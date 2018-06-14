Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 882E5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECD0208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECD0208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754738AbeFNJF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:05:29 -0400
Received: from www.osadl.org ([62.245.132.105]:33205 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752833AbeFNJF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:05:27 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5E94mHE023428;
        Thu, 14 Jun 2018 11:04:48 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] PCI: xilinx-nwl: add missing of_node_put()
Date:   Thu, 14 Jun 2018 11:04:34 +0200
Message-Id: <1528967074-30024-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The call to of_get_next_child() returns a node pointer with
refcount incremented thus it must be explicitly decremented
here after the last usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller")
---

Problem found by an experimental cocinelle script

Patch was compile tested with: multi_v7_defconfig + ARCH_ZYNQ=y,
COMPILE_TEST=y, PCIE_XILINX_NWL=y
(one sparse warning though not related to the change proposed though)

Patch is against 4.17.0 (localversion-next is next-20180613)

 drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 6a4bbb5..fb32840 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -559,7 +559,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 							PCI_NUM_INTX,
 							&legacy_domain_ops,
 							pcie);
-
+	of_node_put(legacy_intc_node);
 	if (!pcie->legacy_irq_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
-- 
2.1.4

