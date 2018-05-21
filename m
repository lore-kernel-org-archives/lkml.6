Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeEUNZe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:25:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37536 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeEUNZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:25:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 276FA601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] PCI: Do not enable PASID when End-to-End TLP is not
 supported
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
References: <1526748769-701-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <c8184d48-a343-503a-83a3-707e44961f1a@codeaurora.org>
Date: Mon, 21 May 2018 09:25:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526748769-701-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+iommu folks.

On 5/19/2018 12:52 PM, Sinan Kaya wrote:
> A PCIe endpoint carries the process address space identifier (PASID) in
> the TLP prefix as part of the memory read/write transaction. The address
> information in the TLP is relevant only for a given PASID context.
> 
> A translation agent takes PASID value and the address information from the
> TLP to look up the physical address in the system.
> 
> If a bridge drops the TLP prefix, the translation agent can resolve the
> address to an incorrect location and cause data corruption. Prevent
> this condition by requiring End-to-End TLP prefix to be supported on the
> entire data path between the endpoint and the root port.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/ats.c             | 16 ++++++++++++++++
>  include/uapi/linux/pci_regs.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 89305b5..0bcded5 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -265,7 +265,9 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
>  int pci_enable_pasid(struct pci_dev *pdev, int features)
>  {
>  	u16 control, supported;
> +	struct pci_dev *bridge;
>  	int pos;
> +	u32 cap;
>  
>  	if (WARN_ON(pdev->pasid_enabled))
>  		return -EBUSY;
> @@ -274,6 +276,20 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (!pos)
>  		return -EINVAL;
>  
> +	bridge = pci_upstream_bridge(pdev);
> +	while (bridge) {
> +		if (!pci_find_capability(bridge, PCI_CAP_ID_EXP))
> +			return -EINVAL;
> +
> +		if (pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap))
> +			return -EINVAL;
> +
> +		if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
> +			return -EINVAL;
> +
> +		bridge = pci_upstream_bridge(bridge);
> +	}
> +
>  	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
>  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 103ba79..d91dea5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -634,6 +634,7 @@
>  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
>  #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
>  #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
> +#define PCI_EXP_DEVCAP2_E2ETLP		0x00200000 /* End-to-End TLP Prefix */
>  #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
>  #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
>  #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
