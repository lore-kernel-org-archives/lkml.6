Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33526C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4AE2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfBCOVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55900 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730600AbfBCOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:40 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeQ-0006Sx-VA; Sun, 03 Feb 2019 14:21:39 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006sT-2I; Sun, 03 Feb 2019 14:49:42 +0100
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
Message-ID: <lsq.1549201508.399912747@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 066/305] mach64: fix display corruption on big endian
 machines
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

commit 3c6c6a7878d00a3ac997a779c5b9861ff25dfcc8 upstream.

The code for manual bit triple is not endian-clean. It builds the variable
"hostdword" using byte accesses, therefore we must read the variable with
"le32_to_cpu".

The patch also enables (hardware or software) bit triple only if the image
is monochrome (image->depth). If we want to blit full-color image, we
shouldn't use the triple code.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Ville Syrjälä <syrjala@sci.fi>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/aty/mach64_accel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/video/fbdev/aty/mach64_accel.c
+++ b/drivers/video/fbdev/aty/mach64_accel.c
@@ -344,7 +344,7 @@ void atyfb_imageblit(struct fb_info *inf
 		 * since Rage 3D IIc we have DP_HOST_TRIPLE_EN bit
 		 * this hwaccelerated triple has an issue with not aligned data
 		 */
-		if (M64_HAS(HW_TRIPLE) && image->width % 8 == 0)
+		if (image->depth == 1 && M64_HAS(HW_TRIPLE) && image->width % 8 == 0)
 			pix_width |= DP_HOST_TRIPLE_EN;
 	}
 
@@ -381,7 +381,7 @@ void atyfb_imageblit(struct fb_info *inf
 	src_bytes = (((image->width * image->depth) + 7) / 8) * image->height;
 
 	/* manual triple each pixel */
-	if (info->var.bits_per_pixel == 24 && !(pix_width & DP_HOST_TRIPLE_EN)) {
+	if (image->depth == 1 && info->var.bits_per_pixel == 24 && !(pix_width & DP_HOST_TRIPLE_EN)) {
 		int inbit, outbit, mult24, byte_id_in_dword, width;
 		u8 *pbitmapin = (u8*)image->data, *pbitmapout;
 		u32 hostdword;
@@ -414,7 +414,7 @@ void atyfb_imageblit(struct fb_info *inf
 				}
 			}
 			wait_for_fifo(1, par);
-			aty_st_le32(HOST_DATA0, hostdword, par);
+			aty_st_le32(HOST_DATA0, le32_to_cpu(hostdword), par);
 		}
 	} else {
 		u32 *pbitmap, dwords = (src_bytes + 3) / 4;

