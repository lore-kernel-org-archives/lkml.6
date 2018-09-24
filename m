Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A313ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14E22145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFVEpeQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14E22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbeIXRu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:50:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34552 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIXRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:50:26 -0400
Received: by mail-io1-f66.google.com with SMTP id h16-v6so7016969ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 04:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mn+i50RmcCgSWcLcAQofhZ5lI1QtQIaMo0Rx4A5Yi8U=;
        b=XFVEpeQV3b9fF8QFBIfIuJKr1hgmCgAvy/CzerAj17+9mLBmoHrGQApVPJjunnViRm
         pgjspTjNe5PBXvinClG7756inCXleUBEc06jM7piRo6GiMoa8OMOKon0L8navBcdiGY7
         Lrt77QPo+USFkP4oq0p1faziLd/zRD7GTdWx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mn+i50RmcCgSWcLcAQofhZ5lI1QtQIaMo0Rx4A5Yi8U=;
        b=Bv5Z+4VtqsSCi/BjZJhd9D7SW/uFryI4PW96QkU7pQPdtaRM0XglsevXb0Fxd98lHN
         OqTI5wkgt/cm4OLm2mP+X20ea7OxIl+Sv0mozlD5a3Ig1l4SEF6ZuYucIdhYcWVAbCcL
         8PEdkoFmhhbPSUzllrhKaXbL4TGs2p7+yrMOa5rCMOoxyvlLfejiN4mRwkPFOi/3bBCc
         ANAqDvuqJcKzM9friOjqUQKRcNatJtDA8S9ptpWRPgwm6aRRzhUov5I1sPqShs33QdU7
         8U1DbJzYMB95bB3MK/k1juunQpFRU9x52LwhiJV+7AmTO9lvtlWhFafudEiEWRyHO/q/
         b8nQ==
X-Gm-Message-State: ABuFfogBmgKT754AkkoPK+SOSWG+orkIAVwndPTWxWpEv2k7+WHKSmey
        Ub1eqwQPtKUSmnE3JOS/VvohtUftlIYSsYvPbydyHg==
X-Google-Smtp-Source: ACcGV621/HCmCtDIavucDAXE4stMHjT9SmDJt4rIqbYQmmcQikQUaKF08dG1GixtuhbicnboBvO1Uhwr/01ABnCrK6Q=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr7645918iof.173.1537789722774;
 Mon, 24 Sep 2018 04:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180919021100.3380-1-keescook@chromium.org> <20180919021100.3380-2-keescook@chromium.org>
