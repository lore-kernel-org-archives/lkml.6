Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbeE3PKg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:10:36 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36130 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbeE3PK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:10:27 -0400
X-Google-Smtp-Source: ADUXVKIQk4UQxcDOeMoRPGpVHxjFshTtj3wMw0XKrPZFBfFn9wvyyqmwMhTjha2ybZMlDKgIjkDuIg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] clk: tegra20: Turn EMC clock gate into divider
Date: Wed, 30 May 2018 18:06:45 +0300
Message-Id: <20180530150646.19030-4-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530150646.19030-1-digetx@gmail.com>
References: <20180530150646.19030-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel should never gate the EMC clock as it causes immediate lockup, so
removing clk-gate functionality doesn't affect anything. Turning EMC clk
gate into divider allows to implement glitch-less EMC scaling, avoiding
reparenting to a backup clock.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 39 ++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index cc857d4d4a86..189dbc86ab71 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -578,7 +578,6 @@ static struct tegra_clk tegra20_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_afi] = { .dt_id = TEGRA20_CLK_AFI, .present = true },
 	[tegra_clk_fuse] = { .dt_id = TEGRA20_CLK_FUSE, .present = true },
 	[tegra_clk_kfuse] = { .dt_id = TEGRA20_CLK_KFUSE, .present = true },
-	[tegra_clk_emc] = { .dt_id = TEGRA20_CLK_EMC, .present = true },
 };
 
 static unsigned long tegra20_clk_measure_input_freq(void)
@@ -799,19 +798,18 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
 	TEGRA_INIT_DATA_NODIV("disp2",	mux_pllpdc_clkm, CLK_SOURCE_DISP2, 30, 2, 26,  0, TEGRA20_CLK_DISP2),
 };
 
-static void __init tegra20_periph_clk_init(void)
+static void __init tegra20_emc_clk_init(void)
 {
-	struct tegra_periph_init_data *data;
+	u32 emc_reg = readl_relaxed(clk_base + CLK_SOURCE_EMC);
+	u32 use_pllm_ud = BIT(29);
 	struct clk *clk;
-	unsigned int i;
 
-	/* ac97 */
-	clk = tegra_clk_register_periph_gate("ac97", "pll_a_out0",
-				    TEGRA_PERIPH_ON_APB,
-				    clk_base, 0, 3, periph_clk_enb_refcnt);
-	clks[TEGRA20_CLK_AC97] = clk;
+	if (emc_reg & use_pllm_ud) {
+		pr_err("%s: un-divided PllM_out0 used as clock source\n",
+		       __func__);
+		return;
+	}
 
-	/* emc */
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
 			       ARRAY_SIZE(mux_pllmcp_clkm),
 			       CLK_SET_RATE_NO_REPARENT,
@@ -822,6 +820,27 @@ static void __init tegra20_periph_clk_init(void)
 				    &emc_lock);
 	clks[TEGRA20_CLK_MC] = clk;
 
+	clk = clk_register_divider(NULL, "emc", "emc_mux", CLK_IS_CRITICAL,
+				   clk_base + CLK_SOURCE_EMC, 0, 7,
+				   0, &emc_lock);
+	clks[TEGRA20_CLK_EMC] = clk;
+}
+
+static void __init tegra20_periph_clk_init(void)
+{
+	struct tegra_periph_init_data *data;
+	struct clk *clk;
+	unsigned int i;
+
+	/* ac97 */
+	clk = tegra_clk_register_periph_gate("ac97", "pll_a_out0",
+				    TEGRA_PERIPH_ON_APB,
+				    clk_base, 0, 3, periph_clk_enb_refcnt);
+	clks[TEGRA20_CLK_AC97] = clk;
+
+	/* emc */
+	tegra20_emc_clk_init();
+
 	/* dsi */
 	clk = tegra_clk_register_periph_gate("dsi", "pll_d", 0, clk_base, 0,
 				    48, periph_clk_enb_refcnt);
-- 
2.17.0
