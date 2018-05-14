Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753911AbeENOKW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:10:22 -0400
Received: from icp-osb-irony-out5.external.iinet.net.au ([203.59.1.221]:44310
        "EHLO icp-osb-irony-out5.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753707AbeENOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:10:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ClAAC6l/la/6SIBjoNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGJOZU7AQEGfymBD5UqhHcCgzI4FAECAQEBAQEBAoY9AQEBAyMEEUE?=
 =?us-ascii?q?QCw0BCgICJgICVwYBDAgBAYMfgXSpaW2BaTMahD6DZYIngQmEeIMwgQeBDyOCO?=
 =?us-ascii?q?i6Hc4JUApg2CAGOS4E8g2WCUIUEkggzgXMzGggoCIJ/gh8XjimRQwEB?=
X-IPAS-Result: =?us-ascii?q?A2ClAAC6l/la/6SIBjoNTxoBAQEBAQIBAQEBCAEBAQGJOZU?=
 =?us-ascii?q?7AQEGfymBD5UqhHcCgzI4FAECAQEBAQEBAoY9AQEBAyMEEUEQCw0BCgICJgICV?=
 =?us-ascii?q?wYBDAgBAYMfgXSpaW2BaTMahD6DZYIngQmEeIMwgQeBDyOCOi6Hc4JUApg2CAG?=
 =?us-ascii?q?OS4E8g2WCUIUEkggzgXMzGggoCIJ/gh8XjimRQwEB?=
X-IronPort-AV: E=Sophos;i="5.49,400,1520870400";
   d="scan'208";a="133346943"
Subject: Re: [RFC] m68k: Set up dma mask for platform devices
To: Finn Thain <fthain@telegraphics.com.au>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <S1751284AbeEMBAx/20180513010053Z+394@vger.kernel.org>
From: Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <75ea772a-75d8-d24b-880c-2cd64706db9b@linux-m68k.org>
Date: Tue, 15 May 2018 00:10:15 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <S1751284AbeEMBAx/20180513010053Z+394@vger.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On 13/05/18 11:00, Finn Thain wrote:
> This avoids a WARNING splat when loading the macsonic or macmace driver.
> Please see commit 205e1b7f51e4 ("dma-mapping: warn when there is no
> coherent_dma_mask").
> 
> This implementation of arch_setup_pdev_archdata() differs from the one
> in arch/powerpc in that this one avoids clobbering an existing dma mask.
> For example, this approach preserves the mask set by the initializer for
> struct platform_device mcf_fec0.
> 
> Note that either approach would make that initializer redundant and
> commit f61e64310b75 ("m68k: set dma and coherent masks for platform
> FEC ethernets") could be reverted.

Seems reasonable to me. I would be happy to do this and the back out
commit f61e64310b75 ("m68k: set dma and coherent masks for platform
FEC ethernets").

Regards
Greg


> ---
>   arch/m68k/kernel/dma.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
> index c01b9b8f97bf..463572c4943f 100644
> --- a/arch/m68k/kernel/dma.c
> +++ b/arch/m68k/kernel/dma.c
> @@ -9,6 +9,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/device.h>
>   #include <linux/kernel.h>
> +#include <linux/platform_device.h>
>   #include <linux/scatterlist.h>
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
> @@ -165,3 +166,12 @@ const struct dma_map_ops m68k_dma_ops = {
>   	.sync_sg_for_device	= m68k_dma_sync_sg_for_device,
>   };
>   EXPORT_SYMBOL(m68k_dma_ops);
> +
> +void arch_setup_pdev_archdata(struct platform_device *pdev)
> +{
> +	if (pdev->dev.coherent_dma_mask == DMA_MASK_NONE &&
> +	    pdev->dev.dma_mask == NULL) {
> +		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> +	}
> +}
> 
