Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 96152C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571DE2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571DE2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934744AbeFLUEO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:04:14 -0400
Received: from mailoutvs3.siol.net ([185.57.226.194]:38828 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934556AbeFLUCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:02:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 3A572521F6A;
        Tue, 12 Jun 2018 22:02:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id q-LaINXpF48d; Tue, 12 Jun 2018 22:02:46 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id BFC925212DC;
        Tue, 12 Jun 2018 22:02:46 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 3EC07522436;
        Tue, 12 Jun 2018 22:02:44 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 23/27] drm/sun4i: Add support for A64 HDMI PHY
Date:   Tue, 12 Jun 2018 22:00:32 +0200
Message-Id: <20180612200036.21483-24-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY is the same as in H3, except it can switch between two clock
parents.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index e1b7196d4587..457f0a121684 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -396,6 +396,14 @@ static struct regmap_config sun8i_hdmi_phy_regmap_config = {
 	.name		= "phy"
 };
 
+static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
+	.has_phy_clk = true,
+	.has_second_pll = true,
+	.phy_init = &sun8i_hdmi_phy_init_h3,
+	.phy_disable = &sun8i_hdmi_phy_disable_h3,
+	.phy_config = &sun8i_hdmi_phy_config_h3,
+};
+
 static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
 	.phy_init = &sun8i_hdmi_phy_init_a83t,
 	.phy_disable = &sun8i_hdmi_phy_disable_a83t,
@@ -410,6 +418,10 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
 };
 
 static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
+	{
+		.compatible = "allwinner,sun50i-a64-hdmi-phy",
+		.data = &sun50i_a64_hdmi_phy,
+	},
 	{
 		.compatible = "allwinner,sun8i-a83t-hdmi-phy",
 		.data = &sun8i_a83t_hdmi_phy,
-- 
2.17.1

