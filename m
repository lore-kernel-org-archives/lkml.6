Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48D6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E115208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E115208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405702AbeHATIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405665AbeHATId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:33 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC53D1096;
        Wed,  1 Aug 2018 17:02:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shirish S <shirish.s@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 179/336] drm/amd/display: remove need of modeset flag for overlay planes (V2)
Date:   Wed,  1 Aug 2018 18:48:34 +0200
Message-Id: <20180801165035.946243722@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shirish S <shirish.s@amd.com>

[ Upstream commit a2a330ad66313084c9432b32862aa7e1255da9b4 ]

This patch is in continuation to the
"843e3c7 drm/amd/display: defer modeset check in dm_update_planes_state"
where we started to eliminate the dependency on
DRM_MODE_ATOMIC_ALLOW_MODESET to be set by the user space,
which as such is not mandatory.

After deferring, this patch eliminates the dependency on the flag
for overlay planes.

This has to be done in stages as its a pretty complex and requires thorough
testing before we free primary planes as well from dependency on modeset
flag.

V2: Simplified the plane type check.

Signed-off-by: Shirish S <shirish.s@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4037,7 +4037,7 @@ static void amdgpu_dm_commit_planes(stru
 		}
 		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
 
-		if (!pflip_needed) {
+		if (!pflip_needed || plane->type == DRM_PLANE_TYPE_OVERLAY) {
 			WARN_ON(!dm_new_plane_state->dc_state);
 
 			plane_states_constructed[planes_count] = dm_new_plane_state->dc_state;
@@ -4783,7 +4783,8 @@ static int dm_update_planes_state(struct
 
 		/* Remove any changed/removed planes */
 		if (!enable) {
-			if (pflip_needed)
+			if (pflip_needed &&
+			    plane->type != DRM_PLANE_TYPE_OVERLAY)
 				continue;
 
 			if (!old_plane_crtc)
@@ -4830,7 +4831,8 @@ static int dm_update_planes_state(struct
 			if (!dm_new_crtc_state->stream)
 				continue;
 
-			if (pflip_needed)
+			if (pflip_needed &&
+			    plane->type != DRM_PLANE_TYPE_OVERLAY)
 				continue;
 
 			WARN_ON(dm_new_plane_state->dc_state);


