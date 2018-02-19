Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeBSLWH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:22:07 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37710 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeBSLWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:22:04 -0500
X-Google-Smtp-Source: AH8x226g2nuehqY45tBaY8MyhlnBO5Wm9OsEwRTihcn+iKZA02ulCOT3xNLXJmcubD94pJK+JwtfLA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] clk: meson: clean-up clk81 clocks
Date: Mon, 19 Feb 2018 12:21:46 +0100
Message-Id: <20180219112146.21746-12-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219112146.21746-1-jbrunet@baylibre.com>
References: <20180219112146.21746-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk81 is a composite clock which parents all the peripheral clocks of the
platform. It is a critical clock which is used as provided by the
bootloader. We don't want to change its rate or reparent it, ever.

Remove the CLK_IGNORE_UNUSED on the mux and divider. These clock can't
gate so the flag is useless, and the gate is already critical, so the
clock won't ever be unused.

Remove CLK_SET_RATE_NO_REPARENT from mux, it is useless since the mux is
read-only.

Remove CLK_SET_RATE_PARENT from the gate and divider and use ro_ops for
the divider. A peripheral clock should not try to change the rate of
clk81. Stopping the rate propagation is good way to make sure such request
would be ignored.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c    | 6 ++----
 drivers/clk/meson/meson8b.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 70b4669cf7d6..db5e0dcbb5aa 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -775,7 +775,6 @@ static struct clk_regmap gxbb_mpeg_clk_sel = {
 		 */
 		.parent_names = clk81_parent_names,
 		.num_parents = ARRAY_SIZE(clk81_parent_names),
-		.flags = (CLK_SET_RATE_NO_REPARENT | CLK_IGNORE_UNUSED),
 	},
 };
 
@@ -787,10 +786,9 @@ static struct clk_regmap gxbb_mpeg_clk_div = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_div",
-		.ops = &clk_regmap_divider_ops,
+		.ops = &clk_regmap_divider_ro_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_sel" },
 		.num_parents = 1,
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
 	},
 };
 
@@ -805,7 +803,7 @@ static struct clk_regmap gxbb_clk81 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_div" },
 		.num_parents = 1,
-		.flags = (CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 9c9e3d180120..b324c44d36eb 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -506,7 +506,6 @@ static struct clk_regmap meson8b_mpeg_clk_sel = {
 		.parent_names = (const char *[]){ "fclk_div3", "fclk_div4",
 			"fclk_div5" },
 		.num_parents = 3,
-		.flags = (CLK_SET_RATE_NO_REPARENT | CLK_IGNORE_UNUSED),
 	},
 };
 
@@ -518,10 +517,9 @@ struct clk_regmap meson8b_mpeg_clk_div = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_div",
-		.ops = &clk_regmap_divider_ops,
+		.ops = &clk_regmap_divider_ro_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_sel" },
 		.num_parents = 1,
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
 	},
 };
 
@@ -535,7 +533,7 @@ struct clk_regmap meson8b_clk81 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_div" },
 		.num_parents = 1,
-		.flags = (CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.14.3
