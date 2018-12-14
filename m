Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A150C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D014C20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D014C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeLNB1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:27:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbeLNB1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:27:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 183A8307DAA2;
        Fri, 14 Dec 2018 01:27:11 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EADF600C0;
        Fri, 14 Dec 2018 01:27:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [WIP PATCH 13/15] drm/dp_mst: Start tracking per-port VCPI allocations
Date:   Thu, 13 Dec 2018 20:25:42 -0500
Message-Id: <20181214012604.13746-14-lyude@redhat.com>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 14 Dec 2018 01:27:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been a TODO waiting for quite a long time in
drm_dp_mst_topology.c:

	/* We cannot rely on port->vcpi.num_slots to update
	 * topology_state->avail_slots as the port may not exist if the parent
	 * branch device was unplugged. This should be fixed by tracking
	 * per-port slot allocation in drm_dp_mst_topology_state instead of
	 * depending on the caller to tell us how many slots to release.
	 */

That's not the only reason we should fix this: forcing the driver to
track the VCPI allocations throughout a state's atomic check is
error prone, because it means that extra care has to be taken with the
order that drm_dp_atomic_find_vcpi_slots() and
drm_dp_atomic_release_vcpi_slots() are called in in order to ensure
idempotency. Currently the only driver actually using these helpers,
i915, doesn't even do this correctly: multiple ->best_encoder() checks
with i915's current implementation would not be idempotent and would
over-allocate VCPI slots, something I learned trying to implement
fallback retraining in MST.

So: simplify this whole mess, and teach drm_dp_atomic_find_vcpi_slots()
and drm_dp_atomic_release_vcpi_slots() to track the VCPI allocations for
each port. This allows us to ensure idempotency without having to rely
on the driver as much. Additionally: the driver doesn't need to do any
kind of VCPI slot tracking anymore if it doesn't need it for it's own
internal state.

Additionally; this adds a new drm_dp_mst_atomic_check() helper which
must be used by atomic drivers to perform validity checks for the new
VCPI allocations incurred by a state.

Also: update the documentation and make it more obvious that these
/must/ be called by /all/ atomic drivers supporting MST.

Changes since v6:
 - Keep a kref to all of the ports we have allocations on. This required
   a good bit of changing to when we call drm_dp_find_vcpi_slots(),
   mainly that we need to ensure that we only redo VCPI allocations on
   actual mode or CRTC changes, not crtc_state->active changes.
   Additionally, we no longer take the registration of the DRM connector
   for each port into account because so long as we have a kref to the
   port in the new or previous atomic state, the connector will stay
   registered.
 - Use the small changes to drm_dp_put_port() to add even more error
   checking to make misusage of the helpers more obvious. I added this
   after having to chase down various use-after-free conditions that
   started popping up from the new helpers so no one else has to
   troubleshoot that.
 - Move some accidental DRM_DEBUG_KMS() calls to DRM_DEBUG_ATOMIC()
 - Update documentation again, note that find/release() should both not be
   called on the same port in a single atomic check phase (but multiple
   calls to one or the other is OK)

Changes since v4:
 - Don't skip the atomic checks for VCPI allocations if no new VCPI
   allocations happen in a state. This makes the next change I'm about
   to list here a lot easier to implement.
 - Don't ignore VCPI allocations on destroyed ports, instead ensure that
   when ports are destroyed and still have VCPI allocations in the
   topology state, the only state changes allowed are releasing said
   ports' VCPI. This prevents a state with a mix of VCPI allocations
   from destroyed ports, and allocations from valid ports.

Changes since v3:
 - Don't release VCPI allocations in the topology state immediately in
   drm_dp_atomic_release_vcpi_slots(), instead mark them as 0 and skip
   over them in drm_dp_mst_duplicate_state(). This makes it so
   drm_dp_atomic_release_vcpi_slots() is still idempotent while also
   throwing warnings if the driver messes up it's book keeping and tries
   to release VCPI slots on a port that doesn't have any pre-existing
   VCPI allocation - danvet
 - Change mst_state/state in some debugging messages to "mst state"

