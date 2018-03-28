Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeC1TIW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:08:22 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35060 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753320AbeC1TIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:08:15 -0400
X-Google-Smtp-Source: AIpwx49TcJRV1DpL2dQXTxWGL0y/GOPjz5+/ZlmpSC56tMK7xbqEaR2tJv/6YRnx49GGV9cZPMoVCg==
From: Sean Paul <seanpaul@chromium.org>
To: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: robdclark@gmail.com, hoegsberg@chromium.org, jsanka@codeaurora.org,
        abhinavk@codeaurora.org, architt@codeaurora.org,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] drm/msm: Refactor complete_commit() to look more the helpers
Date: Wed, 28 Mar 2018 15:06:48 -0400
Message-Id: <20180328190657.218661-3-seanpaul@chromium.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328190657.218661-1-seanpaul@chromium.org>
References: <20180328190657.218661-1-seanpaul@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the commit_tail() portions of complete_commit() into a
separate function to facilitate moving to the atomic helpers in future
patches.

Changes in v2:
- None

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/msm/msm_atomic.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index e792158676aa..671a18ee977d 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -97,18 +97,12 @@ static void msm_atomic_wait_for_commit_done(struct drm_device *dev,
 	}
 }
 
-/* The (potentially) asynchronous part of the commit.  At this point
- * nothing can fail short of armageddon.
- */
-static void complete_commit(struct msm_commit *c, bool async)
+static void msm_atomic_commit_tail(struct drm_atomic_state *state)
 {
-	struct drm_atomic_state *state = c->state;
 	struct drm_device *dev = state->dev;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_kms *kms = priv->kms;
 
-	drm_atomic_helper_wait_for_fences(dev, state, false);
-
 	kms->funcs->prepare_commit(kms, state);
 
 	drm_atomic_helper_commit_modeset_disables(dev, state);
@@ -135,6 +129,19 @@ static void complete_commit(struct msm_commit *c, bool async)
 	drm_atomic_helper_cleanup_planes(dev, state);
 
 	kms->funcs->complete_commit(kms, state);
+}
+
+/* The (potentially) asynchronous part of the commit.  At this point
+ * nothing can fail short of armageddon.
+ */
+static void complete_commit(struct msm_commit *c)
+{
+	struct drm_atomic_state *state = c->state;
+	struct drm_device *dev = state->dev;
+
+	drm_atomic_helper_wait_for_fences(dev, state, false);
+
+	msm_atomic_commit_tail(state);
 
 	drm_atomic_state_put(state);
 
@@ -143,7 +150,7 @@ static void complete_commit(struct msm_commit *c, bool async)
 
 static void commit_worker(struct work_struct *work)
 {
-	complete_commit(container_of(work, struct msm_commit, work), true);
+	complete_commit(container_of(work, struct msm_commit, work));
 }
 
 /**
@@ -242,7 +249,7 @@ int msm_atomic_commit(struct drm_device *dev,
 		return 0;
 	}
 
-	complete_commit(c, false);
+	complete_commit(c);
 
 	return 0;
 
-- 
Sean Paul, Software Engineer, Google / Chromium OS
