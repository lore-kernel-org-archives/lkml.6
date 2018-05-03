Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeECW4n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:56:43 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41363 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeECW4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:56:20 -0400
X-Google-Smtp-Source: AB8JxZrcFeh3We+yeiPo3Ko7AzCSpaRTSM/3aN75AOXSF1pVFrT1gKAo1C8b7wutA/SSF1qetswAxw==
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
Subject: [PATCH v2 3/4] clk: tegra: Add quirk for getting CDEV1/2 clocks
Date: Fri,  4 May 2018 01:55:36 +0300
Message-Id: <20180503225537.20748-5-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503225537.20748-1-digetx@gmail.com>
References: <20180503225537.20748-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CDEV1 and CDEV2 clocks are a bit special case, their parent clock is
created by the pinctrl driver. It should be possible for clk user to
request these clocks before pinctrl driver got probed and hence user will
get an orphaned clock. That might be undesirable because user expects
parent clock to be enabled by the child, so let's return EPROBE_DEFER
until parent clock appear.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index ba923f0d5953..04cbe7e9eff3 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -298,6 +298,38 @@ static struct reset_controller_dev rst_ctlr = {
 	.of_reset_n_cells = 1,
 };
 
+static struct clk *tegra_of_clk_src_onecell_get(struct of_phandle_args *clkspec,
+						void *data)
+{
+	struct clk_hw *parent_hw;
+	struct clk_hw *hw;
+	struct clk *clk;
+	const char *name;
+
+	clk = of_clk_src_onecell_get(clkspec, data);
+	if (IS_ERR(clk))
+		return clk;
+
+	name = __clk_get_name(clk);
+
+	/*
+	 * Tegra20 CDEV1 and CDEV2 clocks are a bit special case, their parent
+	 * clock is created by the pinctrl driver. It is possible for clk user
+	 * to request these clocks before pinctrl driver got probed and hence
+	 * user will get an orphaned clock. That might be undesirable because
+	 * user may expect parent clock to be enabled by the child.
+	 */
+	if (!strcmp(name, "cdev1") || !strcmp(name, "cdev2")) {
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
 void __init tegra_add_of_provider(struct device_node *np)
 {
 	int i;
@@ -314,7 +346,7 @@ void __init tegra_add_of_provider(struct device_node *np)
 
 	clk_data.clks = clks;
 	clk_data.clk_num = clk_num;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_provider(np, tegra_of_clk_src_onecell_get, &clk_data);
 
 	rst_ctlr.of_node = np;
 	rst_ctlr.nr_resets = periph_banks * 32 + num_special_reset;
-- 
2.17.0
