Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99A8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DC3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DC3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbeGTNZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:25:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbeGTNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:25:31 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42AD5C96;
        Fri, 20 Jul 2018 12:34:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Christoffer Dall <cdall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 74/92] KVM: arm64: Stop save/restoring host tpidr_el1 on VHE
Date:   Fri, 20 Jul 2018 14:14:18 +0200
Message-Id: <20180720121421.972488973@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

Commit 1f742679c33bc083722cb0b442a95d458c491b56 upstream.

Now that a VHE host uses tpidr_el2 for the cpu offset we no longer
need KVM to save/restore tpidr_el1. Move this from the 'common' code
into the non-vhe code. While we're at it, on VHE we don't need to
save the ELR or SPSR as kernel_entry in entry.S will have pushed these
onto the kernel stack, and will restore them from there. Move these
to the non-vhe code as we need them to get back to the host.

Finally remove the always-copy-tpidr we hid in the stage2 setup
code, cpufeature's enable callback will do this for VHE, we only
need KVM to do it for non-vhe. Add the copy into kvm-init instead.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/hyp-init.S      |    4 ++++
 arch/arm64/kvm/hyp/s2-setup.c  |    3 ---
 arch/arm64/kvm/hyp/sysreg-sr.c |   16 ++++++++--------
 3 files changed, 12 insertions(+), 11 deletions(-)

--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -122,6 +122,10 @@ CPU_BE(	orr	x4, x4, #SCTLR_ELx_EE)
 	kern_hyp_va	x2
 	msr	vbar_el2, x2
 
+	/* copy tpidr_el1 into tpidr_el2 for use by HYP */
+	mrs	x1, tpidr_el1
+	msr	tpidr_el2, x1
+
 	/* Hello, World! */
 	eret
 ENDPROC(__kvm_hyp_init)
--- a/arch/arm64/kvm/hyp/s2-setup.c
+++ b/arch/arm64/kvm/hyp/s2-setup.c
@@ -84,8 +84,5 @@ u32 __hyp_text __init_stage2_translation
 
 	write_sysreg(val, vtcr_el2);
 
-	/* copy tpidr_el1 into tpidr_el2 for use by HYP */
-	write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
-
 	return parange;
 }
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -27,8 +27,8 @@ static void __hyp_text __sysreg_do_nothi
 /*
  * Non-VHE: Both host and guest must save everything.
  *
- * VHE: Host must save tpidr*_el[01], actlr_el1, mdscr_el1, sp0, pc,
- * pstate, and guest must save everything.
+ * VHE: Host must save tpidr*_el0, actlr_el1, mdscr_el1, sp_el0,
+ * and guest must save everything.
  */
 
 static void __hyp_text __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
@@ -36,11 +36,8 @@ static void __hyp_text __sysreg_save_com
 	ctxt->sys_regs[ACTLR_EL1]	= read_sysreg(actlr_el1);
 	ctxt->sys_regs[TPIDR_EL0]	= read_sysreg(tpidr_el0);
 	ctxt->sys_regs[TPIDRRO_EL0]	= read_sysreg(tpidrro_el0);
-	ctxt->sys_regs[TPIDR_EL1]	= read_sysreg(tpidr_el1);
 	ctxt->sys_regs[MDSCR_EL1]	= read_sysreg(mdscr_el1);
 	ctxt->gp_regs.regs.sp		= read_sysreg(sp_el0);
-	ctxt->gp_regs.regs.pc		= read_sysreg_el2(elr);
-	ctxt->gp_regs.regs.pstate	= read_sysreg_el2(spsr);
 }
 
 static void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
@@ -62,10 +59,13 @@ static void __hyp_text __sysreg_save_sta
 	ctxt->sys_regs[AMAIR_EL1]	= read_sysreg_el1(amair);
 	ctxt->sys_regs[CNTKCTL_EL1]	= read_sysreg_el1(cntkctl);
 	ctxt->sys_regs[PAR_EL1]		= read_sysreg(par_el1);
+	ctxt->sys_regs[TPIDR_EL1]	= read_sysreg(tpidr_el1);
 
 	ctxt->gp_regs.sp_el1		= read_sysreg(sp_el1);
 	ctxt->gp_regs.elr_el1		= read_sysreg_el1(elr);
 	ctxt->gp_regs.spsr[KVM_SPSR_EL1]= read_sysreg_el1(spsr);
+	ctxt->gp_regs.regs.pc		= read_sysreg_el2(elr);
+	ctxt->gp_regs.regs.pstate	= read_sysreg_el2(spsr);
 }
 
 static hyp_alternate_select(__sysreg_call_save_host_state,
@@ -89,11 +89,8 @@ static void __hyp_text __sysreg_restore_
 	write_sysreg(ctxt->sys_regs[ACTLR_EL1],	  actlr_el1);
 	write_sysreg(ctxt->sys_regs[TPIDR_EL0],	  tpidr_el0);
 	write_sysreg(ctxt->sys_regs[TPIDRRO_EL0], tpidrro_el0);
-	write_sysreg(ctxt->sys_regs[TPIDR_EL1],	  tpidr_el1);
 	write_sysreg(ctxt->sys_regs[MDSCR_EL1],	  mdscr_el1);
 	write_sysreg(ctxt->gp_regs.regs.sp,	  sp_el0);
-	write_sysreg_el2(ctxt->gp_regs.regs.pc,	  elr);
-	write_sysreg_el2(ctxt->gp_regs.regs.pstate, spsr);
 }
 
 static void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
@@ -115,10 +112,13 @@ static void __hyp_text __sysreg_restore_
 	write_sysreg_el1(ctxt->sys_regs[AMAIR_EL1],	amair);
 	write_sysreg_el1(ctxt->sys_regs[CNTKCTL_EL1], 	cntkctl);
 	write_sysreg(ctxt->sys_regs[PAR_EL1],		par_el1);
+	write_sysreg(ctxt->sys_regs[TPIDR_EL1],		tpidr_el1);
 
 	write_sysreg(ctxt->gp_regs.sp_el1,		sp_el1);
 	write_sysreg_el1(ctxt->gp_regs.elr_el1,		elr);
 	write_sysreg_el1(ctxt->gp_regs.spsr[KVM_SPSR_EL1],spsr);
+	write_sysreg_el2(ctxt->gp_regs.regs.pc,		elr);
+	write_sysreg_el2(ctxt->gp_regs.regs.pstate,	spsr);
 }
 
 static hyp_alternate_select(__sysreg_call_restore_host_state,


