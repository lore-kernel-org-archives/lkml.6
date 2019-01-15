Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91445C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F4420859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfAOFWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:22:11 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.80]:46610 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbfAOFWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:22:10 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C361BA7332
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 23:22:09 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id jHAvghR3zdnCejHAvgmBHp; Mon, 14 Jan 2019 23:22:09 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=39054 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gjHAu-000ESg-7L; Mon, 14 Jan 2019 23:22:08 -0600
Date:   Mon, 14 Jan 2019 23:22:02 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdgpu: Replace kzalloc with kcalloc
Message-ID: <20190115052202.GA8537@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gjHAu-000ESg-7L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:39054
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kzalloc() function with its 2-factor argument form, kcalloc().

This patch replaces cases of:

	kzalloc(a * b, gfp)

with:
	kcalloc(a, b, gfp)

Also, improve the coding style and the use of sizeof during
allocation by changing sizeof(struct dc_surface_update) and
sizeof(struct dc_plane_state) to sizeof(*updates) and
sizeof(*surfaces), correspondingly.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a3e65e457348..4c201de38329 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5782,11 +5782,14 @@ dm_determine_update_type_for_commit(struct dc *dc,
 	struct dm_crtc_state *new_dm_crtc_state, *old_dm_crtc_state;
 	struct dc_stream_status *status = NULL;
 
-	struct dc_surface_update *updates = kzalloc(MAX_SURFACES * sizeof(struct dc_surface_update), GFP_KERNEL);
-	struct dc_plane_state *surface = kzalloc(MAX_SURFACES * sizeof(struct dc_plane_state), GFP_KERNEL);
+	struct dc_surface_update *updates;
+	struct dc_plane_state *surface;
 	struct dc_stream_update stream_update;
 	enum surface_update_type update_type = UPDATE_TYPE_FAST;
 
+	updates = kcalloc(MAX_SURFACES, sizeof(*updates), GFP_KERNEL);
+	surface = kcalloc(MAX_SURFACES, sizeof(*surface), GFP_KERNEL);
+
 	if (!updates || !surface) {
 		DRM_ERROR("Plane or surface update failed to allocate");
 		/* Set type to FULL to avoid crashing in DC*/
-- 
2.20.1

