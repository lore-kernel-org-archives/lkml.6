Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AFFC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D1D2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfBCOUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:31 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55384 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729153AbfBCOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:24 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdD-0006Io-6u; Sun, 03 Feb 2019 14:20:23 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006sY-3j; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Ville =?UTF-8?Q?Syrj=C3=A4l=C3=A4?=" <syrjala@sci.fi>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.746607465@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 067/305] mach64: fix image corruption due to reading
 accelerator registers
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/aty/mach64_accel.c | 22 +++++++++-------------
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

