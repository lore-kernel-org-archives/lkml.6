Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03ACC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6362177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298193;
	bh=0DwkacJSQLsl7OMXToQxSJNUHCLSN5+xRXA6+RBFSzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DeTjtZgA6zPsbMcYnDNrtJx/53v3p7vkyMht8NEZOaVSGXtrUM/mVpxZv2yXg6AeK
	 BBvlIk9MNEY8K20ZWslsUs6SsLt1MG/DbOAPU5IbCOZG88jT3M3So7MR/GSJXevCHR
	 27Qs+/ErXN7S7mR3cckJkcA8SgL5drDhdgVHkEYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbeLTJ3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732790AbeLTJ3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3784320989;
        Thu, 20 Dec 2018 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298188;
        bh=0DwkacJSQLsl7OMXToQxSJNUHCLSN5+xRXA6+RBFSzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFnIdD8gA/17BgU+u8B4izZQgkAhirNT+9kzImm5ZhBzLeIod7DKqQvRHUrNlI2Ht
         gBOkLM0//S1uOCSz8YQW1efUxsrKSknt0u6Bym/oQjcnMkZAdtUhlB9PMgB9vr4Aok
         kdQpsYKHX27xblXjo6I3s25kAGhW7SAUgP3Ke87c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/67] drm/msm/hdmi: Enable HPD after HDMI IRQ is set up
Date:   Thu, 20 Dec 2018 10:18:45 +0100
Message-Id: <20181220085904.853407407@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ee4456359640defe3f51cc6b728bfce4bc444c9e ]

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
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c           |  6 ++++++
 drivers/gpu/drm/msm/hdmi/hdmi.h           |  1 +
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c | 10 ++--------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index c79659ca5706..33e083f71a17 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -332,6 +332,12 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
 		goto fail;
 	}
 
+	ret = msm_hdmi_hpd_enable(hdmi->connector);
+	if (ret < 0) {
+		DRM_DEV_ERROR(&hdmi->pdev->dev, "failed to enable HPD: %d\n", ret);
+		goto fail;
+	}
+
 	encoder->bridge = hdmi->bridge;
 
 	priv->bridges[priv->num_bridges++]       = hdmi->bridge;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index accc9a61611d..5c5df6ab2a57 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -245,6 +245,7 @@ void msm_hdmi_bridge_destroy(struct drm_bridge *bridge);
 
 void msm_hdmi_connector_irq(struct drm_connector *connector);
 struct drm_connector *msm_hdmi_connector_init(struct hdmi *hdmi);
+int msm_hdmi_hpd_enable(struct drm_connector *connector);
 
 /*
  * i2c adapter for ddc:
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_connector.c b/drivers/gpu/drm/msm/hdmi/hdmi_connector.c
index e9c9a0af508e..30e908dfded7 100644
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
2.19.1



