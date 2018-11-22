Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660D3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1CF20838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="nV17SHRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1CF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405999AbeKWDaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:30:23 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:39565 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404359AbeKWDaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1542905411; x=1574441411;
  h=from:to:cc:subject:date:message-id;
  bh=HPgIZQKZrYaysE0I6hPLeVIB9cTT1aK3/gzMyh66vww=;
  b=nV17SHRiq7uVFr1sjv13soLphsfoxl0tZVaUIpIdmUu+lWcDAGhIVFy7
   GnDW17/Nk45yuAC25Hi+1x5bQsBC8+IzzqLAe7Axwp998ln8kcXZllvQ4
   gsnVM2JrldjETz0QJoNOqE+RiSoa1y2kBOz1Sxy9KUvDe6oD8MX8FfWH2
   0=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="771919563"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 16:50:11 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wAMGo48P104633
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 22 Nov 2018 16:50:06 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wAMGo3Rp008148;
        Thu, 22 Nov 2018 17:50:03 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id wAMGo2Zr008135;
        Thu, 22 Nov 2018 17:50:02 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kernel-hardening@lists.openwall.com
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Liran Alon <liran.alon@oracle.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Jonathan Adams <jwadams@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC RESEND PATCH 6/6] x86/speculation, kvm: move gprs to process local storage
Date:   Thu, 22 Nov 2018 17:49:39 +0100
Message-Id: <a262873a233b9918e63d57cf20bd9a303d356add.1542905228.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542905228.git.jsteckli@amazon.de>
References: <cover.1542905228.git.jsteckli@amazon.de>
In-Reply-To: <cover.1542905228.git.jsteckli@amazon.de>
References: <cover.1542905228.git.jsteckli@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

General-purpose registers (GPRs) contain guest data and must be protected
from information leak vulnerabilities in the kernel.

Move GPRs into process local memory and change the VMX and SVM world
switch and related code accordingly.

Note: Only Intel VMX support is tested.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
---
 arch/x86/include/asm/kvm_host.h |  11 +--
 arch/x86/kvm/kvm_cache_regs.h   |   4 +-
 arch/x86/kvm/svm.c              | 132 ++++++++++++++++-------------
 arch/x86/kvm/vmx.c              | 142 ++++++++++++++++++--------------
 arch/x86/kvm/x86.c              |   3 +-
 5 files changed, 164 insertions(+), 128 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5dd29bfef77f..bffd3e35232c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -532,17 +532,18 @@ struct kvm_vcpu_hv {
 };
 
 struct kvm_vcpu_arch_hidden {
+	/*
+	 * rip and regs accesses must go through
+	 * kvm_{register,rip}_{read,write} functions.
+	 */
+	unsigned long regs[NR_VCPU_REGS];
+
 	struct fpu guest_fpu;
 };
 
 struct kvm_vcpu_arch {
 	struct proclocal hidden;
 
-	/*
-	 * rip and regs accesses must go through
-	 * kvm_{register,rip}_{read,write} functions.
-	 */
-	unsigned long regs[NR_VCPU_REGS];
 	u32 regs_avail;
 	u32 regs_dirty;
 
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 9619dcc2b325..b270e38abb5f 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -13,14 +13,14 @@ static inline unsigned long kvm_register_read(struct kvm_vcpu *vcpu,
 	if (!test_bit(reg, (unsigned long *)&vcpu->arch.regs_avail))
 		kvm_x86_ops->cache_reg(vcpu, reg);
 
-	return vcpu->arch.regs[reg];
+	return kvm_arch_vcpu_hidden_get(vcpu)->regs[reg];
 }
 
 static inline void kvm_register_write(struct kvm_vcpu *vcpu,
 				      enum kvm_reg reg,
 				      unsigned long val)
 {
-	vcpu->arch.regs[reg] = val;
+	kvm_arch_vcpu_hidden_get(vcpu)->regs[reg] = val;
 	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_dirty);
 	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
 }
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f416f5c7f2ae..ca86efcdfc49 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1568,7 +1568,7 @@ static void init_vmcb(struct vcpu_svm *svm)
 	save->dr6 = 0xffff0ff0;
 	kvm_set_rflags(&svm->vcpu, 2);
 	save->rip = 0x0000fff0;
