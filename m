Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF9DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A60218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbfAaN0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:26:16 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:35231 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733072AbfAaN0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:26:15 -0500
X-Greylist: delayed 75339 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2019 08:26:14 EST
Received: from localhost.localdomain (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id F3809100012;
        Thu, 31 Jan 2019 13:26:11 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init
Date:   Thu, 31 Jan 2019 14:25:50 +0100
Message-Id: <20190131132550.26355-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initializing clocks, a reference to the TCON channel 0 clock is
obtained. However, the clock is never prepared and enabled later.
Switching from simplefb to DRM actually disables the clock (that was
usually configured by U-Boot) because of that.

On the V3s, this results in a hang when writing to some mixer registers
when switching over to DRM from simplefb.

Fix this by preparing and enabling the clock when initializing other
clocks. Waiting for sun4i_tcon_channel_enable to enable the clock is
apparently too late and results in the same mixer register access hang.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e987615c16f1..b31f5d95cadb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -371,6 +371,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 		dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
 		return PTR_ERR(tcon->sclk0);
 	}
+	clk_prepare_enable(tcon->sclk0);
 
 	if (tcon->quirks->has_channel_1) {
 		tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
@@ -385,6 +386,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 
 static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
 {
+	clk_disable_unprepare(tcon->sclk0);
 	clk_disable_unprepare(tcon->clk);
 }
 
-- 
2.20.1

