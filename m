Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeFDV0z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:26:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40533 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeFDV0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:26:52 -0400
X-Google-Smtp-Source: ADUXVKKzPZJGz7Au4z9U8eooQF99exG10U1MYFXnRYqtvK4lRRMUnzuK6eGOXZyrgfIauxyArxRqMw==
Date: Tue, 5 Jun 2018 00:26:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 4.17-ad1: -march=native support or Kernel Ricers wanted
Message-ID: <20180604212646.GA10078@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original announcement:
https://marc.info/?l=linux-kernel&m=151268659328024&w=4

TLDR: this patchset adds kernel compilation with "-march=native"
for x86_64 which was available for a long time in userspace.

Run "make oldconfig", select "-march=native" support, recompile,
reboot on the same machine(!).

Changes since v0:

* REP STOSB/MOVSB harder for both aligned and unaligned cases
  (still not enough)
* disable MMX/SSE/AVX/AVX-512 (needs double checking re F16C etc)
* use __builtin_popcount() (kudos to hpa)
* fail hard in verify_cpu()
* REP STOSB clear_user() support
* inject "-march=native" detection line into /proc/config.gz

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Makefile                                      |   17 +++-
 arch/x86/Kconfig.cpu                          |    8 +
 arch/x86/Makefile                             |   27 +++++-
 arch/x86/boot/compressed/head_64.S            |    4 
 arch/x86/crypto/des3_ede-asm_64.S             |   28 ++++++
 arch/x86/crypto/sha1_ssse3_asm.S              |    7 +
 arch/x86/include/asm/arch_hweight.h           |   28 ++++++
 arch/x86/include/asm/page_64.h                |   26 ++++++
 arch/x86/kernel/relocate_kernel_64.S          |   15 +++
 arch/x86/kernel/verify_cpu.S                  |   27 ++++++
 arch/x86/lib/Makefile                         |   12 ++
 arch/x86/lib/memcpy_64.S                      |   13 +++
 arch/x86/lib/memset_64.S                      |   15 +++
 arch/x86/lib/usercopy_64.c                    |   15 +++
 arch/x86/net/bpf_jit.S                        |   12 ++
 arch/x86/xen/xen-pvh.S                        |    4 
 drivers/net/wireless/mediatek/mt76/mac80211.c |    2 
 include/linux/bitops.h                        |    2 
 lib/Makefile                                  |    2 
 scripts/kconfig/.gitignore                    |    1 
 scripts/kconfig/Makefile                      |   19 +++-
 scripts/kconfig/cpuid.c                       |  100 +++++++++++++++++++++++
 scripts/march-native.sh                       |  109 ++++++++++++++++++++++++++
 23 files changed, 473 insertions(+), 20 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 4
 PATCHLEVEL = 17
 SUBLEVEL = 0
-EXTRAVERSION =
+EXTRAVERSION = -ad1
 NAME = Merciless Moray
 
 # *DOCUMENTATION*
@@ -362,9 +362,8 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS)
 
 HOSTCC       = gcc
 HOSTCXX      = g++
-HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
-		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
-HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
+HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -march=native -O2 -fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
+HOSTCXXFLAGS := -march=native -O2 $(HOST_LFS_CFLAGS)
 HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
 HOST_LOADLIBES := $(HOST_LFS_LIBS)
 
@@ -584,6 +583,16 @@ ifeq ($(dot-config),1)
 # Read in config
 -include include/config/auto.conf
 
+ifdef CONFIG_MARCH_NATIVE
+KBUILD_CFLAGS += -march=native
+endif
+ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+KBUILD_CFLAGS += -mmemcpy-strategy=rep_byte:-1:align,rep_byte:-1:noalign
+endif
+ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+KBUILD_CFLAGS += -mmemset-strategy=rep_byte:-1:align,rep_byte:-1:noalign
+endif
+
 ifeq ($(KBUILD_EXTMOD),)
 # Read in dependencies to all Kconfig* files, make sure to run
 # oldconfig if changes are detected.
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -287,6 +287,12 @@ config GENERIC_CPU
 	  Generic x86-64 CPU.
 	  Run equally well on all x86-64 CPUs.
 
+config MARCH_NATIVE
+	bool "-march=native"
+	depends on X86_64
+	---help---
+	  -march=native support.
+
 endchoice
 
 config X86_GENERIC
