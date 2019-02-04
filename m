Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889C2C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C5E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GKYo6yfQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g9usSiRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbfBDQQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:16:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731726AbfBDQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:16:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 902F560A74; Mon,  4 Feb 2019 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296959;
        bh=iPNB8KdDRrNaQEfs+HjsHS3z/b8yRn5qqN1q72X/r9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKYo6yfQc57PMI/NNh0JMO6/ByrA3H+CdXd5F6/k5o7wzgeCaUiCtgkie/LGhQVNn
         Du3qlSO4Ge2qwrghiBRIlfk9gL3JqYUKo2uIhhFDfX+NXXBHQSNetYugiojIWgK477
         AxaWFQNkSMpExxvbVVqklsYqucgd3wvNNaZLBARU=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F5D2609FD;
        Mon,  4 Feb 2019 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296957;
        bh=iPNB8KdDRrNaQEfs+HjsHS3z/b8yRn5qqN1q72X/r9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9usSiRWcr5MDK9xhSytzxBSwprJr56hGz0yn+5DZXWf5WeGAIpKF4EZ1thzF+n7V
         ltnej2nW7UI49xqaJfWSitRxqwdwVaIBZKr8UX3aJvyCbYUyEBVx+i5eMk+zO4tKbL
         QJyxEAEnJ/Mc6xY3J2P6AW5GwXiL9fdf5/QIN8HM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F5D2609FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Daniel Mack <daniel@zonque.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 5/6] msm/drm/a6xx: Turn off the GMU if resume fails
Date:   Mon,  4 Feb 2019 09:15:43 -0700
Message-Id: <1549296944-17285-6-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
References: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if the GMU resume function fails all we try to do is clear the
BOOT_SLUMBER oob which usually times out and ends up in a cycle of death.
If the resume function fails at any point remove any RPMh votes that might
have been added and try to shut down the GMU hardware cleanly.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 82 +++++++++++++++++++-----------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 20 ++------
 drivers/gpu/drm/msm/adreno/adreno_device.c |  1 +
 3 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index e16d55d..2e89ca3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -638,20 +638,6 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	 A6XX_GMU_AO_HOST_INTERRUPT_STATUS_HOST_AHB_BUS_ERROR | \
 	 A6XX_GMU_AO_HOST_INTERRUPT_STATUS_FENCE_ERR)
 
-static void a6xx_gmu_irq_enable(struct a6xx_gmu *gmu)
-{
-	gmu_write(gmu, REG_A6XX_GMU_AO_HOST_INTERRUPT_CLR, ~0);
-	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_CLR, ~0);
-
-	gmu_write(gmu, REG_A6XX_GMU_AO_HOST_INTERRUPT_MASK,
-		~A6XX_GMU_IRQ_MASK);
-	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_MASK,
-		~A6XX_HFI_IRQ_MASK);
-
-	enable_irq(gmu->gmu_irq);
-	enable_irq(gmu->hfi_irq);
-}
-
 static void a6xx_gmu_irq_disable(struct a6xx_gmu *gmu)
 {
 	disable_irq(gmu->gmu_irq);
@@ -661,11 +647,24 @@ static void a6xx_gmu_irq_disable(struct a6xx_gmu *gmu)
 	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_MASK, ~0);
 }
 
-/* Force the GMU off in case it isn't responsive */
-static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
+static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
 {
 	u32 val;
 
+	/* Make sure there are no outstanding RPMh votes */
+	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS0_DRV0_STATUS, val,
+		(val & 1), 100, 10000);
+	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS1_DRV0_STATUS, val,
+		(val & 1), 100, 10000);
+	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS2_DRV0_STATUS, val,
+		(val & 1), 100, 10000);
+	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS, val,
+		(val & 1), 100, 1000);
+}
+
+/* Force the GMU off in case it isn't responsive */
+static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
+{
 	/* Flush all the queues */
 	a6xx_hfi_stop(gmu);
 
@@ -676,14 +675,7 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 	a6xx_sptprac_disable(gmu);
 
 	/* Make sure there are no outstanding RPMh votes */
-	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS0_DRV0_STATUS, val,
-		(val & 1), 100, 10000);
-	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS1_DRV0_STATUS, val,
-		(val & 1), 100, 10000);
-	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS2_DRV0_STATUS, val,
-		(val & 1), 100, 10000);
-	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS, val,
-		(val & 1), 100, 1000);
+	a6xx_gmu_rpmh_off(gmu);
 }
 
 int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
