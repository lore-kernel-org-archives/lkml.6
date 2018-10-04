Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D6DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB932087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFNBVEvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB932087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJEBtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:49:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40514 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeJEBtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:49:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so6615186wro.7;
        Thu, 04 Oct 2018 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=39ePqVtoN/Q+RSpJpvlXDil/LDcl0k2Atg25lrLPMGc=;
        b=YFNBVEvVvknIyG2LywJJ54erIp1RtYOYGkuorRjEaF/TE8XFfPG/pEYUVzFTNajhTv
         EiF/pwufik3lxoWf6Lg3UjsLjBj933xTtYrAGWGDE2q+QrycCh7XPt6ImIIvPN1klCQN
         Y0ny6hIMhIrao3BmeMB8Ia3uoiTsp98OUcrIBuuNw16oBEnFwbtoN5iBl99bec8s4YEL
         Yneca4YkuibWqzo2MpAjuyiylkmkTdNDvShflGC8HF1MxumD+CF5/TCoTn7U/NwLD+mT
         6afls6PXV2akK5WzkWwAdtH7QR3FkKG17pa5ylUCcU5onjye1AhDc/9cxveJ6TDN9CJk
         /WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=39ePqVtoN/Q+RSpJpvlXDil/LDcl0k2Atg25lrLPMGc=;
        b=a58OiAACoUWq9ML9JGYVAUa+5FZeLYEpTjTHYjtqFwLzZuJYFR5swOFdNvA5iupLNN
         PoWi2BuQgDT5tJ4x3WK8NC4VXsW9sH+OsCt/mDuB9C5F0MgmBgVFA+nlMJpUPyfxSR5I
         +oT/uC9OjJf6s9SfLiK3a4T9gUU2Oyj7J3m/ZNKE8aSnGX7MFRU1V1lnBp1ogS6uhg8N
         43HAA9P2qTsTlhiTwmG0CRPQZZ0HP50dj/Gsdkof+VEF1fn4vf+KH+ipi5xxPz3NHZ/t
         VbpVHdRRu15jpmQ3p9tg3MgnFU7IxvlsfkW2vmQ5FlN93B1G3r1xs3xEOw/F2gtRP+HF
         Aw4w==
X-Gm-Message-State: ABuFfohtHKlYfJQMc9g6ueVRWM7npGWdB19t5eAioE/sF5rUJyqhKcn6
        coqUJaklJ2pedo5bEVOmTYltV2LM
X-Google-Smtp-Source: ACcGV63F4irX8wj9u3A2yt6mR4k1PjH2p7zlFJoeSizvaYXn145N3rngaNam6QzTdtihNY7eSRpjUQ==
X-Received: by 2002:adf:d082:: with SMTP id y2-v6mr5678747wrh.314.1538679276922;
        Thu, 04 Oct 2018 11:54:36 -0700 (PDT)
Received: from mappy.world.mentorg.com (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id h78-v6sm8706877wmd.4.2018.10.04.11.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:54:36 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 09/11] media: imx-csi: Move crop/compose reset after filling default mbus fields
Date:   Thu,  4 Oct 2018 11:53:59 -0700
Message-Id: <20181004185401.15751-10-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004185401.15751-1-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If caller passes un-initialized field type V4L2_FIELD_ANY to CSI
sink pad, the reset CSI crop window would not be correct, because
the crop window depends on a valid input field type. To fix move
the reset of crop and compose windows to after the call to
imx_media_fill_default_mbus_fields().

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-media-csi.c | 27 ++++++++++++-----------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 6dd53a8e35d2..679295da5dde 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1405,19 +1405,6 @@ static void csi_try_fmt(struct csi_priv *priv,
 				      W_ALIGN, &sdformat->format.height,
 				      MIN_H, MAX_H, H_ALIGN, S_ALIGN);
 
-		/* Reset crop and compose rectangles */
-		crop->left = 0;
-		crop->top = 0;
-		crop->width = sdformat->format.width;
-		crop->height = sdformat->format.height;
-		if (sdformat->format.field == V4L2_FIELD_ALTERNATE)
-			crop->height *= 2;
-		csi_try_crop(priv, crop, cfg, &sdformat->format, upstream_ep);
-		compose->left = 0;
-		compose->top = 0;
-		compose->width = crop->width;
-		compose->height = crop->height;
-
 		*cc = imx_media_find_mbus_format(sdformat->format.code,
 						 CS_SEL_ANY, true);
 		if (!*cc) {
@@ -1433,6 +1420,20 @@ static void csi_try_fmt(struct csi_priv *priv,
 		imx_media_fill_default_mbus_fields(
 			&sdformat->format, infmt,
 			priv->active_output_pad == CSI_SRC_PAD_DIRECT);
+
+		/* Reset crop and compose rectangles */
+		crop->left = 0;
+		crop->top = 0;
+		crop->width = sdformat->format.width;
+		crop->height = sdformat->format.height;
+		if (sdformat->format.field == V4L2_FIELD_ALTERNATE)
+			crop->height *= 2;
+		csi_try_crop(priv, crop, cfg, &sdformat->format, upstream_ep);
+		compose->left = 0;
+		compose->top = 0;
+		compose->width = crop->width;
+		compose->height = crop->height;
+
 		break;
 	}
 }
-- 
2.17.1

