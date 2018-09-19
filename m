Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69127C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF7221527
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF7221527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbeITEtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeITEtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:49:39 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 325933082120;
        Wed, 19 Sep 2018 23:09:27 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-250.rdu2.redhat.com [10.10.122.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E07A62010D0D;
        Wed, 19 Sep 2018 23:09:23 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Julia Lawall <julia.lawall@lip6.fr>, stable@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] drm/dp_mst: Introduce drm_dp_mst_connector_atomic_check()
Date:   Wed, 19 Sep 2018 19:08:58 -0400
Message-Id: <20180919230913.16894-2-lyude@redhat.com>
In-Reply-To: <20180919230913.16894-1-lyude@redhat.com>
References: <20180919230913.16894-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 19 Sep 2018 23:09:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the way that we prevent userspace from performing new modesets
on MST connectors that have just been destroyed is rather broken.
There's nothing in the actual DRM DP MST topology helpers that checks
whether or not a connector still exists, instead each DRM driver does
this on it's own, usually by returning NULL from the best_encoder
callback which in turn, causes the atomic commit to fail.

However, this is wrong in a rather subtle way. If ->best_encoder()
returns NULL, this makes ALL modesets involving the connector fail. This
includes modesets from userspace that would shut off the CRTCs being
used by the connector. Since this results in blocking any changes to a
connector's DPMS prop, it has the sideaffect of preventing legacy
modesetting users from ever disabling a CRTC that was previously enabled
for use in an MST topology. An example of this, where X tries to
change the DPMS property of an MST connector that was just detached from
the system:

[ 2908.320131] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:82:DP-6]
[ 2908.320148] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:82:DP-6] status updated from connected to disconnected
[ 2908.320166] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:82:DP-6] disconnected
[ 2908.320193] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 111 (1)
[ 2908.320230] [drm:drm_sysfs_hotplug_event [drm]] generating hotplug event
...
[ 2908.638539] [drm:drm_ioctl [drm]] pid=12928, dev=0xe201, auth=1, DRM_IOCTL_MODE_SETPROPERTY
[ 2908.638546] [drm:drm_atomic_state_init [drm]] Allocated atomic state 000000007155ba49
[ 2908.638553] [drm:drm_mode_object_get [drm]] OBJ ID: 114 (1)
[ 2908.638560] [drm:drm_mode_object_get [drm]] OBJ ID: 108 (1)
[ 2908.638568] [drm:drm_atomic_get_crtc_state [drm]] Added [CRTC:41:head-0] 0000000097a6396e state to 000000007155ba49
[ 2908.638575] [drm:drm_atomic_add_affected_connectors [drm]] Adding all current connectors for [CRTC:41:head-0] to 000000007155ba49
[ 2908.638582] [drm:drm_mode_object_get [drm]] OBJ ID: 82 (3)
[ 2908.638589] [drm:drm_mode_object_get [drm]] OBJ ID: 82 (4)
[ 2908.638596] [drm:drm_atomic_get_connector_state [drm]] Added [CONNECTOR:82:DP-6] 0000000087427144 state to 000000007155ba49
[ 2908.638603] [drm:drm_atomic_check_only [drm]] checking 000000007155ba49
[ 2908.638609] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] [CRTC:41:head-0] active changed
[ 2908.638613] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] Updating routing for [CONNECTOR:82:DP-6]
[ 2908.638616] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] No suitable encoder found for [CONNECTOR:82:DP-6]
[ 2908.638623] [drm:drm_atomic_check_only [drm]] atomic driver check for 000000007155ba49 failed: -22
[ 2908.638630] [drm:drm_atomic_state_default_clear [drm]] Clearing atomic state 000000007155ba49
[ 2908.638637] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 82 (4)
[ 2908.638643] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 82 (3)
[ 2908.638650] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 114 (2)
[ 2908.638656] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 108 (2)
[ 2908.638663] [drm:__drm_atomic_state_free [drm]] Freeing atomic state 000000007155ba49
[ 2908.638669] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 82 (2)
[ 2908.638676] [drm:drm_ioctl [drm]] pid=12928, ret = -22

