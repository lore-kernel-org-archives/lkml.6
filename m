Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566CAC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2690820882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763242;
	bh=O8TLu6bC3g81VzutmNfdMadr1upHh2hoS3LDEE1XhbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SvVxr4HLhhBzbrlpoDHJwa7a0CndBa0TAMGTUS4bbX40tavn3PuTKveAZKkm/CVBa
	 foyY1/uRN30tpMpR/wI/ao0aSQoJD5wpiWvCxvZGMLutrxQAsdTePMzUJVEKkxxLry
	 ZvmfbZHhGWVzNrFYbYscRuAOBpfk6KeC4+IwyXjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfA2MAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfA2LqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 937882083B;
        Tue, 29 Jan 2019 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762372;
        bh=O8TLu6bC3g81VzutmNfdMadr1upHh2hoS3LDEE1XhbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfBFXRo0IO/0BXH/aOpOUss8uz/1Vw/rCN6CB1s8rw+5khZtvXUH+6F9O1h19Rqhd
         4lZecVsYujpCNPSOjfVL+UnBQ9Sp4ONaecaWExQNHhdnNbFh+dn2ZMN1O9zfJBirTO
         4FhVX1mffoQkAN/WWXVUJdyXgldwtB7foQHnGoSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony McKahan <tonymckahan@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.19 085/103] drm/meson: Fix atomic mode switching regression
Date:   Tue, 29 Jan 2019 12:36:02 +0100
Message-Id: <20190129113206.615402776@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Armstrong <narmstrong@baylibre.com>

commit ce0210c12433031aba3bbacd75f4c02ab77f2004 upstream.

Since commit 2bcd3ecab773 when switching mode from X11 (ubuntu mate for
example) the display gets blurry, looking like an invalid framebuffer width.

This commit fixed atomic crtc modesetting in a totally wrong way and
introduced a local unnecessary ->enabled crtc state.

This commit reverts the crctc _begin() and _enable() changes and simply
adds drm_atomic_helper_commit_tail_rpm as helper.

Reported-by: Tony McKahan <tonymckahan@gmail.com>
Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Fixes: 2bcd3ecab773 ("drm/meson: Fixes for drm_crtc_vblank_on/off support")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
[narmstrong: fixed blank line issue from checkpatch]
Link: https://patchwork.freedesktop.org/patch/msgid/20190114153118.8024-1-narmstrong@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/meson/meson_crtc.c |   23 ++---------------------
 drivers/gpu/drm/meson/meson_drv.c  |    5 +++++
 2 files changed, 7 insertions(+), 21 deletions(-)

--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -45,7 +45,6 @@ struct meson_crtc {
 	struct drm_crtc base;
 	struct drm_pending_vblank_event *event;
 	struct meson_drm *priv;
-	bool enabled;
 };
 #define to_meson_crtc(x) container_of(x, struct meson_crtc, base)
 
@@ -81,7 +80,8 @@ static const struct drm_crtc_funcs meson
 
 };
 
-static void meson_crtc_enable(struct drm_crtc *crtc)
+static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
+				     struct drm_crtc_state *old_state)
 {
 	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
 	struct drm_crtc_state *crtc_state = crtc->state;
@@ -103,20 +103,6 @@ static void meson_crtc_enable(struct drm
 
 	drm_crtc_vblank_on(crtc);
 
-	meson_crtc->enabled = true;
-}
-
-static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
-				     struct drm_crtc_state *old_state)
-{
-	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
-	struct meson_drm *priv = meson_crtc->priv;
-
-	DRM_DEBUG_DRIVER("\n");
-
-	if (!meson_crtc->enabled)
-		meson_crtc_enable(crtc);
-
 	priv->viu.osd1_enabled = true;
 }
 
@@ -142,8 +128,6 @@ static void meson_crtc_atomic_disable(st
 
 		crtc->state->event = NULL;
 	}
-
-	meson_crtc->enabled = false;
 }
 
 static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -152,9 +136,6 @@ static void meson_crtc_atomic_begin(stru
 	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
 	unsigned long flags;
 
-	if (crtc->state->enable && !meson_crtc->enabled)
-		meson_crtc_enable(crtc);
-
 	if (crtc->state->event) {
 		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
 
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -82,6 +82,10 @@ static const struct drm_mode_config_func
 	.fb_create           = drm_gem_fb_create,
 };
 
+static const struct drm_mode_config_helper_funcs meson_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
 static irqreturn_t meson_irq(int irq, void *arg)
 {
 	struct drm_device *dev = arg;
@@ -246,6 +250,7 @@ static int meson_drv_bind_master(struct
 	drm->mode_config.max_width = 3840;
 	drm->mode_config.max_height = 2160;
 	drm->mode_config.funcs = &meson_mode_config_funcs;
+	drm->mode_config.helper_private	= &meson_mode_config_helpers;
 
 	/* Hardware Initialization */
 


