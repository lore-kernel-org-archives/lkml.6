Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D31ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46602208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Sdxc6Otd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46602208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbeGMQMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:12:50 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35074 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbeGMQMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:12:49 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4234F10C0593;
        Fri, 13 Jul 2018 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531497456; bh=iIRinYc/zb6pKN6i1rsQ1pDZMJeNTDtALoYngXwWmUw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Sdxc6OtdBwSl4mpj2dF/2xAiVvNjFXnmqLzBNHnK4eAdtt7Qnk9CZv8rBeFH21Uc7
         P6PwUmqm23GJa84OPD80qkhCNjyS3zScfLk0L5U8LeCL5CkizPAtmh6BngsoIzEC9v
         esjepTaCWnt/Nhu2o3Ud0lYXNbjCD+25hFByh89bP1+pmg/CT3GnwGBLwZ017hDHf1
         A2FhXGMSdOG2fa8gEqRLpat/8PCS9/TfL2kCvd9F9O/lM4/lErWCFZwky8UASLNyKu
         Z1ciPxFPQ+SZWY+oIU4DVUKt6XYqNviDhDvTHUKps41bxOPb/+juaw+mElojLO9X0Q
         tBfimpUJRcysA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id 20B3A595A;
        Fri, 13 Jul 2018 08:57:36 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 13 Jul 2018 08:57:35 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 13 Jul 2018 17:57:33 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 13 Jul 2018 17:57:33 +0200
Subject: Re: [PATCH v9 04/12] PCI: dwc: Add MSI-X callbacks handler
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1531155252.git.gustavo.pimentel@synopsys.com>
 <5e4ca8380a65da72cf5d3ab46588948e3537aeae.1531155252.git.gustavo.pimentel@synopsys.com>
 <b1db283e-b9db-a8c4-409c-d9dc64805c94@ti.com>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <e4e1c9b7-bc10-6500-7924-7e5c9551076b@synopsys.com>
