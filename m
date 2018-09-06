Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBFEC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FFB2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QBPEf4FG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FFB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeIFFQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 01:16:35 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33889 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeIFFQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 01:16:34 -0400
Received: by mail-yb1-f194.google.com with SMTP id t10-v6so3470445ybb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 17:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dcbdufUUopdJyOnOyV1Megizm7y5y5d7D3ot2iOfDZ4=;
        b=QBPEf4FGRKhQLqGVa16a4JQt4rN/7vtEg/+v3tVZhSjvaNSrGflumjXj1l9FEroD97
         N3i/ZRLmeFvFx1HvFZ4OuGD+6rQ6E6xQtWuLaM3aZ2YCIiPKZDKsylr+OiFGt45fAAcm
         y+qD9rAScE2CFU9H6HkfhNApr60XYvSvhbzh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dcbdufUUopdJyOnOyV1Megizm7y5y5d7D3ot2iOfDZ4=;
        b=VNsnA3UF1xBjqZhYuR6GtEoZptcZbc+kscFpVRYyNtOmIRmRYNlAGwga4RWL5FBZZa
         yp1MPTb3FJcBOi07ybGH1/Z41xuY4Stn2tSlHLMe+P1wJvmz1zfQtK+i0s3VhSHYT2Ut
         ATQJ0B899NHKca/G9UEOlrX2CUS7TT0MSuMJ3YzhMwB7fgqxql7bnCKjE/NApCs828Le
         MAD0LziL/xLxoyASrfEAkNEZXexjh5dr9HlWhFc6qO4KwSVTsR8a3gocM/7DWZspl9t8
         GwhNq1e87h/T2SJrxi6bI6um4LseCyQuisg6iP34fDYfU0XQYf3xyjiEIikLxOk/veq0
         xDsg==
X-Gm-Message-State: APzg51D+OrdxJXhiyrEhe8PVyTPbmXg2TTINu/lAdduuYNWAH3KLifk3
        DNWXrjfnABwTTFAQKiNiPdUj59FRq68=
X-Google-Smtp-Source: ANB0VdZZBjNiuL/hxX2Z5mrzoQqRyPIYi22PJB6Yw/XLq6UpqNMu/0tvToI1n+MZbl1LQo8jZ4U3ww==
X-Received: by 2002:a25:ae0a:: with SMTP id a10-v6mr132641ybj.450.1536194632199;
        Wed, 05 Sep 2018 17:43:52 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id o128-v6sm1122656ywe.110.2018.09.05.17.43.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 17:43:52 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id t71-v6so3462368ybi.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 17:43:51 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr125262ybh.209.1536194631062;
 Wed, 05 Sep 2018 17:43:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 17:43:50 -0700 (PDT)
In-Reply-To: <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
 <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com> <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Sep 2018 17:43:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+z8eQKu_3sm93pdo+bBZDFqkHNM3Y0tKTDbnHfUNzywg@mail.gmail.com>
Message-ID: <CAGXu5j+z8eQKu_3sm93pdo+bBZDFqkHNM3Y0tKTDbnHfUNzywg@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

