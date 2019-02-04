Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA547C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9056020815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ge39DEVa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ha/UIRln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbfBDQQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:16:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50166 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfBDQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:15:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7502660A08; Mon,  4 Feb 2019 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296958;
        bh=A32xjH2FbcdHs33yWa5JyHkdx6i7TB2y+AyyHFgE/vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ge39DEVavG3Ua8HOD08pc04viE6xm+DknoSlpbi938pm+UHoruVbpSSGKk8fxsRhr
         IN1V/KexaNoK1JmEDbG4aQiQsy81QaxZJXC4LOOk20W8zShVFx9EWxfuBrzQ61UbtW
         KxtHyCNEvURBJYJvS4Bg/O3mVz+q05k1f5eZo8Pk=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE926609B4;
        Mon,  4 Feb 2019 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296956;
        bh=A32xjH2FbcdHs33yWa5JyHkdx6i7TB2y+AyyHFgE/vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ha/UIRlnoncWVNcEAS6B75m/6iOJaxcHeI3wKgiNH/QxDMf9zqfrSuO6t7c5hsrnn
         m/L1VX0txxoVOAZRNO2aswPyDP4dYixXBK3O7PU0olKWJchfZgbuEblW1bnwawx++4
         HH9ArqO8M3RJxmKZRSP1ezi7kregg/Fu7ynuAwtg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE926609B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 4/6] drm/msm/a6xx: Make GMU reset useful
Date:   Mon,  4 Feb 2019 09:15:42 -0700
Message-Id: <1549296944-17285-5-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
References: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the GX domain is sorted we can wire up a working GMU reset.
IF a GMU hang was detected then try to forcefully shut down the GMU
in the power down sequence which should ensure that it can recover
normally on the next power up.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 109 ++++++++++++++++------------------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |   3 +-
 4 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index a527c50..e16d55d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -9,6 +9,24 @@
 #include "a6xx_gpu.h"
 #include "a6xx_gmu.xml.h"
 
+static void a6xx_gmu_fault(struct a6xx_gmu *gmu)
+{
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct drm_device *dev = gpu->dev;
+	struct msm_drm_private *priv = dev->dev_private;
+
+	/* FIXME: add a banner here */
+	gmu->hung = true;
+
+	/* Turn off the hangcheck timer while we are resetting */
+	del_timer(&gpu->hangcheck_timer);
+
+	/* Queue the GPU handler because we need to treat this as a recovery */
+	queue_work(priv->wq, &gpu->recover_work);
+}
+
 static irqreturn_t a6xx_gmu_irq(int irq, void *data)
 {
 	struct a6xx_gmu *gmu = data;
@@ -20,8 +38,7 @@ static irqreturn_t a6xx_gmu_irq(int irq, void *data)
 	if (status & A6XX_GMU_AO_HOST_INTERRUPT_STATUS_WDOG_BITE) {
 		dev_err_ratelimited(gmu->dev, "GMU watchdog expired\n");
 
-		/* Temporary until we can recover safely */
-		BUG();
+		a6xx_gmu_fault(gmu);
 	}
 
 	if (status &  A6XX_GMU_AO_HOST_INTERRUPT_STATUS_HOST_AHB_BUS_ERROR)
@@ -45,8 +62,7 @@ static irqreturn_t a6xx_hfi_irq(int irq, void *data)
 	if (status & A6XX_GMU_GMU2HOST_INTR_INFO_CM3_FAULT) {
 		dev_err_ratelimited(gmu->dev, "GMU firmware fault\n");
 
-		/* Temporary until we can recover safely */
-		BUG();
+		a6xx_gmu_fault(gmu);
 	}
 
 	return IRQ_HANDLED;
@@ -156,10 +172,8 @@ static bool a6xx_gmu_check_idle_level(struct a6xx_gmu *gmu)
 }
 
 /* Wait for the GMU to get to its most idle state */
-int a6xx_gmu_wait_for_idle(struct a6xx_gpu *a6xx_gpu)
+int a6xx_gmu_wait_for_idle(struct a6xx_gmu *gmu)
 {
-	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
-
 	return spin_until(a6xx_gmu_check_idle_level(gmu));
 }
 
@@ -558,7 +572,7 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 		if (!rpmh_init) {
 			a6xx_gmu_rpmh_init(gmu);
 			rpmh_init = true;
-		} else if (state != GMU_RESET) {
+		} else {
 			ret = a6xx_rpmh_start(gmu);
 			if (ret)
 				return ret;
@@ -647,10 +661,9 @@ static void a6xx_gmu_irq_disable(struct a6xx_gmu *gmu)
 	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_MASK, ~0);
 }
 
-int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
+/* Force the GMU off in case it isn't responsive */
+static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 {
-	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
-	int ret;
 	u32 val;
 
 	/* Flush all the queues */
@@ -671,44 +684,6 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
 		(val & 1), 100, 10000);
 	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS, val,
 		(val & 1), 100, 1000);
