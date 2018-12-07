Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE19C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECA12082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECA12082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLGFj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 00:39:59 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:48920 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLGFj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 00:39:59 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gV8rc-000496-N2; Fri, 07 Dec 2018 13:39:48 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gV8rY-00058V-3D; Fri, 07 Dec 2018 13:39:44 +0800
Date:   Fri, 7 Dec 2018 13:39:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rhashtable: further improve stability of
 rhashtable_walk
Message-ID: <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au>
References: <153086101070.2825.6850140624411927465.stgit@noble>
 <153086109256.2825.15329014177598382684.stgit@noble>
 <87zhtkeimx.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhtkeimx.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 02:51:02PM +1100, NeilBrown wrote:
> 
> If the sequence:
>    obj = rhashtable_walk_next(iter);
>    rhashtable_walk_stop(iter);
>    rhashtable_remove_fast(ht, &obj->head, params);
>    rhashtable_walk_start(iter);
> 
>  races with another thread inserting or removing
>  an object on the same hash chain, a subsequent
>  rhashtable_walk_next() is not guaranteed to get the "next"
>  object. It is possible that an object could be
>  repeated, or missed.
> 
>  This can be made more reliable by keeping the objects in a hash chain
>  sorted by memory address.  A subsequent rhashtable_walk_next()
>  call can reliably find the correct position in the list, and thus
>  find the 'next' object.
> 
>  It is not possible to take this approach with an rhltable as keeping
>  the hash chain in order is not so easy.  When the first object with a
>  given key is removed, it is replaced in the chain with the next
>  object with the same key, and the address of that object may not be
>  correctly ordered.
>  I have not yet found any way to achieve the same stability
>  with rhltables, that doesn't have a major impact on lookup
>  or insert.  No code currently in Linux would benefit from
>  such extra stability.
> 
>  With this patch:
>  - a new object is always inserted after the last object with a
>    smaller address, or at the start.
>  - when rhashtable_walk_start() is called, it records that 'p' is not
>    'safe', meaning that it cannot be dereferenced.  The revalidation
>    that was previously done here is moved to rhashtable_walk_next()
>  - when rhashtable_walk_next() is called while p is not NULL and not
>    safe, it walks the chain looking for the first object with an
>    address greater than p and returns that.  If there is none, it moves
>    to the next hash chain.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> 
> This is a resend of a patch that I sent back in July.  I couldn't
> applied then because it assumed another rhashtable patch which hadn't
> landed yet - it now has.

I thought we had agreed to drop this because nobody needs it
currently and it doesn't handle rhlist?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
