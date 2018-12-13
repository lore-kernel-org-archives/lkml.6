Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D2EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48FB20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48FB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeLMBnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:43:22 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:49018 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbeLMBnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:43:22 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gXG1y-00011o-VH; Thu, 13 Dec 2018 09:43:15 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gXG1t-0003i6-Uy; Thu, 13 Dec 2018 09:43:09 +0800
Date:   Thu, 13 Dec 2018 09:43:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rhashtable: further improve stability of
 rhashtable_walk
Message-ID: <20181213014309.uufaeoijhympgxbz@gondor.apana.org.au>
References: <153086109256.2825.15329014177598382684.stgit@noble>
 <87zhtkeimx.fsf@notabene.neil.brown.name>
 <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au>
 <87k1kico1o.fsf@notabene.neil.brown.name>
 <20181211051755.modgomqzszkbiihe@gondor.apana.org.au>
 <87mupbvch0.fsf@notabene.neil.brown.name>
 <20181212054601.wbzpxjunnsfi62mz@gondor.apana.org.au>
 <87efanuu06.fsf@notabene.neil.brown.name>
 <20181212080037.j2zs22t57uxdu2jr@gondor.apana.org.au>
 <87bm5ruo3f.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm5ruo3f.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 07:49:08PM +1100, NeilBrown wrote:
> On Wed, Dec 12 2018, Herbert Xu wrote:
> 
> > On Wed, Dec 12, 2018 at 05:41:29PM +1100, NeilBrown wrote:
> >>
> >> So you would substantially slow down the rhashtable_walk_start() step.
> >
> > This whole thing is meant for uses such as /proc and netlink
> > enumeration.  Speed is definitely not a prerogative of these
> > iterators.
> 
> An RCU grace period is typically 10s of milliseconds.  It doesn't take
> very many of those to start being noticed.

Why would you even need an RCU grace period for deleting and adding
the walker object to the bucket list? You just allocate a new one
each time and free the old one after an RCU grace period.  I don't
see where the latency is coming from.

> > For that matter, if speed was an issue then surely you would
> > not drop out of the RCU read lock at all while iterating.
> 
> tipc_nl_sk_walk() drops out of RCU for every object.
> I don't know what it is used for, but I doubt that making it thousands
> of times slower would be a good thing.

Now you're conflating two different things.  Dropping the RCU
isn't necessarily slow.  We were talking about waiting for an
RCU grace period which would only come into play if you were
suspending the walk indefinitely.  Actually as I said above even
there you don't really need to wait.

> > It sounds to me like you're trying to use this interface for
> > something that it's simply not designed to do.
> 
> I'm just trying to make sure we have a reliable data structure which I
> can use without having to be worried that I might accidentally hit some
> unsupported behaviour.

Now that is something I agree with.

> I don't really see why you think my patch is all that complex.
> The only conceptual change is that hash chains are now ordered, and
> ordered chains are easy to understand.
> The biggest part of the code change is just moving some code from
> rhashtable_walk_start() to rhashtable_walk_next().
> 
> Why don't you like it?

My main beef is the fact that it doesn't work with rhlist.  So down
the track either we'll have to add more complexity for rhlist or
we will have to rip this out again do something completely different.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
