Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeEROSY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:18:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45988 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEROSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:18:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 408EE601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-fbdev@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Date: Fri, 18 May 2018 10:17:51 -0400
Message-Id: <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A host bridge is allowed to remap BAR addresses using _TRA attribute in
_CRS windows.

pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]

When a VGA device is behind such a host bridge and the resource is
translated efifb driver is trying to do ioremap against bus address
rather than the resource address and is failing to probe.

efifb: probing for efifb
efifb: cannot reserve video memory at 0x1e000000
efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
efifb: mode is 800x600x32, linelength=3200, pages=1
efifb: scrolling: redraw
efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0

Use the host bridge offset information to convert bus address to
resource address in the fixup.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/video/fbdev/efifb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 6daac8d..429cc85 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -431,6 +431,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 		.end = screen_info.lfb_base + screen_info.lfb_size - 1,
 		.flags = IORESOURCE_MEM,
 	};
+	struct pci_bus_region region;
 	int i;
 
 	if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
@@ -442,6 +443,10 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 	if (!screen_res.start)
 		return;
 
+	region.start = screen_res.start;
+	region.end = screen_res.end;
+	pcibios_bus_to_resource(dev->bus, &screen_res, &region);
+
 	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
 		struct resource *res = &dev->resource[i];
 
-- 
2.7.4
