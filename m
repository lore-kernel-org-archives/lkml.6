Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FE1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69277222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfBKN6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:58:22 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:46847 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKN6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:58:22 -0500
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A3792100018;
        Mon, 11 Feb 2019 13:58:19 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] clk: clk-gpio: add support for sleeping GPIOs in gpio-gate-clk
Date:   Mon, 11 Feb 2019 14:58:18 +0100
Message-Id: <20190211135818.10518-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of gpio-gate-clk enables/disables the clock
using the GPIO in the ->enable() and ->disable() clock callbacks. This
requires the GPIO to be configurable in atomic contexts. While it is
the case for most memory-mapped GPIO controllers, it is not the case
for GPIO expanders on I2C or SPI.

This commit extends the gpio-gate-clk to check whether the GPIO calls
require sleeping or not. If sleeping is not required, the current
implementation based on ->enable()/->disable() is kept. However, if
sleeping is needed, we instead implement the logic in the ->prepare()
and ->unprepare() hooks. Thanks to this, a gate clock connected to a
GPIO on a GPIO expander can be controlled with the existing driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/clk/clk-gpio.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 6a43ce420492..f5d481713c7d 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -61,6 +61,35 @@ const struct clk_ops clk_gpio_gate_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_gpio_gate_ops);
 
+static int clk_sleeping_gpio_gate_prepare(struct clk_hw *hw)
+{
+	struct clk_gpio *clk = to_clk_gpio(hw);
+
+	gpiod_set_value_cansleep(clk->gpiod, 1);
+
+	return 0;
+}
+
+static void clk_sleeping_gpio_gate_unprepare(struct clk_hw *hw)
+{
+	struct clk_gpio *clk = to_clk_gpio(hw);
+
+	gpiod_set_value_cansleep(clk->gpiod, 0);
+}
+
+static int clk_sleeping_gpio_gate_is_prepared(struct clk_hw *hw)
+{
+	struct clk_gpio *clk = to_clk_gpio(hw);
+
+	return gpiod_get_value_cansleep(clk->gpiod);
+}
+
+const struct clk_ops clk_sleeping_gpio_gate_ops = {
+	.prepare = clk_sleeping_gpio_gate_prepare,
+	.unprepare = clk_sleeping_gpio_gate_unprepare,
+	.is_prepared = clk_sleeping_gpio_gate_is_prepared,
+};
+
 /**
  * DOC: basic clock multiplexer which can be controlled with a gpio output
  * Traits of this clock:
@@ -147,10 +176,16 @@ struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
 		const char *parent_name, struct gpio_desc *gpiod,
 		unsigned long flags)
 {
+	const struct clk_ops *ops;
+
+	if (gpiod_cansleep(gpiod))
+		ops = &clk_sleeping_gpio_gate_ops;
+	else
+		ops = &clk_gpio_gate_ops;
+
 	return clk_register_gpio(dev, name,
 			(parent_name ? &parent_name : NULL),
-			(parent_name ? 1 : 0), gpiod, flags,
-			&clk_gpio_gate_ops);
+			(parent_name ? 1 : 0), gpiod, flags, ops);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_gpio_gate);
 
-- 
2.20.1

