Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC39C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8E4208D6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8E4208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeHXQ5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:57:16 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46228 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeHXQ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:57:16 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ftC2q-0008CC-JY; Fri, 24 Aug 2018 21:22:32 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ftC2p-0001X1-FB; Fri, 24 Aug 2018 21:22:31 +0800
Date:   Fri, 24 Aug 2018 21:22:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Mike Snitzer <msnitzer@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Dave Watson <davejwatson@fb.com>
Subject: Re: Deadlock when using crypto API for block devices
Message-ID: <20180824132231.t3narmsfcykseeee@gondor.apana.org.au>
References: <alpine.LRH.2.02.1808231621220.8560@file01.intranet.prod.int.rdu2.redhat.com>
 <20180824021010.hfar7gasp34ddrib@gondor.apana.org.au>
 <alpine.LRH.2.02.1808240659320.27014@file01.intranet.prod.int.rdu2.redhat.com>
 <20180824112435.ggizlqrymuibm6oo@gondor.apana.org.au>
 <alpine.LRH.2.02.1808240837120.11243@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1808240854010.15479@file01.intranet.prod.int.rdu2.redhat.com>
 <20180824132145.2zsnqwbih3iygeeq@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824132145.2zsnqwbih3iygeeq@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 09:21:45PM +0800, Herbert Xu wrote:
> On Fri, Aug 24, 2018 at 09:00:00AM -0400, Mikulas Patocka wrote:
> >
> > BTW. gcmaes_crypt_by_sg also contains GFP_ATOMIC and -ENOMEM, behind a 
> > pretty complex condition. Do you mean that this condition is part of the 
> > contract that the crypto API provides?
> 
> This is an implementation defect.  I think for this case we should
> fall back to software GCM if the accelerated version fails.
> 
> > Should "req->src->offset + req->src->length < PAGE_SIZE" use "<=" instead? 
> > Because if the data ends up at page boundary, it will use the atomic 
> > allocation that can fail.
> 
> This condition does look strange.  It's introduced by the commit
> e845520707f85c539ce04bb73c6070e9441480be.   Dave, what exactly is
> it meant to do?

I forgot to Cc Dave Watson.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
