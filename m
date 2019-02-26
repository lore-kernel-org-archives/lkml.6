Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF201C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B310A2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfBZLSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:18:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbfBZLSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:18:49 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9E33340D3053976F4C99;
        Tue, 26 Feb 2019 19:18:46 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Tue, 26 Feb 2019 19:18:41 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <n-horiguchi@ah.jp.nec.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mhocko@suse.com>, <hughd@google.com>, <mhocko@kernel.org>
Subject: [PATCH] mm: hwpoison: fix thp split handing in soft_offline_in_use_page()
Date:   Tue, 26 Feb 2019 19:18:00 +0800
Message-ID: <1551179880-65331-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhongjiang <zhongjiang@huawei.com>

When soft_offline_in_use_page() runs on a thp tail page after pmd is plit,
we trigger the following VM_BUG_ON_PAGE():

Memory failure: 0x3755ff: non anonymous thp
__get_any_page: 0x3755ff: unknown zero refcount page type 2fffff80000000
Soft offlining pfn 0x34d805 at process virtual address 0x20fff000
page:ffffea000d360140 count:0 mapcount:0 mapping:0000000000000000 index:0x1
flags: 0x2fffff80000000()
raw: 002fffff80000000 ffffea000d360108 ffffea000d360188 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
------------[ cut here ]------------
kernel BUG at ./include/linux/mm.h:519!

soft_offline_in_use_page() passed refcount and page lock from tail page to
head page, which is not needed because we can pass any subpage to
split_huge_page().

Cc: <stable@vger.kernel.org>        [4.5+]
Signed-off-by: zhongjiang <zhongjiang@huawei.com>
---
 mm/memory-failure.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d9b8a24..6edc6db 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1823,19 +1823,17 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage)) {
-		lock_page(hpage);
-		if (!PageAnon(hpage) || unlikely(split_huge_page(hpage))) {
-			unlock_page(hpage);
-			if (!PageAnon(hpage))
+		lock_page(page);
+		if (!PageAnon(page) || unlikely(split_huge_page(page))) {
+			unlock_page(page);
+			if (!PageAnon(page))
 				pr_info("soft offline: %#lx: non anonymous thp\n", page_to_pfn(page));
 			else
 				pr_info("soft offline: %#lx: thp split failed\n", page_to_pfn(page));
-			put_hwpoison_page(hpage);
+			put_hwpoison_page(page);
 			return -EBUSY;
 		}
-		unlock_page(hpage);
-		get_hwpoison_page(page);
-		put_hwpoison_page(hpage);
+		unlock_page(page);
 	}
 
 	/*
-- 
1.7.12.4

