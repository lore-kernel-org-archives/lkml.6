Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754254AbeDBJuj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:50:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36087 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754124AbeDBJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:50:37 -0400
X-Google-Smtp-Source: AIpwx4/X1+apoCo7syouvp4izg0T29oVbbsuRiO1AGGxnFASvtGYM+m/OIrb9CxK1UcAN4z2R1k9tA==
Date: Mon, 2 Apr 2018 11:50:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-build-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

   # HEAD: d6289f36aa7d5893d091a7a0c67eee7798719f03 x86/build: Don't pass in -D__KERNEL__ multiple times

The biggest change is the forcing of asm-goto support on x86, which effectively 
increases the GCC minimum supported version to gcc-4.5 (on x86).

There's also some Makefile and linker script cleanups.


  out-of-topic modifications in x86-build-for-linus:
  ----------------------------------------------------
  Makefile                           # e501ce957a78: x86: Force asm-goto

 Thanks,

	Ingo

------------------>
Cao jin (2):
      x86/build: Drop superfluous ALIGN from the linker script
      x86/build: Don't pass in -D__KERNEL__ multiple times

Peter Zijlstra (2):
      x86: Force asm-goto
      x86: Remove FAST_FEATURE_TESTS


 Makefile                          | 13 +++++++------
 arch/x86/Kconfig                  | 11 -----------
 arch/x86/Makefile                 |  7 +++++--
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/include/asm/cpufeature.h |  8 --------
 arch/x86/kernel/vmlinux.lds.S     |  7 +++----
 6 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/Makefile b/Makefile
index d65e2e229017..6fb6fd28a124 100644
--- a/Makefile
+++ b/Makefile
@@ -494,6 +494,13 @@ RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
 RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
 export RETPOLINE_CFLAGS
 
+# check for 'asm goto'
+ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
+  CC_HAVE_ASM_GOTO := 1
+  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
+  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
+endif
+
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
@@ -658,12 +665,6 @@ KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
 
-# check for 'asm goto'
-ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
-	KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
-	KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
-endif
-
 include scripts/Makefile.kcov
 include scripts/Makefile.gcc-plugins
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0fa71a78ec99..cb5b5907dbd6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -393,17 +393,6 @@ config X86_FEATURE_NAMES
 
 	  If in doubt, say Y.
 
-config X86_FAST_FEATURE_TESTS
-	bool "Fast CPU feature tests" if EMBEDDED
-	default y
-	---help---
-	  Some fast-paths in the kernel depend on the capabilities of the CPU.
-	  Say Y here for the kernel to patch in the appropriate code at runtime
-	  based on the capabilities of the CPU. The infrastructure for patching
-	  code at runtime takes up some additional space; space-constrained
-	  embedded systems may wish to say N here to produce smaller, slightly
-	  slower code.
-
 config X86_X2APIC
 	bool "Support x2apic"
 	depends on X86_LOCAL_APIC && X86_64 && (IRQ_REMAP || HYPERVISOR_GUEST)
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 498c1b812300..a517852dad55 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -31,8 +31,7 @@ endif
 CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
 M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
 
-REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -D__KERNEL__ \
-		   -DDISABLE_BRANCH_PROFILING \
+REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse
@@ -181,6 +180,10 @@ ifdef CONFIG_FUNCTION_GRAPH_TRACER
   endif
 endif
 
+ifndef CC_HAVE_ASM_GOTO
+  $(error Compiler lacks asm-goto support.)
+endif
+
 #
 # Jump labels need '-maccumulate-outgoing-args' for gcc < 4.5.2 to prevent a
 # GCC bug (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=46226).  There's no way
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f25e1530e064..f484ae0ece93 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -26,7 +26,7 @@ KCOV_INSTRUMENT		:= n
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
 
-KBUILD_CFLAGS := -m$(BITS) -D__KERNEL__ -O2
+KBUILD_CFLAGS := -m$(BITS) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 736771c9822e..b27da9602a6d 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,7 +140,6 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
-#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_X86_FAST_FEATURE_TESTS)
 /*
  * Static testing of CPU features.  Used the same as boot_cpu_has().
  * These will statically patch the target code for additional
@@ -196,13 +195,6 @@ static __always_inline __pure bool _static_cpu_has(u16 bit)
 		boot_cpu_has(bit) :				\
 		_static_cpu_has(bit)				\
 )
-#else
-/*
- * Fall back to dynamic for gcc versions which don't support asm goto. Should be
- * a minority now anyway.
- */
-#define static_cpu_has(bit)		boot_cpu_has(bit)
-#endif
 
 #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
 #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index b854ebf5851b..795f3a80e576 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -102,7 +102,6 @@ SECTIONS
 		_stext = .;
 		/* bootstrapping code */
 		HEAD_TEXT
-		. = ALIGN(8);
 		TEXT_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
@@ -200,7 +199,7 @@ SECTIONS
 		. = __vvar_beginning_hack + PAGE_SIZE;
 	} :data
 
-       . = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
+	. = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
 
 	/* Init code and data - will be freed after init */
 	. = ALIGN(PAGE_SIZE);
@@ -368,8 +367,8 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
 	_end = .;
 
-        STABS_DEBUG
-        DWARF_DEBUG
+	STABS_DEBUG
+	DWARF_DEBUG
 
 	/* Sections to be discarded */
 	DISCARDS
