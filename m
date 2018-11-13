Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D64B22360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D64B22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeKNIr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:47:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbeKNIr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:47:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AF1285546;
        Tue, 13 Nov 2018 22:47:07 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73E2E1001F59;
        Tue, 13 Nov 2018 22:47:01 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Jerry Zuo <Jerry.Zuo@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp_mst: Skip validating ports during destruction, just ref
Date:   Tue, 13 Nov 2018 17:46:14 -0500
Message-Id: <20181113224613.28809-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 13 Nov 2018 22:47:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerry Zuo pointed out a rather obscure hotplugging issue that it seems I
accidentally introduced into DRM two years ago.

Pretend we have a topology like this:

|- DP-1: mst_primary
   |- DP-4: active display
   |- DP-5: disconnected
   |- DP-6: active hub
      |- DP-7: active display
      |- DP-8: disconnected
      |- DP-9: disconnected

If we unplug DP-6, the topology starting at DP-7 will be destroyed but
it's payloads will live on in DP-1's VCPI allocations and thus require
removal. However, this removal currently fails because
drm_dp_update_payload_part1() will (rightly so) try to validate the port
before accessing it, fail then abort. If we keep going, eventually we
run the MST hub out of bandwidth and all new allocations will start to
fail (or in my case; all new displays just start flickering a ton).

We could just teach drm_dp_update_payload_part1() not to drop the port
ref in this case, but then we also need to teach
drm_dp_destroy_payload_step1() to do the same thing, then hope no one
ever adds anything to the that requires a validated port reference in
drm_dp_destroy_connector_work(). Kind of sketchy.

So let's go with a more clever solution: any port that
drm_dp_destroy_connector_work() interacts with is guaranteed to still
exist in memory until we say so. While said port might not be valid we
don't really care: that's the whole reason we're destroying it in the
first place! So, teach drm_dp_get_validated_port_ref() to use the all
mighty current_work() function to avoid attempting to validate ports
from the context of mgr->destroy_connector_work. I can't see any
situation where this wouldn't be safe, and this avoids having to play
whack-a-mole in the future of trying to work around port validation.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 263efde31f97 ("drm/dp/mst: Get validated port ref in drm_dp_update_payload_part1()")
Reported-by: Jerry Zuo <Jerry.Zuo@amd.com>
Cc: Jerry Zuo <Jerry.Zuo@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: <stable@vger.kernel.org> # v4.6+
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 529414556962..08978ad72f33 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1023,9 +1023,20 @@ static struct drm_dp_mst_port *drm_dp_mst_get_port_ref_locked(struct drm_dp_mst_
 static struct drm_dp_mst_port *drm_dp_get_validated_port_ref(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port)
 {
 	struct drm_dp_mst_port *rport = NULL;
+
 	mutex_lock(&mgr->lock);
-	if (mgr->mst_primary)
-		rport = drm_dp_mst_get_port_ref_locked(mgr->mst_primary, port);
+	/*
+	 * Port may or may not be 'valid' but we don't care about that when
+	 * destroying the port and we are guaranteed that the port pointer
+	 * will be valid until we've finished
+	 */
+	if (current_work() == &mgr->destroy_connector_work) {
+		kref_get(&port->kref);
+		rport = port;
+	} else if (mgr->mst_primary) {
+		rport = drm_dp_mst_get_port_ref_locked(mgr->mst_primary,
+						       port);
+	}
 	mutex_unlock(&mgr->lock);
 	return rport;
 }
-- 
2.19.1

