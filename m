Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A576C65BD1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5201214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="IXKnDQxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5201214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJJEtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:49:51 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53196 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJEtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:49:46 -0400
Received: from allenwind.lan (unknown [37.17.239.109])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 300D15C097A;
        Tue,  9 Oct 2018 23:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1539120651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxKES5i8OdqEPY0M+7sSXxnNFq2ypMEHz1LKRg/ZWX8=;
        b=IXKnDQxYRNYsCQ8OJd65+MojUtbqTAobgET+WYt5lfpgiqtBYSEdB1SKTeRUajfeUT3v+x
        QlSp5XQlOy46VIcdAv/A7VjDqBnWVTYVyJT2pp/x+hjfoWg8L/miTxzQ2jW/0Vt5bVsPv7
        /+kjdFzwwq9iGha5oATJ0ELVCnPU6nI=
From:   Stefan Agner <stefan@agner.ch>
To:     p.zabel@pengutronix.de, airlied@linux.ie,
        gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] drm/imx: make sure to cleanup DRM before unbinding components
Date:   Tue,  9 Oct 2018 23:30:49 +0200
Message-Id: <e08eff2ed53b441c8a6c41758c00c1c91dc48d2c.1539120077.git.stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <83a28282a3f745a4cd4ca77d0593ad2e61359a5d.1539120077.git.stefan@agner.ch>
References: <83a28282a3f745a4cd4ca77d0593ad2e61359a5d.1539120077.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In situations where a component fails to bind, a previously
successfully bound component might already registered itself
with the DRM framework (e.g. an encoder). When the master
component then calls drm_mode_config_cleanup, we end up in a
use after free sitution.

Use the cleanup callback to make sure all framework level
cleanup is done by the time we unbind components.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/imx/imx-drm-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 5ea0c82f9957..b174a0ca9acb 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -288,8 +288,8 @@ static int imx_drm_bind(struct device *dev)
 err_unbind:
 #endif
 	component_unbind_all(drm->dev, drm);
-err_kms:
 	drm_mode_config_cleanup(drm);
+err_kms:
 	drm_dev_put(drm);
 
 	return ret;
@@ -313,9 +313,17 @@ static void imx_drm_unbind(struct device *dev)
 	drm_dev_put(drm);
 }
 
+static void imx_drm_cleanup(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	drm_mode_config_cleanup(drm);
+}
+
 static const struct component_master_ops imx_drm_ops = {
 	.bind = imx_drm_bind,
 	.unbind = imx_drm_unbind,
+	.cleanup = imx_drm_cleanup,
 };
 
 static int imx_drm_platform_probe(struct platform_device *pdev)
-- 
2.19.1

