Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C8FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACEC2064E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACEC2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeHWLhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:37:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeHWLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:37:31 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5D4B9C74;
        Thu, 23 Aug 2018 08:09:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 063/130] PCI: xilinx: Add missing of_node_put()
Date:   Thu, 23 Aug 2018 09:52:59 +0200
Message-Id: <20180823074931.518824341@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 8c3f9bd851a4d3acf0a0f222d4e9e41c0cd1ea8e ]

The call to of_get_next_child() returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
[lorenzo.pieralisi@arm.com: reworked commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/host/pcie-xilinx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -527,6 +527,7 @@ static int xilinx_pcie_init_irq_domain(s
 	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
 						 &intx_domain_ops,
 						 port);
+	of_node_put(pcie_intc_node);
 	if (!port->leg_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENODEV;


