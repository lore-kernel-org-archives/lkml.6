Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeC1H1m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:27:42 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46584 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeC1H1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:27:39 -0400
Date: Wed, 28 Mar 2018 15:27:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] rhashtable: support guaranteed successful insertion.
Message-ID: <20180328072727.GA17306@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718434.11435.6551477417902631683.stgit@noble>
 <20180327155610.GD14001@gondor.apana.org.au>
 <87y3id42zo.fsf@notabene.neil.brown.name>
 <20180328060432.GA16291@gondor.apana.org.au>
 <87d0zo4r5j.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0zo4r5j.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 06:04:40PM +1100, NeilBrown wrote:
>
> I disagree.  My patch 6 only makes it common instead of exceedingly
> rare.  If any table in the list other than the first has a chain with 16
> elements, then trying to insert an element with a hash which matches
> that chain will fail with -EBUSY.  This is theoretically possible
> already, though astronomically unlikely.  So that case will never be
> tested for.

No that's not true.  If the table is correctly sized then the
probability of having a chain with 16 elements is extremely low.

Even if it does happen we won't fail because we will perform
an immediate rehash.  We only fail if it happens right away
after the rehash (that is, at least another 16 elements have
been inserted and you're trying to insert a 17th element, all
while the new hash table has not been completely populated),
which means that somebody has figured out our hash secret and
failing in that case makes sense.

> It is hard to know if it is necessary.  And making the new table larger
> will make the error less likely, but still won't make it impossible.  So
> callers will have to handle it - just like they currently have to handle
> -ENOMEM even though it is highly unlikely (and not strictly necessary).

Callers should not handle an ENOMEM error by retrying.  Nor should
they retry an EBUSY return value.

> Are these errors ever actually useful?  I thought I had convinced myself
> before that they were (to throttle attacks on the hash function), but
> they happen even less often than I thought.

The EBUSY error indicates that the hash table has essentially
degenereated into a linked list because somebody has worked out
our hash secret.

> Maybe. Reading a percpu counter isn't cheap.  Reading it whenever a hash
> chain reaches 16 is reasonable, but I think we would want to read it a
> lot more often than that.  So probably store the last-sampled time (with
> no locking) and only sample the counter if last-sampled is more than
>  jiffies - 10*HZ (???)

We could also take the spinlock table approach and have a counter
per bucket spinlock.  This should be sufficient as you'll contend
on the bucket spinlock table anyway.

This also allows us to estimate the total table size and not have
to always do a last-ditch growth when it's too late.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
