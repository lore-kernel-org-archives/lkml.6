Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE713C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC9820838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="YNSWHkb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC9820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404427AbeKWDaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:30:20 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:39541 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403948AbeKWDaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1542905408; x=1574441408;
  h=from:to:cc:subject:date:message-id;
  bh=Tu1wFq/IRA6/A/2HiYirBgRoQen9IWAq64v+L2q9MkQ=;
  b=YNSWHkb4bx/6cwZz/OGR2m8mWK3qhS5DhP36N/seEL2gzujONEJ8rzVm
   Mgm61FXtEuztGUNURiZHgeN+lpIxiI/aUR7D/A3XQfu/pLlRyqa/nTxUh
   mlEqPMkrwcbPPaSHa7SK36vvRDCitiSnJdNaVMs5LXxGoCR31oKusoSEE
   Y=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="771919557"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 16:50:07 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wAMGo3tR087602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 22 Nov 2018 16:50:04 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wAMGo1QL008132;
        Thu, 22 Nov 2018 17:50:02 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id wAMGo1al008123;
        Thu, 22 Nov 2018 17:50:01 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kernel-hardening@lists.openwall.com
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Liran Alon <liran.alon@oracle.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Jonathan Adams <jwadams@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC RESEND PATCH 5/6] x86/speculation, kvm: move guest FPU state into process local memory
Date:   Thu, 22 Nov 2018 17:49:38 +0100
Message-Id: <53daa400d6abd95b18ed660b40ebe5f41ef1dfff.1542905228.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542905228.git.jsteckli@amazon.de>
References: <cover.1542905228.git.jsteckli@amazon.de>
In-Reply-To: <cover.1542905228.git.jsteckli@amazon.de>
References: <cover.1542905228.git.jsteckli@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FPU registers contain guest data and must be protected from information
leak vulnerabilities in the kernel.

FPU register state for vCPUs are allocated from the globally-visible
kernel heap. Change this to use process-local memory instead and thus
prevent access (or prefetching) in any other context in the kernel.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
---
 arch/x86/include/asm/kvm_host.h | 10 +++++++-
 arch/x86/kvm/x86.c              | 42 ++++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55e51ff7e421..5dd29bfef77f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -36,6 +36,7 @@
 #include <asm/asm.h>
 #include <asm/kvm_page_track.h>
 #include <asm/hyperv-tlfs.h>
+#include <asm/proclocal.h>
 
 #define KVM_MAX_VCPUS 288
 #define KVM_SOFT_MAX_VCPUS 240
@@ -530,7 +531,13 @@ struct kvm_vcpu_hv {
 	cpumask_t tlb_flush;
 };
 
