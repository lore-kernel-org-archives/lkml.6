Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeDDGgy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:36:54 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39607 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeDDGgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:36:52 -0400
X-Google-Smtp-Source: AIpwx49QT9R8SAV7w30ZNJWcPpMwyl91FQaQjUpk45y/fb1w16Kq+nnUgTVwzfBANdfp2h2/RkLxJQ==
Subject: Re: [PATCH v2] net: thunderx: nicvf_main: Fix potential NULL pointer
 dereferences
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sunil Goutham <sgoutham@cavium.com>, Robert Richter <rric@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180403220423.GA718@embeddedor.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <6aa876e8-c94c-1ab8-2a3a-02b2b77df65f@gmail.com>
Date: Tue, 3 Apr 2018 23:36:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403220423.GA718@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2018 03:04 PM, Gustavo A. R. Silva wrote:
> Add null check on kmalloc() return value in order to prevent
> a null pointer dereference.
> 
> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Add a null check on a second kmalloc a few lines below. Thanks to
>    Eric Dumazet for pointing this out.
> 
>  drivers/net/ethernet/cavium/thunder/nicvf_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> index 1e9a31f..f7b5ca5 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> @@ -1999,10 +1999,14 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
>  				struct xcast_addr *xaddr;
>  
>  				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
> +				if (unlikely(!mc_list))
> +					return;
>  				INIT_LIST_HEAD(&mc_list->list);
>  				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
>  					xaddr = kmalloc(sizeof(*xaddr),
>  							GFP_ATOMIC);
> +					if (unlikely(!xaddr))
> +						return;

So now you leak memory :/

If you fix bugs, please do not add new ones.

>  					xaddr->addr =
>  						ether_addr_to_u64(ha->addr);
>  					list_add_tail(&xaddr->list,
> 
