Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 47D00C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07854208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07854208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935904AbeFMOJq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:09:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52354 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935778AbeFMOHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:07:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2F2D320A20; Wed, 13 Jun 2018 16:07:18 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id F3024203B4;
        Wed, 13 Jun 2018 16:07:17 +0200 (CEST)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     hans.verkuil@cisco.com, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     tfiga@chromium.org, posciak@chromium.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4/9] media: cedrus: make engine type more generic
Date:   Wed, 13 Jun 2018 16:07:09 +0200
Message-Id: <20180613140714.1686-5-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613140714.1686-1-maxime.ripard@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sunxi_cedrus_engine enum actually enumerates pretty much the codecs to
use (or we can easily infer the codec engine from the codec).

Since we will need the codec type as well in some later refactoring, make
that structure more useful by just enumerating the codec, and converting
the existing users.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h | 6 ++++++
 drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c     | 6 +++---
 drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.h     | 6 +-----
 drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c  | 2 +-
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
index b1ed1c8cb130..a5f83c452006 100644
--- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
+++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
@@ -61,6 +61,12 @@ struct sunxi_cedrus_run {
 	};
 };
 
+enum sunxi_cedrus_codec {
+	SUNXI_CEDRUS_CODEC_MPEG2,
+
+	SUNXI_CEDRUS_CODEC_LAST,
+};
+
 struct sunxi_cedrus_ctx {
 	struct v4l2_fh fh;
 	struct sunxi_cedrus_dev	*dev;
diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
index fc688a5c1ea3..bb46a01214e0 100644
--- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
+++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
@@ -41,7 +41,7 @@
 #define SYSCON_SRAM_C1_MAP_VE	0x7fffffff
 
 int sunxi_cedrus_engine_enable(struct sunxi_cedrus_dev *dev,
-			       enum sunxi_cedrus_engine engine)
+			       enum sunxi_cedrus_codec codec)
 {
 	u32 reg = 0;
 
@@ -53,8 +53,8 @@ int sunxi_cedrus_engine_enable(struct sunxi_cedrus_dev *dev,
 
 	reg |= VE_CTRL_CACHE_BUS_BW_128;
 
-	switch (engine) {
-	case SUNXI_CEDRUS_ENGINE_MPEG:
+	switch (codec) {
+	case SUNXI_CEDRUS_CODEC_MPEG2:
 		reg |= VE_CTRL_DEC_MODE_MPEG;
 		break;
 
diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.h b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.h
index 34f3fae462a8..3236c80bfcf4 100644
--- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.h
+++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.h
@@ -23,12 +23,8 @@
 #ifndef _SUNXI_CEDRUS_HW_H_
 #define _SUNXI_CEDRUS_HW_H_
 
-enum sunxi_cedrus_engine {
-	SUNXI_CEDRUS_ENGINE_MPEG,
-};
-
 int sunxi_cedrus_engine_enable(struct sunxi_cedrus_dev *dev,
-			       enum sunxi_cedrus_engine engine);
+			       enum sunxi_cedrus_codec codec);
 void sunxi_cedrus_engine_disable(struct sunxi_cedrus_dev *dev);
 
 int sunxi_cedrus_hw_probe(struct sunxi_cedrus_dev *dev);
diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c
index 5be3e3b9ceef..85e6fc2fbdb2 100644
--- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c
+++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c
@@ -83,7 +83,7 @@ void sunxi_cedrus_mpeg2_setup(struct sunxi_cedrus_ctx *ctx,
 	}
 
 	/* Activate MPEG engine. */
-	sunxi_cedrus_engine_enable(dev, SUNXI_CEDRUS_ENGINE_MPEG);
+	sunxi_cedrus_engine_enable(dev, SUNXI_CEDRUS_CODEC_MPEG2);
 
 	/* Set quantization matrices. */
 	for (i = 0; i < 64; i++) {
-- 
2.17.0

