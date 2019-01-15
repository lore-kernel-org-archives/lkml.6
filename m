Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796B9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4916F20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571333;
	bh=pHDgDumRhaRN2WaOHvz5726PnTAFRu2anpCiwYD7CpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FpX7VwT/aJ1bCl5A7wavG9rWAA+e9deMLy/kV9BSO0Wcr36ArnTD6Elvpzc7RvxqH
	 twm426d23kwFxH3smwUF6HrqZEnPt8IzKx3A82vKPfDFGziOiqIHE+MubIIl5wqRQp
	 KrkeAAbifoO/B+yQVARv0dfjxm1axo8BHX9SGl8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfAOQza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:55:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbfAOQmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214EB2054F;
        Tue, 15 Jan 2019 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570539;
        bh=pHDgDumRhaRN2WaOHvz5726PnTAFRu2anpCiwYD7CpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBPEfbr3eVFjgy4NKEVJ6XOhykeaCGi7jhEsVhrtwYurm8tp6ZVlAAFxqJl+oRcRX
         /ckCxxx/Nnqj8ec5Xh3y2+EkR5l2yFC510PE986StjOym1NcREZoeJphwL8MMeFJ2v
         g0LyP9Wcm5Kwv33uWmY16PF8Nji2BBBZPfAtLeUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Trent Piepho <tpiepho@impinj.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.19 30/50] PCI: dwc: Move interrupt acking into the proper callback
Date:   Tue, 15 Jan 2019 17:36:06 +0100
Message-Id: <20190115154911.663871702@linuxfoundation.org>
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

commit 3f7bb2ec20ce07c02b2002349d256c91a463fcc5 upstream.

The write to the status register is really an ACK for the HW,
and should be treated as such by the driver. Let's move it to the
irq_ack() callback, which will prevent people from moving it around
in order to paper over other bugs.

Fixes: 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status after it is handled,
not before")
Fixes: 7c5925afbc58 ("PCI: dwc: Move MSI IRQs allocation to IRQ domains
hierarchical API")
Link: https://lore.kernel.org/linux-pci/20181113225734.8026-1-marc.zyngier@arm.com/
Reported-by: Trent Piepho <tpiepho@impinj.com>
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Tested-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pcie-designware-host.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -99,9 +99,6 @@ irqreturn_t dw_handle_msi_irq(struct pci
 					       (i * MAX_MSI_IRQS_PER_CTRL) +
 					       pos);
 			generic_handle_irq(irq);
-			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
-						(i * MSI_REG_CTRL_BLOCK_SIZE),
-					    4, 1 << pos);
 			pos++;
 		}
 	}
@@ -200,14 +197,18 @@ static void dw_pci_bottom_unmask(struct
 
 static void dw_pci_bottom_ack(struct irq_data *d)
 {
-	struct msi_desc *msi = irq_data_get_msi_desc(d);
-	struct pcie_port *pp;
+	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
+	unsigned int res, bit, ctrl;
 	unsigned long flags;
 
-	pp = msi_desc_to_pci_sysdata(msi);
+	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
+
 	if (pp->ops->msi_irq_ack)
 		pp->ops->msi_irq_ack(d->hwirq, pp);
 


