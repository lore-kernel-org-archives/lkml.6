Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E06C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2510D214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2510D214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbeHBOP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:15:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37483 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbeHBOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:15:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72COqle3498686
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 05:24:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72COqYC3498683;
        Thu, 2 Aug 2018 05:24:52 -0700
Date:   Thu, 2 Aug 2018 05:24:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-1b3a62643660020cdc68e6139a010c06e8fc96c7@git.kernel.org>
Cc:     kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, youling257@gmail.com,
        linux-kernel@vger.kernel.org, d.malkin@real-time-systems.com,
        hpa@zytor.com
Reply-To: youling257@gmail.com, tglx@linutronix.de, mingo@kernel.org,
          kirill.shutemov@linux.intel.com, d.malkin@real-time-systems.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180801133225.38121-1-kirill.shutemov@linux.intel.com>
References: <20180801133225.38121-1-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/compressed/64: Validate trampoline
 placement against E820
Git-Commit-ID: 1b3a62643660020cdc68e6139a010c06e8fc96c7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1b3a62643660020cdc68e6139a010c06e8fc96c7
Gitweb:     https://git.kernel.org/tip/1b3a62643660020cdc68e6139a010c06e8fc96c7
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 1 Aug 2018 16:32:25 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 14:22:22 +0200

x86/boot/compressed/64: Validate trampoline placement against E820

There were two report of boot failure cased by trampoline placed into
a reserved memory region. It can happen on machines that don't report
EBDA correctly.

Fix the problem by re-validating the found address against the E820 table.
If the address is in a reserved area, find the next usable region below the
initial address.

Fixes: 3548e131ec6a ("x86/boot/compressed/64: Find a place for 32-bit trampoline")
Reported-by: Dmitry Malkin <d.malkin@real-time-systems.com>
Reported-by: youling 257 <youling257@gmail.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180801133225.38121-1-kirill.shutemov@linux.intel.com

---
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
 
