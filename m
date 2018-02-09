Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184679-2-1134911958004801697
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
    t=1518184679; b=BDf0SghoVyHZjMRD3wTh3VKYfNVur+q2BYSc5fyfTv4DikU
    KCGib+uB4S89ZnfHCAZwxxVRyiOljsCsZ6tQAqUV6KMleYa4neEi4C/RJZ9mFNuF
    m35a4FpQ+ceUxcC6nDLdiCSweenqFZivG8oncuH4vuQGDjvRO4Z+d6g+SGLlXjRr
    QOIofkHsyjqZ/SsDsTZuLi3R2+iQNRK46AEY4+nLfKlPw09t+YJ0iHSgHDw2ADV5
    x76gwvJqueP6ZIoFQ2pS0XZo/CIdLd5IdYJC3qB+j06h69lmLoec/TmryIie4LL4
    FnM/iTNRXFt7jBTwcI0MW4jXJrw2Ourmc3xtTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184679; bh=mhk0glijs99xwIyq62OVwjoFI9
    5UROO9Rr5hYsB/EYc=; b=h+s6pGamEXAmM0x8QK5HS/kjdXCy+1NiHEC3INgKWJ
    hEXUorqy+5A+F8BQqaDyyytHppiFPaaMiFMm2GgkLj4+ftvNv528StXRswE7ZmlY
    46In19Zk8rpHkH3hI3bD3f7dwX90TGFvHagJM7kvGbItV144mC1GYQBrkH+wCnjq
    I9Uz7WYdSGuumJ4gVFNm2xv2eOX+9LyqR+18lJ9T4suLhBrQwXxTBkj3qtQxJ74R
    Su2Dfk+jGAGnOIFI37/qb3FicCCf7dWc4w657DCbHsRS0aMyd7IZddpYpaGnh83r
    I6EGl5ZNWk/NoosN6HCV/p3LOyV51QhH7sKejc22d6gA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeBIN5m (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:57:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBINou (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        thongsyho <thong.ho.px@rvc.renesas.com>,
        Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Subject: [PATCH 4.9 91/92] drm: rcar-du: Fix race condition when disabling planes at CRTC stop
Date: Fri,  9 Feb 2018 14:40:00 +0100
Message-Id: <20180209133937.566943626@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c |   53 +++++++++++++++++++++++++++++----
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h |    8 ++++
 2 files changed, 55 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -392,6 +392,31 @@ static void rcar_du_crtc_start(struct rc
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
+				msecs_to_jiffies(100)))
+		dev_warn(rcdu->dev, "vertical blanking timeout\n");
+	drm_crtc_vblank_put(crtc);
+}
+
 static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
 {
 	struct drm_crtc *crtc = &rcrtc->crtc;
@@ -400,17 +425,16 @@ static void rcar_du_crtc_stop(struct rca
 		return;
 
 	/* Disable all planes and wait for the change to take effect. This is
-	 * required as the DSnPR registers are updated on vblank, and no vblank
-	 * will occur once the CRTC is stopped. Disabling planes when starting
-	 * the CRTC thus wouldn't be enough as it would start scanning out
-	 * immediately from old frame buffers until the next vblank.
+         * required as the plane enable registers are updated on vblank, and no
+         * vblank will occur once the CRTC is stopped. Disabling planes when
+         * starting the CRTC thus wouldn't be enough as it would start scanning
+         * out immediately from old frame buffers until the next vblank.
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
@@ -548,10 +572,25 @@ static irqreturn_t rcar_du_crtc_irq(int
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
+	spin_unlock(&rcrtc->vblank_lock);
+
+	if (status & DSSR_VBK) {
 		drm_crtc_handle_vblank(&rcrtc->crtc);
 		rcar_du_crtc_finish_page_flip(rcrtc);
 		ret = IRQ_HANDLED;
@@ -606,6 +645,8 @@ int rcar_du_crtc_create(struct rcar_du_g
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
@@ -33,6 +34,9 @@ struct rcar_du_vsp;
  * @started: whether the CRTC has been started and is running
  * @event: event to post when the pending page flip completes
  * @flip_wait: wait queue used to signal page flip completion
+ * @vblank_lock: protects vblank_wait and vblank_count
+ * @vblank_wait: wait queue used to signal vertical blanking
+ * @vblank_count: number of vertical blanking interrupts to wait for
  * @outputs: bitmask of the outputs (enum rcar_du_output) driven by this CRTC
  * @group: CRTC group this CRTC belongs to
  */
@@ -48,6 +52,10 @@ struct rcar_du_crtc {
 	struct drm_pending_vblank_event *event;
 	wait_queue_head_t flip_wait;
 
+	spinlock_t vblank_lock;
+	wait_queue_head_t vblank_wait;
+	unsigned int vblank_count;
+
 	unsigned int outputs;
 
 	struct rcar_du_group *group;
