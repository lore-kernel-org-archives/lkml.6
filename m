Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F2C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B375217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tVOi1qdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfBLQsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:48:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59584 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfBLQsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r7vVYIp6RyrM+d0aIc9EjXTQ866rrrcV+00xAcce++E=; b=tVOi1qdpYBmkXAfB/wMrlqULA
        Gy57HItkKKKnkh2hXGxtzzFAnG7E9+5DM0NzTqcWBAD2opUB1YArVnNHt2Tu2dNlux7eH7NWILFNO
        8TUDVEDSnZhPEAT3OYcR5QmSvYhQPdrZrPwZN3dwQ+RPtx0Hgkf56pthYXa4bg/FvMUsoafgEtne4
        LLTPRMWxTlDym6pr9EGI7PpPkTxVbZlI/R9IK3dl/1N8qlLpRv+jrjdqXZhd4HgKyC199UFo3cYLe
        Clcvi7Akz+GS6v8IgdA+tkZSsCCE+THjlagN+3l8L4nlWnFZtdI0iFG9tlhaNaWefhc6oteD+XuZN
        k4dyncA2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtbEa-0007Iy-3a; Tue, 12 Feb 2019 16:48:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26F5A23EAA438; Tue, 12 Feb 2019 17:48:33 +0100 (CET)
Date:   Tue, 12 Feb 2019 17:48:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190212164833.GK32494@hirez.programming.kicks-ass.net>
References: <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190205084857.GK17528@hirez.programming.kicks-ass.net>
 <ec193a66-b395-ed1a-e39c-40fa1ece3f56@intel.com>
 <20190205170415.GG17550@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1902102012520.8784@nanos.tec.linutronix.de>
 <20190211191643.GB103371@romley-ivt3.sc.intel.com>
 <20190212133750.GJ32494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1902121444250.3710@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902121444250.3710@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 02:51:00PM +0100, Thomas Gleixner wrote:
> On Tue, 12 Feb 2019, Peter Zijlstra wrote:
> 
> > On Mon, Feb 11, 2019 at 11:16:43AM -0800, Fenghua Yu wrote:
> > > 4. The feature can be disabled by kernel option
> > > "clearcpuid=split_lock_detection" during early boot time.
> > 
> > IFF clearcpuid lives, it should also employ CPUID faulting and clear it
> > for userspace too.
> 
> We have it already,

D'0h right, I thought that was introduced here, but that's just
extending it to multiple arguments.

> and aside of clearcpuid there are enough things which
> the kernel disables in the kernel view of CPUID, but user space still can
> see them. That's inconsistent, so we really should use CPUID faulting when
> its available.

How about something terrible like this then? _completely_ untested, not
been near a compiler.

---
 arch/x86/include/asm/cpufeature.h |  4 +++
 arch/x86/kernel/cpu/common.c      |  2 ++
 arch/x86/kernel/cpu/cpuid-deps.c  | 52 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c       | 47 ++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/scattered.c   | 15 +++++++++++
 arch/x86/kernel/process.c         |  3 +++
 arch/x86/kernel/traps.c           | 11 +++++++++
 7 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index ce95b8cbd229..a41d147af110 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -226,5 +226,9 @@ static __always_inline __pure bool _static_cpu_has(u16 bit)
 #define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
 					boot_cpu_data.x86_model
 
+extern int cpuid_fault;
+extern u32 scattered_cpuid_mask(u32 leaf, u32 count, enum cpuid_regs_idx reg);
+extern u32 cpuid_cap_mask(u32 leaf, u32 count, enum cpuid_regs_idx reg)
+
 #endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
 #endif /* _ASM_X86_CPUFEATURE_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659..5abc0ef725a7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1499,6 +1499,8 @@ void print_cpu_info(struct cpuinfo_x86 *c)
 		pr_cont(")\n");
 }
 
