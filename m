Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5A5EAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0B6208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0B6208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934522AbeFKUvv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:51:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:22630 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933366AbeFKUvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:51:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 13:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,211,1526367600"; 
   d="scan'208";a="62279502"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2018 13:51:48 -0700
Subject: Re: [PATCH 2/8] NTB: Setup the DMA mask globally for all drivers
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc:     Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-3-logang@deltatee.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <25c67d72-9cb0-6a13-3614-b549906e222c@intel.com>
Date:   Mon, 11 Jun 2018 13:51:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180609000819.13883-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/2018 05:08 PM, Logan Gunthorpe wrote:
> Commit  417cf39cfea9 ("NTB: Set dma mask and dma coherent mask to NTB
> devices") added code to set the DMA mask for the NTB device
> to each driver individually. However, it neglected to set it for the
> Switchtec driver. So when the monolithic commit 7f46c8b3a552 ("NTB:
> ntb_tool: Add full multi-port NTB API support") started allocating
> DMA memory against the NTB device it broke the Switchtec driver.
> 
> Seeing this is setting up a property of the NTB device, it should be
> done by the common NTB code (inside ntb_register_device()) so we can be
> sure it's done properly for all drivers. This avoids each driver needing
> to duplicate the code and helps prevent us from inadvertently breaking
> one of the drivers in the future if we have to make changes in this area.
> 
> Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>
for the Intel parts and the generic parts

> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  4 ----
>  drivers/ntb/hw/idt/ntb_hw_idt.c     |  6 ------
>  drivers/ntb/hw/intel/ntb_hw_intel.c |  4 ----
>  drivers/ntb/ntb.c                   | 13 ++++++++++++-
>  4 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 3cfa46876239..f0788aae05c9 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -1020,10 +1020,6 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
>  			goto err_dma_mask;
>  		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
>  	}
> -	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> -					  dma_get_mask(&pdev->dev));
> -	if (rc)
> -		goto err_dma_mask;
>  
>  	ndev->self_mmio = pci_iomap(pdev, 0, 0);
>  	if (!ndev->self_mmio) {
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 8d98872d0983..1918a2db1c43 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2447,12 +2447,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  		dev_warn(&pdev->dev,
>  			"Cannot set consistent DMA highmem bit mask\n");
>  	}
> -	ret = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> -					   dma_get_mask(&pdev->dev));
> -	if (ret != 0) {
> -		dev_err(&pdev->dev, "Failed to set NTB device DMA bit mask\n");
> -		return ret;
> -	}
>  
>  	/*
>  	 * Enable the device advanced error reporting. It's not critical to
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 156b45cd4a19..341a3d5baa3f 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -2334,10 +2334,6 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
>  			goto err_dma_mask;
>  		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
>  	}
> -	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> -					  dma_get_mask(&pdev->dev));
> -	if (rc)
> -		goto err_dma_mask;
>  
>  	ndev->self_mmio = pci_iomap(pdev, 0, 0);
>  	if (!ndev->self_mmio) {
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 2581ab724c34..93f24440d11d 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -100,6 +100,8 @@ EXPORT_SYMBOL(ntb_unregister_client);
>  
>  int ntb_register_device(struct ntb_dev *ntb)
>  {
> +	int ret;
> +
>  	if (!ntb)
>  		return -EINVAL;
>  	if (!ntb->pdev)
> @@ -120,7 +122,16 @@ int ntb_register_device(struct ntb_dev *ntb)
>  	ntb->ctx_ops = NULL;
>  	spin_lock_init(&ntb->ctx_lock);
>  
> -	return device_register(&ntb->dev);
> +	device_initialize(&ntb->dev);
> +
> +	ret = dma_coerce_mask_and_coherent(&ntb->dev,
> +					   dma_get_mask(&ntb->pdev->dev));
> +	if (ret != 0) {
> +		dev_err(&ntb->dev, "Failed to set NTB device DMA bit mask\n");
> +		return ret;
> +	}
> +
> +	return device_add(&ntb->dev);
>  }
>  EXPORT_SYMBOL(ntb_register_device);
>  
> 
