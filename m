Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4609EC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0FB20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfAHA5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:57:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbfAHA5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:57:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15550C05FF9D;
        Tue,  8 Jan 2019 00:57:51 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A44160E3F;
        Tue,  8 Jan 2019 00:57:49 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Jerry Zuo <Jerry.Zuo@amd.com>, stable@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tony Cheng <Tony.Cheng@amd.com>,
        David Francis <David.Francis@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Shirish S <shirish.s@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/amdgpu: Don't ignore rc from drm_dp_mst_topology_mgr_resume()
Date:   Mon,  7 Jan 2019 19:56:45 -0500
Message-Id: <20190108005651.25967-2-lyude@redhat.com>
In-Reply-To: <20190108005651.25967-1-lyude@redhat.com>
References: <20190108005651.25967-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 08 Jan 2019 00:57:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_dp_mst_topology_mgr_resume() returns whether or not it managed to
find the topology in question after a suspend resume cycle, and the
driver is supposed to check this value and disable MST accordingly if
it's gone-in addition to sending a hotplug in order to notify userspace
that something changed during suspend.

Currently, amdgpu just makes the mistake of ignoring the return code
from drm_dp_mst_topology_mgr_resume() which means that if a topology was
removed in suspend, amdgpu never notices and assumes it's still
connected which leads to all sorts of problems.

So, fix this by actually checking the rc from
drm_dp_mst_topology_mgr_resume(). Also, reformat the rest of the
function while we're at it to fix the over-indenting.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jerry Zuo <Jerry.Zuo@amd.com>
Cc: <stable@vger.kernel.org> # v4.15+
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8a626d16e8e3..3f326a2c513b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -699,22 +699,36 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
+	struct drm_dp_mst_topology_mgr *mgr;
+	int ret;
+	bool need_hotplug = false;
 
 	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-		   aconnector = to_amdgpu_dm_connector(connector);
-		   if (aconnector->dc_link->type == dc_connection_mst_branch &&
-				   !aconnector->mst_port) {
+	list_for_each_entry(connector, &dev->mode_config.connector_list,
+			    head) {
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (aconnector->dc_link->type != dc_connection_mst_branch ||
+		    aconnector->mst_port)
+			continue;
+
+		mgr = &aconnector->mst_mgr;
 
-			   if (suspend)
-				   drm_dp_mst_topology_mgr_suspend(&aconnector->mst_mgr);
-			   else
-				   drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr);
-		   }
+		if (suspend) {
+			drm_dp_mst_topology_mgr_suspend(mgr);
+		} else {
+			ret = drm_dp_mst_topology_mgr_resume(mgr);
+			if (ret < 0) {
+				drm_dp_mst_topology_mgr_set_mst(mgr, false);
+				need_hotplug = true;
+			}
+		}
 	}
 
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+
+	if (need_hotplug)
+		drm_kms_helper_hotplug_event(dev);
 }
 
 /**
-- 
2.20.1

