Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BDDC46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BBD21723
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmsc+L03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BBD21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbeHHSeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:34:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45472 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbeHHSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:34:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so1361211pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kWbgqFWnf7rarNatQL16OW5agW56H2KnxyqqbjZLOvs=;
        b=nmsc+L03OaBFKM8fm6mRFyebJM70CJYrRU3sykv2FYtNv2+C4SsxoXg/mUZCpYP+bd
         iOrdWetR76b25cPsSlcAc3Drk3jYQtiTFBQ/DsmWlXfxmf4fiPjN8OoATyVUG0lVgO4A
         Xef03ovDmLUvjSslJkZiMsqKjFRuPN6dLdFoFO0WgIB9tfEHzkRsjPe9bmupH0+WYDps
         i/8Ub7TWTTZqEGRFG07wwU9ByXnIRbjS83i3UNoEcUPg18oq6Su/ssvaTLrqKjIOkcQZ
         Td+9QO8xIExNzl+8frXynTKsXtNgHhoSCgmyOBfvbBKjnBEHCfqPX0ioMyr68u4eg2Yz
         SgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kWbgqFWnf7rarNatQL16OW5agW56H2KnxyqqbjZLOvs=;
        b=iGRv/rsTDmnwE6PY0tb5fS81/CfJasUIORgXZd9lUzRWCYJY9Fl0J9ARWxgkRQgZ+h
         SCZ3xaxAwZmHTY3eEbVCsCshglsO1mJ9CUV9tSBQux6ydrFpzV+liJWMCEgX1XHCjH3R
         tcPstmjG48Veaam9WJt00e6jeHjm3zFpd2juBy0wa8Ji8ly9tlVg/vZI3WvthzT6RWdj
         3iqtKqMeFXVB4w7QWQTvxN5TxiSsOFh3tpJ8q1eB/h+VX+O8TdzJrg7ePS4Mo+eJh4Es
         F1liAYDRM4mv6LEILpKpmqd2OkSYs0qJHRZdQj3j1++C/uhNc47Q8UIVf65tWPLDu1rs
         0rKw==
X-Gm-Message-State: AOUpUlFuQNexry7rRpZpvpI0+DDt6NLNtWCHP6Tq8c7eDlA8XxKSpdaa
        m6IS/5q1kHZyQXWE8pEe4do=
X-Google-Smtp-Source: AA+uWPxCYbGgJUrswKl5/yspqrX+FuVDek91z9RIZQ6fLCtYD9j2yRelC/q/a3LQ/BRUevNrH42VaA==
X-Received: by 2002:a62:1647:: with SMTP id 68-v6mr3646958pfw.6.1533744832129;
        Wed, 08 Aug 2018 09:13:52 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.217.252])
        by smtp.gmail.com with ESMTPSA id t19-v6sm13144752pfk.182.2018.08.08.09.13.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 09:13:50 -0700 (PDT)
Date:   Wed, 8 Aug 2018 21:46:41 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jsarha@ti.com, tomi.valkeinen@ti.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ajitn.linux@gmail.com
Subject: [PATCH] drm/tilcdc: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180808161641.GA20483@jordon-HP-15-Notebook-PC>
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

saved_state in tilcdc_drm_private will not be used
anymore, so it can be removed.

Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 14 ++++----------
 drivers/gpu/drm/tilcdc/tilcdc_drv.h |  3 ---
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 0fb300d..33e5332 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -554,29 +554,23 @@ static int tilcdc_debugfs_init(struct drm_minor *minor)
 static int tilcdc_pm_suspend(struct device *dev)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct tilcdc_drm_private *priv = ddev->dev_private;
+	int ret = 0;
 
-	priv->saved_state = drm_atomic_helper_suspend(ddev);
+	ret = drm_mode_config_helper_suspend(ddev);
 
 	/* Select sleep pin state */
 	pinctrl_pm_select_sleep_state(dev);
 
-	return 0;
+	return ret;
 }
 
 static int tilcdc_pm_resume(struct device *dev)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct tilcdc_drm_private *priv = ddev->dev_private;
-	int ret = 0;
 
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(dev);
-
-	if (priv->saved_state)
-		ret = drm_atomic_helper_resume(ddev, priv->saved_state);
-
-	return ret;
+	return  drm_mode_config_helper_resume(ddev);
 }
 #endif
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
index ead5122..62cea5f 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
@@ -70,9 +70,6 @@ struct tilcdc_drm_private {
 	const uint32_t *pixelformats;
 	uint32_t num_pixelformats;
 
-	/* The context for pm susped/resume cycle is stored here */
-	struct drm_atomic_state *saved_state;
-
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block freq_transition;
 #endif
-- 
1.9.1

