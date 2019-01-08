Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4765EC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E76920660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfAHA57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:57:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbfAHA55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:57:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71827C05D3FF;
        Tue,  8 Jan 2019 00:57:57 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 462BC65F76;
        Tue,  8 Jan 2019 00:57:56 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Jerry Zuo <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/dp_mst: Add __must_check to drm_dp_mst_topology_mgr_resume()
Date:   Mon,  7 Jan 2019 19:56:47 -0500
Message-Id: <20190108005651.25967-4-lyude@redhat.com>
In-Reply-To: <20190108005651.25967-1-lyude@redhat.com>
References: <20190108005651.25967-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 08 Jan 2019 00:57:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I've had to fix two cases of drivers not checking the return code
from this function, let's make the compiler complain so this doesn't
come up again in the future.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jerry Zuo <Jerry.Zuo@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 3 ++-
 include/drm/drm_dp_mst_helper.h       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 2ab16c9e6243..13a7e497bfe2 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2226,7 +2226,8 @@ EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
  * if the device fails this returns -1, and the driver should do
  * a full MST reprobe, in case we were undocked.
  */
-int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
+int __must_check
+drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
 {
 	int ret = 0;
 
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 371cc2816477..4355b55d0081 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -614,7 +614,8 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 			      struct drm_dp_mst_topology_mgr *mgr);
 
 void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
-int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
+int __must_check
+drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
 struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
 								    struct drm_dp_mst_topology_mgr *mgr);
 int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
-- 
2.20.1

