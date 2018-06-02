Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeFBPxl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 11:53:41 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:59062 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbeFBPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 11:53:40 -0400
Date: Sat, 2 Jun 2018 23:53:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/5] lib/rhashtable: guarantee initial hashtable
 allocation
Message-ID: <20180602155324.yrco4xq2yeez2btg@gondor.apana.org.au>
References: <20180601160125.30031-1-dave@stgolabs.net>
 <20180601160125.30031-3-dave@stgolabs.net>
 <20180602044150.xpazuhpxbwt37xmu@gondor.apana.org.au>
 <20180602054131.ta7ligrfwbgvemfv@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602054131.ta7ligrfwbgvemfv@linux-r8p5>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 10:41:31PM -0700, Davidlohr Bueso wrote:
> On Sat, 02 Jun 2018, Herbert Xu wrote:
> > >  	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
> > > -	if (tbl == NULL)
> > > -		return -ENOMEM;
> > > +	if (unlikely(tbl == NULL)) {
> > > +		size = min_t(u16, ht->p.min_size, HASH_MIN_SIZE);
> > 
> > You mean max_t?
> 
> Not really. I considered some of the users to set quite a large min_size
> (such as 1024 buckets). The min() makes sense to me in that it's the smallest
> possible value. If memory later becomes available and the hashtable is resized
> to a more appropriate value, couldn't any issues regarding collisions not be dealt
> with organically? And we've agreed that allocating a tiny table is the
> least of our problems.

Huh? The min_size is a floor for the hash table size.  Some users
may need it because they cannot tolerate the insert-time allocation
or failure.

Your use of min_t against min_size makes absolutely no sense.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
