Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbeC1TIh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:08:37 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43616 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753555AbeC1TIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:08:35 -0400
X-Google-Smtp-Source: AIpwx4//8SYurgHmRY00Z4chTlrdkrtQh3EjzNWXnDB2ZjZy8de7klTXk3BwXn49s0gwxf5N5lMWuQ==
From: Sean Paul <seanpaul@chromium.org>
To: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: robdclark@gmail.com, hoegsberg@chromium.org, jsanka@codeaurora.org,
        abhinavk@codeaurora.org, architt@codeaurora.org,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] drm/msm: Mark the crtc->state->event consumed
Date: Wed, 28 Mar 2018 15:06:49 -0400
Message-Id: <20180328190657.218661-4-seanpaul@chromium.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328190657.218661-1-seanpaul@chromium.org>
References: <20180328190657.218661-1-seanpaul@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't leave the event != NULL once it's consumed, this is used a signal
to the atomic helpers that the event will be handled by the driver.

Changes in v2:
- None

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c | 1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
index 6e5e1aa54ce1..b001699297c4 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
@@ -351,6 +351,7 @@ static void mdp4_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	spin_lock_irqsave(&dev->event_lock, flags);
 	mdp4_crtc->event = crtc->state->event;
+	crtc->state->event = NULL;
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 
 	blend_setup(crtc);
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index 9893e43ba6c5..76b96081916f 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -708,6 +708,7 @@ static void mdp5_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	spin_lock_irqsave(&dev->event_lock, flags);
 	mdp5_crtc->event = crtc->state->event;
+	crtc->state->event = NULL;
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 
 	/*
-- 
Sean Paul, Software Engineer, Google / Chromium OS
