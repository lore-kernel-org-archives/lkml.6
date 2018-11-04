Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F253EECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7690204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKulzHhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7690204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeKDXVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730261AbeKDXHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFD42086C;
        Sun,  4 Nov 2018 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339538;
        bh=c9cVPQRRFslEX79ZXWU590g0w+BcNTU3J/dDUhaiRKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKulzHhpW+YnUspEnXp62U0zuHhG38QV+7eOlfFHlClmhRLgpkwgySk7SFk0B+RkE
         RYJP/l+Sz6Q5j8yvkDeLlgh2ZBijYwL7ITtXAcxDgwunfwPrAZUoRQmx/ZpN/9U+WR
         RlE/7r+vcjYnFXxDU8X8OtrZfD6IsVuH1WFrZJNc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     SivapiriyanKumarasamy <sivapiriyan.kumarasamy@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 33/57] drm/amd/display: fix gamma not being applied
Date:   Sun,  4 Nov 2018 08:51:20 -0500
Message-Id: <20181104135144.88324-33-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SivapiriyanKumarasamy <sivapiriyan.kumarasamy@amd.com>

[ Upstream commit 30049754ab7c4b6148dd3cd64af7d54850604582 ]

[WHY]
Previously night light forced a full update by
applying a  transfer function update regardless of if it was changed.
This logic was removed,

Now gamma surface updates are only applied when there is also a plane
info update, this does not work in cases such as using the night light
slider.

[HOW]
When moving the night light slider we will perform a full update if
the gamma has changed and there is a surface, even when the surface
has not changed. Also get stream updates in setgamma prior to
update planes and stream.

Signed-off-by: SivapiriyanKumarasamy <sivapiriyan.kumarasamy@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6ae050dc3220..9045e6fa0780 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1120,9 +1120,6 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 		 */
 		update_flags->bits.bpp_change = 1;
 
-	if (u->gamma && dce_use_lut(u->plane_info->format))
-		update_flags->bits.gamma_change = 1;
-
 	if (memcmp(&u->plane_info->tiling_info, &u->surface->tiling_info,
 			sizeof(union dc_tiling_info)) != 0) {
 		update_flags->bits.swizzle_change = 1;
@@ -1139,7 +1136,6 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 	if (update_flags->bits.rotation_change
 			|| update_flags->bits.stereo_format_change
 			|| update_flags->bits.pixel_format_change
-			|| update_flags->bits.gamma_change
 			|| update_flags->bits.bpp_change
 			|| update_flags->bits.bandwidth_change
 			|| update_flags->bits.output_tf_change)
@@ -1229,13 +1225,26 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	if (u->coeff_reduction_factor)
 		update_flags->bits.coeff_reduction_change = 1;
 
+	if (u->gamma) {
+		enum surface_pixel_format format = SURFACE_PIXEL_FORMAT_GRPH_BEGIN;
+
+		if (u->plane_info)
+			format = u->plane_info->format;
+		else if (u->surface)
+			format = u->surface->format;
+
+		if (dce_use_lut(format))
+			update_flags->bits.gamma_change = 1;
+	}
+
 	if (update_flags->bits.in_transfer_func_change) {
 		type = UPDATE_TYPE_MED;
 		elevate_update_type(&overall_type, type);
 	}
 
 	if (update_flags->bits.input_csc_change
-			|| update_flags->bits.coeff_reduction_change) {
+			|| update_flags->bits.coeff_reduction_change
+			|| update_flags->bits.gamma_change) {
 		type = UPDATE_TYPE_FULL;
 		elevate_update_type(&overall_type, type);
 	}
-- 
2.17.1

