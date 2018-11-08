Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7931C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E45A20883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHxAPcsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E45A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbeKIHqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731252AbeKIHqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:46:06 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 365CC2089F;
        Thu,  8 Nov 2018 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714915;
        bh=qtoOftedPXLy67AZQw0jG1QXzXAkS32IJDxoYpQvyzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHxAPcsnJ2ii32Jhf58OkqN4agUBIgvCYwMJpjLhnnr91yNhojR2++fX4nB6K/DVm
         tOk5Q0HOGf2hiZ2WS18CAUBo+fHCxOoKmrdoq+h0aGemWraHKzmRrs5fcuNLYomwOr
         3vDY7PWyXwe+j3wkxw+BFm5J3y+3JUTXknDnZMn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/31] clk: tegra: Add quirk for getting CDEV1/2 clocks on Tegra20
Date:   Thu,  8 Nov 2018 13:52:31 -0800
Message-Id: <20181108215130.285950754@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
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

[ Upstream commit 5d797111afe12e488e08432fd9b372fae2cc7e93 ]

CDEV1 and CDEV2 clocks are a bit special case, their parent clock is
created by the pinctrl driver. It should be possible for clk user to
request these clocks before pinctrl driver got probed and hence user will
get an orphaned clock. That might be undesirable because user may expect
parent clock to be enabled by the child, so let's return -EPROBE_DEFER
till parent clock appears.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index fd1a99c05c2d..f94d1c016643 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1369,7 +1369,7 @@ static void __init tegra114_clock_init(struct device_node *np)
 	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra114_clks,
 					&pll_x_params);
 
-	tegra_add_of_provider(np);
+	tegra_add_of_provider(np, of_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra_clk_apply_init_table = tegra114_clock_apply_init_table;
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index e81ea5b11577..e08df2faafd7 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1480,7 +1480,7 @@ static void __init tegra124_132_clock_init_post(struct device_node *np)
 				  &pll_x_params);
 	tegra_init_special_resets(1, tegra124_reset_assert,
 				  tegra124_reset_deassert);
-	tegra_add_of_provider(np);
+	tegra_add_of_provider(np, of_clk_src_onecell_get);
 
 	clks[TEGRA124_CLK_EMC] = tegra_clk_register_emc(clk_base, np,
 							&emc_lock);
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 837e5cbd60e9..532322b3d717 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1084,6 +1084,36 @@ static const struct of_device_id pmc_match[] __initconst = {
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
@@ -1122,7 +1152,7 @@ static void __init tegra20_clock_init(struct device_node *np)
 
 	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA20_CLK_CLK_MAX);
 
-	tegra_add_of_provider(np);
+	tegra_add_of_provider(np, tegra20_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra_clk_apply_init_table = tegra20_clock_apply_init_table;
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index b92867814e2d..b57193fba643 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3169,7 +3169,7 @@ static void __init tegra210_clock_init(struct device_node *np)
 	tegra_init_special_resets(2, tegra210_reset_assert,
 				  tegra210_reset_deassert);
 
-	tegra_add_of_provider(np);
+	tegra_add_of_provider(np, of_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra_cpu_car_ops = &tegra210_cpu_car_ops;
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 07f5203df01c..80748e7925f8 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1355,7 +1355,7 @@ static void __init tegra30_clock_init(struct device_node *np)
 
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
index 872f1189ad7f..a282a12637e3 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -760,7 +760,7 @@ struct clk **tegra_clk_init(void __iomem *clk_base, int num, int periph_banks);
 
 struct clk **tegra_lookup_dt_id(int clk_id, struct tegra_clk *tegra_clk);
 
-void tegra_add_of_provider(struct device_node *np);
+void tegra_add_of_provider(struct device_node *np, void *clk_src_onecell_get);
 void tegra_register_devclks(struct tegra_devclk *dev_clks, int num);
 
 void tegra_audio_clk_init(void __iomem *clk_base,
-- 
2.17.1



