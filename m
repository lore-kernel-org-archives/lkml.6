Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D10C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A62125D17
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A62125D17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966471AbeF0W2Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:28:25 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:49638 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966251AbeF0W2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:28:23 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fYIuu-0000yI-17; Thu, 28 Jun 2018 06:28:00 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fYIuj-0004D7-G8; Thu, 28 Jun 2018 06:27:49 +0800
Date:   Thu, 28 Jun 2018 06:27:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, qat-linux@intel.com,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] crypto: skcipher: Remove VLA usage for
 SKCIPHER_REQUEST_ON_STACK
Message-ID: <20180627222749.xa5333caq5vaa7st@gondor.apana.org.au>
References: <20180625211026.15819-1-keescook@chromium.org>
 <20180625211026.15819-12-keescook@chromium.org>
 <20180626092041.mxfg4lxcvxfivzc2@gondor.apana.org.au>
 <CAGXu5jKYb-0NNvOcN79hzqU7O6vCFhMTBDGBL8Knuoc-YHamPg@mail.gmail.com>
 <20180627143622.ntksjxsymo4yw6dz@gondor.apana.org.au>
 <CAGXu5jJ2Z=YP+fNsvy+6a_BpC1ibZf6tOzZuPHk=Qx1qNVvOZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ2Z=YP+fNsvy+6a_BpC1ibZf6tOzZuPHk=Qx1qNVvOZw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:31:09AM -0700, Kees Cook wrote:
>
> I might be catching on... so from this list, I should only "count" the
> synchronous ones as being wrappable? The skcipher list is actually
> pretty short:
> 
> crypto/cryptd.c:        crypto_skcipher_set_reqsize(
> crypto/cryptd.c-                tfm, sizeof(struct
> cryptd_skcipher_request_ctx));

cryptd is async so you don't have to include it.
 
> These are "simple" wrappers:
> 
> crypto/lrw.c:   crypto_skcipher_set_reqsize(tfm,
> crypto_skcipher_reqsize(cipher) +
> crypto/lrw.c-                                    sizeof(struct rctx));
> 
> crypto/simd.c-  reqsize = sizeof(struct skcipher_request);
> crypto/simd.c-  reqsize += crypto_skcipher_reqsize(&cryptd_tfm->base);
> crypto/simd.c:  crypto_skcipher_set_reqsize(tfm, reqsize);

simd is async.

> crypto/xts.c:   crypto_skcipher_set_reqsize(tfm,
> crypto_skcipher_reqsize(child) +
> crypto/xts.c-                                    sizeof(struct rctx));
> 
> But what are the "legitimate" existing crypto_skcipher_reqsize() values here?
> 
> These are "complex" wrappers, with cts even adding blocksize to the mix...
> 
> crypto/ctr.c-   align = crypto_skcipher_alignmask(tfm);
> crypto/ctr.c-   align &= ~(crypto_tfm_ctx_alignment() - 1);
> crypto/ctr.c-   reqsize = align + sizeof(struct crypto_rfc3686_req_ctx) +
> crypto/ctr.c-             crypto_skcipher_reqsize(cipher);
> crypto/ctr.c:   crypto_skcipher_set_reqsize(tfm, reqsize);
> 
> crypto/cts.c-   align = crypto_skcipher_alignmask(tfm);
> crypto/cts.c-   bsize = crypto_skcipher_blocksize(cipher);
> crypto/cts.c-   reqsize = ALIGN(sizeof(struct crypto_cts_reqctx) +
> crypto/cts.c-                   crypto_skcipher_reqsize(cipher),
> crypto/cts.c-                   crypto_tfm_ctx_alignment()) +
> crypto/cts.c-             (align & ~(crypto_tfm_ctx_alignment() - 1)) + bsize;
> crypto/cts.c-
> crypto/cts.c:   crypto_skcipher_set_reqsize(tfm, reqsize);
> 
> What values might be expected here? It seems the entire blocksize
> needs to be included as well...

But otherwise yes these are the ones that count.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
