Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeFCPAr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 11:00:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42038 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbeFCPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 11:00:45 -0400
X-Google-Smtp-Source: ADUXVKLwJFmUFFXQjo6lUmy/IzbHP7BjRPQ7eTT1DD34T/7GzgxnEGQvNTwh/0jXoifsgWV3mEP9dA==
Subject: Re: [PATCH net v2] ipv6: omit traffic class when calculating flow
 hash
To: Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Tom Herbert <tom@herbertland.com>, Ido Schimmel <idosch@idosch.org>
References: <20180602080528.54B27A0C48@unicorn.suse.cz>
From: David Ahern <dsahern@gmail.com>
Message-ID: <687af1bc-a1f9-c0d2-dd3a-eeef3a2bf9b4@gmail.com>
Date: Sun, 3 Jun 2018 09:00:42 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180602080528.54B27A0C48@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/18 1:40 AM, Michal Kubecek wrote:
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 836f31af1369..7fbdc3e9e25d 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -906,6 +906,11 @@ static inline __be32 ip6_make_flowinfo(unsigned int tclass, __be32 flowlabel)
>  	return htonl(tclass << IPV6_TCLASS_SHIFT) | flowlabel;
>  }
>  
> +static inline u32 flowi6_get_flowlabel(const struct flowi6 *fl6)
> +{
> +	return (__force u32)(fl6->flowlabel & IPV6_FLOWLABEL_MASK);
> +}
> +
>  /*
>   *	Prototypes exported by ipv6
>   */

discussing the fix for net-next and making the label vs info consistent,
Michal notes a few places where this helper is needed as a __be32, so
the typecast should be outside of this helper.
