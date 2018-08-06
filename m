Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDEFC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388D921A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yqhJwU+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388D921A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbeHFXOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:32920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbeHFXOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:14:52 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5269D21A3B;
        Mon,  6 Aug 2018 21:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533589439;
        bh=TBbs6MPXPCwbBgeqtWlIyZSqPCNEvjksmxswD2I3Yq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqhJwU+C6u9x7JRtyBrJ0C1roGinXcRNUtAmCWUjuKlzefbpnazV973mUa7rCP4js
         4KFsdbYiJcSSwagQOILZ5JGKesS5p0+xVjMc5RDaL3Zj0y/Z/gqGxhFbhmjFDkQT++
         6OjRqxe6JCZGxqn7TuGn6L6TtlSje4Lw7uYDvpFE=
Date:   Mon, 6 Aug 2018 16:03:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH 2/3] PCI: Use dedicated Xilinx controller irq number for
 AER
Message-ID: <20180806210357.GD30691@bhelgaas-glaptop.roam.corp.google.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-3-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533141889-19962-3-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 10:14:48PM +0530, Bharat Kumar Gogada wrote:
> Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
> Error Interrupt Message Number. The controller has dedicated interrupt line
> for reporting PCIe errors along with AER.
> 
> Using pci_dev->sysdata of root port to save controller irq number, which
> will be used for registering AER irq handler.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/quirks.c |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f439de8..e666373 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4753,3 +4753,32 @@ static void quirk_gpu_hda(struct pci_dev *hda)
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
> +
> +#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_PCIE_XILINX_NWL) && \
> +	defined(CONFIG_PCIEAER)
> +/*
> + * Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
> + * Error Interrupt Message Number. The controller has dedicated interrupt line
> + * for reporting PCIe errors along with AER.

Your comment says "PCIe errors along with AER", but your ifdef tests
CONFIG_PCIEAER.  Per PCIe r4.0, sec 6.2.6, interrupts can be generated
even if AER isn't supported.  Don't we want to allow that?

> + */
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +
> +static void quirk_xilinx_aer_irq(struct pci_dev *dev)
> +{
> +	struct device_node *dev_node;
> +
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR)) {
> +		dev_node = of_find_compatible_node(NULL, NULL,
> +						   "xlnx,nwl-pcie-2.11");
> +		if (!dev_node) {
> +			dev_err(&dev->dev, "Error could not find ZynqMP PS PCIe node\n");

Use pci_err().

Doesn't arm64 support generic kernels that may contain support for
several platforms?  We don't want a warning if a generic kernel
happens to be running on a non-ZynqMP system.

> +			return;
> +		}
> +
> +		dev->sysdata = dev_node->data;
> +	}
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, PCI_ANY_ID, quirk_xilinx_aer_irq);
> +#endif
> -- 
> 1.7.1
> 
