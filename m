Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755108AbeDCKTW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:19:22 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:59222 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754949AbeDCKTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:19:21 -0400
Date: Tue, 3 Apr 2018 18:19:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] crypto: ccree: enable support for hardware keys
Message-ID: <20180403101905.GA4245@gondor.apana.org.au>
References: <1522049540-10042-1-git-send-email-gilad@benyossef.com>
 <1522049540-10042-3-git-send-email-gilad@benyossef.com>
 <20180330172616.GB28120@gondor.apana.org.au>
 <CAOtvUMd6MMyQBHU4E=5DKXndhZw90=K1V1apD0uRRaMLyp-0Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMd6MMyQBHU4E=5DKXndhZw90=K1V1apD0uRRaMLyp-0Ag@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 08:30:46PM +0300, Gilad Ben-Yossef wrote:
>
> However, as it uses the exact same mechanism of the regular xts-aes-ccree
> but takes the key from another source, I've marked it with a test of
> alg_test_null() on the premise that if the xts-aes-ccree works, so must this.

Well it appears to be stubbed out as cc_is_hw_key always returns
false.

> > Are there other crypto drivers doing this?
> 
> I thought the exact same thing until I ran into a presentation about the s390
> secure keys implementation. I basically imitated their use (or abuse?)
> of the Crypto API
> assuming it is the way to go.
> 
> Take a look at arch/s390/crypto/paes_s390.c

It's always nice to discover code that was never reviewed.

The general approach seems sane though.

> Anyway, if this is not the way to go I'd be more than happy to do whatever
> work is needed to create the right interface.
> 
> PS. I'd be out of the office and away from email access to the coming week, so
> kindly excuse any delay in response.

I think it's fine.  However, I don't really like the idea of everyone
coming up with their own "paes", i.e., your patch's use of "haes".
It should be OK to just use paes for everyone, no?

As to your patch specifically, there is one issue where you're
directly dereferencing the key as a struct.  This is a no-no because
the key may have come from user-space.  You must treat it as a
binary blob.  The s390 code seems to do this correctly.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
