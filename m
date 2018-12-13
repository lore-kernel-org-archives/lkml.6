Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F872C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A148D2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A148D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeLMIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:48:08 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:50040 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLMIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:48:05 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gXMf0-0001D9-ND; Thu, 13 Dec 2018 16:47:58 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gXMex-0004Qc-Rt; Thu, 13 Dec 2018 16:47:55 +0800
Date:   Thu, 13 Dec 2018 16:47:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rhashtable: further improve stability of
 rhashtable_walk
Message-ID: <20181213084755.3kdwdd53qyasdwfw@gondor.apana.org.au>
References: <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au>
 <87k1kico1o.fsf@notabene.neil.brown.name>
 <20181211051755.modgomqzszkbiihe@gondor.apana.org.au>
 <87mupbvch0.fsf@notabene.neil.brown.name>
 <20181212054601.wbzpxjunnsfi62mz@gondor.apana.org.au>
 <87efanuu06.fsf@notabene.neil.brown.name>
 <20181212080037.j2zs22t57uxdu2jr@gondor.apana.org.au>
 <87bm5ruo3f.fsf@notabene.neil.brown.name>
 <20181213014309.uufaeoijhympgxbz@gondor.apana.org.au>
 <8736r2ulw4.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736r2ulw4.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:48:59PM +1100, NeilBrown wrote:
> 
> Yes, you could rcu_free the old one and allocate a new one.  Then you
> would have to be ready to deal with memory allocation failure which
> complicates usage (I already don't like that rhashtable_insert() can
> report -ENOMEM!).

Yes there will be a cost to dealing with allocation failure but at
least it'll work reliably in all cases.  For the intended use-case
of dumping things to user-space allocation failure is a non-issue.

> > Now you're conflating two different things.  Dropping the RCU
> > isn't necessarily slow.  We were talking about waiting for an
> > RCU grace period which would only come into play if you were
> > suspending the walk indefinitely.  Actually as I said above even
> > there you don't really need to wait.
> 
> How would rhashtable_walk_stop() know if it was indefinite or not?

You assume that it's always indefinite because the typical usage of
stop is because we have run out of memory and must wait for user-
space to read what we have produced so far to free up memory.

> *Not* keeping them all in the hash chain is ideal, but not essential.
> I see three costs with this.
> One is that we would compare the same key multiple times for lookup.
> How much of a problem is that? A failing compare is usually quite quick,
> and most rhltable uses have inline memcmp for comparison (admittedly not
> all).
> 
> The second cost is tracking the chain length against elasticity.
> We could flag one object with each key as a 'master' (low bit of the
> 'next' pointer) and only count the masters.  When lookup raced with
> remove this might get a slightly incorrect count, but I don't think that
> hurts.
> 
> Finally, there is more pointer chasing as the chains are longer.

The biggest problem is that you can no longer return the lookup
result.  When you perform a lookup on rhltable you need to return
all the matching objects, not just a random one.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
