Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC10C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9FA20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9FA20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKXIjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:39:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33420 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeKXIjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 03:39:39 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 1EC7F263AE1
From:   Helen Koike <helen.koike@collabora.com>
To:     David Airlie <airlied@linux.ie>
Cc:     dnicoara@chromium.org, alexandros.frantzis@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>
Subject: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
Date:   Fri, 23 Nov 2018 19:53:26 -0200
Message-Id: <20181123215326.14274-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow userspace to identify if the driver supports async update.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
[prepared for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hi,

This patch introduces the ASYNC_UPDATE cap, which originated from the
discussion regarding DRM_MODE_ATOMIC_AMEND on [1], to allow user to
figure that async_update exists.

This was tested using a small program that exercises the uAPI for easy
sanity testing. The program was created by Alexandros and modified by
Enric to test the capability flag [2].

The test worked on a rockchip Ficus v1.1 board on top of mainline plus
the patch to update cursors asynchronously through atomic plus the patch
that introduces the ATOMIC_AMEND flag for the drm/rockchip driver.

To test, just build the program and use the --atomic flag to use the cursor
plane with the ATOMIC_AMEND flag. E.g.

  drm_cursor --atomic

[1] https://patchwork.freedesktop.org/patch/243088/
[2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-capability

Thanks
Helen


 drivers/gpu/drm/drm_ioctl.c | 11 +++++++++++
 include/uapi/drm/drm.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 94bd872d56c4..4a7e0f874171 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -31,6 +31,7 @@
 #include <drm/drm_ioctl.h>
 #include <drm/drmP.h>
 #include <drm/drm_auth.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include "drm_legacy.h"
 #include "drm_internal.h"
 #include "drm_crtc_internal.h"
@@ -229,6 +230,7 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
 {
 	struct drm_get_cap *req = data;
 	struct drm_crtc *crtc;
+	struct drm_plane *plane;
 
 	req->value = 0;
 
@@ -292,6 +294,15 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
 	case DRM_CAP_CRTC_IN_VBLANK_EVENT:
 		req->value = 1;
 		break;
+	case DRM_CAP_ASYNC_UPDATE:
+		req->value = 1;
+		list_for_each_entry(plane, &dev->mode_config.plane_list, head) {
+			if (!plane->helper_private->atomic_async_update) {
+				req->value = 0;
+				break;
+			}
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 300f336633f2..ff01540cbb1d 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -649,6 +649,7 @@ struct drm_gem_open {
 #define DRM_CAP_PAGE_FLIP_TARGET	0x11
 #define DRM_CAP_CRTC_IN_VBLANK_EVENT	0x12
 #define DRM_CAP_SYNCOBJ		0x13
+#define DRM_CAP_ASYNC_UPDATE		0x14
 
 /** DRM_IOCTL_GET_CAP ioctl argument type */
 struct drm_get_cap {
-- 
2.19.1

