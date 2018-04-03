Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDCEDj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 00:03:39 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:57408 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeDCEDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 00:03:37 -0400
Date: Tue, 3 Apr 2018 12:03:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH v2 0/2] gfs2: Stop using rhashtable_walk_peek
Message-ID: <20180403040322.GB3515@gondor.apana.org.au>
References: <20180329120612.6104-1-agruenba@redhat.com>
 <20180329123544.GA22551@gondor.apana.org.au>
 <CAHc6FU4i5LDoqXXTgAKtTA8EtGyawxXtY4iavo7NjHCsbX1G8w@mail.gmail.com>
 <20180329154153.GA23562@gondor.apana.org.au>
 <CAHc6FU708-F-C_ihwBW-zKC7rZvfeuKYq7kTccZQU156UicjQA@mail.gmail.com>
 <20180329170626.GA24218@gondor.apana.org.au>
 <871sfx0xeh.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sfx0xeh.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 01:41:26PM +1000, NeilBrown wrote:
>
> Do we really need a rhashtable_walk_peek() interface?
> I imagine that a seqfile ->start function can do:
> 
>   if (*ppos == 0 && last_pos != 0) {
>   	rhashtable_walk_exit(&iter);
>         rhashtable_walk_enter(&table, &iter);
>         last_pos = 0;
>   }
>   rhashtable_walk_start(&iter);
>   if (*ppos == last_pos && iter.p)
>   	return iter.p;
>   last_pos = *ppos;

We don't want users poking into the internals of iter.  If you're
suggesting we could simplify rhashtable_walk_peek to just this after
your patch then yes possibly.  You also need to ensure that not only
seqfs users continue to work but also netlink dump users which are
slightly different.

> It might be OK to have a function call instead of expecting people to
> use iter.p directly.

Yes that would definitely be the preferred option.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
