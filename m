Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C13C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B6C213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5bNpsaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B6C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeJEBtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:49:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46294 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeJEBtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:49:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id a2-v6so3975935wrc.13;
        Thu, 04 Oct 2018 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfj0/FpPhXWz4+R+laujVpeT7NrSAQzRT3T/DZOBYiE=;
        b=X5bNpsaCXcvEH6bpWndqGPpexi37fZeicZJ4+IlhJ9Neh0/FsoW0Lfwvz7eA3dnFkT
         DSDjvVjhd/6BHC3Kxr3p+E9F+WVDsMDtNdNP5x1FZRdsDlSgmAMNVrHD3uZ3kflLK0C4
         XdzomSFEz6Gut0BKsLCQ527nEh8JVzvH+tzGG8QnX1prdCTGXbEzZIjSc6aeGIPPGazN
         y26eP2nNRnjMKacJR4gdfPuMfbG6V27ifHfWe81QY4JMYPyterSZqoLxaahWrtNkCjXS
         vzeS2SpWiknErnx9r3/brZhLs3BKzdP9nqXID3A9I9UskoPpUJF9JcXQxYpO43W3EQM9
         HGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfj0/FpPhXWz4+R+laujVpeT7NrSAQzRT3T/DZOBYiE=;
        b=g7flR6Y+XojqVXt8P3t89Uj3mnIAlbysUhk8HQ0pMCib/oStpMkJU+d59BD+pKDYFW
         5ESeEWBYNxdYkIQWeeDS2MMJgB1XoAVr940Meu2hHe2yKxSYhdFXiRdaUZEI3GsJykkn
         r0sAyN9vJiEau5rgpIXq+siSJvpqUSo1jg7/xaIH9h4EKHA13DfTutV/GPc7Jf3rI2CR
         28XjPeuuKpSVMiBAWrz2rQyZRUzmUjSZMWV5swwB9fwB4m3ybaZLMKs4rBqJ7kOWeA3J
         P5P220vEcMvqLgaFZscLRq0XX2cZvnEAlB9cksAgY2ZwpSn67uUhuV6MUa8ZWZ6sxfRw
         Bp5w==
X-Gm-Message-State: ABuFfoiSt+xWeV2Txq8AstvYTfkM97AoRilOqzDo+iz5m63sD1fgf11B
        +gSbZ663KSGzB8gC9vu8PkkV4YhK
X-Google-Smtp-Source: ACcGV61ku6AMiVg0TxpBaZ0yxup+IsDjAx90dI7G6rAu0TgNcXCjzIViuhIYs//pp0n9//lT12s/jg==
X-Received: by 2002:adf:a781:: with SMTP id j1-v6mr3232104wrc.277.1538679265132;
        Thu, 04 Oct 2018 11:54:25 -0700 (PDT)
Received: from mappy.world.mentorg.com (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id h78-v6sm8706877wmd.4.2018.10.04.11.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:54:24 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 05/11] media: imx-csi: Double crop height for alternate fields at sink
Date:   Thu,  4 Oct 2018 11:53:55 -0700
Message-Id: <20181004185401.15751-6-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004185401.15751-1-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the incoming sink field type is alternate, the reset crop height
and crop height bounds must be set to twice the incoming height,
because in alternate field mode, upstream will report only the
lines for a single field, and the CSI captures the whole frame.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-media-csi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 764db0d7c6d3..ca6328f53b75 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1138,6 +1138,8 @@ static void csi_try_crop(struct csi_priv *priv,
 			 struct v4l2_mbus_framefmt *infmt,
 			 struct v4l2_fwnode_endpoint *upstream_ep)
 {
+	u32 in_height;
+
 	crop->width = min_t(__u32, infmt->width, crop->width);
 	if (crop->left + crop->width > infmt->width)
 		crop->left = infmt->width - crop->width;
@@ -1145,6 +1147,10 @@ static void csi_try_crop(struct csi_priv *priv,
 	crop->left &= ~0x3;
 	crop->width &= ~0x7;
 
+	in_height = infmt->height;
+	if (infmt->field == V4L2_FIELD_ALTERNATE)
+		in_height *= 2;
+
 	/*
 	 * FIXME: not sure why yet, but on interlaced bt.656,
 	 * changing the vertical cropping causes loss of vertical
@@ -1154,12 +1160,12 @@ static void csi_try_crop(struct csi_priv *priv,
 	if (upstream_ep->bus_type == V4L2_MBUS_BT656 &&
 	    (V4L2_FIELD_HAS_BOTH(infmt->field) ||
 	     infmt->field == V4L2_FIELD_ALTERNATE)) {
-		crop->height = infmt->height;
-		crop->top = (infmt->height == 480) ? 2 : 0;
+		crop->height = in_height;
+		crop->top = (in_height == 480) ? 2 : 0;
 	} else {
-		crop->height = min_t(__u32, infmt->height, crop->height);
-		if (crop->top + crop->height > infmt->height)
-			crop->top = infmt->height - crop->height;
+		crop->height = min_t(__u32, in_height, crop->height);
+		if (crop->top + crop->height > in_height)
+			crop->top = in_height - crop->height;
 	}
 }
 
@@ -1399,6 +1405,8 @@ static void csi_try_fmt(struct csi_priv *priv,
 		crop->top = 0;
 		crop->width = sdformat->format.width;
 		crop->height = sdformat->format.height;
+		if (sdformat->format.field == V4L2_FIELD_ALTERNATE)
+			crop->height *= 2;
 		csi_try_crop(priv, crop, cfg, &sdformat->format, upstream_ep);
 		compose->left = 0;
 		compose->top = 0;
@@ -1526,6 +1534,8 @@ static int csi_get_selection(struct v4l2_subdev *sd,
 		sel->r.top = 0;
 		sel->r.width = infmt->width;
 		sel->r.height = infmt->height;
+		if (infmt->field == V4L2_FIELD_ALTERNATE)
+			sel->r.height *= 2;
 		break;
 	case V4L2_SEL_TGT_CROP:
 		sel->r = *crop;
-- 
2.17.1

