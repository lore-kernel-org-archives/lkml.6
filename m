Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeC2FWr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:22:47 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:47608 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeC2FWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:22:46 -0400
Date: Thu, 29 Mar 2018 13:22:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 5/6] rhashtable: support guaranteed successful insertion.
Message-ID: <20180329052231.GA21028@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718434.11435.6551477417902631683.stgit@noble>
 <20180327155610.GD14001@gondor.apana.org.au>
 <87y3id42zo.fsf@notabene.neil.brown.name>
 <20180328060432.GA16291@gondor.apana.org.au>
 <87d0zo4r5j.fsf@notabene.neil.brown.name>
 <20180328072727.GA17306@gondor.apana.org.au>
 <87370j51tu.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87370j51tu.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 08:26:21AM +1100, NeilBrown wrote:
>
> I say "astronomically unlikely", you say "probability .. is extremely
> low".  I think we are in agreement here.
> 
> The point remains that if an error *can* be returned then I have to
> write code to handle it and test that code.  I'd rather not.

You have be able to handle errors anyway because of memory allocation
failures.  Ultimately if you keep inserting you will eventually
fail with ENOMEM.  So I don't see the issue with an additional
error value.

> > Even if it does happen we won't fail because we will perform
> > an immediate rehash.  We only fail if it happens right away
> > after the rehash (that is, at least another 16 elements have
> > been inserted and you're trying to insert a 17th element, all
> > while the new hash table has not been completely populated),
> > which means that somebody has figured out our hash secret and
> > failing in that case makes sense.

BTW, you didn't acknowledge this bit which I think is crucial to
how likely such an error is.

> I never suggested retrying, but I would have to handle it somehow.  I'd
> rather not.

...

> While I have no doubt that there are hashtables where someone could try
> to attack the hash, I am quite sure there are others where is such an
> attack is meaningless - any code which could generate the required range of
> keys, could do far worse things more easily.

Our network hashtable has to be secure against adversaries.  I
understand that this may not be important to your use-case.  However,
given the fact that the failure would only occur if an adversary
is present and actively attacking your hash table, I don't think
it has that much of a negative effect on your use-case either.

Of course if you can reproduce the EBUSY error without your
disable_count patch or even after you have fixed the issue I
have pointed out in your disable_count patch you can still reproduce
it then that would suggest a real bug and we would need to fix it,
for everyone.

> Yes, storing a sharded count in the spinlock table does seem like an
> appropriate granularity.  However that leads me to ask: why do we have
> the spinlock table?  Why not bit spinlocks in the hashchain head like
> include/linux/list_bl uses?

The spinlock table predates rhashtable.  Perhaps Thomas/Eric/Dave
can elucidate this.

> I don't understand how it can ever be "too late", though I appreciate
> that in some cases "sooner" is better than "later"
> If we give up on the single atomic_t counter, then we must accept that
> the number of elements could exceed any given value.  The only promise
> we can provide is that it wont exceed N% of the table size for more than
> T seconds.

Sure.  However, assuming we use an estimate that is hash-based,
that *should* be fairly accurate assuming that your hash function
is working in the first place.  It's completely different vs.
estimating based on a per-cpu count which could be wildly inaccurate.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
