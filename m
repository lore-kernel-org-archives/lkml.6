Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC16FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925BF2462D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925BF2462D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeGCUdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:33:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752620AbeGCUcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:32:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1132181A4EAD;
        Tue,  3 Jul 2018 20:32:21 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32D90111CA17;
        Tue,  3 Jul 2018 20:32:18 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Archit Taneja <architt@codeaurora.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Set DRIVER_ATOMIC cap earlier to fix debugfs
Date:   Tue,  3 Jul 2018 16:31:41 -0400
Message-Id: <20180703203144.24785-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 03 Jul 2018 20:32:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 03 Jul 2018 20:32:21 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently nouveau doesn't actually expose the state debugfs file that's
usually provided for any modesetting driver that supports atomic, even
if nouveau is loaded with atomic=1. This is due to the fact that the
standard debugfs files that DRM creates for atomic drivers is called
when drm_get_pci_dev() is called from nouveau_drm.c. This happens well
before we've initialized the display core, which is currently
responsible for setting the DRIVER_ATOMIC cap.

So, move the atomic option into nouveau_drm.c and just add the
DRIVER_ATOMIC cap whenever it's enabled on the kernel commandline. This
shouldn't cause any actual issues, as the atomic ioctl will still fail
as expected even if the display core doesn't disable it until later in
the init sequence. This also provides the added benefit of being able to
use the state debugfs file to check the current display state even if
clients aren't allowed to modify it through anything other than the
legacy ioctls.

Additionally, disable the DRIVER_ATOMIC cap in nv04's display core, as
this was already disabled there previously.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/dispnv04/disp.c | 3 +++
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 6 ------
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 7 +++++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/disp.c b/drivers/gpu/drm/nouveau/dispnv04/disp.c
index 501d2d290e9c..70dce544984e 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/disp.c
@@ -55,6 +55,9 @@ nv04_display_create(struct drm_device *dev)
 	nouveau_display(dev)->init = nv04_display_init;
 	nouveau_display(dev)->fini = nv04_display_fini;
 
+	/* Pre-nv50 doesn't support atomic, so don't expose the ioctls */
+	dev->driver->driver_features &= ~DRIVER_ATOMIC;
+
 	nouveau_hw_save_vga_fonts(dev, 1);
 
 	nv04_crtc_create(dev, 0);
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 9382e99a0bc7..d9da69c83ae7 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2126,10 +2126,6 @@ nv50_display_destroy(struct drm_device *dev)
 	kfree(disp);
 }
 
-MODULE_PARM_DESC(atomic, "Expose atomic ioctl (default: disabled)");
-static int nouveau_atomic = 0;
-module_param_named(atomic, nouveau_atomic, int, 0400);
-
 int
 nv50_display_create(struct drm_device *dev)
 {
@@ -2154,8 +2150,6 @@ nv50_display_create(struct drm_device *dev)
 	disp->disp = &nouveau_display(dev)->disp;
 	dev->mode_config.funcs = &nv50_disp_func;
 	dev->driver->driver_features |= DRIVER_PREFER_XBGR_30BPP;
-	if (nouveau_atomic)
-		dev->driver->driver_features |= DRIVER_ATOMIC;
 
 	/* small shared memory area we use for notifiers and semaphores */
 	ret = nouveau_bo_new(&drm->client, 4096, 0x1000, TTM_PL_FLAG_VRAM,
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 775443c9af94..0452b18d36b9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -81,6 +81,10 @@ MODULE_PARM_DESC(modeset, "enable driver (default: auto, "
 int nouveau_modeset = -1;
 module_param_named(modeset, nouveau_modeset, int, 0400);
 
+MODULE_PARM_DESC(atomic, "Expose atomic ioctl (default: disabled)");
+static int nouveau_atomic = 0;
+module_param_named(atomic, nouveau_atomic, int, 0400);
+
 MODULE_PARM_DESC(runpm, "disable (0), force enable (1), optimus only default (-1)");
 static int nouveau_runtime_pm = -1;
 module_param_named(runpm, nouveau_runtime_pm, int, 0400);
@@ -509,6 +513,9 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
+	if (nouveau_atomic)
+		driver_pci.driver_features |= DRIVER_ATOMIC;
+
 	ret = drm_get_pci_dev(pdev, pent, &driver_pci);
 	if (ret) {
 		nvkm_device_del(&device);
-- 
2.17.1

