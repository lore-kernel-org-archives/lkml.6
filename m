Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDAAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79535208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79535208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbeHATrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:47:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405868AbeHATIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A6BBC10F2;
        Wed,  1 Aug 2018 17:04:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 169/336] PCI/DPC: Clear interrupt status in interrupt handler top half
Date:   Wed,  1 Aug 2018 18:48:24 +0200
Message-Id: <20180801165035.579863965@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oza Pawandeep <poza@codeaurora.org>

[ Upstream commit 56abbf8ad73c89d0a4c3c84b1449ceaaabd1b8c7 ]

The generic IRQ handling code ensures that an interrupt handler runs with
its interrupt masked or disabled.  If the interrupt is level-triggered, the
interrupt handler must tell its device to stop asserting the interrupt
before returning.  If it doesn't, we will immediately take the interrupt
again when the handler returns and the generic code unmasks the interrupt.

The driver doesn't know whether its interrupt is edge- or level-triggered,
so it must clear its interrupt source directly in its interrupt handler.

Previously we cleared the DPC interrupt status in the bottom half, i.e., in
deferred work, which can cause an interrupt storm if the DPC interrupt
happens to be level-triggered, e.g., if we're using INTx instead of MSI.

Clear the DPC interrupt status bit in the interrupt handler, not in the
deferred work.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pcie/dpc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -113,7 +113,7 @@ static void dpc_work(struct work_struct
 	}
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
+			      PCI_EXP_DPC_STATUS_TRIGGER);
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
@@ -223,6 +223,9 @@ static irqreturn_t dpc_irq(int irq, void
 	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
 		dpc_process_rp_pio_error(dpc);
 
+	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
+			      PCI_EXP_DPC_STATUS_INTERRUPT);
+
 	schedule_work(&dpc->work);
 
 	return IRQ_HANDLED;


