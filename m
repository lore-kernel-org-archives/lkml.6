Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AFBC282C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C7B218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfAZBYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:24:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfAZBYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:24:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD71819D323;
        Sat, 26 Jan 2019 01:24:42 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E3911851B;
        Sat, 26 Jan 2019 01:24:37 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Todd Previte <tprevite@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Don't send MST hotplugs until after resume
Date:   Fri, 25 Jan 2019 20:24:35 -0500
Message-Id: <20190126012436.31382-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 26 Jan 2019 01:24:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out we are sending a lot more hotplug events then we need, and
this is causing some pretty serious issues. Currently, we call
intel_dp_mst_resume() in i915_drm_resume() well before we have any sort
of hotplugging setup. This is a pretty big problem, because in practice
it will generally result in throwing the power domain refcounts out of
wack.

For instance: On my T480s, removing a previously connected topology
before the system finishes resuming causes
drm_kms_helper_hotplug_event() to be called before HPD is setup again,
which causes us to do a connector reprobe, which then causes
intel_dp_detect() to be called on all DP devices -including- the eDP
display. From there, intel_dp_detect() is run on the eDP display which
triggers DPCD transactions. Those DPCD transactions then cause us to
call edp_panel_vdd_on(), which then causes us to grab an additional
wakeref to the relevant power wells (PORT_DDI_A_IO on this machine).
From there, this wakeref is never released which then causes the next
suspend/resume cycle to entirely fail due to the hardware not being
powered off correctly.

This sucks really badly, and I don't see any decent way to actually fix
this in intel_dp_detect() easily. Additionally, I don't even think it'd
be worth the time now since we're not expecting to handle any kind of
connector reprobing at the point in which we call intel_dp_mst_resume(),
but we also can't move intel_dp_mst_resume() any higher in the resume
process since MST topologies need to be resumed before
intel_display_resume() is called.

However, there's a light at the end of the tunnel! After reading through
a lot of code dozens of times, it occurred to me that we -never-
actually need to send hotplug events when calling
drm_dp_mst_topology_mgr_set_mst() since we send hotplug events in
drm_dp_destroy_connector_work(). Imagine that!

So, since we only seem to call intel_dp_mst_check_status() to disable
MST on the encoder in question and then send a hotplug, get rid of this
and instead just disable MST mode when a hub fails in
intel_dp_mst_resume(). From there, drm_dp_destroy_connector_work() will
eventually send the hotplug event.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 0e32b39ceed6 ("drm/i915: add DP 1.2 MST support (v0.7)")
Cc: Todd Previte <tprevite@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.17+
---
 drivers/gpu/drm/i915/intel_dp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index 681e88405ada..c2399acf177b 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -7096,7 +7096,10 @@ void intel_dp_mst_resume(struct drm_i915_private *dev_priv)
 			continue;
 
 		ret = drm_dp_mst_topology_mgr_resume(&intel_dp->mst_mgr);
-		if (ret)
-			intel_dp_check_mst_status(intel_dp);
+		if (ret) {
+			intel_dp->is_mst = false;
+			drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr,
+							false);
+		}
 	}
 }
-- 
2.20.1

