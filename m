Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeBFO06 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:26:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34438 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeBFO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:26:38 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 2/3] ARM: imx53: add SoC specific PMU setup
Date: Tue,  6 Feb 2018 15:26:28 +0100
Message-Id: <20180206142629.534-3-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
References: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Senna Tschudin <peter.senna@collabora.com>

On i.MX53 it is necessary to set the DBG_EN bit in the
platform GPC register to enable access to PMU counters
other than the cycle counter.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/mach-imx/mach-imx53.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 07c2e8dca494..da7c80371f32 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/perf/arm_pmu.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
@@ -28,10 +29,77 @@ static void __init imx53_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX53);
 }
 
+/* Hard code as this is i.Mx53 only file */
+#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
+#define GPC_DBG_EN (1 << 16)
+
+static void __iomem *imx53_pmu_get_gpc(void)
+{
+	static void __iomem *gpc;
+
+	if (!gpc) {
+		gpc = ioremap(MXC_CORTEXA8_PLAT_GPC, 4);
+		if (!gpc)
+			printk_once(KERN_INFO "unable to map GPC to enable perf\n");
+	}
+
+	return gpc;
+}
+
+static int imx53_pmu_reserve(struct arm_pmu *arm_pmu)
+{
+	void __iomem *gpc_reg;
+	u32 gpc;
+
+	gpc_reg = imx53_pmu_get_gpc();
+	if (!gpc_reg)
+		return 0;
+
+	gpc = __raw_readl(gpc_reg);
+	if (gpc & GPC_DBG_EN) {
+		arm_pmu->reserved_hardware = false;
+	} else {
+		gpc |= GPC_DBG_EN;
+		__raw_writel(gpc, gpc_reg);
+		arm_pmu->reserved_hardware = true;
+	}
+
+	return 0;
+}
+
+static void imx53_pmu_release(struct arm_pmu *arm_pmu)
+{
+	void __iomem *gpc_reg;
+	u32 gpc;
+
+	gpc_reg = imx53_pmu_get_gpc();
+	if (!gpc_reg)
+		return;
+
+	if (arm_pmu->reserved_hardware) {
+		gpc = __raw_readl(gpc_reg);
+		gpc &= ~GPC_DBG_EN;
+		__raw_writel(gpc, gpc_reg);
+		arm_pmu->reserved_hardware = false;
+	}
+}
+
+static struct arm_pmu_platdata imx53_pmu_platdata = {
+	.reserve_hardware = imx53_pmu_reserve,
+	.release_hardware = imx53_pmu_release,
+};
+
+static struct of_dev_auxdata imx53_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,cortex-a8-pmu", 0, "arm-pmu", &imx53_pmu_platdata),
+	{}
+};
+
 static void __init imx53_dt_init(void)
 {
 	imx_src_init();
 
+	of_platform_populate(NULL, of_default_bus_match_table,
+					imx53_auxdata_lookup, NULL);
 	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
 }
 
-- 
2.15.1