-	svm->vcpu.arch.regs[VCPU_REGS_RIP] = save->rip;
+	kvm_arch_vcpu_hidden_get(&svm->vcpu)->regs[VCPU_REGS_RIP] = save->rip;
 
 	/*
 	 * svm_set_cr0() sets PG and WP and clears NW and CD on save->cr0.
@@ -3094,7 +3094,7 @@ static int nested_svm_exit_handled_msr(struct vcpu_svm *svm)
 	if (!(svm->nested.intercept & (1ULL << INTERCEPT_MSR_PROT)))
 		return NESTED_EXIT_HOST;
 
-	msr    = svm->vcpu.arch.regs[VCPU_REGS_RCX];
+	msr    = kvm_arch_vcpu_hidden_get(&svm->vcpu)->regs[VCPU_REGS_RCX];
 	offset = svm_msrpm_offset(msr);
 	write  = svm->vmcb->control.exit_info_1 & 1;
 	mask   = 1 << ((2 * (msr & 0xf)) + write);
@@ -5548,10 +5548,11 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	unsigned long *regs = kvm_arch_vcpu_hidden_get(vcpu)->regs;
 
-	svm->vmcb->save.rax = vcpu->arch.regs[VCPU_REGS_RAX];
-	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
-	svm->vmcb->save.rip = vcpu->arch.regs[VCPU_REGS_RIP];
+	svm->vmcb->save.rax = regs[VCPU_REGS_RAX];
+	svm->vmcb->save.rsp = regs[VCPU_REGS_RSP];
+	svm->vmcb->save.rip = regs[VCPU_REGS_RIP];
 
 	/*
 	 * A vmexit emulation is required before the vcpu can be executed
@@ -5595,23 +5596,24 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	local_irq_enable();
 
 	asm volatile (
-		"push %%" _ASM_BP "; \n\t"
-		"mov %c[rbx](%[svm]), %%" _ASM_BX " \n\t"
-		"mov %c[rcx](%[svm]), %%" _ASM_CX " \n\t"
-		"mov %c[rdx](%[svm]), %%" _ASM_DX " \n\t"
-		"mov %c[rsi](%[svm]), %%" _ASM_SI " \n\t"
-		"mov %c[rdi](%[svm]), %%" _ASM_DI " \n\t"
-		"mov %c[rbp](%[svm]), %%" _ASM_BP " \n\t"
+		"push %%" _ASM_BP "; push %%" _ASM_CX "; \n\t"
+		"push $0 \n\t"	/* placeholder for guest rcx */
+		"mov %c[rbx](%[regs]), %%" _ASM_BX " \n\t"
+		"mov %c[rdx](%[regs]), %%" _ASM_DX " \n\t"
+		"mov %c[rsi](%[regs]), %%" _ASM_SI " \n\t"
+		"mov %c[rdi](%[regs]), %%" _ASM_DI " \n\t"
+		"mov %c[rbp](%[regs]), %%" _ASM_BP " \n\t"
 #ifdef CONFIG_X86_64
-		"mov %c[r8](%[svm]),  %%r8  \n\t"
-		"mov %c[r9](%[svm]),  %%r9  \n\t"
-		"mov %c[r10](%[svm]), %%r10 \n\t"
-		"mov %c[r11](%[svm]), %%r11 \n\t"
-		"mov %c[r12](%[svm]), %%r12 \n\t"
-		"mov %c[r13](%[svm]), %%r13 \n\t"
-		"mov %c[r14](%[svm]), %%r14 \n\t"
-		"mov %c[r15](%[svm]), %%r15 \n\t"
+		"mov %c[r8](%[regs]),  %%r8  \n\t"
+		"mov %c[r9](%[regs]),  %%r9  \n\t"
+		"mov %c[r10](%[regs]), %%r10 \n\t"
+		"mov %c[r11](%[regs]), %%r11 \n\t"
+		"mov %c[r12](%[regs]), %%r12 \n\t"
+		"mov %c[r13](%[regs]), %%r13 \n\t"
+		"mov %c[r14](%[regs]), %%r14 \n\t"
+		"mov %c[r15](%[regs]), %%r15 \n\t"
 #endif
