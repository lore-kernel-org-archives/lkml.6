Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeBZSFI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:05:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:2401 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751175AbeBZSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:05:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="20343785"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 3/5] x86/boot/compressed/64: Save and restore trampoline memory
Date: Mon, 26 Feb 2018 21:04:49 +0300
Message-Id: <20180226180451.86788-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180226180451.86788-1-kirill.shutemov@linux.intel.com>
References: <20180226180451.86788-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory area we found for trampoline shouldn't contain anything
useful. But let's preserve the data anyway. Just to be on safe side.

paging_prepare() would save the data into a buffer.

cleanup_trampoline() would restore it back once we are done with the
trampoline.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/head_64.S    | 10 ++++++++++
 arch/x86/boot/compressed/pgtable_64.c | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d598d65db32c..8ba0582c65d5 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -355,6 +355,16 @@ ENTRY(startup_64)
 	lretq
 lvl5:
 
+	/*
+	 * cleanup_trampoline() would restore trampoline memory.
+	 *
+	 * RSI holds real mode data and needs to be preserved across
+	 * this function call.
+	 */
+	pushq	%rsi
+	call	cleanup_trampoline
+	popq	%rsi
+
 	/* Zero EFLAGS */
 	pushq	$0
 	popfq
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 21d5cc1cd5fa..01d08d3e3e43 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,5 +1,6 @@
 #include <asm/processor.h>
 #include "pgtable.h"
+#include "../string.h"
 
 /*
  * __force_order is used by special_insns.h asm code to force instruction
@@ -18,6 +19,9 @@ struct paging_config {
 	unsigned long l5_required;
 };
 
+/* Buffer to preserve trampoline memory */
+static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
+
 /*
  * Trampoline address will be printed by extract_kernel() for debugging
  * purposes.
@@ -69,5 +73,14 @@ struct paging_config paging_prepare(void)
 
 	trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
 
+	/* Preserve trampoline memory */
+	memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
+
 	return paging_config;
 }
+
+void cleanup_trampoline(void)
+{
+	/* Restore trampoline memory */
+	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
+}
-- 
2.16.1
