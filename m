Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E90C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A45C206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoeMe3xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A45C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeIENrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:47:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51631 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeIENrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:47:24 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so8949422itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/kmiQGk9OCyxH/PSMCRPEP5L1pOrph9HrPJQdBJjVYA=;
        b=ZoeMe3xufJpJ1tb7gn0v+O+pZS6pGLwPxDoCnweK6R2rpWiajaubPafWGY48aQiRZB
         bTTn9rYXQLzISz4lCmWkp9hS68X6gpIS5rku3vuch3rDtL209cfeAOJcSOPwZRO0ILpX
         yJoWipY8MecL5db7t3My4ie70z0izqdqghfLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/kmiQGk9OCyxH/PSMCRPEP5L1pOrph9HrPJQdBJjVYA=;
        b=NqzYzN71BQjP9yP4uxVK0SmtOE+MnnKtpOf/TYNQse7piY4ykJdur+DNTqLsuGBEKs
         6uafA0AVmK39sEQeYk156BAG1u9qe9r7pV8YG3hKQBHLPwPtl7rMC/IqHIbRiHpO+ftS
         WjrsUy6aLJD+fHprN4u70VbWEcPwd36j10iHiNppNRqpaOyTjEr/VQot+7GQOYjb2gGL
         1OBrG0M9S5tI1nDsa625Yy1h+L3amOw0pgbUJ9zyIGMaQ50oz5kHDfP/r3vh8ZGFOYoc
         zdal9xhkHqnf7irjp89B0kJah1WLLdYtblw4+yLjKanwgwoA2D15OhcMFLaUqwPcpgjm
         Rgsg==
X-Gm-Message-State: APzg51BqUK9vaYSlH27d6/U2JOd0jvYeY4Yw1pSBl/np8ma9rEbnRTE5
        4xr5q44W5/W9Gr/R28FdVTS8yrVRaqaXl6nmQlJ8KQ==
X-Google-Smtp-Source: ANB0VdascDCtuyiLYdKXT4LdTbgt2E3sM86tGjOe7lgshDUbcfvsHuAtkFEhMHJKPwt4CbaBYaP1XwMdKm9n5isU/to=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr3231500itq.9.1536139086156;
 Wed, 05 Sep 2018 02:18:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 02:18:05 -0700 (PDT)
In-Reply-To: <20180904181629.20712-3-keescook@chromium.org>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 5 Sep 2018 11:18:05 +0200
Message-ID: <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
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
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 September 2018 at 20:16, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> caps the skcipher request size similar to other limits and adds a sanity
> check at registration. Looking at instrumented tcrypt output, the largest
> is for lrw:
>
>         crypt: testing lrw(aes)
>         crypto_skcipher_set_reqsize: 8
>         crypto_skcipher_set_reqsize: 88
>         crypto_skcipher_set_reqsize: 472
>

Are you sure this is a representative sampling? I haven't double
checked myself, but we have plenty of drivers for peripherals in
drivers/crypto that implement block ciphers, and they would not turn
up in tcrypt unless you are running on a platform that provides the
hardware in question.

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
>         struct crypto_skcipher *skcipher, unsigned int reqsize)
>  {
> +       if (WARN_ON(reqsize > SKCIPHER_MAX_REQSIZE))
> +               return -EINVAL;
> +
>         skcipher->reqsize = reqsize;
>
>         return 0;
> diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
> index 2f327f090c3e..c48e194438cf 100644
> --- a/include/crypto/skcipher.h
> +++ b/include/crypto/skcipher.h
> @@ -139,9 +139,11 @@ struct skcipher_alg {
>         struct crypto_alg base;
>  };
>
> +#define SKCIPHER_MAX_REQSIZE   472
> +
>  #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
>         char __##name##_desc[sizeof(struct skcipher_request) + \
> -               crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
> +               SKCIPHER_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
>         struct skcipher_request *name = (void *)__##name##_desc
>
>  /**
> --
> 2.17.1
>
