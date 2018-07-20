Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7A120661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7A120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbeGTNpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:45:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39008 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387908AbeGTNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:19:12 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A7BBBCF;
        Fri, 20 Jul 2018 12:30:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.9 53/66] arm64: Call ARCH_WORKAROUND_2 on transitions between EL0 and EL1
Date:   Fri, 20 Jul 2018 14:14:10 +0200
Message-Id: <20180720121410.680379605@linuxfoundation.org>
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

From: Marc Zyngier <marc.zyngier@arm.com>

commit 8e2906245f1e3b0d027169d9f2e55ce0548cb96e upstream.

In order for the kernel to protect itself, let's call the SSBD mitigation
implemented by the higher exception level (either hypervisor or firmware)
on each transition between userspace and kernel.

We must take the PSCI conduit into account in order to target the
right exception level, hence the introduction of a runtime patching
callback.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Julien Grall <julien.grall@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |   24 ++++++++++++++++++++++++
 arch/arm64/kernel/entry.S      |   22 ++++++++++++++++++++++
 include/linux/arm-smccc.h      |    5 +++++
 3 files changed, 51 insertions(+)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -187,6 +187,30 @@ static int enable_smccc_arch_workaround_
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
+#ifdef CONFIG_ARM64_SSBD
+void __init arm64_update_smccc_conduit(struct alt_instr *alt,
+				       __le32 *origptr, __le32 *updptr,
+				       int nr_inst)
+{
+	u32 insn;
+
+	BUG_ON(nr_inst != 1);
+
+	switch (psci_ops.conduit) {
+	case PSCI_CONDUIT_HVC:
+		insn = aarch64_insn_get_hvc_value();
+		break;
+	case PSCI_CONDUIT_SMC:
+		insn = aarch64_insn_get_smc_value();
+		break;
+	default:
+		return;
+	}
+
+	*updptr = cpu_to_le32(insn);
+}
+#endif	/* CONFIG_ARM64_SSBD */
+
 #define MIDR_RANGE(model, min, max) \
 	.def_scope = SCOPE_LOCAL_CPU, \
 	.matches = is_affected_midr_range, \
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -18,6 +18,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
 
@@ -95,6 +96,18 @@ alternative_else_nop_endif
 	add	\dst, \dst, #(\sym - .entry.tramp.text)
 	.endm
 
+	// This macro corrupts x0-x3. It is the caller's duty
+	// to save/restore them if required.
+	.macro	apply_ssbd, state
+#ifdef CONFIG_ARM64_SSBD
+	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2
+	mov	w1, #\state
+alternative_cb	arm64_update_smccc_conduit
+	nop					// Patched to SMC/HVC #0
+alternative_cb_end
+#endif
+	.endm
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
@@ -122,6 +135,13 @@ alternative_else_nop_endif
 	ldr	x19, [tsk, #TI_FLAGS]		// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 
+	apply_ssbd 1
+
+#ifdef CONFIG_ARM64_SSBD
+	ldp	x0, x1, [sp, #16 * 0]
+	ldp	x2, x3, [sp, #16 * 1]
+#endif
+
 	mov	x29, xzr			// fp pointed to user-space
 	.else
 	add	x21, sp, #S_FRAME_SIZE
@@ -190,6 +210,8 @@ alternative_if ARM64_WORKAROUND_845719
 alternative_else_nop_endif
 #endif
 3:
+	apply_ssbd 0
+
 	.endif
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -80,6 +80,11 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 0x8000)
 
+#define ARM_SMCCC_ARCH_WORKAROUND_2					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 0x7fff)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>


