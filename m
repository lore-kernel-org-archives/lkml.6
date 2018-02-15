Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720699-2-13492618655647038151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720698; b=EOjJAFU6O6Cx2VuNBjZSuLnVAa5qzlKG5XYCAOWn4wTalpJ
    3hYYTjjbGgtJrWgi4qVCQGWwqzz2zfrBTNc5AYJPhD2nrqJ7U562c8oMPrhFyH5g
    qa7msnMipSx2U4nB2ukGwL1JmTwFHkjp0WUOOl67ui65VnqebB5aplbSHz9pysA+
    BnTumzDZmUq/BLHcvYs2IbMkeEM8VFW7isTRfD6szm5MvkJ8RMeMFsY07irFEvXf
    iVRLRYAxZDDLLNEIDZ/hZK6pnQk3o5jgLOGQEzyz1CZgr4KZWNNNyvMtRaJzrR+A
    Isi3fCPDCOFGIoMFLvsn438z+Bf76+IrDc/WWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720698; bh=aZzyfSVy2MTJWMiOwA9qPlojGH
    +G61KIybC9lRN4PwE=; b=T7yAp0hKvngdDe8my4NA1pIxuzvdJ9iYrU9la4s0cq
    q9sw2hsNQa8IiyEQQ+vcWjJYQDeyMVU809vOUfeK18aU3dRSueHr4LyPTYmv2mLH
    7Qu01uDnFzGYbvkhLntwoCWxgHN3yC+76TygPB2F68GQKWSfcSw+Hb1FXuGyeTS4
    2Ls9tn9Qe+QICEKZ8ifv9zvEMCbfsbq2q+5d4kN8p3Yrji4OOZM+JgplakOzQf/0
    1xo6YC7v8j2dTKAokP48yU40uRRSXxXODjnnbfFEJ/qevcAYFyq9niFUOFx6wuu+
    9VlUhJLrXN4m6D8PwYTepFBDCVF/a/p3cnfXHbHKXAVQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162217AbeBOSvW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:51:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162064AbeBOPV2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:28 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        thongsyho <thong.ho.px@rvc.renesas.com>,
        Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Subject: [PATCH 4.4 025/108] drm: rcar-du: Fix race condition when disabling planes at CRTC stop
Date: Thu, 15 Feb 2018 16:16:22 +0100
Message-Id: <20180215151226.076346687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 641307df71fe77d7b38a477067495ede05d47295 upstream.

When stopping the CRTC the driver must disable all planes and wait for
the change to take effect at the next vblank. Merely calling
drm_crtc_wait_one_vblank() is not enough, as the function doesn't
include any mechanism to handle the race with vblank interrupts.

Replace the drm_crtc_wait_one_vblank() call with a manual mechanism that
handles the vblank interrupt race.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: thongsyho <thong.ho.px@rvc.renesas.com>
Signed-off-by: Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c |   54 +++++++++++++++++++++++++++++----
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h |    8 ++++
 2 files changed, 56 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -371,6 +371,31 @@ static void rcar_du_crtc_start(struct rc
 	rcrtc->started = true;
 }
 
