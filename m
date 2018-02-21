Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936411AbeBUOhw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:37:52 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32973 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934187AbeBUOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:37:48 -0500
X-Google-Smtp-Source: AH8x225PnWX/Y1XrcJAKgkx6d6U/k2vLkG8yIwKEZmI4C3t480UCnSoUrs8Pltxq7ktnPJDYYbZ43w==
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/atomic: integrate modeset lock with private objects
Date: Wed, 21 Feb 2018 09:37:21 -0500
Message-Id: <20180221143730.30285-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221143730.30285-1-robdclark@gmail.com>
References: <20180221143730.30285-1-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the same pattern of locking as with other state objects.  This
avoids boilerplate in the driver.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/drm_atomic.c | 9 ++++++++-
 include/drm/drm_atomic.h     | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index fc8c4da409ff..004e621ab307 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1078,6 +1078,8 @@ drm_atomic_private_obj_init(struct drm_private_obj *obj,
 {
 	memset(obj, 0, sizeof(*obj));
 
+	drm_modeset_lock_init(&obj->lock);
+
 	obj->state = state;
 	obj->funcs = funcs;
 }
@@ -1093,6 +1095,7 @@ void
 drm_atomic_private_obj_fini(struct drm_private_obj *obj)
 {
 	obj->funcs->atomic_destroy_state(obj, obj->state);
+	drm_modeset_lock_fini(&obj->lock);
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_fini);
 
@@ -1113,7 +1116,7 @@ struct drm_private_state *
 drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
 				 struct drm_private_obj *obj)
 {
-	int index, num_objs, i;
+	int index, num_objs, i, ret;
 	size_t size;
 	struct __drm_private_objs_state *arr;
 	struct drm_private_state *obj_state;
@@ -1122,6 +1125,10 @@ drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
 		if (obj == state->private_objs[i].ptr)
 			return state->private_objs[i].state;
 
+	ret = drm_modeset_lock(&obj->lock, state->acquire_ctx);
+	if (ret)
+		return ERR_PTR(ret);
+
 	num_objs = state->num_private_objs + 1;
 	size = sizeof(*state->private_objs) * num_objs;
 	arr = krealloc(state->private_objs, size, GFP_KERNEL);
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 09076a625637..9ae53b73c9d2 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -218,6 +218,11 @@ struct drm_private_state_funcs {
  * &drm_modeset_lock is required to duplicate and update this object's state.
  */
 struct drm_private_obj {
+	/**
+	 * @lock: Modeset lock to protect the state object.
+	 */
+	struct drm_modeset_lock lock;
+
 	/**
 	 * @state: Current atomic state for this driver private object.
 	 */
-- 
2.14.3
