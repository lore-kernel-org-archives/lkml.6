Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E694FC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0AB218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfBCNza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:55:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54542 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729097AbfBCNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:46 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEO-0003te-KQ; Sun, 03 Feb 2019 13:54:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIDX-000086-1c; Sun, 03 Feb 2019 14:53:51 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.899741959@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 302/305] drm/ioctl: Fix Spectre v1 vulnerabilities
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

commit 505b5240329b922f21f91d5b5d1e535c805eca6d upstream.

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

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181220000015.GA18973@embeddedor
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/drm_drv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -49,6 +49,7 @@
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 #include <drm/drmP.h>
 #include <drm/drm_core.h>
 
@@ -360,7 +361,10 @@ long drm_ioctl(struct file *filp,
 	if ((nr >= DRM_COMMAND_BASE) && (nr < DRM_COMMAND_END) &&
 	    (nr < DRM_COMMAND_BASE + dev->driver->num_ioctls)) {
 		u32 drv_size;
-		ioctl = &dev->driver->ioctls[nr - DRM_COMMAND_BASE];
+		unsigned int index = nr - DRM_COMMAND_BASE;
+
+		index = array_index_nospec(index, dev->driver->num_ioctls);
+		ioctl = &dev->driver->ioctls[index];
 		drv_size = _IOC_SIZE(ioctl->cmd_drv);
 		usize = asize = _IOC_SIZE(cmd);
 		if (drv_size > asize)
@@ -370,6 +374,7 @@ long drm_ioctl(struct file *filp,
 	else if ((nr >= DRM_COMMAND_END) || (nr < DRM_COMMAND_BASE)) {
 		u32 drv_size;
 
+		nr = array_index_nospec(nr, DRM_CORE_IOCTL_COUNT);
 		ioctl = &drm_ioctls[nr];
 
 		drv_size = _IOC_SIZE(ioctl->cmd);
@@ -465,6 +470,7 @@ bool drm_ioctl_flags(unsigned int nr, un
 
 	if (nr >= DRM_CORE_IOCTL_COUNT)
 		return false;
+	nr = array_index_nospec(nr, DRM_CORE_IOCTL_COUNT);
 
 	*flags = drm_ioctls[nr].flags;
 	return true;

