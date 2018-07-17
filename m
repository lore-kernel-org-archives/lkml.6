Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A76ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A8F20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A8F20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeGQKi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:38:59 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38398 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729679AbeGQKit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:38:49 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42327538"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Jul 2018 18:06:55 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 05BA84B5CC0C;
        Tue, 17 Jul 2018 18:06:54 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD02.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.399.0; Tue, 17 Jul 2018
 18:06:52 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        <caoj.fnst@cn.fujitsu.com>, <douly.fnst@cn.fujitsu.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v3 4/4] x86/boot/KASLR: Limit kaslr to choosing the immovable memory
Date:   Tue, 17 Jul 2018 18:04:09 +0800
Message-ID: <20180717100409.10547-5-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717100409.10547-1-fanc.fnst@cn.fujitsu.com>
References: <20180717100409.10547-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 05BA84B5CC0C.AAE37
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'CONFIG_MEMORY_HOTREMOVE' specified and the account of immovable
memory regions is not zero. Calculate the intersection between memory
regions from e820/efi memory table and immovable memory regions.
Or go on the old code.

Rename process_mem_region to slots_count to match slots_fetch_random,
and name new function as process_mem_region.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/kaslr.c | 66 ++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index c3634ef5cc01..d4f7a571092f 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -631,9 +631,9 @@ static unsigned long slots_fetch_random(void)
 	return 0;
 }
 
-static void process_mem_region(struct mem_vector *entry,
-			       unsigned long minimum,
-			       unsigned long image_size)
+static void slots_count(struct mem_vector *entry,
+			unsigned long minimum,
+			unsigned long image_size)
 {
 	struct mem_vector region, overlap;
 	struct slot_area slot_area;
@@ -710,6 +710,56 @@ static void process_mem_region(struct mem_vector *entry,
 	}
 }
 
+static bool process_mem_region(struct mem_vector *region,
+			       unsigned long long minimum,
+			       unsigned long long image_size)
+{
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	/*
+	 * If immovable memory found, filter the intersection between
+	 * immovable memory and region to slots_count.
+	 * Otherwise, go on old code.
+	 */
+	if (num_immovable_mem > 0) {
+		int i;
+
+		for (i = 0; i < num_immovable_mem; i++) {
+			struct mem_vector entry;
+			unsigned long long start, end, entry_end, region_end;
+
+			start = immovable_mem[i].start;
+			end = start + immovable_mem[i].size;
+			region_end = region->start + region->size;
+
+			entry.start = clamp(region->start, start, end);
+			entry_end = clamp(region_end, start, end);
+
+			if (entry.start + image_size < entry_end) {
+				entry.size = entry_end - entry.start;
+				slots_count(&entry, minimum, image_size);
+
+				if (slot_area_index == MAX_SLOT_AREA) {
+					debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
+					return 1;
+				}
+			}
+		}
+		return 0;
+	}
+#endif
+	/*
+	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
+	 * walk all the regions, so use region directely.
+	 */
+	slots_count(region, minimum, image_size);
+
+	if (slot_area_index == MAX_SLOT_AREA) {
+		debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
+		return 1;
+	}
+	return 0;
+}
+
 #ifdef CONFIG_EFI
 /*
  * Returns true if mirror region found (and must have been processed
@@ -775,11 +825,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 
 		region.start = md->phys_addr;
 		region.size = md->num_pages << EFI_PAGE_SHIFT;
-		process_mem_region(&region, minimum, image_size);
-		if (slot_area_index == MAX_SLOT_AREA) {
-			debug_putstr("Aborted EFI scan (slot_areas full)!\n");
+		if (process_mem_region(&region, minimum, image_size))
 			break;
-		}
 	}
 	return true;
 }
@@ -806,11 +853,8 @@ static void process_e820_entries(unsigned long minimum,
 			continue;
 		region.start = entry->addr;
 		region.size = entry->size;
-		process_mem_region(&region, minimum, image_size);
-		if (slot_area_index == MAX_SLOT_AREA) {
-			debug_putstr("Aborted e820 scan (slot_areas full)!\n");
+		if (process_mem_region(&region, minimum, image_size))
 			break;
-		}
 	}
 }
 
-- 
2.17.1



