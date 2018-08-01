Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1796CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0DD20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0DD20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbeHAPSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:18:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:42817 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389329AbeHAPSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:18:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 06:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="58865025"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2018 06:32:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3CFBEF7; Wed,  1 Aug 2018 16:32:31 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Malkin <d.malkin@real-time-systems.com>,
        youling 257 <youling257@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/boot/compressed/64: Validate trampoline placement against e820
Date:   Wed,  1 Aug 2018 16:32:25 +0300
Message-Id: <20180801133225.38121-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were two report of boot failure cased by trampoline placed into
a reserved memory region. It can happen on machines that don't report
EBDA correctly.

Fix the problem by re-validating the found address against e820 table.
If the address is in a reserved area, find the next usable region below
the initial address.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Dmitry Malkin <d.malkin@real-time-systems.com>
Reported-by: youling 257 <youling257@gmail.com>
Fixes: 3548e131ec6a ("x86/boot/compressed/64: Find a place for 32-bit trampoline")
---
 arch/x86/boot/compressed/pgtable_64.c | 73 ++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 8c5107545251..9e2157371491 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,3 +1,4 @@
+#include <asm/e820/types.h>
 #include <asm/processor.h>
 #include "pgtable.h"
 #include "../string.h"
@@ -34,10 +35,62 @@ unsigned long *trampoline_32bit __section(.data);
 extern struct boot_params *boot_params;
 int cmdline_find_option_bool(const char *option);
 
+static unsigned long find_trampoline_placement(void)
+{
+	unsigned long bios_start, ebda_start;
+	unsigned long trampoline_start;
+	struct boot_e820_entry *entry;
+	int i;
+
+	/*
+	 * Find a suitable spot for the trampoline.
+	 * This code is based on reserve_bios_regions().
+	 */
+
+	ebda_start = *(unsigned short *)0x40e << 4;
+	bios_start = *(unsigned short *)0x413 << 10;
+
+	if (bios_start < BIOS_START_MIN || bios_start > BIOS_START_MAX)
+		bios_start = BIOS_START_MAX;
+
+	if (ebda_start > BIOS_START_MIN && ebda_start < bios_start)
+		bios_start = ebda_start;
+
+	bios_start = round_down(bios_start, PAGE_SIZE);
+
+	/* Find the first usable memory region under bios_start. */
+	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
+		entry = &boot_params->e820_table[i];
+
+		/* Skip all entries above bios_start. */
+		if (bios_start <= entry->addr)
+			continue;
+
+		/* Skip non-RAM entries. */
+		if (entry->type != E820_TYPE_RAM)
+			continue;
+
+		/* Adjust bios_start to the end of the entry if needed. */
+		if (bios_start > entry->addr + entry->size)
+			bios_start = entry->addr + entry->size;
+
+		/* Keep bios_start page-aligned. */
+		bios_start = round_down(bios_start, PAGE_SIZE);
+
+		/* Skip the entry if it's too small. */
+		if (bios_start - TRAMPOLINE_32BIT_SIZE < entry->addr)
+			continue;
+
+		break;
+	}
+
+	/* Place the trampoline just below the end of low memory */
+	return bios_start - TRAMPOLINE_32BIT_SIZE;
+}
+
 struct paging_config paging_prepare(void *rmode)
 {
 	struct paging_config paging_config = {};
-	unsigned long bios_start, ebda_start;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
 	boot_params = rmode;
@@ -61,23 +114,7 @@ struct paging_config paging_prepare(void *rmode)
 		paging_config.l5_required = 1;
 	}
 
-	/*
-	 * Find a suitable spot for the trampoline.
-	 * This code is based on reserve_bios_regions().
-	 */
-
-	ebda_start = *(unsigned short *)0x40e << 4;
-	bios_start = *(unsigned short *)0x413 << 10;
-
-	if (bios_start < BIOS_START_MIN || bios_start > BIOS_START_MAX)
-		bios_start = BIOS_START_MAX;
-
-	if (ebda_start > BIOS_START_MIN && ebda_start < bios_start)
-		bios_start = ebda_start;
-
-	/* Place the trampoline just below the end of low memory, aligned to 4k */
-	paging_config.trampoline_start = bios_start - TRAMPOLINE_32BIT_SIZE;
-	paging_config.trampoline_start = round_down(paging_config.trampoline_start, PAGE_SIZE);
+	paging_config.trampoline_start = find_trampoline_placement();
 
 	trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
 
-- 
2.18.0

