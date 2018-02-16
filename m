Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935158AbeBPLG0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:06:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50439 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934998AbeBPLGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:06:24 -0500
Date: Fri, 16 Feb 2018 02:55:57 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-6657fca06e3ffab8d0b3f9d8b397f5ee498952d7@git.kernel.org>
Cc: jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, arjan@linux.intel.com, hpa@zytor.com, bp@suse.de,
        torvalds@linux-foundation.org, luto@kernel.org, dwmw2@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, dan.j.williams@intel.com
Reply-To: dan.j.williams@intel.com, luto@kernel.org, dwmw2@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, arjan@linux.intel.com,
        peterz@infradead.org, bp@suse.de, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com
In-Reply-To: <20180214182542.69302-10-kirill.shutemov@linux.intel.com>
References: <20180214182542.69302-10-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Allow to boot without LA57 if
 CONFIG_X86_5LEVEL=y
Git-Commit-ID: 6657fca06e3ffab8d0b3f9d8b397f5ee498952d7
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

Commit-ID:  6657fca06e3ffab8d0b3f9d8b397f5ee498952d7
Gitweb:     https://git.kernel.org/tip/6657fca06e3ffab8d0b3f9d8b397f5ee498952d7
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 21:25:42 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:48:49 +0100

x86/mm: Allow to boot without LA57 if CONFIG_X86_5LEVEL=y

All pieces of the puzzle are in place and we can now allow to boot with
CONFIG_X86_5LEVEL=y on a machine without LA57 support.

Kernel will detect that LA57 is missing and fold p4d at runtime.

Update the documentation and the Kconfig option description to reflect the
change.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214182542.69302-10-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/x86_64/5level-paging.txt |  9 +++------
 arch/x86/Kconfig                           |  4 ++--
 arch/x86/boot/compressed/misc.c            | 16 ----------------
 arch/x86/include/asm/required-features.h   |  8 +-------
 4 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/Documentation/x86/x86_64/5level-paging.txt b/Documentation/x86/x86_64/5level-paging.txt
index 087251a..2432a5e 100644
--- a/Documentation/x86/x86_64/5level-paging.txt
+++ b/Documentation/x86/x86_64/5level-paging.txt
@@ -20,12 +20,9 @@ Documentation/x86/x86_64/mm.txt
 
 CONFIG_X86_5LEVEL=y enables the feature.
 
-So far, a kernel compiled with the option enabled will be able to boot
-only on machines that supports the feature -- see for 'la57' flag in
-/proc/cpuinfo.
-
-The plan is to implement boot-time switching between 4- and 5-level paging
-in the future.
+Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
+In this case additional page table level -- p4d -- will be folded at
+runtime.
 
 == User-space and large virtual address space ==
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fcc3f88..1c4f7b6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1440,8 +1440,8 @@ config X86_5LEVEL
 
 	  It will be supported by future Intel CPUs.
 
-	  Note: a kernel with this option enabled can only be booted
-	  on machines that support the feature.
+	  A kernel with the option enabled can be booted on machines that
+	  support 4- or 5-level paging.
 
 	  See Documentation/x86/x86_64/5level-paging.txt for more
 	  information.
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 98761a1..b50c424 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -169,16 +169,6 @@ void __puthex(unsigned long value)
 	}
 }
 
-static bool l5_supported(void)
-{
-	/* Check if leaf 7 is supported. */
-	if (native_cpuid_eax(0) < 7)
-		return 0;
-
-	/* Check if la57 is supported. */
-	return native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31));
-}
-
 #if CONFIG_X86_NEED_RELOCS
 static void handle_relocations(void *output, unsigned long output_len,
 			       unsigned long virt_addr)
@@ -372,12 +362,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	console_init();
 	debug_putstr("early console in extract_kernel\n");
 
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) && !l5_supported()) {
-		error("This linux kernel as configured requires 5-level paging\n"
-			"This CPU does not support the required 'cr4.la57' feature\n"
-			"Unable to boot - please use a kernel appropriate for your CPU\n");
-	}
-
 	free_mem_ptr     = heap;	/* Heap */
 	free_mem_end_ptr = heap + BOOT_HEAP_SIZE;
 
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index fb3a6de..6847d85 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -53,12 +53,6 @@
 # define NEED_MOVBE	0
 #endif
 
-#ifdef CONFIG_X86_5LEVEL
-# define NEED_LA57	(1<<(X86_FEATURE_LA57 & 31))
-#else
-# define NEED_LA57	0
-#endif
-
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT
 /* Paravirtualized systems may not have PSE or PGE available */
@@ -104,7 +98,7 @@
 #define REQUIRED_MASK13	0
 #define REQUIRED_MASK14	0
 #define REQUIRED_MASK15	0
-#define REQUIRED_MASK16	(NEED_LA57)
+#define REQUIRED_MASK16	0
 #define REQUIRED_MASK17	0
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
