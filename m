Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A61C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FDE2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FDE2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbeLNB1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:27:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbeLNB1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:27:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D259307D922;
        Fri, 14 Dec 2018 01:27:00 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45A6B6012B;
        Fri, 14 Dec 2018 01:26:53 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: [WIP PATCH 09/15] drm/nouveau: Fix potential use-after-frees for MSTCs
Date:   Thu, 13 Dec 2018 20:25:38 -0500
Message-Id: <20181214012604.13746-10-lyude@redhat.com>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 14 Dec 2018 01:27:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we finally have a sane way to keep port allocations around, use
it to fix the potential unchecked ->port accesses that nouveau makes by
making sure we keep the mst port allocated for as long as it's
drm_connector is accessible.

Additionally, now that we've guaranteed that mstc->port is allocated for
as long as we keep mstc around we can remove the connector registration
checks for codepaths which release payloads, allowing us to release
payloads on active topologies properly. These registration checks were
only required before in order to avoid situations where mstc->port could
technically be pointing at freed memory.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 0f7d72518604..982054bbcc8b 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -964,7 +964,11 @@ static void
 nv50_mstc_destroy(struct drm_connector *connector)
 {
 	struct nv50_mstc *mstc = nv50_mstc(connector);
+
 	drm_connector_cleanup(&mstc->connector);
+	if (mstc->port)
+		drm_dp_mst_put_port_malloc(mstc->port);
+
 	kfree(mstc);
 }
 
@@ -1012,6 +1016,7 @@ nv50_mstc_new(struct nv50_mstm *mstm, struct drm_dp_mst_port *port,
 	drm_object_attach_property(&mstc->connector.base, dev->mode_config.path_property, 0);
 	drm_object_attach_property(&mstc->connector.base, dev->mode_config.tile_property, 0);
 	drm_connector_set_path_property(&mstc->connector, path);
+	drm_dp_mst_get_port_malloc(port);
 	return 0;
 }
 
@@ -1077,6 +1082,7 @@ nv50_mstm_destroy_connector(struct drm_dp_mst_topology_mgr *mgr,
 	drm_fb_helper_remove_one_connector(&drm->fbcon->helper, &mstc->connector);
 
 	drm_modeset_lock(&drm->dev->mode_config.connection_mutex, NULL);
+	drm_dp_mst_put_port_malloc(mstc->port);
 	mstc->port = NULL;
 	drm_modeset_unlock(&drm->dev->mode_config.connection_mutex);
 
-- 
2.19.2

