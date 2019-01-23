Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68A7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37FF20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z9aAMB+O";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kt7am6XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfAWLMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:12:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfAWLMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:12:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 44DD76014B; Wed, 23 Jan 2019 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548241973;
        bh=yx/RqyJ4hWDcNmGbeUJdRdVXCtvBV8K5olsKzX+lf5E=;
        h=From:To:Cc:Subject:Date:From;
        b=Z9aAMB+O9zScpowUq/MJPgaRO+2nF+UejZ1vxjzDA13o+KnpDSKA3zygqfJOw6FNS
         2PTI2Ey7hML4BCc8bXvk85wiAMoqmB3rwQP1Nf5nxQ6DhiFBDEO9XDbWxe7yh+fHp3
         oraAaS9GY5df9rohLT2uk1QMSuXjOr7gzNizQ3kI=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E71E6049C;
        Wed, 23 Jan 2019 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548241972;
        bh=yx/RqyJ4hWDcNmGbeUJdRdVXCtvBV8K5olsKzX+lf5E=;
        h=From:To:Cc:Subject:Date:From;
        b=kt7am6XZR19AsRDF8iu/ffgBlSUzmQwVTq2CRhBKMnPcNk8vtqYDkQh60PxvpmHto
         RXmL5TFVr0Lag6e5To8eGhSUkct3yfpgL624I1LYJZ1/HkVLBwN8crwd8bMptWb7gK
         RXK/7+kfOyRsDAbbOX+ye9H7Oqatz/GY/zh2fQnk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E71E6049C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: [v1] drm/msm: Remove clock and bandwidth votes in mdss pm suspend
Date:   Wed, 23 Jan 2019 16:42:40 +0530
Message-Id: <1548241960-7412-1-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MDSS PM suspend is dependent on runtime suspend for disabling
clocks and removing bandwidth votes. In case of pm_suspend
triggered, dpm_prepare hold a refcount on power usage of device
and hence runtime suspend is never triggered during pm_suspend.
As runtime suspend is not triggered, clocks and bandwidth votes
remain. Hence explicitly trigger mdss disable in msm_pm_suspend
to disable clocks and remove the votes.

Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5c60bb3..ffe3a25 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1068,12 +1068,16 @@ static int msm_pm_suspend(struct device *dev)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct msm_drm_private *priv = ddev->dev_private;
+	struct msm_mdss *mdss = priv->mdss;
 
 	if (!IS_ERR_OR_NULL(priv->pm_state))
 		return 0;
 
 	priv->pm_state = drm_atomic_helper_suspend(ddev);
 
+	if (mdss && mdss->funcs)
+		mdss->funcs->disable(mdss);
+
 	return IS_ERR(priv->pm_state) ? PTR_ERR(priv->pm_state) : 0;
 }
 
@@ -1081,11 +1085,15 @@ static int msm_pm_resume(struct device *dev)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct msm_drm_private *priv = ddev->dev_private;
+	struct msm_mdss *mdss = priv->mdss;
 	int ret;
 
 	if (IS_ERR_OR_NULL(priv->pm_state))
 		return 0;
 
+	if (mdss && mdss->funcs)
+		mdss->funcs->enable(mdss);
+
 	ret = drm_atomic_helper_resume(ddev, priv->pm_state);
 	if (ret == 0)
 		priv->pm_state = NULL;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

