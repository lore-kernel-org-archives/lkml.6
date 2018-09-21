Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724ACECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D8C21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D8C21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbeIUUQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:16:57 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:44188 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbeIUUQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:16:57 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id CB99B5FBB9; Fri, 21 Sep 2018 22:27:47 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drm/sun4i: Remove R40 display pipeline compatibles"
Date:   Fri, 21 Sep 2018 22:27:43 +0800
Message-Id: <20180921142743.8711-1-wens@csie.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3510e7a7f91088159bfc67e8abdc9f9e77d28870.

During the 4.19 merge window for drm-misc, two patches critical to
supporting the display pipeline on the Allwinner R40 SoC were missed.
They were applied later but missed the merge window deadline. As a
result 4.19-rc1 kernel would crash on the R40 when it couldn't parse
the new device tree structure. We ended up removing support for the
R40 display pipeline for 4.19.

Since the missing patches are already merged for 4.20, we can now
revert the commit that removed support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

drm-misc-fixes, which contains the patch to be reverted, should be
merged into drm-misc-next before tihs patch is applied.

Also, checkpatch.pl is complaining that the R40 mixer compatibles are
missing from the device tree bindings. It seems the patch adding them
never made it in. Please apply if possible:

    https://patchwork.kernel.org/patch/10485815/

Thanks

---
 drivers/gpu/drm/sun4i/sun4i_drv.c      |  1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 9027ddde4262..1e41c3f5fd6d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -402,6 +402,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun8i-a33-display-engine" },
 	{ .compatible = "allwinner,sun8i-a83t-display-engine" },
 	{ .compatible = "allwinner,sun8i-h3-display-engine" },
+	{ .compatible = "allwinner,sun8i-r40-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ .compatible = "allwinner,sun9i-a80-display-engine" },
 	{ .compatible = "allwinner,sun50i-a64-display-engine" },
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 091f6cf40353..8b3d02b146b7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -545,6 +545,22 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
 	.vi_num		= 1,
 };
 
+static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
+	.ccsc		= 0,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0xf,
+	.ui_num		= 3,
+	.vi_num		= 1,
+};
+
+static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg = {
+	.ccsc		= 1,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0x3,
+	.ui_num		= 1,
+	.vi_num		= 1,
+};
+
 static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.vi_num = 2,
 	.ui_num = 1,
@@ -582,6 +598,14 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
 		.compatible = "allwinner,sun8i-h3-de2-mixer-0",
 		.data = &sun8i_h3_mixer0_cfg,
 	},
+	{
+		.compatible = "allwinner,sun8i-r40-de2-mixer-0",
+		.data = &sun8i_r40_mixer0_cfg,
+	},
+	{
+		.compatible = "allwinner,sun8i-r40-de2-mixer-1",
+		.data = &sun8i_r40_mixer1_cfg,
+	},
 	{
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
 		.data = &sun8i_v3s_mixer_cfg,
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 9831a9fe2cf4..3040a79f298f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -252,6 +252,7 @@ static int sun8i_tcon_top_remove(struct platform_device *pdev)
 
 /* sun4i_drv uses this list to check if a device node is a TCON TOP */
 const struct of_device_id sun8i_tcon_top_of_table[] = {
+	{ .compatible = "allwinner,sun8i-r40-tcon-top" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_tcon_top_of_table);
-- 
2.19.0

