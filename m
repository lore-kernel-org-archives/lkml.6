Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeBAL36 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:29:58 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:56460 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeBAL3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:29:54 -0500
Date: Thu, 1 Feb 2018 12:29:51 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20180201112950.GA14515@axis.com>
References: <20180201105114.562aef46@canb.auug.org.au>
 <20180201085608.GA22568@axis.com>
 <20180201111054.GA3983@e107981-ln.cambridge.arm.com>
 <20180201111617.GA8396@axis.com>
 <30c8c87f-bba9-d71e-b8d5-4b547711bab2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30c8c87f-bba9-d71e-b8d5-4b547711bab2@ti.com>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 04:52:01PM +0530, Kishon Vijay Abraham I wrote:
> Hi Niklas,
> 
> On Thursday 01 February 2018 04:46 PM, Niklas Cassel wrote:
> > On Thu, Feb 01, 2018 at 11:10:54AM +0000, Lorenzo Pieralisi wrote:
> >> On Thu, Feb 01, 2018 at 09:56:09AM +0100, Niklas Cassel wrote:
> >>> On Thu, Feb 01, 2018 at 10:51:14AM +1100, Stephen Rothwell wrote:
> >>>> Hi Bjorn,
> >>>>
> >>>> After merging the pci tree, today's linux-next build (arm
> >>>> multi_v7_defconfig) failed like this:
> >>>>
> >>>> drivers/pci/dwc/pcie-designware-ep.c: In function 'dw_pcie_ep_raise_msi_irq':
> >>>> drivers/pci/dwc/pcie-designware-ep.c:293:8: error: too few arguments to function 'dw_pcie_ep_map_addr'
> >>>>   ret = dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr,
> >>>>         ^~~~~~~~~~~~~~~~~~~
> >>>> drivers/pci/dwc/pcie-designware-ep.c:177:12: note: declared here
> >>>>  static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
> >>>>             ^~~~~~~~~~~~~~~~~~~
> >>>> drivers/pci/dwc/pcie-designware-ep.c:300:2: error: too few arguments to function 'dw_pcie_ep_unmap_addr'
> >>>>   dw_pcie_ep_unmap_addr(epc, ep->msi_mem_phys);
> >>>>   ^~~~~~~~~~~~~~~~~~~~~
> >>>> drivers/pci/dwc/pcie-designware-ep.c:161:13: note: declared here
> >>>>  static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
> >>>>              ^~~~~~~~~~~~~~~~~~~~~
> >>>>
> >>>> Caused by commit
> >>>>
> >>>>   4494738de0d9 ("PCI: endpoint: Add the function number as argument to EPC ops")
> >>>>
> >>>> interacting with commit
> >>>>
> >>>>   6f6d7873711c ("PCI: designware-ep: Add generic function for raising MSI irq")
> >>>>
> >>>> This should have been fixed up in commit
> >>>>
> >>>>   26b259ab4fe8 ("Merge remote-tracking branch 'lorenzo/pci/dwc' into next")
> >>>>
> >>>> I have used the pci tree from next-20180131 for today.
> >>>
> >>> Hello,
> >>>
> >>> A suggested merge resolution included as an attachment.
> >>
> >> The resolution is OK to me - we have not spotted it since
> >> PCI_ENDPOINT is being turned on in the config file in question only
> >> in -next, it is not on by default in current mainline, apologies.
> >>
> >> Lorenzo
> > 
> > Adding Kishon to CC, he should probably have a look.
> > 
> > https://marc.info/?l=linux-kernel&m=151747537928327&w=2
> > 
> > If Kishon approves the suggested merge resolution,
> > perhaps it can be squashed with Cyrille's patch.
> 
> The patch looks good to me.

Since dw_pcie_ep_map_addr()/dw_pcie_ep_unmap_addr() ignores
func_no, I guess another merge resoluton would be:

--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -290,14 +290,14 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
                msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_32);
        }
        msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
-       ret = dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr,
+       ret = dw_pcie_ep_map_addr(epc, 0, ep->msi_mem_phys, msg_addr,
                                  epc->mem->page_size);
        if (ret)
                return ret;
 
        writel(msg_data | (interrupt_num - 1), ep->msi_mem);
 
-       dw_pcie_ep_unmap_addr(epc, ep->msi_mem_phys);
+       dw_pcie_ep_unmap_addr(epc, 0, ep->msi_mem_phys);
 
        return 0;
 }


But in case pcie-designware-ep.c is ever going to support
multi-function devices (will it? will it not?), perhaps
the first merge resolution is prefered.


Regards,
Niklas
