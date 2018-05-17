Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeEQNWd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:22:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbeEQNWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:22:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F378609D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        ard.biesheuvel@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:EFIFB FRAMEBUFFER DRIVER),
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] efi/fb: Convert PCI bus address to resource if translated by the bridge
Date: Thu, 17 May 2018 09:22:23 -0400
Message-Id: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
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

efifb driver is having difficulty locating the base address from BAR
address when

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
 drivers/video/fbdev/efifb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 46a4484..ea68d5c 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -428,6 +428,8 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 {
 	u64 base = screen_info.lfb_base;
 	u64 size = screen_info.lfb_size;
+	struct pci_bus_region region;
+	struct resource res;
 	int i;
 
 	if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
@@ -439,6 +441,14 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 	if (!base)
 		return;
 
+	region.start = base;
+	region.end = base + size - 1;
+	res.start = 0;
+	res.flags = IORESOURCE_MEM;
+	pcibios_bus_to_resource(dev->bus, &res, &region);
+	if (res.start)
+		base = res.start;
+
 	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
 		struct resource *res = &dev->resource[i];
 
-- 
2.7.4
