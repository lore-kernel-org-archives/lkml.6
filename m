Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DB220656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeLNO4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:56:52 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:52542 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbeLNO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:56:51 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gXotM-0003Tk-JH; Fri, 14 Dec 2018 22:56:40 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gXotE-0001d2-TW; Fri, 14 Dec 2018 22:56:32 +0800
Date:   Fri, 14 Dec 2018 22:56:32 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Florian Westphal <fw@strlen.de>
Cc:     Wolfgang Walter <linux@stwm.de>,
        David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, christophe.gouault@6wind.com
Subject: Re: INFO: rcu detected stall in xfrm_hash_rebuild
Message-ID: <20181214145632.urh3n4vua66wvmkx@gondor.apana.org.au>
References: <00000000000075fe86057ca6367e@google.com>
 <20181210124724.iuver2va3yjdsokf@breakpoint.cc>
 <20181210.095856.580441946779980596.davem@davemloft.net>
 <2559562.n5nkmlqv4s@stwm.de>
 <20181214143532.43zgy2hwkdskwfn2@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214143532.43zgy2hwkdskwfn2@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 03:35:32PM +0100, Florian Westphal wrote:
>
> Ok.  An alternative would be to remove the support for
> policy hash table thresholds (which decide what kinds of policies
> go to exact table and which ones go into inexact ones), i.e.
> partially revert 880a6fab8f6ba5b5abe59ea6
> ("xfrm: configure policy hash table thresholds by netlink").
> 
> This would remove the need for the rehashing support that
> re-sorts the policies into either exact/inexact lists) when the
> those tunables are changed.
> 
> We could also easily convert the exact table to an rhashtable
> then if we wanted to.

We could also do both.  In fact that was the reason why I started
working on rhashtable in the first place.  The idea is to extend
the run-time rehashing to include both parts of the database.

So you would look up the old table/list combo and then move onto
the new one.

Of course I never had time to finish this and I think the entity
asking for this has moved onto something else.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
