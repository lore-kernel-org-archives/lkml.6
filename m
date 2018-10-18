Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157FDC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6802148E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0hDx0st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6802148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbeJSCIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeJSCIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:08:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2104204FD;
        Thu, 18 Oct 2018 18:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885975;
        bh=9iJiCd2zEDHjGAlppXYF3FsUNtTWY3mBuNSzZljOruE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0hDx0stAxpHj5Q0pqM7PJ6wBNa4Qrxgf6AUm55+qEs017tFaSl1bIg+crpd42mB0
         1fg5TbYu3F8lZ83LGbQhKU8o4lG2NpWG+60oKTv5Oz2CsJCzhHgJqsdNRb5THmaUx+
         9ke8/ci+L1m1MvLDsccb/fBBjYee/xY7C7j4brkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, pbonzini@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [PATCH 4.4 32/48] x86/fpu: Remove use_eager_fpu()
Date:   Thu, 18 Oct 2018 19:55:07 +0200
Message-Id: <20181018175429.672632710@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit c592b57347069abfc0dcad3b3a302cf882602597 upstream.

This removes all the obvious code paths that depend on lazy FPU mode.
It shouldn't change the generated code at all.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Rik van Riel <riel@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: pbonzini@redhat.com
Link: http://lkml.kernel.org/r/1475627678-20788-5-git-send-email-riel@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/crypto/crc32c-intel_glue.c |   17 +++-------------
 arch/x86/include/asm/fpu/internal.h |   34 --------------------------------
 arch/x86/kernel/fpu/core.c          |   38 ++++--------------------------------
 arch/x86/kernel/fpu/signal.c        |    8 ++-----
 arch/x86/kvm/cpuid.c                |    4 ---
 arch/x86/kvm/x86.c                  |   10 ---------
 6 files changed, 14 insertions(+), 97 deletions(-)

--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -48,21 +48,13 @@
 #ifdef CONFIG_X86_64
 /*
  * use carryless multiply version of crc32c when buffer
- * size is >= 512 (when eager fpu is enabled) or
- * >= 1024 (when eager fpu is disabled) to account
+ * size is >= 512 to account
  * for fpu state save/restore overhead.
  */
-#define CRC32C_PCL_BREAKEVEN_EAGERFPU	512
-#define CRC32C_PCL_BREAKEVEN_NOEAGERFPU	1024
+#define CRC32C_PCL_BREAKEVEN	512
 
 asmlinkage unsigned int crc_pcl(const u8 *buffer, int len,
 				unsigned int crc_init);
-static int crc32c_pcl_breakeven = CRC32C_PCL_BREAKEVEN_EAGERFPU;
-#define set_pcl_breakeven_point()					\
-do {									\
-	if (!use_eager_fpu())						\
-		crc32c_pcl_breakeven = CRC32C_PCL_BREAKEVEN_NOEAGERFPU;	\
-} while (0)
 #endif /* CONFIG_X86_64 */
 
 static u32 crc32c_intel_le_hw_byte(u32 crc, unsigned char const *data, size_t length)
