Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C0C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8BF21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYwApfWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8BF21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeJEBs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:48:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43312 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeJEBsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:48:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so11042285wrt.10;
        Thu, 04 Oct 2018 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2MliECJbngSvNxEJcXI/6/ht4MgQjigBp+2ip6FikjA=;
        b=AYwApfWqWJOvMFz8ZUBXvAN/yDmu0vJOM0cR7+VXpE8EqptA722Vha+rDMtQNmhkcQ
         fazBKaYADpG9pNcLJtrNmgvfrzt5zPRDBpub0qefMuiM8PwINic/6uK64L+B+pkQCOuP
         GtjltNp+UGcMFYrx6mmd4cT+uccIi9w9eC+gBjOITj9RrEOW29qEC3k9smcqhSqWiCB9
         7OOqi3vw2a8me6lhBV5/d3tbu45CXyfOMOWmeUBGs5226EPotlzBkAxpk+gMNH1mpJtb
         4SnWrUyYTP0Si9e0UAjrwrWyG3IaBjeNmXNUDFdmKxS66FF83uPl0CNfaaNzvpelQwzG
         dQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2MliECJbngSvNxEJcXI/6/ht4MgQjigBp+2ip6FikjA=;
        b=nD1JIRfWB8pSb77GIbgcx7VEP3M8daxflNvqX4UbTgj6PH2R+q2ztWaVn2sRsaPDXC
         5qb+lwYb8AbRg9iDml9xm2qLqLSYWAoNfiUbih6d6y9tzSF0Na5ASUd6zNv0UEZhqqz7
         DyXCpTmxFbuCgWJbcdGNbq6FE6YjluTFBciueSTy1eb8y8swHhfWctFIcUjbza3aZKD8
         yweFOKZX1e2CbuIKWKPjcuJcRh6GTuUADM1JGrb/6oiMBMuBah8YbERlBVrEE5dIOaAD
         YjMkii4ZzRar9onkOYBLN3SCj+SpP4CRHT6BIeSIUZyBT28RHm3o66lG4k+CpHhKeTkq
         3vCg==
X-Gm-Message-State: ABuFfohmzlfFxDU+uZ/JBT17+T3Bl2fgLWTKIBPjEYRrE7nrzL6uFMzz
        l0BxEp7XV+73yiWrcmZC0wO3MdyA
X-Google-Smtp-Source: ACcGV63fIakzVN7b7Okgph+Ud/U8k2YvZ0ZjTJxfIf4eXYdIdPZ1shtXG3lcl1xG4eCrDVmlmqyL6g==
X-Received: by 2002:a05:6000:48:: with SMTP id k8mr5670940wrx.103.1538679259187;
        Thu, 04 Oct 2018 11:54:19 -0700 (PDT)
Received: from mappy.world.mentorg.com (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id h78-v6sm8706877wmd.4.2018.10.04.11.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:54:18 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
Subject: [PATCH v4 03/11] gpu: ipu-v3: Add planar support to interlaced scan
Date:   Thu,  4 Oct 2018 11:53:53 -0700
Message-Id: <20181004185401.15751-4-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004185401.15751-1-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support interlaced scan with planar formats, cpmem SLUV must
be programmed with the correct chroma line stride. For full and
partial planar 4:2:2 (YUV422P, NV16), chroma line stride must
be doubled. For full and partial planar 4:2:0 (YUV420, YVU420, NV12),
chroma line stride must _not_ be doubled, since a single chroma line
is shared by two luma lines.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-cpmem.c              | 26 +++++++++++++++++++--
 drivers/staging/media/imx/imx-ic-prpencvf.c |  3 ++-
 drivers/staging/media/imx/imx-media-csi.c   |  3 ++-
 include/video/imx-ipu-v3.h                  |  3 ++-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
index a9d2501500a1..d41df8034c5b 100644
--- a/drivers/gpu/ipu-v3/ipu-cpmem.c
+++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
@@ -273,9 +273,10 @@ void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off)
 }
 EXPORT_SYMBOL_GPL(ipu_cpmem_set_uv_offset);
 
-void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
+void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride,
+			       u32 pixelformat)
 {
-	u32 ilo, sly;
+	u32 ilo, sly, sluv;
 
 	if (stride < 0) {
 		stride = -stride;
@@ -286,9 +287,30 @@ void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
 
 	sly = (stride * 2) - 1;
 
+	switch (pixelformat) {
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YVU420:
+		sluv = stride / 2 - 1;
+		break;
+	case V4L2_PIX_FMT_NV12:
+		sluv = stride - 1;
+		break;
+	case V4L2_PIX_FMT_YUV422P:
+		sluv = stride - 1;
+		break;
+	case V4L2_PIX_FMT_NV16:
+		sluv = stride * 2 - 1;
+		break;
+	default:
+		sluv = 0;
+		break;
+	}
+
 	ipu_ch_param_write_field(ch, IPU_FIELD_SO, 1);
 	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, ilo);
 	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, sly);
+	if (sluv)
+		ipu_ch_param_write_field(ch, IPU_FIELD_SLUV, sluv);
 };
 EXPORT_SYMBOL_GPL(ipu_cpmem_interlaced_scan);
 
diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 28f41caba05d..af7224846bd5 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -412,7 +412,8 @@ static int prp_setup_channel(struct prp_priv *priv,
 	if (image.pix.field == V4L2_FIELD_NONE &&
 	    V4L2_FIELD_HAS_BOTH(infmt->field) &&
 	    channel == priv->out_ch)
-		ipu_cpmem_interlaced_scan(channel, image.pix.bytesperline);
+		ipu_cpmem_interlaced_scan(channel, image.pix.bytesperline,
+					  image.pix.pixelformat);
 
 	ret = ipu_ic_task_idma_init(priv->ic, channel,
 				    image.pix.width, image.pix.height,
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index ad66f007d395..5e3aa4f3a1dd 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -512,7 +512,8 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	if (image.pix.field == V4L2_FIELD_NONE &&
 	    V4L2_FIELD_HAS_BOTH(infmt->field))
 		ipu_cpmem_interlaced_scan(priv->idmac_ch,
-					  image.pix.bytesperline);
+					  image.pix.bytesperline,
+					  image.pix.pixelformat);
 
 	ipu_idmac_set_double_buffer(priv->idmac_ch, true);
 
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index f44a35192313..e888c66b9d9d 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -255,7 +255,8 @@ void ipu_cpmem_set_stride(struct ipuv3_channel *ch, int stride);
 void ipu_cpmem_set_high_priority(struct ipuv3_channel *ch);
 void ipu_cpmem_set_buffer(struct ipuv3_channel *ch, int bufnum, dma_addr_t buf);
 void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off);
-void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride);
+void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride,
+			       u32 pixelformat);
 void ipu_cpmem_set_axi_id(struct ipuv3_channel *ch, u32 id);
 int ipu_cpmem_get_burstsize(struct ipuv3_channel *ch);
 void ipu_cpmem_set_burstsize(struct ipuv3_channel *ch, int burstsize);
-- 
2.17.1

