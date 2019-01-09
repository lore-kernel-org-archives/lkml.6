Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F41AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3743520665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfAIMUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:20:52 -0500
Received: from relay.sw.ru ([185.231.240.75]:42310 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729911AbfAIMUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:20:37 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ghCqU-0004h4-FM; Wed, 09 Jan 2019 15:20:30 +0300
Subject: [PATCH 2/3] mm: Recharge page memcg on first get from pagecache
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        josef@toxicpanda.com, jack@suse.cz, hughd@google.com,
        ktkhai@virtuozzo.com, darrick.wong@oracle.com, mhocko@suse.com,
        aryabinin@virtuozzo.com, guro@fb.com, mgorman@techsingularity.net,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Jan 2019 15:20:30 +0300
Message-ID: <154703642996.32690.7131436841852687919.stgit@localhost.localdomain>
In-Reply-To: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes pagecache_get_page() to charge uncharged
page into memcg of process, which accesses the page first.
Page will be returned in case of it's charged only, so
memcg tasks can't use pages, which was left by __remove_mapping(),
without accounting them. In case of accounting is not possible,
pages remain in pagecache, and further global reclaim will
remove them (and this will be easily, since pages are not
mapped by any task).

Also, note that uncharged page can't be dirty or under
writeback, since it was able to be isolated in __remove_mapping()
earlier.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/filemap.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 65c85c47bdb1..2603c44fc74a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1576,15 +1576,18 @@ EXPORT_SYMBOL(find_lock_entry);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 	int fgp_flags, gfp_t gfp_mask)
 {
+	struct mem_cgroup *memcg;
 	struct page *page;
+	bool drop_lock;
 
 repeat:
+	drop_lock = false;
 	page = find_get_entry(mapping, offset);
 	if (xa_is_value(page))
 		page = NULL;
 	if (!page)
 		goto no_page;
-
+lock:
 	if (fgp_flags & FGP_LOCK) {
 		if (fgp_flags & FGP_NOWAIT) {
 			if (!trylock_page(page)) {
@@ -1604,6 +1607,31 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 		VM_BUG_ON_PAGE(page->index != offset, page);
 	}
 
+	if (!mem_cgroup_disabled() && !PageHuge(page) &&
+	    !page_memcg(page) && !page_mapped(page) &&
+	    test_bit(AS_KEEP_MEMCG_RECLAIM, &mapping->flags)) {
+		if (!(fgp_flags & FGP_LOCK)) {
+			drop_lock = true;
+			fgp_flags |= FGP_LOCK;
+			goto lock;
+		}
+
+		if (!WARN_ON(PageDirty(page) || PageWriteback(page))) {
+			if (mem_cgroup_try_charge(page, current->mm,
+					gfp_mask, &memcg, false)) {
+				unlock_page(page);
+				put_page(page);
+				return NULL;
+			}
+			mem_cgroup_commit_charge(page, memcg, true, false);
+			if (!isolate_lru_page(page))
+				putback_lru_page(page);
+		}
+	}
+
+	if (drop_lock)
+		unlock_page(page);
+
 	if (fgp_flags & FGP_ACCESSED)
 		mark_page_accessed(page);
 

