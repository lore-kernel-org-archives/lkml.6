Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1DEC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062232088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062232088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeILObA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:31:00 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:51322 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727183AbeILObA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:31:00 -0400
X-IronPort-AV: E=Sophos;i="5.53,364,1531765800"; 
   d="scan'208";a="164674"
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Sep 2018 14:57:17 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9013"; a="1111909"
Received: from blr-ubuntu-104.ap.qualcomm.com (HELO blr-ubuntu-104.qualcomm.com) ([10.79.40.64])
  by ironmsg02-blr.qualcomm.com with ESMTP; 12 Sep 2018 14:57:16 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id F037829BF; Wed, 12 Sep 2018 14:57:15 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        iamjoonsoo.kim@lge.com, osalvador@suse.de, arunks@codeaurora.org,
        malat@debian.org, gregkh@linuxfoundation.org,
        yasu.isimatu@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     arunks.linux@gmail.com, vinmenon@codeaurora.org
Subject: [RFC] memory_hotplug: Free pages as pageblock_order
Date:   Wed, 12 Sep 2018 14:56:45 +0530
Message-Id: <1536744405-16752-1-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When free pages are done with pageblock_order, time spend on
coalescing pages by buddy allocator can be reduced. With
section size of 256MB, hot add latency of a single section
shows improvement from 50-60 ms to less than 1 ms, hence
improving the hot add latency by 60%.

If this looks okey, I'll modify users of set_online_page_callback
and resend clean patch.

Signed-off-by: Arun KS <arunks@codeaurora.org>
---
 include/linux/memory_hotplug.h |  1 +
 mm/memory_hotplug.c            | 52 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 34a2822..447047d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -88,6 +88,7 @@ extern int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
 extern void __offline_isolated_pages(unsigned long, unsigned long);
 
 typedef void (*online_page_callback_t)(struct page *page);
+typedef int (*online_pages_callback_t)(struct page *page, unsigned int order);
 
 extern int set_online_page_callback(online_page_callback_t callback);
 extern int restore_online_page_callback(online_page_callback_t callback);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 38d94b7..853104d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -662,19 +662,57 @@ static void generic_online_page(struct page *page)
 	__online_page_free(page);
 }
 
+static int generic_online_pages(struct page *page, unsigned int order);
+static online_pages_callback_t online_pages_callback = generic_online_pages;
+
+static int generic_online_pages(struct page *page, unsigned int order)
+{
+	unsigned long nr_pages = 1 << order;
+	struct page *p = page;
+	unsigned int loop;
+
+	for (loop = 0 ; loop < nr_pages ; loop++, p++) {
+		__ClearPageReserved(p);
+		set_page_count(p, 0);
+	}
+	adjust_managed_page_count(page, nr_pages);
+	init_page_count(page);
+	__free_pages(page, order);
+
+	return 0;
+}
+
+static int online_pages_blocks(unsigned long start_pfn, unsigned long nr_pages)
+{
+	unsigned long pages_per_block = (1 << pageblock_order);
+	unsigned long nr_pageblocks = nr_pages / pages_per_block;
+//	unsigned long rem_pages = nr_pages % pages_per_block;
+	int i, ret, onlined_pages = 0;
+	struct page *page;
+
+	for (i = 0 ; i < nr_pageblocks ; i++) {
+		page = pfn_to_page(start_pfn + (i * pages_per_block));
+		ret = (*online_pages_callback)(page, pageblock_order);
+		if (!ret)
+			onlined_pages += pages_per_block;
+		else if (ret > 0)
+			onlined_pages += ret;
+	}
+/*
+	if (rem_pages)
+		onlined_pages += online_page_single(start_pfn + i, rem_pages);
+*/
+
+	return onlined_pages;
+}
+
 static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
 			void *arg)
 {
-	unsigned long i;
 	unsigned long onlined_pages = *(unsigned long *)arg;
-	struct page *page;
 
 	if (PageReserved(pfn_to_page(start_pfn)))
-		for (i = 0; i < nr_pages; i++) {
-			page = pfn_to_page(start_pfn + i);
-			(*online_page_callback)(page);
-			onlined_pages++;
-		}
+		onlined_pages = online_pages_blocks(start_pfn, nr_pages);
 
 	online_mem_sections(start_pfn, start_pfn + nr_pages);
 
-- 
1.9.1

