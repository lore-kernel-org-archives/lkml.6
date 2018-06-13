Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 346A0C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D7E208D8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D7E208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935393AbeFMRVf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:21:35 -0400
Received: from www.osadl.org ([62.245.132.105]:49939 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751898AbeFMRVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:21:33 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5DHKwCo009004;
        Wed, 13 Jun 2018 19:20:58 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] PCI: xilinx: add missing of_node_put()
Date:   Wed, 13 Jun 2018 19:20:44 +0200
Message-Id: <1528910444-25593-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The call to of_get_next_child() returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")
---

Problem found by an experimental cocinelle script

Patch was compile tested with: multi_v7_defconfig + ARCH_ZYNQ=y,
COMPILE_TEST=y, PCIE_XILINX=y
(with one sparse warning though not related to the change proposed)

Patch is against 4.17.0 (localversion-next is next-20180613)

 drivers/pci/controller/pcie-xilinx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index b110a3a..7b1389d 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -509,6 +509,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 						 &intx_domain_ops,
 						 port);
+	of_node_put(pcie_intc_node);
 	if (!port->leg_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENODEV;
-- 
2.1.4

