Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968866AbeE3Jih (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:38:37 -0400
Received: from elvis.franken.de ([193.175.24.41]:48839 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965196AbeE3Jic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:38:32 -0400
Date: Wed, 30 May 2018 11:01:51 +0200
From: Tom Bogendoerfer <tsbogend@alpha.franken.de>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sonic: Use dma_mapping_error()
Message-ID: <20180530090151.GA2004@alpha.franken.de>
References: <cba8175deaf9d631ae000088aea1ccf1c444909b.1527649393.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba8175deaf9d631ae000088aea1ccf1c444909b.1527649393.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 01:03:51PM +1000, Finn Thain wrote:
> With CONFIG_DMA_API_DEBUG=y, calling sonic_open() produces the
> message, "DMA-API: device driver failed to check map error".
> Add the missing dma_mapping_error() call.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  drivers/net/ethernet/natsemi/sonic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
> index 7ed08486ae23..c805dcbebd02 100644
> --- a/drivers/net/ethernet/natsemi/sonic.c
> +++ b/drivers/net/ethernet/natsemi/sonic.c
> @@ -84,7 +84,7 @@ static int sonic_open(struct net_device *dev)
>  	for (i = 0; i < SONIC_NUM_RRS; i++) {
>  		dma_addr_t laddr = dma_map_single(lp->device, skb_put(lp->rx_skb[i], SONIC_RBSIZE),
>  		                                  SONIC_RBSIZE, DMA_FROM_DEVICE);
> -		if (!laddr) {
> +		if (dma_mapping_error(lp->device, laddr)) {
>  			while(i > 0) { /* free any that were mapped successfully */
>  				i--;
>  				dma_unmap_single(lp->device, lp->rx_laddr[i], SONIC_RBSIZE, DMA_FROM_DEVICE);
> -- 
> 2.16.1

looks good

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
