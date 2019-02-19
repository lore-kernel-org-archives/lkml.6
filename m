Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ABEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913B720645
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DNU6lQ1N";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="acKjserT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfBSSs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:48:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46246 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBSSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:48:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D5D7608D4; Tue, 19 Feb 2019 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550602106;
        bh=WdeFdupR5GGp/lujcSH4hA7KIn8EpzdZx7fdgS1qJL8=;
        h=From:To:Cc:Subject:Date:From;
        b=DNU6lQ1N7XVAwh3MMhXfTfkO3u6UOGYoeKIC469wKxvE32fdghzQxZgdt0QaUttIF
         n+0SI1wmK6hcpzCTbeUvhqPcbs/O3j6pL61ufUY4yneQ/mxUCx8q6b511nYmp013OX
         jvR3jehxnsX4yAKcqMpE1sf5botsvivX6dr6h3k8=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7383960850;
        Tue, 19 Feb 2019 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550602105;
        bh=WdeFdupR5GGp/lujcSH4hA7KIn8EpzdZx7fdgS1qJL8=;
        h=From:To:Cc:Subject:Date:From;
        b=acKjserTShX380jvLVM/bn7GREsKosoJNhSI7TD74agEqEjzbwEku6aytzBM4oDri
         NWw/QzpmDTaOPGz3XvmvjNEqMGl/Cpnhu+/PSUgj/n+MkExbhraMRTYlmoXSDmd/uG
         JJ196fGKylCF4LJNrT23clqoFaAcEts//3da8wcM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7383960850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Doug Anderson <dianders@chromium.org>,
        Kristian Kristensen <hoegsberg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/msm: Remove pm_runtime calls from msm_iommu.c
Date:   Tue, 19 Feb 2019 11:48:20 -0700
Message-Id: <1550602100-14169-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the IOMMU code calls pm_runtime_get/put on the GPU or display
device before doing a IOMMU operation. This was because usually the
IOMMU driver didn't do power control of its own and since the hardware
used the same clocks and power as the respective multimedia device it
was a easy way to make sure that the power was available.

Now two things have changed. First, the SMMU devices can do their own power
control and more important bringing up the a6xx GPU isn't as easy as
turning on some clocks. To bring the GPU up we need the GMU which itself
needs the IOMMU so we have a chicken and egg problem.

Luckily this is easily fixed by removing the pm_runtime calls from the
functions and letting the device link to the IOMMU device handle the magic.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_iommu.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 4d62790..12bb54c 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -38,13 +38,8 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
 			    int cnt)
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
-	int ret;
 
-	pm_runtime_get_sync(mmu->dev);
-	ret = iommu_attach_device(iommu->domain, mmu->dev);
-	pm_runtime_put_sync(mmu->dev);
-
-	return ret;
+	return iommu_attach_device(iommu->domain, mmu->dev);
 }
 
 static void msm_iommu_detach(struct msm_mmu *mmu, const char * const *names,
@@ -52,9 +47,7 @@ static void msm_iommu_detach(struct msm_mmu *mmu, const char * const *names,
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 
-	pm_runtime_get_sync(mmu->dev);
 	iommu_detach_device(iommu->domain, mmu->dev);
-	pm_runtime_put_sync(mmu->dev);
 }
 
 static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
@@ -63,9 +56,7 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	size_t ret;
 
-//	pm_runtime_get_sync(mmu->dev);
 	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
-//	pm_runtime_put_sync(mmu->dev);
 	WARN_ON(!ret);
 
 	return (ret == len) ? 0 : -EINVAL;
@@ -75,9 +66,7 @@ static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, unsigned len)
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 
-	pm_runtime_get_sync(mmu->dev);
 	iommu_unmap(iommu->domain, iova, len);
-	pm_runtime_put_sync(mmu->dev);
 
 	return 0;
 }
-- 
2.7.4

