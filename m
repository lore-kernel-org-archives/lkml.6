Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934641AbeBLMj6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:39:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39246 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933358AbeBLMjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:39:53 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
Date: Mon, 12 Feb 2018 13:39:44 +0100
Message-Id: <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX53 it is necessary to set the DBG_EN bit in the
platform GPC register to enable access to PMU counters
other than the cycle counter.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 07c2e8dca494..658e28604dca 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX53);
 }
 
+#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
+#define GPC_DBG_EN BIT(16)
+
+/*
+ * This enables the DBGEN bit in ARM_GPC register, which is
+ * required for accessing some performance counter features.
+ * Technically it is only required while perf is used, but to
+ * keep the source code simple we just enable it all the time
+ * when the kernel configuration allows using the feature.
+ */
+static void imx53_pmu_init(void)
+{
+	void __iomem *gpc_reg;
+	struct device_node *node;
+	u32 gpc;
+
+	if (!IS_ENABLED(CONFIG_ARM_PMU))
+		return;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,cortex-a8-pmu");
+	if (!node)
+		return;
+
+	if (!of_property_read_bool(node, "secure-reg-access"))
+		return;
+
+	gpc_reg = ioremap(MXC_CORTEXA8_PLAT_GPC, 4);
+	if (!gpc_reg) {
+		pr_warning("unable to map GPC to enable perf\n");
+		return;
+	}
+
+	gpc = readl_relaxed(gpc_reg);
+	gpc |= GPC_DBG_EN;
+	writel_relaxed(gpc, gpc_reg);
+}
+
 static void __init imx53_dt_init(void)
 {
 	imx_src_init();
-
+	imx53_pmu_init();
 	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
 }
 
-- 
2.15.1
