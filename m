Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076C6C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E6120811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E6120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeLLFqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:46:15 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:47006 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLLFqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:46:15 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gWxLU-000367-90; Wed, 12 Dec 2018 13:46:08 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gWxLN-0002El-LR; Wed, 12 Dec 2018 13:46:01 +0800
Date:   Wed, 12 Dec 2018 13:46:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rhashtable: further improve stability of
 rhashtable_walk
Message-ID: <20181212054601.wbzpxjunnsfi62mz@gondor.apana.org.au>
References: <153086101070.2825.6850140624411927465.stgit@noble>
 <153086109256.2825.15329014177598382684.stgit@noble>
 <87zhtkeimx.fsf@notabene.neil.brown.name>
 <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au>
 <87k1kico1o.fsf@notabene.neil.brown.name>
 <20181211051755.modgomqzszkbiihe@gondor.apana.org.au>
 <87mupbvch0.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mupbvch0.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:02:35AM +1100, NeilBrown wrote:
> 
> So I think this is a real bug - it is quite unlikely to hit, but
> possibly.
> You need a chain with at least 2 objects, you need
> rhashtable_walk_stop() to be called after visiting an object other than
> the last object, and you need some thread (this or some other) to remove
> that object from the table.
> 
> The patch that I posted aims to fix that bug, and only that bug.
> The only alternative that I can think of is to document that this can
> happen and advise that a reference should be held to the last visited
> object when stop/start is called, or in some other way ensure that it
> doesn't get removed.

Thanks for reminding me of the issue you were trying to fix.

So going back into the email archives, I suggested at the very
start that we could just insert the walker objects into the actual
hash table.  That would solve the issue for both rhashtable and
rhlist.

Could we do that rather than using this ordered list that only
works for rhashtable?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
