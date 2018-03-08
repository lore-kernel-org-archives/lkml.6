Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbeCHXY3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:24:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751173AbeCHXY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:24:28 -0500
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        "David Airlie" <airlied@linux.ie>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>, linux-kernel@vger.kernel.org,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Sean Paul" <seanpaul@chromium.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Gustavo Padovan" <gustavo@padovan.org>
Subject: [PATCH 0/6] Implement proper MST fallback retraining in i915
Date: Thu,  8 Mar 2018 18:24:14 -0500
Message-Id: <20180308232421.14049-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first version of my patch series to implement MST fallback
retraining in i915, along with improving the stability of i915's mst
retraining in general. Additionally, it also introduces helpers into DRM
to help with correctly handling MST fallback retraining so that other
drivers may also implement it. If your driver has a homegrown
implementation of this, you should convert it to these helpers to ensure
that the behavior of atomic commits and connector's link status
properties in the event of requiring retraining on an MST topology
remains consistent between DRM drivers.

Additionally, this lets me use the DisplayPort on my dock so I can
finally free up the thunderbolt 3 connector on it for more useful
things. At long last :).

Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>

Lyude Paul (6):
  drm/i915: Remove unused DP_LINK_CHECK_TIMEOUT
  drm/i915: Move DP modeset retry work into intel_dp
  drm/i915: Only use one link bw config for MST topologies
  drm/dp_mst: Add drm_dp_mst_topology_mgr_lower_link_rate()
  drm/dp_mst: Add drm_atomic_dp_mst_retrain_topology()
  drm/i915: Implement proper fallback training for MST

 drivers/gpu/drm/drm_dp_mst_topology.c         | 296 ++++++++++++++++++++-
 drivers/gpu/drm/i915/intel_display.c          |  23 +-
 drivers/gpu/drm/i915/intel_dp.c               | 360 +++++++++++++++++++-------
 drivers/gpu/drm/i915/intel_dp_link_training.c |   2 +-
 drivers/gpu/drm/i915/intel_dp_mst.c           |  64 +++--
 drivers/gpu/drm/i915/intel_drv.h              |  23 +-
 include/drm/drm_dp_mst_helper.h               |   5 +
 7 files changed, 662 insertions(+), 111 deletions(-)

-- 
2.14.3
