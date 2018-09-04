Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1750C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790D120843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z9yfsUl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790D120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeIDSON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbeIDSON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:14:13 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353D92077C;
        Tue,  4 Sep 2018 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536068940;
        bh=JI6vT8kEsOZ9HRwzJ9r7AKZHawK9hXLqVnHfDkVtFgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z9yfsUl9tc7moQOBBrofOZZ/aEqmpH2E9SW1doGaSStpOeuiVxqeaJDU45larkwe/
         gZcuXZnmjWXyZP9/zoa9Wh55hZtCCh4P4Pr3CjEgVPJl0E0gk3oOU1j/5wP4h7ccjc
         oNjm6ZhunOex8NBlyhSxCSB4BAwiItbxxC2/4vTk=
Date:   Tue, 4 Sep 2018 08:48:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH 4/4] PCI: xilinx-nwl: Add method to
 setup_platform_service_irq hook
Message-ID: <20180904134859.GC107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 09:09:40PM +0530, Bharat Kumar Gogada wrote:
> Add nwl_setup_service_irqs hook to setup_platform_service_irq IRQs to
> register platform provided IRQ number to kernel AER service.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index fb32840..285647b 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -22,6 +22,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  
>  #include "../pci.h"
> +#include "../pcie/portdrv.h"
>  
>  /* Bridge core config registers */
>  #define BRCFG_PCIE_RX0			0x00000000
> @@ -819,6 +820,20 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
>  	return 0;
>  }
>  
> +int nwl_setup_service_irqs(struct pci_host_bridge *bridge, int *irqs,
> +			   int plat_mask)
> +{
> +	struct nwl_pcie *pcie;
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	if (plat_mask & PCIE_PORT_SERVICE_AER) {
> +		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pcie->irq_misc;
> +		plat_mask &= ~(1 << PCIE_PORT_SERVICE_AER_SHIFT);
> +	}

If I understand correctly, this ultimately results in pcie->irq_misc
being hooked up to aer_irq() via the aer_probe() path.  We already
have pcie->irq_misc being hooked up to nwl_pcie_misc_handler() via
nwl_pcie_bridge_init().

We can't rely on the ordering of the two handlers.  Is it safe if
nwl_pcie_misc_handler() runs first, followed by aer_irq()?  It looks
like nwl_pcie_misc_handler() might log messages and clear AER-related
errors.  If that's the case aer_irq() might not find anything to do.

> +
> +	return plat_mask;
> +}
> +
>  static const struct of_device_id nwl_pcie_of_match[] = {
>  	{ .compatible = "xlnx,nwl-pcie-2.11", },
>  	{}
> @@ -880,6 +895,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>  	bridge->ops = &nwl_pcie_ops;
>  	bridge->map_irq = of_irq_parse_and_map_pci;
>  	bridge->swizzle_irq = pci_common_swizzle;
> +	bridge->setup_platform_service_irq = nwl_setup_service_irqs;
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		err = nwl_pcie_enable_msi(pcie);
> -- 
> 1.7.1
> 