+int cpuid_fault;
+
 /*
  * clearcpuid= was already parsed in fpu__init_parse_early_param.
  * But we need to keep a dummy __setup around otherwise it would
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 2c0bd38a44ab..3c5a590508a5 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -117,5 +117,57 @@ void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
 
 void setup_clear_cpu_cap(unsigned int feature)
 {
+	if (boot_cpu_has(feature))
+		cpuid_fault = 1;
 	do_clear_cpu_cap(NULL, feature);
 }
+
+u32 cpuid_cap_mask(u32 leaf, u32 count, enum cpuid_regs_idx reg)
+{
+	switch (leaf) {
+	case 0x1:
+		if (reg == CPUID_EDX)
+			return ~cpu_caps_cleared[CPUID_1_EDX];
+		if (reg == CPUID_ECX)
+			return ~cpu_caps_cleared[CPUID_1_ECX];
+		break;
+
+	case 0x6:
+		if (reg == CPUID_EAX)
+			return ~cpu_caps_cleared[CPUID_6_EAX];
+		break;
+
+	case 0x7:
+		if (reg == CPUID_EDX)
+			return ~cpu_caps_cleared[CPUID_7_EDX];
+		if (reg == CPUID_ECX)
+			return ~cpu_caps_cleared[CPUID_7_ECX];
+		if (reg == CPUID_EBX && count == 0)
+			return ~cpu_caps_cleared[CPUID_7_0_EBX];
+		break;
+
+
+	case 0xD:
+		if (reg == CPUID_EAX)
+			return ~cpu_caps_cleared[CPUID_D_EAX];
+		break;
+
+	case 0xF:
+		if (reg == CPUID_EDX) {
+			if (count == 0)
+				return ~cpu_caps_cleared[CPUID_F_0_EDX];
+			if (count == 1)
+				return ~cpu_caps_cleared[CPUID_F_0_EDX];
+		}
+		break;
+
+	case 0x80000007:
+		if (reg == CPUID_EDX) {
+			if (test_bit(X86_FEATURE_CONSTANT_TSC, cpu_caps_cleared))
+				return ~BIT(8);
+		}
+		break;
+	}
+
+	return scattered_cpuid_mask(leaf, count, reg);
+}
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fc3c07fe7df5..85a37239d009 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -626,13 +626,58 @@ static void intel_bsp_resume(struct cpuinfo_x86 *c)
 	init_intel_energy_perf(c);
 }
 
+bool fixup_cpuid_exception(struct pt_regs *regs)
+{
+	unsigned int leaf, count, eax, ebx, ecx, edx;
+	unsigned long seg_base = 0;
+	unsigned char buf[2];
+	int not_copied;
+
+	if (!cpuid_fault)
+		return false;
+
+	if (test_thread_flag(TIF_NOCPUID))
+		return false;
+
+	if (!user_64bit_mode(regs))
+		seg_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
+
+	if (seg_base == -1L)
+		return false;
+
+	not_copied = copy_from_user(buf, (void __user *)(seg_base + regs->ip), sizeof(buf));
+	if (not_copied)
+		return false;
+
+	if (buf[0] != 0x0F || buf[1] != 0xA2) /* CPUID - OF A2 */
+		return false;
+
+	leaf = regs->ax;
+	count = regs->cx;
+
+	cpuid_count(leaf, count, &eax, &ebx, &ecx, &edx);
+
+	regs->ip += 2;
+	regs->ax = eax & cpuid_cap_mask(leaf, count, CPUID_EAX);
+	regs->bx = ebx & cpuid_cap_mask(leaf, count, CPUID_EBX);
+	regs->cx = ecx & cpuid_cap_mask(leaf, count, CPUID_ECX);
+	regs->dx = edx & cpuid_cap_mask(leaf, count, CPUID_EDX);
+
+	return true;
+}
+
 static void init_cpuid_fault(struct cpuinfo_x86 *c)
 {
 	u64 msr;
 
 	if (!rdmsrl_safe(MSR_PLATFORM_INFO, &msr)) {
-		if (msr & MSR_PLATFORM_INFO_CPUID_FAULT)
+		if (msr & MSR_PLATFORM_INFO_CPUID_FAULT) {
 			set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
+			if (cpuid_fault) {
+				this_cpu_or(msr_misc_features_shadow,
+					    MSR_MISC_FEATURES_ENABLES_CPUID_FAULT);
+			}
+		}
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 94aa1c72ca98..faee10864db9 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -62,3 +62,18 @@ void init_scattered_cpuid_features(struct cpuinfo_x86 *c)
 			set_cpu_cap(c, cb->feature);
 	}
 }
+
+u32 scattered_cpuid_mask(u32 leaf, u32 count, enum cpuid_regs_idx reg)
+{
+	const struct cpuid_bit *cb;
+	u32 mask = ~0U;
+
+	for (cp = cpuid_bits; cb->feature; cb++) {
+		if (cb->level == leaf && cb->sub_leaf == count && cb->reg == reg) {
+			if (test_bit(cb->feature, cpu_caps_cleared))
+				mask &= ~BIT(cb->bit);
+		}
+	}
+
+	return mask;
+}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 58ac7be52c7a..2b1dfd7ae65d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -196,6 +196,9 @@ static void set_cpuid_faulting(bool on)
 {
 	u64 msrval;
 
+	if (cpuid_fault)
+		return;
+
 	msrval = this_cpu_read(msr_misc_features_shadow);
 	msrval &= ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
 	msrval |= (on << MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2684a9d11e66..1762848cd2bd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -517,6 +517,12 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
 }
 
+#ifdef CONFIG_CPU_SUP_INTEL
+extern bool fixup_cpuid_exception(struct pt_regs *regs);
+#else
+static inline bool fixup_cpuid_exception(struct pt_regs *regs) { return false; }
+#endif
+
 dotraplinkage void
 do_general_protection(struct pt_regs *regs, long error_code)
 {
@@ -531,6 +537,11 @@ do_general_protection(struct pt_regs *regs, long error_code)
 			return;
 	}
 
+	if (static_cpu_has(X86_FEATURE_CPUID_FAULT)) {
+		if (user_mode(regs) && fixup_cpuid_exception(regs))
+			return;
+	}
+
 	if (v8086_mode(regs)) {
 		local_irq_enable();
 		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
