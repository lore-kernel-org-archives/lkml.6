Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D16C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1384C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1384C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeK1Ubh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:31:37 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:49298 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbeK1Ubg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:31:36 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 75ACC60339; Wed, 28 Nov 2018 17:30:28 +0800 (CST)
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
        linux-sunxi@googlegroups.com
Subject: [PATCH 08/15] rtc: sun6i: Expose internal oscillator through device tree
Date:   Wed, 28 Nov 2018 17:30:06 +0800
Message-Id: <20181128093013.24442-10-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/rtc-sun6i.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 62ed9ce53d8c..273ab7fbbbe3 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -220,6 +220,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		.ops		= &sun6i_rtc_osc_ops,
 		.name		= "losc",
 	};
+	const char *iosc_name = "rtc-int-osc";
 	const char *clkout_name = "osc32k-out";
 	const char *parents[2];
 
@@ -228,7 +229,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		return;
 
 	rtc->data = data;
-	clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, 3), GFP_KERNEL);
 	if (!clk_data) {
 		kfree(rtc);
 		return;
@@ -253,8 +254,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	if (!of_get_property(node, "clocks", NULL))
 		goto err;
 
+	of_property_read_string_index(node, "clock-output-names", 2,
+				      &iosc_name);
 	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
-								"rtc-int-osc",
+								iosc_name,
 								NULL, 0,
 								rtc->data->rc_osc_rate,
 								300000000);
@@ -290,9 +293,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 		return;
 	}
 
-	clk_data->num = 2;
+	clk_data->num = 3;
 	clk_data->hws[0] = &rtc->hw;
 	clk_data->hws[1] = __clk_get_hw(rtc->ext_losc);
+	clk_data->hws[2] = rtc->int_osc;
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	return;
 
-- 
2.20.0.rc1