On Wed, Sep 5, 2018 at 3:49 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 5 September 2018 at 23:05, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Sep 5, 2018 at 2:18 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 4 September 2018 at 20:16, Kees Cook <keescook@chromium.org> wrote:
>>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>>> caps the skcipher request size similar to other limits and adds a sanity
>>>> check at registration. Looking at instrumented tcrypt output, the largest
>>>> is for lrw:
>>>>
>>>>         crypt: testing lrw(aes)
>>>>         crypto_skcipher_set_reqsize: 8
>>>>         crypto_skcipher_set_reqsize: 88
>>>>         crypto_skcipher_set_reqsize: 472
>>>>
>>>
>>> Are you sure this is a representative sampling? I haven't double
>>> checked myself, but we have plenty of drivers for peripherals in
>>> drivers/crypto that implement block ciphers, and they would not turn
>>> up in tcrypt unless you are running on a platform that provides the
>>> hardware in question.
>>
>> Hrm, excellent point. Looking at this again:
>>
>> The core part of the VLA is using this in the ON_STACK macro:
>>
>> static inline unsigned int crypto_skcipher_reqsize(struct crypto_skcipher *tfm)
>> {
>>         return tfm->reqsize;
>> }
>>
>> I don't find any struct crypto_skcipher .reqsize static initializers,
>> and the initial reqsize is here:
>>
>> static int crypto_init_skcipher_ops_ablkcipher(struct crypto_tfm *tfm)
>> {
>> ...
>>         skcipher->reqsize = crypto_ablkcipher_reqsize(ablkcipher) +
>>                             sizeof(struct ablkcipher_request);
>>
>> with updates via crypto_skcipher_set_reqsize().
>>
>> So I have to examine ablkcipher reqsize too:
>>
>> static inline unsigned int crypto_ablkcipher_reqsize(
>>         struct crypto_ablkcipher *tfm)
>> {
>>         return crypto_ablkcipher_crt(tfm)->reqsize;
>> }
>>
>> And of the crt_ablkcipher.reqsize assignments/initializers, I found:
>>
>> ablkcipher reqsize:
>> 1       struct dcp_aes_req_ctx
>> 8       struct atmel_tdes_reqctx
>> 8       struct cryptd_blkcipher_request_ctx
>> 8       struct mtk_aes_reqctx
>> 8       struct omap_des_reqctx
>> 8       struct s5p_aes_reqctx
>> 8       struct sahara_aes_reqctx
>> 8       struct stm32_cryp_reqctx
>> 8       struct stm32_cryp_reqctx
>> 16      struct ablk_ctx
>> 24      struct atmel_aes_reqctx
>> 48      struct omap_aes_reqctx
>> 48      struct omap_aes_reqctx
>> 48      struct qat_crypto_request
>> 56      struct artpec6_crypto_request_context
>> 64      struct chcr_blkcipher_req_ctx
>> 80      struct spacc_req
>> 80      struct virtio_crypto_sym_request
>> 136     struct qce_cipher_reqctx
>> 168     struct n2_request_context
>> 328     struct ccp_des3_req_ctx
>> 400     struct ccp_aes_req_ctx
>> 536     struct hifn_request_context
>> 992     struct cvm_req_ctx
>> 2456    struct iproc_reqctx_s
>>
>> The base ablkcipher wrapper is:
>> 80      struct ablkcipher_request
>>
>> And in my earlier skcipher wrapper analysis, lrw was the largest
>> skcipher wrapper:
>> 384     struct rctx
>>
>> iproc_reqctx_s is an extreme outlier, with cvm_req_ctx at a bit less than half.
>>
>> Making this a 2920 byte fixed array doesn't seem sensible at all
>> (though that's what's already possible to use with existing
>> SKCIPHER_REQUEST_ON_STACK users).
>>
>> What's the right path forward here?
>>
>
> The skcipher implementations based on crypto IP blocks are typically
> asynchronous, and I wouldn't be surprised if a fair number of
> SKCIPHER_REQUEST_ON_STACK() users are limited to synchronous
> skciphers.

Looks similar to ahash vs shash. :) Yes, so nearly all
crypto_alloc_skcipher() users explicitly mask away ASYNC. What's left
appears to be:

crypto/drbg.c:  sk_tfm = crypto_alloc_skcipher(ctr_name, 0, 0);
crypto/tcrypt.c:        tfm = crypto_alloc_skcipher(algo, 0, async ? 0
: CRYPTO_ALG_ASYNC);
drivers/crypto/omap-aes.c:      ctx->ctr =
crypto_alloc_skcipher("ecb(aes)", 0, 0);
drivers/md/dm-crypt.c:          cc->cipher_tfm.tfms[i] =
crypto_alloc_skcipher(ciphermode, 0, 0);
drivers/md/dm-integrity.c:              ic->journal_crypt =
crypto_alloc_skcipher(ic->journal_crypt_alg.alg_string, 0, 0);
fs/crypto/keyinfo.c:    struct crypto_skcipher *tfm =
crypto_alloc_skcipher("ecb(aes)", 0, 0);
fs/crypto/keyinfo.c:    ctfm = crypto_alloc_skcipher(mode->cipher_str, 0, 0);
fs/ecryptfs/crypto.c:   crypt_stat->tfm =
crypto_alloc_skcipher(full_alg_name, 0, 0);

I'll cross-reference this with SKCIPHER_REQUEST_ON_STACK...

> So we could formalize this and limit SKCIPHER_REQUEST_ON_STACK() to
> synchronous skciphers, which implies that the reqsize limit only has
> to apply synchronous skciphers as well. But before we can do this, we
> have to identify the remaining occurrences that allow asynchronous
> skciphers to be used, and replace them with heap allocations.

Sounds good; thanks!

-Kees

-- 
Kees Cook
Pixel Security