While this doesn't usually result in any errors that would be obvious to
the user, it does result in us leaving display resources on. This in
turn leads to unwanted sideaffects like inactive GPUs being left on
(usually from the resulting leaked runtime PM ref).

So, provide an easier way of doing this that doesn't require breaking
->best_encoder(): add a common drm_dp_mst_connector_atomic_check()
function that DRM drivers can call in order to have CRTC enabling
commits fail automatically if the MST port driving the connector no
longer exists. We'll also be able to expand upon this later as well once
we add MST fallback retraining support.

Changes since v1:
- Use list_for_each_entry_safe in drm_dp_mst_connector_still_exists() -
  Julia Lawall

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 76 +++++++++++++++++++++++++++
 include/drm/drm_dp_mst_helper.h       |  3 ++
 2 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 7780567aa669..58b9554711c7 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3129,6 +3129,82 @@ static const struct drm_private_state_funcs mst_state_funcs = {
 	.atomic_destroy_state = drm_dp_mst_destroy_state,
 };
 
+static bool
+drm_dp_mst_connector_still_exists(struct drm_connector *connector,
+				  struct drm_dp_mst_topology_mgr *mgr,
+				  struct drm_dp_mst_branch *mstb)
+{
+	struct drm_dp_mst_port *port, *tmp;
+	bool exists = false;
+
+	mstb = drm_dp_get_validated_mstb_ref(mgr, mstb);
+	if (!mstb)
+		return false;
+
+	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
+		port = drm_dp_get_validated_port_ref(mgr, port);
+		if (!port)
+			continue;
+
+		exists = (port->connector == connector ||
+			  (port->mstb &&
+			   drm_dp_mst_connector_still_exists(connector, mgr,
+							     port->mstb)));
+
+		drm_dp_put_port(port);
+		if (exists)
+			break;
+	}
+
+	drm_dp_put_mst_branch_device(mstb);
+	return exists;
+}
+
+/**
+ * drm_dp_mst_connector_atomic_check - Helper for validating a new atomic
+ *                                     state on an MST connector
+ * @connector: drm connector
+ * @connector_state: the new atomic state of @connector
+ * @mgr: the MST topology mgr for @connector
+ *
+ * This function performs various atomic checks that apply to all drivers
+ * using the DRM DP MST helpers. This should be called by all drivers at the
+ * start of the atomic_check function for their MST connectors.
+ *
+ * Return 0 for success, or negative error code on failure.
+ */
+int
+drm_dp_mst_connector_atomic_check(struct drm_connector *connector,
+				  struct drm_connector_state *connector_state,
+				  struct drm_dp_mst_topology_mgr *mgr)
+{
+	struct drm_atomic_state *state = connector_state->state;
+	struct drm_crtc *crtc = connector_state->crtc;
+	struct drm_crtc_state *new_crtc_state;
+
+	if (!crtc)
+		return 0;
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	if (!new_crtc_state)
+		return 0;
+
+	if (!drm_atomic_crtc_needs_modeset(new_crtc_state) ||
+	    !new_crtc_state->active)
+		return 0;
+
+	/* Make sure that the port for this MST connector still exists */
+	if (!drm_dp_mst_connector_still_exists(connector, mgr,
+					       mgr->mst_primary)) {
+		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] has disappeared from the MST topology\n",
+				 connector->base.id, connector->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_dp_mst_connector_atomic_check);
+
 /**
  * drm_atomic_get_mst_topology_state: get MST topology state
  *
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 7f78d26a0766..8e33c2c85d1e 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -625,6 +625,9 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
 int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
 struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
 								    struct drm_dp_mst_topology_mgr *mgr);
+int drm_dp_mst_connector_atomic_check(struct drm_connector *connector,
+				      struct drm_connector_state *connector_state,
+				      struct drm_dp_mst_topology_mgr *mgr);
 int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 				  struct drm_dp_mst_topology_mgr *mgr,
 				  struct drm_dp_mst_port *port, int pbn);
-- 
2.17.1

