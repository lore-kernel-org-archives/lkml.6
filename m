Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeC1GHq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:07:46 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46536 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeC1GHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:07:45 -0400
Date: Wed, 28 Mar 2018 14:07:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rhashtable: allow a walk of the hash table without
 missing objects.
Message-ID: <20180328060734.GB16291@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718430.11435.5761213978298714527.stgit@noble>
 <20180327155118.GB14001@gondor.apana.org.au>
 <87po3p421q.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87po3p421q.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 08:54:41AM +1100, NeilBrown wrote:
>
> Possibly.
> I particularly want the interface to require that you pass the
> previously returned object to _continue. That makes it easy to see that
> the object is still being used.  If someone changes to code to delete
> the object before the _continue, there should be a strong hint that it
> won't work.
> 
> Maybe it would be better to make it a WARN_ON()
> 
>   if (!obj || WARN_ON(iter->p != obj))
>          iter->p = NULL;

This doesn't really protect against the case where obj is removed.
All it proves is that the user saved a copy of obj which we already
did anyway.

To detect an actual removal you'd need to traverse the list.

I have another idea: we could save insert the walkers into the
hash table chain at the end, essentially as a hidden list.  We
can mark it with a flag like rht_marker so that normal traversal
doesn't see it.

That way the removal code can simply traverse that list and inform
them that the iterator is invalid.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
