Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AA920840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197924;
	bh=b9mHi0vxGM5l7wd3jcDXtjgneNvouOkb7J+ZhDi3SMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IviGgWjWJC0MXsJECsgnfSuXcC4q7dNIzLpQw4KfBNdGoFWdldAEj9uc2MUm8gcS/
	 6G4P+YxkwOtOrY19JCjMo4EEXQvyhJs6d4GEpAfHlSAwav6DJEIas4zj75qUSjByoZ
	 mXlXYztLQBSi6Roo2nw9M/E+NiIS9owaPYJiy280=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbfBOCcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:32:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404261AbfBOCMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141C12229F;
        Fri, 15 Feb 2019 02:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196743;
        bh=b9mHi0vxGM5l7wd3jcDXtjgneNvouOkb7J+ZhDi3SMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCEEhToETIF6FQHegcSc/lskqg9V5c7Q5gpIp0sgWceckKAwodcarPZDt1qChgW7U
         pXPvvU98S64xOdfeQ/buFJJgodGIFi44OwQtiM13LVOCBTVX/C22AT82Jw/C/BnRE4
         2iW7WGbQfT1Aa4b1/nh5w8fzpaSoCPsox0+vV0Ts=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Priit Laes <priit.laes@paf.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 38/65] drm/sun4i: hdmi: Fix usage of TMDS clock
Date:   Thu, 14 Feb 2019 21:10:54 -0500
Message-Id: <20190215021121.177674-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Priit Laes <priit.laes@paf.com>

[ Upstream commit 5e1bc251cebc84b41b8eb5d2434e54d939a85430 ]

Although TMDS clock is required for HDMI to properly function,
nobody called clk_prepare_enable(). This fixes reference counting
issues and makes sure clock is running when it needs to be running.

Due to TDMS clock being parent clock for DDC clock, TDMS clock
was turned on/off for each EDID probe, causing spurious failures
for certain HDMI/DVI screens.

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
Signed-off-by: Priit Laes <priit.laes@paf.com>
[Maxime: Moved the TMDS clock enable earlier]
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190122073232.7240-1-plaes@plaes.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 061d2e0d9011..416da5376701 100644
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
@@ -102,6 +104,8 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Enabling the HDMI Output\n");
 
+	clk_prepare_enable(hdmi->tmds_clk);
+
 	sun4i_hdmi_setup_avi_infoframes(hdmi, mode);
 	val |= SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
 	val |= SUN4I_HDMI_PKT_CTRL_TYPE(1, SUN4I_HDMI_PKT_END);
-- 
2.19.1

