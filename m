Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeEEJlZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:41:25 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35438 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEEJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:41:24 -0400
Date: Sat, 5 May 2018 17:41:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] rhashtable: don't hold lock on first table
 throughout insertion.
Message-ID: <20180505094117.pl7b6bbk6mtyri6d@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605444.18473.9591316658457316578.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152540605444.18473.9591316658457316578.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
> rhashtable_try_insert() currently hold a lock on the bucket in
> the first table, while also locking buckets in subsequent tables.
> This is unnecessary and looks like a hold-over from some earlier
> version of the implementation.
> 
> As insert and remove always lock a bucket in each table in turn, and
> as insert only inserts in the final table, there cannot be any races
> that are not covered by simply locking a bucket in each table in turn.
> 
> When an insert call reaches that last table it can be sure that there
> is no match entry in any other table as it has searched them all, and
> insertion never happens anywhere but in the last table.  The fact that
> code tests for the existence of future_tbl while holding a lock on
> the relevant bucket ensures that two threads inserting the same key
> will make compatible decisions about which is the "last" table.
> 
> This simplifies the code and allows the ->rehash field to be
> discarded.
> We still need a way to ensure that a dead bucket_table is never
> re-linked by rhashtable_walk_stop().  This can be achieved by
> setting the ->size to 1.  This still allows lookup code to work (and
> correctly not find anything) but can never happen on an active bucket
> table (as the minimum size is 4).
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

I'm not convinced this is safe.  There can be multiple tables
in existence.  Unless you hold the lock on the first table, what
is to stop two parallel inserters each from inserting into their
"last" tables which may not be the same table?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
