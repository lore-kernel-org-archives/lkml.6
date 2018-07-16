Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DDEECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678D9208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678D9208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeGPBQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:16:34 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34394 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeGPBQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:16:34 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ferjm-0002bk-TP; Mon, 16 Jul 2018 08:51:39 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ferjj-0001rC-4N; Mon, 16 Jul 2018 08:51:35 +0800
Date:   Mon, 16 Jul 2018 08:51:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH - revised] rhashtable: detect when object movement might
 have invalidated a lookup
Message-ID: <20180716005134.q4rfkfn3m5zzwt62@gondor.apana.org.au>
References: <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au>
 <87k1q8yh70.fsf@notabene.neil.brown.name>
 <20180711.224658.2077863065492745521.davem@davemloft.net>
 <20180711.224801.1129067473269289703.davem@davemloft.net>
 <87fu0kt5m0.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fu0kt5m0.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:57:11AM +1000, NeilBrown wrote:
> 
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
> 
> If an object is removed and re-added to the same hash chain, we won't
> notice by looking that the NULLS marker.  In this case we must be sure
> that it was not re-added *after* its original location, or a lookup may
> incorrectly fail.  The easiest solution is to ensure it is inserted at
> the start of the chain.  insert_slow() already does that,
> insert_fast() does not.  So this patch changes insert_fast to always
> insert at the head of the chain.
> 
> Note that such a user must do their own double-checking of
> the object found by rhashtable_lookup_fast() after ensuring
> mutual exclusion which anything that might change the key, such as
> successfully taking a new reference.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

I still don't understand why we need this feature.  The only
existing user of this (which currently doesn't use rhashtable)
does not readd the reused entry to the same table.  IOW the flow
is always from table A to table B.  After which the entry will
be properly freed rather than reused.

So who is going to use this?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
