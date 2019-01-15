Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796FBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4437C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570849;
	bh=5ritQIkldwqUkK1z2ZXq/ilZ3qQC0h1gjJkpBXL8dH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BmbO2o0+A/D2UqnDR5OlvUSwaw84uRV+m/qkwVkmYQCRQNfiYoZi3//5mATWSz71U
	 HNEnyJ/V/6aIgQTCLC7sejqZlUJVUV2d5lqaBw3HIBdKJ6MRtABBZ+P8C5uy4fjUJl
	 grVEUm1HoygNcGMPvGO58oJG6QYC9QVGyTdz6Iw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbfAOQpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbfAOQpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:45:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E1020645;
        Tue, 15 Jan 2019 16:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570712;
        bh=5ritQIkldwqUkK1z2ZXq/ilZ3qQC0h1gjJkpBXL8dH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlaUeztdpXf+nEA+GI9Ag3eq63HWrvfmOd4q7HfZjM74lPeBim2ddN8mMgajxoIog
         o7RvBZK0fi2SykjkKfPmLQEKadYKzXpo7rW8xC7Cib86ZXWq0gj/vpaEvYkGICbJq4
         oMHYPm1+ZmRhi/gU/iFlLiset+maq7qQyg1zPRfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 4.20 44/57] drm/amdgpu: Dont ignore rc from drm_dp_mst_topology_mgr_resume()
Date:   Tue, 15 Jan 2019 17:36:25 +0100
Message-Id: <20190115154913.416329594@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit fe7553bef8d676d1d8b40666868b33ec39b9df5d upstream.

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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Cc: Jerry Zuo <Jerry.Zuo@amd.com>
Cc: <stable@vger.kernel.org> # v4.15+
Link: https://patchwork.freedesktop.org/patch/msgid/20190108211133.32564-2-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   34 +++++++++++++++-------
 1 file changed, 24 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -645,22 +645,36 @@ static void s3_handle_mst(struct drm_dev
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
-
-			   if (suspend)
-				   drm_dp_mst_topology_mgr_suspend(&aconnector->mst_mgr);
-			   else
-				   drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr);
-		   }
+	list_for_each_entry(connector, &dev->mode_config.connector_list,
+			    head) {
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (aconnector->dc_link->type != dc_connection_mst_branch ||
+		    aconnector->mst_port)
+			continue;
+
+		mgr = &aconnector->mst_mgr;
+
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
 
 static int dm_hw_init(void *handle)


