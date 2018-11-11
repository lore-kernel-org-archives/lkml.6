Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C60C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B20320881
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B20320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbeKLGuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:50:52 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44330 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeKLGuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:50:51 -0500
Received: from p54b264b4.dip0.t-ipconnect.de ([84.178.100.180] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gLwqw-0001eN-9u; Sun, 11 Nov 2018 22:01:06 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linus.walleij@linaro.org
Cc:     heiko@sntech.de, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: [PATCH 2/2] pinctrl: rockchip: add rk3188 routes to switch between nand and emmc
Date:   Sun, 11 Nov 2018 22:00:47 +0100
Message-Id: <20181111210047.30375-2-heiko@sntech.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181111210047.30375-1-heiko@sntech.de>
References: <20181111210047.30375-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

The rk3188 has pins that are not handled through the regular iomuxing
for handling either nand-flash or an emmc and are set through only one
specifal setting. So utilize the routing function to simply do that
setting depending on one of the core nand/emmc signals that are actually
regular pins handled through pinctrl.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 246bf14c7f72..16bf21bf69a2 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -822,6 +822,26 @@ static struct rockchip_mux_route_data rk3128_mux_route_data[] = {
 	},
 };
 
+static struct rockchip_mux_route_data rk3188_mux_route_data[] = {
+	{
+		/* non-iomuxed emmc/flash pins on flash-dqs */
+		.bank_num = 0,
+		.pin = 24,
+		.func = 1,
+		.route_location = ROCKCHIP_ROUTE_GRF,
+		.route_offset = 0xa0,
+		.route_val = BIT(16 + 11),
+	}, {
+		/* non-iomuxed emmc/flash pins on emmc-clk */
+		.bank_num = 0,
+		.pin = 24,
+		.func = 2,
+		.route_location = ROCKCHIP_ROUTE_GRF,
+		.route_offset = 0xa0,
+		.route_val = BIT(16 + 11) | BIT(11),
+	},
+};
+
 static struct rockchip_mux_route_data rk3228_mux_route_data[] = {
 	{
 		/* pwm0-0 */
@@ -3626,6 +3646,8 @@ static struct rockchip_pin_ctrl rk3188_pin_ctrl = {
 		.label			= "RK3188-GPIO",
 		.type			= RK3188,
 		.grf_mux_offset		= 0x60,
+		.iomux_routes		= rk3188_mux_route_data,
+		.niomux_routes		= ARRAY_SIZE(rk3188_mux_route_data),
 		.pull_calc_reg		= rk3188_calc_pull_reg_and_bit,
 };
 
-- 
2.18.0

