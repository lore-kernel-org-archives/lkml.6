Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D82C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A883020861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="jI91dIFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfAVHcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:32:36 -0500
Received: from plaes.org ([188.166.43.21]:41700 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfAVHcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:32:36 -0500
Received: from localhost (unknown [IPv6:2001:bb8:4008:ff:21a:64ff:fe97:f62])
        by plaes.org (Postfix) with ESMTPSA id 4366E40377;
        Tue, 22 Jan 2019 07:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1548142354; bh=B1Qep9dESQIpSgo3ifGmlcmiBpGPcpysADD3kbecHoI=;
        h=From:To:Cc:Subject:Date:From;
        b=jI91dIFhE51RhvSc3Ns5QVancwYQOppbWroe3RREntyxrC4DxKFTEr8gG6nnCEmUj
         1hc0Rzd5hD8t/5jP5h5vqJOSF/bb7zwp795niUohEZU+rsQOX0UZ7FLSbh3455mdzn
         iyY+64aNn8zKfZXqTKux4ezUbGhkWt0ciw1Pc/Tdkc0a3ZIiqHKp9tJM/j3HtEijiL
         TphNjOzZAy2XoUta3m4/j+7O7NP62NxBWSQBIPgtnVm1xgI9Wskzo5UnaqysdTOb4q
         yrpOv/yRbTee1HQbK3M90L/StNDW2vfwbUlM3c6E1Cds+9VhpL5VZhiffIjuHPz8E5
         L+uY1yvHoEoMw==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Priit Laes <priit.laes@paf.com>
Subject: [PATCH] drm/sun4i: hdmi: Fix usage of TMDS clock
Date:   Tue, 22 Jan 2019 09:32:32 +0200
Message-Id: <20190122073232.7240-1-plaes@plaes.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Priit Laes <priit.laes@paf.com>

Although TMDS clock is required for HDMI to properly function,
nobody called clk_prepare_enable(). This fixes reference counting
issues and makes sure clock is running when it needs to be running.

Due to TDMS clock being parent clock for DDC clock, TDMS clock
was turned on/off for each EDID probe, causing spurious failures
for certain HDMI/DVI screens.

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")

Signed-off-by: Priit Laes <priit.laes@paf.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 061d2e0d9011..25f4d676fd82 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -92,6 +92,8 @@ static void sun4i_hdmi_disable(struct drm_encoder *encoder)
 	val = readl(hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
 	val &= ~SUN4I_HDMI_VID_CTRL_ENABLE;
 	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
+
+	clk_disable_unprepare(hdmi->tmds_clk);
 }
 
 static void sun4i_hdmi_enable(struct drm_encoder *encoder)
@@ -112,6 +114,8 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
 		val |= SUN4I_HDMI_VID_CTRL_HDMI_MODE;
 
 	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
+
+	clk_prepare_enable(hdmi->tmds_clk);
 }
 
 static void sun4i_hdmi_mode_set(struct drm_encoder *encoder,
-- 
2.11.0

