Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965450AbeBMSD3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:03:29 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32992 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965158AbeBMSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:03:27 -0500
X-Google-Smtp-Source: AH8x224JEMtvJjDrz4rP7x46UdIzx9Ip/ZW3ZDCHpzzyh/FzXKKPW3fV5BpPRwec2ABDTSQ1uFZwTg==
From: Mathieu Malaterre <malat@debian.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] Fix loading of module radeonfb on PowerMac
Date: Tue, 13 Feb 2018 19:03:16 +0100
Message-Id: <20180213180316.11934-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the linux kernel is build with (typical kernel ship with Debian
installer):

CONFIG_FB=y
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
possible to load radeonfb when offb is first loaded, see
commit a56f7428d753 ("drm/radeon: Add early unregister of firmware fb's").

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
v5: do not use drm_fb_helper_remove_conflicting_framebuffers from drm_fb_helper
    remove ifdef hacks since not needed once framebuffer is properly decremented

 drivers/video/fbdev/aty/radeon_base.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 87608c0b2351..e8594bbaea60 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2255,6 +2255,23 @@ static const struct bin_attribute edid2_attr = {
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
+	remove_conflicting_framebuffers(ap, KBUILD_MODNAME, false);
+
+	kfree(ap);
+
+	return 0;
+}
 
 static int radeonfb_pci_register(struct pci_dev *pdev,
 				 const struct pci_device_id *ent)
@@ -2308,6 +2325,10 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
 	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
 
+	ret = radeon_kick_out_firmware_fb(pdev);
+	if (ret)
+		return ret;
+
 	/* request the mem regions */
 	ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
 	if (ret < 0) {
-- 
2.11.0
