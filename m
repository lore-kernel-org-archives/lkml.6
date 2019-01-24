Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F37C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB63621906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358414;
	bh=HIwgbqwBqHR2gpk+dildLN936vAp54HtB1s7qDNdgLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jA6wVHskglIWm/MKOI9GcEGvl6UiNDjUeRHy3ewWgipxdOOMUW6lL1VuSH9mc42Uj
	 BkBLtFquOHrHIsj6OtXJKDc1FIe+N2AL6ZqNkuSElZJkg/RDUla47z5b3UXmo+feza
	 C7EedXvU9j+DTmMMNKvHdEWw/qwq58GpAHSMztOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbfAXTdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:33:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbfAXTd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:33:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05FAD21903;
        Thu, 24 Jan 2019 19:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358408;
        bh=HIwgbqwBqHR2gpk+dildLN936vAp54HtB1s7qDNdgLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJ4lWDlukZNpedP7MXpy3rIP7ld1R2g89PkXP0a7K05jzopXosscnN5FPWm62QOE1
         9v6UpS36dKIx3GokOvMJtaCK0cvOHzUVSeXlMY6ysVyGX6diQsp2eaO4Ya1oosG0Wg
         i5J8UkDvs9OrOHAVthV7ECyYDtkP4Io/2FRQNUq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Trent Piepho <tpiepho@impinj.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.14 62/63] PCI: dwc: Move interrupt acking into the proper callback
Date:   Thu, 24 Jan 2019 20:20:51 +0100
Message-Id: <20190124190202.497835281@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/pci/dwc/pcie-designware-host.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -45,8 +45,19 @@ static int dw_pcie_wr_own_conf(struct pc
 	return dw_pcie_write(pci->dbi_base + where, size, val);
 }
 
+static void dwc_irq_ack(struct irq_data *d)
+{
+	struct msi_desc *msi = irq_data_get_msi_desc(d);
+	struct pcie_port *pp = msi_desc_to_pci_sysdata(msi);
+	int pos = d->hwirq % 32;
+	int i = d->hwirq / 32;
+
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4, BIT(pos));
+}
+
 static struct irq_chip dw_msi_irq_chip = {
 	.name = "PCI-MSI",
+	.irq_ack = dwc_irq_ack,
 	.irq_enable = pci_msi_unmask_irq,
 	.irq_disable = pci_msi_mask_irq,
 	.irq_mask = pci_msi_mask_irq,
@@ -72,8 +83,6 @@ irqreturn_t dw_handle_msi_irq(struct pci
 					    pos)) != 32) {
 			irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
 			generic_handle_irq(irq);
-			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
-					    4, 1 << pos);
 			pos++;
 		}
 	}
@@ -263,7 +272,7 @@ static struct msi_controller dw_pcie_msi
 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
 			   irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_edge_irq);
 	irq_set_chip_data(irq, domain->host_data);
 
 	return 0;


