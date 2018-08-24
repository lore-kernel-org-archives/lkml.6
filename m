Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59F5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979702151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979702151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeHXUMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:12:10 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:37332 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbeHXULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:11:34 -0400
Received: from [109.168.11.45] (port=58220 helo=pc-ceresoli.dev.aim)
        by srv-hp10.netsons.net with esmtpa (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1ftF49-00EAi1-KS; Fri, 24 Aug 2018 18:36:05 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-media@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] media: imx274: rename frmfmt and format to "mode"
Date:   Fri, 24 Aug 2018 18:35:22 +0200
Message-Id: <20180824163525.12694-5-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180824163525.12694-1-luca@lucaceresoli.net>
References: <20180824163525.12694-1-luca@lucaceresoli.net>
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

A mix of "mode", "format" and "frmfmt" is used to refer to the sensor
readout mode. Use the term "mode" for all of them. Now "format" is
only used in the V4L2 meaning.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/media/i2c/imx274.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index 570706695ca7..6572d5728791 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -178,7 +178,7 @@ enum imx274_binning {
  * @nocpiop: Number of clocks per internal offset period (see "Integration Time
  *           in Each Readout Drive Mode (CSI-2)" in the datasheet)
  */
-struct imx274_frmfmt {
+struct imx274_mode {
 	const struct reg_8 *init_regs;
 	unsigned int bin_ratio;
 	int min_frame_len;
@@ -453,7 +453,7 @@ static const struct reg_8 imx274_tp_regs[] = {
 };
 
 /* nocpiop happens to be the same number for the implemented modes */
-static const struct imx274_frmfmt imx274_formats[] = {
+static const struct imx274_mode imx274_modes[] = {
 	{
 		/* mode 1, 4K */
 		.bin_ratio = 1,
@@ -526,7 +526,7 @@ struct stimx274 {
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpio;
 	struct mutex lock; /* mutex lock for operations */
-	const struct imx274_frmfmt *mode;
+	const struct imx274_mode *mode;
 };
 
 #define IMX274_ROUND(dim, step, flags)			\
@@ -871,7 +871,7 @@ static int __imx274_change_compose(struct stimx274 *imx274,
 	const struct v4l2_rect *cur_crop;
 	struct v4l2_mbus_framefmt *tgt_fmt;
 	unsigned int i;
-	const struct imx274_frmfmt *best_mode = &imx274_formats[0];
+	const struct imx274_mode *best_mode = &imx274_modes[0];
 	int best_goodness = INT_MIN;
 
 	if (which == V4L2_SUBDEV_FORMAT_TRY) {
@@ -882,8 +882,8 @@ static int __imx274_change_compose(struct stimx274 *imx274,
 		tgt_fmt = &imx274->format;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(imx274_formats); i++) {
-		unsigned int ratio = imx274_formats[i].bin_ratio;
+	for (i = 0; i < ARRAY_SIZE(imx274_modes); i++) {
+		unsigned int ratio = imx274_modes[i].bin_ratio;
 
 		int goodness = imx274_binning_goodness(
 			imx274,
@@ -893,7 +893,7 @@ static int __imx274_change_compose(struct stimx274 *imx274,
 
 		if (goodness >= best_goodness) {
 			best_goodness = goodness;
-			best_mode = &imx274_formats[i];
+			best_mode = &imx274_modes[i];
 		}
 	}
 
@@ -1313,7 +1313,7 @@ static int imx274_s_stream(struct v4l2_subdev *sd, int on)
 
 	dev_dbg(&imx274->client->dev, "%s : %s, mode index = %td\n", __func__,
 		on ? "Stream Start" : "Stream Stop",
-		imx274->mode - &imx274_formats[0]);
+		imx274->mode - &imx274_modes[0]);
 
 	mutex_lock(&imx274->lock);
 
@@ -1861,7 +1861,7 @@ static int imx274_probe(struct i2c_client *client,
 	mutex_init(&imx274->lock);
 
 	/* initialize format */
-	imx274->mode = &imx274_formats[IMX274_DEFAULT_BINNING];
+	imx274->mode = &imx274_modes[IMX274_DEFAULT_BINNING];
 	imx274->crop.width = IMX274_MAX_WIDTH;
 	imx274->crop.height = IMX274_MAX_HEIGHT;
 	imx274->format.width = imx274->crop.width / imx274->mode->bin_ratio;
-- 
2.17.1