Changes since v2:
 - Use kmemdup() for duplicating MST state - danvet
 - Move port validation out of duplicate state callback - danvet
 - Handle looping through MST topology states in
   drm_dp_mst_atomic_check() so the driver doesn't have to do it
 - Fix documentation in drm_dp_atomic_find_vcpi_slots()
 - Move the atomic check for each individual topology state into it's
   own function, reduces indenting
 - Don't consider "stale" MST ports when calculating the bandwidth
   requirements. This is needed because originally we relied on the
   state duplication functions to prune any stale ports from the new
   state, which would prevent us from incorrectly considering their
   bandwidth requirements alongside legitimate new payloads.
 - Add function references in drm_dp_atomic_release_vcpi_slots() - danvet
 - Annotate atomic VCPI and atomic check functions with __must_check
   - danvet

Changes since v1:
 - Don't use the now-removed ->atomic_check() for private objects hook,
   just give drivers a function to call themselves

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 271 +++++++++++++++++++++++---
 drivers/gpu/drm/i915/intel_display.c  |   4 +
 drivers/gpu/drm/i915/intel_dp_mst.c   |  64 +++---
 include/drm/drm_dp_mst_helper.h       |  24 ++-
 4 files changed, 298 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 8d94c8943ac7..b9374c981a5b 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2897,21 +2897,42 @@ static int drm_dp_init_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 }
 
 /**
- * drm_dp_atomic_find_vcpi_slots() - Find and add vcpi slots to the state
+ * drm_dp_atomic_find_vcpi_slots() - Find and add VCPI slots to the state
  * @state: global atomic state
  * @mgr: MST topology manager for the port
  * @port: port to find vcpi slots for
  * @pbn: bandwidth required for the mode in PBN
  *
- * RETURNS:
- * Total slots in the atomic state assigned for this port or error
+ * Allocates VCPI slots to @port, replacing any previous VCPI allocations it
+ * may have had. Any atomic drivers which support MST must call this function
+ * in their &drm_encoder_helper_funcs.atomic_check() callback to change the
+ * current VCPI allocation for the new state, but only when
+ * &drm_crtc_state.mode_changed or &drm_crtc_state.connectors_changed is set
+ * to ensure compatibility with userspace applications that still use the
+ * legacy modesetting UAPI.
+ *
+ * Allocations set by this function are not checked against the bandwidth
+ * restraints of @mgr until the driver calls drm_dp_mst_atomic_check().
+ *
+ * Additionally, it is OK to call this function multiple times on the same
+ * @port as needed. It is not OK however, to call this function and
+ * drm_dp_atomic_release_vcpi_slots() in the same atomic check phase.
+ *
+ * See also:
+ * drm_dp_atomic_release_vcpi_slots()
+ * drm_dp_mst_atomic_check()
+ *
+ * Returns:
+ * Total slots in the atomic state assigned for this port, or a negative error
+ * code if the port no longer exists
  */
 int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 				  struct drm_dp_mst_topology_mgr *mgr,
 				  struct drm_dp_mst_port *port, int pbn)
 {
 	struct drm_dp_mst_topology_state *topology_state;
-	int req_slots;
+	struct drm_dp_vcpi_allocation *pos, *vcpi = NULL;
+	int prev_slots, req_slots, ret;
 
 	topology_state = drm_atomic_get_mst_topology_state(state, mgr);
 	if (IS_ERR(topology_state))
@@ -2920,20 +2941,56 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 	port = drm_dp_mst_topology_get_port_validated(mgr, port);
 	if (port == NULL)
 		return -EINVAL;
-	req_slots = DIV_ROUND_UP(pbn, mgr->pbn_div);
-	DRM_DEBUG_KMS("vcpi slots req=%d, avail=%d\n",
-			req_slots, topology_state->avail_slots);
 
-	if (req_slots > topology_state->avail_slots) {
-		drm_dp_mst_topology_put_port(port);
-		return -ENOSPC;
+	topology_state->vcpi_allocated = true;
+
+	/* Find the current allocation for this port, if any */
+	list_for_each_entry(pos, &topology_state->vcpis, next) {
+		if (pos->port == port) {
+			vcpi = pos;
+			prev_slots = vcpi->vcpi;
+
+			/*
+			 * This should never happen, unless the driver tries
+			 * releasing and allocating the same VCPI allocation,
+			 * which is an error
+			 */
+			if (WARN_ON(!prev_slots)) {
+				DRM_ERROR("cannot allocate and release VCPI on [MST PORT:%p] in the same state\n",
+					  port);
+				return -EINVAL;
+			}
+
+			break;
+		}
 	}
+	if (!vcpi)
+		prev_slots = 0;
+
+	req_slots = DIV_ROUND_UP(pbn, mgr->pbn_div);
+
+	DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] [MST PORT:%p] VCPI %d -> %d\n",
+			 port->connector->base.id, port->connector->name,
+			 port, prev_slots, req_slots);
 
