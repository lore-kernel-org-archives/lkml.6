Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7BFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6199620834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6199620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeK2TVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:21:35 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27144 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727490AbeK2TVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:21:35 -0500
X-IronPort-AV: E=Sophos;i="5.56,293,1539619200"; 
   d="scan'208";a="48821863"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Nov 2018 16:17:02 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id C2E6C4B7349C;
        Thu, 29 Nov 2018 16:17:00 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Nov 2018 16:17:06 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v12 5/5] x86/boot/KASLR: Limit KASLR to extracting kernel in immovable memory
Date:   Thu, 29 Nov 2018 16:16:31 +0800
Message-ID: <20181129081631.11139-6-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: C2E6C4B7349C.AA972
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASLR may randomly choose some positions which are located in movable
memory regions. This will break memory hotplug feature and make the
movable memory chosen by KASLR practically immovable.

The solution is to limit KASLR to choose memory regions in immovable
node according to SRAT tables.
If CONFIG_EARLY_PARSE_RSDP is enabled, walk through the SRAT memory
tables and store those immovable memory regions so that KASLR can get
where to choose for randomization.

Also, rename process_mem_region() as __process_mem_region() and name new
function as process_mem_region().

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/kaslr.c | 75 +++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b251572e77af..f0c30e3ddcb4 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -97,6 +97,11 @@ static bool memmap_too_large;
 /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
 static unsigned long long mem_limit = ULLONG_MAX;
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+/* Store the immovable memory regions */
+extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
+#endif
+
 
 enum mem_avoid_index {
 	MEM_AVOID_ZO_RANGE = 0,
@@ -413,6 +418,9 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* Mark the memmap regions we need to avoid */
 	handle_mem_options();
 
+	/* Mark the immovable regions we need to choose */
+	get_immovable_mem();
+
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
 	add_identity_map(0, PMD_SIZE);
@@ -568,9 +576,9 @@ static unsigned long slots_fetch_random(void)
 	return 0;
 }
 
-static void process_mem_region(struct mem_vector *entry,
-			       unsigned long minimum,
-			       unsigned long image_size)
+static void __process_mem_region(struct mem_vector *entry,
+				 unsigned long minimum,
+				 unsigned long image_size)
 {
 	struct mem_vector region, overlap;
 	unsigned long start_orig, end;
@@ -646,6 +654,57 @@ static void process_mem_region(struct mem_vector *entry,
 	}
 }
 
+static bool process_mem_region(struct mem_vector *region,
+			       unsigned long long minimum,
+			       unsigned long long image_size)
+{
+	int i;
+	/*
+	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
+	 * walk all the regions, so use region directly.
+	 */
+	if (!num_immovable_mem) {
+		__process_mem_region(region, minimum, image_size);
+
+		if (slot_area_index == MAX_SLOT_AREA) {
+			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
+			return 1;
+		}
+		return 0;
+	}
+
+#ifdef CONFIG_EARLY_PARSE_RSDP
+	/*
+	 * If immovable memory found, filter the intersection between
+	 * immovable memory and region to __process_mem_region().
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
+		__process_mem_region(&entry, minimum, image_size);
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
@@ -711,11 +770,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 
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
@@ -742,11 +798,8 @@ static void process_e820_entries(unsigned long minimum,
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
2.19.1



