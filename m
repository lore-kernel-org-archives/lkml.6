Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBF9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03501208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03501208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeHWFHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 01:07:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727468AbeHWFHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 01:07:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16F5E7A7E7;
        Thu, 23 Aug 2018 01:40:20 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-163.rdu2.redhat.com [10.10.124.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A995110D18CB;
        Thu, 23 Aug 2018 01:40:19 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/nouveau: Start using new drm_dev initialization helpers
Date:   Wed, 22 Aug 2018 21:40:07 -0400
Message-Id: <20180823014009.21532-3-lyude@redhat.com>
In-Reply-To: <20180823014009.21532-1-lyude@redhat.com>
References: <20180823014009.21532-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 23 Aug 2018 01:40:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 23 Aug 2018 01:40:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the documentation in drm_get_pci_dev(), this function is deprecated
and shouldn't be used anymore. As it turns out, we're going to need to
stop using drm_get_pci_dev() anyway in order to allow us to turn off the
card before full system shutdowns, otherwise we'll hit race conditions
with userspace while trying to tear down the card on shutdown.

So, start using drm_dev_get() and drm_dev_put(), and just turn our
load/unload callbacks into open coded init/fini() functions.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 173 +++++++++++++++-----------
 1 file changed, 101 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 6c88ff776ff6..b88b338dc79c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -458,75 +458,8 @@ nouveau_accel_init(struct nouveau_drm *drm)
 	nouveau_bo_move_init(drm);
 }
 
