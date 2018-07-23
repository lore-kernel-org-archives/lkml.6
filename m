Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456EBECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BF020875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BF020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbeGWKjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:39:20 -0400
Received: from mail.us.es ([193.147.175.20]:46026 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388043AbeGWKjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:39:20 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A5C8F4BCE1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:36:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C6B06DA4C2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:36:58 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C5BA8DA57F; Mon, 23 Jul 2018 11:36:58 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 46502DA861;
        Mon, 23 Jul 2018 11:36:56 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 23 Jul 2018 11:36:56 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BEF024265A4E;
        Mon, 23 Jul 2018 11:36:56 +0200 (CEST)
Date:   Mon, 23 Jul 2018 11:38:55 +0200
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
Message-ID: <20180723093855.c4ncixsnkee6r34v@salvia>
References: <20180722143354.23722-1-cscnull@gmail.com>
 <20180722163925.gdfkndldatsoae6x@breakpoint.cc>
 <20180722.100755.19840167505550163.davem@davemloft.net>
 <20180722180910.wcwhantwpm2nfxet@breakpoint.cc>
 <20180723091551.mwhltw4ujm4bylvj@salvia>
 <20180723092818.ztsfsnqzxgzrauim@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723092818.ztsfsnqzxgzrauim@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 11:28:18AM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> > > --- a/net/netfilter/nf_tables_api.c
> > > +++ b/net/netfilter/nf_tables_api.c
> > > @@ -5010,6 +5013,22 @@ nft_obj_filter_alloc(const struct nlattr * const nla[])
> > >  	return filter;
> > >  }
> > >  
> > > +static int nf_tables_dump_obj_start(struct netlink_callback *cb)
> > > +{
> > > +	const struct nlattr * const *nla = cb->data;
> 
> On-Stack input.
> I can't see how its wrong, ->start() happens from same context as
> netlink_dump_start so its valid.
> 
> > > +	struct nft_obj_filter *filter = NULL;
> > > +
> > > +	if (nla[NFTA_OBJ_TABLE] ||
> > > +	    nla[NFTA_OBJ_TYPE]) {
> > > +		filter = nft_obj_filter_alloc(nla);
> > > +		if (IS_ERR(filter))
> > > +			return -ENOMEM;
> > > +	}
> > > +
> > > +	cb->data = filter;
> 
> And this replaced the on-stack input with dynamically
> allocated one, which will be free'd via ->done().
> 
> > >  /* called with rcu_read_lock held */
> > >  static int nf_tables_getobj(struct net *net, struct sock *nlsk,
> > >  			    struct sk_buff *skb, const struct nlmsghdr *nlh,
> > > @@ -5028,21 +5047,13 @@ static int nf_tables_getobj(struct net *net, struct sock *nlsk,
> > >  
> > >  	if (nlh->nlmsg_flags & NLM_F_DUMP) {
> > >  		struct netlink_dump_control c = {
> > > +			.start = nf_tables_dump_obj_start,
> > >  			.dump = nf_tables_dump_obj,
> > >  			.done = nf_tables_dump_obj_done,
> > >  			.module = THIS_MODULE,
> > > +			.data = (void *)nla,
> > 
> > You cannot do this.
> > 
> > nla is allocated in this stack.
> 
> Yes.
> 
> > the nla will not be available in the second recv(), it won't be there.
> 
> Its replaced in ->start().
> 
> As David pointed out, once ->start() returns 0 we set cb_running, i.e.
> only after successful ->start() netlink core will call ->dump() again.
> 
> So I see no problem setting ->data to onstack cookie and then
> duplicating it to heap via kmemdup in ->start().
> 
> As far as I can see netlink core offers all functionality already,
> so we only need to switch netfilter to make use of it.
> 
> If you disagree please let me know, otherwise I will cook up
> a patch along this pattern for net/netfilter/*.

Why not just call ->done from netlink_dump_start() when it fails?
