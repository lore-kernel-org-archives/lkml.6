Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbeFAQmQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:42:16 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46725 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeFAQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:42:13 -0400
X-Google-Smtp-Source: ADUXVKIC0C47XYqMnw8UVBRiAQRX7wMwBrv2jhEldXhbjoa1y8mCbI5rH01Jtim//FrTf4n0V55poA==
Subject: Re: [PATCH net] ipv6: omit traffic class when calculating flow hash
To: Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Tom Herbert <tom@herbertland.com>
References: <20180601112948.93BE7A0C48@unicorn.suse.cz>
From: David Ahern <dsahern@gmail.com>
Message-ID: <4c70b2ef-20c2-0e7c-d1f6-7d4c97e566f2@gmail.com>
Date: Fri, 1 Jun 2018 10:42:10 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601112948.93BE7A0C48@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/18 4:34 AM, Michal Kubecek wrote:
> Some of the code paths calculating flow hash for IPv6 use flowlabel member
> of struct flowi6 which, despite its name, encodes both flow label and
> traffic class. If traffic class changes within a TCP connection (as e.g.
> ssh does), ECMP route can switch between path. It's also incosistent with
> other code paths where ip6_flowlabel() (returning only flow label) is used
> to feed the key.
> 
> Use only flow label everywhere, including one place where hash key is set
> using ip6_flowinfo().
> 
> Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
> Fixes: f70ea018da06 ("net: Add functions to get skb->hash based on flow structures")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---
>  net/core/flow_dissector.c | 3 ++-
>  net/ipv6/route.c          | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index d29f09bc5ff9..441d3db76e8e 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1334,7 +1334,8 @@ __u32 __get_hash_from_flowi6(const struct flowi6 *fl6, struct flow_keys *keys)
>  	keys->ports.src = fl6->fl6_sport;
>  	keys->ports.dst = fl6->fl6_dport;
>  	keys->keyid.keyid = fl6->fl6_gre_key;
> -	keys->tags.flow_label = (__force u32)fl6->flowlabel;
> +	keys->tags.flow_label = (__force u32)(fl6->flowlabel &
> +					      IPV6_FLOWLABEL_MASK);
>  	keys->basic.ip_proto = fl6->flowi6_proto;
>  
>  	return flow_hash_from_keys(keys);
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index f4d61736c41a..fcbacf1677f8 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1868,7 +1868,7 @@ static void ip6_multipath_l3_keys(const struct sk_buff *skb,
>  	} else {
>  		keys->addrs.v6addrs.src = key_iph->saddr;
>  		keys->addrs.v6addrs.dst = key_iph->daddr;
> -		keys->tags.flow_label = ip6_flowinfo(key_iph);
> +		keys->tags.flow_label = ip6_flowlabel(key_iph);
>  		keys->basic.ip_proto = key_iph->nexthdr;
>  	}
>  }
> @@ -1889,7 +1889,8 @@ u32 rt6_multipath_hash(const struct net *net, const struct flowi6 *fl6,
>  		} else {
>  			hash_keys.addrs.v6addrs.src = fl6->saddr;
>  			hash_keys.addrs.v6addrs.dst = fl6->daddr;
> -			hash_keys.tags.flow_label = (__force u32)fl6->flowlabel;
> +			hash_keys.tags.flow_label = (__force u32)(fl6->flowlabel &
> +								  IPV6_FLOWLABEL_MASK);
>  			hash_keys.basic.ip_proto = fl6->flowi6_proto;
>  		}
>  		break;
> 

Can you make an inline for the flowlabel conversion. Something like this:

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 798558fd1681..e36eca2f8531 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -284,6 +284,11 @@ struct ip6_flowlabel {
 #define IPV6_FLOWLABEL_MASK            cpu_to_be32(0x000FFFFF)
 #define IPV6_FLOWLABEL_STATELESS_FLAG  cpu_to_be32(0x00080000)

+static inline u32 flowi6_get_flowlabel(const struct flowi6 *fl6)
+{
+       return (__force u32)(fl6->flowlabel & IPV6_FLOWLABEL_MASK);
+}
+
 #define IPV6_TCLASS_MASK (IPV6_FLOWINFO_MASK & ~IPV6_FLOWLABEL_MASK)
 #define IPV6_TCLASS_SHIFT      20

>From there we can fix the flow struct to have flowinfo instead of
flowlabel and use the macro to hide the conversion.
