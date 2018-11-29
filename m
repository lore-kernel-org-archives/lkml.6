Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95533C07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A4220863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L+A6W0Wp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kXYqICyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A4220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbeK3E1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:27:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50874 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeK3E1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:27:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C9FFF61371; Thu, 29 Nov 2018 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543512091;
        bh=NFUgxHICUN5E14dYRFKcVoC/UBmWHlL+Dni+4jISyRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+A6W0WpHvh5GoTROx4IxanuGJ+be9XHlrBB87eKuqdrDSJQDgik9JZ/O2NcNKTrG
         mcimSwR/sn02sksdYSTj1wQ1HSv2bSm3mdLx/apnu9AZRwsrbmCXTCoGgStBFJ7Hdu
         C7vRzY2+k6zbk7Db6VKplG9ELjUarZv8J6Ot9zfA=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0C2561330;
        Thu, 29 Nov 2018 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543512089;
        bh=NFUgxHICUN5E14dYRFKcVoC/UBmWHlL+Dni+4jISyRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXYqICyo/Yaqt8vRtvDPz6lqw2C93Y0LJYmg2F87wvUDBICX/5NHx0XEQ3/CKWm5Q
         mB8flNpCCimFen0DSCXw4encqJrZaWyf+XAApL60s9rIE+6qFRRPPwilsPDnpgyhYE
         yssOoSdzHGdOy2CWVCqZ1/Py4xbMF9hXB30pchbI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0C2561330
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 1/1] drm/msm/a6xx: Add support for an interconnect path
Date:   Thu, 29 Nov 2018 10:21:24 -0700
Message-Id: <20181129172124.6851-2-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181129172124.6851-1-jcrouse@codeaurora.org>
References: <20181129172124.6851-1-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to get the interconnect path for the GPU and vote for the maximum
bandwidth to support all frequencies. This is needed for performance.
Later we will want to scale the bandwidth based on the frequency to
also optimize for power but that will require some device tree
infrastructure that does not yet exist.

v2: Absolute bandwidth values should be in KBps

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 546599a7ab05..b96ae2ab04bb 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -3,6 +3,7 @@
 
 #include <linux/clk.h>
 #include <linux/pm_opp.h>
+#include <linux/interconnect.h>
 #include <soc/qcom/cmd-db.h>
 
 #include "a6xx_gpu.h"
@@ -63,6 +64,9 @@ static bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 
 static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
 {
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	int ret;
 
 	gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
@@ -85,6 +89,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
 		dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
 
 	gmu->freq = gmu->gpu_freqs[index];
+
+	/*
+	 * Eventually we will want to scale the path vote with the frequency but
+	 * for now leave it t at max so that the performance is nominal.
+	 */
+	icc_set(gpu->icc_path, 0, 7216000000);
 }
 
 void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
@@ -680,6 +690,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
 
 int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 {
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	int status, ret;
 
@@ -695,6 +707,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	if (ret)
 		goto out;
 
+	/* Set the bus quota to a reasonable value for boot */
+	icc_set(gpu->icc_path, 0, 3072000000);
+
 	a6xx_gmu_irq_enable(gmu);
 
 	/* Check to see if we are doing a cold or warm boot */
@@ -735,6 +750,8 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
 
 int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 {
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	u32 val;
 
@@ -781,6 +798,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 	/* Tell RPMh to power off the GPU */
 	a6xx_rpmh_stop(gmu);
 
+	/* Remove the bus vote */
+	icc_set(gpu->icc_path, 0, 0);
+
 	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
 
 	pm_runtime_put_sync(gmu->dev);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 93d70f4a2154..9bab491912cf 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
+#include <linux/interconnect.h>
 #include "adreno_gpu.h"
 #include "msm_gem.h"
 #include "msm_mmu.h"
@@ -695,6 +696,11 @@ static int adreno_get_pwrlevels(struct device *dev,
 
 	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
 
+	/* Check for an interconnect path for the bus */
+	gpu->icc_path = of_icc_get(dev, "port0");
+	if (IS_ERR(gpu->icc_path))
+		gpu->icc_path = NULL;
+
 	return 0;
 }
 
@@ -733,10 +739,13 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 {
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
 		release_firmware(adreno_gpu->fw[i]);
 
+	icc_put(gpu->icc_path);
+
 	msm_gpu_cleanup(&adreno_gpu->base);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index f82bac086666..7b04d1665555 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -20,6 +20,7 @@
 
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
+#include <linux/interconnect.h>
 
 #include "msm_drv.h"
 #include "msm_fence.h"
@@ -119,6 +120,8 @@ struct msm_gpu {
 	struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
 	uint32_t fast_rate;
 
+	struct icc_path *icc_path;
+
 	/* Hang and Inactivity Detection:
 	 */
 #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
-- 
2.18.0

