Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD51C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6999C21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6999C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJDTWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:22:51 -0400
Received: from hermes.aosc.io ([199.195.250.187]:43936 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbeJDTWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:22:50 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id CC2DE6687F;
        Thu,  4 Oct 2018 12:29:42 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 02/10] phy: sun4i-usb: add support for missing USB PHY index
Date:   Thu,  4 Oct 2018 20:28:47 +0800
Message-Id: <20181004122855.22981-3-icenowy@aosc.io>
In-Reply-To: <20181004122855.22981-1-icenowy@aosc.io>
References: <20181004122855.22981-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Allwinner H6 SoC's USB2 PHY has two holes -- USB1 (which is a
3.0 port with dedicated PHY) and USB2 (which doesn't exist at all).

Add support for this kind of missing USB PHY index.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
No changes in v4.

Changes in v3:
- Added Chen-Yu's Review tag.

 drivers/phy/allwinner/phy-sun4i-usb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index d4dcd39b8d76..881078ff73f6 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -126,6 +126,7 @@ struct sun4i_usb_phy_cfg {
 	bool dedicated_clocks;
 	bool enable_pmu_unk1;
 	bool phy0_dual_route;
+	int missing_phys;
 };
 
 struct sun4i_usb_phy_data {
@@ -646,6 +647,9 @@ static struct phy *sun4i_usb_phy_xlate(struct device *dev,
 	if (args->args[0] >= data->cfg->num_phys)
 		return ERR_PTR(-ENODEV);
 
+	if (data->cfg->missing_phys & BIT(args->args[0]))
+		return ERR_PTR(-ENODEV);
+
 	return data->phys[args->args[0]].phy;
 }
 
@@ -741,6 +745,9 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		struct sun4i_usb_phy *phy = data->phys + i;
 		char name[16];
 
+		if (data->cfg->missing_phys & BIT(i))
+			continue;
+
 		snprintf(name, sizeof(name), "usb%d_vbus", i);
 		phy->vbus = devm_regulator_get_optional(dev, name);
 		if (IS_ERR(phy->vbus)) {
-- 
2.18.0

