Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeC1TIu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:08:50 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34574 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753668AbeC1TIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:08:48 -0400
X-Google-Smtp-Source: AIpwx4+NLh01AWCsC3pPWIRl4QDFjd0e/qq950g0alLWJpUGeXyixz+AhkF1F5gJbysMEg5Acz+L6w==
From: Sean Paul <seanpaul@chromium.org>
To: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: robdclark@gmail.com, hoegsberg@chromium.org, jsanka@codeaurora.org,
        abhinavk@codeaurora.org, architt@codeaurora.org,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] drm/msm: Issue queued events when disabling crtc
Date: Wed, 28 Mar 2018 15:06:50 -0400
Message-Id: <20180328190657.218661-5-seanpaul@chromium.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328190657.218661-1-seanpaul@chromium.org>
References: <20180328190657.218661-1-seanpaul@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that any queued events are issued when disabling the crtc. This
avoids timeouts when we come back and wait for dependencies (like the
previous frame's flip_done).

Changes in v2:
- None

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index 76b96081916f..10271359789e 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -430,6 +430,7 @@ static void mdp5_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct mdp5_crtc_state *mdp5_cstate = to_mdp5_crtc_state(crtc->state);
 	struct mdp5_kms *mdp5_kms = get_kms(crtc);
 	struct device *dev = &mdp5_kms->pdev->dev;
+	unsigned long flags;
 
 	DBG("%s", crtc->name);
 
@@ -445,6 +446,14 @@ static void mdp5_crtc_atomic_disable(struct drm_crtc *crtc,
 	mdp_irq_unregister(&mdp5_kms->base, &mdp5_crtc->err);
 	pm_runtime_put_sync(dev);
 
+	if (crtc->state->event && !crtc->state->active) {
+		WARN_ON(mdp5_crtc->event);
+		spin_lock_irqsave(&mdp5_kms->dev->event_lock, flags);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+		spin_unlock_irqrestore(&mdp5_kms->dev->event_lock, flags);
+	}
+
 	mdp5_crtc->enabled = false;
 }
 
-- 
Sean Paul, Software Engineer, Google / Chromium OS
