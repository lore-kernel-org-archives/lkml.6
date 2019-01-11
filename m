Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BE4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6442173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfAKFh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:37:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfAKFh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:37:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB39542BBC;
        Fri, 11 Jan 2019 05:37:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C82A5600C3;
        Fri, 11 Jan 2019 05:37:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 20B609AD4; Fri, 11 Jan 2019 06:37:53 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 03/16] drm/bochs: atomic: add atomic_flush+atomic_enable callbacks.
Date:   Fri, 11 Jan 2019 06:37:39 +0100
Message-Id: <20190111053752.4004-4-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 11 Jan 2019 05:37:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion to atomic modesetting, step one.
Add atomic crtc helper callbacks.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index f7e6d1a9b3..2cbd406b1f 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -115,6 +115,29 @@ static int bochs_crtc_page_flip(struct drm_crtc *crtc,
 	return 0;
 }
 
+static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
+				     struct drm_crtc_state *old_crtc_state)
+{
+}
+
+static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
+				    struct drm_crtc_state *old_crtc_state)
+{
+	struct drm_device *dev = crtc->dev;
+	struct drm_pending_vblank_event *event;
+
+	if (crtc->state && crtc->state->event) {
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&dev->event_lock, irqflags);
+		event = crtc->state->event;
+		crtc->state->event = NULL;
+		drm_crtc_send_vblank_event(crtc, event);
+		spin_unlock_irqrestore(&dev->event_lock, irqflags);
+	}
+}
+
+
 /* These provide the minimum set of functions required to handle a CRTC */
 static const struct drm_crtc_funcs bochs_crtc_funcs = {
 	.set_config = drm_crtc_helper_set_config,
@@ -128,6 +151,8 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
 	.mode_set_base = bochs_crtc_mode_set_base,
 	.prepare = bochs_crtc_prepare,
 	.commit = bochs_crtc_commit,
+	.atomic_enable = bochs_crtc_atomic_enable,
+	.atomic_flush = bochs_crtc_atomic_flush,
 };
 
 static const uint32_t bochs_formats[] = {
-- 
2.9.3

