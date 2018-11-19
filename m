Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F16C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3C620831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5Tij4m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3C620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbeKTCza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:55:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbeKTCz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:55:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B59420870;
        Mon, 19 Nov 2018 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645080;
        bh=kRG5q7Q/VsvgKaw5CD1ieG4RZQL9QiOrwpdDHOWB3UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5Tij4m+d4Xyfh4zc1yfny/LpoP9bOUm+M0kd3JlbFqMVWMfa/r9lE9+wKkdiGHPh
         k3TFuIdoxovpO+O8Zf//4a66KY1bb546Kz+DpcIrNE0k97rlkjRMc4FcHcDyxLVtvR
         pmJtAcoSg8g4Uluo8hO5bPRs7oFO83pWUExHjV28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        SivapiriyanKumarasamy <sivapiriyan.kumarasamy@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/205] drm/amd/display: fix gamma not being applied
Date:   Mon, 19 Nov 2018 17:25:28 +0100
Message-Id: <20181119162621.147281610@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1120,9 +1120,6 @@ static enum surface_update_type get_plan
 		 */
 		update_flags->bits.bpp_change = 1;
 
-	if (u->gamma && dce_use_lut(u->plane_info->format))
-		update_flags->bits.gamma_change = 1;
-
 	if (memcmp(&u->plane_info->tiling_info, &u->surface->tiling_info,
 			sizeof(union dc_tiling_info)) != 0) {
 		update_flags->bits.swizzle_change = 1;
@@ -1139,7 +1136,6 @@ static enum surface_update_type get_plan
 	if (update_flags->bits.rotation_change
 			|| update_flags->bits.stereo_format_change
 			|| update_flags->bits.pixel_format_change
-			|| update_flags->bits.gamma_change
 			|| update_flags->bits.bpp_change
 			|| update_flags->bits.bandwidth_change
 			|| update_flags->bits.output_tf_change)
@@ -1229,13 +1225,26 @@ static enum surface_update_type det_surf
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


