Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbeC1Hae (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:30:34 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46592 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbeC1Hab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:30:31 -0400
Date: Wed, 28 Mar 2018 15:30:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rhashtable: allow a walk of the hash table without
 missing objects.
Message-ID: <20180328073023.GB17306@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718430.11435.5761213978298714527.stgit@noble>
 <20180327155118.GB14001@gondor.apana.org.au>
 <87po3p421q.fsf@notabene.neil.brown.name>
 <20180328060734.GB16291@gondor.apana.org.au>
 <87a7us4qje.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7us4qje.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 06:17:57PM +1100, NeilBrown wrote:
>
> Sounds like over-kill to me.
> It might be reasonable to have a CONFIG_DEBUG_RHASHTABLE which enables
> extra to code to catch misuse, but I don't see the justification for
> always performing these checks.
> The DEBUG code could just scan the chain (usually quite short) to see if
> the given element is present.  Of course it might have already been
> rehashed to the next table, so you would to allow for that possibility -
> probably check tbl->rehash.

No this is not meant to debug users incorrectly using the cursor.
This is a replacement of your continue interface by automatically
validating the cursor.

In fact we can make it even more reliable.  We can insert the walker
right into the bucket chain, that way the walking will always be
consistent.

The only problem is that we need be able to differentiate between
a walker, a normal object, and the end of the list.  I think it
should be doable.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
