Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADC9C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAD720880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAD720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeIJRen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:34:43 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33076 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728482AbeIJRen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:34:43 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="44733321"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Sep 2018 20:40:41 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 1B9AA4B6EC66;
        Mon, 10 Sep 2018 20:40:40 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD01.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.408.0; Mon, 10 Sep 2018
 20:40:43 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <bhe@redhat.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v6 3/3] x86/boot/KASLR: Limit kaslr to choosing the immovable memory
Date:   Mon, 10 Sep 2018 20:40:15 +0800
Message-ID: <20180910124015.18073-4-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910124015.18073-1-fanc.fnst@cn.fujitsu.com>
References: <20180910124015.18073-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 1B9AA4B6EC66.ABB04
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_MEMORY_HOTREMOVE enabled and the amount of immovable
memory regions is not zero. Calculate the intersection between memory
regions from e820/efi memory table and immovable memory regions.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/kaslr.c | 66 ++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 3d839040cc7f..3b0b305c049d 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -583,9 +583,9 @@ static unsigned long slots_fetch_random(void)
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
@@ -662,6 +662,56 @@ static void process_mem_region(struct mem_vector *entry,
 	}
 }
 
+static bool process_mem_region(struct mem_vector *region,
+			       unsigned long long minimum,
+			       unsigned long long image_size)
+{
+	int i;
+	/*
+	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
+	 * walk all the regions, so use region directely.
+	 */
+	if (num_immovable_mem == 0) {
+		slots_count(region, minimum, image_size);
+
+		if (slot_area_index == MAX_SLOT_AREA) {
+			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
+			return 1;
+		}
+		return 0;
+	}
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	/*
+	 * If immovable memory found, filter the intersection between
+	 * immovable memory and region to slots_count.
+	 * Otherwise, go on old code.
+	 */
+	for (i = 0; i < num_immovable_mem; i++) {
+		struct mem_vector entry;
+		unsigned long long start, end, entry_end, region_end;
+
+		start = immovable_mem[i].start;
+		end = start + immovable_mem[i].size;
+		region_end = region->start + region->size;
+
+		entry.start = clamp(region->start, start, end);
+		entry_end = clamp(region_end, start, end);
+
+		if (entry.start + image_size < entry_end) {
+			entry.size = entry_end - entry.start;
+			slots_count(&entry, minimum, image_size);
+
+			if (slot_area_index == MAX_SLOT_AREA) {
+				debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
+				return 1;
+			}
+		}
+	}
+	return 0;
+#endif
+}
+
 #ifdef CONFIG_EFI
 /*
  * Returns true if mirror region found (and must have been processed
@@ -727,11 +777,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 
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
@@ -758,11 +805,8 @@ static void process_e820_entries(unsigned long minimum,
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



