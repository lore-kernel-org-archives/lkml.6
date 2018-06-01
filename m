Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeFAQG0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:06:26 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:58016 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeFAQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:06:23 -0400
Date: Sat, 2 Jun 2018 00:06:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 04/18] rhashtable: detect when object movement might have
 invalidated a lookup
Message-ID: <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824943.30340.8224535954517915320.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152782824943.30340.8224535954517915320.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
> Some users of rhashtable might need to change the key
> of an object and move it to a different location in the table.
> Other users might want to allocate objects using
> SLAB_TYPESAFE_BY_RCU which can result in the same memory allocation
> being used for a different (type-compatible) purpose and similarly
> end up in a different hash-chain.
>
> To support these, we store a unique NULLS_MARKER at the end of
> each chain, and when a search fails to find a match, we check
> if the NULLS marker found was the expected one.  If not,
> the search is repeated.
> 
> The unique NULLS_MARKER is derived from the address of the
> head of the chain.

Yes I thinks makes a lot more sense than the existing rhashtable
nulls code.  The current rhashtable nulls code harkens back to the
time of the old rhashtable implementation where the same chain
existed in two different tables and that is no longer the case.

> If an object is removed and re-added to the same hash chain, we won't
> notice by looking that the NULLS marker.  In this case we must be sure

This is not currently required by TCP/UDP.  I'd rather not add
extra constraints that aren't actually used.  The only requirement
for nulls is to allow sockets to float from the listening table to
the established table within one RCU grace period.  There is no
shuttling back and forth, i.e., the only exit path for a socket in
the established table is to be freed at the end of the RCU grace
period.

Adding Eric/Dave to the cc list in case they do/will need such a
functionality.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
