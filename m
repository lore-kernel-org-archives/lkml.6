Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeEVIxx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:53:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38860 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeEVIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:53:51 -0400
X-Google-Smtp-Source: AB8JxZojE1lJ13c925eZTTSdcq0GHEVgq3SpFJEAiwzAAAuQ6d5009xW6wFiLsCvg+r0ifCD+V/3bw==
From: Lin Huang <hl@rock-chips.com>
To: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        dgreid@chromium.org, broonie@kernel.org
Cc: dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeffy.chen@rock-chips.com, Lin Huang <hl@rock-chips.com>
Subject: [PATCH 1/2] drm/rockchip: cnd-dp: adjust spdif register setting
Date: Tue, 22 May 2018 16:53:41 +0800
Message-Id: <1526979222-32478-1-git-send-email-hl@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use jitter bypass mode for spdif, so do not need to set jitter mode
related bit in SPDIF_CTRL_ADDR register. Also, we need to enable
SPDIF_ENABLE bit.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index eb3042c..3105965 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -792,7 +792,6 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 
 int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio)
 {
-	u32 val;
 	int ret;
 
 	ret = cdn_dp_reg_write(dp, AUDIO_PACK_CONTROL, 0);
@@ -801,11 +800,7 @@ int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio)
 		return ret;
 	}
 
-	val = SPDIF_AVG_SEL | SPDIF_JITTER_BYPASS;
-	val |= SPDIF_FIFO_MID_RANGE(0xe0);
-	val |= SPDIF_JITTER_THRSH(0xe0);
-	val |= SPDIF_JITTER_AVG_WIN(7);
-	writel(val, dp->regs + SPDIF_CTRL_ADDR);
+	writel(0, dp->regs + SPDIF_CTRL_ADDR);
 
 	/* clearn the audio config and reset */
 	writel(0, dp->regs + AUDIO_SRC_CNTL);
@@ -929,12 +924,6 @@ static void cdn_dp_audio_config_spdif(struct cdn_dp_device *dp)
 {
 	u32 val;
 
-	val = SPDIF_AVG_SEL | SPDIF_JITTER_BYPASS;
-	val |= SPDIF_FIFO_MID_RANGE(0xe0);
-	val |= SPDIF_JITTER_THRSH(0xe0);
-	val |= SPDIF_JITTER_AVG_WIN(7);
-	writel(val, dp->regs + SPDIF_CTRL_ADDR);
-
 	writel(SYNC_WR_TO_CH_ZERO, dp->regs + FIFO_CNTL);
 
 	val = MAX_NUM_CH(2) | AUDIO_TYPE_LPCM | CFG_SUB_PCKT_NUM(4);
@@ -942,9 +931,6 @@ static void cdn_dp_audio_config_spdif(struct cdn_dp_device *dp)
 	writel(SMPL2PKT_EN, dp->regs + SMPL2PKT_CNTL);
 
 	val = SPDIF_ENABLE | SPDIF_AVG_SEL | SPDIF_JITTER_BYPASS;
-	val |= SPDIF_FIFO_MID_RANGE(0xe0);
-	val |= SPDIF_JITTER_THRSH(0xe0);
-	val |= SPDIF_JITTER_AVG_WIN(7);
 	writel(val, dp->regs + SPDIF_CTRL_ADDR);
 
 	clk_prepare_enable(dp->spdif_clk);
-- 
2.7.4
