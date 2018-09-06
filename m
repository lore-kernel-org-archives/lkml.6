Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F49C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2ACE20861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ACE20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeIFRrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:47:49 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:42002 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:47:49 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fxu4m-00064A-LX; Thu, 06 Sep 2018 21:12:00 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fxu4b-000820-4F; Thu, 06 Sep 2018 21:11:49 +0800
Date:   Thu, 6 Sep 2018 21:11:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] crypto: skcipher: Remove VLA usage for
 SKCIPHER_REQUEST_ON_STACK
Message-ID: <20180906131149.ge2db74nxffs2tbz@gondor.apana.org.au>
References: <20180904181629.20712-1-keescook@chromium.org>
 <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
 <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
 <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
 <CAOtvUMfu4-DWD4n4c5itjArAYWhGaBnPBEnkh6cbCubG-k9cCA@mail.gmail.com>
 <CAKv+Gu8bKcPksgoryaVjoD9G5KeCYrqWOCgVhqrBqGw5dCzXag@mail.gmail.com>
 <CAKv+Gu-QkCE0pY4+5anEZ0eWv-FTH1QJtOQfPcTVLcvNf7XNiA@mail.gmail.com>
 <20180906085100.xcqqftgqg4sizkec@gondor.apana.org.au>
 <CAKv+Gu_0ehX9sLCtUYR00D4iQw+ytwmsLKmG6dgq9EnLjidKFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_0ehX9sLCtUYR00D4iQw+ytwmsLKmG6dgq9EnLjidKFw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 11:29:41AM +0200, Ard Biesheuvel wrote:
>
> Perhaps not, but it is not enforced atm.
> 
> In any case, limiting the reqsize is going to break things, so that
> needs to occur based on the sync/async nature of the algo. That also
> means we'll corrupt the stack if we ever end up using
> SKCIPHER_REQUEST_ON_STACK() with an async algo whose reqsize is
> greater than the sync reqsize limit, so I do think some additional
> sanity check is appropriate.

I'd prefer compile-time based checks.  Perhaps we can introduce
a wrapper around crypto_skcipher, say crypto_skcipher_sync which
could then be used by SKCIPHER_REQUEST_ON_STACK to ensure that
only sync algorithms can use this construct.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
