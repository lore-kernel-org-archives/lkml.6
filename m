Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3803FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB0426776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB0426776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeFZJU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:20:27 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:47630 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeFZJUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:20:25 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fXk8x-0004oY-Td; Tue, 26 Jun 2018 17:20:12 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fXk8l-00020g-0u; Tue, 26 Jun 2018 17:19:59 +0800
Date:   Tue, 26 Jun 2018 17:19:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-crypto@vger.kernel.org,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [dm-devel] [PATCH v2 10/11] crypto: ahash: Remove VLA usage for
 AHASH_REQUEST_ON_STACK
Message-ID: <20180626091958.zy3m24sjukfbn7av@gondor.apana.org.au>
References: <20180625211026.15819-1-keescook@chromium.org>
 <20180625211026.15819-11-keescook@chromium.org>
 <20180625225609.GA181665@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625225609.GA181665@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 03:56:09PM -0700, Eric Biggers wrote:
>
> > diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.h
> > index a0b0ad9d585e..d96ae5f52125 100644
> > --- a/include/crypto/internal/hash.h
> > +++ b/include/crypto/internal/hash.h
> > @@ -142,6 +142,7 @@ static inline struct ahash_alg *__crypto_ahash_alg(struct crypto_alg *alg)
> >  static inline void crypto_ahash_set_reqsize(struct crypto_ahash *tfm,
> >  					    unsigned int reqsize)
> >  {
> > +	BUG_ON(reqsize > AHASH_MAX_REQSIZE);
> >  	tfm->reqsize = reqsize;
> >  }
> 
> This isn't accounting for the cases where a hash algorithm is "wrapped" with
> another one, which increases the request size.  For example, "sha512_mb" ends up
> with a request size of

I think this patch is on the wrong track.  The stack requests are
only ever meant to be used for synchronous algorithms (IOW shash
algorithms) and were a quick-and-dirty fix for legacy users.

So either check SHASH_MAX_REQSIZE or just convert the users to
kmalloc or even better make them real async users.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
