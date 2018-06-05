Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeFENI1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:08:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58769 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751744AbeFENI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:08:26 -0400
Subject: Re: [PATCH net-next] net: fddi: fix a possible null-ptr-deref
To: <davem@davemloft.net>
References: <20180605100627.16184-1-yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <d1dc0497-7b03-111a-9c58-594eeb9c67fc@huawei.com>
Date: Tue, 5 Jun 2018 21:08:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180605100627.16184-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/5 18:06, YueHaibing wrote:
> bp->SharedMemAddr is set to NULL while bp->SharedMemSize less than 0,
> then memset will trigger null-ptr-deref.
> 
> Fix it use pci_zalloc_consistent when bp->SharedMemSize is greater than 0.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/fddi/skfp/skfddi.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/fddi/skfp/skfddi.c b/drivers/net/fddi/skfp/skfddi.c
> index 2414f1d..90164e0 100644
> --- a/drivers/net/fddi/skfp/skfddi.c
> +++ b/drivers/net/fddi/skfp/skfddi.c
> @@ -407,23 +407,21 @@ static  int skfp_driver_init(struct net_device *dev)
>  	if (bp->SharedMemSize > 0) {
>  		bp->SharedMemSize += 16;	// for descriptor alignment
>  
> -		bp->SharedMemAddr = pci_alloc_consistent(&bp->pdev,
> -							 bp->SharedMemSize,
> -							 &bp->SharedMemDMA);
> +		bp->SharedMemAddr = pci_zalloc_consistent(&bp->pdev,
> +							  bp->SharedMemSize,
> +							  &bp->SharedMemDMA);

This also need move from pci_dma* to dma_*, will send v2

>  		if (!bp->SharedMemAddr) {
>  			printk("could not allocate mem for ");
>  			printk("hardware module: %ld byte\n",
>  			       bp->SharedMemSize);
>  			goto fail;
>  		}
> -		bp->SharedMemHeap = 0;	// Nothing used yet.
>  
>  	} else {
>  		bp->SharedMemAddr = NULL;
> -		bp->SharedMemHeap = 0;
>  	}			// SharedMemSize > 0
>  
> -	memset(bp->SharedMemAddr, 0, bp->SharedMemSize);
> +	bp->SharedMemHeap = 0;
>  
>  	card_stop(smc);		// Reset adapter.
>  
> 
