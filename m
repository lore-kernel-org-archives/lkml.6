Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeB1Kwf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:52:35 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54770 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752312AbeB1Kvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:51:40 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37332007"
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC: <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v9 2/5] x86/KASLR: Handle the memory regions specified in kaslr_boot_mem
Date: Wed, 28 Feb 2018 18:51:02 +0800
Message-ID: <20180228105105.11487-3-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 628734D0EFD9.AC786
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no 'kaslr_boot_mem=' specified, just handle the e820/efi entries
directly as before. Otherwise, limit kernel to memory regions
specified in 'kaslr_boot_mem=' commandline.

Rename process_mem_region to slots_count to match
slots_fetch_random, and name new function as process_mem_region.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Tested-by: Luiz Capitulino <lcapitulino@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/boot/compressed/kaslr.c | 64 +++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e33e5cbf7244..eb47502fbe54 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -554,9 +554,9 @@ static unsigned long slots_fetch_random(void)
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
@@ -633,6 +633,52 @@ static void process_mem_region(struct mem_vector *entry,
 	}
 }
 
+static bool process_mem_region(struct mem_vector region,
+			       unsigned long long minimum,
+			       unsigned long long image_size)
+{
+	/*
+	 * If 'kaslr_boot_mem=' specified, walk all the regions, and
+	 * filter the intersection to slots_count.
+	 */
+	if (num_usable_region > 0) {
+		int i;
+
+		for (i = 0; i < num_usable_region; i++) {
+			struct mem_vector entry;
+			unsigned long long start, end, entry_end, region_end;
+
+			start = mem_usable[i].start;
+			end = start + mem_usable[i].size;
+			region_end = region.start + region.size;
+
+			entry.start = clamp(region.start, start, end);
+			entry_end = clamp(region_end, start, end);
+
+			if (entry.start < entry_end) {
+				entry.size = entry_end - entry.start;
+				slots_count(&entry, minimum, image_size);
+			}
+
+			if (slot_area_index == MAX_SLOT_AREA) {
+				debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
+				return 1;
+			}
+		}
+		return 0;
+	}
+
+	/*
+	 * If no kaslr_boot_mem stored, use region directly
+	 */
+	slots_count(&region, minimum, image_size);
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
@@ -698,11 +744,9 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 
 		region.start = md->phys_addr;
 		region.size = md->num_pages << EFI_PAGE_SHIFT;
-		process_mem_region(&region, minimum, image_size);
-		if (slot_area_index == MAX_SLOT_AREA) {
-			debug_putstr("Aborted EFI scan (slot_areas full)!\n");
+
+		if (process_mem_region(region, minimum, image_size))
 			break;
-		}
 	}
 	return true;
 }
@@ -729,11 +773,9 @@ static void process_e820_entries(unsigned long minimum,
 			continue;
 		region.start = entry->addr;
 		region.size = entry->size;
-		process_mem_region(&region, minimum, image_size);
-		if (slot_area_index == MAX_SLOT_AREA) {
-			debug_putstr("Aborted e820 scan (slot_areas full)!\n");
+
+		if (process_mem_region(region, minimum, image_size))
 			break;
-		}
 	}
 }
 
-- 
2.14.3
