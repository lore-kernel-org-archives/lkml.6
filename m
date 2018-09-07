Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84BBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA8120857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA8120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIGIV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:21:56 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:44530 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeIGIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:21:56 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fy7fW-0005HT-1E; Fri, 07 Sep 2018 11:42:50 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fy7fO-0000lW-SR; Fri, 07 Sep 2018 11:42:42 +0800
Date:   Fri, 7 Sep 2018 11:42:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack
 requests
Message-ID: <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
References: <20180906225854.40989-1-keescook@chromium.org>
 <20180906225854.40989-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906225854.40989-3-keescook@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:58:52PM -0700, Kees Cook wrote:
>
> @@ -437,6 +442,12 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm_check(
>  {
>  	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
>  
> +	if (req->__onstack) {
> +		if (WARN_ON(crypto_skcipher_alg(tfm)->base.cra_flags &
> +				CRYPTO_ALG_ASYNC))
> +			return ERR_PTR(-EINVAL);
> +	}

Sorry but I don't like imposing a run-time check on everybody when
stack-based requests are the odd ones out.  If we're going to make
this a run-time check (I'd much prefer a compile-time check, but I
understand that this may involve too much churn), then please do it
for stack-based request users only.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
