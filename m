Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeFDFey (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 01:34:54 -0400
Received: from atl4mhob10.registeredsite.com ([209.17.115.48]:43802 "EHLO
        atl4mhob10.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751356AbeFDFex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 01:34:53 -0400
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] clk-si514, clk-si544: Implement prepare/unprepare/is_prepared operations
Date: Mon,  4 Jun 2018 07:34:39 +0200
Message-Id: <1528090479-20861-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds prepare/unprepare/is_prepared functionality to the drivers for
the SI544 and SI514 chips, allowing the clock output to be disabled when
the clock is not in use.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clk/clk-si514.c | 38 +++++++++++++++++++++++++++++++++++++-
 drivers/clk/clk-si544.c | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-si514.c b/drivers/clk/clk-si514.c
index 09b6718..153b3a2 100644
--- a/drivers/clk/clk-si514.c
+++ b/drivers/clk/clk-si514.c
@@ -74,6 +74,33 @@ static int si514_enable_output(struct clk_si514 *data, bool enable)
 		SI514_CONTROL_OE, enable ? SI514_CONTROL_OE : 0);
 }
 
+static int si514_prepare(struct clk_hw *hw)
+{
+	struct clk_si514 *data = to_clk_si514(hw);
+
+	return si514_enable_output(data, true);
+}
+
+static void si514_unprepare(struct clk_hw *hw)
+{
+	struct clk_si514 *data = to_clk_si514(hw);
+
+	si514_enable_output(data, false);
+}
+
+static int si514_is_prepared(struct clk_hw *hw)
+{
+	struct clk_si514 *data = to_clk_si514(hw);
+	unsigned int val;
+	int err;
+
+	err = regmap_read(data->regmap, SI514_REG_CONTROL, &val);
+	if (err < 0)
+		return err;
+
+	return !!(val & SI514_CONTROL_OE);
+}
+
 /* Retrieve clock multiplier and dividers from hardware */
 static int si514_get_muldiv(struct clk_si514 *data,
 	struct clk_si514_muldiv *settings)
@@ -235,12 +262,17 @@ static int si514_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_si514 *data = to_clk_si514(hw);
 	struct clk_si514_muldiv settings;
+	unsigned int old_oe_state;
 	int err;
 
 	err = si514_calc_muldiv(&settings, rate);
 	if (err)
 		return err;
 
+	err = regmap_read(data->regmap, SI514_REG_CONTROL, &old_oe_state);
+	if (err)
+		return err;
+
 	si514_enable_output(data, false);
 
 	err = si514_set_muldiv(data, &settings);
@@ -255,12 +287,16 @@ static int si514_set_rate(struct clk_hw *hw, unsigned long rate,
 	/* Applying a new frequency can take up to 10ms */
 	usleep_range(10000, 12000);
 
-	si514_enable_output(data, true);
+	if (old_oe_state & SI514_CONTROL_OE)
+		si514_enable_output(data, true);
 
 	return err;
 }
 
 static const struct clk_ops si514_clk_ops = {
+	.prepare = si514_prepare,
+	.unprepare = si514_unprepare,
+	.is_prepared = si514_is_prepared,
 	.recalc_rate = si514_recalc_rate,
 	.round_rate = si514_round_rate,
 	.set_rate = si514_set_rate,
diff --git a/drivers/clk/clk-si544.c b/drivers/clk/clk-si544.c
index e972ffb..f8ed9d9 100644
--- a/drivers/clk/clk-si544.c
+++ b/drivers/clk/clk-si544.c
@@ -86,6 +86,34 @@ static int si544_enable_output(struct clk_si544 *data, bool enable)
 		SI544_OE_STATE_ODC_OE, enable ? SI544_OE_STATE_ODC_OE : 0);
 }
 
+static int si544_prepare(struct clk_hw *hw)
+{
+	struct clk_si544 *data = to_clk_si544(hw);
+
+	return si544_enable_output(data, true);
+}
+
+static void si544_unprepare(struct clk_hw *hw)
+{
+	struct clk_si544 *data = to_clk_si544(hw);
+
+	si544_enable_output(data, false);
+}
+
+static int si544_is_prepared(struct clk_hw *hw)
+{
+	struct clk_si544 *data = to_clk_si544(hw);
+	unsigned int val;
+	int err;
+
+	err = regmap_read(data->regmap, SI544_REG_OE_STATE, &val);
+	if (err < 0)
+		return err;
+
+	return !!(val & SI544_OE_STATE_ODC_OE);
+}
+
+
 /* Retrieve clock multiplier and dividers from hardware */
 static int si544_get_muldiv(struct clk_si544 *data,
 	struct clk_si544_muldiv *settings)
@@ -273,6 +301,7 @@ static int si544_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_si544 *data = to_clk_si544(hw);
 	struct clk_si544_muldiv settings;
+	unsigned int old_oe_state;
 	int err;
 
 	if (!is_valid_frequency(data, rate))
@@ -282,6 +311,10 @@ static int si544_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (err)
 		return err;
 
+	err = regmap_read(data->regmap, SI544_REG_OE_STATE, &old_oe_state);
+	if (err)
+		return err;
+
 	si544_enable_output(data, false);
 
 	/* Allow FCAL for this frequency update */
@@ -303,12 +336,16 @@ static int si544_set_rate(struct clk_hw *hw, unsigned long rate,
 	/* Applying a new frequency can take up to 10ms */
 	usleep_range(10000, 12000);
 
-	si544_enable_output(data, true);
+	if (old_oe_state & SI544_OE_STATE_ODC_OE)
+		si544_enable_output(data, true);
 
 	return err;
 }
 
 static const struct clk_ops si544_clk_ops = {
+	.prepare = si544_prepare,
+	.unprepare = si544_unprepare,
+	.is_prepared = si544_is_prepared,
 	.recalc_rate = si544_recalc_rate,
 	.round_rate = si544_round_rate,
 	.set_rate = si544_set_rate,
-- 
1.9.1