-	topology_state->avail_slots -= req_slots;
-	DRM_DEBUG_KMS("vcpi slots avail=%d", topology_state->avail_slots);
+	/* Add the new allocation to the state */
+	if (!vcpi) {
+		vcpi = kzalloc(sizeof(*vcpi), GFP_KERNEL);
+		if (!vcpi) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
+		drm_dp_mst_get_port_malloc(port);
+		vcpi->port = port;
+		list_add(&vcpi->next, &topology_state->vcpis);
+	}
+	vcpi->vcpi = req_slots;
+
+	ret = req_slots;
+out:
 	drm_dp_mst_topology_put_port(port);
-	return req_slots;
+	return ret;
 }
 EXPORT_SYMBOL(drm_dp_atomic_find_vcpi_slots);
 
@@ -2941,31 +2998,57 @@ EXPORT_SYMBOL(drm_dp_atomic_find_vcpi_slots);
  * drm_dp_atomic_release_vcpi_slots() - Release allocated vcpi slots
  * @state: global atomic state
  * @mgr: MST topology manager for the port
- * @slots: number of vcpi slots to release
+ * @port: The port to release the VCPI slots from
  *
- * RETURNS:
- * 0 if @slots were added back to &drm_dp_mst_topology_state->avail_slots or
- * negative error code
+ * Releases any VCPI slots that have been allocated to a port in the atomic
+ * state. Any atomic drivers which support MST must call this function in
+ * their &drm_connector_helper_funcs.atomic_check() callback when the
+ * connector will no longer have VCPI allocated (e.g. because it's CRTC was
+ * removed) when it had VCPI allocated in the previous atomic state.
+ *
+ * It is OK to call this even if @port has been removed from the system.
+ * Additionally, it is OK to call this function multiple times on the same
+ * @port as needed. It is not OK however, to call this function and
+ * drm_dp_atomic_find_vcpi_slots() on the same @port in a single atomic check
+ * phase.
+ *
+ * See also:
+ * drm_dp_atomic_find_vcpi_slots()
+ * drm_dp_mst_atomic_check()
+ *
+ * Returns:
+ * 0 if all slots for this port were added back to
+ * &drm_dp_mst_topology_state.avail_slots or negative error code
  */
 int drm_dp_atomic_release_vcpi_slots(struct drm_atomic_state *state,
 				     struct drm_dp_mst_topology_mgr *mgr,
-				     int slots)
+				     struct drm_dp_mst_port *port)
 {
 	struct drm_dp_mst_topology_state *topology_state;
+	struct drm_dp_vcpi_allocation *pos;
+	bool found = false;
 
 	topology_state = drm_atomic_get_mst_topology_state(state, mgr);
 	if (IS_ERR(topology_state))
 		return PTR_ERR(topology_state);
 
-	/* We cannot rely on port->vcpi.num_slots to update
-	 * topology_state->avail_slots as the port may not exist if the parent
-	 * branch device was unplugged. This should be fixed by tracking
-	 * per-port slot allocation in drm_dp_mst_topology_state instead of
-	 * depending on the caller to tell us how many slots to release.
-	 */
-	topology_state->avail_slots += slots;
-	DRM_DEBUG_KMS("vcpi slots released=%d, avail=%d\n",
-			slots, topology_state->avail_slots);
+	list_for_each_entry(pos, &topology_state->vcpis, next) {
+		if (pos->port == port) {
+			found = true;
+			break;
+		}
+	}
+	if (WARN_ON(!found)) {
+		DRM_ERROR("no VCPI for [MST PORT:%p] found in mst state %p\n",
+			  port, &topology_state->base);
+		return -EINVAL;
+	}
+
+	DRM_DEBUG_ATOMIC("[MST PORT:%p] VCPI %d -> 0\n", port, pos->vcpi);
+	if (pos->vcpi) {
+		drm_dp_mst_put_port_malloc(port);
+		pos->vcpi = 0;
+	}
 
 	return 0;
 }
