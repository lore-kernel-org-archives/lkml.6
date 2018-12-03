Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7631EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA7F20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA7F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeLCO7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:59:13 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:50874 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeLCO6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:58:36 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 728AE5FD90; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v2 06/14] rtc: sun6i: Add support for different variants
Date:   Mon,  3 Dec 2018 22:58:17 +0800
Message-Id: <20181203145825.20511-7-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amongst the Allwinner SoCs that have seen some kind of coverage by the
linux-sunxi community, whether it be mainline Linux or U-boot support,
or just available datasheets, most newer chips use the RTC design first
seen in the A31 (sun6i).

Overall there have been some minor differences. This patch covers the
following:

  - average clock rate of the internal RC oscillator
    + presence of fixed and adjustable prescaler for this clock
  - availability of an external (to the SoC) clock output

One major difference regarding the H6 is the 24 MHz crystal is now
routed through the RTC, as a digitally compensated oscillator (DCXO).
This is not covered in this patch and will be supported later.

Other differences are either unrelated to RTC or clock functionality,
such as boot or crypto related registers, or the driver simply doesn't
use the feature in question. One example of the latter is the
calibration function for the RC oscillator. We consider this clock to
be very bad and avoid using it.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 58 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 8edd9e1ec007..d1866d90b9ef 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -118,9 +118,30 @@
 #define SUN6I_YEAR_MAX				2033
 #define SUN6I_YEAR_OFF				(SUN6I_YEAR_MIN - 1900)
 
+/*
+ * There are other differences between models, including:
+ *
+ *   - number of GPIO pins that can be configured to hold a certain level
+ *   - crypto-key related registers (H5, H6)
+ *   - boot process related (super standby, secondary processor entry address)
+ *     registers (R40, H6)
+ *   - SYS power domain controls (R40)
+ *   - DCXO controls (H6)
+ *   - RC oscillator calibration (H6)
+ *
+ * These functions are not covered by this driver.
+ */
+struct sun6i_rtc_clk_data {
+	unsigned long rc_osc_rate;
+	unsigned int fixed_prescaler : 16;
+	unsigned int has_prescaler : 1;
+	unsigned int has_out_clk : 1;
+};
+
 struct sun6i_rtc_dev {
 	struct rtc_device *rtc;
 	struct device *dev;
+	const struct sun6i_rtc_clk_data *data;
 	void __iomem *base;
 	int irq;
 	unsigned long alarm;
@@ -139,14 +160,19 @@ static unsigned long sun6i_rtc_osc_recalc_rate(struct clk_hw *hw,
 					       unsigned long parent_rate)
 {
 	struct sun6i_rtc_dev *rtc = container_of(hw, struct sun6i_rtc_dev, hw);
-	u32 val;
+	u32 val = 0;
 
 	val = readl(rtc->base + SUN6I_LOSC_CTRL);
 	if (val & SUN6I_LOSC_CTRL_EXT_OSC)
 		return parent_rate;
 
-	val = readl(rtc->base + SUN6I_LOSC_CLK_PRESCAL);
-	val &= GENMASK(4, 0);
+	if (rtc->data->fixed_prescaler)
+		parent_rate /= rtc->data->fixed_prescaler;
+
+	if (rtc->data->has_prescaler) {
+		val = readl(rtc->base + SUN6I_LOSC_CLK_PRESCAL);
+		val &= GENMASK(4, 0);
+	}
 
 	return parent_rate / (val + 1);
 }
@@ -185,7 +211,8 @@ static const struct clk_ops sun6i_rtc_osc_ops = {
 	.set_parent	= sun6i_rtc_osc_set_parent,
 };
 
-static void __init sun6i_rtc_clk_init(struct device_node *node)
+static void __init sun6i_rtc_clk_init(struct device_node *node,
+				      const struct sun6i_rtc_clk_data *data)
 {
 	struct clk_hw_onecell_data *clk_data;
 	struct sun6i_rtc_dev *rtc;
@@ -200,6 +227,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	if (!rtc)
 		return;
 
+	rtc->data = data;
 	clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
 	if (!clk_data) {
 		kfree(rtc);
@@ -228,7 +256,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
 								"rtc-int-osc",
 								NULL, 0,
-								667000,
+								rtc->data->rc_osc_rate,
 								300000000);
 	if (IS_ERR(rtc->int_osc)) {
 		pr_crit("Couldn't register the internal oscillator\n");
@@ -271,8 +299,18 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 err:
 	kfree(clk_data);
 }
-CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
-		      sun6i_rtc_clk_init);
+
+static const struct sun6i_rtc_clk_data sun6i_a31_rtc_data = {
+	.rc_osc_rate = 667000, /* datasheet says 600 ~ 700 KHz */
+	.has_prescaler = 1,
+};
+
+static void __init sun6i_a31_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun6i_a31_rtc_data);
+}
+CLK_OF_DECLARE_DRIVER(sun6i_a31_rtc_clk, "allwinner,sun6i-a31-rtc",
+		      sun6i_a31_rtc_clk_init);
 
 static irqreturn_t sun6i_rtc_alarmirq(int irq, void *id)
 {
@@ -579,6 +617,12 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * As far as RTC functionality goes, all models are the same. The
+ * datasheets claim that different models have different number of
+ * registers available for non-volatile storage, but experiments show
+ * that all SoCs have 16 registers available for this purpose.
+ */
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
 	{ /* sentinel */ },
-- 
2.20.0.rc1

