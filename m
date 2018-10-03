Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC6AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A700F2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z6K5+n++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A700F2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeJCRxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:53:00 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:55612 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCRxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:53:00 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2F97A10C03B3;
        Wed,  3 Oct 2018 04:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538564706; bh=qQ8L0Z+7eV9UKazbeWPkZFzZ765OnKszjk9JjmN1DVA=;
        h=From:To:Cc:Subject:Date:From;
        b=Z6K5+n++g4GB2Rhbc8qMWOQHVtivMF8SQfAN1jfLwpTI+gP4om3K66AZunC2kV3z2
         89fBvSqG+5XaEXLr+ZrdGDvV0vBd49CM6IRztALLmp4uSNtkYhu2tTtV+m40WkcE+e
         trfaZDzM5An+HUc+a80mB0W2DaHc5okaNcD/KEeMe1cANcDkPPTldM2NW819GMBM6g
         ATfUUdweO5NNqNm9hF86ozeRxqA6dmJvYaVY2rF9sddaR6heq0NRIZ8Thxj0RuKZjH
         kryB3bRroCCmy74ZllZLHVNqIOBV+A8jSD9MiySAjpX4hQ67o+RmAGarEp+m0YhEL6
         5IgghwvKbYQ+g==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id A031C53A4;
        Wed,  3 Oct 2018 04:05:00 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] drm: fb-helper: Validate requested pixel format against bpp
Date:   Wed,  3 Oct 2018 14:04:57 +0300
Message-Id: <20181003110457.9318-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validate requested pixel format against bits_per_pixel to reject
invalid formats with subcomponents length sum is greater than requested
bits_per_pixel.

weston 5.0.0 with fbdev backend tries to set up an ARGB x8r8g8b8 pixel
format without bits_per_pixel updating. So it can request
x8r8g8b8 with 16 bpp which is obviously incorrect and should be
rejected.

Cc: stable@vger.kernel.org
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 16ec93b75dbf..4f39da07f053 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1610,6 +1610,13 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
+	if ((var->green.length + var->blue.length + var->red.length +
+	    var->transp.length) > var->bits_per_pixel) {
+		DRM_DEBUG("fb requested pixel format can't fit in %d bpp\n",
+			  var->bits_per_pixel);
+		return -EINVAL;
+	}
+
 	switch (var->bits_per_pixel) {
 	case 16:
 		depth = (var->green.length == 6) ? 16 : 15;
-- 
2.14.4

