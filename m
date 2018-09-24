Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C08ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592C32145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUsjtpde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592C32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeIXRri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:47:38 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33128 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbeIXRrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:47:37 -0400
Received: by mail-it1-f195.google.com with SMTP id j198-v6so4534616ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q87nrC+apH7L1XIIZhw+84Zc2xxQqXfyxDxKaTZ8ZQ8=;
        b=HUsjtpde3Dog128g81CvMw0puGMrEjIyA/YxDytTthbLBLAvRhNZ0PGl118TVsgpmc
         y9R/RUv0mQT+hhDCQGMQoRNQxqQYVPYFwFucXSKeymONE9r6KtLf8HISaCoYesHZtNfo
         0XwBM87d+3/yv0pgnr/EVzyTVWXtGxgbeMWrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q87nrC+apH7L1XIIZhw+84Zc2xxQqXfyxDxKaTZ8ZQ8=;
        b=tPJKAOtkHDdTn7Bt4A3qb2y3wQk5Okqm3zTkHFJEmlHjTpiMcqH2NYDyIhaW2vjTnN
         29kAAGuH+6qvsl7YdNBvXgVFlK+h0hpWsC0wXLOIrnLKvLos6mZQgpJFEJzEejzjL9jd
         WE5XMaxJ2cFu7ibuf9Bht/8B4ktXD/UnqqsIKCg7w+o7/GS7PIZy00emFg72otQLgBpb
         /k2DOHUgW62YDJDSAeRuDzbnlcDEJZE/ECcsfx8+OwWNRz3IlyK9UCokYxMnGht20qHq
         KuV2r/8knGoAKTOLYzOXwUn38ofltlfWXdUiF6Rjiv3392W4ghdHkdaOPr6pcOpKg/v0
         KtBw==
X-Gm-Message-State: APzg51BH/dtx9AOwXLgded1oqXA/9m6R88eAXWSRgHVS/bBO4uCpoGXQ
        n8BbUYV3N8XUQatYXDJe26vVWgntZi9XxgqEXVSSMA==
X-Google-Smtp-Source: ACcGV61kBTszCJ+bEFRCcT3/PJquuttDVin4/OcTa64q/Ajx0GQELdP8QZtXxlNEKmiw9Gev0FpjiZUB+VkRpBvWOMw=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr7339428ite.123.1537789554726;
 Mon, 24 Sep 2018 04:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180919021100.3380-1-keescook@chromium.org> <20180919021100.3380-7-keescook@chromium.org>
In-Reply-To: <20180919021100.3380-7-keescook@chromium.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 24 Sep 2018 13:45:41 +0200
Message-ID: <CAKv+Gu8OXbMZqQCM3MOa0Feag94j+wnKKfCCyzit3eRJSN5+_A@mail.gmail.com>
Subject: Re: [PATCH crypto-next 06/23] x86/fpu: Remove VLA usage of skcipher
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 at 04:11, Kees Cook <keescook@chromium.org> wrote:
>
> In the quest to remove all stack VLA usage from the kernel[1], this
> replaces struct crypto_skcipher and SKCIPHER_REQUEST_ON_STACK() usage
> with struct crypto_sync_skcipher and SYNC_SKCIPHER_REQUEST_ON_STACK(),
> which uses a fixed stack size.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Cc: x86@kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Doing some archeology on this driver, it turns out that the FPU
wrapper was introduced to support combining the generic CTR, LRW, XTS
and PCBC chaining modes with the AES-NI core transform. In the mean
time, CTR, LRW and XTS support have been implemented natively, which
leaves pcbc-aes-aesni as the only remaining user of the fpu template.

Since there are no users of pcbc(aes) in the kernel, could we perhaps
just remove this driver and all the special handling we have for it in
aesni-intel_glue.c?

