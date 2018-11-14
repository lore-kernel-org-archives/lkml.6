Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA40CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FA720868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="W2PSZmkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FA720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbeKOIch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:32:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42699 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388219AbeKOIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:32:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id m5so28795847qka.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=otHAAoJeXEc/P3G/AXr3bWGwZWsjr5VuAddyjFBEbz8=;
        b=W2PSZmkgLl+pPs0SdDeahlYMhhbo867cs819v+QI1hfxY9SoEqnEp8/HZBwOs5tKzb
         2EFqlrw98eJ03EdrIwxJJ0EaMpHsOWrNW9sTGyuvo1eG259wELmgjbIcMOguxmW7BzlW
         hHYzlLiSBY4G2q8IkjnPOQsXE19nYX6w/VTbAGjyPkAMv42GyXOH6IVCJ55EqRWkwY1O
         AXAP5WspptyRPdJ4qlNNbdI9RIAv0JElgkYA3srGWeyGtyOgxsnlb0Igk1J43YAgfBlT
         stqTDbFYOnydQgPxzPvbXpcEegVipDzvWgPJfpKglV8XpvvXCVi7eM3Fp2HQD6/RI4gt
         j+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=otHAAoJeXEc/P3G/AXr3bWGwZWsjr5VuAddyjFBEbz8=;
        b=KvvVEznG2DF7ZKfLuf4Zlctvn0ZEahcq3MrqNGJjrQQA/30QMoecxzIRf+U9Udws4f
         v05y9UeI35vdh+ZTBKecmlfdsFGJRgbzmDeRUzKUd0T3MyCZUE/Mlp8yKzI0hQnNXY/R
         dYq2NQnbTjtd+FHf9eVkqu2Xy5B4UjEM3cmTTYR97OhM9UaP7SGLucf6BbzS++Mj4rTj
         VmzzwOtplFFZcCRe05QmzUdGoav4s65MJfqWGVKFMgPdFHqs24VXNnOW61MgbUdTF8+/
         i2UnMVIbqXcCXH5HMQPH0WvPzBi6HV6Jdb/mNEDhWXTIH2aZi560ZZytipO5d2vN0f4X
         MGiQ==
X-Gm-Message-State: AGRZ1gL4vKLBmFFyLnlV1Zt1JPCzzu8zt8GwDEP9En3f18LXExGnozj/
        bputMgKirm8yL4Tu+qzXXnuCTQ==
X-Google-Smtp-Source: AJdET5eTcpb9V7jPmDwJDLI0vCTjGj6rVW8niA3U3Mjyb5HBRRdHhsvcTsWtNry9/xjtPmf+yLdngw==
X-Received: by 2002:a0c:afd1:: with SMTP id t17mr3745998qvc.93.1542234451549;
        Wed, 14 Nov 2018 14:27:31 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id 24sm24067595qkp.65.2018.11.14.14.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:27:30 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Steve Kowalik <steven@wedontsleep.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/9] drm/msm/mdp4: only use lut_clk on mdp4.2+
Date:   Wed, 14 Nov 2018 17:24:08 -0500
Message-Id: <20181114222418.15960-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index ae25d763cd8c..8f765f284d11 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -206,7 +206,8 @@ int mdp4_disable(struct mdp4_kms *mdp4_kms)
 	clk_disable_unprepare(mdp4_kms->clk);
 	if (mdp4_kms->pclk)
 		clk_disable_unprepare(mdp4_kms->pclk);
-	clk_disable_unprepare(mdp4_kms->lut_clk);
+	if (mdp4_kms->lut_clk)
+		clk_disable_unprepare(mdp4_kms->lut_clk);
 	if (mdp4_kms->axi_clk)
 		clk_disable_unprepare(mdp4_kms->axi_clk);
 
@@ -220,7 +221,8 @@ int mdp4_enable(struct mdp4_kms *mdp4_kms)
 	clk_prepare_enable(mdp4_kms->clk);
 	if (mdp4_kms->pclk)
 		clk_prepare_enable(mdp4_kms->pclk);
-	clk_prepare_enable(mdp4_kms->lut_clk);
+	if (mdp4_kms->lut_clk)
+		clk_prepare_enable(mdp4_kms->lut_clk);
 	if (mdp4_kms->axi_clk)
 		clk_prepare_enable(mdp4_kms->axi_clk);
 
@@ -472,12 +474,13 @@ struct msm_kms *mdp4_kms_init(struct drm_device *dev)
 	if (IS_ERR(mdp4_kms->pclk))
 		mdp4_kms->pclk = NULL;
 
-	// XXX if (rev >= MDP_REV_42) { ???
-	mdp4_kms->lut_clk = devm_clk_get(&pdev->dev, "lut_clk");
-	if (IS_ERR(mdp4_kms->lut_clk)) {
-		dev_err(dev->dev, "failed to get lut_clk\n");
-		ret = PTR_ERR(mdp4_kms->lut_clk);
-		goto fail;
+	if (mdp4_kms->rev >= 2) {
+		mdp4_kms->lut_clk = devm_clk_get(&pdev->dev, "lut_clk");
+		if (IS_ERR(mdp4_kms->lut_clk)) {
+			dev_err(dev->dev, "failed to get lut_clk\n");
+			ret = PTR_ERR(mdp4_kms->lut_clk);
+			goto fail;
+		}
 	}
 
 	mdp4_kms->axi_clk = devm_clk_get(&pdev->dev, "bus_clk");
@@ -488,7 +491,8 @@ struct msm_kms *mdp4_kms_init(struct drm_device *dev)
 	}
 
 	clk_set_rate(mdp4_kms->clk, config->max_clk);
-	clk_set_rate(mdp4_kms->lut_clk, config->max_clk);
+	if (mdp4_kms->lut_clk)
+		clk_set_rate(mdp4_kms->lut_clk, config->max_clk);
 
 	pm_runtime_enable(dev->dev);
 	mdp4_kms->rpm_enabled = true;
-- 
2.17.1

