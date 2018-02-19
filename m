Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeBSLV6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:21:58 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52088 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeBSLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:21:54 -0500
X-Google-Smtp-Source: AH8x227U8G9wQzgpIZz83znUwXZKld2qAs8jKXcnuAqOQCyv8QgRMZeSBGzt8wxNd2R2BUiIH0HTyg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] clk: meson: poke pll CNTL last
Date: Mon, 19 Feb 2018 12:21:37 +0100
Message-Id: <20180219112146.21746-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219112146.21746-1-jbrunet@baylibre.com>
References: <20180219112146.21746-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Poking CNTL first may take the PLL out of reset while we are still
applying the initial settings, including the filter values
initialization. This is the case for the axg and gxl gp0 pll.

Doing this poke last ensures the pll stays in reset while the initial
settings are applied.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c  | 2 +-
 drivers/clk/meson/gxbb.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index acb63c8e0fd8..8226b82c67fd 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -193,12 +193,12 @@ static const struct pll_rate_table axg_gp0_pll_rate_table[] = {
 };
 
 const struct reg_sequence axg_gp0_init_regs[] = {
-	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x40010250 },
 	{ .reg = HHI_GP0_PLL_CNTL1,	.def = 0xc084a000 },
 	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0xb75020be },
 	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a59a288 },
 	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0xc000004d },
 	{ .reg = HHI_GP0_PLL_CNTL5,	.def = 0x00078000 },
+	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x40010250 },
 };
 
 static struct clk_regmap axg_gp0_pll = {
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index bb0b0529ca81..3cd07f960489 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -390,10 +390,10 @@ static struct clk_regmap gxbb_sys_pll = {
 };
 
 const struct reg_sequence gxbb_gp0_init_regs[] = {
-	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x6a000228 },
 	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0x69c80000 },
 	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a5590c4 },
 	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0x0000500d },
+	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x4a000228 },
 };
 
 static struct clk_regmap gxbb_gp0_pll = {
@@ -437,12 +437,12 @@ static struct clk_regmap gxbb_gp0_pll = {
 };
 
 const struct reg_sequence gxl_gp0_init_regs[] = {
-	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x40010250 },
 	{ .reg = HHI_GP0_PLL_CNTL1,	.def = 0xc084a000 },
 	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0xb75020be },
 	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a59a288 },
 	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0xc000004d },
 	{ .reg = HHI_GP0_PLL_CNTL5,	.def = 0x00078000 },
+	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x40010250 },
 };
 
 static struct clk_regmap gxl_gp0_pll = {
-- 
2.14.3
