Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D661520815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NbgnyqIt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IivKEMTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfBDQQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:16:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbfBDQP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:15:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F2F0609C6; Mon,  4 Feb 2019 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296955;
        bh=DANfYZAr0IJ7iZWclKlp3WcOd2dppQW1UEMJ5r7u6SU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbgnyqIt8MaHK+cIR3ahr884umyo/+prOD3p3t3w8dSAyI+ppT7kRcl1JKaiRqDIC
         AR/OLRfaNL3uY7hbCUjST/SOrSDsyd5YX+ari7sHE0D/aTocABfTtTLTolSSn48n52
         jXkyJxs2s1wFT/uaBmnAcGU7f9rvynA/lCqPTxrs=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 687C360960;
        Mon,  4 Feb 2019 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296954;
        bh=DANfYZAr0IJ7iZWclKlp3WcOd2dppQW1UEMJ5r7u6SU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IivKEMTkP+US1FDeSE9pjOun8KsgOTyqCnTvn73jmUUf4cUwh/n6jHTXe2jSyyGjw
         +TrAds4wtgOCh/qhoMTwzU1KWn/Rt7EeOFDw51tErPVDt8fheRu/erzSEjktYkZ3UO
         3lYok4FmaXOUrQFaV8AcuKQk5waCbniN5v4W8scs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 687C360960
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 3/6] drm/msm/gpu: Attach to the GPU GX power domain
Date:   Mon,  4 Feb 2019 09:15:41 -0700
Message-Id: <1549296944-17285-4-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
References: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

99.999% of the time during normal operation the GMU is responsible
for power and clock control on the GX domain and the CPU remains
blissfully unaware. However, there is one situation where the CPU
needs to get involved:

The power sequencing rules dictate that the GX needs to be turned
off before the CX so that the CX can be turned on before the GX
during power up. During normal operation when the CPU is taking
down the CX domain a stop command is sent to the GMU which turns
off the GX domain and then the CPU handles the CX domain.

But if the GMU happened to be unresponsive while the GX domain was
left then the CPU will need to step in and turn off the GX domain
before resetting the CX and rebooting the GMU. This unfortunately
means that the CPU needs to be marginally aware of the GX domain
even though it is expected to usually keep its hands off.

To support this we create a semi-disabled GX power domain that
does nothing to the hardware on power up but tries to shut it
down normally on power down. In this method the reference counting
is correct and we can step in with the pm_runtime_put() at the right
time during the failure path.

This patch sets up the connection to the GX power domain and does
the magic to "enable" and disable it at the right points.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 41 ++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  2 ++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index f1baf64f..a527c50 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
 
 #include <linux/clk.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <soc/qcom/cmd-db.h>
 
@@ -671,6 +672,16 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
 	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS, val,
 		(val & 1), 100, 1000);
 
+	/*
+	 * Depending on the state of the GMU at this point the GX domain might
+	 * have been left on. Hardware sequencing rules state that the GX has to
+	 * be turned off before the CX domain so this is that one time that
+	 * that calling pm_runtime_put_sync() is expected to do something useful
+	 * (turn off the headswitch)
+	 */
+	if (!IS_ERR(gmu->gxpd))
+		pm_runtime_put_sync(gmu->gxpd);
+
 	/* Disable the resources */
 	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
 	pm_runtime_put_sync(gmu->dev);
@@ -732,6 +743,14 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	/* Set the GPU to the highest power frequency */
 	__a6xx_gmu_set_freq(gmu, gmu->nr_gpu_freqs - 1);
 
+	/*
+	 * "enable" the GX power domain which won't actually do anything but it
+	 * will make sure that the refcounting is correct in case we need to
+	 * bring down the GX after a GMU failure
+	 */
+	if (!IS_ERR(gmu->gxpd))
+		pm_runtime_get(gmu->gxpd);
+
 out:
 	/* Make sure to turn off the boot OOB request on error */
 	if (ret)
@@ -803,6 +822,14 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 	/* Tell RPMh to power off the GPU */
 	a6xx_rpmh_stop(gmu);
 
+	/*
+	 * Mark the GPU power domain as off. During the shutdown process the GMU
+	 * should actually turn off the power so this is really just a
+	 * houskeeping step
+	 */
+	if (!IS_ERR(gmu->gxpd))
+		pm_runtime_put_sync(gmu->gxpd);
+
 	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
 
 	pm_runtime_put_sync(gmu->dev);
@@ -1172,9 +1199,15 @@ void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
 	if (IS_ERR_OR_NULL(gmu->mmio))
 		return;
 
-	pm_runtime_disable(gmu->dev);
 	a6xx_gmu_stop(a6xx_gpu);
 
+	pm_runtime_disable(gmu->dev);
+
+	if (!IS_ERR(gmu->gxpd)) {
+		pm_runtime_disable(gmu->gxpd);
+		dev_pm_domain_detach(gmu->gxpd, false);
+	}
+
 	a6xx_gmu_irq_disable(gmu);
 	a6xx_gmu_memory_free(gmu, gmu->hfi);
 
@@ -1233,6 +1266,12 @@ int a6xx_gmu_probe(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	if (gmu->hfi_irq < 0 || gmu->gmu_irq < 0)
 		goto err;
 
+	/*
+	 * Get a link to the GX power domain to reset the GPU in case of GMU
+	 * crash
+	 */
+	gmu->gxpd = dev_pm_domain_attach_by_name(gmu->dev, "gx");
+
 	/* Get the power levels for the GMU and GPU */
 	a6xx_gmu_pwrlevels_probe(gmu);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 8081083..078d418 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -55,6 +55,8 @@ struct a6xx_gmu {
 	struct iommu_domain *domain;
 	u64 uncached_iova_base;
 
+	struct device *gxpd;
+
 	int idle_level;
 
 	struct a6xx_gmu_bo *hfi;
-- 
2.7.4

