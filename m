Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7946DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6CF2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6CF2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeH3Rlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:41:50 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:54548 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbeH3Rlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:41:50 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fvNAd-0006PL-2x; Thu, 30 Aug 2018 21:39:35 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fvNAZ-0005QQ-1r; Thu, 30 Aug 2018 21:39:31 +0800
Date:   Thu, 30 Aug 2018 21:39:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        smueller@chronox.de
Subject: Re: Locking for HW crypto accelerators
Message-ID: <20180830133930.r7s5hmnriif46hlr@gondor.apana.org.au>
References: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 02:22:22PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> I am trying to figure out necessary locking on the driver side of
> crypto HW accelerator for symmetric hash (actually: CRC). I
> implemented quite simple driver for shash_alg.
> 
> I looked at the docs, I looked at the crypto kcapi core code... and
> there is nothing about necessary locking. kcapi does not perform it.
> 
> My HW is quite similar to drivers/crypto/stm32/stm32_crc32.c so it has
> only one HW set of registers for dealing with CRC. Or in other words,
> only one queue of one element. :) I implemented all shash_alg
> callbacks - init(), update(), final()... and also finup() (manually
> calling update+final) and digest() (init+update+final).
> 
> Now imagine multiple user-space users of this crypto alg where all of
> them call kcapi_md_digest() (so essentially init() -> update() ->
> final()). It seems that kcapi does not perform any locking here so at
> some point updates from different processes might be mixed with
> finals:
> 
> Process A:             Process B:
> init()
>                        init()
> update()
>                        update()
> final()
>                        final()
> 
> My findings show that the requests are indeed being mixed with each other...

After each operation all state must be stored in the ahash_request
object.  The next operation should then load the state from the
request object into the hardware.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
