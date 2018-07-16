Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3EEECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB54E208E1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB54E208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeGPCmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 22:42:09 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34542 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbeGPCmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 22:42:08 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fet4M-0003I9-Ol; Mon, 16 Jul 2018 10:16:58 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fet4H-0001ux-Mp; Mon, 16 Jul 2018 10:16:53 +0800
Date:   Mon, 16 Jul 2018 10:16:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH - revised] rhashtable: detect when object movement might
 have invalidated a lookup
Message-ID: <20180716021653.xtbyetdfc2uzxub3@gondor.apana.org.au>
References: <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au>
 <87k1q8yh70.fsf@notabene.neil.brown.name>
 <20180711.224658.2077863065492745521.davem@davemloft.net>
 <20180711.224801.1129067473269289703.davem@davemloft.net>
 <87fu0kt5m0.fsf@notabene.neil.brown.name>
 <20180716005134.q4rfkfn3m5zzwt62@gondor.apana.org.au>
 <874lh0t1ls.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lh0t1ls.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:23:43AM +1000, NeilBrown wrote:
>
> kmem_cache_free() directly.  For this, I need rhashtable to be safe if
> an object is deleted and immediately re-inserted into the same hash
> chain.

This means that

	rcu_read_lock();
	A = rhashtable_lookup();
	use(A);
	rcu_read_unlock();

A can turn into object B when it is used.  That is just too strange
for words.  Can we see some actual code on how this works?

For comparison, the existing net code where this happens A doesn't
actually change and it simply moves from one hashtable to another.

I'm relucant to add semantics that would restrain on how rhashtable
works unless we have real and valid use-cases for it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
