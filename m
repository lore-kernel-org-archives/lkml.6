Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Djl3NdxeHltWNAAAmS7hNA
	; Mon, 11 Jun 2018 11:37:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C92AA607BB; Mon, 11 Jun 2018 11:37:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 46B9E601C3;
	Mon, 11 Jun 2018 11:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46B9E601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbeFKLgR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:36:17 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:45898 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeFKLgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:36:15 -0400
Received: from [109.168.11.45] (port=54392 helo=pc-ceresoli.dev.aim)
        by srv-hp10.netsons.net with esmtpa (Exim 4.89_1)
        (envelope-from <luca@lucaceresoli.net>)
        id 1fSL7M-00B1A2-9C; Mon, 11 Jun 2018 13:36:12 +0200
From: Luca Ceresoli <luca@lucaceresoli.net>
To: linux-media@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] media: imx274: initialize format before v4l2 controls
Date: Mon, 11 Jun 2018 13:35:32 +0200
Message-Id: <1528716939-17015-2-git-send-email-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
References: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current probe function calls v4l2_ctrl_handler_setup() before
initializing the format info. This triggers call paths such as:
imx274_probe -> v4l2_ctrl_handler_setup -> imx274_s_ctrl ->
imx274_set_exposure, where priv->mode_index is accessed before being
assigned.

This is wrong but does not trigger a visible bug because priv is
zero-initialized and 0 is the default value for priv->mode_index. But
this would become a crash in follow-up commits when mode_index is
replaced by a pointer that must always be valid.

Fix the bug before it shows up by initializing struct members early.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>

---
Changed v3 -> v4: nothing

Changed v2 -> v3: nothing

Changed v1 -> v2:
 - add "media: " prefix to commit message
---
 drivers/media/i2c/imx274.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index 63fb94e7da37..8a8a11b8d75d 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -1632,6 +1632,16 @@ static int imx274_probe(struct i2c_client *client,
 
 	mutex_init(&imx274->lock);
 
+	/* initialize format */
+	imx274->mode_index = IMX274_MODE_3840X2160;
+	imx274->format.width = imx274_formats[0].size.width;
+	imx274->format.height = imx274_formats[0].size.height;
+	imx274->format.field = V4L2_FIELD_NONE;
+	imx274->format.code = MEDIA_BUS_FMT_SRGGB10_1X10;
+	imx274->format.colorspace = V4L2_COLORSPACE_SRGB;
+	imx274->frame_interval.numerator = 1;
+	imx274->frame_interval.denominator = IMX274_DEF_FRAME_RATE;
+
 	/* initialize regmap */
 	imx274->regmap = devm_regmap_init_i2c(client, &imx274_regmap_config);
 	if (IS_ERR(imx274->regmap)) {
@@ -1720,16 +1730,6 @@ static int imx274_probe(struct i2c_client *client,
 		goto err_ctrls;
 	}
 
-	/* initialize format */
-	imx274->mode_index = IMX274_MODE_3840X2160;
-	imx274->format.width = imx274_formats[0].size.width;
-	imx274->format.height = imx274_formats[0].size.height;
-	imx274->format.field = V4L2_FIELD_NONE;
-	imx274->format.code = MEDIA_BUS_FMT_SRGGB10_1X10;
-	imx274->format.colorspace = V4L2_COLORSPACE_SRGB;
-	imx274->frame_interval.numerator = 1;
-	imx274->frame_interval.denominator = IMX274_DEF_FRAME_RATE;
-
 	/* load default control values */
 	ret = imx274_load_default(imx274);
 	if (ret) {
-- 
2.7.4
