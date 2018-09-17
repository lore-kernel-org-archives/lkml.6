Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E714AECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A609B2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A609B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbeIREod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:44:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbeIREoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:44:32 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1510C49;
        Mon, 17 Sep 2018 23:14:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 108/158] PCI: mobiveil: Fix struct mobiveil_pcie.pcie_reg_base address type
Date:   Tue, 18 Sep 2018 00:42:18 +0200
Message-Id: <20180917211716.267385259@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[ Upstream commit af3f606e0bbb6d811c50b7b90fe324b07fb7cab8 ]

The field pcie_reg_base in struct mobiveil_pcie represents a physical
address so it should be of phys_addr_t type rather than void __iomem*;
this results in the following compilation  warnings:

drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_pcie_parse_dt':
drivers/pci/controller/pcie-mobiveil.c:326:22: warning: assignment makes
pointer from integer without a cast [-Wint-conversion]
  pcie->pcie_reg_base = res->start;
                      ^
drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_pcie_enable_msi':
drivers/pci/controller/pcie-mobiveil.c:485:25: warning: initialization
makes integer from pointer without a cast [-Wint-conversion]
  phys_addr_t msg_addr = pcie->pcie_reg_base;
                         ^~~~
drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_compose_msi_msg':
drivers/pci/controller/pcie-mobiveil.c:640:21: warning: initialization
makes integer from pointer without a cast [-Wint-conversion]
  phys_addr_t addr = pcie->pcie_reg_base + (data->hwirq * sizeof(int));

Fix the type and with it the compilation warnings.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
driver")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pcie-mobiveil.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -132,7 +132,7 @@ struct mobiveil_pcie {
 	void __iomem *config_axi_slave_base;	/* endpoint config base */
 	void __iomem *csr_axi_slave_base;	/* root port config base */
 	void __iomem *apb_csr_base;	/* MSI register base */
-	void __iomem *pcie_reg_base;	/* Physical PCIe Controller Base */
+	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
 	struct irq_domain *intx_domain;
 	raw_spinlock_t intx_mask_lock;
 	int irq;


