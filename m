Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A953ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43B920856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43B920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbeGTNS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:18:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387828AbeGTNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:18:59 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F366741C;
        Fri, 20 Jul 2018 12:30:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Christoffer Dall <cdall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.9 46/66] KVM: arm64: Change hyp_panic()s dependency on tpidr_el2
Date:   Fri, 20 Jul 2018 14:14:03 +0200
Message-Id: <20180720121409.889700459@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

Commit c97e166e54b662717d20ec2e36761758d2b6a7c2 upstream.

Make tpidr_el2 a cpu-offset for per-cpu variables in the same way the
host uses tpidr_el1. This lets tpidr_el{1,2} have the same value, and
on VHE they can be the same register.

KVM calls hyp_panic() when anything unexpected happens. This may occur
while a guest owns the EL1 registers. KVM stashes the vcpu pointer in
tpidr_el2, which it uses to find the host context in order to restore
the host EL1 registers before parachuting into the host's panic().

The host context is a struct kvm_cpu_context allocated in the per-cpu
area, and mapped to hyp. Given the per-cpu offset for this CPU, this is
easy to find. Change hyp_panic() to take a pointer to the
struct kvm_cpu_context. Wrap these calls with an asm function that
retrieves the struct kvm_cpu_context from the host's per-cpu area.

Copy the per-cpu offset from the hosts tpidr_el1 into tpidr_el2 during
kvm init. (Later patches will make this unnecessary for VHE hosts)

We print out the vcpu pointer as part of the panic message. Add a back
reference to the 'running vcpu' in the host cpu context to preserve this.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_host.h |    2 ++
 arch/arm64/kvm/hyp/hyp-entry.S    |   12 ++++++++++++
 arch/arm64/kvm/hyp/s2-setup.c     |    3 +++
 arch/arm64/kvm/hyp/switch.c       |   25 +++++++++++++------------
 4 files changed, 30 insertions(+), 12 deletions(-)

--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -197,6 +197,8 @@ struct kvm_cpu_context {
 		u64 sys_regs[NR_SYS_REGS];
 		u32 copro[NR_COPRO_REGS];
 	};
+
+	struct kvm_vcpu *__hyp_running_vcpu;
 };
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -173,6 +173,18 @@ ENTRY(__hyp_do_panic)
 	eret
 ENDPROC(__hyp_do_panic)
 
+ENTRY(__hyp_panic)
+	/*
+	 * '=kvm_host_cpu_state' is a host VA from the constant pool, it may
+	 * not be accessible by this address from EL2, hyp_panic() converts
+	 * it with kern_hyp_va() before use.
+	 */
+	ldr	x0, =kvm_host_cpu_state
+	mrs	x1, tpidr_el2
+	add	x0, x0, x1
+	b	hyp_panic
+ENDPROC(__hyp_panic)
+
 .macro invalid_vector	label, target = __hyp_panic
 	.align	2
 \label:
--- a/arch/arm64/kvm/hyp/s2-setup.c
+++ b/arch/arm64/kvm/hyp/s2-setup.c
@@ -84,5 +84,8 @@ u32 __hyp_text __init_stage2_translation
 
 	write_sysreg(val, vtcr_el2);
 
+	/* copy tpidr_el1 into tpidr_el2 for use by HYP */
+	write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
+
 	return parange;
 }
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -275,9 +275,9 @@ int __hyp_text __kvm_vcpu_run(struct kvm
 	u64 exit_code;
 
 	vcpu = kern_hyp_va(vcpu);
-	write_sysreg(vcpu, tpidr_el2);
 
 	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
+	host_ctxt->__hyp_running_vcpu = vcpu;
 	guest_ctxt = &vcpu->arch.ctxt;
 
 	__sysreg_save_host_state(host_ctxt);
@@ -364,7 +364,8 @@ again:
 
 static const char __hyp_panic_string[] = "HYP panic:\nPS:%08llx PC:%016llx ESR:%08llx\nFAR:%016llx HPFAR:%016llx PAR:%016llx\nVCPU:%p\n";
 
-static void __hyp_text __hyp_call_panic_nvhe(u64 spsr, u64 elr, u64 par)
+static void __hyp_text __hyp_call_panic_nvhe(u64 spsr, u64 elr, u64 par,
+					     struct kvm_vcpu *vcpu)
 {
 	unsigned long str_va;
 
@@ -378,35 +379,35 @@ static void __hyp_text __hyp_call_panic_
 	__hyp_do_panic(str_va,
 		       spsr,  elr,
 		       read_sysreg(esr_el2),   read_sysreg_el2(far),
-		       read_sysreg(hpfar_el2), par,
-		       (void *)read_sysreg(tpidr_el2));
+		       read_sysreg(hpfar_el2), par, vcpu);
 }
 
-static void __hyp_text __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par)
+static void __hyp_text __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par,
+					    struct kvm_vcpu *vcpu)
 {
 	panic(__hyp_panic_string,
 	      spsr,  elr,
 	      read_sysreg_el2(esr),   read_sysreg_el2(far),
-	      read_sysreg(hpfar_el2), par,
-	      (void *)read_sysreg(tpidr_el2));
+	      read_sysreg(hpfar_el2), par, vcpu);
 }
 
 static hyp_alternate_select(__hyp_call_panic,
 			    __hyp_call_panic_nvhe, __hyp_call_panic_vhe,
 			    ARM64_HAS_VIRT_HOST_EXTN);
 
-void __hyp_text __noreturn __hyp_panic(void)
+void __hyp_text __noreturn hyp_panic(struct kvm_cpu_context *__host_ctxt)
 {
+	struct kvm_vcpu *vcpu = NULL;
+
 	u64 spsr = read_sysreg_el2(spsr);
 	u64 elr = read_sysreg_el2(elr);
 	u64 par = read_sysreg(par_el1);
 
 	if (read_sysreg(vttbr_el2)) {
-		struct kvm_vcpu *vcpu;
 		struct kvm_cpu_context *host_ctxt;
 
-		vcpu = (struct kvm_vcpu *)read_sysreg(tpidr_el2);
-		host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
+		host_ctxt = kern_hyp_va(__host_ctxt);
+		vcpu = host_ctxt->__hyp_running_vcpu;
 		__timer_save_state(vcpu);
 		__deactivate_traps(vcpu);
 		__deactivate_vm(vcpu);
@@ -414,7 +415,7 @@ void __hyp_text __noreturn __hyp_panic(v
 	}
 
 	/* Call panic for real */
-	__hyp_call_panic()(spsr, elr, par);
+	__hyp_call_panic()(spsr, elr, par, vcpu);
 
 	unreachable();
 }