+		"mov %c[rcx](%[regs]), %%" _ASM_CX " \n\t" /* destroys %[regs] */
 
 		/* Enter guest mode */
 		"push %%" _ASM_AX " \n\t"
@@ -5621,22 +5623,34 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 		__ex(SVM_VMSAVE) "\n\t"
 		"pop %%" _ASM_AX " \n\t"
 
+		/*
+		 * Stack layout at this point (x86_64)
+		 *
+		 * [RSP + 16] = RBP
+		 * [RSP +  8] = vcpu_hidden pointer
+		 * [RSP +  0] = Space for guest RCX
+		 */
+
+		"mov %[regs], (%%" _ASM_SP ") \n\t" /* save guest RCX */
+		"mov %c[wordsize](%%" _ASM_SP"), %[regs] \n\t"
+
 		/* Save guest registers, load host registers */
-		"mov %%" _ASM_BX ", %c[rbx](%[svm]) \n\t"
-		"mov %%" _ASM_CX ", %c[rcx](%[svm]) \n\t"
-		"mov %%" _ASM_DX ", %c[rdx](%[svm]) \n\t"
-		"mov %%" _ASM_SI ", %c[rsi](%[svm]) \n\t"
-		"mov %%" _ASM_DI ", %c[rdi](%[svm]) \n\t"
-		"mov %%" _ASM_BP ", %c[rbp](%[svm]) \n\t"
+		"mov %%" _ASM_BX ", %c[rbx](%[regs]) \n\t"
+		__ASM_SIZE(pop)  "  %c[rcx](%[regs]) \n\t"
+		"mov %%" _ASM_CX ", %c[rcx](%[regs]) \n\t"
+		"mov %%" _ASM_DX ", %c[rdx](%[regs]) \n\t"
+		"mov %%" _ASM_SI ", %c[rsi](%[regs]) \n\t"
+		"mov %%" _ASM_DI ", %c[rdi](%[regs]) \n\t"
+		"mov %%" _ASM_BP ", %c[rbp](%[regs]) \n\t"
 #ifdef CONFIG_X86_64
