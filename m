Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61EEECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F732150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F732150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJQSQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:16:29 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44928 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727333AbeJQSQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:16:28 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46265560"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Oct 2018 18:21:23 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 4BD144B6ED70;
        Wed, 17 Oct 2018 18:21:23 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 17 Oct 2018 18:21:28 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <bhe@redhat.com>,
        <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v9 8/8] x86/boot/KASLR: Limit kaslr to choosing the immovable memory
Date:   Wed, 17 Oct 2018 18:20:12 +0800
Message-ID: <20181017102012.872-9-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 4BD144B6ED70.AB905
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
 arch/x86/boot/compressed/kaslr.c | 72 +++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 0c3567bc231c..3ebb150f61eb 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -101,6 +101,11 @@ static bool memmap_too_large;
 /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
 static unsigned long long mem_limit = ULLONG_MAX;
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+/* Store the immovable memory regions */
+extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
+#endif
+
 
 enum mem_avoid_index {
 	MEM_AVOID_ZO_RANGE = 0,
@@ -577,9 +582,9 @@ static unsigned long slots_fetch_random(void)
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
 	unsigned long start_orig, end;
@@ -655,6 +660,57 @@ static void process_mem_region(struct mem_vector *entry,
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
+		if (!mem_overlaps(region, &immovable_mem[i]))
+			continue;
+
+		start = immovable_mem[i].start;
+		end = start + immovable_mem[i].size;
+		region_end = region->start + region->size;
+
+		entry.start = clamp(region->start, start, end);
+		entry_end = clamp(region_end, start, end);
+		entry.size = entry_end - entry.start;
+
+		slots_count(&entry, minimum, image_size);
+
+		if (slot_area_index == MAX_SLOT_AREA) {
+			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
+			return 1;
+		}
+	}
+	return 0;
+#endif
+}
+
 #ifdef CONFIG_EFI
 /*
  * Returns true if mirror region found (and must have been processed
@@ -720,11 +776,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 
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
@@ -751,11 +804,8 @@ static void process_e820_entries(unsigned long minimum,
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
2.17.2



