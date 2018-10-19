Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA6ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E7E214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E7E214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJSUkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:40:07 -0400
Received: from relay.sw.ru ([185.231.240.75]:44234 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeJSUkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:40:07 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gDTyF-0007WP-Hy; Fri, 19 Oct 2018 15:33:39 +0300
Subject: [PATCH v3] ksm: Assist buddy allocator to assemble 1-order pages
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     hughd@google.com, aarcange@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mhocko@suse.com, rppt@linux.vnet.ibm.com,
        imbrenda@linux.vnet.ibm.com, corbet@lwn.net,
        ndesaulniers@google.com, ktkhai@virtuozzo.com,
        dave.jiang@intel.com, jglisse@redhat.com, jia.he@hxt-semitech.com,
        paulmck@linux.vnet.ibm.com, colin.king@canonical.com,
        jiang.biao2@zte.com.cn, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Oct 2018 15:33:39 +0300
Message-ID: <153995241537.4096.15189862239521235797.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: Comment improvements.
v2: Style improvements.

try_to_merge_two_pages() merges two pages, one of them
is a page of currently scanned mm, the second is a page
with identical hash from unstable tree. Currently, we
merge the page from unstable tree into the first one,
and then free it.

The idea of this patch is to prefer freeing that page
of them, which has a free neighbour (i.e., neighbour
with zero page_count()). This allows buddy allocator
to assemble at least 1-order set from the freed page
and its neighbour; this is a kind of cheep passive
compaction.

AFAIK, 1-order pages set consists of pages with PFNs
[2n, 2n+1] (odd, even), so the neighbour's pfn is
calculated via XOR with 1. We check the result pfn
is valid and its page_count(), and prefer merging
into @tree_page if neighbour's usage count is zero.

There a is small difference with current behavior
in case of error path. In case of the second
try_to_merge_with_ksm_page() is failed, we return
from try_to_merge_two_pages() with @tree_page
removed from unstable tree. It does not seem to matter,
but if we do not want a change at all, it's not
a problem to move remove_rmap_item_from_tree() from
try_to_merge_with_ksm_page() to its callers.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/ksm.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 5b0894b45ee5..47c2dfd1cf4f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1321,6 +1321,23 @@ static struct page *try_to_merge_two_pages(struct rmap_item *rmap_item,
 {
 	int err;
 
+	if (IS_ENABLED(CONFIG_COMPACTION)) {
+		unsigned long pfn;
+
+		/*
+		 * Find neighbour of @page containing 1-order pair in buddy
+		 * allocator and check whether its count is 0. If so, we
+		 * consider the neighbour as a free page (this is more
+		 * probable than it's freezed via page_ref_freeze()), and
+		 * we try to use @tree_page as ksm page and to free @page.
+		 */
+		pfn = page_to_pfn(page) ^ 1;
+		if (pfn_valid(pfn) && page_count(pfn_to_page(pfn)) == 0) {
+			swap(rmap_item, tree_rmap_item);
+			swap(page, tree_page);
+		}
+	}
+
 	err = try_to_merge_with_ksm_page(rmap_item, page, NULL);
 	if (!err) {
 		err = try_to_merge_with_ksm_page(tree_rmap_item,

