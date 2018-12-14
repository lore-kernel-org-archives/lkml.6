Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98ACC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1BD2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1BD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeLNB0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:26:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbeLNB0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:26:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E867330841DE;
        Fri, 14 Dec 2018 01:26:42 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A1C66012B;
        Fri, 14 Dec 2018 01:26:41 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [WIP PATCH 05/15] drm/dp_mst: Fix payload deallocation on hotplugs using malloc refs
Date:   Thu, 13 Dec 2018 20:25:34 -0500
Message-Id: <20181214012604.13746-6-lyude@redhat.com>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 14 Dec 2018 01:26:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, freeing payloads on remote MST hubs that just had ports
removed has almost never worked because we've been relying on port
validation in order to stop us from accessing ports that have already
been freed from memory, but ports which need their payloads released due
to being removed will never be a valid part of the topology after
they've been removed.

Since we've introduced malloc refs, we can replace all of the validation
logic in payload helpers which are used for deallocation with some
well-placed malloc krefs. This ensures that regardless of whether or not
the ports are still valid and in the topology, any port which has an
allocated payload will remain allocated in memory until it's payloads
have been removed - finally allowing us to actually release said
payloads correctly.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 54 +++++++++++++++------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index ae9d019af9f2..93f08bfd2ab3 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1989,10 +1989,6 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
 	u8 sinks[DRM_DP_MAX_SDP_STREAMS];
 	int i;
 
-	port = drm_dp_mst_topology_get_port_validated(mgr, port);
-	if (!port)
-		return -EINVAL;
-
 	port_num = port->port_num;
 	mstb = drm_dp_mst_topology_get_mstb_validated(mgr, port->parent);
 	if (!mstb) {
@@ -2000,10 +1996,8 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
 							       port->parent,
 							       &port_num);
 
-		if (!mstb) {
-			drm_dp_mst_topology_put_port(port);
+		if (!mstb)
 			return -EINVAL;
-		}
 	}
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
@@ -2032,7 +2026,6 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
 	kfree(txmsg);
 fail_put:
 	drm_dp_mst_topology_put_mstb(mstb);
-	drm_dp_mst_topology_put_port(port);
 	return ret;
 }
 
@@ -2137,15 +2130,16 @@ static int drm_dp_destroy_payload_step2(struct drm_dp_mst_topology_mgr *mgr,
  */
 int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
 {
-	int i, j;
-	int cur_slots = 1;
 	struct drm_dp_payload req_payload;
 	struct drm_dp_mst_port *port;
+	int i, j;
+	int cur_slots = 1;
 
 	mutex_lock(&mgr->payload_lock);
 	for (i = 0; i < mgr->max_payloads; i++) {
 		struct drm_dp_vcpi *vcpi = mgr->proposed_vcpis[i];
 		struct drm_dp_payload *payload = &mgr->payloads[i];
+		bool put_port = false;
 
 		/* solve the current payloads - compare to the hw ones
 		   - update the hw view */
@@ -2153,12 +2147,20 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
 		if (vcpi) {
 			port = container_of(vcpi, struct drm_dp_mst_port,
 					    vcpi);
-			port = drm_dp_mst_topology_get_port_validated(mgr,
-								      port);
-			if (!port) {
-				mutex_unlock(&mgr->payload_lock);
-				return -EINVAL;
+
+			/* Validated ports don't matter if we're releasing
+			 * VCPI
+			 */
+			if (vcpi->num_slots) {
+				port = drm_dp_mst_topology_get_port_validated(
+				    mgr, port);
+				if (!port) {
+					mutex_unlock(&mgr->payload_lock);
+					return -EINVAL;
+				}
+				put_port = true;
 			}
+
 			req_payload.num_slots = vcpi->num_slots;
 			req_payload.vcpi = vcpi->vcpi;
 		} else {
@@ -2190,7 +2192,7 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
 		}
 		cur_slots += req_payload.num_slots;
 
-		if (port)
+		if (put_port)
 			drm_dp_mst_topology_put_port(port);
 	}
 
@@ -3005,6 +3007,8 @@ bool drm_dp_mst_allocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 	DRM_DEBUG_KMS("initing vcpi for pbn=%d slots=%d\n",
 		      pbn, port->vcpi.num_slots);
 
+	/* Keep port allocated until it's payload has been removed */
+	drm_dp_mst_get_port_malloc(port);
 	drm_dp_mst_topology_put_port(port);
 	return true;
 out:
@@ -3034,11 +3038,12 @@ EXPORT_SYMBOL(drm_dp_mst_get_vcpi_slots);
  */
 void drm_dp_mst_reset_vcpi_slots(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port)
 {
-	port = drm_dp_mst_topology_get_port_validated(mgr, port);
-	if (!port)
-		return;
+	/*
+	 * A port with VCPI will remain allocated until it's VCPI is
+	 * released, no verified ref needed
+	 */
+
 	port->vcpi.num_slots = 0;
-	drm_dp_mst_topology_put_port(port);
 }
 EXPORT_SYMBOL(drm_dp_mst_reset_vcpi_slots);
 
@@ -3050,16 +3055,17 @@ EXPORT_SYMBOL(drm_dp_mst_reset_vcpi_slots);
 void drm_dp_mst_deallocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 				struct drm_dp_mst_port *port)
 {
-	port = drm_dp_mst_topology_get_port_validated(mgr, port);
-	if (!port)
-		return;
+	/*
+	 * A port with VCPI will remain allocated until it's VCPI is
+	 * released, no verified ref needed
+	 */
 
 	drm_dp_mst_put_payload_id(mgr, port->vcpi.vcpi);
 	port->vcpi.num_slots = 0;
 	port->vcpi.pbn = 0;
 	port->vcpi.aligned_pbn = 0;
 	port->vcpi.vcpi = 0;
-	drm_dp_mst_topology_put_port(port);
+	drm_dp_mst_put_port_malloc(port);
 }
 EXPORT_SYMBOL(drm_dp_mst_deallocate_vcpi);
 
-- 
2.19.2