If not, or in case we prefer to defer that to the next release:

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/x86/crypto/fpu.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/crypto/fpu.c b/arch/x86/crypto/fpu.c
> index 406680476c52..be9b3766f241 100644
> --- a/arch/x86/crypto/fpu.c
> +++ b/arch/x86/crypto/fpu.c
> @@ -20,21 +20,23 @@
>  #include <asm/fpu/api.h>
>
>  struct crypto_fpu_ctx {
> -       struct crypto_skcipher *child;
> +       struct crypto_sync_skcipher *child;
>  };
>
>  static int crypto_fpu_setkey(struct crypto_skcipher *parent, const u8 *key,
>                              unsigned int keylen)
>  {
>         struct crypto_fpu_ctx *ctx = crypto_skcipher_ctx(parent);
> -       struct crypto_skcipher *child = ctx->child;
> +       struct crypto_sync_skcipher *child = ctx->child;
>         int err;
>
> -       crypto_skcipher_clear_flags(child, CRYPTO_TFM_REQ_MASK);
> -       crypto_skcipher_set_flags(child, crypto_skcipher_get_flags(parent) &
> +       crypto_sync_skcipher_clear_flags(child, CRYPTO_TFM_REQ_MASK);
> +       crypto_sync_skcipher_set_flags(child,
> +                                      crypto_skcipher_get_flags(parent) &
>                                          CRYPTO_TFM_REQ_MASK);
> -       err = crypto_skcipher_setkey(child, key, keylen);
> -       crypto_skcipher_set_flags(parent, crypto_skcipher_get_flags(child) &
> +       err = crypto_sync_skcipher_setkey(child, key, keylen);
> +       crypto_skcipher_set_flags(parent,
> +                                 crypto_sync_skcipher_get_flags(child) &
>                                           CRYPTO_TFM_RES_MASK);
>         return err;
>  }
> @@ -43,11 +45,11 @@ static int crypto_fpu_encrypt(struct skcipher_request *req)
>  {
>         struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
>         struct crypto_fpu_ctx *ctx = crypto_skcipher_ctx(tfm);
> -       struct crypto_skcipher *child = ctx->child;
> -       SKCIPHER_REQUEST_ON_STACK(subreq, child);
> +       struct crypto_sync_skcipher *child = ctx->child;
> +       SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, child);
>         int err;
>
> -       skcipher_request_set_tfm(subreq, child);
> +       skcipher_request_set_sync_tfm(subreq, child);
>         skcipher_request_set_callback(subreq, 0, NULL, NULL);
>         skcipher_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
>                                    req->iv);
> @@ -64,11 +66,11 @@ static int crypto_fpu_decrypt(struct skcipher_request *req)
>  {
>         struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
>         struct crypto_fpu_ctx *ctx = crypto_skcipher_ctx(tfm);
> -       struct crypto_skcipher *child = ctx->child;
> -       SKCIPHER_REQUEST_ON_STACK(subreq, child);
> +       struct crypto_sync_skcipher *child = ctx->child;
> +       SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, child);
>         int err;
>
> -       skcipher_request_set_tfm(subreq, child);
> +       skcipher_request_set_sync_tfm(subreq, child);
>         skcipher_request_set_callback(subreq, 0, NULL, NULL);
>         skcipher_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
>                                    req->iv);
> @@ -93,7 +95,7 @@ static int crypto_fpu_init_tfm(struct crypto_skcipher *tfm)
>         if (IS_ERR(cipher))
>                 return PTR_ERR(cipher);
>
> -       ctx->child = cipher;
> +       ctx->child = (struct crypto_sync_skcipher *)cipher;
>
>         return 0;
>  }
> @@ -102,7 +104,7 @@ static void crypto_fpu_exit_tfm(struct crypto_skcipher *tfm)
>  {
>         struct crypto_fpu_ctx *ctx = crypto_skcipher_ctx(tfm);
>
> -       crypto_free_skcipher(ctx->child);
> +       crypto_free_sync_skcipher(ctx->child);
>  }
>
>  static void crypto_fpu_free(struct skcipher_instance *inst)
> --
> 2.17.1
>
