Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DB1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D269A208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="vedlbywg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D269A208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeJQAAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:00:45 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49158 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJQAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:00:45 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id BEC295C1A11;
        Tue, 16 Oct 2018 18:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1539706174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=SGXyMQ5/DtOOwjZl44CAeyFtnrIHtnC7vul8IkTwp2k=;
        b=vedlbywgB0cCDJEiE7IQMXfihEncYD/TIa9/U6HajoyYO46vkRVM1qF2GG1ok1zvsEPhBf
        z1F83oUcIn16XF0+h0l2tt6TCp9K1gz2ymU47889wSf8xv/aeXCmCaL8ROUnWjL4ZcWRQk
        hlAocbbCCfK7M9rRelGG92ANHRPI+ZU=
From:   Stefan Agner <stefan@agner.ch>
To:     p.zabel@pengutronix.de
Cc:     airlied@linux.ie, rmk+kernel@armlinux.org.uk,
        l.stach@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] Revert "drm/imx: don't destroy mode objects manually on driver unbind"
Date:   Tue, 16 Oct 2018 18:09:23 +0200
Message-Id: <20181016160923.2042-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8e3b16e2117409625b89807de3912ff773aea354.

Using the component framework requires all components to undo in
->unbind what ->bind does. Unfortunately that particular commit
broke this rule. In particular, this is an issue if a single
component during probe fails. In that case, component_bind_all()
calls unbind on already succussfully bound components, and then
frees memory allocated using devm. If one of those components
registered e.g. an encoder with the framework then this leads to
use after free situations.

Revert the commit to ensure that all components properly undo
what ->bind does.

Link: https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg233327.html
Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/imx/imx-drm-core.c     | 4 ++--
 drivers/gpu/drm/imx/imx-ldb.c          | 6 ++++++
 drivers/gpu/drm/imx/imx-tve.c          | 3 +++
 drivers/gpu/drm/imx/parallel-display.c | 3 +++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 5ea0c82f9957..caa6061a98ba 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -305,11 +305,11 @@ static void imx_drm_unbind(struct device *dev)
 
 	drm_fb_cma_fbdev_fini(drm);
 
-	drm_mode_config_cleanup(drm);
-
 	component_unbind_all(drm->dev, drm);
 	dev_set_drvdata(dev, NULL);
 
+	drm_mode_config_cleanup(drm);
+
 	drm_dev_put(drm);
 }
 
diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index 3bd0f8a18e74..592aabc4a262 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -723,6 +723,12 @@ static void imx_ldb_unbind(struct device *dev, struct device *master,
 		if (channel->panel)
 			drm_panel_detach(channel->panel);
 
+		if (!channel->connector.funcs)
+			continue;
+
+		channel->connector.funcs->destroy(&channel->connector);
+		channel->encoder.funcs->destroy(&channel->encoder);
+
 		kfree(channel->edid);
 		i2c_put_adapter(channel->ddc);
 	}
diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index cffd3310240e..8d6e89ce1edb 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -673,6 +673,9 @@ static void imx_tve_unbind(struct device *dev, struct device *master,
 {
 	struct imx_tve *tve = dev_get_drvdata(dev);
 
+	tve->connector.funcs->destroy(&tve->connector);
+	tve->encoder.funcs->destroy(&tve->encoder);
+
 	if (!IS_ERR(tve->dac_reg))
 		regulator_disable(tve->dac_reg);
 }
diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index aefd04e18f93..6f11bffcde37 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -258,6 +258,9 @@ static void imx_pd_unbind(struct device *dev, struct device *master,
 	if (imxpd->panel)
 		drm_panel_detach(imxpd->panel);
 
+	imxpd->encoder.funcs->destroy(&imxpd->encoder);
+	imxpd->connector.funcs->destroy(&imxpd->connector);
+
 	kfree(imxpd->edid);
 }
 
-- 
2.19.1

