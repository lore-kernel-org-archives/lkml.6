Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeDFEOE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 00:14:04 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35308 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeDFEOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 00:14:03 -0400
Date: Fri, 6 Apr 2018 12:13:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 5/6] rhashtable: support guaranteed successful insertion.
Message-ID: <20180406041348.GA14428@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718434.11435.6551477417902631683.stgit@noble>
 <20180327155610.GD14001@gondor.apana.org.au>
 <87y3id42zo.fsf@notabene.neil.brown.name>
 <20180328060432.GA16291@gondor.apana.org.au>
 <87d0zo4r5j.fsf@notabene.neil.brown.name>
 <20180328072727.GA17306@gondor.apana.org.au>
 <87370j51tu.fsf@notabene.neil.brown.name>
 <20180329052231.GA21028@gondor.apana.org.au>
 <87y3i1vxj7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3i1vxj7.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 01:11:56PM +1000, NeilBrown wrote:
>
> You don't need to handle memory allocation failures at the point where
> you insert into the table - adding to a linked list requires no new
> memory.

You do actually.  The r in rhashtable stands for resizable.  We
cannot completely rely on a background hash table resize because
the insertions can be triggered from softirq context and be without
rate-limits of any kind (e.g., incoming TCP connections).

Therefore at some point you either have to wait for the resize or
fail the insertion.  Since we cannot sleep then failing is the only
option.

> The likelihood of the error isn't really the issue - it either can
> happen or it cannot.  If it can, it requires code to handle it.

Sure, but you just have to handle it the same way you would handle
a memory allocation failure, because that's what it essentially is.

I'm sorry if that means you have to restructure your code to do that
but that's what you pay for having a resizable hash table because
at some point you just have to perform a resize.

> Ahhh... I see what you are thinking now.  You aren't suggestion a
> sharded count that is summed periodically.  Rather you are suggesting that
> we divide the hash space into N regions each with their own independent
> counter, and resize the table if any one region reaches 70% occupancy -
> on the assumption that the other regions are likely to be close.  Is
> that right?

Yes.

> It would probably be dangerous to allow automatic shrinking (when just
> one drops below 30%) in that case, but it might be OK for growing.

At the greatest granularity it would be a counter per bucket, so
clearly we need to maintain some kind of bound on the granularity
so our sample space is not too small.

Automatic shrinking shouldn't be an issue because that's the slow
kind of resizing that we punt to kthread context and it can afford
to do a careful count.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
