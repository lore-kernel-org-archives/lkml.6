Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9ADECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A361F2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A361F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390139AbeIUTgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390038AbeIUTgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:36:09 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D91E310E986;
        Fri, 21 Sep 2018 13:47:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E77AC89B09;
        Fri, 21 Sep 2018 13:47:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8C4959EE5C; Fri, 21 Sep 2018 15:47:05 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, michel@daenzer.net, imirkin@alum.mit.edu,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 6/6] drm: move quirk_addfb_prefer_xbgr_30bpp handling to drm_driver_legacy_fb_format too
Date:   Fri, 21 Sep 2018 15:47:04 +0200
Message-Id: <20180921134704.12826-7-kraxel@redhat.com>
In-Reply-To: <20180921134704.12826-1-kraxel@redhat.com>
References: <20180921134704.12826-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 21 Sep 2018 13:47:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_fourcc.c      | 5 +++++
 drivers/gpu/drm/drm_framebuffer.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 7c6d3922ed..90a1c846fc 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -121,6 +121,11 @@ uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
 		if (fmt == DRM_FORMAT_XRGB1555)
 			fmt = DRM_FORMAT_HOST_XRGB1555;
 	}
+
+	if (dev->mode_config.quirk_addfb_prefer_xbgr_30bpp &&
+	    fmt == DRM_FORMAT_XRGB2101010)
+		fmt = DRM_FORMAT_XBGR2101010;
+
 	return fmt;
 }
 EXPORT_SYMBOL(drm_driver_legacy_fb_format);
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 1e2126101c..3bf729d0aa 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -129,10 +129,6 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
 	r.pitches[0] = or->pitch;
 	r.handles[0] = or->handle;
 
-	if (dev->mode_config.quirk_addfb_prefer_xbgr_30bpp &&
-	    r.pixel_format == DRM_FORMAT_XRGB2101010)
-		r.pixel_format = DRM_FORMAT_XBGR2101010;
-
 	ret = drm_mode_addfb2(dev, &r, file_priv);
 	if (ret)
 		return ret;
-- 
2.9.3

