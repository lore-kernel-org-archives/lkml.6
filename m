Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20084C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75DF2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75DF2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeJRTSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:18:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34156 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeJRTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:18:00 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gD6Ip-0005iS-GS; Thu, 18 Oct 2018 13:17:19 +0200
Date:   Thu, 18 Oct 2018 13:17:19 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 03/11] x86/fpu: make __raw_xsave_addr() use feature
 number instead of mask
Message-ID: <20181018111719.bka4nqgslnurxysr@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-4-bigeasy@linutronix.de>
 <225ca4ed-a0c8-9566-4a40-00d7876b623b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <225ca4ed-a0c8-9566-4a40-00d7876b623b@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-12 08:52:03 [-0700], Dave Hansen wrote:
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > index 87a57b7642d36..38d0b5ea40425 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -811,10 +811,8 @@ void fpu__resume_cpu(void)
> >   *
> >   * Note: does not work for compacted buffers.
> >   */
> > -void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
> > +void *__raw_xsave_addr(struct xregs_state *xsave, int feature_nr)
> >  {
> 
> Could we call this 'xfeature_nr' consistently?
yes.

> Should we also be using a feature number for get_xsave_addr()?  In other
> words, could you take a look and see how widely we should be doing this
> kind of conversion and not just limit it to __raw_xsave_addr()?

this brings us to:

Subject: [PATCH] x86/fpu: Make get_xsave_field_ptr() and get_xsave_addr() use
 feature number instead of mask

After changing the argument of __raw_xsave_addr() from a mask to number
Dave suggested to check if it makes sense to do the same for
get_xsave_addr(). As it turns out it does. Only get_xsave_addr() needs
the mask to check if the requested feature is part of what is
support/saved and then uses the number again. The shift operation is
cheaper compared to "find last bit set". Also, the feature number uses
less opcode space compared to the mask :)

Make get_xsave_addr() argument a xfeature number instead of mask and fix
up its callers.
As part of this use xfeature_nr and xfeature_mask consistently.
This results in changes to the kvm code as:
	feature -> xfeature_mask
	index -> xfeature_nr

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/xstate.h |  2 +-
 arch/x86/kernel/fpu/xstate.c      | 23 +++++++++++------------
 arch/x86/kernel/traps.c           |  2 +-
 arch/x86/kvm/x86.c                | 28 ++++++++++++++--------------
 arch/x86/mm/mpx.c                 |  6 +++---
 5 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 48581988d78c7..a0b6062012ed7 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -47,7 +47,7 @@ extern void __init update_regset_xstate_info(unsigned int size,
 
 void fpu__xstate_clear_all_cpu_caps(void);
 void *get_xsave_addr(struct xregs_state *xsave, int xstate);
-const void *get_xsave_field_ptr(int xstate_field);
+const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
 int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
 int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3dfe3627deaf6..375226055a413 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -832,15 +832,15 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
  *
  * Inputs:
  *	xstate: the thread's storage area for all FPU data
- *	xstate_feature: state which is defined in xsave.h (e.g.
- *	XFEATURE_MASK_FP, XFEATURE_MASK_SSE, etc...)
+ *	xfeature_nr: state which is defined in xsave.h (e.g. XFEATURE_FP,
+ *	XFEATURE_SSE, etc...)
  * Output:
  *	address of the state in the xsave area, or NULL if the
  *	field is not present in the xsave buffer.
  */
-void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
+void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
-	int xfeature_nr;
+	u64 xfeature_mask = 1ULL << xfeature_nr;
 	/*
 	 * Do we even *have* xsave state?
 	 */
@@ -852,11 +852,11 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 	 * have not enabled.  Remember that pcntxt_mask is
 	 * what we write to the XCR0 register.
 	 */
-	WARN_ONCE(!(xfeatures_mask & xstate_feature),
+	WARN_ONCE(!(xfeatures_mask & xfeature_mask),
 		  "get of unsupported state");
 	/*
 	 * This assumes the last 'xsave*' instruction to
-	 * have requested that 'xstate_feature' be saved.
+	 * have requested that 'xfeature_mask' be saved.
 	 * If it did not, we might be seeing and old value
 	 * of the field in the buffer.
 	 *
@@ -865,10 +865,9 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 	 * or because the "init optimization" caused it
 	 * to not be saved.
 	 */
-	if (!(xsave->header.xfeatures & xstate_feature))
+	if (!(xsave->header.xfeatures & xfeature_mask))
 		return NULL;
 
-	xfeature_nr = fls64(xstate_feature) - 1;
 	return __raw_xsave_addr(xsave, xfeature_nr);
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
@@ -884,13 +883,13 @@ EXPORT_SYMBOL_GPL(get_xsave_addr);
  * Note that this only works on the current task.
  *
  * Inputs:
- *	@xsave_state: state which is defined in xsave.h (e.g. XFEATURE_MASK_FP,
- *	XFEATURE_MASK_SSE, etc...)
+ *	@xfeature_nr: state which is defined in xsave.h (e.g. XFEATURE_FP,
+ *	XFEATURE_SSE, etc...)
  * Output:
  *	address of the state in the xsave area or NULL if the state
  *	is not present or is in its 'init state'.
  */
-const void *get_xsave_field_ptr(int xsave_state)
+const void *get_xsave_field_ptr(int xfeature_nr)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
@@ -900,7 +899,7 @@ const void *get_xsave_field_ptr(int xsave_state)
 	 */
 	fpu__save(fpu);
 
-	return get_xsave_addr(&fpu->state.xsave, xsave_state);
+	return get_xsave_addr(&fpu->state.xsave, xfeature_nr);
 }
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e6db475164ede..aa4703d12e084 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -477,7 +477,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	 * which is all zeros which indicates MPX was not
 	 * responsible for the exception.
 	 */
-	bndcsr = get_xsave_field_ptr(XFEATURE_MASK_BNDCSR);
+	bndcsr = get_xsave_field_ptr(XFEATURE_BNDCSR);
 	if (!bndcsr)
 		goto exit_trap;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ca717737347e6..78006ea3cf46f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3533,15 +3533,15 @@ static void fill_xsave(u8 *dest, struct kvm_vcpu *vcpu)
 	 */
 	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
-		u64 feature = valid & -valid;
-		int index = fls64(feature) - 1;
-		void *src = get_xsave_addr(xsave, feature);
+		u64 xfeature_mask = valid & -valid;
+		int xfeature_nr = fls64(xfeature_mask) - 1;
+		void *src = get_xsave_addr(xsave, xfeature_nr);
 
 		if (src) {
 			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, index,
+			cpuid_count(XSTATE_CPUID, xfeature_nr,
 				    &size, &offset, &ecx, &edx);
-			if (feature == XFEATURE_MASK_PKRU)
+			if (xfeature_nr == XFEATURE_PKRU)
 				memcpy(dest + offset, &vcpu->arch.pkru,
 				       sizeof(vcpu->arch.pkru));
 			else
@@ -3549,7 +3549,7 @@ static void fill_xsave(u8 *dest, struct kvm_vcpu *vcpu)
 
 		}
 
-		valid -= feature;
+		valid -= xfeature_mask;
 	}
 }
 
