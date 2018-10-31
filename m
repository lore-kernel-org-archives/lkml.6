Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E413C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C4D20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMGgFHKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C4D20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbeKAIeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730422AbeKAIJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D21BC20664;
        Wed, 31 Oct 2018 23:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027356;
        bh=00t2dVpQ8kJ6QIi+azOzbLzCZhRvLoKZhLUQN+lCn2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMGgFHKEflAAXGb56CrPxWb78aOQwD1ebIjbmb48sG0BVb0roRW6tAoSreLqe6m6W
         /dwwE5WSjgfDuMQu6Ku39Xqx/6O2ZCrEXO0Zs3krzCi2lv+axC7F7BGO8N9efR6D3D
         y3gwbdj3s2VspvJJCgpGMmI5JqSoXYeJFLV2la1k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alan Douglas <adouglas@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 090/126] PCI: cadence: Use AXI region 0 to signal interrupts from EP
Date:   Wed, 31 Oct 2018 19:07:18 -0400
Message-Id: <20181031230754.29029-90-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Douglas <adouglas@cadence.com>

[ Upstream commit 0652d4b6b56f73c81abbdbc7e26f772cb2dfe370 ]

The IRQ physical address is allocated from region 0, rather than
the highest region. Update the driver to reserve this region in
the bitmap and to use region 0 for all types of interrupt.

This corrects a problem which prevents the interrupt being
signalled correctly if using the first address in the AXI region,
since an offset of zero will always be mapped to region 0.

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-cadence-ep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index e3fe4124e3af..a67dc91261f5 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -259,7 +259,6 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 				     u8 intx, bool is_asserted)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 r = ep->max_regions - 1;
 	u32 offset;
 	u16 status;
 	u8 msg_code;
@@ -269,8 +268,8 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 	/* Set the outbound region if needed. */
 	if (unlikely(ep->irq_pci_addr != CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY ||
 		     ep->irq_pci_fn != fn)) {
-		/* Last region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region_for_normal_msg(pcie, fn, r,
+		/* First region was reserved for IRQ writes. */
+		cdns_pcie_set_outbound_region_for_normal_msg(pcie, fn, 0,
 							     ep->irq_phys_addr);
 		ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
 		ep->irq_pci_fn = fn;
@@ -348,8 +347,8 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 	/* Set the outbound region if needed. */
 	if (unlikely(ep->irq_pci_addr != (pci_addr & ~pci_addr_mask) ||
 		     ep->irq_pci_fn != fn)) {
-		/* Last region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, fn, ep->max_regions - 1,
+		/* First region was reserved for IRQ writes. */
+		cdns_pcie_set_outbound_region(pcie, fn, 0,
 					      false,
 					      ep->irq_phys_addr,
 					      pci_addr & ~pci_addr_mask,
@@ -510,6 +509,8 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 		goto free_epc_mem;
 	}
 	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
+	/* Reserve region 0 for IRQs */
+	set_bit(0, &ep->ob_region_map);
 
 	return 0;
 
-- 
2.17.1

