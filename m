Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C407DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0AB2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0AB2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeIGVQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:16:34 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:60444 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeIGVQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:16:34 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 3803EC025F;
        Fri,  7 Sep 2018 18:34:51 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id A5080C0F69; Fri,  7 Sep 2018 18:34:49 +0200 (CEST)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id BA84EC0F5E;
        Fri,  7 Sep 2018 18:33:55 +0200 (CEST)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/2] media: cedrus: Fix error reporting in request validation
Date:   Fri,  7 Sep 2018 18:33:46 +0200
Message-Id: <20180907163347.32312-2-contact@paulk.fr>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907163347.32312-1-contact@paulk.fr>
References: <20180907163347.32312-1-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes error reporting by using the appropriate logging helpers and
return codes, while introducing new messages when there are not enough
or too many buffers associated with the request.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 09ab1b732c31..0a9363c7db06 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -105,10 +105,19 @@ static int cedrus_request_validate(struct media_request *req)
 	struct v4l2_ctrl_handler *parent_hdl, *hdl;
 	struct cedrus_ctx *ctx = NULL;
 	struct v4l2_ctrl *ctrl_test;
+	unsigned int count;
 	unsigned int i;
 
-	if (vb2_request_buffer_cnt(req) != 1)
+	count = vb2_request_buffer_cnt(req);
+	if (!count) {
+		v4l2_info(&ctx->dev->v4l2_dev,
+			  "No buffer was provided with the request\n");
 		return -ENOENT;
+	} else if (count > 1) {
+		v4l2_info(&ctx->dev->v4l2_dev,
+			  "More than one buffer was provided with the request\n");
+		return -EINVAL;
+	}
 
 	list_for_each_entry(obj, &req->objects, list) {
 		struct vb2_buffer *vb;
@@ -128,7 +137,7 @@ static int cedrus_request_validate(struct media_request *req)
 
 	hdl = v4l2_ctrl_request_hdl_find(req, parent_hdl);
 	if (!hdl) {
-		v4l2_err(&ctx->dev->v4l2_dev, "Missing codec control(s)\n");
+		v4l2_info(&ctx->dev->v4l2_dev, "Missing codec control(s)\n");
 		return -ENOENT;
 	}
 
@@ -140,7 +149,7 @@ static int cedrus_request_validate(struct media_request *req)
 		ctrl_test = v4l2_ctrl_request_hdl_ctrl_find(hdl,
 			cedrus_controls[i].id);
 		if (!ctrl_test) {
-			v4l2_err(&ctx->dev->v4l2_dev,
+			v4l2_info(&ctx->dev->v4l2_dev,
 				 "Missing required codec control\n");
 			return -ENOENT;
 		}
-- 
2.18.0