@@ -3395,15 +3478,42 @@ static void drm_dp_destroy_connector_work(struct work_struct *work)
 static struct drm_private_state *
 drm_dp_mst_duplicate_state(struct drm_private_obj *obj)
 {
-	struct drm_dp_mst_topology_state *state;
+	struct drm_dp_mst_topology_state *state, *old_state =
+		to_dp_mst_topology_state(obj->state);
+	struct drm_dp_vcpi_allocation *pos, *vcpi;
 
-	state = kmemdup(obj->state, sizeof(*state), GFP_KERNEL);
+	state = kmemdup(old_state, sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return NULL;
 
 	__drm_atomic_helper_private_obj_duplicate_state(obj, &state->base);
 
+	INIT_LIST_HEAD(&state->vcpis);
+	state->vcpi_allocated = false;
+
+	list_for_each_entry(pos, &old_state->vcpis, next) {
+		/* Prune leftover freed VCPI allocations */
+		if (!pos->vcpi)
+			continue;
+
+		vcpi = kmemdup(pos, sizeof(*vcpi), GFP_KERNEL);
+		if (!vcpi)
+			goto fail;
+
+		drm_dp_mst_get_port_malloc(vcpi->port);
+		list_add(&vcpi->next, &state->vcpis);
+	}
+
 	return &state->base;
+
+fail:
+	list_for_each_entry_safe(pos, vcpi, &state->vcpis, next) {
+		drm_dp_mst_put_port_malloc(pos->port);
+		kfree(pos);
+	}
+	kfree(state);
+
+	return NULL;
 }
 
 static void drm_dp_mst_destroy_state(struct drm_private_obj *obj,
@@ -3411,10 +3521,109 @@ static void drm_dp_mst_destroy_state(struct drm_private_obj *obj,
 {
 	struct drm_dp_mst_topology_state *mst_state =
 		to_dp_mst_topology_state(state);
+	struct drm_dp_vcpi_allocation *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &mst_state->vcpis, next) {
+		/* We only keep references to ports with non-zero VCPIs */
+		if (pos->vcpi)
+			drm_dp_mst_put_port_malloc(pos->port);
+		kfree(pos);
+	}
 
 	kfree(mst_state);
 }
 
+static inline int
+drm_dp_mst_atomic_check_topology_state(struct drm_dp_mst_topology_mgr *mgr,
+				       struct drm_dp_mst_topology_state *mst_state)
+{
+	struct drm_dp_vcpi_allocation *vcpi;
+	int avail_slots = 63, ret;
+
+	/* There's no possible scenario where releasing VCPI or keeping it the
+	 * same would make the state invalid
+	 */
+	if (!mst_state->vcpi_allocated) {
+		DRM_DEBUG_ATOMIC("[MST MGR:%p] state %p allocates no VCPI, check skipped\n",
+				 mgr, &mst_state->base);
+		return 0;
+	}
+
+	list_for_each_entry(vcpi, &mst_state->vcpis, next) {
+		/* Releasing VCPI is always OK-even if the port is gone */
+		if (!vcpi->vcpi) {
+			DRM_DEBUG_ATOMIC("[MST PORT:%p] releases all VCPI slots\n",
+					 vcpi->port);
+			continue;
+		}
+
+		if (!drm_dp_mst_topology_get_port(vcpi->port)) {
+			DRM_DEBUG_ATOMIC("[MST PORT:%p] is gone but still has VCPI, cannot add new VCPI\n",
+					 vcpi->port);
+			return -EINVAL;
+		}
+
+		DRM_DEBUG_ATOMIC("[MST PORT:%p] requires %d vcpi slots\n",
+				 vcpi->port, vcpi->vcpi);
+
+		avail_slots -= vcpi->vcpi;
+		if (avail_slots < 0) {
+			DRM_DEBUG_ATOMIC("[MST PORT:%p] not enough VCPI slots in mst state %p (avail=%d)\n",
+					 vcpi->port, mst_state,
+					 avail_slots + vcpi->vcpi);
+			ret = -ENOSPC;
+			goto port_fail;
+		}
+
+		drm_dp_mst_topology_put_port(vcpi->port);
+	}
+	DRM_DEBUG_ATOMIC("[MST MGR:%p] mst state %p VCPI avail=%d used=%d\n",
+			 mgr, mst_state, avail_slots,
+			 63 - avail_slots);
+
+	return 0;
+port_fail:
+	drm_dp_mst_topology_put_port(vcpi->port);
+	return ret;
+}
+
+/**
+ * drm_dp_mst_atomic_check - Check that the new state of an MST topology in an
+ * atomic update is valid
+ * @state: Pointer to the new &struct drm_dp_mst_topology_state
+ *
+ * Checks the given topology state for an atomic update to ensure that it's
+ * valid. This includes checking whether there's enough bandwidth to support
+ * the new VCPI allocations in the atomic update.
+ *
+ * Any atomic drivers supporting DP MST must make sure to call this after
+ * checking the rest of their state in their
+ * &drm_mode_config_funcs.atomic_check() callback.
+ *
+ * See also:
+ * drm_dp_atomic_find_vcpi_slots()
+ * drm_dp_atomic_release_vcpi_slots()
+ *
+ * Returns:
+ *
+ * 0 if the new state is valid, negative error code otherwise.
+ */
+int drm_dp_mst_atomic_check(struct drm_atomic_state *state)
+{
+	struct drm_dp_mst_topology_mgr *mgr;
+	struct drm_dp_mst_topology_state *mst_state;
+	int i, ret = 0;
+
+	for_each_new_mst_mgr_in_state(state, mgr, mst_state, i) {
+		ret = drm_dp_mst_atomic_check_topology_state(mgr, mst_state);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_dp_mst_atomic_check);
+
 const struct drm_private_state_funcs drm_dp_mst_topology_state_funcs = {
 	.atomic_duplicate_state = drm_dp_mst_duplicate_state,
 	.atomic_destroy_state = drm_dp_mst_destroy_state,
@@ -3497,9 +3706,7 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 		return -ENOMEM;
 
 	mst_state->mgr = mgr;
-
-	/* max. time slots - one slot for MTP header */
-	mst_state->avail_slots = 63;
+	INIT_LIST_HEAD(&mst_state->vcpis);
 
 	drm_atomic_private_obj_init(dev, &mgr->base,
 				    &mst_state->base,
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 2c3f3f68d506..868cb897f629 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -12690,6 +12690,10 @@ static int intel_atomic_check(struct drm_device *dev,
 				       "[modeset]" : "[fastset]");
 	}
 
+	ret = drm_dp_mst_atomic_check(state);
+	if (ret)
+		return ret;
+
 	if (any_ms) {
 		ret = intel_modeset_checks(state);
 
diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index 4d6ced34d465..6754d7922a34 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -41,8 +41,13 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 	struct drm_connector *connector = conn_state->connector;
 	void *port = to_intel_connector(connector)->port;
 	struct drm_atomic_state *state = pipe_config->base.state;
+	struct drm_crtc *crtc = pipe_config->base.crtc;
+	struct drm_crtc_state *old_crtc_state =
+		drm_atomic_get_old_crtc_state(state, crtc);
+	struct drm_crtc_state *new_crtc_state = &pipe_config->base;
 	int bpp;
-	int lane_count, slots = 0;
+	int lane_count, slots =
+		to_intel_crtc_state(old_crtc_state)->dp_m_n.tu;
 	const struct drm_display_mode *adjusted_mode = &pipe_config->base.adjusted_mode;
 	int mst_pbn;
 	bool constant_n = drm_dp_has_quirk(&intel_dp->desc,
@@ -77,8 +82,12 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 	mst_pbn = drm_dp_calc_pbn_mode(adjusted_mode->crtc_clock, bpp);
 	pipe_config->pbn = mst_pbn;
 
-	/* Zombie connectors can't have VCPI slots */
-	if (!drm_connector_is_unregistered(connector)) {
+	/* Only change VCPI allocation on actual mode changes, to prevent us
+	 * from trying to allocate VCPI to ports that no longer exist when we
+	 * may just be trying to disable DPMS on them
+	 */
+	if (new_crtc_state->mode_changed ||
+	    new_crtc_state->connectors_changed) {
 		slots = drm_dp_atomic_find_vcpi_slots(state,
 						      &intel_dp->mst_mgr,
 						      port,
@@ -107,36 +116,39 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 	return true;
 }
 
-static int intel_dp_mst_atomic_check(struct drm_connector *connector,
-		struct drm_connector_state *new_conn_state)
+static int
+intel_dp_mst_atomic_check(struct drm_connector *connector,
+			  struct drm_connector_state *new_conn_state)
 {
+	struct intel_connector *intel_connector =
+		to_intel_connector(connector);
+	struct drm_dp_mst_topology_mgr *mgr =
+		&intel_connector->mst_port->mst_mgr;
+	struct drm_dp_mst_port *port = intel_connector->port;
 	struct drm_atomic_state *state = new_conn_state->state;
-	struct drm_connector_state *old_conn_state;
-	struct drm_crtc *old_crtc;
-	struct drm_crtc_state *crtc_state;
-	int slots, ret = 0;
+	struct drm_connector_state *old_conn_state =
+		drm_atomic_get_old_connector_state(state, connector);
+	struct drm_crtc *old_crtc = old_conn_state->crtc,
+			*new_crtc = new_conn_state->crtc;
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 
-	old_conn_state = drm_atomic_get_old_connector_state(state, connector);
-	old_crtc = old_conn_state->crtc;
 	if (!old_crtc)
-		return ret;
+		return 0;
 
-	crtc_state = drm_atomic_get_new_crtc_state(state, old_crtc);
-	slots = to_intel_crtc_state(crtc_state)->dp_m_n.tu;
-	if (drm_atomic_crtc_needs_modeset(crtc_state) && slots > 0) {
-		struct drm_dp_mst_topology_mgr *mgr;
-		struct drm_encoder *old_encoder;
+	old_crtc_state = drm_atomic_get_old_crtc_state(state, old_crtc);
+	if (!old_crtc_state ||
+	    !to_intel_crtc_state(old_crtc_state)->dp_m_n.tu)
+		return 0;
 
-		old_encoder = old_conn_state->best_encoder;
-		mgr = &enc_to_mst(old_encoder)->primary->dp.mst_mgr;
+	/* If we switched CRTCs, clear the previous one's allocation */
+	new_crtc_state = drm_atomic_get_new_crtc_state(state, old_crtc);
+	if (new_crtc_state->connectors_changed && !new_crtc_state->enable)
+		to_intel_crtc_state(new_crtc_state)->dp_m_n.tu = 0;
 
-		ret = drm_dp_atomic_release_vcpi_slots(state, mgr, slots);
-		if (ret)
-			DRM_DEBUG_KMS("failed releasing %d vcpi slots:%d\n", slots, ret);
-		else
-			to_intel_crtc_state(crtc_state)->dp_m_n.tu = 0;
-	}
-	return ret;
+	if (new_crtc)
+		return 0;
+
+	return drm_dp_atomic_release_vcpi_slots(state, mgr, port);
 }
 
 static void intel_mst_disable_dp(struct intel_encoder *encoder,
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index b8a8d75410d0..79e3f9c730a5 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -412,9 +412,16 @@ struct drm_dp_payload {
 
 #define to_dp_mst_topology_state(x) container_of(x, struct drm_dp_mst_topology_state, base)
 
+struct drm_dp_vcpi_allocation {
+	struct drm_dp_mst_port *port;
+	int vcpi;
+	struct list_head next;
+};
+
 struct drm_dp_mst_topology_state {
 	struct drm_private_state base;
-	int avail_slots;
+	struct list_head vcpis;
+	u8 vcpi_allocated;
 	struct drm_dp_mst_topology_mgr *mgr;
 };
 
@@ -625,14 +632,17 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
 int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
 struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
 								    struct drm_dp_mst_topology_mgr *mgr);
-int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
-				  struct drm_dp_mst_topology_mgr *mgr,
-				  struct drm_dp_mst_port *port, int pbn);
-int drm_dp_atomic_release_vcpi_slots(struct drm_atomic_state *state,
-				     struct drm_dp_mst_topology_mgr *mgr,
-				     int slots);
+int __must_check
+drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
+			      struct drm_dp_mst_topology_mgr *mgr,
+			      struct drm_dp_mst_port *port, int pbn);
+int __must_check
+drm_dp_atomic_release_vcpi_slots(struct drm_atomic_state *state,
+				 struct drm_dp_mst_topology_mgr *mgr,
+				 struct drm_dp_mst_port *port);
 int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
 				 struct drm_dp_mst_port *port, bool power_up);
+int __must_check drm_dp_mst_atomic_check(struct drm_atomic_state *state);
 
 void drm_dp_mst_get_port_malloc(struct drm_dp_mst_port *port);
 void drm_dp_mst_put_port_malloc(struct drm_dp_mst_port *port);
-- 
2.19.2