In-Reply-To: <20180919021100.3380-2-keescook@chromium.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 24 Sep 2018 13:48:30 +0200
Message-ID: <CAKv+Gu8v0e-6Xv4_1W5qcUV_3Hed9rTXmJ9vzYTf1jEHnyaxaQ@mail.gmail.com>
Subject: Re: [PATCH crypto-next 01/23] crypto: skcipher - Introduce crypto_sync_skcipher
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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
> In preparation for removal of VLAs due to skcipher requests on the stack
> via SKCIPHER_REQUEST_ON_STACK() usage, this introduces the infrastructure
> for the "sync skcipher" tfm, which is for handling the on-stack cases of
> skcipher, which are always non-ASYNC and have a known limited request
> size.
>
> The crypto API additions:
>
>         struct crypto_sync_skcipher (wrapper for struct crypto_skcipher)
>         crypto_alloc_sync_skcipher()
>         crypto_free_sync_skcipher()
>         crypto_sync_skcipher_setkey()
>         crypto_sync_skcipher_get_flags()
>         crypto_sync_skcipher_set_flags()
>         crypto_sync_skcipher_clear_flags()
>         crypto_sync_skcipher_blocksize()
>         crypto_sync_skcipher_ivsize()
>         crypto_sync_skcipher_reqtfm()
>         skcipher_request_set_sync_tfm()
>         SYNC_SKCIPHER_REQUEST_ON_STACK() (with tfm type check)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  crypto/skcipher.c         | 24 +++++++++++++
>  include/crypto/skcipher.h | 75 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
>
> diff --git a/crypto/skcipher.c b/crypto/skcipher.c
> index 0bd8c6caa498..4caab81d2d02 100644
> --- a/crypto/skcipher.c
> +++ b/crypto/skcipher.c
> @@ -949,6 +949,30 @@ struct crypto_skcipher *crypto_alloc_skcipher(const char *alg_name,
>  }
>  EXPORT_SYMBOL_GPL(crypto_alloc_skcipher);
>
> +struct crypto_sync_skcipher *crypto_alloc_sync_skcipher(
> +                               const char *alg_name, u32 type, u32 mask)
> +{
> +       struct crypto_skcipher *tfm;
> +
> +       /* Only sync algorithms allowed. */
> +       mask |= CRYPTO_ALG_ASYNC;
> +
> +       tfm = crypto_alloc_tfm(alg_name, &crypto_skcipher_type2, type, mask);
> +
> +       /*
> +        * Make sure we do not allocate something that might get used with
> +        * an on-stack request: check the request size.
> +        */
> +       if (!IS_ERR(tfm) && WARN_ON(crypto_skcipher_reqsize(tfm) >
> +                                   MAX_SYNC_SKCIPHER_REQSIZE)) {
> +               crypto_free_skcipher(tfm);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return (struct crypto_sync_skcipher *)tfm;
> +}
> +EXPORT_SYMBOL_GPL(crypto_alloc_sync_skcipher);
> +
>  int crypto_has_skcipher2(const char *alg_name, u32 type, u32 mask)
>  {
>         return crypto_type_has_alg(alg_name, &crypto_skcipher_type2,
> diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
> index 2f327f090c3e..d00ce90dc7da 100644
> --- a/include/crypto/skcipher.h
> +++ b/include/crypto/skcipher.h
> @@ -65,6 +65,10 @@ struct crypto_skcipher {
>         struct crypto_tfm base;
>  };
>
> +struct crypto_sync_skcipher {
> +       struct crypto_skcipher base;
> +};
> +
>  /**
>   * struct skcipher_alg - symmetric key cipher definition
>   * @min_keysize: Minimum key size supported by the transformation. This is the
> @@ -139,6 +143,19 @@ struct skcipher_alg {
>         struct crypto_alg base;
>  };
>
> +#define MAX_SYNC_SKCIPHER_REQSIZE      384
> +/*
> + * This performs a type-check against the "tfm" argument to make sure
> + * all users have the correct skcipher tfm for doing on-stack requests.
> + */
> +#define SYNC_SKCIPHER_REQUEST_ON_STACK(name, tfm) \
> +       char __##name##_desc[sizeof(struct skcipher_request) + \
> +                            MAX_SYNC_SKCIPHER_REQSIZE + \
> +                            (!(sizeof((struct crypto_sync_skcipher *)1 == \
> +                                      (typeof(tfm))1))) \
> +                           ] CRYPTO_MINALIGN_ATTR; \
> +       struct skcipher_request *name = (void *)__##name##_desc
> +
>  #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
>         char __##name##_desc[sizeof(struct skcipher_request) + \
>                 crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
> @@ -197,6 +214,9 @@ static inline struct crypto_skcipher *__crypto_skcipher_cast(
>  struct crypto_skcipher *crypto_alloc_skcipher(const char *alg_name,
>                                               u32 type, u32 mask);
>
> +struct crypto_sync_skcipher *crypto_alloc_sync_skcipher(const char *alg_name,
> +                                             u32 type, u32 mask);
> +
>  static inline struct crypto_tfm *crypto_skcipher_tfm(
>         struct crypto_skcipher *tfm)
>  {
> @@ -212,6 +232,11 @@ static inline void crypto_free_skcipher(struct crypto_skcipher *tfm)
>         crypto_destroy_tfm(tfm, crypto_skcipher_tfm(tfm));
>  }
>
> +static inline void crypto_free_sync_skcipher(struct crypto_sync_skcipher *tfm)
> +{
> +       crypto_free_skcipher(&tfm->base);
> +}
> +
>  /**
>   * crypto_has_skcipher() - Search for the availability of an skcipher.
>   * @alg_name: is the cra_name / name or cra_driver_name / driver name of the
> @@ -280,6 +305,12 @@ static inline unsigned int crypto_skcipher_ivsize(struct crypto_skcipher *tfm)
>         return tfm->ivsize;
>  }
>
> +static inline unsigned int crypto_sync_skcipher_ivsize(
> +       struct crypto_sync_skcipher *tfm)
> +{
> +       return crypto_skcipher_ivsize(&tfm->base);
> +}
> +
>  static inline unsigned int crypto_skcipher_alg_chunksize(
>         struct skcipher_alg *alg)
>  {
> @@ -356,6 +387,12 @@ static inline unsigned int crypto_skcipher_blocksize(
>         return crypto_tfm_alg_blocksize(crypto_skcipher_tfm(tfm));
>  }
>
> +static inline unsigned int crypto_sync_skcipher_blocksize(
> +       struct crypto_sync_skcipher *tfm)
> +{
> +       return crypto_skcipher_blocksize(&tfm->base);
> +}
> +
>  static inline unsigned int crypto_skcipher_alignmask(
>         struct crypto_skcipher *tfm)
>  {
> @@ -379,6 +416,24 @@ static inline void crypto_skcipher_clear_flags(struct crypto_skcipher *tfm,
>         crypto_tfm_clear_flags(crypto_skcipher_tfm(tfm), flags);
>  }
>
> +static inline u32 crypto_sync_skcipher_get_flags(
> +       struct crypto_sync_skcipher *tfm)
> +{
> +       return crypto_skcipher_get_flags(&tfm->base);
> +}
> +
> +static inline void crypto_sync_skcipher_set_flags(
> +       struct crypto_sync_skcipher *tfm, u32 flags)
> +{
> +       crypto_skcipher_set_flags(&tfm->base, flags);
> +}
> +
> +static inline void crypto_sync_skcipher_clear_flags(
> +       struct crypto_sync_skcipher *tfm, u32 flags)
> +{
> +       crypto_skcipher_clear_flags(&tfm->base, flags);
> +}
> +
>  /**
>   * crypto_skcipher_setkey() - set key for cipher
>   * @tfm: cipher handle
> @@ -401,6 +456,12 @@ static inline int crypto_skcipher_setkey(struct crypto_skcipher *tfm,
>         return tfm->setkey(tfm, key, keylen);
>  }
>
> +static inline int crypto_sync_skcipher_setkey(struct crypto_sync_skcipher *tfm,
> +                                        const u8 *key, unsigned int keylen)
> +{
> +       return crypto_skcipher_setkey(&tfm->base, key, keylen);
> +}
> +
>  static inline unsigned int crypto_skcipher_default_keysize(
>         struct crypto_skcipher *tfm)
>  {
> @@ -422,6 +483,14 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm(
>         return __crypto_skcipher_cast(req->base.tfm);
>  }
>
> +static inline struct crypto_sync_skcipher *crypto_sync_skcipher_reqtfm(
> +       struct skcipher_request *req)
> +{
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +
> +       return container_of(tfm, struct crypto_sync_skcipher, base);
> +}
> +
>  /**
>   * crypto_skcipher_encrypt() - encrypt plaintext
>   * @req: reference to the skcipher_request handle that holds all information
> @@ -500,6 +569,12 @@ static inline void skcipher_request_set_tfm(struct skcipher_request *req,
>         req->base.tfm = crypto_skcipher_tfm(tfm);
>  }
>
> +static inline void skcipher_request_set_sync_tfm(struct skcipher_request *req,
> +                                           struct crypto_sync_skcipher *tfm)
> +{
> +       skcipher_request_set_tfm(req, &tfm->base);
> +}
> +
>  static inline struct skcipher_request *skcipher_request_cast(
>         struct crypto_async_request *req)
>  {
> --
> 2.17.1
>