@@ -3576,22 +3576,22 @@ static void load_xsave(struct kvm_vcpu *vcpu, u8 *src)
 	 */
 	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
 	while (valid) {
-		u64 feature = valid & -valid;
-		int index = fls64(feature) - 1;
-		void *dest = get_xsave_addr(xsave, feature);
+		u64 xfeature_mask = valid & -valid;
+		int xfeature_nr = fls64(xfeature_mask) - 1;
+		void *dest = get_xsave_addr(xsave, xfeature_nr);
 
 		if (dest) {
 			u32 size, offset, ecx, edx;
-			cpuid_count(XSTATE_CPUID, index,
+			cpuid_count(XSTATE_CPUID, xfeature_nr,
 				    &size, &offset, &ecx, &edx);
-			if (feature == XFEATURE_MASK_PKRU)
+			if (xfeature_nr == XFEATURE_PKRU)
 				memcpy(&vcpu->arch.pkru, src + offset,
 				       sizeof(vcpu->arch.pkru));
 			else
 				memcpy(dest, src + offset, size);
 		}
 
-		valid -= feature;
+		valid -= xfeature_mask;
 	}
 }
 
@@ -8562,11 +8562,11 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		if (init_event)
 			kvm_put_guest_fpu(vcpu);
 		mpx_state_buffer = get_xsave_addr(&vcpu->arch.guest_fpu.state.xsave,
-					XFEATURE_MASK_BNDREGS);
+					XFEATURE_BNDREGS);
 		if (mpx_state_buffer)
 			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndreg_state));
 		mpx_state_buffer = get_xsave_addr(&vcpu->arch.guest_fpu.state.xsave,
-					XFEATURE_MASK_BNDCSR);
+					XFEATURE_BNDCSR);
 		if (mpx_state_buffer)
 			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndcsr));
 		if (init_event)
diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index e500949bae245..a50c3fe11c6ff 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -145,7 +145,7 @@ siginfo_t *mpx_generate_siginfo(struct pt_regs *regs)
 		goto err_out;
 	}
 	/* get bndregs field from current task's xsave area */
-	bndregs = get_xsave_field_ptr(XFEATURE_MASK_BNDREGS);
+	bndregs = get_xsave_field_ptr(XFEATURE_BNDREGS);
 	if (!bndregs) {
 		err = -EINVAL;
 		goto err_out;
@@ -202,7 +202,7 @@ static __user void *mpx_get_bounds_dir(void)
 	 * The bounds directory pointer is stored in a register
 	 * only accessible if we first do an xsave.
 	 */
-	bndcsr = get_xsave_field_ptr(XFEATURE_MASK_BNDCSR);
+	bndcsr = get_xsave_field_ptr(XFEATURE_BNDCSR);
 	if (!bndcsr)
 		return MPX_INVALID_BOUNDS_DIR;
 
@@ -388,7 +388,7 @@ static int do_mpx_bt_fault(void)
 	const struct mpx_bndcsr *bndcsr;
 	struct mm_struct *mm = current->mm;
 
-	bndcsr = get_xsave_field_ptr(XFEATURE_MASK_BNDCSR);
+	bndcsr = get_xsave_field_ptr(XFEATURE_BNDCSR);
 	if (!bndcsr)
 		return -EINVAL;
 	/*
-- 
2.19.1


Sebastian
