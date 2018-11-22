Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1297C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A97020663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hTGWmmJe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iEAbJPug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A97020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393388AbeKVTpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:45:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35400 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKVTpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:45:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C794F60C48; Thu, 22 Nov 2018 09:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542877635;
        bh=Pq9fhDDJ782dlNY7ozcU47fIMtNoEuYEpKheVJ0L94w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTGWmmJeebBbzsLIbSvEpYsQqe6szFmBNr7hNgrAE6FvfHMLnZZYKHA4lQYejEMyN
         XWpA10NCo13x381UpcCqHx90IMx4HAsj6ESC0cB9VMv7bRCbMAT2fhPljzYpEyVR6q
         6ZesfmSkhNW0oAPFTlLoN5vXDgjc5JmQaE5YbHOA=
Received: from skolluku-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: skolluku@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22D6B60722;
        Thu, 22 Nov 2018 09:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542877634;
        bh=Pq9fhDDJ782dlNY7ozcU47fIMtNoEuYEpKheVJ0L94w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEAbJPug/9yODpZL2AgM1XK13cmrWF02v1kUyp099hbLUk7Wd2lu3xDJtXWf7j8oC
         wPNTfm2XWesDyybEB8arZn5nbiFwYSKJTYP+8cWZoBqSLCYD8aPlcu2fza1uwgBZPT
         y0lrz7EOmPaJgPEuudwAY1welHlmYtfB+w773TOA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22D6B60722
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skolluku@codeaurora.org
From:   Sravanthi Kollukuduru <skolluku@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, sean@poorly.run
Subject: [PATCH v3 2/3] drm/msm/dpu: Integrate interconnect API in MDSS
Date:   Thu, 22 Nov 2018 14:36:52 +0530
Message-Id: <20181122090653.3523-3-skolluku@codeaurora.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181122090653.3523-1-skolluku@codeaurora.org>
References: <20181122090653.3523-1-skolluku@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interconnect framework is designed to provide a
standard kernel interface to control the settings of
the interconnects on a SoC.

The interconnect API uses a consumer/provider-based model,
where the providers are the interconnect buses and the
consumers could be various drivers.

MDSS is one of the interconnect consumers which uses the
interconnect APIs to get the path between endpoints and
set its bandwidth/latency/QoS requirements for the given
interconnected path.

Changes in v2:
	- Remove error log and unnecessary check (Jordan Crouse)

Changes in v3:
	- Code clean involving variable name change, removal
	  of extra paranthesis and variables (Matthias Kaehlcke)

Signed-off-by: Sravanthi Kollukuduru <skolluku@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 49 ++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index 38576f8b90b6..1387a6b1b39e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -4,10 +4,12 @@
  */
 
 #include "dpu_kms.h"
+#include <linux/interconnect.h>
 
 #define to_dpu_mdss(x) container_of(x, struct dpu_mdss, base)
 
-#define HW_INTR_STATUS			0x0010
+#define HW_INTR_STATUS	0x0010
+#define MAX_BW		6800000
 
 struct dpu_mdss {
 	struct msm_mdss base;
@@ -16,8 +18,30 @@ struct dpu_mdss {
 	u32 hwversion;
 	struct dss_module_power mp;
 	struct dpu_irq_controller irq_controller;
+	struct icc_path *path[2];
+	u32 num_paths;
 };
 
+static int dpu_mdss_parse_data_bus_icc_path(
+		struct drm_device *dev, struct dpu_mdss *dpu_mdss)
+{
+	struct icc_path *path0 = of_icc_get(dev->dev, "port0");
+	struct icc_path *path1 = of_icc_get(dev->dev, "port1");
+
+	if (IS_ERR(path0))
+		return PTR_ERR(path0);
+
+	dpu_mdss->path[0] = path0;
+	dpu_mdss->num_paths = 1;
+
+	if (!IS_ERR(path1)) {
+		dpu_mdss->path[1] = path1;
+		dpu_mdss->num_paths++;
+	}
+
+	return 0;
+}
+
 static irqreturn_t dpu_mdss_irq(int irq, void *arg)
 {
 	struct dpu_mdss *dpu_mdss = arg;
@@ -127,7 +151,11 @@ static int dpu_mdss_enable(struct msm_mdss *mdss)
 {
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
-	int ret;
+	int ret, i;
+	u64 avg_bw = dpu_mdss->num_paths ? MAX_BW/dpu_mdss->num_paths : 0;
+
+	for (i = 0; i < dpu_mdss->num_paths; i++)
+		icc_set(dpu_mdss->path[i], avg_bw, MAX_BW);
 
 	ret = msm_dss_enable_clk(mp->clk_config, mp->num_clk, true);
 	if (ret)
@@ -140,12 +168,15 @@ static int dpu_mdss_disable(struct msm_mdss *mdss)
 {
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
-	int ret;
+	int ret, i;
 
 	ret = msm_dss_enable_clk(mp->clk_config, mp->num_clk, false);
 	if (ret)
 		DPU_ERROR("clock disable failed, ret:%d\n", ret);
 
+	for (i = 0; i < dpu_mdss->num_paths; i++)
+		icc_set(dpu_mdss->path[i], 0, 0);
+
 	return ret;
 }
 
@@ -155,6 +186,7 @@ static void dpu_mdss_destroy(struct drm_device *dev)
 	struct msm_drm_private *priv = dev->dev_private;
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(priv->mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
+	int i;
 
 	pm_runtime_disable(dev->dev);
 	_dpu_mdss_irq_domain_fini(dpu_mdss);
@@ -162,6 +194,9 @@ static void dpu_mdss_destroy(struct drm_device *dev)
 	msm_dss_put_clk(mp->clk_config, mp->num_clk);
 	devm_kfree(&pdev->dev, mp->clk_config);
 
+	for (i = 0; i < dpu_mdss->num_paths; i++)
+		icc_put(dpu_mdss->path[i]);
+
 	if (dpu_mdss->mmio)
 		devm_iounmap(&pdev->dev, dpu_mdss->mmio);
 	dpu_mdss->mmio = NULL;
@@ -200,6 +235,10 @@ int dpu_mdss_init(struct drm_device *dev)
 	}
 	dpu_mdss->mmio_len = resource_size(res);
 
+	ret = dpu_mdss_parse_data_bus_icc_path(dev, dpu_mdss);
+	if (ret)
+		return ret;
+
 	mp = &dpu_mdss->mp;
 	ret = msm_dss_parse_clock(pdev, mp);
 	if (ret) {
@@ -221,14 +260,14 @@ int dpu_mdss_init(struct drm_device *dev)
 		goto irq_error;
 	}
 
+	priv->mdss = &dpu_mdss->base;
+
 	pm_runtime_enable(dev->dev);
 
 	pm_runtime_get_sync(dev->dev);
 	dpu_mdss->hwversion = readl_relaxed(dpu_mdss->mmio);
 	pm_runtime_put_sync(dev->dev);
 
-	priv->mdss = &dpu_mdss->base;
-
 	return ret;
 
 irq_error:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

