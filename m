Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeFEMNy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:13:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751908AbeFEMNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:13:51 -0400
Message-ID: <cdf6ffd450b0566ce4f0024155144e1d84503eea.camel@redhat.com>
Subject: Re: [PATCH] netfilter: provide udp*_lib_lookup for nf_tproxy
From: Paolo Abeni <pabeni@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: =?ISO-8859-1?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 05 Jun 2018 14:13:47 +0200
In-Reply-To: <20180605114056.1239571-1-arnd@arndb.de>
References: <20180605114056.1239571-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-05 at 13:40 +0200, Arnd Bergmann wrote:
> It is now possible to enable the libified nf_tproxy modules without
> also enabling NETFILTER_XT_TARGET_TPROXY, which throws off the
> ifdef logic in the udp core code:
> 
> net/ipv6/netfilter/nf_tproxy_ipv6.o: In function `nf_tproxy_get_sock_v6':
> nf_tproxy_ipv6.c:(.text+0x1a8): undefined reference to `udp6_lib_lookup'
> net/ipv4/netfilter/nf_tproxy_ipv4.o: In function `nf_tproxy_get_sock_v4':
> nf_tproxy_ipv4.c:(.text+0x3d0): undefined reference to `udp4_lib_lookup'
> 
> We can actually simplify the conditions now to provide the two functions
> exactly when they are needed.
> 
> Fixes: 45ca4e0cf273 ("netfilter: Libify xt_TPROXY")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/ipv4/udp.c | 4 +---
>  net/ipv6/udp.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 4f16e5d71875..3365362cac88 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -544,9 +544,7 @@ EXPORT_SYMBOL_GPL(udp4_lib_lookup_skb);
>  /* Must be called under rcu_read_lock().
>   * Does increment socket refcount.
>   */
> -#if IS_ENABLED(CONFIG_NETFILTER_XT_MATCH_SOCKET) || \
> -    IS_ENABLED(CONFIG_NETFILTER_XT_TARGET_TPROXY) || \
> -    IS_ENABLED(CONFIG_NF_SOCKET_IPV4)
> +#if IS_ENABLED(CONFIG_NF_TPROXY_IPV4) || IS_ENABLED(CONFIG_NF_SOCKET_IPV4)
>  struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
>  			     __be32 daddr, __be16 dport, int dif)
>  {
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 967acff95bbe..164afd31aebf 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -285,9 +285,7 @@ EXPORT_SYMBOL_GPL(udp6_lib_lookup_skb);
>  /* Must be called under rcu_read_lock().
>   * Does increment socket refcount.
>   */
> -#if IS_ENABLED(CONFIG_NETFILTER_XT_MATCH_SOCKET) || \
> -    IS_ENABLED(CONFIG_NETFILTER_XT_TARGET_TPROXY) || \
> -    IS_ENABLED(CONFIG_NF_SOCKET_IPV6)
> +#if IS_ENABLED(CONFIG_NF_TPROXY_IPV6) || IS_ENABLED(CONFIG_NF_SOCKET_IPV6)
>  struct sock *udp6_lib_lookup(struct net *net, const struct in6_addr *saddr, __be16 sport,
>  			     const struct in6_addr *daddr, __be16 dport, int dif)
>  {

LGTM,

Acked-by: Paolo Abeni <pabeni@redhat.com>

Thanks,

Paolo
