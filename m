Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C590C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B8221741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690469;
	bh=SDdDHVPe2v0aKPHu1WctkwU4nvAnGBGp5d8pnNIlKi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nbwaNv1WzmPmHs02wLLvj0vFoHANBSpnaTSMDcxrEiZdUjpeNXdmB4P7ifIIe7lrX
	 CuXd46051QecvJfQYk58Plbp2YNo4aVtOQvKUSMDVq0l1QZ5X1pdsdKQNmR1fgdZKp
	 7up7KUTNY8Hh7TmAXS6ecYaIFTUWFw+RH58XCEHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfA1Prr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbfA1Prn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:47:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EE92147A;
        Mon, 28 Jan 2019 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690463;
        bh=SDdDHVPe2v0aKPHu1WctkwU4nvAnGBGp5d8pnNIlKi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnWy1hBoUHMVUYW9NSkoOD8JRaEKtDPIy4+V+XkF8qzIr62TFo0VXSTZKnFDVlud3
         Jb/Aq41cO5Z/LHl3fdiU3M1Mos7QaNnrtfSpOWX//YMSVdtT9byGq9yG1JBUuji5GW
         IR5f5AFRt4pTj6vuucsF6tAb51/ZRhb+W7i/+jSk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 097/304] drm: Move drm_mode_setcrtc() local re-init to failure path
Date:   Mon, 28 Jan 2019 10:40:14 -0500
Message-Id: <20190128154341.47195-97-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit c232e9f41b136c141df9938024e521191a7b910d ]

Instead of always re-initializing the variables we need to clean up on
out, move the re-initialization into the branch that goes back to retry
label.

This is a lateral move right now, but will allow us to pull out the
modeset locking into common code. I kept this change separate to make
things easier to review.

Changes in v2:
- None

Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20181129150423.239081-2-sean@poorly.run
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_crtc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 268a182ae189..af4b94ce8e94 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -570,9 +570,9 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	struct drm_mode_crtc *crtc_req = data;
 	struct drm_crtc *crtc;
 	struct drm_plane *plane;
-	struct drm_connector **connector_set, *connector;
-	struct drm_framebuffer *fb;
-	struct drm_display_mode *mode;
+	struct drm_connector **connector_set = NULL, *connector;
+	struct drm_framebuffer *fb = NULL;
+	struct drm_display_mode *mode = NULL;
 	struct drm_mode_set set;
 	uint32_t __user *set_connectors_ptr;
 	struct drm_modeset_acquire_ctx ctx;
@@ -601,10 +601,6 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	mutex_lock(&crtc->dev->mode_config.mutex);
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
 retry:
-	connector_set = NULL;
-	fb = NULL;
-	mode = NULL;
-
 	ret = drm_modeset_lock_all_ctx(crtc->dev, &ctx);
 	if (ret)
 		goto out;
@@ -766,6 +762,12 @@ out:
 	}
 	kfree(connector_set);
 	drm_mode_destroy(dev, mode);
+
+	/* In case we need to retry... */
+	connector_set = NULL;
+	fb = NULL;
+	mode = NULL;
+
 	if (ret == -EDEADLK) {
 		ret = drm_modeset_backoff(&ctx);
 		if (!ret)
-- 
2.19.1

