Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A3C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC39620880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC39620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeLJLlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:41:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:58666 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLJLlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:41:31 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43D1PP4NhCz9tylK;
        Mon, 10 Dec 2018 12:41:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RLSczNLKkF5q; Mon, 10 Dec 2018 12:41:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43D1PP3VQ7z9tylJ;
        Mon, 10 Dec 2018 12:41:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 000878B7A9;
        Mon, 10 Dec 2018 12:41:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gTaV2tp9ZEjP; Mon, 10 Dec 2018 12:41:29 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CBDCC8B74C;
        Mon, 10 Dec 2018 12:41:29 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A857D716EF; Mon, 10 Dec 2018 11:41:29 +0000 (UTC)
Message-Id: <33dbb34cea199dc003cf5b7581faf905d546e0cf.1544441989.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/83xx: handle machine check caused by watchdog timer
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 10 Dec 2018 11:41:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the watchdog timer is set in interrupt mode, it causes a
machine check when it times out. The purpose of this mode is to
ease debugging, not to crash the kernel and reboot the machine.

This patch implements a special handling for that, in order to not
crash the kernel if the watchdog times out while in interrupt or
within the idle task.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cputable.h |  1 +
 arch/powerpc/include/asm/reg.h      |  2 ++
 arch/powerpc/kernel/cputable.c      | 10 ++++++----
 arch/powerpc/platforms/83xx/misc.c  | 16 ++++++++++++++++
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a0395ccbbe9e..d05f0c28e515 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -44,6 +44,7 @@ extern int machine_check_e500(struct pt_regs *regs);
 extern int machine_check_e200(struct pt_regs *regs);
 extern int machine_check_47x(struct pt_regs *regs);
 int machine_check_8xx(struct pt_regs *regs);
+int machine_check_83xx(struct pt_regs *regs);
 
 extern void cpu_down_flush_e500v2(void);
 extern void cpu_down_flush_e500mc(void);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 0d2139a0d5b9..1c98ef1f2d5b 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -769,6 +769,8 @@
 #define   SRR1_PROGTRAP		0x00020000 /* Trap */
 #define   SRR1_PROGADDR		0x00010000 /* SRR0 contains subsequent addr */
 
+#define   SRR1_MCE_MCP		0x00080000 /* Machine check signal caused interrupt */
+
 #define SPRN_HSRR0	0x13A	/* Save/Restore Register 0 */
 #define SPRN_HSRR1	0x13B	/* Save/Restore Register 1 */
 #define   HSRR1_DENORM		0x00100000 /* Denorm exception */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 2da01340c84c..1eab54bc6ee9 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1141,6 +1141,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
+#ifdef CONFIG_PPC_83xx
 	{	/* e300c1 (a 603e core, plus some) on 83xx */
 		.pvr_mask		= 0x7fff0000,
 		.pvr_value		= 0x00830000,
@@ -1151,7 +1152,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_83xx,
 		.platform		= "ppc603",
 	},
 	{	/* e300c2 (an e300c1 core, plus some, minus FPU) on 83xx */
@@ -1165,7 +1166,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_83xx,
 		.platform		= "ppc603",
 	},
 	{	/* e300c3 (e300c1, plus one IU, half cache size) on 83xx */
@@ -1179,7 +1180,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_83xx,
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e300",
 		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
@@ -1196,12 +1197,13 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_83xx,
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e300",
 		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
 		.platform		= "ppc603",
 	},
+#endif
 	{	/* default match, we assume split I/D cache & TB (non-601)... */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index d75c9816a5c9..3e591d159413 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -150,3 +150,19 @@ void __init mpc83xx_setup_arch(void)
 
 	mpc83xx_setup_pci();
 }
+
+int machine_check_83xx(struct pt_regs *regs)
+{
+	u32 mask = 1 << (31 - IPIC_MCP_WDT);
+
+	if (!(regs->msr & SRR1_MCE_MCP) || !(ipic_get_mcp_status() & mask))
+		return machine_check_generic(regs);
+	ipic_clear_mcp_status(mask);
+
+	if (debugger_fault_handler(regs))
+		return 1;
+
+	die("Watchdog NMI Reset", regs, 0);
+
+	return 1;
+}
-- 
2.13.3

