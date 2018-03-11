Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932473AbeCKWEV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:04:21 -0400
Received: from mail.us.es ([193.147.175.20]:44386 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932344AbeCKWES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:04:18 -0400
Date: Sun, 11 Mar 2018 23:04:14 +0100
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [RFC] netfilter: cttimeout: remove VLA in
 ctnl_timeout_parse_policy
Message-ID: <20180311220414.feda33aw72zw2rko@salvia>
References: <20180306184755.GA7628@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306184755.GA7628@embeddedgus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 12:47:55PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with dynamic memory allocation.

Looks good but...

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  net/netfilter/nfnetlink_cttimeout.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
> index 95b0470..a2f7d92 100644
> --- a/net/netfilter/nfnetlink_cttimeout.c
> +++ b/net/netfilter/nfnetlink_cttimeout.c
> @@ -52,18 +52,26 @@ ctnl_timeout_parse_policy(void *timeouts,
>  			  struct net *net, const struct nlattr *attr)
>  {
>  	int ret = 0;
> +	struct nlattr **tb = NULL;

I think we don't need to initialize this, right?

>  
>  	if (likely(l4proto->ctnl_timeout.nlattr_to_obj)) {
> -		struct nlattr *tb[l4proto->ctnl_timeout.nlattr_max+1];
> +		tb = kcalloc(l4proto->ctnl_timeout.nlattr_max + 1, sizeof(*tb),
> +			     GFP_KERNEL);
> +
> +		if (!tb)
> +			return -ENOMEM;
>  
>  		ret = nla_parse_nested(tb, l4proto->ctnl_timeout.nlattr_max,
>  				       attr, l4proto->ctnl_timeout.nla_policy,
>  				       NULL);
>  		if (ret < 0)
> -			return ret;
> +			goto err;
>  
>  		ret = l4proto->ctnl_timeout.nlattr_to_obj(tb, net, timeouts);
>  	}
> +
> +err:
> +	kfree(tb);
>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 