@@ -702,10 +694,15 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	/* Use a known rate to bring up the GMU */
 	clk_set_rate(gmu->core_clk, 200000000);
 	ret = clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
-	if (ret)
-		goto out;
+	if (ret) {
+		pm_runtime_put(gmu->dev);
+		return ret;
+	}
 
-	a6xx_gmu_irq_enable(gmu);
+	/* Enable the GMU interrupt */
+	gmu_write(gmu, REG_A6XX_GMU_AO_HOST_INTERRUPT_CLR, ~0);
+	gmu_write(gmu, REG_A6XX_GMU_AO_HOST_INTERRUPT_MASK, ~A6XX_GMU_IRQ_MASK);
+	enable_irq(gmu->gmu_irq);
 
 	/* Check to see if we are doing a cold or warm boot */
 	status = gmu_read(gmu, REG_A6XX_GMU_GENERAL_7) == 1 ?
@@ -716,6 +713,16 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 		goto out;
 
 	ret = a6xx_hfi_start(gmu, status);
+	if (ret)
+		goto out;
+
+	/*
+	 * Turn on the GMU firmware fault interrupt after we know the boot
+	 * sequence is successful
+	 */
+	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_CLR, ~0);
+	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_MASK, ~A6XX_HFI_IRQ_MASK);
+	enable_irq(gmu->hfi_irq);
 
 	/* Set the GPU to the highest power frequency */
 	__a6xx_gmu_set_freq(gmu, gmu->nr_gpu_freqs - 1);
@@ -729,9 +736,12 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 		pm_runtime_get(gmu->gxpd);
 
 out:
-	/* Make sure to turn off the boot OOB request on error */
-	if (ret)
-		a6xx_gmu_clear_oob(gmu, GMU_OOB_BOOT_SLUMBER);
+	/* On failure, shut down the GMU to leave it in a good state */
+	if (ret) {
+		disable_irq(gmu->gmu_irq);
+		a6xx_rpmh_stop(gmu);
+		pm_runtime_put(gmu->dev);
+	}
 
 	return ret;
 }
@@ -754,6 +764,9 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
 /* Gracefully try to shut down the GMU and by extension the GPU */
 static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 {
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	u32 val;
 
 	/*
@@ -771,6 +784,12 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 			return;
 		}
 
+		/* Clear the VBIF pipe before shutting down */
+		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0xf);
+		spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) & 0xf)
+			== 0xf);
+		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0);
+
 		/* tell the GMU we want to slumber */
 		a6xx_gmu_notify_slumber(gmu);
 
@@ -808,6 +827,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 {
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 
+	if (!pm_runtime_active(gmu->dev))
+		return 0;
+
 	/*
 	 * Force the GMU off if we detected a hang, otherwise try to shut it
 	 * down gracefully
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f76d8cd..576559a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -678,13 +678,15 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	int ret;
 
-	ret = a6xx_gmu_resume(a6xx_gpu);
-
 	gpu->needs_hw_init = true;
 
+	ret = a6xx_gmu_resume(a6xx_gpu);
+	if (ret)
+		return ret;
+
 	msm_gpu_resume_devfreq(gpu);
 
-	return ret;
+	return 0;
 }
 
 static int a6xx_pm_suspend(struct msm_gpu *gpu)
@@ -694,18 +696,6 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 
 	devfreq_suspend_device(gpu->devfreq.devfreq);
 
-	/*
-	 * Make sure the GMU is idle before continuing (because some transitions
-	 * may use VBIF
-	 */
-	a6xx_gmu_wait_for_idle(&a6xx_gpu->gmu);
-
-	/* Clear the VBIF pipe before shutting down */
-	/* FIXME: This accesses the GPU - do we need to make sure it is on? */
-	gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0xf);
-	spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) & 0xf) == 0xf);
-	gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0);
-
 	return a6xx_gmu_stop(a6xx_gpu);
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 714ed65..0d87db7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -229,6 +229,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
+		pm_runtime_put_sync(&pdev->dev);
 		DRM_DEV_ERROR(dev->dev, "Couldn't power up the GPU: %d\n", ret);
 		return NULL;
 	}
-- 
2.7.4

