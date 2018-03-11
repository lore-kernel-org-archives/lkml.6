Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeCKTwq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:52:46 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:47497 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932161AbeCKTwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:52:45 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:4321:4385:4605:5007:6117:7514:10004:10400:10848:11026:11232:11658:11914:12043:12296:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:13972:14181:14659:14721:21060:21080:21451:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:31,LUA_SUMMARY:none
X-HE-Tag: tank68_8c2396a62f749
X-Filterd-Recvd-Size: 2807
Message-ID: <1520797961.19456.4.camel@perches.com>
Subject: Re: [PATCH v2] net: netfilter: Replace printk() with appropriate
 pr_*() macro
From: Joe Perches <joe@perches.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>, pablo@netfilter.org
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Mar 2018 12:52:41 -0700
In-Reply-To: <20180311194104.GA17450@seema-Inspiron-15-3567>
References: <20180311194104.GA17450@seema-Inspiron-15-3567>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 01:11 +0530, Arushi Singhal wrote:
> Using pr_<loglevel>() is more concise than
> printk(KERN_<LOGLEVEL>).
> Replace printks having a log level with the appropriate
> pr_*() macros.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
> *in v1 printk() were replaced with netdev_*()

>  net/netfilter/nf_conntrack_acct.c      | 2 +-
>  net/netfilter/nf_conntrack_ecache.c    | 2 +-
>  net/netfilter/nf_conntrack_timestamp.c | 2 +-
>  net/netfilter/nf_nat_core.c            | 2 +-
>  net/netfilter/nfnetlink_queue.c        | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)

None of these files have a #define for pr_fmt so this
should be OK.

Perhaps coalesce the formats and remove the unnecessary periods too.

> diff --git a/net/netfilter/nf_conntrack_acct.c b/net/netfilter/nf_conntrack_acct.c
[]
> @@ -80,7 +80,7 @@ static int nf_conntrack_acct_init_sysctl(struct net *net)
>  	net->ct.acct_sysctl_header = register_net_sysctl(net, "net/netfilter",
>  							 table);
>  	if (!net->ct.acct_sysctl_header) {
> -		printk(KERN_ERR "nf_conntrack_acct: can't register to sysctl.\n");
> +		pr_err("nf_conntrack_acct: can't register to sysctl.\n");
>  		goto out_register;
>  	}
>  	return 0;

etc...

> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
[]
> @@ -834,8 +834,8 @@ nfqnl_mangle(void *data, int data_len, struct nf_queue_entry *e, int diff)
>  			nskb = skb_copy_expand(e->skb, skb_headroom(e->skb),
>  					       diff, GFP_ATOMIC);
>  			if (!nskb) {
> -				printk(KERN_WARNING "nf_queue: OOM "
> -				      "in mangle, dropping packet\n");
> +				pr_warn("nf_queue: OOM "
> +					"in mangle, dropping packet\n");
>  				return -ENOMEM;
>  			}
>  			kfree_skb(e->skb);
