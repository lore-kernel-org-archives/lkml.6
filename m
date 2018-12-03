Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297FBC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D042120851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="S/D0g3B6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D042120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeLCK3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:29:22 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12046 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLCK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:29:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c0505660000>; Mon, 03 Dec 2018 02:28:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Dec 2018 02:28:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Dec 2018 02:28:54 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Dec
 2018 10:28:54 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Dec
 2018 10:28:53 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 10:28:53 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.11.194]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c0505630000>; Mon, 03 Dec 2018 02:28:53 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH 1/2] clk: tegra: Fix maximum audio sync clock for Tegra124/210
Date:   Mon, 3 Dec 2018 10:28:40 +0000
Message-ID: <1543832921-11661-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543832934; bh=+FzRBSN8Bp0BvTkrYAAef8WDwbAl+cHWCOroTMHqkoM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=S/D0g3B6Nsnkvm9hp4aAtBv6XWr0fgbRa8oEGBLVApDX8vI5SwEYe1aFIIg2oSxat
         MHP6Mo/GBrTuqmRWdL6revi5mITdnf1CS2mufgh9tOruuCVvErGsrC4bVs3+RHDxMU
         GxCqWQeRfhfhyspk2MJA/rf4XMPmUXIlSrCKQQYShK1SojxDD6tivzfzRjtzfjB4oH
         KoRJap4R+1t8OSiaOWjyPC1JwbbmJYe3vXn/kdgZ0ITbeHastVFNvOEMcVY/o5u4wy
         YrAuQu3ulw0Q4zgHCuyT9GCecygqgzr3A/xPvhJCocgKNfUV46TNiMki0n5/DOsrT/
         NoWMHOaNJJANw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum frequency supported for I2S on Tegra124 and Tegra210 is
24.576MHz (as stated in the Tegra TK1 data sheet for Tegra124 and the
Jetson TX1 module data sheet for Tegra210). However, the maximum I2S
frequency is limited to 24MHz because that is the maximum frequency of
the audio sync clock. Increase the maximum audio sync clock frequency
to 24.576MHz for Tegra124 and Tegra210 in order to support 24.576MHz
for I2S.

Update the tegra_clk_register_sync_source() function so that it does
not set the initial rate for the sync clocks and use the clock init
tables to set the initial rate instead.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
Resending with Thierry's ACK and CC'ing clock maintainers.

 drivers/clk/tegra/clk-audio-sync.c  | 3 +--
 drivers/clk/tegra/clk-tegra-audio.c | 7 ++-----
 drivers/clk/tegra/clk-tegra114.c    | 9 ++++++++-
 drivers/clk/tegra/clk-tegra124.c    | 9 ++++++++-
 drivers/clk/tegra/clk-tegra210.c    | 9 ++++++++-
 drivers/clk/tegra/clk-tegra30.c     | 9 ++++++++-
 drivers/clk/tegra/clk.h             | 4 ++--
 7 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/tegra/clk-audio-sync.c b/drivers/clk/tegra/clk-audio-sync.c
