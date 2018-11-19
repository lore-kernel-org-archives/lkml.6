Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA59C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452AD2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD34CwAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452AD2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbeKTC6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730122AbeKTC6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D5D2086A;
        Mon, 19 Nov 2018 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645237;
        bh=U6HOoEU7l/CvtwJNNGosW/+749o43xcYL7CyI50ec1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JD34CwAipI71N2WjnUI+3wTAgm/T8YxGqPyEcyCb0A9alapM9w8wft3MqLOMVlXXl
         LwuUXqjRcvjRo5vOyPqOq3ZQYnYM+U4sH+4SeCwCCh6xr2oYDAlumfWRb9rBtQGsJc
         3KwSp8j+tC/m54T5ewA44zFoi/rTSCehElpARH4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.19 088/205] mach64: fix display corruption on big endian machines
Date:   Mon, 19 Nov 2018 17:26:35 +0100
Message-Id: <20181119162631.858949988@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/aty/mach64_accel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/video/fbdev/aty/mach64_accel.c
+++ b/drivers/video/fbdev/aty/mach64_accel.c
@@ -345,7 +345,7 @@ void atyfb_imageblit(struct fb_info *inf
 		 * since Rage 3D IIc we have DP_HOST_TRIPLE_EN bit
 		 * this hwaccelerated triple has an issue with not aligned data
 		 */
-		if (M64_HAS(HW_TRIPLE) && image->width % 8 == 0)
+		if (image->depth == 1 && M64_HAS(HW_TRIPLE) && image->width % 8 == 0)
 			pix_width |= DP_HOST_TRIPLE_EN;
 	}
 
@@ -382,7 +382,7 @@ void atyfb_imageblit(struct fb_info *inf
 	src_bytes = (((image->width * image->depth) + 7) / 8) * image->height;
 
 	/* manual triple each pixel */
-	if (info->var.bits_per_pixel == 24 && !(pix_width & DP_HOST_TRIPLE_EN)) {
+	if (image->depth == 1 && info->var.bits_per_pixel == 24 && !(pix_width & DP_HOST_TRIPLE_EN)) {
 		int inbit, outbit, mult24, byte_id_in_dword, width;
 		u8 *pbitmapin = (u8*)image->data, *pbitmapout;
 		u32 hostdword;
@@ -415,7 +415,7 @@ void atyfb_imageblit(struct fb_info *inf
 				}
 			}
 			wait_for_fifo(1, par);
-			aty_st_le32(HOST_DATA0, hostdword, par);
+			aty_st_le32(HOST_DATA0, le32_to_cpu(hostdword), par);
 		}
 	} else {
 		u32 *pbitmap, dwords = (src_bytes + 3) / 4;


