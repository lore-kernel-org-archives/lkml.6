Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757223AbeDKTa1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:30:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756329AbeDKTaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:30:18 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/10] drm/atomic: Print debug message on atomic check failure
Date: Wed, 11 Apr 2018 15:29:28 -0400
Message-Id: <20180411192951.21997-2-lyude@redhat.com>
In-Reply-To: <20180411192951.21997-1-lyude@redhat.com>
References: <20180411192951.21997-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does what it says on the label, it's a little confusing debugging atomic
check failures otherwise.

Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_atomic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 7d25c42f22db..972a7e9634ab 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1705,8 +1705,11 @@ int drm_atomic_check_only(struct drm_atomic_state *state)
 	if (config->funcs->atomic_check)
 		ret = config->funcs->atomic_check(state->dev, state);
 
-	if (ret)
+	if (ret) {
+		DRM_DEBUG_ATOMIC("atomic driver check for %p failed: %d\n",
+				 state, ret);
 		return ret;
+	}
 
 	if (!state->allow_modeset) {
 		for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
-- 
2.14.3
