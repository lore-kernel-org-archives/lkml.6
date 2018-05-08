Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933050AbeEHQ30 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:29:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35059 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932735AbeEHQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:29:23 -0400
X-Google-Smtp-Source: AB8JxZqqMZJON+JPv+b48RixPuGBPaWsPM4Sssx4/ZXSlBexYrgpslr5nqr839WTiJHuG0iJ+C5Syw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>
Cc: linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] clk: tegra: Add quirk for getting CDEV1/2 clocks on Tegra20
Date: Tue,  8 May 2018 19:26:06 +0300
Message-Id: <20180508162607.3500-5-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508162607.3500-1-digetx@gmail.com>
References: <20180508162607.3500-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CDEV1 and CDEV2 clocks are a bit special case, their parent clock is
created by the pinctrl driver. It should be possible for clk user to
request these clocks before pinctrl driver got probed and hence user will
get an orphaned clock. That might be undesirable because user may expect
parent clock to be enabled by the child, so let's return -EPROBE_DEFER
till parent clock appears.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra114.c |  2 +-
 drivers/clk/tegra/clk-tegra124.c |  2 +-
 drivers/clk/tegra/clk-tegra20.c  | 32 +++++++++++++++++++++++++++++++-
 drivers/clk/tegra/clk-tegra210.c |  2 +-
 drivers/clk/tegra/clk-tegra30.c  |  2 +-
 drivers/clk/tegra/clk.c          |  5 +++--
 drivers/clk/tegra/clk.h          |  2 +-
 7 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 5d5a22d529f5..1824f014202b 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1367,7 +1367,7 @@ static void __init tegra114_clock_init(struct device_node *np)
 	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra114_clks,
 					&pll_x_params);
 
-	tegra_add_of_provider(np);
+	tegra_add_of_provider(np, of_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra_clk_apply_init_table = tegra114_clock_apply_init_table;
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 50088e976611..0c69c7970950 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1479,7 +1479,7 @@ static void __init tegra124_132_clock_init_post(struct device_node *np)
 				  &pll_x_params);
 	tegra_init_special_resets(1, tegra124_reset_assert,
 				  tegra124_reset_deassert);
-	tegra_add_of_provider(np);
+	tegra_add_of_provider(np, of_clk_src_onecell_get);
 
 	clks[TEGRA124_CLK_EMC] = tegra_clk_register_emc(clk_base, np,
 							&emc_lock);
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 636500a98561..cc857d4d4a86 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1089,6 +1089,36 @@ static const struct of_device_id pmc_match[] __initconst = {
 	{ },
 };
 
+static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
+					       void *data)
+{
+	struct clk_hw *parent_hw;
+	struct clk_hw *hw;
+	struct clk *clk;
+
+	clk = of_clk_src_onecell_get(clkspec, data);
+	if (IS_ERR(clk))
+		return clk;
+
+	/*
+	 * Tegra20 CDEV1 and CDEV2 clocks are a bit special case, their parent
+	 * clock is created by the pinctrl driver. It is possible for clk user
+	 * to request these clocks before pinctrl driver got probed and hence
+	 * user will get an orphaned clock. That might be undesirable because
+	 * user may expect parent clock to be enabled by the child.
+	 */
+	if (clkspec->args[0] == TEGRA20_CLK_CDEV1 ||
+	    clkspec->args[0] == TEGRA20_CLK_CDEV2) {
+		hw = __clk_get_hw(clk);
+
+		parent_hw = clk_hw_get_parent(hw);
+		if (!parent_hw)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return clk;
+}
+
 static void __init tegra20_clock_init(struct device_node *np)
 {
 	struct device_node *node;
@@ -1127,7 +1157,7 @@ static void __init tegra20_clock_init(struct device_node *np)
 
 	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA20_CLK_CLK_MAX);
 
-	tegra_add_of_provider(np);
+	tegra_add_of_provider(np, tegra20_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra_clk_apply_init_table = tegra20_clock_apply_init_table;
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 9fb5d51ccce4..5435d01c636a 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3567,7 +3567,7 @@ static void __init tegra210_clock_init(struct device_node *np)
 	tegra_init_special_resets(2, tegra210_reset_assert,
 				  tegra210_reset_deassert);
 
-	tegra_add_of_provider(np);
+	tegra_add_of_provider(np, of_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra210_mbist_clk_init();
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index b316dfb6f6c7..acfe661b2ae7 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1349,7 +1349,7 @@ static void __init tegra30_clock_init(struct device_node *np)
 
 	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA30_CLK_CLK_MAX);
 
-	tegra_add_of_provider(np);
+	tegra_add_of_provider(np, of_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra_clk_apply_init_table = tegra30_clock_apply_init_table;
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index ba923f0d5953..593d76a114f9 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -298,7 +298,8 @@ static struct reset_controller_dev rst_ctlr = {
 	.of_reset_n_cells = 1,
 };
 
-void __init tegra_add_of_provider(struct device_node *np)
+void __init tegra_add_of_provider(struct device_node *np,
+				  void *clk_src_onecell_get)
 {
 	int i;
 
@@ -314,7 +315,7 @@ void __init tegra_add_of_provider(struct device_node *np)
 
 	clk_data.clks = clks;
 	clk_data.clk_num = clk_num;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_provider(np, clk_src_onecell_get, &clk_data);
 
 	rst_ctlr.of_node = np;
 	rst_ctlr.nr_resets = periph_banks * 32 + num_special_reset;
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index ba7e20e6a82b..e1f88463b600 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -763,7 +763,7 @@ struct clk **tegra_clk_init(void __iomem *clk_base, int num, int periph_banks);
 
 struct clk **tegra_lookup_dt_id(int clk_id, struct tegra_clk *tegra_clk);
 
-void tegra_add_of_provider(struct device_node *np);
+void tegra_add_of_provider(struct device_node *np, void *clk_src_onecell_get);
 void tegra_register_devclks(struct tegra_devclk *dev_clks, int num);
 
 void tegra_audio_clk_init(void __iomem *clk_base,
-- 
2.17.0