index 92d04ce2dee6..53cdc0ec40f3 100644
--- a/drivers/clk/tegra/clk-audio-sync.c
+++ b/drivers/clk/tegra/clk-audio-sync.c
@@ -55,7 +55,7 @@ const struct clk_ops tegra_clk_sync_source_ops = {
 };
 
 struct clk *tegra_clk_register_sync_source(const char *name,
-		unsigned long rate, unsigned long max_rate)
+					   unsigned long max_rate)
 {
 	struct tegra_clk_sync_source *sync;
 	struct clk_init_data init;
@@ -67,7 +67,6 @@ struct clk *tegra_clk_register_sync_source(const char *name,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	sync->rate = rate;
 	sync->max_rate = max_rate;
 
 	init.ops = &tegra_clk_sync_source_ops;
diff --git a/drivers/clk/tegra/clk-tegra-audio.c b/drivers/clk/tegra/clk-tegra-audio.c
index b37cae7af26d..02dd6487d855 100644
--- a/drivers/clk/tegra/clk-tegra-audio.c
+++ b/drivers/clk/tegra/clk-tegra-audio.c
@@ -49,8 +49,6 @@ struct tegra_sync_source_initdata {
 #define SYNC(_name) \
 	{\
 		.name		= #_name,\
-		.rate		= 24000000,\
-		.max_rate	= 24000000,\
 		.clk_id		= tegra_clk_ ## _name,\
 	}
 
@@ -176,7 +174,7 @@ static void __init tegra_audio_sync_clk_init(void __iomem *clk_base,
 void __init tegra_audio_clk_init(void __iomem *clk_base,
 			void __iomem *pmc_base, struct tegra_clk *tegra_clks,
 			struct tegra_audio_clk_info *audio_info,
-			unsigned int num_plls)
+			unsigned int num_plls, unsigned long sync_max_rate)
 {
 	struct clk *clk;
 	struct clk **dt_clk;
@@ -221,8 +219,7 @@ void __init tegra_audio_clk_init(void __iomem *clk_base,
 		if (!dt_clk)
 			continue;
 
-		clk = tegra_clk_register_sync_source(data->name,
-					data->rate, data->max_rate);
+		clk = tegra_clk_register_sync_source(data->name, sync_max_rate);
 		*dt_clk = clk;
 	}
 
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 1824f014202b..625d11091330 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1190,6 +1190,13 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA114_CLK_XUSB_FALCON_SRC, TEGRA114_CLK_PLL_P, 204000000, 0 },
 	{ TEGRA114_CLK_XUSB_HOST_SRC, TEGRA114_CLK_PLL_P, 102000000, 0 },
 	{ TEGRA114_CLK_VDE, TEGRA114_CLK_CLK_MAX, 600000000, 0 },
+	{ TEGRA114_CLK_SPDIF_IN_SYNC, TEGRA114_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA114_CLK_I2S0_SYNC, TEGRA114_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA114_CLK_I2S1_SYNC, TEGRA114_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA114_CLK_I2S2_SYNC, TEGRA114_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA114_CLK_I2S3_SYNC, TEGRA114_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA114_CLK_I2S4_SYNC, TEGRA114_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA114_CLK_VIMCLK_SYNC, TEGRA114_CLK_CLK_MAX, 24000000, 0 },
 	/* must be the last entry */
 	{ TEGRA114_CLK_CLK_MAX, TEGRA114_CLK_CLK_MAX, 0, 0 },
 };
@@ -1362,7 +1369,7 @@ static void __init tegra114_clock_init(struct device_node *np)
 	tegra114_periph_clk_init(clk_base, pmc_base);
 	tegra_audio_clk_init(clk_base, pmc_base, tegra114_clks,
 			     tegra114_audio_plls,
-			     ARRAY_SIZE(tegra114_audio_plls));
+			     ARRAY_SIZE(tegra114_audio_plls), 24000000);
 	tegra_pmc_clk_init(pmc_base, tegra114_clks);
 	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra114_clks,
 					&pll_x_params);
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index b6cf28ca2ed2..df0018f7bf7e 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1291,6 +1291,13 @@ static struct tegra_clk_init_table common_init_table[] __initdata = {
 	{ TEGRA124_CLK_CSITE, TEGRA124_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA124_CLK_TSENSOR, TEGRA124_CLK_CLK_M, 400000, 0 },
 	{ TEGRA124_CLK_VIC03, TEGRA124_CLK_PLL_C3, 0, 0 },
+	{ TEGRA124_CLK_SPDIF_IN_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA124_CLK_I2S0_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA124_CLK_I2S1_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA124_CLK_I2S2_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA124_CLK_I2S3_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA124_CLK_I2S4_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA124_CLK_VIMCLK_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
 	/* must be the last entry */
 	{ TEGRA124_CLK_CLK_MAX, TEGRA124_CLK_CLK_MAX, 0, 0 },
 };
@@ -1455,7 +1462,7 @@ static void __init tegra124_132_clock_init_pre(struct device_node *np)
 	tegra124_periph_clk_init(clk_base, pmc_base);
 	tegra_audio_clk_init(clk_base, pmc_base, tegra124_clks,
 			     tegra124_audio_plls,
-			     ARRAY_SIZE(tegra124_audio_plls));
+			     ARRAY_SIZE(tegra124_audio_plls), 24576000);
 	tegra_pmc_clk_init(pmc_base, tegra124_clks);
 
 	/* For Tegra124 & Tegra132, PLLD is the only source for DSIA & DSIB */
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 88f1943bd2b5..7545af763d7a 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3370,6 +3370,13 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA210_CLK_CCLK_G, TEGRA210_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA210_CLK_PLL_U_OUT1, TEGRA210_CLK_CLK_MAX, 48000000, 1 },
 	{ TEGRA210_CLK_PLL_U_OUT2, TEGRA210_CLK_CLK_MAX, 60000000, 1 },
