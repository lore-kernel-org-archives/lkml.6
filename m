Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5CBC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2685920827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF8d9uuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2685920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeJ3WUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeJ3WUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:20:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A839F2075D;
        Tue, 30 Oct 2018 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906026;
        bh=qvTMp9NME4T1wpuT2GnKguX55scpDm65r+lRvZMiHHo=;
        h=From:To:Cc:Subject:Date:From;
        b=fF8d9uuujVW92iU4s8EBRUe1+6TI4ISDyjINRB1cL5tx335dCDiZRl2TwLp3SrH/W
         6RDYihbmO+lAxvAAJ86e7ImKbjV99y3Iyc+09ATetnMsQFs6TCCFwbM4nL75ChkzqQ
         TaD+NYvOzT/cWRLeLDcj6N1emn0CkZrA+CRf72C0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 01/33] drm: fix use of freed memory in drm_mode_setcrtc
Date:   Tue, 30 Oct 2018 09:26:25 -0400
Message-Id: <20181030132657.217970-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 064253c1c0625efd0362a0b7ecdbe8bee2a2904d ]

drm_mode_setcrtc() retries modesetting in case one of the functions it
calls returns -EDEADLK. connector_set, mode and fb are freed before
retrying, but they are not set to NULL. This can cause
drm_mode_setcrtc() to use those variables.

For example: On the first try __drm_mode_set_config_internal() returns
-EDEADLK. connector_set, mode and fb are freed. Next retry starts, and
drm_modeset_lock_all_ctx() returns -EDEADLK, and we jump to 'out'. The
code will happily try to release all three again.

This leads to crashes of different kinds, depending on the sequence the
EDEADLKs happen.

Fix this by setting the three variables to NULL at the start of the
retry loop.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180917110054.4053-1-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_crtc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 98a36e6c69ad..bd207857a964 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -560,9 +560,9 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	struct drm_mode_crtc *crtc_req = data;
 	struct drm_crtc *crtc;
 	struct drm_plane *plane;
-	struct drm_connector **connector_set = NULL, *connector;
-	struct drm_framebuffer *fb = NULL;
-	struct drm_display_mode *mode = NULL;
+	struct drm_connector **connector_set, *connector;
+	struct drm_framebuffer *fb;
+	struct drm_display_mode *mode;
 	struct drm_mode_set set;
 	uint32_t __user *set_connectors_ptr;
 	struct drm_modeset_acquire_ctx ctx;
@@ -591,6 +591,10 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	mutex_lock(&crtc->dev->mode_config.mutex);
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
 retry:
+	connector_set = NULL;
+	fb = NULL;
+	mode = NULL;
+
 	ret = drm_modeset_lock_all_ctx(crtc->dev, &ctx);
 	if (ret)
 		goto out;
-- 
2.17.1