+struct kvm_vcpu_arch_hidden {
+	struct fpu guest_fpu;
+};
+
 struct kvm_vcpu_arch {
+	struct proclocal hidden;
+
 	/*
 	 * rip and regs accesses must go through
 	 * kvm_{register,rip}_{read,write} functions.
@@ -611,7 +618,6 @@ struct kvm_vcpu_arch {
 	 * host PRKU bits.
 	 */
 	struct fpu user_fpu;
-	struct fpu guest_fpu;
 
 	u64 xcr0;
 	u64 guest_supported_xcr0;
@@ -1580,4 +1586,6 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
 #define put_smstate(type, buf, offset, val)                      \
 	*(type *)((buf) + (offset) - 0x7e00) = val
 
+struct kvm_vcpu_arch_hidden *kvm_arch_vcpu_hidden_get(struct kvm_vcpu *vcpu);
+
 #endif /* _ASM_X86_KVM_HOST_H */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 66d66d77caee..941fa3209607 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -37,6 +37,7 @@
 #include <linux/vmalloc.h>
 #include <linux/export.h>
 #include <linux/moduleparam.h>
+#include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/highmem.h>
 #include <linux/iommu.h>
@@ -69,6 +70,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
+#include <asm/proclocal.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -3630,7 +3632,7 @@ static int kvm_vcpu_ioctl_x86_set_debugregs(struct kvm_vcpu *vcpu,
 
 static void fill_xsave(u8 *dest, struct kvm_vcpu *vcpu)
 {
-	struct xregs_state *xsave = &vcpu->arch.guest_fpu.state.xsave;
+	struct xregs_state *xsave = &kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state.xsave;
 	u64 xstate_bv = xsave->header.xfeatures;
 	u64 valid;
 
@@ -3672,7 +3674,7 @@ static void fill_xsave(u8 *dest, struct kvm_vcpu *vcpu)
 
 static void load_xsave(struct kvm_vcpu *vcpu, u8 *src)
 {
-	struct xregs_state *xsave = &vcpu->arch.guest_fpu.state.xsave;
+	struct xregs_state *xsave = &kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state.xsave;
 	u64 xstate_bv = *(u64 *)(src + XSAVE_HDR_OFFSET);
 	u64 valid;
 
@@ -3720,7 +3722,7 @@ static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
 		fill_xsave((u8 *) guest_xsave->region, vcpu);
 	} else {
 		memcpy(guest_xsave->region,
-			&vcpu->arch.guest_fpu.state.fxsave,
+			&kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state.fxsave,
 			sizeof(struct fxregs_state));
 		*(u64 *)&guest_xsave->region[XSAVE_HDR_OFFSET / sizeof(u32)] =
 			XFEATURE_MASK_FPSSE;
@@ -3750,7 +3752,7 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 		if (xstate_bv & ~XFEATURE_MASK_FPSSE ||
 			mxcsr & ~mxcsr_feature_mask)
 			return -EINVAL;
-		memcpy(&vcpu->arch.guest_fpu.state.fxsave,
+		memcpy(&kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state.fxsave,
 			guest_xsave->region, sizeof(struct fxregs_state));
 	}
 	return 0;
@@ -7996,7 +7998,7 @@ static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 	preempt_disable();
 	copy_fpregs_to_fpstate(&vcpu->arch.user_fpu);
 	/* PKRU is separately restored in kvm_x86_ops->run.  */
-	__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu.state,
+	__copy_kernel_to_fpregs(&kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state,
 				~XFEATURE_MASK_PKRU);
 	preempt_enable();
 	trace_kvm_fpu(1);
@@ -8006,7 +8008,7 @@ static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
-	copy_fpregs_to_fpstate(&vcpu->arch.guest_fpu);
+	copy_fpregs_to_fpstate(&kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu);
 	copy_kernel_to_fpregs(&vcpu->arch.user_fpu.state);
 	preempt_enable();
 	++vcpu->stat.fpu_reload;
@@ -8501,7 +8503,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 	vcpu_load(vcpu);
 
-	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
+	fxsave = &kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state.fxsave;
 	memcpy(fpu->fpr, fxsave->st_space, 128);
 	fpu->fcw = fxsave->cwd;
 	fpu->fsw = fxsave->swd;
@@ -8521,8 +8523,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 	vcpu_load(vcpu);
 
-	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
-
+	fxsave = &kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state.fxsave;
 	memcpy(fxsave->st_space, fpu->fpr, 128);
 	fxsave->cwd = fpu->fcw;
 	fxsave->swd = fpu->fsw;
@@ -8577,9 +8578,9 @@ static int sync_regs(struct kvm_vcpu *vcpu)
 
 static void fx_init(struct kvm_vcpu *vcpu)
 {
-	fpstate_init(&vcpu->arch.guest_fpu.state);
+	fpstate_init(&kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state);
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		vcpu->arch.guest_fpu.state.xsave.header.xcomp_bv =
+		kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state.xsave.header.xcomp_bv =
 			host_xcr0 | XSTATE_COMPACTION_ENABLED;
 
 	/*
@@ -8703,11 +8704,11 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		 */
 		if (init_event)
 			kvm_put_guest_fpu(vcpu);
-		mpx_state_buffer = get_xsave_addr(&vcpu->arch.guest_fpu.state.xsave,
+		mpx_state_buffer = get_xsave_addr(&kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state.xsave,
 					XFEATURE_MASK_BNDREGS);
 		if (mpx_state_buffer)
 			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndreg_state));
-		mpx_state_buffer = get_xsave_addr(&vcpu->arch.guest_fpu.state.xsave,
+		mpx_state_buffer = get_xsave_addr(&kvm_arch_vcpu_hidden_get(vcpu)->guest_fpu.state.xsave,
 					XFEATURE_MASK_BNDCSR);
 		if (mpx_state_buffer)
 			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndcsr));
@@ -8892,11 +8893,21 @@ bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu)
 struct static_key kvm_no_apic_vcpu __read_mostly;
 EXPORT_SYMBOL_GPL(kvm_no_apic_vcpu);
 
+struct kvm_vcpu_arch_hidden *kvm_arch_vcpu_hidden_get(struct kvm_vcpu *vcpu)
+{
+	return proclocal_get(&vcpu->arch.hidden, struct kvm_vcpu_arch_hidden);
+}
+EXPORT_SYMBOL_GPL(kvm_arch_vcpu_hidden_get);
+
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct page *page;
 	int r;
 
+	r = kalloc_proclocal(&vcpu->arch.hidden, sizeof(struct kvm_vcpu_arch_hidden));
+	if (r)
+		goto fail;
+
 	vcpu->arch.apicv_active = kvm_x86_ops->get_enable_apicv(vcpu);
 	vcpu->arch.emulate_ctxt.ops = &emulate_ops;
 	if (!irqchip_in_kernel(vcpu->kvm) || kvm_vcpu_is_reset_bsp(vcpu))
@@ -8907,7 +8918,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!page) {
 		r = -ENOMEM;
-		goto fail;
+		goto fail_free_hidden;
 	}
 	vcpu->arch.pio_data = page_address(page);
 
@@ -8963,6 +8974,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	kvm_mmu_destroy(vcpu);
 fail_free_pio_data:
 	free_page((unsigned long)vcpu->arch.pio_data);
+fail_free_hidden:
+	kfree_proclocal(&vcpu->arch.hidden);
 fail:
 	return r;
 }
@@ -8981,6 +8994,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 	free_page((unsigned long)vcpu->arch.pio_data);
 	if (!lapic_in_kernel(vcpu))
 		static_key_slow_dec(&kvm_no_apic_vcpu);
+	kfree_proclocal(&vcpu->arch.hidden);
 }
 
 void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
-- 
2.17.1

