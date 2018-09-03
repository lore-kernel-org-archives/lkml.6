Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2865DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E049520856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E049520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeICPRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:17:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbeICPRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:17:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7328A8011309;
        Mon,  3 Sep 2018 10:58:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 718512027EA0;
        Mon,  3 Sep 2018 10:57:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CBBD017444; Mon,  3 Sep 2018 12:57:57 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] drm: fix drm_mode_addfb() on big endian machines.
Date:   Mon,  3 Sep 2018 12:57:54 +0200
Message-Id: <20180903105756.24912-4-kraxel@redhat.com>
In-Reply-To: <20180903105756.24912-1-kraxel@redhat.com>
References: <20180903105756.24912-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 03 Sep 2018 10:58:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 03 Sep 2018 10:58:00 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
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
drm_mode_addfb() behavior for everybody without breaking things.  So add
a new driver feature flag DRIVER_PREFER_HOST_BYTE_ORDER, so drivers can
opt-in.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_drv.h             |  1 +
 drivers/gpu/drm/drm_framebuffer.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 46a8009784..9cf12596cd 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -57,6 +57,7 @@ struct drm_printer;
 #define DRIVER_KMS_LEGACY_CONTEXT	0x20000
 #define DRIVER_SYNCOBJ                  0x40000
 #define DRIVER_PREFER_XBGR_30BPP        0x80000
+#define DRIVER_PREFER_HOST_BYTE_ORDER   0x100000
 
 /**
  * struct drm_driver - DRM driver structure
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 88758096d5..ccbda8a2e9 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -124,6 +124,17 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
 	    dev->driver->driver_features & DRIVER_PREFER_XBGR_30BPP)
 		r.pixel_format = DRM_FORMAT_XBGR2101010;
 
+	if (dev->driver->driver_features & DRIVER_PREFER_HOST_BYTE_ORDER) {
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

