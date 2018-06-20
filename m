Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56135C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0562520871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tsgWMxCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0562520871
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754880AbeFTJ3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:29:16 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43296 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbeFTJ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:29:09 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5K6nK8P105446;
        Wed, 20 Jun 2018 01:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529477360;
        bh=ALwMAzvEFmXRlmCKTrMv4noIvkdL3O2jSVNdI4C9CKw=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=tsgWMxCZpKF96+BJ08eABiudIFqbJmW3CmKtFhbsN7S1InkjNqtoKNwalJwX1S24r
         CGx8aBbD51rXHpKevYr9z6KNGm35+ahB9QNVPV+RCMaxEZuZ15zhXxDrURaZ1tSpMU
         5UJv8U4H1dGCvPGNOyLyHGmYs7Mxy+7C46fdqMPg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5K6nKoU005043;
        Wed, 20 Jun 2018 01:49:20 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 20
 Jun 2018 01:49:19 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 20 Jun 2018 01:49:19 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5K6nGBM011868;
        Wed, 20 Jun 2018 01:49:16 -0500
Subject: Re: [PATCH v4 04/10] PCI: dwc: Rework MSI callbacks handler
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>
References: <cover.1529329262.git.gustavo.pimentel@synopsys.com>
 <c6320411aa93d76e3e861f6275cebb1caf6cf893.1529329262.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ef846300-1606-397e-c790-45ddee6b2417@ti.com>
Date:   Wed, 20 Jun 2018 12:19:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <c6320411aa93d76e3e861f6275cebb1caf6cf893.1529329262.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 18 June 2018 08:30 PM, Gustavo Pimentel wrote:
> Remove duplicate defines located on pcie-designware.h file already
> available on /include/uapi/linux/pci-regs.h file.
> 
> Add pci_epc_set_msi() maximum 32 interrupts validation.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v1->v2:
>  - Nothing changed, just to follow the patch set version.
> Change v2->v3:
>  - Replaced wrong return value 0 to -EINVAL.
> Change v3->v4:
>  - Rebased to Lorenzo's master branch v4.18-rc1.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 49 +++++++++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h    | 11 ------
>  drivers/pci/endpoint/pci-epc-core.c             |  3 +-
>  3 files changed, 35 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index ad25654..89d9e52 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -246,29 +246,38 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
>  
>  static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
>  {
> -	int val;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	u32 val, reg;
> +
> +	if (!ep->msi_cap)
> +		return -EINVAL;
>  
> -	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> -	if (!(val & MSI_CAP_MSI_EN_MASK))
> +	reg = ep->msi_cap + PCI_MSI_FLAGS;
> +	val = dw_pcie_readw_dbi(pci, reg);
> +	if (!(val & PCI_MSI_FLAGS_ENABLE))
>  		return -EINVAL;
>  
> -	val = (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
> +	val = (val & PCI_MSI_FLAGS_QSIZE) >> 4;
> +
>  	return val;
>  }
>  
> -static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 encode_int)
> +static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
>  {
> -	int val;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	u32 val, reg;
>  
> -	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> -	val &= ~MSI_CAP_MMC_MASK;
> -	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
> +	if (!ep->msi_cap)
> +		return -EINVAL;
> +
> +	reg = ep->msi_cap + PCI_MSI_FLAGS;
> +	val = dw_pcie_readw_dbi(pci, reg);
> +	val &= ~PCI_MSI_FLAGS_QMASK;
> +	val |= (interrupts << 1) & PCI_MSI_FLAGS_QMASK;
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
> +	dw_pcie_writew_dbi(pci, reg, val);
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	return 0;
> @@ -367,21 +376,29 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct pci_epc *epc = ep->epc;
>  	u16 msg_ctrl, msg_data;
> -	u32 msg_addr_lower, msg_addr_upper;
> +	u32 msg_addr_lower, msg_addr_upper, reg;
>  	u64 msg_addr;
>  	bool has_upper;
>  	int ret;
>  
> +	if (!ep->msi_cap)
> +		return -EINVAL;
> +
>  	/* Raise MSI per the PCI Local Bus Specification Revision 3.0, 6.8.1. */
> -	msg_ctrl = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> +	reg = ep->msi_cap + PCI_MSI_FLAGS;
> +	msg_ctrl = dw_pcie_readw_dbi(pci, reg);
>  	has_upper = !!(msg_ctrl & PCI_MSI_FLAGS_64BIT);
> -	msg_addr_lower = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
> +	reg = ep->msi_cap + PCI_MSI_ADDRESS_LO;
> +	msg_addr_lower = dw_pcie_readl_dbi(pci, reg);
>  	if (has_upper) {
> -		msg_addr_upper = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_U32);
> -		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_64);
> +		reg = ep->msi_cap + PCI_MSI_ADDRESS_HI;
> +		msg_addr_upper = dw_pcie_readl_dbi(pci, reg);
> +		reg = ep->msi_cap + PCI_MSI_DATA_64;
> +		msg_data = dw_pcie_readw_dbi(pci, reg);
>  	} else {
>  		msg_addr_upper = 0;
> -		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_32);
> +		reg = ep->msi_cap + PCI_MSI_DATA_32;
> +		msg_data = dw_pcie_readw_dbi(pci, reg);
>  	}
>  	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
>  	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index b22c5bb..a0ab12f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -96,17 +96,6 @@
>  #define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region)				\
>  			((0x3 << 20) | ((region) << 9) | (0x1 << 8))
>  
> -#define MSI_MESSAGE_CONTROL		0x52
> -#define MSI_CAP_MMC_SHIFT		1
> -#define MSI_CAP_MMC_MASK		(7 << MSI_CAP_MMC_SHIFT)
> -#define MSI_CAP_MME_SHIFT		4
> -#define MSI_CAP_MSI_EN_MASK		0x1
> -#define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
> -#define MSI_MESSAGE_ADDR_L32		0x54
> -#define MSI_MESSAGE_ADDR_U32		0x58
> -#define MSI_MESSAGE_DATA_32		0x58
> -#define MSI_MESSAGE_DATA_64		0x5C
> -
>  #define MAX_MSI_IRQS			256
>  #define MAX_MSI_IRQS_PER_CTRL		32
>  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index c72e656..094dcc3 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -201,7 +201,8 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
>  	u8 encode_int;
>  	unsigned long flags;
>  
> -	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
> +	    interrupts > 32)
>  		return -EINVAL;

This is not related to $patch->subject

Thanks
Kishon