@@ -185,7 +177,7 @@ static int crc32c_pcl_intel_update(struc
 	 * use faster PCL version if datasize is large enough to
 	 * overcome kernel fpu state save/restore overhead
 	 */
-	if (len >= crc32c_pcl_breakeven && irq_fpu_usable()) {
+	if (len >= CRC32C_PCL_BREAKEVEN && irq_fpu_usable()) {
 		kernel_fpu_begin();
 		*crcp = crc_pcl(data, len, *crcp);
 		kernel_fpu_end();
@@ -197,7 +189,7 @@ static int crc32c_pcl_intel_update(struc
 static int __crc32c_pcl_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
 				u8 *out)
 {
-	if (len >= crc32c_pcl_breakeven && irq_fpu_usable()) {
+	if (len >= CRC32C_PCL_BREAKEVEN && irq_fpu_usable()) {
 		kernel_fpu_begin();
 		*(__le32 *)out = ~cpu_to_le32(crc_pcl(data, len, *crcp));
 		kernel_fpu_end();
@@ -256,7 +248,6 @@ static int __init crc32c_intel_mod_init(
 		alg.update = crc32c_pcl_intel_update;
 		alg.finup = crc32c_pcl_intel_finup;
 		alg.digest = crc32c_pcl_intel_digest;
-		set_pcl_breakeven_point();
 	}
 #endif
 	return crypto_register_shash(&alg);
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -57,11 +57,6 @@ extern u64 fpu__get_supported_xfeatures_
 /*
  * FPU related CPU feature flag helper routines:
  */
-static __always_inline __pure bool use_eager_fpu(void)
-{
-	return true;
-}
-
 static __always_inline __pure bool use_xsaveopt(void)
 {
 	return static_cpu_has(X86_FEATURE_XSAVEOPT);
@@ -498,24 +493,6 @@ static inline int fpu_want_lazy_restore(
 }
 
 
-/*
- * Wrap lazy FPU TS handling in a 'hw fpregs activation/deactivation'
- * idiom, which is then paired with the sw-flag (fpregs_active) later on:
- */
-
-static inline void __fpregs_activate_hw(void)
-{
-	if (!use_eager_fpu())
-		clts();
-}
-
-static inline void __fpregs_deactivate_hw(void)
-{
-	if (!use_eager_fpu())
-		stts();
-}
-
-/* Must be paired with an 'stts' (fpregs_deactivate_hw()) after! */
 static inline void __fpregs_deactivate(struct fpu *fpu)
 {
 	WARN_ON_FPU(!fpu->fpregs_active);
@@ -524,7 +501,6 @@ static inline void __fpregs_deactivate(s
 	this_cpu_write(fpu_fpregs_owner_ctx, NULL);
 }
 
-/* Must be paired with a 'clts' (fpregs_activate_hw()) before! */
 static inline void __fpregs_activate(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu->fpregs_active);
@@ -549,22 +525,17 @@ static inline int fpregs_active(void)
 }
 
 /*
- * Encapsulate the CR0.TS handling together with the
- * software flag.
- *
  * These generally need preemption protection to work,
  * do try to avoid using these on their own.
  */
 static inline void fpregs_activate(struct fpu *fpu)
 {
-	__fpregs_activate_hw();
 	__fpregs_activate(fpu);
 }
 
 static inline void fpregs_deactivate(struct fpu *fpu)
 {
 	__fpregs_deactivate(fpu);
-	__fpregs_deactivate_hw();
 }
 
 /*
@@ -591,8 +562,7 @@ switch_fpu_prepare(struct fpu *old_fpu,
 	 * or if the past 5 consecutive context-switches used math.
 	 */
 	fpu.preload = static_cpu_has(X86_FEATURE_FPU) &&
-		      new_fpu->fpstate_active &&
-		      (use_eager_fpu() || new_fpu->counter > 5);
+		      new_fpu->fpstate_active;
 
 	if (old_fpu->fpregs_active) {
 		if (!copy_fpregs_to_fpstate(old_fpu))
@@ -608,8 +578,6 @@ switch_fpu_prepare(struct fpu *old_fpu,
 			new_fpu->counter++;
 			__fpregs_activate(new_fpu);
 			prefetch(&new_fpu->state);
-		} else {
-			__fpregs_deactivate_hw();
 		}
 	} else {
 		old_fpu->counter = 0;
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -53,27 +53,9 @@ static bool kernel_fpu_disabled(void)
 	return this_cpu_read(in_kernel_fpu);
 }
 
-/*
- * Were we in an interrupt that interrupted kernel mode?
- *
- * On others, we can do a kernel_fpu_begin/end() pair *ONLY* if that
- * pair does nothing at all: the thread must not have fpu (so
- * that we don't try to save the FPU state), and TS must
- * be set (so that the clts/stts pair does nothing that is
- * visible in the interrupted kernel thread).
- *
- * Except for the eagerfpu case when we return true; in the likely case
- * the thread has FPU but we are not going to set/clear TS.
- */
 static bool interrupted_kernel_fpu_idle(void)
 {
-	if (kernel_fpu_disabled())
-		return false;
-
-	if (use_eager_fpu())
-		return true;
-
-	return !current->thread.fpu.fpregs_active && (read_cr0() & X86_CR0_TS);
+	return !kernel_fpu_disabled();
 }
 
 /*
@@ -121,7 +103,6 @@ void __kernel_fpu_begin(void)
 		copy_fpregs_to_fpstate(fpu);
 	} else {
 		this_cpu_write(fpu_fpregs_owner_ctx, NULL);
-		__fpregs_activate_hw();
 	}
 }
 EXPORT_SYMBOL(__kernel_fpu_begin);
@@ -132,8 +113,6 @@ void __kernel_fpu_end(void)
 
 	if (fpu->fpregs_active)
 		copy_kernel_to_fpregs(&fpu->state);
-	else
-		__fpregs_deactivate_hw();
 
 	kernel_fpu_enable();
 }
@@ -194,10 +173,7 @@ void fpu__save(struct fpu *fpu)
 	preempt_disable();
 	if (fpu->fpregs_active) {
 		if (!copy_fpregs_to_fpstate(fpu)) {
-			if (use_eager_fpu())
-				copy_kernel_to_fpregs(&fpu->state);
-			else
-				fpregs_deactivate(fpu);
+			copy_kernel_to_fpregs(&fpu->state);
 		}
 	}
 	preempt_enable();
@@ -245,8 +221,7 @@ static void fpu_copy(struct fpu *dst_fpu
 	 * Don't let 'init optimized' areas of the XSAVE area
 	 * leak into the child task:
 	 */
-	if (use_eager_fpu())
-		memset(&dst_fpu->state.xsave, 0, xstate_size);
+	memset(&dst_fpu->state.xsave, 0, xstate_size);
 
 	/*
 	 * Save current FPU registers directly into the child
@@ -268,10 +243,7 @@ static void fpu_copy(struct fpu *dst_fpu
 	if (!copy_fpregs_to_fpstate(dst_fpu)) {
 		memcpy(&src_fpu->state, &dst_fpu->state, xstate_size);
 
-		if (use_eager_fpu())
-			copy_kernel_to_fpregs(&src_fpu->state);
-		else
-			fpregs_deactivate(src_fpu);
+		copy_kernel_to_fpregs(&src_fpu->state);
 	}
 	preempt_enable();
 }
@@ -437,7 +409,7 @@ void fpu__clear(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
 
-	if (!use_eager_fpu() || !static_cpu_has(X86_FEATURE_FPU)) {
+	if (!static_cpu_has(X86_FEATURE_FPU)) {
 		/* FPU state will be reallocated lazily at the first use. */
 		fpu__drop(fpu);
 	} else {
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -319,11 +319,9 @@ static int __fpu__restore_sig(void __use
 		}
 
 		fpu->fpstate_active = 1;
-		if (use_eager_fpu()) {
-			preempt_disable();
-			fpu__restore(fpu);
-			preempt_enable();
-		}
+		preempt_disable();
+		fpu__restore(fpu);
+		preempt_enable();
 
 		return err;
 	} else {
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/uaccess.h>
-#include <asm/fpu/internal.h> /* For use_eager_fpu.  Ugh! */
 #include <asm/user.h>
 #include <asm/fpu/xstate.h>
 #include "cpuid.h"
@@ -104,8 +103,7 @@ int kvm_update_cpuid(struct kvm_vcpu *vc
 	if (best && (best->eax & (F(XSAVES) | F(XSAVEC))))
 		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
 
-	if (use_eager_fpu())
-		kvm_x86_ops->fpu_activate(vcpu);
+	kvm_x86_ops->fpu_activate(vcpu);
 
 	/*
 	 * The existing code assumes virtual address is 48-bit in the canonical
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7319,16 +7319,6 @@ void kvm_put_guest_fpu(struct kvm_vcpu *
 	copy_fpregs_to_fpstate(&vcpu->arch.guest_fpu);
 	__kernel_fpu_end();
 	++vcpu->stat.fpu_reload;
-	/*
-	 * If using eager FPU mode, or if the guest is a frequent user
-	 * of the FPU, just leave the FPU active for next time.
-	 * Every 255 times fpu_counter rolls over to 0; a guest that uses
-	 * the FPU in bursts will revert to loading it on demand.
-	 */
-	if (!use_eager_fpu()) {
-		if (++vcpu->fpu_counter < 5)
-			kvm_make_request(KVM_REQ_DEACTIVATE_FPU, vcpu);
-	}
 	trace_kvm_fpu(0);
 }
 