+static void rcar_du_crtc_disable_planes(struct rcar_du_crtc *rcrtc)
+{
+	struct rcar_du_device *rcdu = rcrtc->group->dev;
+	struct drm_crtc *crtc = &rcrtc->crtc;
+	u32 status;
+	/* Make sure vblank interrupts are enabled. */
+	drm_crtc_vblank_get(crtc);
+	/*
+	 * Disable planes and calculate how many vertical blanking interrupts we
+	 * have to wait for. If a vertical blanking interrupt has been triggered
+	 * but not processed yet, we don't know whether it occurred before or
+	 * after the planes got disabled. We thus have to wait for two vblank
+	 * interrupts in that case.
+	 */
+	spin_lock_irq(&rcrtc->vblank_lock);
+	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR, 0);
+	status = rcar_du_crtc_read(rcrtc, DSSR);
+	rcrtc->vblank_count = status & DSSR_VBK ? 2 : 1;
+	spin_unlock_irq(&rcrtc->vblank_lock);
+	if (!wait_event_timeout(rcrtc->vblank_wait, rcrtc->vblank_count == 0,
+	                        msecs_to_jiffies(100)))
+		dev_warn(rcdu->dev, "vertical blanking timeout\n");
+	drm_crtc_vblank_put(crtc);
+}
+
 static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
 {
 	struct drm_crtc *crtc = &rcrtc->crtc;
@@ -379,17 +404,16 @@ static void rcar_du_crtc_stop(struct rca
 		return;
 
 	/* Disable all planes and wait for the change to take effect. This is
-	 * required as the DSnPR registers are updated on vblank, and no vblank
-	 * will occur once the CRTC is stopped. Disabling planes when starting
-	 * the CRTC thus wouldn't be enough as it would start scanning out
-	 * immediately from old frame buffers until the next vblank.
+	 * required as the plane enable registers are updated on vblank, and no
+	 * vblank will occur once the CRTC is stopped. Disabling planes when
+	 * starting the CRTC thus wouldn't be enough as it would start scanning
+	 * out immediately from old frame buffers until the next vblank.
 	 *
 	 * This increases the CRTC stop delay, especially when multiple CRTCs
 	 * are stopped in one operation as we now wait for one vblank per CRTC.
 	 * Whether this can be improved needs to be researched.
 	 */
-	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR, 0);
-	drm_crtc_wait_one_vblank(crtc);
+	rcar_du_crtc_disable_planes(rcrtc);
 
 	/* Disable vertical blanking interrupt reporting. We first need to wait
 	 * for page flip completion before stopping the CRTC as userspace
@@ -528,10 +552,26 @@ static irqreturn_t rcar_du_crtc_irq(int
 	irqreturn_t ret = IRQ_NONE;
 	u32 status;
 
+	spin_lock(&rcrtc->vblank_lock);
+
 	status = rcar_du_crtc_read(rcrtc, DSSR);
 	rcar_du_crtc_write(rcrtc, DSRCR, status & DSRCR_MASK);
 
 	if (status & DSSR_VBK) {
+		/*
+		 * Wake up the vblank wait if the counter reaches 0. This must
+		 * be protected by the vblank_lock to avoid races in
+		 * rcar_du_crtc_disable_planes().
+		 */
+		if (rcrtc->vblank_count) {
+			if (--rcrtc->vblank_count == 0)
+				wake_up(&rcrtc->vblank_wait);
+		}
+	}
+
+	spin_unlock(&rcrtc->vblank_lock);
+
+	if (status & DSSR_VBK) {
 		drm_handle_vblank(rcrtc->crtc.dev, rcrtc->index);
 		rcar_du_crtc_finish_page_flip(rcrtc);
 		ret = IRQ_HANDLED;
@@ -585,6 +625,8 @@ int rcar_du_crtc_create(struct rcar_du_g
 	}
 
 	init_waitqueue_head(&rcrtc->flip_wait);
+	init_waitqueue_head(&rcrtc->vblank_wait);
+	spin_lock_init(&rcrtc->vblank_lock);
 
 	rcrtc->group = rgrp;
 	rcrtc->mmio_offset = mmio_offsets[index];
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -15,6 +15,7 @@
 #define __RCAR_DU_CRTC_H__
 
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/wait.h>
 
 #include <drm/drmP.h>
@@ -32,6 +33,9 @@ struct rcar_du_group;
  * @started: whether the CRTC has been started and is running
  * @event: event to post when the pending page flip completes
  * @flip_wait: wait queue used to signal page flip completion
+ * @vblank_lock: protects vblank_wait and vblank_count
+ * @vblank_wait: wait queue used to signal vertical blanking
+ * @vblank_count: number of vertical blanking interrupts to wait for
  * @outputs: bitmask of the outputs (enum rcar_du_output) driven by this CRTC
  * @enabled: whether the CRTC is enabled, used to control system resume
  * @group: CRTC group this CRTC belongs to
@@ -48,6 +52,10 @@ struct rcar_du_crtc {
 	struct drm_pending_vblank_event *event;
 	wait_queue_head_t flip_wait;
 
+	spinlock_t vblank_lock;
+	wait_queue_head_t vblank_wait;
+	unsigned int vblank_count;
+
 	unsigned int outputs;
 	bool enabled;
 
