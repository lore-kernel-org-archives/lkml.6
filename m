Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342CAC6778D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CCC25C80
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CCC25C80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030261AbeGBK1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:27:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36168 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965478AbeGBK1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:27:37 -0400
Received: from wd0142.dip.tu-dresden.de ([141.76.108.142] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fZw3Q-0004Ek-54; Mon, 02 Jul 2018 12:27:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        emil.l.velikov@gmail.com, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 2/4] drm/panel: p079zca: add variable unprepare_delay properties
Date:   Mon,  2 Jul 2018 12:27:19 +0200
Message-Id: <20180702102721.3546-3-heiko@sntech.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180702102721.3546-1-heiko@sntech.de>
References: <20180702102721.3546-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

When panel power down, p079zca need delay between reset and disable
power supply, but p097pfg does not need it. Similarly p097zca needs
a delay after entering panel sleep mode. So add two delay properties,
so we can meet these two panel power down sequence.

Signed-off-by: Lin Huang <hl@rock-chips.com>
[add sleep-mode delay]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 840ad4a6a6a6..630b0c2549ef 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -33,6 +33,8 @@ struct panel_desc {
 	unsigned int lanes;
 	const char * const *supply_names;
 	unsigned int num_supplies;
+	unsigned int sleep_mode_delay;
+	unsigned int power_down_delay;
 };
 
 struct innolux_panel {
@@ -89,10 +91,13 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 		return err;
 	}
 
+	if (innolux->desc->sleep_mode_delay)
+		msleep(innolux->desc->sleep_mode_delay);
+
 	gpiod_set_value_cansleep(innolux->enable_gpio, 0);
 
-	/* T8: 80ms - 1000ms */
-	msleep(80);
+	if (innolux->desc->power_down_delay)
+		msleep(innolux->desc->power_down_delay);
 
 	regulator_bulk_disable(innolux->desc->num_supplies, innolux->supplies);
 
@@ -205,6 +210,7 @@ static const struct panel_desc innolux_p079zca_panel_desc = {
 	.lanes = 4,
 	.supply_names = innolux_p079zca_supply_names,
 	.num_supplies = ARRAY_SIZE(innolux_p079zca_supply_names),
+	.power_down_delay = 80, /* T8: 80ms - 1000ms */
 };
 
 static int innolux_panel_get_modes(struct drm_panel *panel)
-- 
2.17.0

