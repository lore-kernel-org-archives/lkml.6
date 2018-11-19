Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E88214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu6Tar2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E88214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407019AbeKTDaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405879AbeKTDaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:30:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A464D2146D;
        Mon, 19 Nov 2018 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647163;
        bh=mdOLvICvVYHrJIbgmhojurhkDsQGPLprOpmOMUGCKgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zu6Tar2pSriXc10Vns67U7oQGu/VE3wc3QpFfVtjHe0mnIyLgPzcbM0LaB16w5ioN
         EykRWzc5X9OWuplWArb6m5gwwS+JJBpyIKJy1if07DULP5VdrPQKrieC4VO5tadPnY
         lHsEDcSLvp0faDli2TkvbcYbeSyZyIahtwNkwuoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3.18 67/90] mach64: fix image corruption due to reading accelerator registers
Date:   Mon, 19 Nov 2018 17:29:49 +0100
Message-Id: <20181119162631.208925097@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit c09bcc91bb94ed91f1391bffcbe294963d605732 upstream.

Reading the registers without waiting for engine idle returns
unpredictable values. These unpredictable values result in display
corruption - if atyfb_imageblit reads the content of DP_PIX_WIDTH with the
bit DP_HOST_TRIPLE_EN set (from previous invocation), the driver would
never ever clear the bit, resulting in display corruption.

We don't want to wait for idle because it would degrade performance, so
this patch modifies the driver so that it never reads accelerator
registers.

HOST_CNTL doesn't have to be read, we can just write it with
HOST_BYTE_ALIGN because no other part of the driver cares if
HOST_BYTE_ALIGN is set.

DP_PIX_WIDTH is written in the functions atyfb_copyarea and atyfb_fillrect
with the default value and in atyfb_imageblit with the value set according
to the source image data.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Ville Syrjälä <syrjala@sci.fi>
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/aty/mach64_accel.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

--- a/drivers/video/fbdev/aty/mach64_accel.c
+++ b/drivers/video/fbdev/aty/mach64_accel.c
@@ -126,7 +126,7 @@ void aty_init_engine(struct atyfb_par *p
 
 	/* set host attributes */
 	wait_for_fifo(13, par);
-	aty_st_le32(HOST_CNTL, 0, par);
+	aty_st_le32(HOST_CNTL, HOST_BYTE_ALIGN, par);
 
 	/* set pattern attributes */
 	aty_st_le32(PAT_REG0, 0, par);
@@ -232,7 +232,8 @@ void atyfb_copyarea(struct fb_info *info
 		rotation = rotation24bpp(dx, direction);
 	}
 
-	wait_for_fifo(4, par);
+	wait_for_fifo(5, par);
+	aty_st_le32(DP_PIX_WIDTH, par->crtc.dp_pix_width, par);
 	aty_st_le32(DP_SRC, FRGD_SRC_BLIT, par);
 	aty_st_le32(SRC_Y_X, (sx << 16) | sy, par);
 	aty_st_le32(SRC_HEIGHT1_WIDTH1, (width << 16) | area->height, par);
@@ -268,7 +269,8 @@ void atyfb_fillrect(struct fb_info *info
 		rotation = rotation24bpp(dx, DST_X_LEFT_TO_RIGHT);
 	}
 
-	wait_for_fifo(3, par);
+	wait_for_fifo(4, par);
+	aty_st_le32(DP_PIX_WIDTH, par->crtc.dp_pix_width, par);
 	aty_st_le32(DP_FRGD_CLR, color, par);
 	aty_st_le32(DP_SRC,
 		    BKGD_SRC_BKGD_CLR | FRGD_SRC_FRGD_CLR | MONO_SRC_ONE,
@@ -283,7 +285,7 @@ void atyfb_imageblit(struct fb_info *inf
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u32 src_bytes, dx = image->dx, dy = image->dy, width = image->width;
-	u32 pix_width_save, pix_width, host_cntl, rotation = 0, src, mix;
+	u32 pix_width, rotation = 0, src, mix;
 
 	if (par->asleep)
 		return;
@@ -295,8 +297,7 @@ void atyfb_imageblit(struct fb_info *inf
 		return;
 	}
 
-	pix_width = pix_width_save = aty_ld_le32(DP_PIX_WIDTH, par);
-	host_cntl = aty_ld_le32(HOST_CNTL, par) | HOST_BYTE_ALIGN;
+	pix_width = par->crtc.dp_pix_width;
 
 	switch (image->depth) {
 	case 1:
@@ -369,12 +370,11 @@ void atyfb_imageblit(struct fb_info *inf
 		mix = FRGD_MIX_D_XOR_S | BKGD_MIX_D;
 	}
 
-	wait_for_fifo(6, par);
-	aty_st_le32(DP_WRITE_MASK, 0xFFFFFFFF, par);
+	wait_for_fifo(5, par);
 	aty_st_le32(DP_PIX_WIDTH, pix_width, par);
 	aty_st_le32(DP_MIX, mix, par);
 	aty_st_le32(DP_SRC, src, par);
-	aty_st_le32(HOST_CNTL, host_cntl, par);
+	aty_st_le32(HOST_CNTL, HOST_BYTE_ALIGN, par);
 	aty_st_le32(DST_CNTL, DST_Y_TOP_TO_BOTTOM | DST_X_LEFT_TO_RIGHT | rotation, par);
 
 	draw_rect(dx, dy, width, image->height, par);
@@ -423,8 +423,4 @@ void atyfb_imageblit(struct fb_info *inf
 			aty_st_le32(HOST_DATA0, get_unaligned_le32(pbitmap), par);
 		}
 	}
-
-	/* restore pix_width */
-	wait_for_fifo(1, par);
-	aty_st_le32(DP_PIX_WIDTH, pix_width_save, par);
 }


