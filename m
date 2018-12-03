Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D6DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917052087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917052087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeLCO7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:59:12 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:50898 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbeLCO6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:58:37 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 7DDFC5FDB8; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
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
Subject: [PATCH v2 08/14] rtc: sun6i: Expose internal oscillator through device tree
Date:   Mon,  3 Dec 2018 22:58:19 +0800
Message-Id: <20181203145825.20511-9-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings have been updated to expose the RTC's internal oscillator,
for some SoCs that have it directly feeding the PRCM block. The changes
include the index 2 for the clock outputs, as well as the clock output
names.

This patch adds the internal oscillator to the list of clocks exposed
through of_clk_add_hw_provider(), and also have the driver optionally
fetch the name of the clock from the device tree if it's available.

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 46609ae56ffd..11f56de52179 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -136,6 +136,7 @@ struct sun6i_rtc_clk_data {
 	unsigned int fixed_prescaler : 16;
 	unsigned int has_prescaler : 1;
 	unsigned int has_out_clk : 1;
+	unsigned int export_iosc : 1;
 };
 
 struct sun6i_rtc_dev {
@@ -220,6 +221,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		.ops		= &sun6i_rtc_osc_ops,
 		.name		= "losc",
 	};
+	const char *iosc_name = "rtc-int-osc";
 	const char *clkout_name = "osc32k-out";
 	const char *parents[2];
 
@@ -228,7 +230,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		return;
 
 	rtc->data = data;
-	clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, 3), GFP_KERNEL);
 	if (!clk_data) {
 		kfree(rtc);
 		return;
@@ -253,8 +255,13 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	if (!of_get_property(node, "clocks", NULL))
 		goto err;
 
+	/* Only read IOSC name from device tree if it is exported */
+	if (rtc->data->export_iosc)
+		of_property_read_string_index(node, "clock-output-names", 2,
+					      &iosc_name);
+
 	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
-								"rtc-int-osc",
+								iosc_name,
 								NULL, 0,
 								rtc->data->rc_osc_rate,
 								300000000);
@@ -293,6 +300,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	clk_data->num = 2;
 	clk_data->hws[0] = &rtc->hw;
 	clk_data->hws[1] = __clk_get_hw(rtc->ext_losc);
+	if (rtc->data->export_iosc) {
+		clk_data->hws[2] = rtc->int_osc;
+		clk_data->num = 3;
+	}
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	return;
 
@@ -330,6 +341,7 @@ static const struct sun6i_rtc_clk_data sun8i_h3_rtc_data = {
 	.fixed_prescaler = 32,
 	.has_prescaler = 1,
 	.has_out_clk = 1,
+	.export_iosc = 1,
 };
 
 static void __init sun8i_h3_rtc_clk_init(struct device_node *node)
-- 
2.20.0.rc1

