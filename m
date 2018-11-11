Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4C7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52C321582
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJlkglIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52C321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbeKLIUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388532AbeKLIUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:19 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3E5208A3;
        Sun, 11 Nov 2018 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975422;
        bh=1X7r57cpFdxpqgf+fyPlWI3lOugNSb6CGJASTOD5/ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJlkglIsMDeyWQkTG5Y/h99AvsiOxF0gT3ZVvft0aU76sWQQzzEY60KPqNIwMuqu6
         7JCzWSL3Qv9RCr66WvQyC2IDCMk3qmdapOlSM/Iw2Nn6TEPvf8ZzZjzaWRaYtEPz3L
         SKOR+DH8dSswj17E6aJ59p7wHyrst48c5wXTaaak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Douglas <adouglas@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 151/350] PCI: cadence: Use AXI region 0 to signal interrupts from EP
Date:   Sun, 11 Nov 2018 14:20:15 -0800
Message-Id: <20181111221714.375412023@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pcie-cadence-ep.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -259,7 +259,6 @@ static void cdns_pcie_ep_assert_intx(str
 				     u8 intx, bool is_asserted)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 r = ep->max_regions - 1;
 	u32 offset;
 	u16 status;
 	u8 msg_code;
@@ -269,8 +268,8 @@ static void cdns_pcie_ep_assert_intx(str
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
@@ -348,8 +347,8 @@ static int cdns_pcie_ep_send_msi_irq(str
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
@@ -510,6 +509,8 @@ static int cdns_pcie_ep_probe(struct pla
 		goto free_epc_mem;
 	}
 	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
+	/* Reserve region 0 for IRQs */
+	set_bit(0, &ep->ob_region_map);
 
 	return 0;
 


