Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E28BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472012089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WxBncMYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472012089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJCXe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:34:57 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:39490 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCXe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:34:56 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 551E710C0558;
        Wed,  3 Oct 2018 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538585146; bh=omY/f8Wi6zegYSgr43GTNQyuRQqPQw7Jc9Ap4Tve6xc=;
        h=From:To:Cc:Subject:Date:From;
        b=WxBncMYz65rydfgRD7o5N0JkshKuO41BomG7J/NsD8X4vkIgXFE+ne143I/eTZ2mi
         ffZaI1F5a3F5OIcu0qZc1wk7O/WaTIzxh/NbHNNIJj0wxeoIScGXAd5fdeukGW9+nC
         I5jFdGgYfNbyZl3MwJnFxKP013XouzbkC14obo0l1Y7zlDJBnUZJhmvvEFNdX3p3Px
         RNvrun/JwpjA6IrCRz1yfsb8yCXVXbqcs/fITzyNJyfu8807G45TlsjMWZ0+FK5UiX
         vFq7bOMUSiSROiCS8EdzETGsJF7I8QuVkLHACHNOmKnT2/ghstPZQv1Xcwh2hLYvg0
         eK15x8rHpsPbA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id D22B83F69;
        Wed,  3 Oct 2018 09:45:43 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2] drm: fb-helper: Reject all pixel format changing requests
Date:   Wed,  3 Oct 2018 19:45:38 +0300
Message-Id: <20181003164538.5534-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm fbdev emulation doesn't support changing the pixel format at all,
so reject all pixel format changing requests.

Cc: stable@vger.kernel.org
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * Reject all pixel format changing request, not just the invalid ones.

 drivers/gpu/drm/drm_fb_helper.c | 91 ++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 16ec93b75dbf..48598d7f673f 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1580,6 +1580,25 @@ int drm_fb_helper_ioctl(struct fb_info *info, unsigned int cmd,
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
@@ -1590,7 +1609,6 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 {
 	struct drm_fb_helper *fb_helper = info->par;
 	struct drm_framebuffer *fb = fb_helper->fb;
-	int depth;
 
 	if (var->pixclock != 0 || in_dbg_master())
 		return -EINVAL;
@@ -1610,72 +1628,15 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
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
-- 
2.14.4

