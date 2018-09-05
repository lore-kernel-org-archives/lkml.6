Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8806FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB192077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB192077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIEKlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:41:23 -0400
Received: from webbox1416.server-home.net ([77.236.96.61]:39503 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbeIEKlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:41:23 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2018 06:41:23 EDT
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id CF62927A6B3;
        Wed,  5 Sep 2018 08:05:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by imapserver.systec-electronic.com (Postfix) with ESMTP id 9F04A1A1B50;
        Wed,  5 Sep 2018 08:05:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at imapserver.systec-electronic.com
Received: from imapserver.systec-electronic.com ([127.0.0.1])
        by localhost (imapserver.systec-electronic.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fAX3J75soR6O; Wed,  5 Sep 2018 08:05:29 +0200 (CEST)
Received: from ws-140106.localnet (ws-140106.systec.local [192.168.10.92])
        by imapserver.systec-electronic.com (Postfix) with ESMTPA id 97DCB1A1B4F;
        Wed,  5 Sep 2018 08:05:29 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
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
Subject: Re: [PATCH 2/2] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
Date:   Wed, 05 Sep 2018 08:05:29 +0200
Message-ID: <2109885.PdqaXYh4EC@ws-140106>
In-Reply-To: <20180904181629.20712-3-keescook@chromium.org>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 4, 2018, 8:16:29 PM CEST Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> caps the skcipher request size similar to other limits and adds a sanity
> check at registration. Looking at instrumented tcrypt output, the largest
> is for lrw:
> 
> 	crypt: testing lrw(aes)
> 	crypto_skcipher_set_reqsize: 8
> 	crypto_skcipher_set_reqsize: 88
> 	crypto_skcipher_set_reqsize: 472
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/crypto/internal/skcipher.h | 3 +++
>  include/crypto/skcipher.h          | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/crypto/internal/skcipher.h b/include/crypto/internal/skcipher.h
> index d2926ecae2ac..6da811c0747e 100644
> --- a/include/crypto/internal/skcipher.h
> +++ b/include/crypto/internal/skcipher.h
> @@ -130,6 +130,9 @@ static inline struct crypto_skcipher *crypto_spawn_skcipher(
>  static inline int crypto_skcipher_set_reqsize(
>  	struct crypto_skcipher *skcipher, unsigned int reqsize)
>  {
> +	if (WARN_ON(reqsize > SKCIPHER_MAX_REQSIZE))
> +		return -EINVAL;
> +
>  	skcipher->reqsize = reqsize;
>  
>  	return 0;
> diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
> index 2f327f090c3e..c48e194438cf 100644
> --- a/include/crypto/skcipher.h
> +++ b/include/crypto/skcipher.h
> @@ -139,9 +139,11 @@ struct skcipher_alg {
>  	struct crypto_alg base;
>  };
>  
> +#define SKCIPHER_MAX_REQSIZE	472
> +
>  #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
>  	char __##name##_desc[sizeof(struct skcipher_request) + \
> -		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
> +		SKCIPHER_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
>  	struct skcipher_request *name = (void *)__##name##_desc

Now tfm could be removed from the macro arguments, no?

Best regards,
Alexander



