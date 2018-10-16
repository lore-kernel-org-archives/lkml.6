Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674DFC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBCC2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPN53Wch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBCC2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbeJQBMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbeJQBMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:12:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF192098A;
        Tue, 16 Oct 2018 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710480;
        bh=+hRzdv6kZb1q5tLNqa9Feu23w/c+8FFIjD14QBNwT8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPN53Wchuke71+jez+oqNH0muRKmWcMmIRCktg7x7OEukic9uO944omwMIEnw89Q8
         wdAR+MBlfqyAjDNiRg703teCw+/73sSLPGkWrWjhkvuSPiYLigNmmSXosPNzWiSi3Y
         CNHFk9Bqyg0UdzkVXlBK9r4B7E6DMFGG743AbOKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.14 093/109] ARM: spectre-v2: add firmware based hardening
Date:   Tue, 16 Oct 2018 19:06:01 +0200
Message-Id: <20181016170530.051636828@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 10115105cb3aa17b5da1cb726ae8dd5f6854bd93 upstream.

Add firmware based hardening for cores that require more complex
handling in firmware.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mm/proc-v7-bugs.c |   60 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7.S      |   21 +++++++++++++++
 2 files changed, 81 insertions(+)

--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -1,14 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/arm-smccc.h>
 #include <linux/kernel.h>
+#include <linux/psci.h>
 #include <linux/smp.h>
 
 #include <asm/cp15.h>
 #include <asm/cputype.h>
+#include <asm/proc-fns.h>
 #include <asm/system_misc.h>
 
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 DEFINE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
 
+extern void cpu_v7_smc_switch_mm(phys_addr_t pgd_phys, struct mm_struct *mm);
+extern void cpu_v7_hvc_switch_mm(phys_addr_t pgd_phys, struct mm_struct *mm);
+
 static void harden_branch_predictor_bpiall(void)
 {
 	write_sysreg(0, BPIALL);
@@ -19,6 +25,16 @@ static void harden_branch_predictor_icia
 	write_sysreg(0, ICIALLU);
 }
 
+static void __maybe_unused call_smc_arch_workaround_1(void)
+{
+	arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
+}
+
+static void __maybe_unused call_hvc_arch_workaround_1(void)
+{
+	arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
+}
+
 static void cpu_v7_spectre_init(void)
 {
 	const char *spectre_v2_method = NULL;
@@ -45,7 +61,51 @@ static void cpu_v7_spectre_init(void)
 			harden_branch_predictor_iciallu;
 		spectre_v2_method = "ICIALLU";
 		break;
+
+#ifdef CONFIG_ARM_PSCI
+	default:
+		/* Other ARM CPUs require no workaround */
+		if (read_cpuid_implementor() == ARM_CPU_IMP_ARM)
+			break;
+		/* fallthrough */
+		/* Cortex A57/A72 require firmware workaround */
+	case ARM_CPU_PART_CORTEX_A57:
+	case ARM_CPU_PART_CORTEX_A72: {
+		struct arm_smccc_res res;
+
+		if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
+			break;
+
+		switch (psci_ops.conduit) {
+		case PSCI_CONDUIT_HVC:
+			arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
+			if ((int)res.a0 != 0)
+				break;
+			per_cpu(harden_branch_predictor_fn, cpu) =
+				call_hvc_arch_workaround_1;
+			processor.switch_mm = cpu_v7_hvc_switch_mm;
+			spectre_v2_method = "hypervisor";
+			break;
+
+		case PSCI_CONDUIT_SMC:
+			arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
+			if ((int)res.a0 != 0)
+				break;
+			per_cpu(harden_branch_predictor_fn, cpu) =
+				call_smc_arch_workaround_1;
+			processor.switch_mm = cpu_v7_smc_switch_mm;
+			spectre_v2_method = "firmware";
+			break;
+
+		default:
+			break;
+		}
 	}
+#endif
+	}
+
 	if (spectre_v2_method)
 		pr_info("CPU%u: Spectre v2: using %s workaround\n",
 			smp_processor_id(), spectre_v2_method);
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -9,6 +9,7 @@
  *
  *  This is the "shell" of the ARMv7 processor support.
  */
+#include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
@@ -93,6 +94,26 @@ ENTRY(cpu_v7_dcache_clean_area)
 	ret	lr
 ENDPROC(cpu_v7_dcache_clean_area)
 
+#ifdef CONFIG_ARM_PSCI
+	.arch_extension sec
+ENTRY(cpu_v7_smc_switch_mm)
+	stmfd	sp!, {r0 - r3}
+	movw	r0, #:lower16:ARM_SMCCC_ARCH_WORKAROUND_1
+	movt	r0, #:upper16:ARM_SMCCC_ARCH_WORKAROUND_1
+	smc	#0
+	ldmfd	sp!, {r0 - r3}
+	b	cpu_v7_switch_mm
+ENDPROC(cpu_v7_smc_switch_mm)
+	.arch_extension virt
+ENTRY(cpu_v7_hvc_switch_mm)
+	stmfd	sp!, {r0 - r3}
+	movw	r0, #:lower16:ARM_SMCCC_ARCH_WORKAROUND_1
+	movt	r0, #:upper16:ARM_SMCCC_ARCH_WORKAROUND_1
+	hvc	#0
+	ldmfd	sp!, {r0 - r3}
+	b	cpu_v7_switch_mm
+ENDPROC(cpu_v7_smc_switch_mm)
+#endif
 ENTRY(cpu_v7_iciallu_switch_mm)
 	mov	r3, #0
 	mcr	p15, 0, r3, c7, c5, 0		@ ICIALLU


