Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAB5C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E0B2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E0B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeLNB1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:27:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbeLNB1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:27:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E01BE750DA;
        Fri, 14 Dec 2018 01:27:08 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79339600C0;
        Fri, 14 Dec 2018 01:27:07 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [WIP PATCH 12/15] drm/dp_mst: Add some atomic state iterator macros
Date:   Thu, 13 Dec 2018 20:25:41 -0500
Message-Id: <20181214012604.13746-13-lyude@redhat.com>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 14 Dec 2018 01:27:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6:
 - Move EXPORT_SYMBOL() for drm_dp_mst_topology_state_funcs to this
   commit
 - Document __drm_dp_mst_state_iter_get() and note that it shouldn't be
   called directly

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_dp_mst_topology.c |  5 +-
 include/drm/drm_dp_mst_helper.h       | 96 +++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 93f08bfd2ab3..8d94c8943ac7 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3415,10 +3415,11 @@ static void drm_dp_mst_destroy_state(struct drm_private_obj *obj,
 	kfree(mst_state);
 }
 
-static const struct drm_private_state_funcs mst_state_funcs = {
+const struct drm_private_state_funcs drm_dp_mst_topology_state_funcs = {
 	.atomic_duplicate_state = drm_dp_mst_duplicate_state,
 	.atomic_destroy_state = drm_dp_mst_destroy_state,
 };
+EXPORT_SYMBOL(drm_dp_mst_topology_state_funcs);
 
 /**
  * drm_atomic_get_mst_topology_state: get MST topology state
@@ -3502,7 +3503,7 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 
 	drm_atomic_private_obj_init(dev, &mgr->base,
 				    &mst_state->base,
-				    &mst_state_funcs);
+				    &drm_dp_mst_topology_state_funcs);
 
 	return 0;
 }
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 50643a39765d..b8a8d75410d0 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -637,4 +637,100 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
 void drm_dp_mst_get_port_malloc(struct drm_dp_mst_port *port);
 void drm_dp_mst_put_port_malloc(struct drm_dp_mst_port *port);
 
+extern const struct drm_private_state_funcs drm_dp_mst_topology_state_funcs;
+
+/**
+ * __drm_dp_mst_state_iter_get - private atomic state iterator function for
+ * macro-internal use
+ * @state: &struct drm_atomic_state pointer
+ * @mgr: pointer to the &struct drm_dp_mst_topology_mgr iteration cursor
+ * @old_state: optional pointer to the old &struct drm_dp_mst_topology_state
+ * iteration cursor
+ * @new_state: optional pointer to the new &struct drm_dp_mst_topology_state
+ * iteration cursor
+ * @i: int iteration cursor, for macro-internal use
+ *
+ * Used by for_each_oldnew_mst_mgr_in_state(),
+ * for_each_old_mst_mgr_in_state(), and for_each_new_mst_mgr_in_state(). Don't
+ * call this directly.
+ *
+ * Returns:
+ * True if the current &struct drm_private_obj is a &struct
+ * drm_dp_mst_topology_mgr, false otherwise.
+ */
+static inline bool
+__drm_dp_mst_state_iter_get(struct drm_atomic_state *state,
+			    struct drm_dp_mst_topology_mgr **mgr,
+			    struct drm_dp_mst_topology_state **old_state,
+			    struct drm_dp_mst_topology_state **new_state,
+			    int i)
+{
+	struct __drm_private_objs_state *objs_state = &state->private_objs[i];
+
+	if (objs_state->ptr->funcs != &drm_dp_mst_topology_state_funcs)
+		return false;
+
+	*mgr = to_dp_mst_topology_mgr(objs_state->ptr);
+	if (old_state)
+		*old_state = to_dp_mst_topology_state(objs_state->old_state);
+	if (new_state)
+		*new_state = to_dp_mst_topology_state(objs_state->new_state);
+
+	return true;
+}
+
+/**
+ * for_each_oldnew_mst_mgr_in_state - iterate over all DP MST topology
+ * managers in an atomic update
+ * @__state: &struct drm_atomic_state pointer
+ * @mgr: &struct drm_dp_mst_topology_mgr iteration cursor
+ * @old_state: &struct drm_dp_mst_topology_state iteration cursor for the old
+ * state
+ * @new_state: &struct drm_dp_mst_topology_state iteration cursor for the new
+ * state
+ * @__i: int iteration cursor, for macro-internal use
+ *
+ * This iterates over all DRM DP MST topology managers in an atomic update,
+ * tracking both old and new state. This is useful in places where the state
+ * delta needs to be considered, for example in atomic check functions.
+ */
+#define for_each_oldnew_mst_mgr_in_state(__state, mgr, old_state, new_state, __i) \
+	for ((__i) = 0; (__i) < (__state)->num_private_objs; (__i)++) \
+		for_each_if(__drm_dp_mst_state_iter_get((__state), &(mgr), &(old_state), &(new_state), (__i)))
+
+/**
+ * for_each_old_mst_mgr_in_state - iterate over all DP MST topology managers
+ * in an atomic update
+ * @__state: &struct drm_atomic_state pointer
+ * @mgr: &struct drm_dp_mst_topology_mgr iteration cursor
+ * @old_state: &struct drm_dp_mst_topology_state iteration cursor for the old
+ * state
+ * @__i: int iteration cursor, for macro-internal use
+ *
+ * This iterates over all DRM DP MST topology managers in an atomic update,
+ * tracking only the old state. This is useful in disable functions, where we
+ * need the old state the hardware is still in.
+ */
+#define for_each_old_mst_mgr_in_state(__state, mgr, old_state, __i) \
+	for ((__i) = 0; (__i) < (__state)->num_private_objs; (__i)++) \
+		for_each_if(__drm_dp_mst_state_iter_get((__state), &(mgr), &(old_state), NULL, (__i)))
+
+/**
+ * for_each_new_mst_mgr_in_state - iterate over all DP MST topology managers
+ * in an atomic update
+ * @__state: &struct drm_atomic_state pointer
+ * @mgr: &struct drm_dp_mst_topology_mgr iteration cursor
+ * @new_state: &struct drm_dp_mst_topology_state iteration cursor for the new
+ * state
+ * @__i: int iteration cursor, for macro-internal use
+ *
+ * This iterates over all DRM DP MST topology managers in an atomic update,
+ * tracking only the new state. This is useful in enable functions, where we
+ * need the new state the hardware should be in when the atomic commit
+ * operation has completed.
+ */
+#define for_each_new_mst_mgr_in_state(__state, mgr, new_state, __i) \
+	for ((__i) = 0; (__i) < (__state)->num_private_objs; (__i)++) \
+		for_each_if(__drm_dp_mst_state_iter_get((__state), &(mgr), NULL, &(new_state), (__i)))
+
 #endif
-- 
2.19.2

