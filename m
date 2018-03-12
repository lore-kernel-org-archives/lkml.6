Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeCLJ3H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:29:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56285 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeCLJ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:29:05 -0400
Date: Mon, 12 Mar 2018 02:28:34 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-3548e131ec6a82208f36e68d31947b0fe244c7a7@git.kernel.org>
Cc: luto@amacapital.net, ebiederm@xmission.com, bp@suse.de,
        gorcunov@openvz.org, willy@infradead.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, andy.shevchenko@gmail.com, keescook@chromium.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, jgross@suse.com,
        hpa@zytor.com
Reply-To: willy@infradead.org, gorcunov@openvz.org, bp@suse.de,
        luto@amacapital.net, ebiederm@xmission.com, jgross@suse.com,
        hpa@zytor.com, kirill.shutemov@linux.intel.com,
        andy.shevchenko@gmail.com, torvalds@linux-foundation.org,
        mingo@kernel.org, keescook@chromium.org, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180226180451.86788-3-kirill.shutemov@linux.intel.com>
References: <20180226180451.86788-3-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot/compressed/64: Find a place for 32-bit
 trampoline
Git-Commit-ID: 3548e131ec6a82208f36e68d31947b0fe244c7a7
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

Commit-ID:  3548e131ec6a82208f36e68d31947b0fe244c7a7
Gitweb:     https://git.kernel.org/tip/3548e131ec6a82208f36e68d31947b0fe244c7a7
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 26 Feb 2018 21:04:48 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 09:37:23 +0100

x86/boot/compressed/64: Find a place for 32-bit trampoline

If a bootloader enables 64-bit mode with 4-level paging, we might need to
switch over to 5-level paging. The switching requires the disabling of
paging, which works fine if kernel itself is loaded below 4G.

But if the bootloader puts the kernel above 4G (not sure if anybody does
this), we would lose control as soon as paging is disabled, because the
code becomes unreachable to the CPU.

To handle the situation, we need a trampoline in lower memory that would
take care of switching on 5-level paging.

This patch finds a spot in low memory for a trampoline.

The heuristic is based on code in reserve_bios_regions().

We find the end of low memory based on BIOS and EBDA start addresses.
The trampoline is put just before end of low memory. It's mimic approach
taken to allocate memory for realtime trampoline.

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
Link: http://lkml.kernel.org/r/20180226180451.86788-3-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/misc.c       |  6 ++++++
 arch/x86/boot/compressed/pgtable.h    | 11 +++++++++++
 arch/x86/boot/compressed/pgtable_64.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b50c42455e25..8e4b55dd5df9 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -14,6 +14,7 @@
 
 #include "misc.h"
 #include "error.h"
+#include "pgtable.h"
 #include "../string.h"
 #include "../voffset.h"
 
@@ -372,6 +373,11 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	debug_putaddr(output_len);
 	debug_putaddr(kernel_total_size);
 
+#ifdef CONFIG_X86_64
+	/* Report address of 32-bit trampoline */
+	debug_putaddr(trampoline_32bit);
+#endif
+
 	/*
 	 * The memory hole needed for the kernel is the larger of either
 	 * the entire decompressed kernel plus relocation table, or the
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
new file mode 100644
index 000000000000..57722a2fe2a0
--- /dev/null
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -0,0 +1,11 @@
+#ifndef BOOT_COMPRESSED_PAGETABLE_H
+#define BOOT_COMPRESSED_PAGETABLE_H
+
+#define TRAMPOLINE_32BIT_SIZE		(2 * PAGE_SIZE)
+
+#ifndef __ASSEMBLER__
+
+extern unsigned long *trampoline_32bit;
+
+#endif /* __ASSEMBLER__ */
+#endif /* BOOT_COMPRESSED_PAGETABLE_H */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 45c76eff2718..21d5cc1cd5fa 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,4 +1,5 @@
 #include <asm/processor.h>
+#include "pgtable.h"
 
 /*
  * __force_order is used by special_insns.h asm code to force instruction
@@ -9,14 +10,27 @@
  */
 unsigned long __force_order;
 
+#define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
+#define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
+
 struct paging_config {
 	unsigned long trampoline_start;
 	unsigned long l5_required;
 };
 
+/*
+ * Trampoline address will be printed by extract_kernel() for debugging
+ * purposes.
+ *
+ * Avoid putting the pointer into .bss as it will be cleared between
+ * paging_prepare() and extract_kernel().
+ */
+unsigned long *trampoline_32bit __section(.data);
+
 struct paging_config paging_prepare(void)
 {
 	struct paging_config paging_config = {};
+	unsigned long bios_start, ebda_start;
 
 	/*
 	 * Check if LA57 is desired and supported.
@@ -35,5 +49,25 @@ struct paging_config paging_prepare(void)
 		paging_config.l5_required = 1;
 	}
 
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
+	/* Place the trampoline just below the end of low memory, aligned to 4k */
+	paging_config.trampoline_start = bios_start - TRAMPOLINE_32BIT_SIZE;
+	paging_config.trampoline_start = round_down(paging_config.trampoline_start, PAGE_SIZE);
+
+	trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
+
 	return paging_config;
 }