-		"mov %%r8,  %c[r8](%[svm]) \n\t"
-		"mov %%r9,  %c[r9](%[svm]) \n\t"
-		"mov %%r10, %c[r10](%[svm]) \n\t"
-		"mov %%r11, %c[r11](%[svm]) \n\t"
-		"mov %%r12, %c[r12](%[svm]) \n\t"
-		"mov %%r13, %c[r13](%[svm]) \n\t"
-		"mov %%r14, %c[r14](%[svm]) \n\t"
-		"mov %%r15, %c[r15](%[svm]) \n\t"
+		"mov %%r8,  %c[r8](%[regs]) \n\t"
+		"mov %%r9,  %c[r9](%[regs]) \n\t"
+		"mov %%r10, %c[r10](%[regs]) \n\t"
+		"mov %%r11, %c[r11](%[regs]) \n\t"
+		"mov %%r12, %c[r12](%[regs]) \n\t"
+		"mov %%r13, %c[r13](%[regs]) \n\t"
+		"mov %%r14, %c[r14](%[regs]) \n\t"
+		"mov %%r15, %c[r15](%[regs]) \n\t"
 		/*
 		* Clear host registers marked as clobbered to prevent
 		* speculative use.
@@ -5655,29 +5669,31 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 		"xor %%edx, %%edx \n\t"
 		"xor %%esi, %%esi \n\t"
 		"xor %%edi, %%edi \n\t"
-		"pop %%" _ASM_BP
+		"pop %%" _ASM_CX " \n\t"
+		"pop %%" _ASM_BP " \n\t"
 		:
-		: [svm]"a"(svm),
+		: [svm]"a"(svm), [regs]"c"(regs),
 		  [vmcb]"i"(offsetof(struct vcpu_svm, vmcb_pa)),
-		  [rbx]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_RBX])),
-		  [rcx]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_RCX])),
-		  [rdx]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_RDX])),
-		  [rsi]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_RSI])),
-		  [rdi]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_RDI])),
-		  [rbp]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_RBP]))
+		  [rbx]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RBX])),
+		  [rcx]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RCX])),
+		  [rdx]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RDX])),
+		  [rsi]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RSI])),
+		  [rdi]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RDI])),
+		  [rbp]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RBP]))
 #ifdef CONFIG_X86_64
-		  , [r8]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R8])),
-		  [r9]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R9])),
-		  [r10]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R10])),
-		  [r11]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R11])),
-		  [r12]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R12])),
-		  [r13]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R13])),
-		  [r14]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R14])),
-		  [r15]"i"(offsetof(struct vcpu_svm, vcpu.arch.regs[VCPU_REGS_R15]))
+		  , [r8]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R8])),
+		  [r9]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R9])),
+		  [r10]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R10])),
+		  [r11]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R11])),
+		  [r12]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R12])),
+		  [r13]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R13])),
+		  [r14]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R14])),
+		  [r15]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R15])),
+		  [wordsize]"i"(sizeof(ulong))
 #endif
 		: "cc", "memory"
 #ifdef CONFIG_X86_64
-		, "rbx", "rcx", "rdx", "rsi", "rdi"
+		, "rbx", "rdx", "rsi", "rdi"
 		, "r8", "r9", "r10", "r11" , "r12", "r13", "r14", "r15"
 #else
 		, "ebx", "ecx", "edx", "esi", "edi"
@@ -5721,9 +5737,9 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	x86_spec_ctrl_restore_host(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	vcpu->arch.cr2 = svm->vmcb->save.cr2;
-	vcpu->arch.regs[VCPU_REGS_RAX] = svm->vmcb->save.rax;
-	vcpu->arch.regs[VCPU_REGS_RSP] = svm->vmcb->save.rsp;
-	vcpu->arch.regs[VCPU_REGS_RIP] = svm->vmcb->save.rip;
+	regs[VCPU_REGS_RAX] = svm->vmcb->save.rax;
+	regs[VCPU_REGS_RSP] = svm->vmcb->save.rsp;
+	regs[VCPU_REGS_RIP] = svm->vmcb->save.rip;
 
 	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
 		kvm_before_interrupt(&svm->vcpu);
@@ -6150,14 +6166,16 @@ static int svm_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 	int ret;
 
 	if (is_guest_mode(vcpu)) {
+		unsigned long *regs = kvm_arch_vcpu_hidden_get(vcpu)->regs;
+
 		/* FED8h - SVM Guest */
 		put_smstate(u64, smstate, 0x7ed8, 1);
 		/* FEE0h - SVM Guest VMCB Physical Address */
 		put_smstate(u64, smstate, 0x7ee0, svm->nested.vmcb);
 
-		svm->vmcb->save.rax = vcpu->arch.regs[VCPU_REGS_RAX];
-		svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
-		svm->vmcb->save.rip = vcpu->arch.regs[VCPU_REGS_RIP];
+		svm->vmcb->save.rax = regs[VCPU_REGS_RAX];
+		svm->vmcb->save.rsp = regs[VCPU_REGS_RSP];
+		svm->vmcb->save.rip = regs[VCPU_REGS_RIP];
 
 		ret = nested_svm_vmexit(svm);
 		if (ret)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 8ebd41d935b8..21959e0a9588 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4364,10 +4364,10 @@ static void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
 	switch (reg) {
 	case VCPU_REGS_RSP:
-		vcpu->arch.regs[VCPU_REGS_RSP] = vmcs_readl(GUEST_RSP);
+		kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RSP] = vmcs_readl(GUEST_RSP);
 		break;
 	case VCPU_REGS_RIP:
-		vcpu->arch.regs[VCPU_REGS_RIP] = vmcs_readl(GUEST_RIP);
+		kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RIP] = vmcs_readl(GUEST_RIP);
 		break;
 	case VCPU_EXREG_PDPTR:
 		if (enable_ept)
@@ -6704,7 +6704,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vmx->spec_ctrl = 0;
 
 	vcpu->arch.microcode_version = 0x100000000ULL;
