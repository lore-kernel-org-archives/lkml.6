Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64601C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171EC208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNqysKRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171EC208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbeGaMes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731428AbeGaMes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:34:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E37208A2;
        Tue, 31 Jul 2018 10:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533034502;
        bh=55RG9NQM/u5eN/hioFHCKJQKp+lYMs65fhggjCo+PPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNqysKRB2FY++PbQJdzy594FRMRpoMOmxmcu2XmLUe6fFm+xMwcLRGH/i1i7GjWRv
         2QuYmgzYZ7F+H/vS5jVpo15tzm68wrhbsSbPv7faIp+DFvr3SkZDy15ClaGpzdUWJS
         u9RK1dX5mQhAjebgisv9mfOWsV10RzZcjKhQxlCE=
Date:   Tue, 31 Jul 2018 05:54:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common
 code
Message-ID: <20180731105459.GH45322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180730073842.16092-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730073842.16092-1-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:38:42AM +0200, Christoph Hellwig wrote:
> There is nothing arch specific about PCI or dma-debug, so move this
> call to common code just after registering the bus type.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied with acks from Thomas and Michael to pci/misc for v4.19, thanks!

> ---
>  arch/powerpc/kernel/dma.c | 3 ---
>  arch/sh/drivers/pci/pci.c | 2 --
>  arch/x86/kernel/pci-dma.c | 3 ---
>  drivers/pci/pci-driver.c  | 2 +-
>  4 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 155170d70324..dbfc7056d7df 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -357,9 +357,6 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
>  
>  static int __init dma_init(void)
>  {
> -#ifdef CONFIG_PCI
> -	dma_debug_add_bus(&pci_bus_type);
> -#endif
>  #ifdef CONFIG_IBMVIO
>  	dma_debug_add_bus(&vio_bus_type);
>  #endif
> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index e5b7437ab4af..8256626bc53c 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -160,8 +160,6 @@ static int __init pcibios_init(void)
>  	for (hose = hose_head; hose; hose = hose->next)
>  		pcibios_scanbus(hose);
>  
> -	dma_debug_add_bus(&pci_bus_type);
> -
>  	pci_initialized = 1;
>  
>  	return 0;
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index ab5d9dd668d2..43f58632f123 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -155,9 +155,6 @@ static int __init pci_iommu_init(void)
>  {
>  	struct iommu_table_entry *p;
>  
> -#ifdef CONFIG_PCI
> -	dma_debug_add_bus(&pci_bus_type);
> -#endif
>  	x86_init.iommu.iommu_init();
>  
>  	for (p = __iommu_table; p < __iommu_table_end; p++) {
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 6792292b5fc7..bef17c3fca67 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1668,7 +1668,7 @@ static int __init pci_driver_init(void)
>  	if (ret)
>  		return ret;
>  #endif
> -
> +	dma_debug_add_bus(&pci_bus_type);
>  	return 0;
>  }
>  postcore_initcall(pci_driver_init);
> -- 
> 2.18.0
> 
