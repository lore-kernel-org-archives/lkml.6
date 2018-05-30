Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932142AbeE3S2Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:28:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33934 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753912AbeE3S2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:28:13 -0400
X-Google-Smtp-Source: ADUXVKLkC9y+XwTEr5zZor6j/1CrIcUbbkKPcFYaasS/4SKMbn9k+Sqjj/F9GJ+EUg7ki5z4MdceFw==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        stable@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4] rtc: sun6i: Fix bit_idx value for clk_register_gate
Date: Wed, 30 May 2018 23:57:44 +0530
Message-Id: <20180530182744.27611-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

clk-gate core will take bit_idx through clk_register_gate
and then do clk_gate_ops by using BIT(bit_idx), but rtc-sun6i
is passing bit_idx as BIT(bit_idx) it becomes BIT(BIT(bit_idx)
which is wrong and eventually external gate clock is not enabling.

This patch fixed by passing bit index and the original change
introduced from below commit.
"rtc: sun6i: Add support for the external oscillator gate"
(sha1: 	17ecd246414b3a0fe0cb248c86977a8bda465b7b)

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Fixes: 17ecd246414b ("rtc: sun6i: Add support for the external oscillator gate")
Cc: stable@vger.kernel.org
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- Cc to stable tree
Changes for v3:
- add fixes tag
- Cced stable ML
Changes for v2:
- add suffix _OFFSET with macro name to distinguish b/w
  register actual values vs offset.

 drivers/rtc/rtc-sun6i.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 2e6fb275acc8..2cd5a7b1a2e3 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -74,7 +74,7 @@
 #define SUN6I_ALARM_CONFIG_WAKEUP		BIT(0)
 
 #define SUN6I_LOSC_OUT_GATING			0x0060
-#define SUN6I_LOSC_OUT_GATING_EN		BIT(0)
+#define SUN6I_LOSC_OUT_GATING_EN_OFFSET		0
 
 /*
  * Get date values
@@ -255,7 +255,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 				      &clkout_name);
 	rtc->ext_losc = clk_register_gate(NULL, clkout_name, rtc->hw.init->name,
 					  0, rtc->base + SUN6I_LOSC_OUT_GATING,
-					  SUN6I_LOSC_OUT_GATING_EN, 0,
+					  SUN6I_LOSC_OUT_GATING_EN_OFFSET, 0,
 					  &rtc->lock);
 	if (IS_ERR(rtc->ext_losc)) {
 		pr_crit("Couldn't register the LOSC external gate\n");
-- 
2.14.3