-	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
+	kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RDX] = get_rdx_init_val();
 	kvm_set_cr8(vcpu, 0);
 
 	if (!init_event) {
@@ -7440,7 +7440,7 @@ static int handle_cpuid(struct kvm_vcpu *vcpu)
 
 static int handle_rdmsr(struct kvm_vcpu *vcpu)
 {
-	u32 ecx = vcpu->arch.regs[VCPU_REGS_RCX];
+	u32 ecx = kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RCX];
 	struct msr_data msr_info;
 
 	msr_info.index = ecx;
@@ -7454,17 +7454,17 @@ static int handle_rdmsr(struct kvm_vcpu *vcpu)
 	trace_kvm_msr_read(ecx, msr_info.data);
 
 	/* FIXME: handling of bits 32:63 of rax, rdx */
-	vcpu->arch.regs[VCPU_REGS_RAX] = msr_info.data & -1u;
-	vcpu->arch.regs[VCPU_REGS_RDX] = (msr_info.data >> 32) & -1u;
+	kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RAX] = msr_info.data & -1u;
+	kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RDX] = (msr_info.data >> 32) & -1u;
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
 static int handle_wrmsr(struct kvm_vcpu *vcpu)
 {
 	struct msr_data msr;
-	u32 ecx = vcpu->arch.regs[VCPU_REGS_RCX];
-	u64 data = (vcpu->arch.regs[VCPU_REGS_RAX] & -1u)
-		| ((u64)(vcpu->arch.regs[VCPU_REGS_RDX] & -1u) << 32);
+	u32 ecx = kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RCX];
+	u64 data = (kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RAX] & -1u)
+		| ((u64)(kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RDX] & -1u) << 32);
 
 	msr.data = data;
 	msr.index = ecx;
@@ -9735,7 +9735,7 @@ static bool valid_ept_address(struct kvm_vcpu *vcpu, u64 address)
 static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 				     struct vmcs12 *vmcs12)
 {
-	u32 index = vcpu->arch.regs[VCPU_REGS_RCX];
+	u32 index = kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RCX];
 	u64 address;
 	bool accessed_dirty;
 	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
@@ -9781,7 +9781,7 @@ static int handle_vmfunc(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12;
-	u32 function = vcpu->arch.regs[VCPU_REGS_RAX];
+	u32 function = kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RAX];
 
 	/*
 	 * VMFUNC is only supported for nested guests, but we always enable the
@@ -9940,7 +9940,7 @@ static bool nested_vmx_exit_handled_io(struct kvm_vcpu *vcpu,
 static bool nested_vmx_exit_handled_msr(struct kvm_vcpu *vcpu,
 	struct vmcs12 *vmcs12, u32 exit_reason)
 {
-	u32 msr_index = vcpu->arch.regs[VCPU_REGS_RCX];
+	u32 msr_index = kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RCX];
 	gpa_t bitmap;
 
 	if (!nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS))
@@ -11166,9 +11166,9 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	}
 
 	if (test_bit(VCPU_REGS_RSP, (unsigned long *)&vcpu->arch.regs_dirty))
-		vmcs_writel(GUEST_RSP, vcpu->arch.regs[VCPU_REGS_RSP]);
+		vmcs_writel(GUEST_RSP, kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RSP]);
 	if (test_bit(VCPU_REGS_RIP, (unsigned long *)&vcpu->arch.regs_dirty))
-		vmcs_writel(GUEST_RIP, vcpu->arch.regs[VCPU_REGS_RIP]);
+		vmcs_writel(GUEST_RIP, kvm_arch_vcpu_hidden_get(vcpu)->regs[VCPU_REGS_RIP]);
 
 	cr3 = __get_current_cr3_fast();
 	if (unlikely(cr3 != vmx->loaded_vmcs->host_state.cr3)) {
@@ -11221,7 +11221,9 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	asm(
 		/* Store host registers */
 		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
-		"push %%" _ASM_CX " \n\t" /* placeholder for guest rcx */
+		"push $0\n\t" /* placeholder for guest rbx */
+		"push $0\n\t" /* placeholder for guest rcx */
+		"push %%" _ASM_BX " \n\t"
 		"push %%" _ASM_CX " \n\t"
 		"cmp %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
 		"je 1f \n\t"
@@ -11237,23 +11239,23 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		/* Check if vmlaunch of vmresume is needed */
 		"cmpl $0, %c[launched](%0) \n\t"
 		/* Load guest registers.  Don't clobber flags. */
