Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28214C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED3B20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XESqm2bQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HErN+yUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfAIRwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:52:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfAIRwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:52:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A02D609EF; Wed,  9 Jan 2019 17:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547056360;
        bh=IvSRhdzPGJqTxBLXU15tjtZAiq2UPzIPgQr6Ph0nP1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XESqm2bQZnteiX7+5hBefsyrtz4b9R36w8BO8OUNuBTSWyHVIkPxIFNQaIMteJ3Vp
         6rzx0bHkHyFehEPJavEwZMHuh5ofMPtxa/1MGh20s7kQVJWdNi12dXmWVb0MPIINHL
         +Tj7EKepfdGtow4FVw288uQDTmlAeeiTbJb008kQ=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D101608CD;
        Wed,  9 Jan 2019 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547056356;
        bh=IvSRhdzPGJqTxBLXU15tjtZAiq2UPzIPgQr6Ph0nP1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HErN+yUf0/ltVes8qleWox9E2OEvOQ8CWRtGWj/gu+EzWCLJyigdHM6Z7pdzD93ST
         x8WlFBQ7yXry1KMBW+XIOfrLrY96qTDABcjYgGrPgSR8eyDX5F6i1y8yG8JNk6Q/a8
         ghfumWST63DbP/LIbEyGSmoKI/hTxRyXKy7uAoMo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D101608CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org,
        Jayant Shekhar <jshekhar@codeaurora.org>
Subject: [v5 2/3] drm/msm/dpu: Integrate interconnect API in MDSS
Date:   Wed,  9 Jan 2019 23:22:04 +0530
Message-Id: <1547056325-1919-3-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547056325-1919-1-git-send-email-jshekhar@codeaurora.org>
References: <1547056325-1919-1-git-send-email-jshekhar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sravanthi Kollukuduru <skolluku@codeaurora.org>

The interconnect framework is designed to provide a
standard kernel interface to control the settings of
the interconnects on a SoC.

The interconnect API uses a consumer/provider-based model,
where the providers are the interconnect buses and the
consumers could be various drivers.

MDSS is one of the interconnect consumers which uses the
interconnect APIs to get the path between endpoints and
set its bandwidth requirement for the given interconnected
path.

Changes in v2:
	- Remove error log and unnecessary check (Jordan Crouse)

Changes in v3:
	- Code clean involving variable name change, removal
	  of extra paranthesis and variables (Matthias Kaehlcke)

Changes in v4:
	- Add comments, spacings, tabs, proper port name
	  and icc macro (Georgi Djakov)

Changes in v5:
	- Commit text and parenthesis alignment (Georgi Djakov)

Signed-off-by: Sravanthi Kollukuduru <skolluku@codeaurora.org>
Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 49 +++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index 38576f8..b8fb197 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -4,11 +4,15 @@
  */
 
 #include "dpu_kms.h"
+#include <linux/interconnect.h>
 
 #define to_dpu_mdss(x) container_of(x, struct dpu_mdss, base)
 
 #define HW_INTR_STATUS			0x0010
 
+/* Max BW defined in KBps */
+#define MAX_BW				6800000
+
 struct dpu_mdss {
 	struct msm_mdss base;
 	void __iomem *mmio;
@@ -16,8 +20,30 @@ struct dpu_mdss {
 	u32 hwversion;
 	struct dss_module_power mp;
 	struct dpu_irq_controller irq_controller;
+	struct icc_path *path[2];
+	u32 num_paths;
 };
 
+static int dpu_mdss_parse_data_bus_icc_path(struct drm_device *dev,
+						struct dpu_mdss *dpu_mdss)
+{
+	struct icc_path *path0 = of_icc_get(dev->dev, "mdp0-mem");
+	struct icc_path *path1 = of_icc_get(dev->dev, "mdp1-mem");
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
@@ -127,7 +153,11 @@ static int dpu_mdss_enable(struct msm_mdss *mdss)
 {
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
-	int ret;
+	int ret, i;
+	u64 avg_bw = dpu_mdss->num_paths ? MAX_BW / dpu_mdss->num_paths : 0;
+
+	for (i = 0; i < dpu_mdss->num_paths; i++)
+		icc_set(dpu_mdss->path[i], avg_bw, kBps_to_icc(MAX_BW));
 
 	ret = msm_dss_enable_clk(mp->clk_config, mp->num_clk, true);
 	if (ret)
@@ -140,12 +170,15 @@ static int dpu_mdss_disable(struct msm_mdss *mdss)
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
 
@@ -155,6 +188,7 @@ static void dpu_mdss_destroy(struct drm_device *dev)
 	struct msm_drm_private *priv = dev->dev_private;
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(priv->mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
+	int i;
 
 	pm_runtime_disable(dev->dev);
 	_dpu_mdss_irq_domain_fini(dpu_mdss);
@@ -162,6 +196,9 @@ static void dpu_mdss_destroy(struct drm_device *dev)
 	msm_dss_put_clk(mp->clk_config, mp->num_clk);
 	devm_kfree(&pdev->dev, mp->clk_config);
 
+	for (i = 0; i < dpu_mdss->num_paths; i++)
+		icc_put(dpu_mdss->path[i]);
+
 	if (dpu_mdss->mmio)
 		devm_iounmap(&pdev->dev, dpu_mdss->mmio);
 	dpu_mdss->mmio = NULL;
@@ -200,6 +237,10 @@ int dpu_mdss_init(struct drm_device *dev)
 	}
 	dpu_mdss->mmio_len = resource_size(res);
 
+	ret = dpu_mdss_parse_data_bus_icc_path(dev, dpu_mdss);
+	if (ret)
+		return ret;
+
 	mp = &dpu_mdss->mp;
 	ret = msm_dss_parse_clock(pdev, mp);
 	if (ret) {
@@ -221,14 +262,14 @@ int dpu_mdss_init(struct drm_device *dev)
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