-
-	/*
-	 * Depending on the state of the GMU at this point the GX domain might
-	 * have been left on. Hardware sequencing rules state that the GX has to
-	 * be turned off before the CX domain so this is that one time that
-	 * that calling pm_runtime_put_sync() is expected to do something useful
-	 * (turn off the headswitch)
-	 */
-	if (!IS_ERR(gmu->gxpd))
-		pm_runtime_put_sync(gmu->gxpd);
-
-	/* Disable the resources */
-	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
-	pm_runtime_put_sync(gmu->dev);
-
-	/* Re-enable the resources */
-	pm_runtime_get_sync(gmu->dev);
-
-	/* Use a known rate to bring up the GMU */
-	clk_set_rate(gmu->core_clk, 200000000);
-	ret = clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
-	if (ret)
-		goto out;
-
-	a6xx_gmu_irq_enable(gmu);
-
-	ret = a6xx_gmu_fw_start(gmu, GMU_RESET);
-	if (!ret)
-		ret = a6xx_hfi_start(gmu, GMU_COLD_BOOT);
-
-	/* Set the GPU back to the highest power frequency */
-	__a6xx_gmu_set_freq(gmu, gmu->nr_gpu_freqs - 1);
-
-out:
-	if (ret)
-		a6xx_gmu_clear_oob(gmu, GMU_OOB_BOOT_SLUMBER);
-
-	return ret;
 }
 
 int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
@@ -719,6 +694,8 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	if (WARN(!gmu->mmio, "The GMU is not set up yet\n"))
 		return 0;
 
+	gmu->hung = false;
+
 	/* Turn on the resources */
 	pm_runtime_get_sync(gmu->dev);
 
@@ -774,9 +751,9 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
 	return true;
 }
 
-int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
+/* Gracefully try to shut down the GMU and by extension the GPU */
+static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 {
-	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	u32 val;
 
 	/*
@@ -786,10 +763,13 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 	val = gmu_read(gmu, REG_A6XX_GPU_GMU_CX_GMU_RPMH_POWER_STATE);
 
 	if (val != 0xf) {
-		int ret = a6xx_gmu_wait_for_idle(a6xx_gpu);
+		int ret = a6xx_gmu_wait_for_idle(gmu);
 
-		/* Temporary until we can recover safely */
-		BUG_ON(ret);
+		/* If the GMU isn't responding assume it is hung */
+		if (ret) {
+			a6xx_gmu_force_off(gmu);
+			return;
+		}
 
 		/* tell the GMU we want to slumber */
 		a6xx_gmu_notify_slumber(gmu);
@@ -821,11 +801,26 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 
 	/* Tell RPMh to power off the GPU */
 	a6xx_rpmh_stop(gmu);
+}
+
+
+int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
+{
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+
+	/*
+	 * Force the GMU off if we detected a hang, otherwise try to shut it
+	 * down gracefully
+	 */
+	if (gmu->hung)
+		a6xx_gmu_force_off(gmu);
+	else
+		a6xx_gmu_shutdown(gmu);
 
 	/*
-	 * Mark the GPU power domain as off. During the shutdown process the GMU
-	 * should actually turn off the power so this is really just a
-	 * houskeeping step
+	 * Make sure the GX domain is off before turning off the GMU (CX)
+	 * domain. Usually the GMU does this but only if the shutdown sequence
+	 * was successful
 	 */
 	if (!IS_ERR(gmu->gxpd))
 		pm_runtime_put_sync(gmu->gxpd);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 078d418..c5b1887 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -27,9 +27,6 @@ struct a6xx_gmu_bo {
 /* the GMU is coming up for the first time or back from a power collapse */
 #define GMU_COLD_BOOT 1
 
-/* The GMU is being soft reset after a fault */
-#define GMU_RESET 2
-
 /*
  * These define the level of control that the GMU has - the higher the number
  * the more things that the GMU hardware controls on its own.
@@ -79,6 +76,7 @@ struct a6xx_gmu {
 	struct a6xx_hfi_queue queues[2];
 
 	struct tasklet_struct hfi_tasklet;
+	bool hung;
 };
 
 static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index fefe773..f76d8cd 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -698,7 +698,7 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 	 * Make sure the GMU is idle before continuing (because some transitions
 	 * may use VBIF
 	 */
-	a6xx_gmu_wait_for_idle(a6xx_gpu);
+	a6xx_gmu_wait_for_idle(&a6xx_gpu->gmu);
 
 	/* Clear the VBIF pipe before shutting down */
 	/* FIXME: This accesses the GPU - do we need to make sure it is on? */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 528a4cf..b46279e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -46,9 +46,8 @@ struct a6xx_gpu {
 int a6xx_gmu_resume(struct a6xx_gpu *gpu);
 int a6xx_gmu_stop(struct a6xx_gpu *gpu);
 
-int a6xx_gmu_wait_for_idle(struct a6xx_gpu *gpu);
+int a6xx_gmu_wait_for_idle(struct a6xx_gmu *gmu);
 
-int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu);
 bool a6xx_gmu_isidle(struct a6xx_gmu *gmu);
 
 int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
-- 
2.7.4

