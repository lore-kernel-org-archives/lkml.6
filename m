Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeECW4V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:56:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39663 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbeECW4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:56:17 -0400
X-Google-Smtp-Source: AB8JxZqv9S53B8TaRaNFom+EeRh+bO2NG7z30nC1ME20eFCxwQtiqZcTxQj+zBFeDf8cu1G5I2wajQ==
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
Subject: [PATCH v2 1/4] clk: tegra20: Add DEV1/DEV2 OSC dividers
Date: Fri,  4 May 2018 01:55:33 +0300
Message-Id: <20180503225537.20748-2-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503225537.20748-1-digetx@gmail.com>
References: <20180503225537.20748-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CDEV1/CDEV2 clocks could have corresponding oscillator clock divider as
a parent. Add these dividers in order to be able to provide that parent
option.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Marc Dietrich <marvin24@gmx.de>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/tegra/clk-tegra20.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 0ee56dd04cec..ad5a7b5e3a39 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -26,6 +26,8 @@
 #include "clk.h"
 #include "clk-id.h"
 
+#define MISC_CLK_ENB 0x48
+
 #define OSC_CTRL 0x50
 #define OSC_CTRL_OSC_FREQ_MASK (3<<30)
 #define OSC_CTRL_OSC_FREQ_13MHZ (0<<30)
@@ -831,6 +833,18 @@ static void __init tegra20_periph_clk_init(void)
 				    periph_clk_enb_refcnt);
 	clks[TEGRA20_CLK_PEX] = clk;
 
+	/* dev1 OSC divider */
+	clk_register_divider(NULL, "dev1_osc_div", "clk_m",
+			     0, clk_base + MISC_CLK_ENB, 22, 2,
+			     CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
+			     NULL);
+
+	/* dev2 OSC divider */
+	clk_register_divider(NULL, "dev2_osc_div", "clk_m",
+			     0, clk_base + MISC_CLK_ENB, 20, 2,
+			     CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY,
+			     NULL);
+
 	/* cdev1 */
 	clk = clk_register_fixed_rate(NULL, "cdev1_fixed", NULL, 0, 26000000);
 	clk = tegra_clk_register_periph_gate("cdev1", "cdev1_fixed", 0,
-- 
2.17.0
