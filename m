Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A00DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E98222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196651;
	bh=80UibNHn3+S3eohnIQUujkkcClnzYCmjQXC9fG/y2LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DSJ5XCiAjA2397YZNsgyauxzBXdb0qWSIiUtKQn7aY3zrBO6PGBfavi+PPoZi7yx5
	 UHmUbObupyePmOqVjdVMCofYe05iA8bPsD2Tp5qGGMRgTkGqcRI7IzE9Lwp9Ht57/x
	 Abvak2Pr7LhSA55k+ewBAvN5p6OhjSH8IbXXfx9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfBOCKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731885AbfBOCKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E27421B68;
        Fri, 15 Feb 2019 02:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196644;
        bh=80UibNHn3+S3eohnIQUujkkcClnzYCmjQXC9fG/y2LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xx3+Z2/vy2KqVctbHvXoeFUwllzPCZMwm6SGXJLJSMyhaFxhYCemCx6A2bb08ZhfS
         8xlQT5Txx4dDRbx7nDcv25N7ux6rNA8/LlGF6/JO3kTVLGSIR8cWNFh5eQ6O0qbVU+
         hn9lDdvVBDOtU+ubFsl07x0Bb8LmfIQoYN2SeFpg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 63/77] drm/msm: Fix A6XX support for opp-level
Date:   Thu, 14 Feb 2019 21:08:41 -0500
Message-Id: <20190215020855.176727-63-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit a3c5e2cd79753121f49a8662c1e0a60ddb5486ca ]

The bindings for Qualcomm opp levels changed after being Acked but
before landing.  Thus the code in the GPU driver that was relying on
the old bindings is now broken.

Let's change the code to match the new bindings by adjusting the old
string 'qcom,level' to the new string 'opp-level'.  See the patch
("dt-bindings: opp: Introduce opp-level bindings").

NOTE: we will do additional cleanup to totally remove the string from
the code and use the new dev_pm_opp_get_level() but we'll do it in a
future patch.  This will facilitate getting the important code fix in
sooner without having to deal with cross-maintainer dependencies.

This patch needs to land before the patch ("arm64: dts: sdm845: Add
gpu and gmu device nodes") since if a tree contains the device tree
patch but not this one you'll get a crash at bootup.

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index d4e98e5876bc..00b2e6e94689 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -939,7 +939,7 @@ static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
 	np = dev_pm_opp_get_of_node(opp);
 
 	if (np) {
-		of_property_read_u32(np, "qcom,level", &val);
+		of_property_read_u32(np, "opp-level", &val);
 		of_node_put(np);
 	}
 
-- 
2.19.1

