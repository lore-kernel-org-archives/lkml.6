Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeAaHnZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:43:25 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53199 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeAaHnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:43:22 -0500
X-Google-Smtp-Source: AH8x225P5qOp5hWAzRxRgms5b+nGiREk3t46JhzVap06Q/AxpTQM9NE3Ta652fvWx64DsR5XY9aQzw==
From: Mathieu Malaterre <malat@debian.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] Fix loading of module radeonfb on PowerMac
Date: Wed, 31 Jan 2018 08:42:45 +0100
Message-Id: <20180131074245.7306-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171221220757.24672-1-malat@debian.org>
References: <20171221220757.24672-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the linux kernel is build with (typical kernel ship with Debian
installer):

CONFIG_FB_OF=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_FB_RADEON=m

The offb driver takes precedence over module radeonfb. It is then
impossible to load the module, error reported is:

[   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
[   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
[   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
[   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16

This patch reproduce the behavior of the module radeon, so as to make it
possible to load radeonfb when offb is first loaded, see commit a56f7428d753
("drm/radeon: Add early unregister of firmware fb's").

It should be noticed that `offb_destroy` is never called which explain the
need to skip error detection on the radeon side.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Link: https://bugs.debian.org/826629#57
Link: https://bugzilla.kernel.org/show_bug.cgi?id=119741
Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
v2: Only fails when CONFIG_PCC is not set
v3: Only fails when CONFIG_FB_OF is not set, CONFIG_PCC was too broad. Since the conflicts in region is due to OFfb explicitly refers to it.
v4: Use drm_fb_helper_remove_conflicting_framebuffers from drm_fb_helper

 drivers/video/fbdev/aty/radeon_base.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 4d77daeecf99..ae669f424537 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -70,6 +70,7 @@
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
 #include <linux/device.h>
+#include <drm/drm_fb_helper.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -2259,6 +2260,23 @@ static const struct bin_attribute edid2_attr = {
 	.read	= radeon_show_edid2,
 };
 
+static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
+{
+	struct apertures_struct *ap;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return -ENOMEM;
+
+	ap->ranges[0].base = pci_resource_start(pdev, 0);
+	ap->ranges[0].size = pci_resource_len(pdev, 0);
+
+	drm_fb_helper_remove_conflicting_framebuffers(ap, KBUILD_MODNAME, false);
+
+	kfree(ap);
+
+	return 0;
+}
 
 static int radeonfb_pci_register(struct pci_dev *pdev,
 				 const struct pci_device_id *ent)
@@ -2312,19 +2330,27 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
 	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
 
+	ret = radeon_kick_out_firmware_fb(pdev);
+	if (ret)
+		return ret;
+
 	/* request the mem regions */
 	ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
 	if (ret < 0) {
+#ifndef CONFIG_FB_OF
 		printk( KERN_ERR "radeonfb (%s): cannot request region 0.\n",
 			pci_name(rinfo->pdev));
 		goto err_release_fb;
+#endif
 	}
 
 	ret = pci_request_region(pdev, 2, "radeonfb mmio");
 	if (ret < 0) {
+#ifndef CONFIG_FB_OF
 		printk( KERN_ERR "radeonfb (%s): cannot request region 2.\n",
 			pci_name(rinfo->pdev));
 		goto err_release_pci0;
+#endif
 	}
 
 	/* map the regions */
@@ -2509,10 +2535,12 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	iounmap(rinfo->mmio_base);
 err_release_pci2:
 	pci_release_region(pdev, 2);
+#ifndef CONFIG_FB_OF
 err_release_pci0:
 	pci_release_region(pdev, 0);
 err_release_fb:
         framebuffer_release(info);
+#endif
 err_disable:
 err_out:
 	return ret;
-- 
2.11.0