@@ -307,6 +313,7 @@ config X86_INTERNODE_CACHE_SHIFT
 	int
 	default "12" if X86_VSMP
 	default X86_L1_CACHE_SHIFT
+	depends on !MARCH_NATIVE
 
 config X86_L1_CACHE_SHIFT
 	int
@@ -314,6 +321,7 @@ config X86_L1_CACHE_SHIFT
 	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
 	default "4" if MELAN || M486 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
+	depends on !MARCH_NATIVE
 
 config X86_F00F_BUG
 	def_bool y
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -12,6 +12,28 @@ else
         KBUILD_DEFCONFIG := $(ARCH)_defconfig
 endif
 
+CFLAGS_NO_FP :=
+CFLAGS_NO_FP += $(call cc-option,-mno-mmx,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse2,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse3,)
+CFLAGS_NO_FP += $(call cc-option,-mno-ssse3,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse4,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse4a,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse4.1,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse4.2,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx2,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512f,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512pf,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512er,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512cd,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512vl,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512bw,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512dq,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512ifma,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512vbmi,)
+
 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
 # clang has the option -mstack-alignment for that purpose.
 ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
@@ -34,7 +56,7 @@ M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
 REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
-		   -mno-mmx -mno-sse
+		   $(CFLAGS_NO_FP)
 
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
@@ -57,8 +79,7 @@ endif
 #
 #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
 #
-KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
-KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
+KBUILD_CFLAGS += $(CFLAGS_NO_FP)
 
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -516,8 +516,12 @@ relocated:
 	leaq    _bss(%rip), %rdi
 	leaq    _ebss(%rip), %rcx
 	subq	%rdi, %rcx
+#ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+	rep stosb
+#else
 	shrq	$3, %rcx
 	rep	stosq
+#endif
 
 /*
  * Do the extraction, and jump to the new kernel..
--- a/arch/x86/crypto/des3_ede-asm_64.S
+++ b/arch/x86/crypto/des3_ede-asm_64.S
@@ -159,6 +159,15 @@
 
 #define dummy2(a, b) /*_*/
 
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+#define read_block(io, left, right) \
+	movbe	 (io), left##d; \
+	movbe	4(io), right##d;
+
+#define write_block(io, left, right) \
+	movbe	left##d,   (io); \
+	movbe	right##d, 4(io);
+#else
 #define read_block(io, left, right) \
 	movl    (io), left##d; \
 	movl   4(io), right##d; \
@@ -170,6 +179,7 @@
 	bswapl right##d; \
 	movl   left##d,   (io); \
 	movl   right##d, 4(io);
+#endif
 
 ENTRY(des3_ede_x86_64_crypt_blk)
 	/* input:
@@ -443,6 +453,14 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 	pushq %rsi /* dst */
 
 	/* load input */
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	movbe 0 * 4(%rdx), RL0d;
+	movbe 1 * 4(%rdx), RR0d;
+	movbe 2 * 4(%rdx), RL1d;
+	movbe 3 * 4(%rdx), RR1d;
+	movbe 4 * 4(%rdx), RL2d;
+	movbe 5 * 4(%rdx), RR2d;
+#else
 	movl 0 * 4(%rdx), RL0d;
 	movl 1 * 4(%rdx), RR0d;
 	movl 2 * 4(%rdx), RL1d;
@@ -456,6 +474,7 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 	bswapl RR1d;
 	bswapl RL2d;
 	bswapl RR2d;
+#endif
 
 	initial_permutation3(RL, RR);
 
@@ -516,6 +535,14 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 
 	final_permutation3(RR, RL);
 
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	movbe RR0d, 0 * 4(%rsi);
+	movbe RL0d, 1 * 4(%rsi);
+	movbe RR1d, 2 * 4(%rsi);
+	movbe RL1d, 3 * 4(%rsi);
+	movbe RR2d, 4 * 4(%rsi);
+	movbe RL2d, 5 * 4(%rsi);
+#else
 	bswapl RR0d;
 	bswapl RL0d;
 	bswapl RR1d;
@@ -530,6 +557,7 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 	movl RL1d, 3 * 4(%rsi);
 	movl RR2d, 4 * 4(%rsi);
 	movl RL2d, 5 * 4(%rsi);
+#endif
 
 	popq %r15;
 	popq %r14;
