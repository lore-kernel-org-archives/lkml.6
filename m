Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeDIOoz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:44:55 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42721 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeDIOox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:44:53 -0400
X-Google-Smtp-Source: AIpwx496y8uqBCEsPiuMJ8yCJsIpMW2W+1qWOFcW7tzStjrzbHGUEmBAuBSFPMRtvIdj58TScfvqiw==
Subject: Re: [PATCH] net: decnet: Replace GFP_ATOMIC with GFP_KERNEL in
 dn_route_init
To: Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net, kafai@fb.com,
        weiwan@google.com, dsa@cumulusnetworks.com, johannes.berg@intel.com,
        fw@strlen.de
Cc: linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523283035-25639-1-git-send-email-baijiaju1990@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <945ed4f2-e1e2-a038-2808-f18a79a35732@gmail.com>
Date: Mon, 9 Apr 2018 07:44:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523283035-25639-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2018 07:10 AM, Jia-Ju Bai wrote:
> dn_route_init() is never called in atomic context.
> 
> The call chain ending up at dn_route_init() is:
> [1] dn_route_init() <- decnet_init()
> decnet_init() is only set as a parameter of module_init().
> 
> Despite never getting called from atomic context,
> dn_route_init() calls __get_free_pages() with GFP_ATOMIC,
> which waits busily for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> to avoid busy waiting and improve the possibility of sucessful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  net/decnet/dn_route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
> index 0bd3afd..59ed12a 100644
> --- a/net/decnet/dn_route.c
> +++ b/net/decnet/dn_route.c
> @@ -1898,7 +1898,7 @@ void __init dn_route_init(void)
>  		while(dn_rt_hash_mask & (dn_rt_hash_mask - 1))
>  			dn_rt_hash_mask--;
>  		dn_rt_hash_table = (struct dn_rt_hash_bucket *)
> -			__get_free_pages(GFP_ATOMIC, order);
> +			__get_free_pages(GFP_KERNEL, order);
>  	} while (dn_rt_hash_table == NULL && --order > 0);
>  
>  	if (!dn_rt_hash_table)
> 

This might OOM under pressure.

This would need __GFP_NOWARN | __GFP_NORETRY  I guess, and would target net-next
