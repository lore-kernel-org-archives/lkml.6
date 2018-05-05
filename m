Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeEEJmS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:42:18 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35446 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeEEJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:42:16 -0400
Date: Sat, 5 May 2018 17:42:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] rhashtable: further improve stability of
 rhashtable_walk
Message-ID: <20180505094212.hpqjyv5ijibviuwh@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605438.18473.4797800779538116583.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152540605438.18473.4797800779538116583.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
> If the sequence:
>    obj = rhashtable_walk_next(iter);
>    rhashtable_walk_stop(iter);
>    rhashtable_remove_fast(ht, &obj->head, params);
>    rhashtable_walk_start(iter);
> 
>  races with another thread inserting or removing
>  an object on the same hash chain, a subsequent
>  rhashtable_walk_next() is not guaranteed to get the "next"
>  object. It is possible that an object could be
>  repeated, or missed.
> 
>  This can be made more reliable by keeping the objects in a hash chain
>  sorted by memory address.  A subsequent rhashtable_walk_next()
>  call can reliably find the correct position in the list, and thus
>  find the 'next' object.
> 
>  It is not possible (certainly not so easy) to achieve this with an
>  rhltable as keeping the hash chain in order is not so easy.  When the
>  first object with a given key is removed, it is replaced in the chain
>  with the next object with the same key, and the address of that
>  object may not be correctly ordered.
>  No current user of rhltable_walk_enter() calls
>  rhashtable_walk_start() more than once, so no current code
>  could benefit from a more reliable walk of rhltables.
> 
>  This patch only attempts to improve walks for rhashtables.
>  - a new object is always inserted after the last object with a
>    smaller address, or at the start
>  - when rhashtable_walk_start() is called, it records that 'p' is not
>    'safe', meaning that it cannot be dereferenced.  The revalidation
>    that was previously done here is moved to rhashtable_walk_next()
>  - when rhashtable_walk_next() is called while p is not NULL and not
>    safe, it walks the chain looking for the first object with an
>    address greater than p and returns that.  If there is none, it moves
>    to the next hash chain.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

I'm a bit torn on this.  On the hand this is definitely an improvement
over the status quo.  On the other this does not work on rhltable and
we do have a way of fixing it for both rhashtable and rhltable.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
