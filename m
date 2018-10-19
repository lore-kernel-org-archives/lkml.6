Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDCDECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003852064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003852064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJSWW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:22:58 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:33050 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbeJSWW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:22:58 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 18:22:57 EDT
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id A25E4CE26;
        Fri, 19 Oct 2018 17:07:38 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     robdclark@gmail.com, linux-kernel@vger.kernel.org,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH] drm/msm/hdmi: Enable HPD after HDMI IRQ is set up
Date:   Fri, 19 Oct 2018 17:07:22 +0300
Message-Id: <1539958042-28612-1-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoCs that contain MDP5 have a top level wrapper called MDSS that
manages locks, power and irq for the sub-blocks within it.

Irq for HDMI is also routed through the MDSS.

Shortly after the Hot Plug Detection (HPD) is enabled in HDMI,
HDMI interrupts are recieved by the MDSS interrupt handler.
However at this moment the HDMI irq is still not mapped to
the MDSS irq domain so the HDMI irq handler cannot be called
to process the interrupts.

This leads to a flood of HDMI interrupts on CPU 0.

If we are lucky to have the HDMI initialization running on a
different CPU, it will eventually map the HDMI irq to MDSS irq
domain, the next HDMI interrupt will be handled by the HDMI irq
handler, the interrupt flood will stop and we will recover.

If the HDMI initialization is running on CPU 0, then it cannot
complete and there is nothing to stop the interrupt flood on
CPU 0. The system is stuck.

Fix this by moving the HPD enablement after the HDMI irq is
mapped to the MDSS irq domain.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c           |  6 ++++++
 drivers/gpu/drm/msm/hdmi/hdmi.h           |  1 +
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c | 10 ++--------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index c79659c..e74df38 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -332,6 +332,12 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
 		goto fail;
 	}
 
+	ret = msm_hdmi_hpd_enable(hdmi->connector);
+	if (ret < 0) {
+		dev_err(&hdmi->pdev->dev, "failed to enable HPD: %d\n", ret);
+		goto fail;
+	}
+
 	encoder->bridge = hdmi->bridge;
 
 	priv->bridges[priv->num_bridges++]       = hdmi->bridge;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index accc9a6..5c5df6a 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -245,6 +245,7 @@ void msm_hdmi_bridge_destroy(struct drm_bridge *bridge);
 
 void msm_hdmi_connector_irq(struct drm_connector *connector);
 struct drm_connector *msm_hdmi_connector_init(struct hdmi *hdmi);
+int msm_hdmi_hpd_enable(struct drm_connector *connector);
 
 /*
  * i2c adapter for ddc:
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_connector.c b/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
index e9c9a0a..30e908d 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
@@ -167,8 +167,9 @@ static void enable_hpd_clocks(struct hdmi *hdmi, bool enable)
 	}
 }
 
-static int hpd_enable(struct hdmi_connector *hdmi_connector)
+int msm_hdmi_hpd_enable(struct drm_connector *connector)
 {
+	struct hdmi_connector *hdmi_connector = to_hdmi_connector(connector);
 	struct hdmi *hdmi = hdmi_connector->hdmi;
 	const struct hdmi_platform_config *config = hdmi->config;
 	struct device *dev = &hdmi->pdev->dev;
@@ -450,7 +451,6 @@ struct drm_connector *msm_hdmi_connector_init(struct hdmi *hdmi)
 {
 	struct drm_connector *connector = NULL;
 	struct hdmi_connector *hdmi_connector;
-	int ret;
 
 	hdmi_connector = kzalloc(sizeof(*hdmi_connector), GFP_KERNEL);
 	if (!hdmi_connector)
@@ -471,12 +471,6 @@ struct drm_connector *msm_hdmi_connector_init(struct hdmi *hdmi)
 	connector->interlace_allowed = 0;
 	connector->doublescan_allowed = 0;
 
-	ret = hpd_enable(hdmi_connector);
-	if (ret) {
-		dev_err(&hdmi->pdev->dev, "failed to enable HPD: %d\n", ret);
-		return ERR_PTR(ret);
-	}
-
 	drm_connector_attach_encoder(connector, hdmi->encoder);
 
 	return connector;
-- 
2.7.4

