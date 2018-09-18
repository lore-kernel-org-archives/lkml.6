Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A73ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B1620C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B1620C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbeISEmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:42:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54783 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbeISEmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:42:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A225630A5681;
        Tue, 18 Sep 2018 23:07:27 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-125-172.rdu2.redhat.com [10.10.125.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC30C7D676;
        Tue, 18 Sep 2018 23:07:20 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Roman Li <Roman.Li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
        Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] drm/amdgpu/dm/mst: Use drm_dp_mst_connector_atomic_check()
Date:   Tue, 18 Sep 2018 19:06:22 -0400
Message-Id: <20180918230637.20700-7-lyude@redhat.com>
In-Reply-To: <20180918230637.20700-1-lyude@redhat.com>
References: <20180918230637.20700-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 18 Sep 2018 23:07:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook this into amdgpu's atomic check for their connectors so they never
get modesets on no-longer-present MST connectors. We'll also expand on
this later once we add DP MST fallback retraining support.

As well, turns out that the only atomic DRM driver without the
->best_encoder() bug is amdgpu. Congrats AMD!

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 9a300732ba37..d011a39f17b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -294,10 +294,22 @@ static struct drm_encoder *dm_mst_best_encoder(struct drm_connector *connector)
 	return &amdgpu_dm_connector->mst_encoder->base;
 }
 
+static int
+amdgpu_dm_mst_connector_atomic_check(struct drm_connector *connector,
+				     struct drm_connector_state *new_cstate)
+{
+	struct amdgpu_dm_connector *aconnector =
+		to_amdgpu_dm_connector(connector);
+
+	return drm_dp_mst_connector_atomic_check(connector, new_cstate,
+						 &aconnector->mst_mgr);
+}
+
 static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_funcs = {
 	.get_modes = dm_dp_mst_get_modes,
 	.mode_valid = amdgpu_dm_connector_mode_valid,
 	.best_encoder = dm_mst_best_encoder,
+	.atomic_check = amdgpu_dm_mst_connector_atomic_check,
 };
 
 static void amdgpu_dm_encoder_destroy(struct drm_encoder *encoder)
-- 
2.17.1

