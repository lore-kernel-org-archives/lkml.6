Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D23C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9F6208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9F6208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbeHAT5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:57:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405698AbeHATIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3963610F7;
        Wed,  1 Aug 2018 17:04:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 203/336] media: renesas-ceu: Set mbus_fmt on subdev operations
Date:   Wed,  1 Aug 2018 18:48:58 +0200
Message-Id: <20180801165036.855346926@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

[ Upstream commit d3a67f27471d4792caf84132228def2b18617932 ]

The renesas-ceu driver intializes the desired mbus_format at 'complete'
time, inspecting the supported subdevice ones, and tuning some
parameters to produce the requested memory format from what the sensor
can produce. Although, the initially selected mbus_format was not
provided to the subdevice during set_fmt and try_fmt operations,
providing instead a '0' mbus format code.

As long as the sensor defaults to a compatible mbus_format when an
invalid code as '0' is provided, capture operations work correctly. If
the subdevice defaults to an unsupported format (eg. some RGB
permutations) capture does not work properly due to a mismatch on the
expected and received image format on the wire.

Fix that by re-using the initially selected mbus_format code during
set_fmt and try_fmt subdevice operation calls.

Tested by printing out the format selection procedure with ov7670
sensor.

Before this patch:
[    0.866001] ov7670_try_fmt_internal -- Looking for mbus_code 0x0000
[    0.870882] ov7670_try_fmt_internal -- Try mbus_code 0x2008
[    0.876336] ov7670_try_fmt_internal -- Try mbus_code 0x1002
[    0.881387] ov7670_try_fmt_internal -- Try mbus_code 0x1008
[    0.886537] ov7670_try_fmt_internal -- Try mbus_code 0x3001
[    0.891584] ov7670_try_fmt_internal -- mbus_code defaulted to 0x2008

With this patch applied:
[    0.867015] ov7670_try_fmt_internal -- Looking for mbus_code 0x2008
[    0.873205] ov7670_try_fmt_internal -- Try mbus_code 0x2008: match

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/renesas-ceu.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/drivers/media/platform/renesas-ceu.c
+++ b/drivers/media/platform/renesas-ceu.c
@@ -777,8 +777,15 @@ static int ceu_try_fmt(struct ceu_device
 	const struct ceu_fmt *ceu_fmt;
 	int ret;
 
+	/*
+	 * Set format on sensor sub device: bus format used to produce memory
+	 * format is selected at initialization time.
+	 */
 	struct v4l2_subdev_format sd_format = {
-		.which = V4L2_SUBDEV_FORMAT_TRY,
+		.which	= V4L2_SUBDEV_FORMAT_TRY,
+		.format	= {
+			.code = ceu_sd->mbus_fmt.mbus_code,
+		},
 	};
 
 	switch (pix->pixelformat) {
@@ -800,10 +807,6 @@ static int ceu_try_fmt(struct ceu_device
 	v4l_bound_align_image(&pix->width, 2, CEU_MAX_WIDTH, 4,
 			      &pix->height, 4, CEU_MAX_HEIGHT, 4, 0);
 
-	/*
-	 * Set format on sensor sub device: bus format used to produce memory
-	 * format is selected at initialization time.
-	 */
 	v4l2_fill_mbus_format_mplane(&sd_format.format, pix);
 	ret = v4l2_subdev_call(v4l2_sd, pad, set_fmt, &pad_cfg, &sd_format);
 	if (ret)
@@ -827,8 +830,15 @@ static int ceu_set_fmt(struct ceu_device
 	struct v4l2_subdev *v4l2_sd = ceu_sd->v4l2_sd;
 	int ret;
 
+	/*
+	 * Set format on sensor sub device: bus format used to produce memory
+	 * format is selected at initialization time.
+	 */
 	struct v4l2_subdev_format format = {
 		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format	= {
+			.code = ceu_sd->mbus_fmt.mbus_code,
+		},
 	};
 
 	ret = ceu_try_fmt(ceudev, v4l2_fmt);


