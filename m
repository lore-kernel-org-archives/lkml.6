Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A926C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DD621C66
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DD621C66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeFUTyc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:54:32 -0400
Received: from anholt.net ([50.246.234.109]:57392 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932922AbeFUTyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:54:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 96F6810A1633;
        Thu, 21 Jun 2018 12:54:30 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id FobVXwcF917n; Thu, 21 Jun 2018 12:54:29 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7933F10A0D3A;
        Thu, 21 Jun 2018 12:54:29 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id CBA4A2FE2FF0; Thu, 21 Jun 2018 12:54:28 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm: Consider drivers setting DRIVER_ATOMIC as atomic.
Date:   Thu, 21 Jun 2018 12:54:28 -0700
Message-Id: <20180621195428.17447-1-eric@anholt.net>
X-Mailer: git-send-email 2.18.0.rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers such as vc4 don't initialize mode_config.funcs until later in
initialization, but we know they're atomic since they've got the flag
set.  This avoids oopsing on dereferencing funcs in the new atomic
methods sanity checks.

I moved the atomic check function down below the core flag check, to
avoid needing a prototype.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: ba1f665f161c ("drm: Add checks for atomic_[duplicate/destroy]_state with atomic drivers")
---
 include/drm/drmP.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index f5099c12c6a6..c5dfbdb7271d 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -97,6 +97,16 @@ struct pci_controller;
 
 #define DRM_IF_VERSION(maj, min) (maj << 16 | min)
 
+#define DRM_SWITCH_POWER_ON 0
+#define DRM_SWITCH_POWER_OFF 1
+#define DRM_SWITCH_POWER_CHANGING 2
+#define DRM_SWITCH_POWER_DYNAMIC_OFF 3
+
+static inline bool drm_core_check_feature(struct drm_device *dev, int feature)
+{
+	return dev->driver->driver_features & feature;
+}
+
 /**
  * drm_drv_uses_atomic_modeset - check if the driver implements
  * atomic_commit()
@@ -107,17 +117,8 @@ struct pci_controller;
  */
 static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
 {
-	return dev->mode_config.funcs->atomic_commit != NULL;
-}
-
-#define DRM_SWITCH_POWER_ON 0
-#define DRM_SWITCH_POWER_OFF 1
-#define DRM_SWITCH_POWER_CHANGING 2
-#define DRM_SWITCH_POWER_DYNAMIC_OFF 3
-
-static inline bool drm_core_check_feature(struct drm_device *dev, int feature)
-{
-	return dev->driver->driver_features & feature;
+	return drm_core_check_feature(dev, DRIVER_ATOMIC) ||
+		dev->mode_config.funcs->atomic_commit != NULL;
 }
 
 /* returns true if currently okay to sleep */
-- 
2.18.0.rc2

