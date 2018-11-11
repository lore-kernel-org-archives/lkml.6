Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E2DC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76A820881
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76A820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbeKLGuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:50:52 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44332 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeKLGuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:50:51 -0500
Received: from p54b264b4.dip0.t-ipconnect.de ([84.178.100.180] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gLwqv-0001eN-WF; Sun, 11 Nov 2018 22:01:06 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linus.walleij@linaro.org
Cc:     heiko@sntech.de, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: [PATCH 1/2] pinctrl: rockchip: allow specifying the regmap location for pin-routes
Date:   Sun, 11 Nov 2018 22:00:46 +0100
Message-Id: <20181111210047.30375-1-heiko@sntech.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

Right now we expect the pin-rounting settings to be in the same area
as the iomux setting itself. And while that seems to be true for all
newer Rockchip socs, back in the wild west days of old this wasn't true.

Nowadays pin settings in the GRF normally stay in the GRF and the same
is true for pins configured from PMU registers. But old socs like the
rk3188 really sprinkle pin settings somewhat randomly through both
for its bank0.

Therefore add the option to specify a location for the route setting,
so that we can map older socs correctly. We'll keep "same" as the
default, so that we only need to specify a location in the corner-cases
described above.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 95e4a06de019..246bf14c7f72 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -307,6 +307,12 @@ struct rockchip_mux_recalced_data {
 	u8 mask;
 };
 
+enum rockchip_mux_route_location {
+	ROCKCHIP_ROUTE_SAME = 0,
+	ROCKCHIP_ROUTE_PMU,
+	ROCKCHIP_ROUTE_GRF,
+};
+
 /**
  * struct rockchip_mux_recalced_data: represent a pin iomux data.
  * @bank_num: bank number.
@@ -319,6 +325,7 @@ struct rockchip_mux_route_data {
 	u8 bank_num;
 	u8 pin;
 	u8 func;
+	enum rockchip_mux_route_location route_location;
 	u32 route_offset;
 	u32 route_val;
 };
@@ -1091,7 +1098,7 @@ static struct rockchip_mux_route_data rk3399_mux_route_data[] = {
 };
 
 static bool rockchip_get_mux_route(struct rockchip_pin_bank *bank, int pin,
-				   int mux, u32 *reg, u32 *value)
+				   int mux, u32 *loc, u32 *reg, u32 *value)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
 	struct rockchip_pin_ctrl *ctrl = info->ctrl;
@@ -1108,6 +1115,7 @@ static bool rockchip_get_mux_route(struct rockchip_pin_bank *bank, int pin,
 	if (i >= ctrl->niomux_routes)
 		return false;
 
+	*loc = data->route_location;
 	*reg = data->route_offset;
 	*value = data->route_val;
 
@@ -1210,7 +1218,7 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	struct regmap *regmap;
 	int reg, ret, mask, mux_type;
 	u8 bit;
-	u32 data, rmask, route_reg, route_val;
+	u32 data, rmask, route_location, route_reg, route_val;
 
 	ret = rockchip_verify_mux(bank, pin, mux);
 	if (ret < 0)
@@ -1247,9 +1255,21 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 		rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
 
 	if (bank->route_mask & BIT(pin)) {
-		if (rockchip_get_mux_route(bank, pin, mux, &route_reg,
-					   &route_val)) {
-			ret = regmap_write(regmap, route_reg, route_val);
+		if (rockchip_get_mux_route(bank, pin, mux, &route_location,
+					   &route_reg, &route_val)) {
+			struct regmap *route_regmap = regmap;
+
+			/* handle special locations */
+			switch (route_location) {
+			case ROCKCHIP_ROUTE_PMU:
+				route_regmap = info->regmap_pmu;
+				break;
+			case ROCKCHIP_ROUTE_GRF:
+				route_regmap = info->regmap_base;
+				break;
+			}
+
+			ret = regmap_write(route_regmap, route_reg, route_val);
 			if (ret)
 				return ret;
 		}
-- 
2.18.0

