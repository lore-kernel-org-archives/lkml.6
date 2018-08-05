Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3315AC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12EB217BB
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12EB217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeHENin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:38:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42656 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeHENin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:38:43 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fmHIl-0001DU-PN; Sun, 05 Aug 2018 13:34:23 +0200
Date:   Sun, 5 Aug 2018 13:34:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 fix for 4.18
Message-ID: <alpine.DEB.2.21.1808051331140.17359@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A single fix, which addresses boot failures on machines which do not report
EBDA correctly, which can place the trampoline into reserved memory regions.
Validating against E820 prevents that.

Thanks,

	tglx

------------------>
Kirill A. Shutemov (1):
      x86/boot/compressed/64: Validate trampoline placement against E820


 arch/x86/boot/compressed/pgtable_64.c | 73 ++++++++++++++++++++++++++---------
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
 
