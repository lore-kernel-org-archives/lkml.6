Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeFBFDb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 01:03:31 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:58492 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeFBFD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 01:03:29 -0400
Date: Sat, 2 Jun 2018 13:03:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 15/18] rhashtable: use bit_spin_locks to protect hash
 bucket.
Message-ID: <20180602050322.liesw324q5kawcue@gondor.apana.org.au>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824984.30340.1634082820568216846.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152782824984.30340.1634082820568216846.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
> This patch changes rhashtables to use a bit_spin_lock (BIT(1))
> the bucket pointer to lock the hash chain for that bucket.
> 
> The benefits of a bit spin_lock are:
>  - no need to allocate a separate array of locks.
>  - no need to have a configuration option to guide the
>    choice of the size of this array
>  - locking cost if often a single test-and-set in a cache line
>    that will have to be loaded anyway.  When inserting at, or removing
>    from, the head of the chain, the unlock is free - writing the new
>    address in the bucket head implicitly clears the lock bit.
>  - even when lockings costs 2 updates (lock and unlock), they are
>    in a cacheline that needs to be read anyway.
> 
> The cost of using a bit spin_lock is a little bit of code complexity,
> which I think is quite manageable.
> 
> Bit spin_locks are sometimes inappropriate because they are not fair -
> if multiple CPUs repeatedly contend of the same lock, one CPU can
> easily be starved.  This is not a credible situation with rhashtable.
> Multiple CPUs may want to repeatedly add or remove objects, but they
> will typically do so at different buckets, so they will attempt to
> acquire different locks.
> 
> As we have more bit-locks than we previously had spinlocks (by at
> least a factor of two) we can expect slightly less contention to
> go with the slightly better cache behavior and reduced memory
> consumption.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

...

> @@ -74,6 +71,61 @@ struct bucket_table {
>  	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
>  };
>  
> +/*
> + * We lock a bucket by setting BIT(1) in the pointer - this is always
> + * zero in real pointers and in the nulls marker.
> + * bit_spin_locks do not handle contention well, but the whole point
> + * of the hashtable design is to achieve minimum per-bucket contention.
> + * A nested hash table might not have a bucket pointer.  In that case
> + * we cannot get a lock.  For remove and replace the bucket cannot be
> + * interesting and doesn't need locking.
> + * For insert we allocate the bucket if this is the last bucket_table,
> + * and then take the lock.
> + * Sometimes we unlock a bucket by writing a new pointer there.  In that
> + * case we don't need to unlock, but we do need to reset state such as
> + * local_bh. For that we have rht_unlocked().  This doesn't include
> + * the memory barrier that bit_spin_unlock() provides, but rcu_assign_pointer()
> + * will have provided that.
> + */

Yes the concept looks good to me.  But I would like to hear from
Eric/Dave as to whether this would be acceptable for existing
network hash tables such as the ones in inet.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
