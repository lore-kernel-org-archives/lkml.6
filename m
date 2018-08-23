Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D0C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B279021486
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B279021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbeHWMIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:08:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbeHWMIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:08:11 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25F23BC1;
        Thu, 23 Aug 2018 08:39:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maciej Purski <m.purski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 011/324] drm/bridge/sii8620: fix display modes validation
Date:   Thu, 23 Aug 2018 09:51:17 +0200
Message-Id: <20180823074956.496922047@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Purski <m.purski@samsung.com>

[ Upstream commit ecba7cfa3afbe489288f2c819158b7402afd7ee9 ]

Current implementation of mode_valid() and mode_fixup() callbacks
handle packed pixel modes improperly.

Fix it by using proper maximum clock values from the documentation.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1517568865-25219-1-git-send-email-m.purski@samsung.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/sil-sii8620.c |   78 +++++++++++++++++------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -36,8 +36,11 @@
 
 #define SII8620_BURST_BUF_LEN 288
 #define VAL_RX_HDMI_CTRL2_DEFVAL VAL_RX_HDMI_CTRL2_IDLE_CNT(3)
-#define MHL1_MAX_LCLK 225000
-#define MHL3_MAX_LCLK 600000
+
+#define MHL1_MAX_PCLK 75000
+#define MHL1_MAX_PCLK_PP_MODE 150000
+#define MHL3_MAX_PCLK 200000
+#define MHL3_MAX_PCLK_PP_MODE 300000
 
 enum sii8620_mode {
 	CM_DISCONNECTED,
@@ -2277,17 +2280,43 @@ static void sii8620_detach(struct drm_br
 	rc_unregister_device(ctx->rc_dev);
 }
 
+static int sii8620_is_packing_required(struct sii8620 *ctx,
+				       const struct drm_display_mode *mode)
+{
+	int max_pclk, max_pclk_pp_mode;
+
+	if (sii8620_is_mhl3(ctx)) {
+		max_pclk = MHL3_MAX_PCLK;
+		max_pclk_pp_mode = MHL3_MAX_PCLK_PP_MODE;
+	} else {
+		max_pclk = MHL1_MAX_PCLK;
+		max_pclk_pp_mode = MHL1_MAX_PCLK_PP_MODE;
+	}
+
+	if (mode->clock < max_pclk)
+		return 0;
+	else if (mode->clock < max_pclk_pp_mode)
+		return 1;
+	else
+		return -1;
+}
+
 static enum drm_mode_status sii8620_mode_valid(struct drm_bridge *bridge,
 					 const struct drm_display_mode *mode)
 {
 	struct sii8620 *ctx = bridge_to_sii8620(bridge);
+	int pack_required = sii8620_is_packing_required(ctx, mode);
 	bool can_pack = ctx->devcap[MHL_DCAP_VID_LINK_MODE] &
 			MHL_DCAP_VID_LINK_PPIXEL;
-	unsigned int max_pclk = sii8620_is_mhl3(ctx) ? MHL3_MAX_LCLK :
-						       MHL1_MAX_LCLK;
-	max_pclk /= can_pack ? 2 : 3;
 
-	return (mode->clock > max_pclk) ? MODE_CLOCK_HIGH : MODE_OK;
+	switch (pack_required) {
+	case 0:
+		return MODE_OK;
+	case 1:
+		return (can_pack) ? MODE_OK : MODE_CLOCK_HIGH;
+	default:
+		return MODE_CLOCK_HIGH;
+	}
 }
 
 static bool sii8620_mode_fixup(struct drm_bridge *bridge,
@@ -2295,43 +2324,16 @@ static bool sii8620_mode_fixup(struct dr
 			       struct drm_display_mode *adjusted_mode)
 {
 	struct sii8620 *ctx = bridge_to_sii8620(bridge);
-	int max_lclk;
-	bool ret = true;
 
 	mutex_lock(&ctx->lock);
 
-	max_lclk = sii8620_is_mhl3(ctx) ? MHL3_MAX_LCLK : MHL1_MAX_LCLK;
-	if (max_lclk > 3 * adjusted_mode->clock) {
-		ctx->use_packed_pixel = 0;
-		goto end;
-	}
-	if ((ctx->devcap[MHL_DCAP_VID_LINK_MODE] & MHL_DCAP_VID_LINK_PPIXEL) &&
-	    max_lclk > 2 * adjusted_mode->clock) {
-		ctx->use_packed_pixel = 1;
-		goto end;
-	}
-	ret = false;
-end:
-	if (ret) {
-		u8 vic = drm_match_cea_mode(adjusted_mode);
+	ctx->use_packed_pixel = sii8620_is_packing_required(ctx, adjusted_mode);
+	ctx->video_code = drm_match_cea_mode(adjusted_mode);
+	ctx->pixel_clock = adjusted_mode->clock;
 
-		if (!vic) {
-			union hdmi_infoframe frm;
-			u8 mhl_vic[] = { 0, 95, 94, 93, 98 };
-
-			/* FIXME: We need the connector here */
-			drm_hdmi_vendor_infoframe_from_display_mode(
-				&frm.vendor.hdmi, NULL, adjusted_mode);
-			vic = frm.vendor.hdmi.vic;
-			if (vic >= ARRAY_SIZE(mhl_vic))
-				vic = 0;
-			vic = mhl_vic[vic];
-		}
-		ctx->video_code = vic;
-		ctx->pixel_clock = adjusted_mode->clock;
-	}
 	mutex_unlock(&ctx->lock);
-	return ret;
+
+	return true;
 }
 
 static const struct drm_bridge_funcs sii8620_bridge_funcs = {


