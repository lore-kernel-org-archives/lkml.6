Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85581C65BA7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568A52098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568A52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeJEGaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:30:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeJEGaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:30:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9846308421D;
        Thu,  4 Oct 2018 23:34:13 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A98D67C7E;
        Thu,  4 Oct 2018 23:34:12 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] drm/i915: Skip vcpi allocation for MSTB ports that are gone
Date:   Thu,  4 Oct 2018 19:33:49 -0400
Message-Id: <20181004233353.5388-5-lyude@redhat.com>
In-Reply-To: <20181004233353.5388-1-lyude@redhat.com>
References: <20181004233353.5388-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 04 Oct 2018 23:34:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we need to be able to allow DPMS on->off prop changes after an MST
port has disappeared from the system, we need to be able to make sure we
can compute a config for the resulting atomic commit. Currently this is
impossible when the port has disappeared, since the VCPI slot searching
we try to do in intel_dp_mst_compute_config() will fail with -EINVAL.

Since the only commits we want to allow on no-longer-present MST ports
are ones that shut off display hardware, we already know that no VCPI
allocations are needed. So, hardcode the VCPI slot count to 0 when
intel_dp_mst_compute_config() is called on an MST port that's gone.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/i915/intel_dp_mst.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index fcb9b87b9339..a366f32b048a 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -42,7 +42,7 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 		to_intel_connector(conn_state->connector);
 	struct drm_atomic_state *state = pipe_config->base.state;
 	int bpp;
-	int lane_count, slots;
+	int lane_count, slots = 0;
 	const struct drm_display_mode *adjusted_mode = &pipe_config->base.adjusted_mode;
 	int mst_pbn;
 	bool reduce_m_n = drm_dp_has_quirk(&intel_dp->desc,
@@ -76,11 +76,16 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 	mst_pbn = drm_dp_calc_pbn_mode(adjusted_mode->crtc_clock, bpp);
 	pipe_config->pbn = mst_pbn;
 
-	slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp->mst_mgr,
-					      connector->port, mst_pbn);
-	if (slots < 0) {
-		DRM_DEBUG_KMS("failed finding vcpi slots:%d\n", slots);
-		return false;
+	if (!connector->mst_port_gone) {
+		slots = drm_dp_atomic_find_vcpi_slots(state,
+						      &intel_dp->mst_mgr,
+						      connector->port,
+						      mst_pbn);
+		if (slots < 0) {
+			DRM_DEBUG_KMS("failed finding vcpi slots:%d\n",
+				      slots);
+			return false;
+		}
 	}
 
 	intel_link_compute_m_n(bpp, lane_count,
-- 
2.17.1

