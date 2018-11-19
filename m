Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD4FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4633820823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4633820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeKSOQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:16:41 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:43326 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeKSOQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 09:16:41 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gOadg-0002nu-63; Mon, 19 Nov 2018 11:54:20 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gOadb-0005Al-8C; Mon, 19 Nov 2018 11:54:15 +0800
Date:   Mon, 19 Nov 2018 11:54:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH] rhashtable: detect when object movement between tables
 might have invalidated a lookup
Message-ID: <20181119035415.yavhqymqiqp3mmcl@gondor.apana.org.au>
References: <87muqbtev6.fsf@notabene.neil.brown.name>
 <20181116055551.zxfydbpoicslsfkg@gondor.apana.org.au>
 <878t1tece0.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t1tece0.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:59:19PM +1100, NeilBrown wrote:
>
> NULLS_MARKER assumes a hash value in which the bottom bits are most
> likely to be unique.  To convert this to a pointer which certainly not
> valid, it shifts left by 1 and sets the lsb.
> We aren't passing a hash value, but are passing an address instead.
> In this case the bottom 2 bits are certain to be 0, and the top bit
> could contain valuable information (on a 32bit system).
> The best way to turn a pointer into a certainly-invalid pointer
> is to just set the lsb.  By shifting right by one, we discard an
> uninteresting bit, preserve all the interesting bits, and effectively
> just set the lsb.
> 
> I could add a comment explaining that if you like.

The top-bit is most likely to be fixed and offer no real value.

> >> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> >> index 30526afa8343..852ffa5160f1 100644
> >> --- a/lib/rhashtable.c
> >> +++ b/lib/rhashtable.c
> >> @@ -1179,8 +1179,7 @@ struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
> >>  					    unsigned int hash)
> >>  {
> >>  	const unsigned int shift = PAGE_SHIFT - ilog2(sizeof(void *));
> >> -	static struct rhash_head __rcu *rhnull =
> >> -		(struct rhash_head __rcu *)NULLS_MARKER(0);
> >> +	static struct rhash_head __rcu *rhnull;
> >
> > I don't understand why you can't continue to do NULLS_MARKER(0) or
> > RHT_NULLS_MARKER(0).
> 
> Because then the test
> 
> +	} while (he != RHT_NULLS_MARKER(head));
> 
> in __rhashtable_lookup() would always succeed, and it would loop
> forever.

This change is only necessary because of your shifting change
above, which AFAICS adds no real benefit.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
