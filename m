Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9F8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE61020645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570538;
	bh=w/Kd78erW5avJym6HODm2LsUvd7Jp3JEzXazriImH2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PCa+aA7QPqj6BsWmC0zPAJT/srTOtSI7evTrPGQdzbxhUSYG+RJYBrUuyjj2BEdwF
	 R9r1Q1lwuUV5OHyRqamuzDCx2b1QA0q1Fy+5qpFaxh5Oh0wed82Gu8+bBNImoA0uJ5
	 sNFLqIdqko7pUm0VUitrvR/9o4sufwt9hEj4uYyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbfAOQmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732943AbfAOQmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A0F2054F;
        Tue, 15 Jan 2019 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570534;
        bh=w/Kd78erW5avJym6HODm2LsUvd7Jp3JEzXazriImH2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvCPcSgjJcrtpVQyroqdT5PeovDDnQC0iDfgWQZMLiPHKQ2mHVF3HF7+/CYTddPGh
         3ETHmeyEZnWhQRt7vIgbuGhkBAgxz5gW8+MjNgt0RyYr/LwobnAx6YYnFjNHjBoSh3
         ARgNjclYrSJlxucePq5pAp9lEGfyXGwpItLHq6m4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.19 29/50] PCI: dwc: Take lock when ACKing an interrupt
Date:   Tue, 15 Jan 2019 17:36:05 +0100
Message-Id: <20190115154911.616405882@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit fce5423e4f431c71933d6c1f850b540a314aa6ee upstream.

Bizarrely, there is no lock taken in the irq_ack() helper. This
puts the ACK callback provided by a specific platform in a awkward
situation where there is no synchronization that would be expected
on other callback.

Introduce the required lock, giving some level of uniformity among
callbacks.

Fixes: 7c5925afbc58 ("PCI: dwc: Move MSI IRQs allocation to IRQ domains
hierarchical API")
Link: https://lore.kernel.org/linux-pci/20181113225734.8026-1-marc.zyngier@arm.com/
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Tested-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pcie-designware-host.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -202,11 +202,16 @@ static void dw_pci_bottom_ack(struct irq
 {
 	struct msi_desc *msi = irq_data_get_msi_desc(d);
 	struct pcie_port *pp;
+	unsigned long flags;
 
 	pp = msi_desc_to_pci_sysdata(msi);
 
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
 	if (pp->ops->msi_irq_ack)
 		pp->ops->msi_irq_ack(d->hwirq, pp);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static struct irq_chip dw_pci_msi_bottom_irq_chip = {


