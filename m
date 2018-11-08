Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B145ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32934208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iE6xeSQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32934208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbeKIHpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730116AbeKIHpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:50 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44EDE2148E;
        Thu,  8 Nov 2018 22:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714899;
        bh=dEN6V+UBkxZISOJKm4/tuOOGjODyAQt/epi51Bjnr+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iE6xeSQykcty7f4/nUsIKA9ecp27CIOvp8UnQCsxlC4FO40fjpDxuFcqxs/xvvnSO
         hjPqOx9JS1q0/uHN/mFi5AmSFz5TM2joxrudPuIdQwaxbhmtWCUmPIY8roItgYB84h
         sC5RhzF+B7rjASI0qqPnONhEHX8DEHQAeIDhKpk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.14 15/31] drm: fb-helper: Reject all pixel format changing requests
Date:   Thu,  8 Nov 2018 13:52:39 -0800
Message-Id: <20181108215130.950208840@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit db05c481977599236f12a85e55de9f5ab37b0a2c upstream.

drm fbdev emulation doesn't support changing the pixel format at all,
so reject all pixel format changing requests.

Cc: stable@vger.kernel.org
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181003164538.5534-1-Eugeniy.Paltsev@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_fb_helper.c |   91 +++++++++++-----------------------------
 1 file changed, 26 insertions(+), 65 deletions(-)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1490,6 +1490,25 @@ unlock:
 }
 EXPORT_SYMBOL(drm_fb_helper_ioctl);
 
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
  * drm_fb_helper_check_var - implementation for &fb_ops.fb_check_var
  * @var: screeninfo to check
@@ -1500,7 +1519,6 @@ int drm_fb_helper_check_var(struct fb_va
 {
 	struct drm_fb_helper *fb_helper = info->par;
 	struct drm_framebuffer *fb = fb_helper->fb;
-	int depth;
 
 	if (var->pixclock != 0 || in_dbg_master())
 		return -EINVAL;
@@ -1520,72 +1538,15 @@ int drm_fb_helper_check_var(struct fb_va
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