+	{ TEGRA210_CLK_SPDIF_IN_SYNC, TEGRA210_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA210_CLK_I2S0_SYNC, TEGRA210_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA210_CLK_I2S1_SYNC, TEGRA210_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA210_CLK_I2S2_SYNC, TEGRA210_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA210_CLK_I2S3_SYNC, TEGRA210_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA210_CLK_I2S4_SYNC, TEGRA210_CLK_CLK_MAX, 24576000, 0 },
+	{ TEGRA210_CLK_VIMCLK_SYNC, TEGRA210_CLK_CLK_MAX, 24576000, 0 },
 	/* This MUST be the last entry. */
 	{ TEGRA210_CLK_CLK_MAX, TEGRA210_CLK_CLK_MAX, 0, 0 },
 };
@@ -3563,7 +3570,7 @@ static void __init tegra210_clock_init(struct device_node *np)
 	tegra210_periph_clk_init(clk_base, pmc_base);
 	tegra_audio_clk_init(clk_base, pmc_base, tegra210_clks,
 			     tegra210_audio_plls,
-			     ARRAY_SIZE(tegra210_audio_plls));
+			     ARRAY_SIZE(tegra210_audio_plls), 24576000);
 	tegra_pmc_clk_init(pmc_base, tegra210_clks);
 
 	/* For Tegra210, PLLD is the only source for DSIA & DSIB */
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index acfe661b2ae7..e0aaecd98fbf 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1267,6 +1267,13 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_GR3D2, TEGRA30_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA30_CLK_PLL_U, TEGRA30_CLK_CLK_MAX, 480000000, 0 },
 	{ TEGRA30_CLK_VDE, TEGRA30_CLK_CLK_MAX, 600000000, 0 },
+	{ TEGRA30_CLK_SPDIF_IN_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA30_CLK_I2S0_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA30_CLK_I2S1_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA30_CLK_I2S2_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA30_CLK_I2S3_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA30_CLK_I2S4_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA30_CLK_VIMCLK_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	/* must be the last entry */
 	{ TEGRA30_CLK_CLK_MAX, TEGRA30_CLK_CLK_MAX, 0, 0 },
 };
@@ -1344,7 +1351,7 @@ static void __init tegra30_clock_init(struct device_node *np)
 	tegra30_periph_clk_init();
 	tegra_audio_clk_init(clk_base, pmc_base, tegra30_clks,
 			     tegra30_audio_plls,
-			     ARRAY_SIZE(tegra30_audio_plls));
+			     ARRAY_SIZE(tegra30_audio_plls), 24000000);
 	tegra_pmc_clk_init(pmc_base, tegra30_clks);
 
 	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA30_CLK_CLK_MAX);
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index d2c3a010f8e9..09bccbb9640c 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -41,7 +41,7 @@ extern const struct clk_ops tegra_clk_sync_source_ops;
 extern int *periph_clk_enb_refcnt;
 
 struct clk *tegra_clk_register_sync_source(const char *name,
-		unsigned long fixed_rate, unsigned long max_rate);
+					   unsigned long max_rate);
 
 /**
  * struct tegra_clk_frac_div - fractional divider clock
@@ -796,7 +796,7 @@ void tegra_register_devclks(struct tegra_devclk *dev_clks, int num);
 void tegra_audio_clk_init(void __iomem *clk_base,
 			void __iomem *pmc_base, struct tegra_clk *tegra_clks,
 			struct tegra_audio_clk_info *audio_info,
-			unsigned int num_plls);
+			unsigned int num_plls, unsigned long sync_max_rate);
 
 void tegra_periph_clk_init(void __iomem *clk_base, void __iomem *pmc_base,
 			struct tegra_clk *tegra_clks,
-- 
2.7.4

