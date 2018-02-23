Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeBWNou (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:44:50 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48948 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeBWNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:38:41 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
Date: Fri, 23 Feb 2018 14:37:42 +0100
Message-Id: <20180223133742.26044-11-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180223133742.26044-1-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Cortex-A7, the CNTVOFF register from arch timer is uninitialized.
It should be done by the bootloader but it is currently not the case,
even for boot CPU because this SoC is booting in secure mode.
It leads to an random offset value meaning that each CPU will have a
different time, which isn't working very well.

Add assembly code used for boot CPU and secondary CPU cores to make
sure that the CNTVOFF register is initialized.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/headsmp.S | 21 +++++++++++++++++++++
 arch/arm/mach-sunxi/sunxi.c   |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
index d5c97e945e69..605896251927 100644
--- a/arch/arm/mach-sunxi/headsmp.S
+++ b/arch/arm/mach-sunxi/headsmp.S
@@ -65,9 +65,30 @@ ENTRY(sunxi_mc_smp_cluster_cache_enable)
 	first: .word sunxi_mc_smp_first_comer - .
 ENDPROC(sunxi_mc_smp_cluster_cache_enable)
 
+ENTRY(sunxi_init_cntvoff)
+	/*
+	 * CNTVOFF has to be initialized either from non-secure Hypervisor
+	 * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
+	 * then it should be handled by the secure code
+	 */
+	cps	#MON_MODE
+	mrc	p15, 0, r1, c1, c1, 0		/* Get Secure Config */
+	orr	r0, r1, #1
+	mcr	p15, 0, r0, c1, c1, 0		/* Set Non Secure bit */
+	instr_sync
+	mov	r0, #0
+	mcrr	p15, 4, r0, r0, c14		/* CNTVOFF = 0 */
+	instr_sync
+	mcr	p15, 0, r1, c1, c1, 0		/* Set Secure bit */
+	instr_sync
+	cps	#SVC_MODE
+	ret	lr
+ENDPROC(sunxi_init_cntvoff)
+
 #ifdef CONFIG_SMP
 ENTRY(sunxi_boot)
 	bl	sunxi_mc_smp_cluster_cache_enable
+	bl	sunxi_init_cntvoff
 	b	secondary_startup
 ENDPROC(sunxi_boot)
 
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 5e9602ce1573..4bb041492b54 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -37,8 +37,12 @@ static const char * const sun6i_board_dt_compat[] = {
 };
 
 extern void __init sun6i_reset_init(void);
+extern void sunxi_init_cntvoff(void);
+
 static void __init sun6i_timer_init(void)
 {
+	sunxi_init_cntvoff();
+
 	of_clk_init(NULL);
 	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
 		sun6i_reset_init();
-- 
2.11.0
