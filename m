Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E30BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBE621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfA1U4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:56:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52179 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbfA1U4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:56:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D73AC0BFBA1;
        Mon, 28 Jan 2019 20:56:19 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EDEE747D4;
        Mon, 28 Jan 2019 20:56:18 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Imre Deak <imre.deak@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/i915: Don't send MST hotplugs during resume
Date:   Mon, 28 Jan 2019 15:56:02 -0500
Message-Id: <20190128205603.16372-3-lyude@redhat.com>
In-Reply-To: <20190128205603.16372-1-lyude@redhat.com>
References: <20190128205603.16372-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 28 Jan 2019 20:56:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a bad habit of calling drm_fb_helper_hotplug_event() far more
then we actually need to. MST appears to be one of these cases, where we
call drm_fb_helper_hotplug_event() if we fail to resume a connected MST
topology in intel_dp_mst_resume(). We don't actually need to do this at
all though since hotplug events are already sent from
drm_dp_connector_destroy_work() every time connectors are unregistered
from userspace's PoV. Additionally, extra calls to
drm_fb_helper_hotplug_event() also just mean more of a chance of doing a
connector probe somewhere we shouldn't.

So, don't send any hotplug events during resume if the MST topology
fails to come up. Just rely on the DP MST helpers to send them for us.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
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

