Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeDDKCI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:02:08 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:11270 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeDDKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:02:07 -0400
Subject: Re: [crypto-chtls] Supicious code in chtls_io
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180403214652.GA31283@embeddedor.com>
From: Atul Gupta <atul.gupta@chelsio.com>
Message-ID: <e9b07de5-4c48-b85e-e4d5-6bfc7df1982c@chelsio.com>
Date: Wed, 4 Apr 2018 15:31:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403214652.GA31283@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/2018 3:16 AM, Gustavo A. R. Silva wrote:
> Hi all,
>
> While doing some static analysis I came across the following piece of code at drivers/crypto/chelsio/chtls/chtls_io.c:1203:
>
> 1203                 if (!size)
> 1204                         break;
> 1205 
> 1206                 if (unlikely(ULP_SKB_CB(skb)->flags & ULPCB_FLAG_NO_APPEND))
> 1207                         push_frames_if_head(sk);
> 1208                 continue;
> 1209 
> 1210                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> 1211         }
>
>
> The issue is that in the code above, set_bit is never reached due to the 'continue' statement at line 1208.
>
> I wonder if the actual intention of the code was something like this:
>
> diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
> index 5a75be4..a949a6c 100644
> --- a/drivers/crypto/chelsio/chtls/chtls_io.c
> +++ b/drivers/crypto/chelsio/chtls/chtls_io.c
> @@ -1203,9 +1203,10 @@ int chtls_sendpage(struct sock *sk, struct page *page,
>                 if (!size)
>                         break;
>  
> -               if (unlikely(ULP_SKB_CB(skb)->flags & ULPCB_FLAG_NO_APPEND))
> +               if (unlikely(ULP_SKB_CB(skb)->flags & ULPCB_FLAG_NO_APPEND)) {
>                         push_frames_if_head(sk);
> -               continue;
> +                       continue;
> +               }
>  
>                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>         }
>
>
> What do you think?
Thanks for pointing, there is additional change required. I will send the patch once the window opens.
>
> I can send a proper patch for this.
>
> Thanks
> --
> Gustavo
