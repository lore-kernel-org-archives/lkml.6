Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeBAI4P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:56:15 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:35903 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeBAI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:56:12 -0500
Date: Thu, 1 Feb 2018 09:56:09 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20180201085608.GA22568@axis.com>
References: <20180201105114.562aef46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20180201105114.562aef46@canb.auug.org.au>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 01, 2018 at 10:51:14AM +1100, Stephen Rothwell wrote:
> Hi Bjorn,
> 
> After merging the pci tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/pci/dwc/pcie-designware-ep.c: In function 'dw_pcie_ep_raise_msi_irq':
> drivers/pci/dwc/pcie-designware-ep.c:293:8: error: too few arguments to function 'dw_pcie_ep_map_addr'
>   ret = dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr,
>         ^~~~~~~~~~~~~~~~~~~
> drivers/pci/dwc/pcie-designware-ep.c:177:12: note: declared here
>  static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
>             ^~~~~~~~~~~~~~~~~~~
> drivers/pci/dwc/pcie-designware-ep.c:300:2: error: too few arguments to function 'dw_pcie_ep_unmap_addr'
>   dw_pcie_ep_unmap_addr(epc, ep->msi_mem_phys);
>   ^~~~~~~~~~~~~~~~~~~~~
> drivers/pci/dwc/pcie-designware-ep.c:161:13: note: declared here
>  static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
>              ^~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   4494738de0d9 ("PCI: endpoint: Add the function number as argument to EPC ops")
> 
> interacting with commit
> 
>   6f6d7873711c ("PCI: designware-ep: Add generic function for raising MSI irq")
> 
> This should have been fixed up in commit
> 
>   26b259ab4fe8 ("Merge remote-tracking branch 'lorenzo/pci/dwc' into next")
> 
> I have used the pci tree from next-20180131 for today.

Hello,

A suggested merge resolution included as an attachment.

Regards,
Niklas

--lrZ03NoBR/3+SXJZ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="dwc-ep.patch"

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 39e4a9744863..ed8558d638e5 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -368,7 +368,7 @@ static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_MSI_XMT, reg);
 }
 
-static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep,
+static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 				 enum pci_epc_irq_type type, u8 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 34ae163603ee..93b3df9ed1b5 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -445,7 +445,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
-static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep,
+static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 				  enum pci_epc_irq_type type, u8 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -455,7 +455,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep,
 		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
 		return -EINVAL;
 	case PCI_EPC_IRQ_MSI:
-		return dw_pcie_ep_raise_msi_irq(ep, interrupt_num);
+		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(pci->dev, "UNKNOWN IRQ type\n");
 	}
diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index c0395e1f470a..3a6feeff5f5b 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -229,7 +229,7 @@ static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
 	if (!ep->ops->raise_irq)
 		return -EINVAL;
 
-	return ep->ops->raise_irq(ep, type, interrupt_num);
+	return ep->ops->raise_irq(ep, func_no, type, interrupt_num);
 }
 
 static void dw_pcie_ep_stop(struct pci_epc *epc)
@@ -267,7 +267,7 @@ static const struct pci_epc_ops epc_ops = {
 	.stop			= dw_pcie_ep_stop,
 };
 
-int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
+int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -290,14 +290,14 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
 		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_32);
 	}
 	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
-	ret = dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr,
+	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
 				  epc->mem->page_size);
 	if (ret)
 		return ret;
 
 	writel(msg_data | (interrupt_num - 1), ep->msi_mem);
 
-	dw_pcie_ep_unmap_addr(epc, ep->msi_mem_phys);
+	dw_pcie_ep_unmap_addr(epc, func_no, ep->msi_mem_phys);
 
 	return 0;
 }
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 7e52119f0e96..11b13864a406 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -186,8 +186,8 @@ enum dw_pcie_as_type {
 
 struct dw_pcie_ep_ops {
 	void	(*ep_init)(struct dw_pcie_ep *ep);
-	int	(*raise_irq)(struct dw_pcie_ep *ep, enum pci_epc_irq_type type,
-			     u8 interrupt_num);
+	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
+			     enum pci_epc_irq_type type, u8 interrupt_num);
 };
 
 struct dw_pcie_ep {
@@ -342,7 +342,8 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
-int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 interrupt_num);
+int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
+			     u8 interrupt_num);
 void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
 #else
 static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
@@ -358,7 +359,7 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 }
 
-static inline int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
+static inline int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 					   u8 interrupt_num)
 {
 	return 0;

--lrZ03NoBR/3+SXJZ--
