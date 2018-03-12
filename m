Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbeCLJ3f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:29:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57317 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932277AbeCLJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:29:33 -0400
Date: Mon, 12 Mar 2018 02:29:03 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-fb5268354d20b82c12569e325b0d051c09f983f7@git.kernel.org>
Cc: gorcunov@openvz.org, keescook@chromium.org, mingo@kernel.org,
        willy@infradead.org, andy.shevchenko@gmail.com, luto@amacapital.net,
        kirill.shutemov@linux.intel.com, ebiederm@xmission.com,
        peterz@infradead.org, jgross@suse.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, bp@suse.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: gorcunov@openvz.org, keescook@chromium.org,
        andy.shevchenko@gmail.com, willy@infradead.org, mingo@kernel.org,
        jgross@suse.com, torvalds@linux-foundation.org, peterz@infradead.org,
        ebiederm@xmission.com, kirill.shutemov@linux.intel.com,
        luto@amacapital.net, linux-kernel@vger.kernel.org, hpa@zytor.com,
        bp@suse.de, tglx@linutronix.de
In-Reply-To: <20180226180451.86788-4-kirill.shutemov@linux.intel.com>
References: <20180226180451.86788-4-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot/compressed/64: Save and restore trampoline
 memory
Git-Commit-ID: fb5268354d20b82c12569e325b0d051c09f983f7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fb5268354d20b82c12569e325b0d051c09f983f7
Gitweb:     https://git.kernel.org/tip/fb5268354d20b82c12569e325b0d051c09f983f7
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 26 Feb 2018 21:04:49 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 09:37:25 +0100

x86/boot/compressed/64: Save and restore trampoline memory

The memory area we found for trampoline shouldn't contain anything
useful. But let's preserve the data anyway. Just to be on safe side.

paging_prepare() would save the data into a buffer.

cleanup_trampoline() would restore it back once we are done with the
trampoline.

Tested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180226180451.86788-4-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
