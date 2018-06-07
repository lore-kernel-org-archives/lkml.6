Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BcAZL6BJGVvKTwAAmS7hNA
	; Thu, 07 Jun 2018 15:05:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3B622608B8; Thu,  7 Jun 2018 15:05:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E96306063F;
	Thu,  7 Jun 2018 15:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E96306063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936067AbeFGPFp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:05:45 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41563 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934945AbeFGPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:04:03 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbz-0005Zk-SP; Thu, 07 Jun 2018 15:10:00 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002jB-FB; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.621635311@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 038/410] KVM: x86: pass host_initiated to functions
 that read MSRs
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 609e36d372ad9329269e4a1467bd35311893d1d6 upstream.

SMBASE is only readable from SMM for the VCPU, but it must be always
accessible if userspace is accessing it.  Thus, all functions that
read MSRs are changed to accept a struct msr_data; the host_initiated
and index fields are pre-initialized, while the data field is filled
on return.

Reviewed-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[carnil: backport to 3.16, adjust context]
[bwh: Adjust context again after update to 3.16.51]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/kvm_host.h |   6 +-
 arch/x86/kvm/svm.c              |  52 ++++++++--------
 arch/x86/kvm/vmx.c              |  51 +++++++--------
 arch/x86/kvm/x86.c              | 106 ++++++++++++++++++++------------
 4 files changed, 118 insertions(+), 97 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -683,7 +683,7 @@ struct kvm_x86_ops {
 	void (*vcpu_put)(struct kvm_vcpu *vcpu);
 
 	void (*update_bp_intercept)(struct kvm_vcpu *vcpu);
-	int (*get_msr)(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata);
+	int (*get_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
 	int (*set_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
 	u64 (*get_segment_base)(struct kvm_vcpu *vcpu, int seg);
 	void (*get_segment)(struct kvm_vcpu *vcpu,
@@ -853,7 +853,7 @@ static inline int emulate_instruction(st
 
 void kvm_enable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
-int kvm_get_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *data);
+int kvm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
 int kvm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
 
 struct x86_emulate_ctxt;
@@ -881,7 +881,7 @@ void kvm_lmsw(struct kvm_vcpu *vcpu, uns
 void kvm_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l);
 int kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
 
-int kvm_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata);
+int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 
 unsigned long kvm_get_rflags(struct kvm_vcpu *vcpu);
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3037,42 +3037,42 @@ u64 svm_read_l1_tsc(struct kvm_vcpu *vcp
 		svm_scale_tsc(vcpu, host_tsc);
 }
 
-static int svm_get_msr(struct kvm_vcpu *vcpu, unsigned ecx, u64 *data)
+static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	switch (ecx) {
+	switch (msr_info->index) {
 	case MSR_IA32_TSC: {
-		*data = svm->vmcb->control.tsc_offset +
+		msr_info->data = svm->vmcb->control.tsc_offset +
 			svm_scale_tsc(vcpu, native_read_tsc());
 
 		break;
 	}
 	case MSR_STAR:
-		*data = svm->vmcb->save.star;
+		msr_info->data = svm->vmcb->save.star;
 		break;
 #ifdef CONFIG_X86_64
 	case MSR_LSTAR:
-		*data = svm->vmcb->save.lstar;
+		msr_info->data = svm->vmcb->save.lstar;
 		break;
 	case MSR_CSTAR:
-		*data = svm->vmcb->save.cstar;
+		msr_info->data = svm->vmcb->save.cstar;
 		break;
 	case MSR_KERNEL_GS_BASE:
-		*data = svm->vmcb->save.kernel_gs_base;
+		msr_info->data = svm->vmcb->save.kernel_gs_base;
 		break;
 	case MSR_SYSCALL_MASK:
-		*data = svm->vmcb->save.sfmask;
+		msr_info->data = svm->vmcb->save.sfmask;
 		break;
 #endif
 	case MSR_IA32_SYSENTER_CS:
-		*data = svm->vmcb->save.sysenter_cs;
+		msr_info->data = svm->vmcb->save.sysenter_cs;
 		break;
 	case MSR_IA32_SYSENTER_EIP:
-		*data = svm->sysenter_eip;
+		msr_info->data = svm->sysenter_eip;
 		break;
 	case MSR_IA32_SYSENTER_ESP:
-		*data = svm->sysenter_esp;
+		msr_info->data = svm->sysenter_esp;
 		break;
 	/*
 	 * Nobody will change the following 5 values in the VMCB so we can
@@ -3080,31 +3080,31 @@ static int svm_get_msr(struct kvm_vcpu *
 	 * implemented.
 	 */
 	case MSR_IA32_DEBUGCTLMSR:
-		*data = svm->vmcb->save.dbgctl;
+		msr_info->data = svm->vmcb->save.dbgctl;
 		break;
 	case MSR_IA32_LASTBRANCHFROMIP:
-		*data = svm->vmcb->save.br_from;
+		msr_info->data = svm->vmcb->save.br_from;
 		break;
 	case MSR_IA32_LASTBRANCHTOIP:
-		*data = svm->vmcb->save.br_to;
+		msr_info->data = svm->vmcb->save.br_to;
 		break;
 	case MSR_IA32_LASTINTFROMIP:
-		*data = svm->vmcb->save.last_excp_from;
+		msr_info->data = svm->vmcb->save.last_excp_from;
 		break;
 	case MSR_IA32_LASTINTTOIP:
-		*data = svm->vmcb->save.last_excp_to;
+		msr_info->data = svm->vmcb->save.last_excp_to;
 		break;
 	case MSR_VM_HSAVE_PA:
-		*data = svm->nested.hsave_msr;
+		msr_info->data = svm->nested.hsave_msr;
 		break;
 	case MSR_VM_CR:
-		*data = svm->nested.vm_cr_msr;
+		msr_info->data = svm->nested.vm_cr_msr;
 		break;
 	case MSR_IA32_UCODE_REV:
-		*data = 0x01000065;
+		msr_info->data = 0x01000065;
 		break;
 	default:
-		return kvm_get_msr_common(vcpu, ecx, data);
+		return kvm_get_msr_common(vcpu, msr_info);
 	}
 	return 0;
 }
@@ -3112,16 +3112,18 @@ static int svm_get_msr(struct kvm_vcpu *
 static int rdmsr_interception(struct vcpu_svm *svm)
 {
 	u32 ecx = svm->vcpu.arch.regs[VCPU_REGS_RCX];
-	u64 data;
+	struct msr_data msr_info;
 
-	if (svm_get_msr(&svm->vcpu, ecx, &data)) {
+	msr_info.index = ecx;
+	msr_info.host_initiated = false;
+	if (svm_get_msr(&svm->vcpu, &msr_info)) {
 		trace_kvm_msr_read_ex(ecx);
 		kvm_inject_gp(&svm->vcpu, 0);
 	} else {
-		trace_kvm_msr_read(ecx, data);
+		trace_kvm_msr_read(ecx, msr_info.data);
 
-		svm->vcpu.arch.regs[VCPU_REGS_RAX] = data & 0xffffffff;
-		svm->vcpu.arch.regs[VCPU_REGS_RDX] = data >> 32;
+		svm->vcpu.arch.regs[VCPU_REGS_RAX] = msr_info.data & 0xffffffff;
+		svm->vcpu.arch.regs[VCPU_REGS_RDX] = msr_info.data >> 32;
 		svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 		skip_emulated_instruction(&svm->vcpu);
 	}
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2493,71 +2493,64 @@ static int vmx_get_vmx_msr(struct kvm_vc
  * Returns 0 on success, non-0 otherwise.
  * Assumes vcpu_load() was already called.
  */
-static int vmx_get_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata)
+static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
-	u64 data;
 	struct shared_msr_entry *msr;
 
-	if (!pdata) {
-		printk(KERN_ERR "BUG: get_msr called with NULL pdata\n");
-		return -EINVAL;
-	}
-
-	switch (msr_index) {
+	switch (msr_info->index) {
 #ifdef CONFIG_X86_64
 	case MSR_FS_BASE:
-		data = vmcs_readl(GUEST_FS_BASE);
+		msr_info->data = vmcs_readl(GUEST_FS_BASE);
 		break;
 	case MSR_GS_BASE:
-		data = vmcs_readl(GUEST_GS_BASE);
+		msr_info->data = vmcs_readl(GUEST_GS_BASE);
 		break;
 	case MSR_KERNEL_GS_BASE:
 		vmx_load_host_state(to_vmx(vcpu));
-		data = to_vmx(vcpu)->msr_guest_kernel_gs_base;
+		msr_info->data = to_vmx(vcpu)->msr_guest_kernel_gs_base;
 		break;
 #endif
 	case MSR_EFER:
-		return kvm_get_msr_common(vcpu, msr_index, pdata);
+		return kvm_get_msr_common(vcpu, msr_info);
 	case MSR_IA32_TSC:
-		data = guest_read_tsc();
+		msr_info->data = guest_read_tsc();
 		break;
 	case MSR_IA32_SYSENTER_CS:
-		data = vmcs_read32(GUEST_SYSENTER_CS);
+		msr_info->data = vmcs_read32(GUEST_SYSENTER_CS);
 		break;
 	case MSR_IA32_SYSENTER_EIP:
-		data = vmcs_readl(GUEST_SYSENTER_EIP);
+		msr_info->data = vmcs_readl(GUEST_SYSENTER_EIP);
 		break;
 	case MSR_IA32_SYSENTER_ESP:
-		data = vmcs_readl(GUEST_SYSENTER_ESP);
+		msr_info->data = vmcs_readl(GUEST_SYSENTER_ESP);
 		break;
 	case MSR_IA32_BNDCFGS:
 		if (!vmx_mpx_supported() || !guest_cpuid_has_mpx(vcpu))
 			return 1;
-		data = vmcs_read64(GUEST_BNDCFGS);
+		msr_info->data = vmcs_read64(GUEST_BNDCFGS);
 		break;
 	case MSR_IA32_FEATURE_CONTROL:
 		if (!nested_vmx_allowed(vcpu))
 			return 1;
-		data = to_vmx(vcpu)->nested.msr_ia32_feature_control;
+		msr_info->data = to_vmx(vcpu)->nested.msr_ia32_feature_control;
 		break;
 	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
 		if (!nested_vmx_allowed(vcpu))
 			return 1;
-		return vmx_get_vmx_msr(vcpu, msr_index, pdata);
+		return vmx_get_vmx_msr(vcpu, msr_info->index, &msr_info->data);
 	case MSR_TSC_AUX:
 		if (!to_vmx(vcpu)->rdtscp_enabled)
 			return 1;
 		/* Otherwise falls through */
 	default:
-		msr = find_msr_entry(to_vmx(vcpu), msr_index);
+		msr = find_msr_entry(to_vmx(vcpu), msr_info->index);
 		if (msr) {
-			data = msr->data;
+			msr_info->data = msr->data;
 			break;
 		}
-		return kvm_get_msr_common(vcpu, msr_index, pdata);
+		return kvm_get_msr_common(vcpu, msr_info);
 	}
 
-	*pdata = data;
 	return 0;
 }
 
@@ -5261,19 +5254,21 @@ static int handle_cpuid(struct kvm_vcpu
 static int handle_rdmsr(struct kvm_vcpu *vcpu)
 {
 	u32 ecx = vcpu->arch.regs[VCPU_REGS_RCX];
-	u64 data;
+	struct msr_data msr_info;
 
-	if (vmx_get_msr(vcpu, ecx, &data)) {
+	msr_info.index = ecx;
+	msr_info.host_initiated = false;
+	if (vmx_get_msr(vcpu, &msr_info)) {
 		trace_kvm_msr_read_ex(ecx);
 		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
 
-	trace_kvm_msr_read(ecx, data);
+	trace_kvm_msr_read(ecx, msr_info.data);
 
 	/* FIXME: handling of bits 32:63 of rax, rdx */
-	vcpu->arch.regs[VCPU_REGS_RAX] = data & -1u;
-	vcpu->arch.regs[VCPU_REGS_RDX] = (data >> 32) & -1u;
+	vcpu->arch.regs[VCPU_REGS_RAX] = msr_info.data & -1u;
+	vcpu->arch.regs[VCPU_REGS_RDX] = (msr_info.data >> 32) & -1u;
 	skip_emulated_instruction(vcpu);
 	return 1;
 }
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -999,6 +999,21 @@ EXPORT_SYMBOL_GPL(kvm_set_msr);
 /*
  * Adapt set_msr() to msr_io()'s calling convention
  */
+static int do_get_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+{
+	struct msr_data msr;
+	int r;
+
+	msr.index = index;
+	msr.host_initiated = true;
+	r = kvm_get_msr(vcpu, &msr);
+	if (r)
+		return r;
+
+	*data = msr.data;
+	return 0;
+}
+
 static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 {
 	struct msr_data msr;
@@ -2280,9 +2295,9 @@ EXPORT_SYMBOL_GPL(kvm_set_msr_common);
  * Returns 0 on success, non-0 otherwise.
  * Assumes vcpu_load() was already called.
  */
-int kvm_get_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata)
+int kvm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 {
-	return kvm_x86_ops->get_msr(vcpu, msr_index, pdata);
+	return kvm_x86_ops->get_msr(vcpu, msr);
 }
 
 static int get_msr_mtrr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
@@ -2418,11 +2433,11 @@ static int get_msr_hyperv(struct kvm_vcp
 	return 0;
 }
 
-int kvm_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
+int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	u64 data;
 
-	switch (msr) {
+	switch (msr_info->index) {
 	case MSR_IA32_PLATFORM_ID:
 	case MSR_IA32_EBL_CR_POWERON:
 	case MSR_IA32_DEBUGCTLMSR:
@@ -2441,26 +2456,26 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_NB_CFG:
 	case MSR_FAM10H_MMIO_CONF_BASE:
 	case MSR_AMD64_BU_CFG2:
-		data = 0;
+		msr_info->data = 0;
 		break;
 	case MSR_P6_PERFCTR0:
 	case MSR_P6_PERFCTR1:
 	case MSR_P6_EVNTSEL0:
 	case MSR_P6_EVNTSEL1:
-		if (kvm_pmu_msr(vcpu, msr))
-			return kvm_pmu_get_msr(vcpu, msr, pdata);
-		data = 0;
+		if (kvm_pmu_msr(vcpu, msr_info->index))
+			return kvm_pmu_get_msr(vcpu, msr_info->index, &msr_info->data);
+		msr_info->data = 0;
 		break;
 	case MSR_IA32_UCODE_REV:
-		data = 0x100000000ULL;
+		msr_info->data = 0x100000000ULL;
 		break;
 	case MSR_MTRRcap:
-		data = 0x500 | KVM_NR_VAR_MTRR;
+		msr_info->data = 0x500 | KVM_NR_VAR_MTRR;
 		break;
 	case 0x200 ... 0x2ff:
-		return get_msr_mtrr(vcpu, msr, pdata);
+		return get_msr_mtrr(vcpu, msr_info->index, &msr_info->data);
 	case 0xcd: /* fsb frequency */
-		data = 3;
+		msr_info->data = 3;
 		break;
 		/*
 		 * MSR_EBC_FREQUENCY_ID
@@ -2474,48 +2489,48 @@ int kvm_get_msr_common(struct kvm_vcpu *
 		 * multiplying by zero otherwise.
 		 */
 	case MSR_EBC_FREQUENCY_ID:
-		data = 1 << 24;
+		msr_info->data = 1 << 24;
 		break;
 	case MSR_IA32_APICBASE:
-		data = kvm_get_apic_base(vcpu);
+		msr_info->data = kvm_get_apic_base(vcpu);
 		break;
 	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
-		return kvm_x2apic_msr_read(vcpu, msr, pdata);
+		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
 		break;
 	case MSR_IA32_TSCDEADLINE:
-		data = kvm_get_lapic_tscdeadline_msr(vcpu);
+		msr_info->data = kvm_get_lapic_tscdeadline_msr(vcpu);
 		break;
 	case MSR_IA32_TSC_ADJUST:
-		data = (u64)vcpu->arch.ia32_tsc_adjust_msr;
+		msr_info->data = (u64)vcpu->arch.ia32_tsc_adjust_msr;
 		break;
 	case MSR_IA32_MISC_ENABLE:
-		data = vcpu->arch.ia32_misc_enable_msr;
+		msr_info->data = vcpu->arch.ia32_misc_enable_msr;
 		break;
 	case MSR_IA32_PERF_STATUS:
 		/* TSC increment by tick */
-		data = 1000ULL;
+		msr_info->data = 1000ULL;
 		/* CPU multiplier */
 		data |= (((uint64_t)4ULL) << 40);
 		break;
 	case MSR_EFER:
-		data = vcpu->arch.efer;
+		msr_info->data = vcpu->arch.efer;
 		break;
 	case MSR_KVM_WALL_CLOCK:
 	case MSR_KVM_WALL_CLOCK_NEW:
-		data = vcpu->kvm->arch.wall_clock;
+		msr_info->data = vcpu->kvm->arch.wall_clock;
 		break;
 	case MSR_KVM_SYSTEM_TIME:
 	case MSR_KVM_SYSTEM_TIME_NEW:
-		data = vcpu->arch.time;
+		msr_info->data = vcpu->arch.time;
 		break;
 	case MSR_KVM_ASYNC_PF_EN:
-		data = vcpu->arch.apf.msr_val;
+		msr_info->data = vcpu->arch.apf.msr_val;
 		break;
 	case MSR_KVM_STEAL_TIME:
-		data = vcpu->arch.st.msr_val;
+		msr_info->data = vcpu->arch.st.msr_val;
 		break;
 	case MSR_KVM_PV_EOI_EN:
-		data = vcpu->arch.pv_eoi.msr_val;
+		msr_info->data = vcpu->arch.pv_eoi.msr_val;
 		break;
 	case MSR_IA32_P5_MC_ADDR:
 	case MSR_IA32_P5_MC_TYPE:
@@ -2523,7 +2538,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_IA32_MCG_CTL:
 	case MSR_IA32_MCG_STATUS:
 	case MSR_IA32_MC0_CTL ... MSR_IA32_MC0_CTL + 4 * KVM_MAX_MCE_BANKS - 1:
-		return get_msr_mce(vcpu, msr, pdata);
+		return get_msr_mce(vcpu, msr_info->index, &msr_info->data);
 	case MSR_K7_CLK_CTL:
 		/*
 		 * Provide expected ramp-up count for K7. All other
@@ -2534,17 +2549,17 @@ int kvm_get_msr_common(struct kvm_vcpu *
 		 * type 6, model 8 and higher from exploding due to
 		 * the rdmsr failing.
 		 */
-		data = 0x20000000;
+		msr_info->data = 0x20000000;
 		break;
 	case HV_X64_MSR_GUEST_OS_ID ... HV_X64_MSR_SINT15:
-		if (kvm_hv_msr_partition_wide(msr)) {
+		if (kvm_hv_msr_partition_wide(msr_info->index)) {
 			int r;
 			mutex_lock(&vcpu->kvm->lock);
-			r = get_msr_hyperv_pw(vcpu, msr, pdata);
+			r = get_msr_hyperv_pw(vcpu, msr_info->index, &msr_info->data);
 			mutex_unlock(&vcpu->kvm->lock);
 			return r;
 		} else
-			return get_msr_hyperv(vcpu, msr, pdata);
+			return get_msr_hyperv(vcpu, msr_info->index, &msr_info->data);
 		break;
 	case MSR_IA32_BBL_CR_CTL3:
 		/* This legacy MSR exists but isn't fully documented in current
@@ -2557,31 +2572,30 @@ int kvm_get_msr_common(struct kvm_vcpu *
 		 * L2 cache control register 3: 64GB range, 256KB size,
 		 * enabled, latency 0x1, configured
 		 */
-		data = 0xbe702111;
+		msr_info->data = 0xbe702111;
 		break;
 	case MSR_AMD64_OSVW_ID_LENGTH:
 		if (!guest_cpuid_has_osvw(vcpu))
 			return 1;
-		data = vcpu->arch.osvw.length;
+		msr_info->data = vcpu->arch.osvw.length;
 		break;
 	case MSR_AMD64_OSVW_STATUS:
 		if (!guest_cpuid_has_osvw(vcpu))
 			return 1;
-		data = vcpu->arch.osvw.status;
+		msr_info->data = vcpu->arch.osvw.status;
 		break;
 	default:
-		if (kvm_pmu_msr(vcpu, msr))
-			return kvm_pmu_get_msr(vcpu, msr, pdata);
+		if (kvm_pmu_msr(vcpu, msr_info->index))
+			return kvm_pmu_get_msr(vcpu, msr_info->index, &msr_info->data);
 		if (!ignore_msrs) {
-			vcpu_unimpl(vcpu, "unhandled rdmsr: 0x%x\n", msr);
+			vcpu_unimpl(vcpu, "unhandled rdmsr: 0x%x\n", msr_info->index);
 			return 1;
 		} else {
-			vcpu_unimpl(vcpu, "ignored rdmsr: 0x%x\n", msr);
-			data = 0;
+			vcpu_unimpl(vcpu, "ignored rdmsr: 0x%x\n", msr_info->index);
+			msr_info->data = 0;
 		}
 		break;
 	}
-	*pdata = data;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kvm_get_msr_common);
@@ -3290,7 +3304,7 @@ long kvm_arch_vcpu_ioctl(struct file *fi
 		break;
 	}
 	case KVM_GET_MSRS:
-		r = msr_io(vcpu, argp, kvm_get_msr, 1);
+		r = msr_io(vcpu, argp, do_get_msr, 1);
 		break;
 	case KVM_SET_MSRS:
 		r = msr_io(vcpu, argp, do_set_msr, 0);
@@ -4810,7 +4824,17 @@ static void emulator_set_segment(struct
 static int emulator_get_msr(struct x86_emulate_ctxt *ctxt,
 			    u32 msr_index, u64 *pdata)
 {
-	return kvm_get_msr(emul_to_vcpu(ctxt), msr_index, pdata);
+	struct msr_data msr;
+	int r;
+
+	msr.index = msr_index;
+	msr.host_initiated = false;
+	r = kvm_get_msr(emul_to_vcpu(ctxt), &msr);
+	if (r)
+		return r;
+
+	*pdata = msr.data;
+	return 0;
 }
 
 static int emulator_set_msr(struct x86_emulate_ctxt *ctxt,
