Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754922AbeDCGVD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:21:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34618 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754837AbeDCGU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:20:56 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/13] ARM: sunxi: smp: Move cpu_resume assembly entry into file
Date: Tue,  3 Apr 2018 08:18:26 +0200
Message-Id: <20180403061836.3926-4-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180403061836.3926-1-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the CPU resume assembly function into the assembly file
to remove all assembly code from C code.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/headsmp.S |  5 +++++
 arch/arm/mach-sunxi/mc_smp.c  | 11 +----------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
index 119005b5dff9..79890fbe5613 100644
--- a/arch/arm/mach-sunxi/headsmp.S
+++ b/arch/arm/mach-sunxi/headsmp.S
@@ -73,3 +73,8 @@ ENTRY(sunxi_mc_smp_secondary_startup)
 	bl	sunxi_mc_smp_cluster_cache_enable
 	b	secondary_startup
 ENDPROC(sunxi_mc_smp_secondary_startup)
+
+ENTRY(sunxi_mc_smp_resume)
+	bl	sunxi_mc_smp_cluster_cache_enable
+	b	cpu_resume
+ENDPROC(sunxi_mc_smp_resume)
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 9cc6c8fc6db7..727968d6a3e5 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -73,6 +73,7 @@ static void __iomem *prcm_base;
 static void __iomem *sram_b_smp_base;
 
 extern void sunxi_mc_smp_secondary_startup(void);
+extern void sunxi_mc_smp_resume(void);
 
 static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 {
@@ -572,16 +573,6 @@ static bool __init sunxi_mc_smp_cpu_table_init(void)
  */
 typedef typeof(cpu_reset) phys_reset_t;
 
-static void __init __naked sunxi_mc_smp_resume(void)
-{
-	asm volatile(
-		"bl	sunxi_mc_smp_cluster_cache_enable\n"
-		"b	cpu_resume"
-		/* Let compiler know about sunxi_mc_smp_cluster_cache_enable */
-		:: "i" (sunxi_mc_smp_cluster_cache_enable)
-	);
-}
-
 static int __init nocache_trampoline(unsigned long __unused)
 {
 	phys_reset_t phys_reset;
-- 
2.11.0
