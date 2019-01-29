Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F1020880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfA2TK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:10:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbfA2TK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:10:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23B247FDE3;
        Tue, 29 Jan 2019 19:10:25 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 071C71715E;
        Tue, 29 Jan 2019 19:10:23 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] drm/i915: Don't send hotplug in intel_dp_check_mst_status()
Date:   Tue, 29 Jan 2019 14:10:01 -0500
Message-Id: <20190129191001.442-4-lyude@redhat.com>
In-Reply-To: <20190129191001.442-1-lyude@redhat.com>
References: <20190129191001.442-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 29 Jan 2019 19:10:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This hotplug also isn't needed: drm_dp_mst_topology_mgr_set_mst()
already sends a hotplug on its own from drm_dp_destroy_connector_work()
after destroying connectors in the MST topology.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/i915/intel_dp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index c2399acf177b..f9113c0cdfcd 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -4608,12 +4608,10 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
 
 			return ret;
 		} else {
-			struct intel_digital_port *intel_dig_port = dp_to_dig_port(intel_dp);
 			DRM_DEBUG_KMS("failed to get ESI - device may have failed\n");
 			intel_dp->is_mst = false;
-			drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr, intel_dp->is_mst);
-			/* send a hotplug event */
-			drm_kms_helper_hotplug_event(intel_dig_port->base.base.dev);
+			drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr,
+							intel_dp->is_mst);
 		}
 	}
 	return -EINVAL;
-- 
2.20.1

