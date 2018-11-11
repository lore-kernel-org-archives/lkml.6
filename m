Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF60C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6BB2154B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfRytO3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6BB2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbeKLITb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731689AbeKLITb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:31 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DED421104;
        Sun, 11 Nov 2018 22:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975374;
        bh=9zJp/WXrQd7dq7306Rec/89AJIIiZcWOFqpNC/J8M9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfRytO3up6SKrNOZlSciM/w2xKhXTmTJc8QShDmegwbkNqFy++jpfVnzvdfQtNxaI
         f5HTo30TbXhJ2I9qLlDePfdbnqrXffVuu8OJtfa2CTCcfDZzT/khRTxRb+WK+CSOTw
         Qsgjh3E83TKfbC6+o2O/o57VLg+xMZ31W65zMeNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 042/350] drm: fix use of freed memory in drm_mode_setcrtc
Date:   Sun, 11 Nov 2018 14:18:26 -0800
Message-Id: <20181111221708.931717357@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_crtc.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -560,9 +560,9 @@ int drm_mode_setcrtc(struct drm_device *
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
@@ -591,6 +591,10 @@ int drm_mode_setcrtc(struct drm_device *
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


