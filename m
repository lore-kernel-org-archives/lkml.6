Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6508ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEE720862
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS5MvYbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEE720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbeGSQpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:45:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40398 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbeGSQph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:45:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so4151704pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4FXtzkzJQMVN2arH9YAZRuhMUvsF+J5FY+L94CQLmQk=;
        b=vS5MvYbdTyCqpk8ButDpawdazfxEVCWtKt4rZkzsMpXUQ3jVSE+wPQ39Wfm0/hBnN2
         Fq4lHewX4fxuo4//pDnrTDpgB3adipjmKKu41uD8SbSnszlvjF5aA36LUhtgWgU05G3u
         fc7BfBI7DvHK18Cq4VhJ4VncYIcCNOw9oNwdy7s9VOjsQ3T7GALrhpgPLzP9R2WtqLAZ
         7+me2UmNL2EC5l3ptCxa9FU9Ecqo5DAqInecCewNuSs3OLGy3ucsoqB63tieWMUnOPLQ
         5Ciq65ewtJD9zCODvOEA2p4QRE+lUSIxQhcGLXlYsqL53ytcaUb6ZzhatjdDXNgeLPEd
         olgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4FXtzkzJQMVN2arH9YAZRuhMUvsF+J5FY+L94CQLmQk=;
        b=KPO1oozUTsuqnymzxE0erfIqzCT6JER5II7isX15NO6+oInrVSpdH0Jq0lfBDbwtjd
         Wl5796j8YKgtgGoGW4pYSgU0LUMgnfXQwVJ70YWOJpX2zuDtYutDdnMbll2PRcpvG3ZS
         V+LBivCtp4YZpOIoVE3tyKb393+x0ppQPda7LHEMlwiofMvq4plcCSWDINYK40krco1M
         Pf8JCHyHZs0gkLwqSgX7r3ykoqSWaZwwE8is02XONQ/6kL+DcF0TfJ7Z8gPfAI6mUSdh
         dccLGopLCybsZYeU6Uwss7NRgtKfOiu6KjiAq6caTz04Osoz36q17JZ+ftBCOvUvZ4MW
         OhYw==
X-Gm-Message-State: AOUpUlGhS30eVDRHkUz8LnojaeMCe0s5zubb2ul27wfJy08KnRbcT431
        x+DNprdGB2piwH3xvOUDaSg=
X-Google-Smtp-Source: AAOMgpfFnsqpG6Ybamea+epN4yWQ0QLSaRv5u/oYd51OGxOIqkkO2z01bx2hey+qoPwIXDhX8zvVTw==
X-Received: by 2002:a63:8648:: with SMTP id x69-v6mr10603407pgd.172.1532016107359;
        Thu, 19 Jul 2018 09:01:47 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.19.142])
        by smtp.gmail.com with ESMTPSA id p3-v6sm9709897pfo.130.2018.07.19.09.01.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 09:01:46 -0700 (PDT)
Date:   Thu, 19 Jul 2018 21:34:26 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
        kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
        airlied@linux.ie, noralf@tronnes.org, jrdr.linux@gmail.com,
        seanpaul@chromium.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ajitn.linux@gmail.com, sabyasachi.linux@gmail.com,
        brajeswar.linux@gmail.com, daniel@ffwll.ch
Subject: [PATCH] gpu/drm/hisilicon: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180719160426.GA21958@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert drm_atomic_helper_suspend/resume() to use
drm_mode_config_helper_suspend/resume().

Fixed one sparse warning by making hibmc_drm_interrupt
static.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index d4f6f1f..2261676 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -37,7 +37,7 @@
 	.llseek		= no_llseek,
 };
 
-irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
+static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
 {
 	struct drm_device *dev = (struct drm_device *)arg;
 	struct hibmc_drm_private *priv =
@@ -74,30 +74,22 @@ static int __maybe_unused hibmc_pm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct hibmc_drm_private *priv = drm_dev->dev_private;
-
-	drm_kms_helper_poll_disable(drm_dev);
-	priv->suspend_state = drm_atomic_helper_suspend(drm_dev);
-	if (IS_ERR(priv->suspend_state)) {
-		DRM_ERROR("drm_atomic_helper_suspend failed: %ld\n",
-			  PTR_ERR(priv->suspend_state));
-		drm_kms_helper_poll_enable(drm_dev);
-		return PTR_ERR(priv->suspend_state);
-	}
+	int ret = 0;
 
-	return 0;
+	ret = drm_mode_config_helper_suspend(drm_dev);
+
+	return ret;
 }
 
 static int  __maybe_unused hibmc_pm_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct hibmc_drm_private *priv = drm_dev->dev_private;
+	int ret = 0;
 
-	drm_atomic_helper_resume(drm_dev, priv->suspend_state);
-	drm_kms_helper_poll_enable(drm_dev);
+	ret = drm_mode_config_helper_resume(drm_dev);
 
-	return 0;
+	return ret;
 }
 
 static const struct dev_pm_ops hibmc_pm_ops = {
-- 
1.9.1

