Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C71C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC12A20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC12A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeLKFSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:18:08 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:43262 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLKFSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:18:07 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gWaQi-0004PB-IA; Tue, 11 Dec 2018 13:18:00 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gWaQd-0002U4-9j; Tue, 11 Dec 2018 13:17:55 +0800
Date:   Tue, 11 Dec 2018 13:17:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rhashtable: further improve stability of
 rhashtable_walk
Message-ID: <20181211051755.modgomqzszkbiihe@gondor.apana.org.au>
References: <153086101070.2825.6850140624411927465.stgit@noble>
 <153086109256.2825.15329014177598382684.stgit@noble>
 <87zhtkeimx.fsf@notabene.neil.brown.name>
 <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au>
 <87k1kico1o.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1kico1o.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil:

On Mon, Dec 10, 2018 at 09:50:43AM +1100, NeilBrown wrote:
>  I think it was agreed that I would not pursue features that were only
>  of use to out-of-tree code, but I don't think that applies here.  This
>  is not a feature, this is a quality-of-implementation improvement.
>  There are users in the kernel today which use
>    rhashtable_walk_stop()/rhashtable_walk_start()
>  to drop out of RCU protection for periods during the walk.
>  Any such user might miss seeing an object that has been in the table
>  for a while - sure that is less than optimal, and should be fixed if
>  the cost is small.
> 
>  There are currently no rhlist users which use stop/start to drop out
>  of RCU, so there is no clear value in fixing that case, or cost in not
>  fixing it.

I think the complexities of this patch outweighs any benefit.

Walking an rhashtable is inherently unreliable, due to rehashing.
If you need an 100% reliable walking mechanism, then add your own
linked list alongside the hash table like xfrm does.

Having said that, if the current code is missing items that existed
prior to the start of the walk (in the absence of a rehash) then
that would be a bug that we should fix.  Anything else like
duplicates just needs to be accepted by the caller.

So please explain how can an object be missed then we can work on
fixing that and that only.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
