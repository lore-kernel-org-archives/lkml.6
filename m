Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E88C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F11C20874
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbeLTAAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:00:19 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.73]:14372 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727818AbeLTAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 19:00:18 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 289C59DE6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 18:00:17 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZllBg4N5a2PzOZllBgoWle; Wed, 19 Dec 2018 18:00:17 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=36150 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZll9-0010in-Rj; Wed, 19 Dec 2018 18:00:16 -0600
Date:   Wed, 19 Dec 2018 18:00:15 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/ioctl: Fix Spectre v1 vulnerabilities
Message-ID: <20181220000015.GA18973@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gZll9-0010in-Rj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:36150
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr is indirectly controlled by user-space, hence leading to a
potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/gpu/drm/drm_ioctl.c:805 drm_ioctl() warn: potential spectre issue 'dev->driver->ioctls' [r]
drivers/gpu/drm/drm_ioctl.c:810 drm_ioctl() warn: potential spectre issue 'drm_ioctls' [r] (local cap)
drivers/gpu/drm/drm_ioctl.c:892 drm_ioctl_flags() warn: potential spectre issue 'drm_ioctls' [r] (local cap)

Fix this by sanitizing nr before using it to index dev->driver->ioctls
and drm_ioctls.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/drm_ioctl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 94bd872d56c4..7e6746b2d704 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -37,6 +37,7 @@
 
 #include <linux/pci.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 
 /**
  * DOC: getunique and setversion story
@@ -800,13 +801,17 @@ long drm_ioctl(struct file *filp,
 
 	if (is_driver_ioctl) {
 		/* driver ioctl */
-		if (nr - DRM_COMMAND_BASE >= dev->driver->num_ioctls)
+		unsigned int index = nr - DRM_COMMAND_BASE;
+
+		if (index >= dev->driver->num_ioctls)
 			goto err_i1;
-		ioctl = &dev->driver->ioctls[nr - DRM_COMMAND_BASE];
+		index = array_index_nospec(index, dev->driver->num_ioctls);
+		ioctl = &dev->driver->ioctls[index];
 	} else {
 		/* core ioctl */
 		if (nr >= DRM_CORE_IOCTL_COUNT)
 			goto err_i1;
+		nr = array_index_nospec(nr, DRM_CORE_IOCTL_COUNT);
 		ioctl = &drm_ioctls[nr];
 	}
 
@@ -888,6 +893,7 @@ bool drm_ioctl_flags(unsigned int nr, unsigned int *flags)
 
 	if (nr >= DRM_CORE_IOCTL_COUNT)
 		return false;
+	nr = array_index_nospec(nr, DRM_CORE_IOCTL_COUNT);
 
 	*flags = drm_ioctls[nr].flags;
 	return true;
-- 
2.20.1

