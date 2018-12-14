Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA824C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25DD208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25DD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeLNB1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:27:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729657AbeLNB1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:27:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D52A1308403A;
        Fri, 14 Dec 2018 01:27:12 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59CCB6012B;
        Fri, 14 Dec 2018 01:27:11 +0000 (UTC)
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
Subject: [WIP PATCH 14/15] drm/dp_mst: Check payload count in drm_dp_mst_atomic_check()
Date:   Thu, 13 Dec 2018 20:25:43 -0500
Message-Id: <20181214012604.13746-15-lyude@redhat.com>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 14 Dec 2018 01:27:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It occurred to me that we never actually check this! So let's start
doing that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index b9374c981a5b..ebffb834f5d6 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3538,7 +3538,7 @@ drm_dp_mst_atomic_check_topology_state(struct drm_dp_mst_topology_mgr *mgr,
 				       struct drm_dp_mst_topology_state *mst_state)
 {
 	struct drm_dp_vcpi_allocation *vcpi;
-	int avail_slots = 63, ret;
+	int avail_slots = 63, payload_count = 0, ret;
 
 	/* There's no possible scenario where releasing VCPI or keeping it the
 	 * same would make the state invalid
@@ -3575,6 +3575,13 @@ drm_dp_mst_atomic_check_topology_state(struct drm_dp_mst_topology_mgr *mgr,
 			goto port_fail;
 		}
 
+		if (++payload_count > mgr->max_payloads) {
+			DRM_DEBUG_ATOMIC("[MST MGR:%p] state %p has too many payloads (max=%d)\n",
+					 mgr, mst_state, mgr->max_payloads);
+			ret = -EINVAL;
+			goto port_fail;
+		}
+
 		drm_dp_mst_topology_put_port(vcpi->port);
 	}
 	DRM_DEBUG_ATOMIC("[MST MGR:%p] mst state %p VCPI avail=%d used=%d\n",
-- 
2.19.2

