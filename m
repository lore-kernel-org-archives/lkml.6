Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA043ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AD92081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQfc5WpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AD92081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbeKDXX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbeKDXHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB62204FD;
        Sun,  4 Nov 2018 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339521;
        bh=AEDSYy3NaRj3eEFvSJYPYreYpGMTtQyynlBcwpMluIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQfc5WpEOsZdmztedDf/y93p8DAhBu4Lb5o3qFDnImQ9Wr4h+T54nn10uvE1s/6Om
         NSmD67aZ3fzsSmKXMCa+pnK5zuNiGFZ+dz62lgnchLgcH6oY9MzIfTjiJ199H1yATg
         cMyVpM4GUkcUbmVqOQl7LG+95fsXLjPd/THpAkLA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Su Sung Chung <Su.Chung@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 14/57] drm/amd/display: fix bug of accessing invalid memory
Date:   Sun,  4 Nov 2018 08:51:01 -0500
Message-Id: <20181104135144.88324-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Sung Chung <Su.Chung@amd.com>

[ Upstream commit 43c3ff27a47d83d153c4adc088243ba594582bf5 ]

[Why]
A loop inside of build_evenly_distributed_points function that traverse through
the array of points become an infinite loop when m_GammaUpdates does not
get assigned to any value.

[How]
In DMColor, clear m_gammaIsValid bit just before writting all Zeromem for
m_GammaUpdates, to prevent calling build_evenly_distributed_points
before m_GammaUpdates gets assigned to some value.

Signed-off-by: Su Sung Chung <Su.Chung@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index bf29733958c3..962900932bee 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1069,10 +1069,14 @@ static void build_evenly_distributed_points(
 	struct dividers dividers)
 {
 	struct gamma_pixel *p = points;
-	struct gamma_pixel *p_last = p + numberof_points - 1;
+	struct gamma_pixel *p_last;
 
 	uint32_t i = 0;
 
+	// This function should not gets called with 0 as a parameter
+	ASSERT(numberof_points > 0);
+	p_last = p + numberof_points - 1;
+
 	do {
 		struct fixed31_32 value = dc_fixpt_from_fraction(i,
 			numberof_points - 1);
@@ -1083,7 +1087,7 @@ static void build_evenly_distributed_points(
 
 		++p;
 		++i;
-	} while (i != numberof_points);
+	} while (i < numberof_points);
 
 	p->r = dc_fixpt_div(p_last->r, dividers.divider1);
 	p->g = dc_fixpt_div(p_last->g, dividers.divider1);
-- 
2.17.1

