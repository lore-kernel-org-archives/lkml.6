Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7BCC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A6C24C3E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A6C24C3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeFWPQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 11:16:43 -0400
Received: from www.osadl.org ([62.245.132.105]:39539 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbeFWPQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 11:16:41 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5NFFUWd027117;
        Sat, 23 Jun 2018 17:15:30 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] PCI: faraday: add missing of_node_put()
Date:   Sat, 23 Jun 2018 17:14:59 +0200
Message-Id: <1529766899-1994-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The call to of_get_next_child() returns a node pointer with refcount
incremented thus it must be explicitly decremented here in the error
path and after the last usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
---

Patch found my experimental coccinelle script

Patch was compile tested with: gemini_defconfig (implies CONFIG_PCI_FTPCI100=y)

Patch is against 4.18-rc1 (localversion-next is next-20180621)

 drivers/pci/controller/pci-ftpci100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index a1ebe9e..20bb256 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -355,11 +355,13 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 	irq = of_irq_get(intc, 0);
 	if (irq <= 0) {
 		dev_err(p->dev, "failed to get parent IRQ\n");
+		of_node_put(intc);
 		return irq ?: -EINVAL;
 	}
 
 	p->irqdomain = irq_domain_add_linear(intc, PCI_NUM_INTX,
 					     &faraday_pci_irqdomain_ops, p);
+	of_node_put(intc);
 	if (!p->irqdomain) {
 		dev_err(p->dev, "failed to create Gemini PCI IRQ domain\n");
 		return -EINVAL;
-- 
2.1.4

