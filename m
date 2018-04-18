Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeDRXyX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 19:54:23 -0400
Received: from icp-osb-irony-out6.external.iinet.net.au ([203.59.1.106]:10019
        "EHLO icp-osb-irony-out6.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752392AbeDRXyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 19:54:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CHAQB92dda/zXSMGcNUBwBAQEEAQEKA?=
 =?us-ascii?q?QGEI4Eig2iVVgZ6KXUalGAKIwuERgKDBDgUAQIBAQEBAQECgQiFLwEBAQMjKys?=
 =?us-ascii?q?QCw0LAgImAgIxJgYBBwUGAgEBGQSEXxylUm2CHBqEPYNpgiWBCYRZgzCBB4EPI?=
 =?us-ascii?q?4IzNYMRA4EogzeCVAKXawcBhVmIXYF1hW2EcSuJCIgYM4FzMxoIKAg7gkMJghc?=
 =?us-ascii?q?XiFmFUF0BjQCCRgEB?=
X-IPAS-Result: =?us-ascii?q?A2CHAQB92dda/zXSMGcNUBwBAQEEAQEKAQGEI4Eig2iVVgZ?=
 =?us-ascii?q?6KXUalGAKIwuERgKDBDgUAQIBAQEBAQECgQiFLwEBAQMjKysQCw0LAgImAgIxJ?=
 =?us-ascii?q?gYBBwUGAgEBGQSEXxylUm2CHBqEPYNpgiWBCYRZgzCBB4EPI4IzNYMRA4Eogze?=
 =?us-ascii?q?CVAKXawcBhVmIXYF1hW2EcSuJCIgYM4FzMxoIKAg7gkMJghcXiFmFUF0BjQCCR?=
 =?us-ascii?q?gEB?=
X-IronPort-AV: E=Sophos;i="5.48,467,1517846400";
   d="scan'208";a="64024644"
Subject: Re: [PATCH -next] m68k: fix return value check in mcf_pci_init()
To: Wei Yongjun <weiyongjun1@huawei.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1524059842-22099-1-git-send-email-weiyongjun1@huawei.com>
From: Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <f5eca74a-972f-dca0-b6e3-3d5978418b88@linux-m68k.org>
Date: Thu, 19 Apr 2018 09:54:34 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524059842-22099-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On 18/04/18 23:57, Wei Yongjun wrote:
> In case of error, the function ioremap() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
> 
> Fixes: bf114d773167 ("m68k: force use of __raw_read/__raw_write address to be iomem")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks for the patch. I plan on dropping that commit completely
from next soon. Autobuilder has shown it is missing some conversions
that it was intended to cover.

Regards
Greg


> ---
>  arch/m68k/coldfire/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
> index 9d6342c..a7c2332 100644
> --- a/arch/m68k/coldfire/pci.c
> +++ b/arch/m68k/coldfire/pci.c
> @@ -218,7 +218,7 @@ static int __init mcf_pci_init(void)
>  
>  	/* Keep a virtual mapping to IO/config space active */
>  	iospace = ioremap(PCI_IO_PA, PCI_IO_SIZE);
> -	if (IS_ERR(iospace))
> +	if (!iospace)
>  		return -ENODEV;
>  	pr_info("Coldfire: PCI IO/config window mapped to 0x%p\n", iospace);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