-		"mov %c[rax](%0), %%" _ASM_AX " \n\t"
-		"mov %c[rbx](%0), %%" _ASM_BX " \n\t"
-		"mov %c[rdx](%0), %%" _ASM_DX " \n\t"
-		"mov %c[rsi](%0), %%" _ASM_SI " \n\t"
-		"mov %c[rdi](%0), %%" _ASM_DI " \n\t"
-		"mov %c[rbp](%0), %%" _ASM_BP " \n\t"
+		"mov %c[rax](%1), %%" _ASM_AX " \n\t"
+		"mov %c[rcx](%1), %%" _ASM_CX " \n\t" /* kills %0 (ecx) */
+		"mov %c[rdx](%1), %%" _ASM_DX " \n\t"
+		"mov %c[rsi](%1), %%" _ASM_SI " \n\t"
+		"mov %c[rdi](%1), %%" _ASM_DI " \n\t"
+		"mov %c[rbp](%1), %%" _ASM_BP " \n\t"
 #ifdef CONFIG_X86_64
-		"mov %c[r8](%0),  %%r8  \n\t"
-		"mov %c[r9](%0),  %%r9  \n\t"
-		"mov %c[r10](%0), %%r10 \n\t"
-		"mov %c[r11](%0), %%r11 \n\t"
-		"mov %c[r12](%0), %%r12 \n\t"
-		"mov %c[r13](%0), %%r13 \n\t"
-		"mov %c[r14](%0), %%r14 \n\t"
-		"mov %c[r15](%0), %%r15 \n\t"
+		"mov %c[r8](%1),  %%r8  \n\t"
+		"mov %c[r9](%1),  %%r9  \n\t"
+		"mov %c[r10](%1), %%r10 \n\t"
+		"mov %c[r11](%1), %%r11 \n\t"
+		"mov %c[r12](%1), %%r12 \n\t"
+		"mov %c[r13](%1), %%r13 \n\t"
+		"mov %c[r14](%1), %%r14 \n\t"
+		"mov %c[r15](%1), %%r15 \n\t"
 #endif
-		"mov %c[rcx](%0), %%" _ASM_CX " \n\t" /* kills %0 (ecx) */
+		"mov %c[rbx](%1), %%" _ASM_BX " \n\t" /* kills %1 (ebx) */
 
 		/* Enter guest mode */
 		"jne 1f \n\t"
@@ -11261,57 +11263,71 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"jmp 2f \n\t"
 		"1: " __ex("vmresume") "\n\t"
 		"2: "
+
+		/*
+		 * Stack layout at this point (x86_64):
+		 *
+		 * [RSP + 40] = RDX
+		 * [RSP + 32] = RBP
+		 * [RSP + 24] = Space for guest RBX
+		 * [RSP + 16] = Space for guest RCX
+		 * [RSP +  8] = vcpu_hidden pointer
+		 * [RSP +  0] = vmx pointer
+		 */
+
 		/* Save guest registers, load host registers, keep flags */
-		"mov %0, %c[wordsize](%%" _ASM_SP ") \n\t"
+		"mov %0, 2*%c[wordsize](%%" _ASM_SP ") \n\t"
+		"mov %1, 3*%c[wordsize](%%" _ASM_SP ") \n\t"
 		"pop %0 \n\t"
+		"pop %1 \n\t"
 		"setbe %c[fail](%0)\n\t"
-		"mov %%" _ASM_AX ", %c[rax](%0) \n\t"
-		"mov %%" _ASM_BX ", %c[rbx](%0) \n\t"
-		__ASM_SIZE(pop) " %c[rcx](%0) \n\t"
-		"mov %%" _ASM_DX ", %c[rdx](%0) \n\t"
-		"mov %%" _ASM_SI ", %c[rsi](%0) \n\t"
-		"mov %%" _ASM_DI ", %c[rdi](%0) \n\t"
-		"mov %%" _ASM_BP ", %c[rbp](%0) \n\t"
+		"mov %%" _ASM_AX ", %c[rax](%1) \n\t"
+		__ASM_SIZE(pop) " %c[rcx](%1) \n\t"
+		__ASM_SIZE(pop) " %c[rbx](%1) \n\t"
+		"mov %%" _ASM_DX ", %c[rdx](%1) \n\t"
+		"mov %%" _ASM_SI ", %c[rsi](%1) \n\t"
+		"mov %%" _ASM_DI ", %c[rdi](%1) \n\t"
+		"mov %%" _ASM_BP ", %c[rbp](%1) \n\t"
 #ifdef CONFIG_X86_64
