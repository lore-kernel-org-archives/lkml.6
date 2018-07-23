Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ECAECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBE820685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBE820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbeGWKTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:19:54 -0400
Received: from mail.us.es ([193.147.175.20]:34500 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388133AbeGWKTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:19:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3BBC34BCDF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:17:38 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4C0FD9D0E8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:17:37 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E91802310C2; Mon, 23 Jul 2018 11:14:10 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 99AA515D65F;
        Mon, 23 Jul 2018 11:13:53 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 23 Jul 2018 11:13:53 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3DABF4265A4E;
        Mon, 23 Jul 2018 11:13:53 +0200 (CEST)
Date:   Mon, 23 Jul 2018 11:15:51 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     David Miller <davem@davemloft.net>, cscnull@gmail.com,
        kadlec@blackhole.kfki.hu, johannes.berg@intel.com, Jason@zx2c4.com,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        xiyou.wangcong@gmail.com, dsahern@gmail.com,
        netfilter-devel@vger.kernel.org, tom@quantonium.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: fix memory leak of dump
Message-ID: <20180723091551.mwhltw4ujm4bylvj@salvia>
References: <20180722143354.23722-1-cscnull@gmail.com>
 <20180722163925.gdfkndldatsoae6x@breakpoint.cc>
 <20180722.100755.19840167505550163.davem@davemloft.net>
 <20180722180910.wcwhantwpm2nfxet@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722180910.wcwhantwpm2nfxet@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 08:09:10PM +0200, Florian Westphal wrote:
> David Miller <davem@davemloft.net> wrote:
> > From: Florian Westphal <fw@strlen.de>
> > Date: Sun, 22 Jul 2018 18:39:25 +0200
> > 
> > > 3. change meaning of ->done() so its always called once ->start()
> > >    was invoked (and returned 0), this requires audit of all
> > >    places that provide .done to make sure they won't trip.
> > > 
> > > 3) seems to be what Tom intended when he added .start, so probably
> > > best to investigate that first.
> > 
> > Hmmm...
> > 
> > Any time ->start() succeeds, we set cb_running to true.
> 
> Right.
> 
> > From that point forward, ->done() will be called at some point at all
> > of the locations that check if cb_running is true and set it to false.
> 
> Also right, thanks for pointing this out, I missed fact that netlink
> core restarts a dump after this.
> 
> So 3) is already true which means we should try to see if we can move
> all dump-related extra magic into ->start().
> 
> Shaochun, can you see if this is possible?
> 
> Something along these lines (totally untested), which makes this
> a netfilter fix:
> 
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -5010,6 +5013,22 @@ nft_obj_filter_alloc(const struct nlattr * const nla[])
>  	return filter;
>  }
>  
> +static int nf_tables_dump_obj_start(struct netlink_callback *cb)
> +{
> +	const struct nlattr * const *nla = cb->data;
> +	struct nft_obj_filter *filter = NULL;
> +
> +	if (nla[NFTA_OBJ_TABLE] ||
> +	    nla[NFTA_OBJ_TYPE]) {
> +		filter = nft_obj_filter_alloc(nla);
> +		if (IS_ERR(filter))
> +			return -ENOMEM;
> +	}
> +
> +	cb->data = filter;
> +	return 0;
> +}
> +
>  /* called with rcu_read_lock held */
>  static int nf_tables_getobj(struct net *net, struct sock *nlsk,
>  			    struct sk_buff *skb, const struct nlmsghdr *nlh,
> @@ -5028,21 +5047,13 @@ static int nf_tables_getobj(struct net *net, struct sock *nlsk,
>  
>  	if (nlh->nlmsg_flags & NLM_F_DUMP) {
>  		struct netlink_dump_control c = {
> +			.start = nf_tables_dump_obj_start,
>  			.dump = nf_tables_dump_obj,
>  			.done = nf_tables_dump_obj_done,
>  			.module = THIS_MODULE,
> +			.data = (void *)nla,

You cannot do this.

nla is allocated in this stack.

the nla will not be available in the second recv(), it won't be there.