--- a/arch/x86/crypto/sha1_ssse3_asm.S
+++ b/arch/x86/crypto/sha1_ssse3_asm.S
@@ -94,10 +94,15 @@
 	SHA1_PIPELINED_MAIN_BODY
 
 	# cleanup workspace
-	mov	$8, %ecx
 	mov	%rsp, %rdi
 	xor	%rax, %rax
+#ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+	mov	$64, %ecx
+	rep stosb
+#else
+	mov	$8, %ecx
 	rep stosq
+#endif
 
 	mov	%rbp, %rsp		# deallocate workspace
 	pop	%rbp
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -2,6 +2,30 @@
 #ifndef _ASM_X86_HWEIGHT_H
 #define _ASM_X86_HWEIGHT_H
 
+#define __HAVE_ARCH_SW_HWEIGHT
+
+#ifdef CONFIG_MARCH_NATIVE_POPCNT
+static inline unsigned int __arch_hweight64(uint64_t x)
+{
+	return __builtin_popcountll(x);
+}
+
+static inline unsigned int __arch_hweight32(uint32_t x)
+{
+	return __builtin_popcount(x);
+}
+
+static inline unsigned int __arch_hweight16(uint16_t x)
+{
+	return __builtin_popcount(x);
+}
+
+static inline unsigned int __arch_hweight8(uint8_t x)
+{
+	return __builtin_popcount(x);
+}
+#else
+
 #include <asm/cpufeatures.h>
 
 #ifdef CONFIG_64BIT
@@ -18,8 +42,6 @@
 #define REG_OUT "a"
 #endif
 
-#define __HAVE_ARCH_SW_HWEIGHT
-
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
@@ -61,3 +83,5 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 #endif /* CONFIG_X86_32 */
 
 #endif
+
+#endif
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -40,6 +40,18 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 #define pfn_valid(pfn)          ((pfn) < max_pfn)
 #endif
 
+#ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+static __always_inline void clear_page(void *page)
+{
+	uint32_t len = PAGE_SIZE;
+	asm volatile (
+		"rep stosb"
+		: "+D" (page), "+c" (len)
+		: "a" (0)
+		: "memory"
+	);
+}
+#else
 void clear_page_orig(void *page);
 void clear_page_rep(void *page);
 void clear_page_erms(void *page);
@@ -53,8 +65,22 @@ static inline void clear_page(void *page)
 			   "0" (page)
 			   : "cc", "memory", "rax", "rcx");
 }
+#endif
 
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+static __always_inline void copy_page(void *to, void *from)
+{
+	uint32_t len = PAGE_SIZE;
+	asm volatile (
+		"rep movsb"
+		: "+D" (to), "+S" (from), "+c" (len)
+		:
+		: "memory"
+	);
+}
+#else
 void copy_page(void *to, void *from);
+#endif
 
 #endif	/* !__ASSEMBLY__ */
 
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -268,18 +268,33 @@ swap_pages:
 	movq	%rsi, %rax
 
 	movq	%r10, %rdi
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+	mov	$4096, %ecx
+	rep movsb
+#else
 	movl	$512, %ecx
 	rep ; movsq
+#endif
 
 	movq	%rax, %rdi
 	movq	%rdx, %rsi
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+	mov	$4096, %ecx
+	rep movsb
+#else
 	movl	$512, %ecx
 	rep ; movsq
+#endif
 
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+	mov	$4096, %ecx
+	rep movsb
+#else
 	movl	$512, %ecx
 	rep ; movsq
+#endif
 
 	lea	PAGE_SIZE(%rax), %rsi
 	jmp	0b
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -136,6 +136,33 @@ ENTRY(verify_cpu)
 	movl $1,%eax
 	ret
 .Lverify_cpu_sse_ok:
+
+#ifdef CONFIG_MARCH_NATIVE_POPCNT
+	mov	$1, %eax
+	cpuid
+	bt	$23, %ecx
+	jnc	.Lverify_cpu_no_longmode
+#endif
+
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	mov	$1, %eax
+	cpuid
+	bt	$22, %ecx
+	jnc	.Lverify_cpu_no_longmode
+#endif
+
+#if defined(CONFIG_MARCH_NATIVE_REP_MOVSB) || defined(CONFIG_MARCH_NATIVE_REP_STOSB)
+	xor	%eax, %eax
+	cpuid
+	cmp	$7, %eax
+	jb	.Lverify_cpu_no_longmode
+	mov	$7, %eax
+	xor	%ecx, %ecx
+	cpuid
+	bt	$9, %ebx
+	jnc	.Lverify_cpu_no_longmode
+#endif
+
 	popf				# Restore caller passed flags
 	xorl %eax, %eax
 	ret
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -29,7 +29,10 @@ lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
 
-obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
+obj-y += msr.o msr-reg.o msr-reg-export.o
+ifneq ($(CONFIG_MARCH_NATIVE),y)
+	obj-y += hweight.o
+endif
 
 ifeq ($(CONFIG_X86_32),y)
         obj-y += atomic64_32.o
@@ -44,7 +47,12 @@ endif
 else
         obj-y += iomap_copy_64.o
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
-        lib-y += clear_page_64.o copy_page_64.o
+ifneq ($(CONFIG_MARCH_NATIVE_REP_STOSB),y)
+        lib-y += clear_page_64.o
+endif
+ifneq ($(CONFIG_MARCH_NATIVE_REP_MOVSB),y)
+	lib-y += copy_page_64.o
+endif
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o
 	lib-y += cmpxchg16b_emu.o
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -15,6 +15,18 @@
 
 .weak memcpy
 
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+ENTRY(__memcpy)
+ENTRY(memcpy)
+	mov	%rdi, %rax
+	mov	%rdx, %rcx
+	rep movsb
+	ret
+ENDPROC(memcpy)
+ENDPROC(__memcpy)
+EXPORT_SYMBOL(memcpy)
+EXPORT_SYMBOL(__memcpy)
+#else
 /*
  * memcpy - Copy a memory block.
  *
@@ -181,6 +193,7 @@ ENTRY(memcpy_orig)
 .Lend:
 	retq
 ENDPROC(memcpy_orig)
+#endif
 
 #ifndef CONFIG_UML
 /*
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -8,6 +8,20 @@
 
 .weak memset
 
+#ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+ENTRY(memset)
+ENTRY(__memset)
+	mov	%esi, %eax
+	mov	%rdi, %rsi
+	mov	%rdx, %rcx
+	rep stosb
+	mov	%rsi, %rax
+	ret
+ENDPROC(memset)
+ENDPROC(__memset)
+EXPORT_SYMBOL(memset)
+EXPORT_SYMBOL(__memset)
+#else
 /*
  * ISO C memset - set a memory block to a byte value. This function uses fast
  * string to get better performance than the original function. The code is
@@ -140,3 +154,4 @@ ENTRY(memset_orig)
 	jmp .Lafter_bad_alignment
 .Lfinal:
 ENDPROC(memset_orig)
+#endif
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -15,11 +15,22 @@
 
 unsigned long __clear_user(void __user *addr, unsigned long size)
 {
-	long __d0;
 	might_fault();
 	/* no memory constraint because it doesn't change any memory gcc knows
 	   about */
 	stac();
+#ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+	asm volatile (
+		"0:	rep stosb\n"
+		"1:\n"
+		_ASM_EXTABLE(0b,1b)
+		: "+D" (addr), "+c" (size)
+		: "a" (0)
+		: "memory"
+	);
+#else
+	{
+	long __d0;
 	asm volatile(
 		"	testq  %[size8],%[size8]\n"
 		"	jz     4f\n"
@@ -42,6 +53,8 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 		: [size8] "=&c"(size), [dst] "=&D" (__d0)
 		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr),
 		  [zero] "r" (0UL), [eight] "r" (8UL));
+	}
+#endif
 	clac();
 	return size;
 }
--- a/arch/x86/net/bpf_jit.S
+++ b/arch/x86/net/bpf_jit.S
@@ -34,8 +34,12 @@ FUNC(sk_load_word_positive_offset)
 	sub	%esi,%eax		# hlen - offset
 	cmp	$3,%eax
 	jle	bpf_slow_path_word
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	movbe	(SKBDATA,%rsi),%eax
+#else
 	mov     (SKBDATA,%rsi),%eax
 	bswap   %eax  			/* ntohl() */
+#endif
 	ret
 
 FUNC(sk_load_half)
@@ -80,8 +84,12 @@ FUNC(sk_load_byte_positive_offset)
 bpf_slow_path_word:
 	bpf_slow_path_common(4)
 	js	bpf_error
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	movbe	32(%rbp),%eax
+#else
 	mov	32(%rbp),%eax
 	bswap	%eax
+#endif
 	ret
 
 bpf_slow_path_half:
