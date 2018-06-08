Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lp9bLio9GluXPQAAmS7hNA
	; Fri, 08 Jun 2018 08:24:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A1605606FA; Fri,  8 Jun 2018 08:24:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VYd//k0P"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C2DE2607A4;
	Fri,  8 Jun 2018 08:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2DE2607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbeFHIXt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:23:49 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:47738 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932167AbeFHITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:36 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C15841E1488;
        Fri,  8 Jun 2018 10:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528445974; bh=WbUrG2lXHFVqbpUarj8w4QPStsiUmLQheCqCNPRIh5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=VYd//k0P74T/7BvVHjHygPnU8wf4uhRYUmDgvyuIV8FDLeZhv33BCoZMsGsxhc8Aq
         RLiL/SEwhTytaJs5dipHd5nOp8RwnCW5KJwKvKtXWR2GmdWKXIAklTGosfQRbwinjL
         crvn8Xea3AdEHCb516/5yJ6Yq2c4EHtBnzqv1JyIP32pJ6XB06NpZt9FZc+YFBeHyP
         T/ood8xmNxnC+SZ73uS40gxpz2UPBqAqg+0ldBfRqp/jfmWMARPcdTSC23wHNihjto
         bUB8lOW/vsYg6qg5c/+BP3XPQ+dtPd5CVpj9R3K7JK9bvC/t6FR4idAJdWXIvSgGH2
         ok/IkWzzZuMVQ==
Received: from pt02.synopsys.com (pt02.internal.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 76377399C;
        Fri,  8 Jun 2018 01:19:32 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id CDFBA3E913;
        Fri,  8 Jun 2018 09:19:31 +0100 (WEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 01/10] PCI: endpoint: Add MSI-X interfaces
Date: Fri,  8 Jun 2018 09:19:17 +0100
Message-Id:
 <16240c7ee10394b88aef99a30bfc422756f79d55.1527862777.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180608081917.8VPrPZ0jZrLSPpa9Vl11xPrdyl8o9iFLpccK81kxEUc@z>

Add PCI_EPC_IRQ_MSIX type.

Add MSI-X callbacks signatures to the ops structure.

Add sysfs interface for set/get MSI-X capability maximum number.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v1->v2:
 - Nothing changed, just to follow the patch set version.
Change v2->v3:
 - Moved pci_epc_raise_irq() signature changes to patch file #3.

 drivers/pci/endpoint/pci-ep-cfs.c   | 24 ++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c | 57 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  9 ++++++
 include/linux/pci-epf.h             |  1 +
 4 files changed, 91 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 018ea34..d1288a0 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -286,6 +286,28 @@ static ssize_t pci_epf_msi_interrupts_show(struct config_item *item,
 		       to_pci_epf_group(item)->epf->msi_interrupts);
 }
 
+static ssize_t pci_epf_msix_interrupts_store(struct config_item *item,
+					     const char *page, size_t len)
+{
+	u16 val;
+	int ret;
+
+	ret = kstrtou16(page, 0, &val);
+	if (ret)
+		return ret;
+
+	to_pci_epf_group(item)->epf->msix_interrupts = val;
+
+	return len;
+}
+
+static ssize_t pci_epf_msix_interrupts_show(struct config_item *item,
+					    char *page)
+{
+	return sprintf(page, "%d\n",
+		       to_pci_epf_group(item)->epf->msix_interrupts);
+}
+
 PCI_EPF_HEADER_R(vendorid)
 PCI_EPF_HEADER_W_u16(vendorid)
 
@@ -327,6 +349,7 @@ CONFIGFS_ATTR(pci_epf_, subsys_vendor_id);
 CONFIGFS_ATTR(pci_epf_, subsys_id);
 CONFIGFS_ATTR(pci_epf_, interrupt_pin);
 CONFIGFS_ATTR(pci_epf_, msi_interrupts);
+CONFIGFS_ATTR(pci_epf_, msix_interrupts);
 
 static struct configfs_attribute *pci_epf_attrs[] = {
 	&pci_epf_attr_vendorid,
@@ -340,6 +363,7 @@ static struct configfs_attribute *pci_epf_attrs[] = {
 	&pci_epf_attr_subsys_id,
 	&pci_epf_attr_interrupt_pin,
 	&pci_epf_attr_msi_interrupts,
+	&pci_epf_attr_msix_interrupts,
 	NULL,
 };
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index b0ee427..7d77bd0 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -218,6 +218,63 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 EXPORT_SYMBOL_GPL(pci_epc_set_msi);
 
 /**
+ * pci_epc_get_msix() - get the number of MSI-X interrupt numbers allocated
+ * @epc: the EPC device to which MSI-X interrupts was requested
+ * @func_no: the endpoint function number in the EPC device
+ *
+ * Invoke to get the number of MSI-X interrupts allocated by the RC
+ */
+int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
+{
+	int interrupt;
+	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return 0;
+
+	if (!epc->ops->get_msix)
+		return 0;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	interrupt = epc->ops->get_msix(epc, func_no);
+	spin_unlock_irqrestore(&epc->lock, flags);
+
+	if (interrupt < 0)
+		return 0;
+
+	return interrupt + 1;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_msix);
+
+/**
+ * pci_epc_set_msix() - set the number of MSI-X interrupt numbers required
+ * @epc: the EPC device on which MSI-X has to be configured
+ * @func_no: the endpoint function number in the EPC device
+ * @interrupts: number of MSI-X interrupts required by the EPF
+ *
+ * Invoke to set the required number of MSI-X interrupts.
+ */
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
+{
+	int ret;
+	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
+	    interrupts < 1 || interrupts > 2048)
+		return -EINVAL;
+
+	if (!epc->ops->set_msix)
+		return 0;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
+	spin_unlock_irqrestore(&epc->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_set_msix);
+
+/**
  * pci_epc_unmap_addr() - unmap CPU address from PCI address
  * @epc: the EPC device on which address is allocated
  * @func_no: the endpoint function number in the EPC device
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 243eaa5..89f079f 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -17,6 +17,7 @@ enum pci_epc_irq_type {
 	PCI_EPC_IRQ_UNKNOWN,
 	PCI_EPC_IRQ_LEGACY,
 	PCI_EPC_IRQ_MSI,
+	PCI_EPC_IRQ_MSIX,
 };
 
 /**
@@ -30,6 +31,10 @@ enum pci_epc_irq_type {
  *	     capability register
  * @get_msi: ops to get the number of MSI interrupts allocated by the RC from
  *	     the MSI capability register
+ * @set_msix: ops to set the requested number of MSI-X interrupts in the
+ *	     MSI-X capability register
+ * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
+ *	     from the MSI-X capability register
  * @raise_irq: ops to raise a legacy or MSI interrupt
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
@@ -48,6 +53,8 @@ struct pci_epc_ops {
 			      phys_addr_t addr);
 	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 interrupts);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no);
+	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts);
+	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
 			     enum pci_epc_irq_type type, u8 interrupt_num);
 	int	(*start)(struct pci_epc *epc);
@@ -144,6 +151,8 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
 			phys_addr_t phys_addr);
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts);
+int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u8 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index f7d6f48..9bb1f31 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -119,6 +119,7 @@ struct pci_epf {
 	struct pci_epf_header	*header;
 	struct pci_epf_bar	bar[6];
 	u8			msi_interrupts;
+	u16			msix_interrupts;
 	u8			func_no;
 
 	struct pci_epc		*epc;
-- 
2.7.4
