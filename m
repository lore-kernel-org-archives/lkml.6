Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC12C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ED3206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbfAPUiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:38:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732714AbfAPUiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:38:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73B3AC05D3E1;
        Wed, 16 Jan 2019 20:38:10 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DC805D967;
        Wed, 16 Jan 2019 20:38:07 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/dp_mst: Remove lock check in drm_atomic_get_mst_topology_state()
Date:   Wed, 16 Jan 2019 15:37:57 -0500
Message-Id: <20190116203759.31820-2-lyude@redhat.com>
In-Reply-To: <20190116203759.31820-1-lyude@redhat.com>
References: <20190116203759.31820-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 16 Jan 2019 20:38:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since modesetting locks by default were added to private objects in:

commit b962a12050a3 ("drm/atomic: integrate modeset lock with private
objects")

This means that the atomic state of a drm_dp_mst_topology_mgr is now
protected by drm_dp_mst_topology_mgr->base.lock as opposed to the main
connection_status mutex. This also means that locking isn't left up to
the caller anymore, and is handled automatically in
drm_atomic_get_private_obj_state().

So, remove the WARN_ON() in drm_atomic_get_mst_topology_state() since
that's now incorrect, and update the kernel docs for the function.
Additionally since all function is now is a simple wrapper around
drm_atomic_get_private_obj_state(), it seems more reasonable to move
this out of drm_dp_mst_topology.c and turn it into an inline function in
drm_dp_mst_helper.h

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 25 -------------------------
 include/drm/drm_dp_mst_helper.h       | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 196ebba8af5f..49575b80caeb 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3718,31 +3718,6 @@ const struct drm_private_state_funcs drm_dp_mst_topology_state_funcs = {
 };
 EXPORT_SYMBOL(drm_dp_mst_topology_state_funcs);
 
-/**
- * drm_atomic_get_mst_topology_state: get MST topology state
- *
- * @state: global atomic state
- * @mgr: MST topology manager, also the private object in this case
- *
- * This function wraps drm_atomic_get_priv_obj_state() passing in the MST atomic
- * state vtable so that the private object state returned is that of a MST
- * topology object. Also, drm_atomic_get_private_obj_state() expects the caller
- * to care of the locking, so warn if don't hold the connection_mutex.
- *
- * RETURNS:
- *
- * The MST topology state or error pointer.
- */
-struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
-								    struct drm_dp_mst_topology_mgr *mgr)
-{
-	struct drm_device *dev = mgr->dev;
-
-	WARN_ON(!drm_modeset_is_locked(&dev->mode_config.connection_mutex));
-	return to_dp_mst_topology_state(drm_atomic_get_private_obj_state(state, &mgr->base));
-}
-EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
-
 /**
  * drm_dp_mst_topology_mgr_init - initialise a topology manager
  * @mgr: manager struct to initialise
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 8c97a5f92c47..263d82178ecd 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -643,8 +643,6 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
 int __must_check
 drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
-struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
-								    struct drm_dp_mst_topology_mgr *mgr);
 int __must_check
 drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 			      struct drm_dp_mst_topology_mgr *mgr,
@@ -756,4 +754,22 @@ __drm_dp_mst_state_iter_get(struct drm_atomic_state *state,
 	for ((__i) = 0; (__i) < (__state)->num_private_objs; (__i)++) \
 		for_each_if(__drm_dp_mst_state_iter_get((__state), &(mgr), NULL, &(new_state), (__i)))
 
+/**
+ * drm_atomic_get_mst_topology_state() - get MST topology state
+ * @state: global atomic state
+ * @mgr: MST topology manager, also the private object in this case
+ *
+ * This function retrieves the atomic topology state for @mgr using
+ * drm_atomic_get_priv_obj_state().
+ *
+ * Returns:
+ * The atomic MST topology state or an error pointer.
+ */
+static inline struct drm_dp_mst_topology_state *
+drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
+				  struct drm_dp_mst_topology_mgr *mgr)
+{
+	return to_dp_mst_topology_state(drm_atomic_get_private_obj_state(
+		state, &mgr->base));
+}
 #endif
-- 
2.20.1

