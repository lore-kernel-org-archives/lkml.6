Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeC2JmQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 05:42:16 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:25359 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC2JmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 05:42:14 -0400
Subject: Re: [PATCH v5 04/12] PCI: endpoint: Setting 64-bit/prefetch bit is
 invalid when IO is set
To: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-5-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2afdb97d-eb07-031b-bb24-7166d011ee5b@ti.com>
Date: Thu, 29 Mar 2018 15:12:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-5-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> If flag PCI_BASE_ADDRESS_SPACE_IO is set, also having any
> PCI_BASE_ADDRESS_MEM_* bit set is invalid.
> 
> This sanity check is done in pci_epc_set_bar(), so that we don't need
> to do this sanity check in all epc->ops->set_bar() implementations.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 109d75f0b7d2..40eea20d21f9 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -309,10 +309,13 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>  {
>  	int ret;
>  	unsigned long irq_flags;
> +	int flags = epf_bar->flags;
>  
>  	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>  	    (epf_bar->barno == BAR_5 &&
> -	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
> +	     flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
> +	    (flags & PCI_BASE_ADDRESS_SPACE_IO &&
> +	     flags & PCI_BASE_ADDRESS_IO_MASK))
>  		return -EINVAL;

If possible I'd like this to be split. But otherwise

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>  
>  	if (!epc->ops->set_bar)
> 