-static int nouveau_drm_probe(struct pci_dev *pdev,
-			     const struct pci_device_id *pent)
-{
-	struct nvkm_device *device;
-	struct apertures_struct *aper;
-	bool boot = false;
-	int ret;
-
-	if (vga_switcheroo_client_probe_defer(pdev))
-		return -EPROBE_DEFER;
-
-	/* We need to check that the chipset is supported before booting
-	 * fbdev off the hardware, as there's no way to put it back.
-	 */
-	ret = nvkm_device_pci_new(pdev, NULL, "error", true, false, 0, &device);
-	if (ret)
-		return ret;
-
-	nvkm_device_del(&device);
-
-	/* Remove conflicting drivers (vesafb, efifb etc). */
-	aper = alloc_apertures(3);
-	if (!aper)
-		return -ENOMEM;
-
-	aper->ranges[0].base = pci_resource_start(pdev, 1);
-	aper->ranges[0].size = pci_resource_len(pdev, 1);
-	aper->count = 1;
-
-	if (pci_resource_len(pdev, 2)) {
-		aper->ranges[aper->count].base = pci_resource_start(pdev, 2);
-		aper->ranges[aper->count].size = pci_resource_len(pdev, 2);
-		aper->count++;
-	}
-
-	if (pci_resource_len(pdev, 3)) {
-		aper->ranges[aper->count].base = pci_resource_start(pdev, 3);
-		aper->ranges[aper->count].size = pci_resource_len(pdev, 3);
-		aper->count++;
-	}
-
-#ifdef CONFIG_X86
-	boot = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
-#endif
-	if (nouveau_modeset != 2)
-		drm_fb_helper_remove_conflicting_framebuffers(aper, "nouveaufb", boot);
-	kfree(aper);
-
-	ret = nvkm_device_pci_new(pdev, nouveau_config, nouveau_debug,
-				  true, true, ~0ULL, &device);
-	if (ret)
-		return ret;
-
-	pci_set_master(pdev);
-
-	if (nouveau_atomic)
-		driver_pci.driver_features |= DRIVER_ATOMIC;
-
-	ret = drm_get_pci_dev(pdev, pent, &driver_pci);
-	if (ret) {
-		nvkm_device_del(&device);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int
-nouveau_drm_load(struct drm_device *dev, unsigned long flags)
+nouveau_drm_device_init(struct drm_device *dev)
 {
 	struct nouveau_drm *drm;
 	int ret;
@@ -615,7 +548,7 @@ nouveau_drm_load(struct drm_device *dev, unsigned long flags)
 }
 
 static void
-nouveau_drm_unload(struct drm_device *dev)
+nouveau_drm_device_fini(struct drm_device *dev)
 {
 	struct nouveau_drm *drm = nouveau_drm(dev);
 
@@ -644,18 +577,116 @@ nouveau_drm_unload(struct drm_device *dev)
 	kfree(drm);
 }
 
+static int nouveau_drm_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *pent)
+{
+	struct nvkm_device *device;
+	struct drm_device *drm_dev;
+	struct apertures_struct *aper;
+	bool boot = false;
+	int ret;
+
+	if (vga_switcheroo_client_probe_defer(pdev))
+		return -EPROBE_DEFER;
+
+	/* We need to check that the chipset is supported before booting
+	 * fbdev off the hardware, as there's no way to put it back.
+	 */
+	ret = nvkm_device_pci_new(pdev, NULL, "error", true, false, 0, &device);
+	if (ret)
+		return ret;
+
+	nvkm_device_del(&device);
+
+	/* Remove conflicting drivers (vesafb, efifb etc). */
+	aper = alloc_apertures(3);
+	if (!aper)
+		return -ENOMEM;
+
+	aper->ranges[0].base = pci_resource_start(pdev, 1);
+	aper->ranges[0].size = pci_resource_len(pdev, 1);
+	aper->count = 1;
+
+	if (pci_resource_len(pdev, 2)) {
+		aper->ranges[aper->count].base = pci_resource_start(pdev, 2);
+		aper->ranges[aper->count].size = pci_resource_len(pdev, 2);
+		aper->count++;
+	}
+
+	if (pci_resource_len(pdev, 3)) {
+		aper->ranges[aper->count].base = pci_resource_start(pdev, 3);
+		aper->ranges[aper->count].size = pci_resource_len(pdev, 3);
+		aper->count++;
+	}
+
+#ifdef CONFIG_X86
+	boot = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
+#endif
+	if (nouveau_modeset != 2)
+		drm_fb_helper_remove_conflicting_framebuffers(aper, "nouveaufb", boot);
+	kfree(aper);
+
+	ret = nvkm_device_pci_new(pdev, nouveau_config, nouveau_debug,
+				  true, true, ~0ULL, &device);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	if (nouveau_atomic)
+		driver_pci.driver_features |= DRIVER_ATOMIC;
+
+	drm_dev = drm_dev_alloc(&driver_pci, &pdev->dev);
+	if (IS_ERR(drm_dev)) {
+		ret = PTR_ERR(drm_dev);
+		goto fail_nvkm;
+	}
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		goto fail_drm;
+
+	drm_dev->pdev = pdev;
+	pci_set_drvdata(pdev, drm_dev);
+
+	ret = nouveau_drm_device_init(drm_dev);
+	if (ret)
+		goto fail_pci;
+
+	ret = drm_dev_register(drm_dev, pent->driver_data);
+	if (ret)
+		goto fail_drm_dev_init;
+
+	return 0;
+
+fail_drm_dev_init:
+	nouveau_drm_device_fini(drm_dev);
+fail_pci:
+	pci_disable_device(pdev);
+fail_drm:
+	drm_dev_put(drm_dev);
+fail_nvkm:
+	nvkm_device_del(&device);
+	return ret;
+}
+
 void
 nouveau_drm_device_remove(struct drm_device *dev)
 {
+	struct pci_dev *pdev = dev->pdev;
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvkm_client *client;
 	struct nvkm_device *device;
 
+	drm_dev_unregister(dev);
+
 	dev->irq_enabled = false;
 	client = nvxx_client(&drm->client.base);
 	device = nvkm_device_find(client->device);
-	drm_put_dev(dev);
 
+	nouveau_drm_device_fini(dev);
+	pci_disable_device(pdev);
+	drm_dev_put(dev);
 	nvkm_device_del(&device);
 }
 
@@ -1022,8 +1053,6 @@ driver_stub = {
 		DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME | DRIVER_RENDER |
 		DRIVER_KMS_LEGACY_CONTEXT,
 
-	.load = nouveau_drm_load,
-	.unload = nouveau_drm_unload,
 	.open = nouveau_drm_open,
 	.postclose = nouveau_drm_postclose,
 	.lastclose = nouveau_vga_lastclose,
-- 
2.17.1

