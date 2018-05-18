Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEROSB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:18:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45920 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeEROR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:17:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CCF46085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-fbdev@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 1/2] efi/fb: Simplify fixup code to prefer struct resource
Date: Fri, 18 May 2018 10:17:50 -0400
Message-Id: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of base and size variables in favor of a struct resource.
The conditional for checking window can be replaced with
resource_contains().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/video/fbdev/efifb.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 46a4484..6daac8d 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -426,17 +426,20 @@ static void record_efifb_bar_resource(struct pci_dev *dev, int idx, u64 offset)
 
 static void efifb_fixup_resources(struct pci_dev *dev)
 {
-	u64 base = screen_info.lfb_base;
-	u64 size = screen_info.lfb_size;
+	struct resource screen_res = {
+		.start = screen_info.lfb_base,
+		.end = screen_info.lfb_base + screen_info.lfb_size - 1,
+		.flags = IORESOURCE_MEM,
+	};
 	int i;
 
 	if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
 		return;
 
 	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)screen_info.ext_lfb_base << 32;
+		screen_res.start |= (u64)screen_info.ext_lfb_base << 32;
 
-	if (!base)
+	if (!screen_res.start)
 		return;
 
 	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
@@ -445,8 +448,10 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 		if (!(res->flags & IORESOURCE_MEM))
 			continue;
 
-		if (res->start <= base && res->end >= base + size - 1) {
-			record_efifb_bar_resource(dev, i, base - res->start);
+		if (resource_contains(res, &screen_res)) {
+			u64 win_offset =  screen_res.start - res->start;
+
+			record_efifb_bar_resource(dev, i, win_offset);
 			break;
 		}
 	}
-- 
2.7.4
