Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757350AbeD0C4D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 22:56:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43907 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757291AbeD0C4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 22:56:00 -0400
X-Google-Smtp-Source: AB8JxZpfpti6pQoaAYEcFD5K74jakg9qIyK4gDn94XdY/WpKdmV3k5feGutEF7OHEgbR85kJzi8WFQ==
From: Joel Stanley <joel@jms.id.au>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Ryan Chen <ryan_chen@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2] clk: aspeed: Support second reset register
Date: Fri, 27 Apr 2018 12:25:47 +0930
Message-Id: <20180427025547.14115-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ast2500 has an additional reset register that contains resets not
present in the ast2400. This enables support for this register, and adds
the one reset line that is controlled by it.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 This commit fixes a bug in aspeed_reset_assert() which determines
 the second reset register using condition.

 drivers/clk/clk-aspeed.c                 | 44 +++++++++++++++++++-----
 include/dt-bindings/clock/aspeed-clock.h |  1 +
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index c7cb1f2b6f8a..1fbf45738535 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -16,6 +16,8 @@
 
 #define ASPEED_NUM_CLKS		35
 
+#define ASPEED_RESET2_OFFSET	32
+
 #define ASPEED_RESET_CTRL	0x04
 #define ASPEED_CLK_SELECTION	0x08
 #define ASPEED_CLK_STOP_CTRL	0x0c
@@ -30,6 +32,7 @@
 #define  CLKIN_25MHZ_EN		BIT(23)
 #define  AST2400_CLK_SOURCE_SEL	BIT(18)
 #define ASPEED_CLK_SELECTION_2	0xd8
+#define ASPEED_RESET_CTRL2	0xd4
 
 /* Globally visible clocks */
 static DEFINE_SPINLOCK(aspeed_clk_lock);
@@ -291,6 +294,7 @@ struct aspeed_reset {
 #define to_aspeed_reset(p) container_of((p), struct aspeed_reset, rcdev)
 
 static const u8 aspeed_resets[] = {
+	/* SCU04 resets */
 	[ASPEED_RESET_XDMA]	= 25,
 	[ASPEED_RESET_MCTP]	= 24,
 	[ASPEED_RESET_ADC]	= 23,
@@ -300,38 +304,62 @@ static const u8 aspeed_resets[] = {
 	[ASPEED_RESET_PCIVGA]	=  8,
 	[ASPEED_RESET_I2C]	=  2,
 	[ASPEED_RESET_AHB]	=  1,
+
+	/*
+	 * SCUD4 resets start at an offset to separate them from
+	 * the SCU04 resets.
+	 */
+	[ASPEED_RESET_CRT1]	= ASPEED_RESET2_OFFSET + 5,
 };
 
 static int aspeed_reset_deassert(struct reset_controller_dev *rcdev,
 				 unsigned long id)
 {
 	struct aspeed_reset *ar = to_aspeed_reset(rcdev);
-	u32 rst = BIT(aspeed_resets[id]);
+	u32 reg = ASPEED_RESET_CTRL;
+	u32 bit = aspeed_resets[id];
+
+	if (bit >= ASPEED_RESET2_OFFSET) {
+		bit -= ASPEED_RESET2_OFFSET;
+		reg = ASPEED_RESET_CTRL2;
+	}
 
-	return regmap_update_bits(ar->map, ASPEED_RESET_CTRL, rst, 0);
+	return regmap_update_bits(ar->map, reg, BIT(bit), 0);
 }
 
 static int aspeed_reset_assert(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
 	struct aspeed_reset *ar = to_aspeed_reset(rcdev);
-	u32 rst = BIT(aspeed_resets[id]);
+	u32 reg = ASPEED_RESET_CTRL;
+	u32 bit = aspeed_resets[id];
 
-	return regmap_update_bits(ar->map, ASPEED_RESET_CTRL, rst, rst);
+	if (bit >= ASPEED_RESET2_OFFSET) {
+		bit -= ASPEED_RESET2_OFFSET;
+		reg = ASPEED_RESET_CTRL2;
+	}
+
+	return regmap_update_bits(ar->map, reg, BIT(bit), BIT(bit));
 }
 
 static int aspeed_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
 	struct aspeed_reset *ar = to_aspeed_reset(rcdev);
-	u32 val, rst = BIT(aspeed_resets[id]);
-	int ret;
+	u32 reg = ASPEED_RESET_CTRL;
+	u32 bit = aspeed_resets[id];
+	int ret, val;
+
+	if (bit >= ASPEED_RESET2_OFFSET) {
+		bit -= ASPEED_RESET2_OFFSET;
+		reg = ASPEED_RESET_CTRL2;
+	}
 
-	ret = regmap_read(ar->map, ASPEED_RESET_CTRL, &val);
+	ret = regmap_read(ar->map, reg, &val);
 	if (ret)
 		return ret;
 
-	return !!(val & rst);
+	return !!(val & BIT(bit));
 }
 
 static const struct reset_control_ops aspeed_reset_ops = {
diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index d3558d897a4d..513c1b4af7a8 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -48,5 +48,6 @@
 #define ASPEED_RESET_PCIVGA		6
 #define ASPEED_RESET_I2C		7
 #define ASPEED_RESET_AHB		8
+#define ASPEED_RESET_CRT1		9
 
 #endif
-- 
2.17.0
