Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeC0P4W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:56:22 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:45716 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbeC0P4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:56:20 -0400
Date: Tue, 27 Mar 2018 23:56:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] rhashtable: support guaranteed successful insertion.
Message-ID: <20180327155610.GD14001@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718434.11435.6551477417902631683.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152210718434.11435.6551477417902631683.stgit@noble>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 10:33:04AM +1100, NeilBrown wrote:
> The current rhashtable will fail an insertion if the hashtable
> it "too full", one of:
>  - table already has 2^31 elements (-E2BIG)
>  - a max_size was specified and table already has that
>    many elements (rounded up to power of 2) (-E2BIG)
>  - a single chain has more than 16 elements (-EBUSY)
>  - table has more elements than the current table size,
>    and allocating a new table fails (-ENOMEM)
>  - a new page needed to be allocated for a nested table,
>    and the memory allocation failed (-ENOMEM).
> 
> A traditional hash table does not have a concept of "too full", and
> insertion only fails if the key already exists.  Many users of hash
> tables have separate means of limiting the total number of entries,
> and are not susceptible to an attack which could cause unusually large
> hash chains.  For those users, the need to check for errors when
> inserting objects to an rhashtable is an unnecessary burden and hence
> a potential source of bugs (as these failures are likely to be rare).

Did you actually encounter an insertion failure? The current code
should never fail an insertion until you actually run ouf memory.
That is unless you're using rhashtable when you should be using
rhlist instead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
