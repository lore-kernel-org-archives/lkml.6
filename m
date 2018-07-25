Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14335C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B986D20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B986D20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeGYFGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:06:48 -0400
Received: from hermes.aosc.io ([199.195.250.187]:45685 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeGYFGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:06:48 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 64FCB9F7C1;
        Wed, 25 Jul 2018 03:57:02 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] drm/bridge/synopsys: dw-hdmi: re-run dw_hdmi_setup when setting mode
Date:   Wed, 25 Jul 2018 11:56:27 +0800
Message-Id: <20180725035627.58223-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently dw_hdmi_setup is only run when the dw-hdmi bridge is enabled,
with the mode set last time.

When the bridge is enabled before any mode is set (this may happen when
booting), the mode won't be set at all, some setup steps will be
skipped or fail, and the HDMI output may not work.

Re-run dw_hdmi_setup when setting mode, in order to prevent such
situation.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 5971976284bf..e2f832182afe 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2007,6 +2007,7 @@ static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
 
 	/* Store the display mode for plugin/DKMS poweron events */
 	memcpy(&hdmi->previous_mode, mode, sizeof(hdmi->previous_mode));
+	dw_hdmi_setup(hdmi, mode);
 
 	mutex_unlock(&hdmi->mutex);
 }
-- 
2.18.0

