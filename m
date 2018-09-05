Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5F7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC5520658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC5520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeIEKdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:33:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbeIEKdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:33:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38D85DFE5;
        Wed,  5 Sep 2018 06:04:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E48F310075FF;
        Wed,  5 Sep 2018 06:04:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6154717532; Wed,  5 Sep 2018 08:04:46 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     michel@daenzer.net, imirkin@alum.mit.edu,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/6] drm: fix drm_mode_addfb() on big endian machines.
Date:   Wed,  5 Sep 2018 08:04:43 +0200
Message-Id: <20180905060445.15008-5-kraxel@redhat.com>
In-Reply-To: <20180905060445.15008-1-kraxel@redhat.com>
References: <20180905060445.15008-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 05 Sep 2018 06:04:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 05 Sep 2018 06:04:49 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace on big endian machhines typically expects the ADDFB ioctl
returns a big endian framebuffer.  drm_mode_addfb() will call
drm_mode_addfb2() unconditionally with little endian DRM_FORMAT_*
values though, which is wrong.  This patch fixes that.

Drivers (both kernel and xorg) have quirks in place to deal with the
broken drm_mode_addfb() behavior.  Because of this we can't just change
drm_mode_addfb() behavior for everybody without breaking things.  Add
the quirk_addfb_prefer_host_byte_order field to mode_config, so drivers
can opt-in.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_mode_config.h     | 14 ++++++++++++++
 drivers/gpu/drm/drm_framebuffer.c | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 5d29f4ba6f..65020086c9 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -811,6 +811,20 @@ struct drm_mode_config {
 	uint32_t preferred_depth, prefer_shadow;
 	bool quirk_addfb_prefer_xbgr_30bpp;
 
+	/*
+	 * @quirk_addfb_prefer_host_byte_order:
+	 *
+	 * When set to true drm_mode_addfb() will pick host byte order
+	 * pixel_format when calling drm_mode_addfb2().  This is how
+	 * drm_mode_addfb() should have worked from day one.  It
+	 * didn't though, so we ended up with quirks in both kernel
+	 * and userspace drivers to deal with the broken behavior.
+	 * Simply fixing drm_mode_addfb() unconditionally would break
+	 * these drivers, so add a quirk bit here to allow drivers
+	 * opt-in.
+	 */
+	bool quirk_addfb_prefer_host_byte_order;
+
 	/**
 	 * @async_page_flip: Does this device support async flips on the primary
 	 * plane?
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 888c4d53cf..f863f8a20f 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -124,6 +124,17 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
 	    r.pixel_format == DRM_FORMAT_XRGB2101010)
 		r.pixel_format = DRM_FORMAT_XBGR2101010;
 
+	if (dev->mode_config.quirk_addfb_prefer_host_byte_order) {
+		if (r.pixel_format == DRM_FORMAT_XRGB8888)
+			r.pixel_format = DRM_FORMAT_HOST_XRGB8888;
+		if (r.pixel_format == DRM_FORMAT_ARGB8888)
+			r.pixel_format = DRM_FORMAT_HOST_ARGB8888;
+		if (r.pixel_format == DRM_FORMAT_RGB565)
+			r.pixel_format = DRM_FORMAT_HOST_RGB565;
+		if (r.pixel_format == DRM_FORMAT_XRGB1555)
+			r.pixel_format = DRM_FORMAT_HOST_XRGB1555;
+	}
+
 	ret = drm_mode_addfb2(dev, &r, file_priv);
 	if (ret)
 		return ret;
-- 
2.9.3

