Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeDCVrj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:47:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43192 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeDCVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:47:37 -0400
X-Google-Smtp-Source: AIpwx4+3ocfOmihk55vhzp1nfW94Au5u2diACigWIJB5nQpqp6OH2nipT4xQDlQlU4KmnsZBItIfXg==
Subject: Re: [PATCH] net: thunderx: nicvf_main: Fix potential NULL pointer
 dereference
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sunil Goutham <sgoutham@cavium.com>, Robert Richter <rric@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180403212925.GA31093@embeddedor.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <f0deebb5-06e8-d788-0e68-0c15c979028c@gmail.com>
Date: Tue, 3 Apr 2018 14:47:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403212925.GA31093@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2018 02:29 PM, Gustavo A. R. Silva wrote:
> Add null check on kmalloc() return value in order to prevent
> a null pointer dereference.
> 
> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/cavium/thunder/nicvf_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> index 1e9a31f..468321a 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> @@ -1999,6 +1999,8 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
>  				struct xcast_addr *xaddr;
>  
>  				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
> +				if (unlikely(!mc_list))
> +					return;
>  				INIT_LIST_HEAD(&mc_list->list);
>  				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
>  					xaddr = kmalloc(sizeof(*xaddr),
> 

What about the second kmalloc() right there ?
