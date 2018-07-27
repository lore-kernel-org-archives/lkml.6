Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADB0C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3536A20894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3536A20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbeG0LXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:23:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbeG0LXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:23:00 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61A4ACB8;
        Fri, 27 Jul 2018 10:01:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.14 07/48] drm/nouveau: Set DRIVER_ATOMIC cap earlier to fix debugfs
Date:   Fri, 27 Jul 2018 11:59:52 +0200
Message-Id: <20180727095919.270447780@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit eb493fbc150f4a28151ae1ee84f24395989f3600 upstream.

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
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/dispnv04/disp.c |    3 +++
 drivers/gpu/drm/nouveau/nouveau_drm.c   |    7 +++++++
 drivers/gpu/drm/nouveau/nv50_display.c  |    6 ------
 3 files changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/nouveau/dispnv04/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/disp.c
@@ -55,6 +55,9 @@ nv04_display_create(struct drm_device *d
 	nouveau_display(dev)->init = nv04_display_init;
 	nouveau_display(dev)->fini = nv04_display_fini;
 
+	/* Pre-nv50 doesn't support atomic, so don't expose the ioctls */
+	dev->driver->driver_features &= ~DRIVER_ATOMIC;
+
 	nouveau_hw_save_vga_fonts(dev, 1);
 
 	nv04_crtc_create(dev, 0);
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -79,6 +79,10 @@ MODULE_PARM_DESC(modeset, "enable driver
 int nouveau_modeset = -1;
 module_param_named(modeset, nouveau_modeset, int, 0400);
 
+MODULE_PARM_DESC(atomic, "Expose atomic ioctl (default: disabled)");
+static int nouveau_atomic = 0;
+module_param_named(atomic, nouveau_atomic, int, 0400);
+
 MODULE_PARM_DESC(runpm, "disable (0), force enable (1), optimus only default (-1)");
 static int nouveau_runtime_pm = -1;
 module_param_named(runpm, nouveau_runtime_pm, int, 0400);
@@ -383,6 +387,9 @@ static int nouveau_drm_probe(struct pci_
 
 	pci_set_master(pdev);
 
+	if (nouveau_atomic)
+		driver_pci.driver_features |= DRIVER_ATOMIC;
+
 	ret = drm_get_pci_dev(pdev, pent, &driver_pci);
 	if (ret) {
 		nvkm_device_del(&device);
--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -4398,10 +4398,6 @@ nv50_display_destroy(struct drm_device *
 	kfree(disp);
 }
 
-MODULE_PARM_DESC(atomic, "Expose atomic ioctl (default: disabled)");
-static int nouveau_atomic = 0;
-module_param_named(atomic, nouveau_atomic, int, 0400);
-
 int
 nv50_display_create(struct drm_device *dev)
 {
@@ -4426,8 +4422,6 @@ nv50_display_create(struct drm_device *d
 	disp->disp = &nouveau_display(dev)->disp;
 	dev->mode_config.funcs = &nv50_disp_func;
 	dev->driver->driver_features |= DRIVER_PREFER_XBGR_30BPP;
-	if (nouveau_atomic)
-		dev->driver->driver_features |= DRIVER_ATOMIC;
 
 	/* small shared memory area we use for notifiers and semaphores */
 	ret = nouveau_bo_new(&drm->client, 4096, 0x1000, TTM_PL_FLAG_VRAM,