@@ -118,8 +126,12 @@ bpf_slow_path_word_neg:
 
 FUNC(sk_load_word_negative_offset)
 	sk_negative_common(4)
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	movbe	(%rax), %eax
+#else
 	mov	(%rax), %eax
 	bswap	%eax
+#endif
 	ret
 
 bpf_slow_path_half_neg:
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -68,9 +68,13 @@ ENTRY(pvh_start_xen)
 	mov $_pa(pvh_start_info), %edi
 	mov %ebx, %esi
 	mov _pa(pvh_start_info_sz), %ecx
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+	rep movsb
+#else
 	shr $2,%ecx
 	rep
 	movsl
+#endif
 
 	mov $_pa(early_stack_end), %esp
 
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -124,7 +124,7 @@ static void mt76_init_stream_cap(struct mt76_dev *dev,
 				 bool vht)
 {
 	struct ieee80211_sta_ht_cap *ht_cap = &sband->ht_cap;
-	int i, nstream = __sw_hweight8(dev->antenna_mask);
+	int i, nstream = hweight8(dev->antenna_mask);
 	struct ieee80211_sta_vht_cap *vht_cap;
 	u16 mcs_map = 0;
 
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -26,10 +26,12 @@
 	(((~0ULL) - (1ULL << (l)) + 1) & \
 	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
 
+#ifndef CONFIG_MARCH_NATIVE_POPCNT
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
 extern unsigned long __sw_hweight64(__u64 w);
+#endif
 
 /*
  * Include this here because some architectures need generic_ffs/fls in
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -87,7 +87,9 @@ obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
 obj-y += logic_pio.o
 
+ifneq ($(CONFIG_MARCH_NATIVE_POPCNT),y)
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
+endif
 
 obj-$(CONFIG_BTREE) += btree.o
 obj-$(CONFIG_INTERVAL_TREE) += interval_tree.o
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -10,6 +10,7 @@ gconf.glade.h
 # configuration programs
 #
 conf
+cpuid
 mconf
 nconf
 qconf
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -19,26 +19,32 @@ endif
 # We need this, in case the user has it in its environment
 unexport CONFIG_
 
-xconfig: $(obj)/qconf
+xconfig: $(obj)/qconf $(obj)/cpuid
 	$< $(silent) $(Kconfig)
+	$(Q)$(srctree)/scripts/march-native.sh $(CC) $(obj)/cpuid
 
-gconfig: $(obj)/gconf
+gconfig: $(obj)/gconf $(obj)/cpuid
 	$< $(silent) $(Kconfig)
+	$(Q)$(srctree)/scripts/march-native.sh $(CC) $(obj)/cpuid
 
-menuconfig: $(obj)/mconf
+menuconfig: $(obj)/mconf $(obj)/cpuid
 	$< $(silent) $(Kconfig)
+	$(Q)$(srctree)/scripts/march-native.sh $(CC) $(obj)/cpuid
 
-config: $(obj)/conf
+config: $(obj)/conf $(obj)/cpuid
 	$< $(silent) --oldaskconfig $(Kconfig)
+	$(Q)$(srctree)/scripts/march-native.sh $(CC) $(obj)/cpuid
 
-nconfig: $(obj)/nconf
+nconfig: $(obj)/nconf $(obj)/cpuid
 	$< $(silent) $(Kconfig)
+	$(Q)$(srctree)/scripts/march-native.sh $(CC) $(obj)/cpuid
 
 # This has become an internal implementation detail and is now deprecated
 # for external use.
-syncconfig: $(obj)/conf
+syncconfig: $(obj)/conf $(obj)/cpuid
 	$(Q)mkdir -p include/config include/generated
 	$< $(silent) --$@ $(Kconfig)
+	$(Q)$(srctree)/scripts/march-native.sh $(CC) $(obj)/cpuid
 
 localyesconfig localmodconfig: $(obj)/conf
 	$(Q)mkdir -p include/config include/generated
@@ -206,6 +212,7 @@ qconf-objs	:= zconf.tab.o
 gconf-objs	:= gconf.o zconf.tab.o
 
 hostprogs-y := conf nconf mconf kxgettext qconf gconf
+hostprogs-y += cpuid
 
 targets		+= zconf.lex.c
 clean-files	:= qconf.moc .tmp_qtcheck .tmp_gtkcheck
new file mode 100644
--- /dev/null
+++ b/scripts/kconfig/cpuid.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright (c) 2017 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+static inline bool streq(const char *s1, const char *s2)
+{
+	return strcmp(s1, s2) == 0;
+}
+
+static inline void cpuid(uint32_t eax0, uint32_t *eax, uint32_t *ecx, uint32_t *edx, uint32_t *ebx)
+{
+	asm volatile (
+		"cpuid"
+		: "=a" (*eax), "=c" (*ecx), "=d" (*edx), "=b" (*ebx)
+		: "0" (eax0)
+	);
+}
+
+static inline void cpuid2(uint32_t eax0, uint32_t ecx0, uint32_t *eax, uint32_t *ecx, uint32_t *edx, uint32_t *ebx)
+{
+	asm volatile (
+		"cpuid"
+		: "=a" (*eax), "=c" (*ecx), "=d" (*edx), "=b" (*ebx)
+		: "0" (eax0), "1" (ecx0)
+	);
+}
+
+static bool movbe	= false;
+static bool popcnt	= false;
+static bool rep_movsb	= false;
+static bool rep_stosb	= false;
+
+static uint32_t eax0_max;
+
+static void intel(void)
+{
+	uint32_t eax, ecx, edx, ebx;
+
+	if (eax0_max >= 1) {
+		cpuid(1, &eax, &ecx, &edx, &ebx);
+//		printf("%08x %08x %08x %08x\n", eax, ecx, edx, ebx);
+
+		if (ecx & (1 << 22))
+			movbe = true;
+		if (ecx & (1 << 23))
+			popcnt = true;
+	}
+	if (eax0_max >= 7) {
+		cpuid2(7, 0, &eax, &ecx, &edx, &ebx);
+//		printf("%08x %08x %08x %08x\n", eax, ecx, edx, ebx);
+
+		if (ebx & (1 << 9)) {
+			rep_movsb = true;
+			rep_stosb = true;
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	const char *opt = argv[1];
+	uint32_t eax, ecx, edx, ebx;
+
+	if (argc != 2)
+		return EXIT_FAILURE;
+
+	cpuid(0, &eax, &ecx, &edx, &ebx);
+//	printf("%08x %08x %08x %08x\n", eax, ecx, edx, ebx);
+	eax0_max = eax;
+
+	if (ecx == 0x6c65746e && edx == 0x49656e69 && ebx == 0x756e6547) {
+		intel();
+	}
+
+#define _(x)	if (streq(opt, #x)) return x ? EXIT_SUCCESS : EXIT_FAILURE
+	_(movbe);
+	_(popcnt);
+	_(rep_movsb);
+	_(rep_stosb);
+#undef _
+
+	return EXIT_FAILURE;
+}
new file mode 100755
--- /dev/null
+++ b/scripts/march-native.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+# Copyright (c) 2017 Alexey Dobriyan <adobriyan@gmail.com>
+if test "$(uname -m)" != "x86_64"; then
+	exit 0
+fi
+
+CC="$1"
+CPUID="$2"
+CONFIG=".config"
+AUTOCONF1="include/config/auto.conf"
+AUTOCONF2="include/generated/autoconf.h"
+
+if ! grep -q -e '^CONFIG_MARCH_NATIVE=y$' .config; then
+	sed -i -e '/CONFIG_MARCH_NATIVE/d' "$AUTOCONF1" "$AUTOCONF2" >/dev/null 2>&1
+	exit 0
+fi
+
+if ! "$CC" -march=native -x c -c -o /dev/null /dev/null >/dev/null 2>&1; then
+	echo >&2 "error: unsupported '-march=native' compiler option"
+	exit 1
+fi
+
+_option() {
+	echo "$1=$2"		>>"$CONFIG"
+	echo "$1=$2"		>>"$AUTOCONF1"
+	echo "#define $1 $2"	>>"$AUTOCONF2"
+}
+
+option() {
+	echo "$1=y"		>>"$CONFIG"
+	echo "$1=y"		>>"$AUTOCONF1"
+	echo "#define $1 1"	>>"$AUTOCONF2"
+}
+
+if test ! -f "$CONFIG" -o ! -f "$AUTOCONF1" -o ! -f "$AUTOCONF2"; then
+	exit 0
+fi
+
+COLLECT_GCC_OPTIONS=$(
+	"$CC" -march=native -v -E -x c -c /dev/null 2>&1	|\
+	sed -ne '/^COLLECT_GCC_OPTIONS=/{n;p}'			|\
+	awk '{$1=$1};1'
+)
+echo "-march=native: $COLLECT_GCC_OPTIONS"
+_option "CONFIG_MARCH_NATIVE_GCC_OPTIONS" "\"$COLLECT_GCC_OPTIONS\""
+
+"$CPUID" movbe		&& option "CONFIG_MARCH_NATIVE_MOVBE"
+"$CPUID" popcnt		&& option "CONFIG_MARCH_NATIVE_POPCNT"
+"$CPUID" rep_movsb	&& option "CONFIG_MARCH_NATIVE_REP_MOVSB"
+"$CPUID" rep_stosb	&& option "CONFIG_MARCH_NATIVE_REP_STOSB"
+
+for i in $COLLECT_GCC_OPTIONS; do
+	case $i in
+		*/cc1|-E|-quiet|-v|/dev/null|--param|-fstack-protector*|-mno-*)
+			;;
+
+		# FIXME
+		l1-cache-size=*);;
+		l2-cache-size=*);;
+
+		l1-cache-line-size=64)
+			_option "CONFIG_X86_L1_CACHE_SHIFT"		6
+			_option "CONFIG_X86_INTERNODE_CACHE_SHIFT"	6
+			;;
+
+		-march=broadwell);;
+		-mtune=broadwell);;
+		-march=nehalem);;
+		-mtune=nehalem);;
+
+		-mabm)		option "CONFIG_MARCH_NATIVE_ABM"	;;
+		-madx)		option "CONFIG_MARCH_NATIVE_ADX"	;;
+		-maes)		option "CONFIG_MARCH_NATIVE_AES"	;;
+		-mavx)		option "CONFIG_MARCH_NATIVE_AVX"	;;
+		-mavx2)		option "CONFIG_MARCH_NATIVE_AVX2"	;;
+		-mbmi)		option "CONFIG_MARCH_NATIVE_BMI"	;;
+		-mbmi2)		option "CONFIG_MARCH_NATIVE_BMI2"	;;
+		-mcx16)		option "CONFIG_MARCH_NATIVE_CX16"	;;
+		-mf16c)		option "CONFIG_MARCH_NATIVE_F16C"	;;
+		-mfsgsbase)	option "CONFIG_MARCH_NATIVE_FSGSBASE"	;;
+		-mfma)		option "CONFIG_MARCH_NATIVE_FMA"	;;
+		-mfxsr)		option "CONFIG_MARCH_NATIVE_FXSR"	;;
+		-mhle)		option "CONFIG_MARCH_NATIVE_HLE"	;;
+		-mlzcnt)	option "CONFIG_MARCH_NATIVE_LZCNT"	;;
+		-mmmx)		option "CONFIG_MARCH_NATIVE_MMX"	;;
+		-mmovbe);;
+		-mpclmul)	option "CONFIG_MARCH_NATIVE_PCLMUL"	;;
+		-mpopcnt);;
+		-mprfchw)	option "CONFIG_MARCH_NATIVE_PREFETCHW"	;;
+		-mrdrnd)	option "CONFIG_MARCH_NATIVE_RDRND"	;;
+		-mrdseed)	option "CONFIG_MARCH_NATIVE_RDSEED"	;;
+		-mrtm)		option "CONFIG_MARCH_NATIVE_RTM"	;;
+		-msahf)		option "CONFIG_MARCH_NATIVE_SAHF"	;;
+		-msse)		option "CONFIG_MARCH_NATIVE_SSE"	;;
+		-msse2)		option "CONFIG_MARCH_NATIVE_SSE2"	;;
+		-msse3)		option "CONFIG_MARCH_NATIVE_SSE3"	;;
+		-msse4.1)	option "CONFIG_MARCH_NATIVE_SSE4_1"	;;
+		-msse4.2)	option "CONFIG_MARCH_NATIVE_SSE4_2"	;;
+		-mssse3)	option "CONFIG_MARCH_NATIVE_SSSE3"	;;
+		-mxsave)	option "CONFIG_MARCH_NATIVE_XSAVE"	;;
+		-mxsaveopt)	option "CONFIG_MARCH_NATIVE_XSAVEOPT"	;;
+
+		*)
+			echo >&2
+			echo >&2 "Unexpected -march=native option: '$i'"
+			echo >&2
+			exit 1
+	esac
+done
