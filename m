Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1622C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9306420850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9306420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeLCO6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:58:39 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:50896 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbeLCO6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:58:37 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 74C445FD96; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
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
Subject: [PATCH v2 07/14] rtc: sun6i: Add support for all known pre-H6 variants
Date:   Mon,  3 Dec 2018 22:58:18 +0800
Message-Id: <20181203145825.20511-8-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are different variants to the RTC hardware first seen on sun6i
(A31). The differences we care about in this driver are the clock rate
for the internal oscillator, prescalers, and the presence of an external
clock output.

This patch adds support for all the known pre-H6 base compatibles using
the variants data structure previously introduced.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index d1866d90b9ef..46609ae56ffd 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -312,6 +312,48 @@ static void __init sun6i_a31_rtc_clk_init(struct device_node *node)
 CLK_OF_DECLARE_DRIVER(sun6i_a31_rtc_clk, "allwinner,sun6i-a31-rtc",
 		      sun6i_a31_rtc_clk_init);
 
+static const struct sun6i_rtc_clk_data sun8i_a23_rtc_data = {
+	.rc_osc_rate = 667000, /* datasheet says 600 ~ 700 KHz */
+	.has_prescaler = 1,
+	.has_out_clk = 1,
+};
+
+static void __init sun8i_a23_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun8i_a23_rtc_data);
+}
+CLK_OF_DECLARE_DRIVER(sun8i_a23_rtc_clk, "allwinner,sun8i-a23-rtc",
+		      sun8i_a23_rtc_clk_init);
+
+static const struct sun6i_rtc_clk_data sun8i_h3_rtc_data = {
+	.rc_osc_rate = 16000000,
+	.fixed_prescaler = 32,
+	.has_prescaler = 1,
+	.has_out_clk = 1,
+};
+
+static void __init sun8i_h3_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun8i_h3_rtc_data);
+}
+CLK_OF_DECLARE_DRIVER(sun8i_h3_rtc_clk, "allwinner,sun8i-h3-rtc",
+		      sun8i_h3_rtc_clk_init);
+/* As far as we are concerned, clocks for H5 are the same as H3 */
+CLK_OF_DECLARE_DRIVER(sun50i_h5_rtc_clk, "allwinner,sun50i-h5-rtc",
+		      sun8i_h3_rtc_clk_init);
+
+static const struct sun6i_rtc_clk_data sun8i_v3_rtc_data = {
+	.rc_osc_rate = 32000,
+	.has_out_clk = 1,
+};
+
+static void __init sun8i_v3_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun8i_v3_rtc_data);
+}
+CLK_OF_DECLARE_DRIVER(sun8i_v3_rtc_clk, "allwinner,sun8i-v3-rtc",
+		      sun8i_v3_rtc_clk_init);
+
 static irqreturn_t sun6i_rtc_alarmirq(int irq, void *id)
 {
 	struct sun6i_rtc_dev *chip = (struct sun6i_rtc_dev *) id;
@@ -625,6 +667,10 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
  */
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
+	{ .compatible = "allwinner,sun8i-a23-rtc" },
+	{ .compatible = "allwinner,sun8i-h3-rtc" },
+	{ .compatible = "allwinner,sun8i-v3-rtc" },
+	{ .compatible = "allwinner,sun50i-h5-rtc" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
-- 
2.20.0.rc1

