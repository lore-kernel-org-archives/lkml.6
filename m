Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1074C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B28B20658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B28B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIEKdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:33:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbeIEKdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:33:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21FC040241C8;
        Wed,  5 Sep 2018 06:04:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9FE3B27AE;
        Wed,  5 Sep 2018 06:04:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 279B91746F; Wed,  5 Sep 2018 08:04:46 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     michel@daenzer.net, imirkin@alum.mit.edu,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/6] drm: byteorder: add DRM_FORMAT_HOST_*
Date:   Wed,  5 Sep 2018 08:04:41 +0200
Message-Id: <20180905060445.15008-3-kraxel@redhat.com>
In-Reply-To: <20180905060445.15008-1-kraxel@redhat.com>
References: <20180905060445.15008-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 06:04:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 05 Sep 2018 06:04:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fourcc variants in host byte order.  With these at hand we don't
need #ifdefs in drivers which support framebuffers in cpu endianess.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_fourcc.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index f9c15845f4..fac831c401 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -25,6 +25,28 @@
 #include <linux/types.h>
 #include <uapi/drm/drm_fourcc.h>
 
+/*
+ * DRM formats are little endian.  Define host endian variants for the
+ * most common formats here, to reduce the #ifdefs needed in drivers.
+ *
+ * Note that the DRM_FORMAT_BIG_ENDIAN flag should only be used in
+ * case the format can't be specified otherwise, so we don't end up
+ * with two values describing the same format.
+ */
+#ifdef __BIG_ENDIAN
+# define DRM_FORMAT_HOST_XRGB1555     (DRM_FORMAT_XRGB1555         |	\
+				       DRM_FORMAT_BIG_ENDIAN)
+# define DRM_FORMAT_HOST_RGB565       (DRM_FORMAT_RGB565           |	\
+				       DRM_FORMAT_BIG_ENDIAN)
+# define DRM_FORMAT_HOST_XRGB8888     DRM_FORMAT_BGRX8888
+# define DRM_FORMAT_HOST_ARGB8888     DRM_FORMAT_BGRA8888
+#else
+# define DRM_FORMAT_HOST_XRGB1555     DRM_FORMAT_XRGB1555
+# define DRM_FORMAT_HOST_RGB565       DRM_FORMAT_RGB565
+# define DRM_FORMAT_HOST_XRGB8888     DRM_FORMAT_XRGB8888
+# define DRM_FORMAT_HOST_ARGB8888     DRM_FORMAT_ARGB8888
+#endif
+
 struct drm_device;
 struct drm_mode_fb_cmd2;
 
-- 
2.9.3

