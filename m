Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBBBECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7C9206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7C9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeGTIl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:41:28 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:39030 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbeGTIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:41:28 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fgQEw-0007aI-3L; Fri, 20 Jul 2018 15:54:14 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fgQEr-0007lo-B0; Fri, 20 Jul 2018 15:54:09 +0800
Date:   Fri, 20 Jul 2018 15:54:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table
 throughout insertion.
Message-ID: <20180720075409.kfckhodsnvktift7@gondor.apana.org.au>
References: <153086169828.24852.10332573315056854948.stgit@noble>
 <153086175009.24852.7782466383056542839.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153086175009.24852.7782466383056542839.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 05:22:30PM +1000, NeilBrown wrote:
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
> 
> We still need a way to ensure that a dead bucket_table is never
> re-linked by rhashtable_walk_stop().  This can be achieved by
> calling call_rcu() inside the locked region, and checking
> ->rcu.func in rhashtable_walk_stop().  If it is not NULL, then
> the bucket table is empty and dead.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

...

> @@ -339,13 +338,16 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
>  	spin_lock(&ht->lock);
>  	list_for_each_entry(walker, &old_tbl->walkers, list)
>  		walker->tbl = NULL;
> -	spin_unlock(&ht->lock);
>  
>  	/* Wait for readers. All new readers will see the new
>  	 * table, and thus no references to the old table will
>  	 * remain.
> +	 * We do this inside the locked region so that
> +	 * rhashtable_walk_stop() can check ->rcu.func and know
> +	 * not to re-link the table.
>  	 */
>  	call_rcu(&old_tbl->rcu, bucket_table_free_rcu);
> +	spin_unlock(&ht->lock);
>  
>  	return rht_dereference(new_tbl->future_tbl, ht) ? -EAGAIN : 0;
>  }

...

> @@ -964,7 +942,7 @@ void rhashtable_walk_stop(struct rhashtable_iter *iter)
>  	ht = iter->ht;
>  
>  	spin_lock(&ht->lock);
> -	if (tbl->rehash < tbl->size)
> +	if (tbl->rcu.func == NULL)
>  		list_add(&iter->walker.list, &tbl->walkers);
>  	else
>  		iter->walker.tbl = NULL;

This appears to be relying on implementation details within RCU.
Paul, are you OK with rhashtable doing this trick?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
