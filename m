Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeDBWsT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:48:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754516AbeDBWsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:48:16 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/10] drm/dp_mst: Remove all evil duplicate state pointers
Date: Mon,  2 Apr 2018 18:47:40 -0400
Message-Id: <20180402224800.16080-5-lyude@redhat.com>
In-Reply-To: <20180402224800.16080-1-lyude@redhat.com>
References: <20180402224800.16080-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to track the atomic state three times. Unfortunately,
this is currently what we're doing, and even worse is that there is only
one actually correct state pointer: the one in mst_state->base.state.
mgr->state never seems to be used, along with the one in
mst_state->state.

This confused me for over 4 hours until I realized there was no magic
behind these pointers. So, let's save everyone else from the trouble.

Signed-off-by: Lyude Paul <lyude@redhat.com>.
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/drm/drm_dp_mst_helper.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 41a8f08da05d..035963fbcd9d 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -409,7 +409,6 @@ struct drm_dp_payload {
 struct drm_dp_mst_topology_state {
 	struct drm_private_state base;
 	int avail_slots;
-	struct drm_atomic_state *state;
 	struct drm_dp_mst_topology_mgr *mgr;
 };
 
@@ -497,11 +496,6 @@ struct drm_dp_mst_topology_mgr {
 	 */
 	int pbn_div;
 
-	/**
-	 * @state: State information for topology manager
-	 */
-	struct drm_dp_mst_topology_state *state;
-
 	/**
 	 * @funcs: Atomic helper callbacks
 	 */
-- 
2.14.3
