Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7019AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F39D2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F39D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeICPRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:17:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbeICPRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:17:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EB208010FDF;
        Mon,  3 Sep 2018 10:58:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E308110B7C8A;
        Mon,  3 Sep 2018 10:57:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3933716E05; Mon,  3 Sep 2018 12:57:57 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] drm: byteorder: add DRM_FORMAT_HOST_*
Date:   Mon,  3 Sep 2018 12:57:52 +0200
Message-Id: <20180903105756.24912-2-kraxel@redhat.com>
In-Reply-To: <20180903105756.24912-1-kraxel@redhat.com>
References: <20180903105756.24912-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 03 Sep 2018 10:58:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 03 Sep 2018 10:58:00 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
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