-		"mov %%r8,  %c[r8](%0) \n\t"
-		"mov %%r9,  %c[r9](%0) \n\t"
-		"mov %%r10, %c[r10](%0) \n\t"
-		"mov %%r11, %c[r11](%0) \n\t"
-		"mov %%r12, %c[r12](%0) \n\t"
-		"mov %%r13, %c[r13](%0) \n\t"
-		"mov %%r14, %c[r14](%0) \n\t"
-		"mov %%r15, %c[r15](%0) \n\t"
+		"mov %%r8,  %c[r8](%1) \n\t"
+		"mov %%r9,  %c[r9](%1) \n\t"
+		"mov %%r10, %c[r10](%1) \n\t"
+		"mov %%r11, %c[r11](%1) \n\t"
+		"mov %%r12, %c[r12](%1) \n\t"
+		"mov %%r13, %c[r13](%1) \n\t"
+		"mov %%r14, %c[r14](%1) \n\t"
+		"mov %%r15, %c[r15](%1) \n\t"
 #endif
 		"pop  %%" _ASM_BP "; pop  %%" _ASM_DX " \n\t"
 		".pushsection .rodata \n\t"
 		".global vmx_return \n\t"
 		"vmx_return: " _ASM_PTR " 2b \n\t"
 		".popsection"
-	      : : "c"(vmx), "d"((unsigned long)HOST_RSP), "S"(evmcs_rsp),
+		: : "c"(vmx), "b" (kvm_arch_vcpu_hidden_get(vcpu)), "d"((unsigned long)HOST_RSP), "S"(evmcs_rsp),
 		[launched]"i"(offsetof(struct vcpu_vmx, __launched)),
 		[fail]"i"(offsetof(struct vcpu_vmx, fail)),
 		[host_rsp]"i"(offsetof(struct vcpu_vmx, host_rsp)),
-		[rax]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_RAX])),
-		[rbx]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_RBX])),
-		[rcx]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_RCX])),
-		[rdx]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_RDX])),
-		[rsi]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_RSI])),
-		[rdi]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_RDI])),
-		[rbp]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_RBP])),
+		[rax]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RAX])),
+		[rbx]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RBX])),
+		[rcx]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RCX])),
+		[rdx]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RDX])),
+		[rsi]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RSI])),
+		[rdi]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RDI])),
+		[rbp]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_RBP])),
 #ifdef CONFIG_X86_64
-		[r8]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R8])),
-		[r9]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R9])),
-		[r10]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R10])),
-		[r11]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R11])),
-		[r12]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R12])),
-		[r13]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R13])),
-		[r14]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R14])),
-		[r15]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R15])),
+		[r8]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R8])),
+		[r9]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R9])),
+		[r10]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R10])),
+		[r11]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R11])),
+		[r12]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R12])),
+		[r13]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R13])),
+		[r14]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R14])),
+		[r15]"i"(offsetof(struct kvm_vcpu_arch_hidden, regs[VCPU_REGS_R15])),
 #endif
 		[wordsize]"i"(sizeof(ulong))
 	      : "cc", "memory"
 #ifdef CONFIG_X86_64
-		, "rax", "rbx", "rdi"
+		, "rax", "rdi"
 		, "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
 #else
 		, "eax", "ebx", "edi"
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 941fa3209607..9c5fc8e13b17 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8726,7 +8726,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		vcpu->arch.xcr0 = XFEATURE_MASK_FP;
 	}
 
-	memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
+	memset(kvm_arch_vcpu_hidden_get(vcpu)->regs, 0,
+	       sizeof(kvm_arch_vcpu_hidden_get(vcpu)->regs));
 	vcpu->arch.regs_avail = ~0;
 	vcpu->arch.regs_dirty = ~0;
 
-- 
2.17.1

