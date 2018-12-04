Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FD2C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BAA2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BAA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeLDR0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:26:32 -0500
Received: from 8bytes.org ([81.169.241.247]:51602 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbeLDR02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:26:28 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 48E45432; Tue,  4 Dec 2018 18:26:24 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH 5/5] xhci: Use device_iommu_mapped()
Date:   Tue,  4 Dec 2018 18:25:04 +0100
Message-Id: <20181204172504.19708-6-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204172504.19708-1-joro@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Replace the dev->iommu_group check with a proper function
call that better reprensents its purpose.

Cc: Mathias Nyman <mathias.nyman@intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index c928dbbff881..5ab97e54d070 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -244,7 +244,7 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
 	 * an iommu. Doing anything when there is no iommu is definitely
 	 * unsafe...
 	 */
-	if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !dev->iommu_group)
+	if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !device_iommu_mapped(dev))
 		return;
 
 	xhci_info(xhci, "Zeroing 64bit base registers, expecting fault\n");
-- 
2.17.1