Date:   Fri, 13 Jul 2018 16:55:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <b1db283e-b9db-a8c4-409c-d9dc64805c94@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 13/07/2018 08:55, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 09 July 2018 11:12 PM, Gustavo Pimentel wrote:
>> Add PCIe config space capability search function.
>>
>> Add sysfs set/get interface to allow the change of EP MSI-X maximum number.
>>
>> Add EP MSI-X callback for triggering interruptions.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v1->v2:
>>  - Nothing changed, just to follow the patch set version.
>> Change v2->v3:
>>  - Moved dra7xx_pcie_raise_irq() signature change to patch file #3.
>>  - Moved artpec6_pcie_raise_irq() signature change to patch file #3.
>>  - Replaced wrong return value 0 to -EINVAL.
>>  - Removed an else if by code refactoring.
>>  - Reduced the size of ioremap_nocache mapping from ep->addr_size to
>> PCI_MSIX_ENTRY_SIZE.
>>  - Fixed a small bug. If the MSI-X vector bit has been set, the function
>> would return without executing the proper unmap.
>> Change v3->v4:
>>  - Rebased to Lorenzo's master branch v4.18-rc1.
>>  - Added static prefix to __dw_pcie_ep_find_next_cap function.
>> Change v4->v5:
>>  - Added static prefix to dw_pcie_ep_find_capability function.
>>  - Swap patch files position (#2 <-> #3).
>>  - Moved dw_pcie_ep_raise_irq and dw_plat_pcie_ep_raise_irq functions
>> signatures change to patch file #2.
>> Change v5->v6:
>>  - Nothing changed, just to follow the patch set version.
>> Change v6->v7:
>>  - Nothing changed, just to follow the patch set version.
>> Change v7->v8:
>>  - Re-sending the patch series.
>> Change v8->v9:
>>  - Nothing changed, just to follow the patch set version.
>>
>>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 144 ++++++++++++++++++++++
>>  drivers/pci/controller/dwc/pcie-designware-plat.c |   2 +
>>  drivers/pci/controller/dwc/pcie-designware.h      |  12 ++
>>  3 files changed, 158 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 69d039d..72c4188 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -40,6 +40,39 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>>  	__dw_pcie_ep_reset_bar(pci, bar, 0);
>>  }
>>  
>> +static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>> +			      u8 cap)
>> +{
>> +	u8 cap_id, next_cap_ptr;
>> +	u16 reg;
>> +
>> +	reg = dw_pcie_readw_dbi(pci, cap_ptr);
>> +	next_cap_ptr = (reg & 0xff00) >> 8;
>> +	cap_id = (reg & 0x00ff);
>> +
>> +	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
>> +		return 0;
>> +
>> +	if (cap_id == cap)
>> +		return cap_ptr;
>> +
>> +	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>> +}
>> +
>> +static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
>> +{
>> +	u8 next_cap_ptr;
>> +	u16 reg;
>> +
>> +	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>> +	next_cap_ptr = (reg & 0x00ff);
>> +
>> +	if (!next_cap_ptr)
>> +		return 0;
>> +
>> +	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>> +}
>> +
>>  static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>>  				   struct pci_epf_header *hdr)
>>  {
>> @@ -241,6 +274,45 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 encode_int)
>>  	return 0;
>>  }
>>  
>> +static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
>> +{
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u32 val, reg;
>> +
>> +	if (!ep->msix_cap)
>> +		return -EINVAL;
>> +
>> +	reg = ep->msix_cap + PCI_MSIX_FLAGS;
>> +	val = dw_pcie_readw_dbi(pci, reg);
>> +	if (!(val & PCI_MSIX_FLAGS_ENABLE))
>> +		return -EINVAL;
>> +
>> +	val &= PCI_MSIX_FLAGS_QSIZE;
>> +
>> +	return val;
>> +}
>> +
>> +static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
>> +{
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u32 val, reg;
>> +
>> +	if (!ep->msix_cap)
>> +		return -EINVAL;
>> +
>> +	reg = ep->msix_cap + PCI_MSIX_FLAGS;
>> +	val = dw_pcie_readw_dbi(pci, reg);
>> +	val &= ~PCI_MSIX_FLAGS_QSIZE;
>> +	val |= interrupts;
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +	dw_pcie_writew_dbi(pci, reg, val);
>> +	dw_pcie_dbi_ro_wr_dis(pci);
>> +
>> +	return 0;
>> +}
>> +
>>  static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
>>  				enum pci_epc_irq_type type, u16 interrupt_num)
>>  {
>> @@ -282,6 +354,8 @@ static const struct pci_epc_ops epc_ops = {
>>  	.unmap_addr		= dw_pcie_ep_unmap_addr,
>>  	.set_msi		= dw_pcie_ep_set_msi,
>>  	.get_msi		= dw_pcie_ep_get_msi,
>> +	.set_msix		= dw_pcie_ep_set_msix,
>> +	.get_msix		= dw_pcie_ep_get_msix,
>>  	.raise_irq		= dw_pcie_ep_raise_irq,
>>  	.start			= dw_pcie_ep_start,
>>  	.stop			= dw_pcie_ep_stop,
>> @@ -322,6 +396,64 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>>  	return 0;
>>  }
>>  
>> +int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>> +			     u16 interrupt_num)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	struct pci_epc *epc = ep->epc;
>> +	u16 tbl_offset, bir;
>> +	u32 bar_addr_upper, bar_addr_lower;
>> +	u32 msg_addr_upper, msg_addr_lower;
>> +	u32 reg, msg_data, vec_ctrl;
>> +	u64 tbl_addr, msg_addr, reg_u64;
>> +	void __iomem *msix_tbl;
>> +	int ret;
>> +
>> +	reg = ep->msix_cap + PCI_MSIX_TABLE;
>> +	tbl_offset = dw_pcie_readl_dbi(pci, reg);
>> +	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
>> +	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
>> +	tbl_offset >>= 3;
>> +
>> +	reg = PCI_BASE_ADDRESS_0 + (4 * bir);
>> +	bar_addr_upper = 0;
>> +	bar_addr_lower = dw_pcie_readl_dbi(pci, reg);
>> +	reg_u64 = (bar_addr_lower & PCI_BASE_ADDRESS_MEM_TYPE_MASK);
>> +	if (reg_u64 == PCI_BASE_ADDRESS_MEM_TYPE_64)
>> +		bar_addr_upper = dw_pcie_readl_dbi(pci, reg + 4);
>> +
>> +	tbl_addr = ((u64) bar_addr_upper) << 32 | bar_addr_lower;
>> +	tbl_addr += (tbl_offset + ((interrupt_num - 1) * PCI_MSIX_ENTRY_SIZE));
>> +	tbl_addr &= PCI_BASE_ADDRESS_MEM_MASK;
>> +
>> +	msix_tbl = ioremap_nocache(ep->phys_base + tbl_addr,
>> +				   PCI_MSIX_ENTRY_SIZE);
>> +	if (!msix_tbl)
>> +		return -EINVAL;
>> +
>> +	msg_addr_lower = readl(msix_tbl + PCI_MSIX_ENTRY_LOWER_ADDR);
>> +	msg_addr_upper = readl(msix_tbl + PCI_MSIX_ENTRY_UPPER_ADDR);
>> +	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
>> +	msg_data = readl(msix_tbl + PCI_MSIX_ENTRY_DATA);
>> +	vec_ctrl = readl(msix_tbl + PCI_MSIX_ENTRY_VECTOR_CTRL);
>> +
>> +	iounmap(msix_tbl);
>> +
>> +	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
>> +		return -EPERM;
>> +
>> +	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msix_mem_phys, msg_addr,
>> +				  epc->mem->page_size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	writel(msg_data, ep->msix_mem);
>> +
>> +	dw_pcie_ep_unmap_addr(epc, func_no, ep->msix_mem_phys);
>> +
>> +	return 0;
>> +}
>> +
>>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>>  {
>>  	struct pci_epc *epc = ep->epc;
>> @@ -329,6 +461,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
>>  			      epc->mem->page_size);
>>  
>> +	pci_epc_mem_free_addr(epc, ep->msix_mem_phys, ep->msix_mem,
>> +			      epc->mem->page_size);
>> +
>>  	pci_epc_mem_exit(epc);
>>  }
>>  
>> @@ -415,6 +550,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>  		dev_err(dev, "Failed to reserve memory for MSI\n");
>>  		return -ENOMEM;
>>  	}
>> +	ep->msi_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
>> +
>> +	ep->msix_mem = pci_epc_mem_alloc_addr(epc, &ep->msix_mem_phys,
>> +					     epc->mem->page_size);
>> +	if (!ep->msix_mem) {
>> +		dev_err(dev, "Failed to reserve memory for MSI-X\n");
>> +		return -ENOMEM;
> 
> Do we have to allocate memory for MSIX memory separately? I think we can reuse
> msi_mem. That's also because we shouldn't fail if a platform doesn't support
> MSIX and fails to allocate msix_mem.

Ok.

> 
> Thanks
> Kishon
> 

Regards,
Gustavo
