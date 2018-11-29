Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F6EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC7E2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC7E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeK3JCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:02:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24937 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbeK3JCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:02:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A5EC4E928;
        Thu, 29 Nov 2018 21:55:23 +0000 (UTC)
Received: from dustball.brq.redhat.com (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BD1E601B9;
        Thu, 29 Nov 2018 21:55:17 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     linux-mm@kvack.org, lersek@redhat.com, alex.williamson@redhat.com,
        aarcange@redhat.com, rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, mhocko@suse.com, jstancek@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm: page_mapped: don't assume compound page is huge or THP
Date:   Thu, 29 Nov 2018 22:53:48 +0100
Message-Id: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 29 Nov 2018 21:55:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP proc01 testcase has been observed to rarely trigger crashes
on arm64:
    page_mapped+0x78/0xb4
    stable_page_flags+0x27c/0x338
    kpageflags_read+0xfc/0x164
    proc_reg_read+0x7c/0xb8
    __vfs_read+0x58/0x178
    vfs_read+0x90/0x14c
    SyS_read+0x60/0xc0

Issue is that page_mapped() assumes that if compound page is not
huge, then it must be THP. But if this is 'normal' compound page
(COMPOUND_PAGE_DTOR), then following loop can keep running until
it tries to read from memory that isn't mapped and triggers a panic:
        for (i = 0; i < hpage_nr_pages(page); i++) {
                if (atomic_read(&page[i]._mapcount) >= 0)
                        return true;
	}

I could replicate this on x86 (v4.20-rc4-98-g60b548237fed) only
with a custom kernel module [1] which:
- allocates compound page (PAGEC) of order 1
- allocates 2 normal pages (COPY), which are initialized to 0xff
  (to satisfy _mapcount >= 0)
- 2 PAGEC page structs are copied to address of first COPY page
- second page of COPY is marked as not present
- call to page_mapped(COPY) now triggers fault on access to 2nd COPY
  page at offset 0x30 (_mapcount)

[1] https://github.com/jstancek/reproducers/blob/master/kernel/page_mapped_crash/repro.c

This patch modifies page_mapped() to check for 'normal'
compound pages (COMPOUND_PAGE_DTOR).

Debugged-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/linux/mm.h | 9 +++++++++
 mm/util.c          | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de93a363..18b0bb953f92 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -700,6 +700,15 @@ static inline compound_page_dtor *get_compound_page_dtor(struct page *page)
 	return compound_page_dtors[page[1].compound_dtor];
 }
 
+static inline int PageNormalCompound(struct page *page)
+{
+	if (!PageCompound(page))
+		return 0;
+
+	page = compound_head(page);
+	return page[1].compound_dtor == COMPOUND_PAGE_DTOR;
+}
+
 static inline unsigned int compound_order(struct page *page)
 {
 	if (!PageHead(page))
diff --git a/mm/util.c b/mm/util.c
index 8bf08b5b5760..06c1640cb7b3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -478,6 +478,8 @@ bool page_mapped(struct page *page)
 		return true;
 	if (PageHuge(page))
 		return false;
+	if (PageNormalCompound(page))
+		return false;
 	for (i = 0; i < hpage_nr_pages(page); i++) {
 		if (atomic_read(&page[i]._mapcount) >= 0)
 			return true;
-- 
1.8.3.1

