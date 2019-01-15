Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AD3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753D020651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571344;
	bh=ldVa6EpiwVaVdpFfkULNFcaYQJnWyWNwSbJRMFMi9GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hqYlrt4U1vFrK1WftCRipVXy1Y9BpcM+2z96vgOd700Kn9M0M6rmifw/ONqNBsalU
	 TD1WvNeRfWXqBBkYEunbLzBDh+Mhx2GGaYnO0jxd78uWXd2nSHxmrajU4kI5Bl05YI
	 8lWSX+iLpffeRpRM43rvIlJynLDBfz3WbnJzarrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbfAOQzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbfAOQmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4338A20645;
        Tue, 15 Jan 2019 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570531;
        bh=ldVa6EpiwVaVdpFfkULNFcaYQJnWyWNwSbJRMFMi9GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tk9Kb0cScp4/bA68GmlFOBYUiuotbjpXRqmF6UCtnMclC5iujfhVhW5sJl/RdPaET
         4mjuuweH4Hdz72jZjba+G+B31XqIu04Hd/7SMTwU+r68g59fxv3qVQf7DHwhyQsr0i
         YmTCDBPHVqNq7oYhZViEXBp70Q7CqMCdayDFYnRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.19 28/50] PCI: dwc: Use interrupt masking instead of disabling
Date:   Tue, 15 Jan 2019 17:36:04 +0100
Message-Id: <20190115154911.573406514@linuxfoundation.org>
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

commit 830920e065e90db318a0da98bf13a02b641eae7f upstream.

The dwc driver is showing an interesting level of brokeness, as it
insists on using the enable/disable set of registers to mask/unmask
MSIs, meaning that an MSIs being generated while the interrupt is in
that "disabled" state will simply be lost.

Let's move to the mask/unmask set of registers, which offers the
expected semantics.

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
 drivers/pci/controller/dwc/pcie-designware-host.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -168,8 +168,8 @@ static void dw_pci_bottom_mask(struct ir
 		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 		pp->irq_status[ctrl] &= ~(1 << bit);
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
-				    pp->irq_status[ctrl]);
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
+				    ~pp->irq_status[ctrl]);
 	}
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
@@ -191,8 +191,8 @@ static void dw_pci_bottom_unmask(struct
 		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 		pp->irq_status[ctrl] |= 1 << bit;
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
-				    pp->irq_status[ctrl]);
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
+				    ~pp->irq_status[ctrl]);
 	}
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
@@ -658,10 +658,15 @@ void dw_pcie_setup_rc(struct pcie_port *
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 	/* Initialize IRQ Status array */
-	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
-		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
 					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, &pp->irq_status[ctrl]);
+				    4, ~0);
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
+					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+				    4, ~0);
+		pp->irq_status[ctrl] = 0;
+	}
 
 	/* Setup RC BARs */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);


