Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B64C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FC32081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FC32081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeLIWTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:19:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35528 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726570AbeLIVz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:26 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72n-0002ii-AT; Sun, 09 Dec 2018 21:55:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003eI-GO; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Ville =?UTF-8?Q?Syrj=C3=A4l=C3=A4?=" <ville.syrjala@linux.intel.com>,
        "Eugeniy Paltsev" <Eugeniy.Paltsev@synopsys.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.936105759@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 292/328] drm: fb-helper: Reject all pixel format
 changing requests
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit db05c481977599236f12a85e55de9f5ab37b0a2c upstream.

drm fbdev emulation doesn't support changing the pixel format at all,
so reject all pixel format changing requests.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181003164538.5534-1-Eugeniy.Paltsev@synopsys.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/drm_fb_helper.c | 91 ++++++++++-----------------------
 1 file changed, 26 insertions(+), 65 deletions(-)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -750,6 +750,25 @@ int drm_fb_helper_setcmap(struct fb_cmap
 }
 EXPORT_SYMBOL(drm_fb_helper_setcmap);
 
+static bool drm_fb_pixel_format_equal(const struct fb_var_screeninfo *var_1,
+				      const struct fb_var_screeninfo *var_2)
+{
+	return var_1->bits_per_pixel == var_2->bits_per_pixel &&
+	       var_1->grayscale == var_2->grayscale &&
+	       var_1->red.offset == var_2->red.offset &&
+	       var_1->red.length == var_2->red.length &&
+	       var_1->red.msb_right == var_2->red.msb_right &&
+	       var_1->green.offset == var_2->green.offset &&
+	       var_1->green.length == var_2->green.length &&
+	       var_1->green.msb_right == var_2->green.msb_right &&
+	       var_1->blue.offset == var_2->blue.offset &&
+	       var_1->blue.length == var_2->blue.length &&
+	       var_1->blue.msb_right == var_2->blue.msb_right &&
+	       var_1->transp.offset == var_2->transp.offset &&
+	       var_1->transp.length == var_2->transp.length &&
+	       var_1->transp.msb_right == var_2->transp.msb_right;
+}
+
 /**
  * drm_fb_helper_check_var - implementation for ->fb_check_var
  * @var: screeninfo to check
@@ -760,7 +779,6 @@ int drm_fb_helper_check_var(struct fb_va
 {
 	struct drm_fb_helper *fb_helper = info->par;
 	struct drm_framebuffer *fb = fb_helper->fb;
-	int depth;
 
 	if (var->pixclock != 0 || in_dbg_master())
 		return -EINVAL;
@@ -777,72 +795,15 @@ int drm_fb_helper_check_var(struct fb_va
 		return -EINVAL;
 	}
 
-	switch (var->bits_per_pixel) {
-	case 16:
-		depth = (var->green.length == 6) ? 16 : 15;
-		break;
-	case 32:
-		depth = (var->transp.length > 0) ? 32 : 24;
-		break;
-	default:
-		depth = var->bits_per_pixel;
-		break;
-	}
-
-	switch (depth) {
-	case 8:
-		var->red.offset = 0;
-		var->green.offset = 0;
-		var->blue.offset = 0;
-		var->red.length = 8;
-		var->green.length = 8;
-		var->blue.length = 8;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		break;
-	case 15:
-		var->red.offset = 10;
-		var->green.offset = 5;
-		var->blue.offset = 0;
-		var->red.length = 5;
-		var->green.length = 5;
-		var->blue.length = 5;
-		var->transp.length = 1;
-		var->transp.offset = 15;
-		break;
-	case 16:
-		var->red.offset = 11;
-		var->green.offset = 5;
-		var->blue.offset = 0;
-		var->red.length = 5;
-		var->green.length = 6;
-		var->blue.length = 5;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		break;
-	case 24:
-		var->red.offset = 16;
-		var->green.offset = 8;
-		var->blue.offset = 0;
-		var->red.length = 8;
-		var->green.length = 8;
-		var->blue.length = 8;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		break;
-	case 32:
-		var->red.offset = 16;
-		var->green.offset = 8;
-		var->blue.offset = 0;
-		var->red.length = 8;
-		var->green.length = 8;
-		var->blue.length = 8;
-		var->transp.length = 8;
-		var->transp.offset = 24;
-		break;
-	default:
+	/*
+	 * drm fbdev emulation doesn't support changing the pixel format at all,
+	 * so reject all pixel format changing requests.
+	 */
+	if (!drm_fb_pixel_format_equal(var, &info->var)) {
+		DRM_DEBUG("fbdev emulation doesn't support changing the pixel format\n");
 		return -EINVAL;
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_fb_helper_check_var);

