Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeBWNit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:38:49 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48921 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeBWNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:38:40 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v4 09/10] ARM: sunxi: smp: Move cpu_resume assembly entry into file
Date: Fri, 23 Feb 2018 14:37:41 +0100
Message-Id: <20180223133742.26044-10-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180223133742.26044-1-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
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
index 4f5957a6e188..d5c97e945e69 100644
--- a/arch/arm/mach-sunxi/headsmp.S
+++ b/arch/arm/mach-sunxi/headsmp.S
@@ -70,4 +70,9 @@ ENTRY(sunxi_boot)
 	bl	sunxi_mc_smp_cluster_cache_enable
 	b	secondary_startup
 ENDPROC(sunxi_boot)
+
+ENTRY(sunxi_mc_smp_resume)
+	bl	sunxi_mc_smp_cluster_cache_enable
+	b	cpu_resume
+ENDPROC(sunxi_mc_smp_resume)
 #endif
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 4e807cc11a0f..f1ad425a469c 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -84,6 +84,7 @@ static bool is_sun9i;
 
 extern void sunxi_boot(void);
 extern void sunxi_cluster_cache_enable(void);
+extern void sunxi_mc_smp_resume(void);
 
 static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 {
@@ -641,16 +642,6 @@ static bool __init sunxi_mc_smp_cpu_table_init(void)
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
