Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE4EC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587812147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfBHJGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:06:25 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:35224 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfBHJGY (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 8 Feb 2019 04:06:24 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 08 Feb 2019 10:06:23 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Fri, 08 Feb 2019 09:06:14 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, anthony.yznaga@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm,memory_hotplug: Explicitly pass the head to isolate_huge_page
Date:   Fri,  8 Feb 2019 10:06:04 +0100
Message-Id: <20190208090604.975-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isolate_huge_page() expects we pass the head of hugetlb page to it:

bool isolate_huge_page(...)
{
	...
	VM_BUG_ON_PAGE(!PageHead(page), page);
	...
}

While I really cannot think of any situation where we end up with a
non-head page between hands in do_migrate_range(), let us make sure
the code is as sane as possible by explicitly passing the Head.
Since we already got the pointer, it does not take us extra effort.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 656ff386ac15..d5f7afda67db 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1378,12 +1378,12 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 		if (PageHuge(page)) {
 			struct page *head = compound_head(page);
-			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
 			if (compound_order(head) > PFN_SECTION_SHIFT) {
 				ret = -EBUSY;
 				break;
 			}
-			isolate_huge_page(page, &source);
+			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
+			isolate_huge_page(head, &source);
 			continue;
 		} else if (PageTransHuge(page))
 			pfn = page_to_pfn(compound_head(page))
-- 
2.13.7

