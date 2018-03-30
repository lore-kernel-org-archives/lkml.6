Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeC3AW4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 20:22:56 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36618 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeC3AWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 20:22:50 -0400
X-Google-Smtp-Source: AIpwx4++JQiLfIj+Nh78DWXVqsEZv8oP0ZBTjz/HmWoittM+sgz5VvxjGal8aEN2ka+t1zPFNK6RfItHgXL8IPUqzsk=
MIME-Version: 1.0
In-Reply-To: <20180329065127.yn6sm3xvs2givubo@gauss3.secunet.de>
References: <CAMfSVWDZn28cYpseJCc=gO1uD1Cr_P5vKRW8FjaqczooyecHwg@mail.gmail.com>
 <20180329065127.yn6sm3xvs2givubo@gauss3.secunet.de>
From: Derek Robson <robsonde@gmail.com>
Date: Fri, 30 Mar 2018 13:22:49 +1300
Message-ID: <CAMfSVWBjuKaKvHtbpoAzZpyQjf88bge95Hp0mHMd_Y90H7DxLQ@mail.gmail.com>
Subject: Re: Regression in 4.16-rc7 - ipsec vpn broken
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, ben@decadent.org.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, that patch has solved issue.


On Thu, Mar 29, 2018 at 7:51 PM, Steffen Klassert
<steffen.klassert@secunet.com> wrote:
> Please always make sure to Cc netdev@vger.kernel.org
> on networking problems.
>
> On Wed, Mar 28, 2018 at 10:21:32PM +0000, Derek Robson wrote:
>> The ipsec VPN is broken in 4.16-rc7 and seem to have been broken in all of
>> 4.15
>>
>> connecting from an iphone seems to give a timeout.
>>
>>
>> A bisect brings me to this commit as the one that is the issue.
>>
>> commit: acf568ee859f098279eadf551612f103afdacb4e  (xfrm: Reinject
>> transport-mode packets through tasklet)
>
> I have a fix queued for this commit in the ipsec tree.
>
> Can you please try if the patch below fixes your problems?
>
> Thanks!
>
> Subject: [PATCH] xfrm: Fix transport mode skb control buffer usage.
>
> A recent commit introduced a new struct xfrm_trans_cb
> that is used with the sk_buff control buffer. Unfortunately
> it placed the structure in front of the control buffer and
> overlooked that the IPv4/IPv6 control buffer is still needed
> for some layer 4 protocols. As a result the IPv4/IPv6 control
> buffer is overwritten with this structure. Fix this by setting
> a apropriate header in front of the structure.
>
> Fixes acf568ee859f ("xfrm: Reinject transport-mode packets ...")
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> ---
>  net/xfrm/xfrm_input.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 1472c0857975..81788105c164 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -26,6 +26,12 @@ struct xfrm_trans_tasklet {
>  };
>
>  struct xfrm_trans_cb {
> +       union {
> +               struct inet_skb_parm    h4;
> +#if IS_ENABLED(CONFIG_IPV6)
> +               struct inet6_skb_parm   h6;
> +#endif
> +       } header;
>         int (*finish)(struct net *net, struct sock *sk, struct sk_buff *skb);
>  };
>
> --
> 2.14.1
>
