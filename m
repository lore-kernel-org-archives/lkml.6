Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FD1206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="YojAra6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FD1206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lekensteyn.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeIGCzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:55:54 -0400
Received: from lekensteyn.nl ([178.21.112.251]:43867 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbeIGCzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=lSXHIIm08sX+DLOT0s3Q3Stk+e7eJ/LJ+4f5flmRGBo=;
        b=YojAra6RWDf/XVI3uH5Y+X3loSnaM9VWpMXhT8tT1ODF/Fcyf8y3VfcQSwhAoap1h79sccwGXZqp9lSOv9pfDp0Hjac0GNl8iR8+sd96/HAKnHLoEObMi2lEQzncEKe9vdofq3fYnGbHISu3bGvQ1sJfmBtA4TuymNmoHgsk+1vTB/P7qAb4cY66QeO1aYvVtlcyS+ctoh2qoFzFgDAntMAgkDFIqzOqHead978X1m65kwDJScIPljHZapPLKD2/Z071jIda/zq7h8zGuSMcEcwJTiUzebmmldFyYZlye/G5TaLeRkYAOuA3LZJthMHStbRdE26fvpnu3iE1kC/gFg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1fy2bN-0005Us-V4; Fri, 07 Sep 2018 00:18:14 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] bochs: convert to drm_dev_register
Date:   Fri,  7 Sep 2018 00:18:09 +0200
Message-Id: <20180906221810.20170-4-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906221810.20170-1-peter@lekensteyn.nl>
References: <20180906221810.20170-1-peter@lekensteyn.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_get_pci_dev API is deprecated, replace it by drm_dev_register.

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 drivers/gpu/drm/bochs/bochs.h     |  2 +-
 drivers/gpu/drm/bochs/bochs_drv.c | 34 +++++++++++++++++++++++++------
 drivers/gpu/drm/bochs/bochs_hw.c  |  2 +-
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 8514a84fbdbe..b4f6bb521900 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -117,7 +117,7 @@ static inline u64 bochs_bo_mmap_offset(struct bochs_bo *bo)
 /* ---------------------------------------------------------------------- */
 
 /* bochs_hw.c */
-int bochs_hw_init(struct drm_device *dev, uint32_t flags);
+int bochs_hw_init(struct drm_device *dev);
 void bochs_hw_fini(struct drm_device *dev);
 
 void bochs_hw_setmode(struct bochs_device *bochs,
diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 0e79d9acf89e..f3dd66ae990a 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -35,7 +35,7 @@ static void bochs_unload(struct drm_device *dev)
 	dev->dev_private = NULL;
 }
 
-static int bochs_load(struct drm_device *dev, unsigned long flags)
+static int bochs_load(struct drm_device *dev)
 {
 	struct bochs_device *bochs;
 	int ret;
@@ -46,7 +46,7 @@ static int bochs_load(struct drm_device *dev, unsigned long flags)
 	dev->dev_private = bochs;
 	bochs->dev = dev;
 
-	ret = bochs_hw_init(dev, flags);
+	ret = bochs_hw_init(dev);
 	if (ret)
 		goto err;
 
@@ -82,8 +82,6 @@ static const struct file_operations bochs_fops = {
 
 static struct drm_driver bochs_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET,
-	.load			= bochs_load,
-	.unload			= bochs_unload,
 	.fops			= &bochs_fops,
 	.name			= "bochs-drm",
 	.desc			= "bochs dispi vga interface (qemu stdvga)",
@@ -138,6 +136,7 @@ static const struct dev_pm_ops bochs_pm_ops = {
 static int bochs_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
+	struct drm_device *dev;
 	unsigned long fbsize;
 	int ret;
 
@@ -151,14 +150,37 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	return drm_get_pci_dev(pdev, ent, &bochs_driver);
+	dev = drm_dev_alloc(&bochs_driver, &pdev->dev);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	dev->pdev = pdev;
+	pci_set_drvdata(pdev, dev);
+
+	ret = bochs_load(dev);
+	if (ret)
+		goto err_free_dev;
+
+	ret = drm_dev_register(dev, 0);
+	if (ret)
+		goto err_unload;
+
+	return ret;
+
+err_unload:
+	bochs_unload(dev);
+err_free_dev:
+	drm_dev_put(dev);
+	return ret;
 }
 
 static void bochs_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
-	drm_put_dev(dev);
+	drm_dev_unregister(dev);
+	bochs_unload(dev);
+	drm_dev_put(dev);
 }
 
 static const struct pci_device_id bochs_pci_tbl[] = {
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index a39b0343c197..16e4f1caccca 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -47,7 +47,7 @@ static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
 	}
 }
 
-int bochs_hw_init(struct drm_device *dev, uint32_t flags)
+int bochs_hw_init(struct drm_device *dev)
 {
 	struct bochs_device *bochs = dev->dev_private;
 	struct pci_dev *pdev = dev->pdev;
-- 
2.18.0

