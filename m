Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FA2C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B234206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbfAPUiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:38:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732772AbfAPUiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:38:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 138FE80F7D;
        Wed, 16 Jan 2019 20:38:13 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19C545D967;
        Wed, 16 Jan 2019 20:38:12 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/dp_mst: Fix topology ref leak in drm_dp_mst_allocate_vcpi()
Date:   Wed, 16 Jan 2019 15:37:59 -0500
Message-Id: <20190116203759.31820-4-lyude@redhat.com>
In-Reply-To: <20190116203759.31820-1-lyude@redhat.com>
References: <20190116203759.31820-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 16 Jan 2019 20:38:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another drive-by fix. If slots < 0, or drm_dp_init_vcpi() fails, we'll
end up returning from the function without dropping the topology ref
that we grabbed at the very start. This would result in an MST hub
and/or it's ports staying around even after the MST topology has been
removed from the system.

So, fix this by making sure that we always drop the topology ref to port
when returning from this function.

Additionally: it looks like this bug exists pre-topology & malloc krefs,
so let's also make sure this gets backported to stable.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0.6)")
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: <stable@vger.kernel.org> # v3.17+
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index d99560c5c693..403f035dc8b8 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3177,28 +3177,29 @@ EXPORT_SYMBOL(drm_dp_atomic_release_vcpi_slots);
 bool drm_dp_mst_allocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 			      struct drm_dp_mst_port *port, int pbn, int slots)
 {
-	int ret;
+	int rc;
+	bool ret = false;
 
-	port = drm_dp_mst_topology_get_port_validated(mgr, port);
-	if (!port)
+	if (slots < 0)
 		return false;
 
-	if (slots < 0)
+	port = drm_dp_mst_topology_get_port_validated(mgr, port);
+	if (!port)
 		return false;
 
 	if (port->vcpi.vcpi > 0) {
 		DRM_DEBUG_KMS("payload: vcpi %d already allocated for pbn %d - requested pbn %d\n",
 			      port->vcpi.vcpi, port->vcpi.pbn, pbn);
 		if (pbn == port->vcpi.pbn) {
-			drm_dp_mst_topology_put_port(port);
-			return true;
+			ret = true;
+			goto out;
 		}
 	}
 
-	ret = drm_dp_init_vcpi(mgr, &port->vcpi, pbn, slots);
-	if (ret) {
+	rc = drm_dp_init_vcpi(mgr, &port->vcpi, pbn, slots);
+	if (rc) {
 		DRM_DEBUG_KMS("failed to init vcpi slots=%d max=63 ret=%d\n",
-			      DIV_ROUND_UP(pbn, mgr->pbn_div), ret);
+			      DIV_ROUND_UP(pbn, mgr->pbn_div), rc);
 		goto out;
 	}
 	DRM_DEBUG_KMS("initing vcpi for pbn=%d slots=%d\n",
@@ -3206,10 +3207,10 @@ bool drm_dp_mst_allocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 
 	/* Keep port allocated until it's payload has been removed */
 	drm_dp_mst_get_port_malloc(port);
-	drm_dp_mst_topology_put_port(port);
-	return true;
+	ret = true;
 out:
-	return false;
+	drm_dp_mst_topology_put_port(port);
+	return ret;
 }
 EXPORT_SYMBOL(drm_dp_mst_allocate_vcpi);
 
-- 
2.20.1

