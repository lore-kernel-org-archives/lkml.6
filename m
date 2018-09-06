Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440D3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AF620659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GkNx1cL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AF620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbeIGA7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:59:46 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33608 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbeIGA7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:59:46 -0400
Received: by mail-yb1-f196.google.com with SMTP id m123-v6so4648848ybm.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5fBzsKNrK1XlMaV/v/8BAzradqMlA6eOOAS7RLJEiAM=;
        b=GkNx1cL+aqbmwy5Npex2Qt2V5wacOpaJECzB7zT4pIpPHhDk8YoG6uZEkfHndkt4tz
         LkWC5QHO9NEvsgvrF6SQPWEQgQRhSEiK9kRFQve9dp8taLmPozb/ttvmrfB3OKdSf57K
         p/bOWx/eBaO3UWEvpXSHCgs9FK8cjEp3FjRyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5fBzsKNrK1XlMaV/v/8BAzradqMlA6eOOAS7RLJEiAM=;
        b=UKYOUb/B2QTtLP4yCyPyTDJg1IAMMVgzC01N3bEtt1BODYqjBEX2J8x5nxFmg7dT9A
         2CrXtgeVKfOcTnuz8UFvaW9FucWCqpFP/nbFSlWSdG9l//Yzy9Y8LUEYDfNMtLoXwWrl
         5XtMhidBmdxh342SJbrXNT8rLtWqZaHiF+uaC0hKMDy38qlXhxphNc1U30gFzY6X+j7G
         SCnNf17viRsjzV1DiMh1ng8gbvxj6cze6AcWaAcq2hlwPXs/Z4jBLoe2FAWnE3USxuLg
         LE9owRwKrVNXiFJxmKUxD851ZfVg1X1CksXybYV0ShA5i2dfMNkHOxXYZRP8/tWPe8Lq
         bEjw==
X-Gm-Message-State: APzg51DCOynQg2YdLaphARaKBHwvmPeTf5yV1GvXzuDYJyCRpPp30yxp
        xGfTmaitXgyXOaAraMTdr/3f1ePeiaQ=
X-Google-Smtp-Source: ANB0Vdam9yknwdwpeZgPeNfw0wvdV2ZuQOdXv0dZV6Pk2D3NdjBBsCB+PcZneQCWQ88sfvWowZ3Mrw==
X-Received: by 2002:a25:3d2:: with SMTP id 201-v6mr2501246ybd.160.1536265358437;
        Thu, 06 Sep 2018 13:22:38 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id 138-v6sm3097092ywj.30.2018.09.06.13.22.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:22:35 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id m62-v6so4582082ywd.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 13:22:34 -0700 (PDT)
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr2606061ywg.288.1536265353932;
 Thu, 06 Sep 2018 13:22:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 13:22:32 -0700 (PDT)
In-Reply-To: <CAGXu5j+z8eQKu_3sm93pdo+bBZDFqkHNM3Y0tKTDbnHfUNzywg@mail.gmail.com>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
 <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
 <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com> <CAGXu5j+z8eQKu_3sm93pdo+bBZDFqkHNM3Y0tKTDbnHfUNzywg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Sep 2018 13:22:32 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJHnUF_C7ChNdxkYMPW59-jTMSJpiTB7XyAYhe6=00zbg@mail.gmail.com>
Message-ID: <CAGXu5jJHnUF_C7ChNdxkYMPW59-jTMSJpiTB7XyAYhe6=00zbg@mail.gmail.com>
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

On Wed, Sep 5, 2018 at 5:43 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Sep 5, 2018 at 3:49 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 5 September 2018 at 23:05, Kees Cook <keescook@chromium.org> wrote:
>>> On Wed, Sep 5, 2018 at 2:18 AM, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>>> On 4 September 2018 at 20:16, Kees Cook <keescook@chromium.org> wrote:
>>>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>>>> caps the skcipher request size similar to other limits and adds a sanity
>>>>> check at registration. Looking at instrumented tcrypt output, the largest
>>>>> is for lrw:
>>>>>
>>>>>         crypt: testing lrw(aes)
>>>>>         crypto_skcipher_set_reqsize: 8
>>>>>         crypto_skcipher_set_reqsize: 88
>>>>>         crypto_skcipher_set_reqsize: 472
>>>>>
>>>>
>>>> Are you sure this is a representative sampling? I haven't double
>>>> checked myself, but we have plenty of drivers for peripherals in
>>>> drivers/crypto that implement block ciphers, and they would not turn
>>>> up in tcrypt unless you are running on a platform that provides the
>>>> hardware in question.
>>>
>>> Hrm, excellent point. Looking at this again:
>>> [...]
>>> And of the crt_ablkcipher.reqsize assignments/initializers, I found:
>>>
>>> ablkcipher reqsize:
>>> 1       struct dcp_aes_req_ctx
>>> 8       struct atmel_tdes_reqctx
>>> 8       struct cryptd_blkcipher_request_ctx
>>> 8       struct mtk_aes_reqctx
>>> 8       struct omap_des_reqctx
>>> 8       struct s5p_aes_reqctx
>>> 8       struct sahara_aes_reqctx
>>> 8       struct stm32_cryp_reqctx
>>> 8       struct stm32_cryp_reqctx
>>> 16      struct ablk_ctx
>>> 24      struct atmel_aes_reqctx
>>> 48      struct omap_aes_reqctx
>>> 48      struct omap_aes_reqctx
>>> 48      struct qat_crypto_request
>>> 56      struct artpec6_crypto_request_context
>>> 64      struct chcr_blkcipher_req_ctx
>>> 80      struct spacc_req
>>> 80      struct virtio_crypto_sym_request
>>> 136     struct qce_cipher_reqctx
>>> 168     struct n2_request_context
>>> 328     struct ccp_des3_req_ctx
>>> 400     struct ccp_aes_req_ctx
>>> 536     struct hifn_request_context
>>> 992     struct cvm_req_ctx
>>> 2456    struct iproc_reqctx_s

All of these are ASYNC (they're all crt_ablkcipher), so IIUC, I can ignore them.

>>> The base ablkcipher wrapper is:
>>> 80      struct ablkcipher_request
>>>
>>> And in my earlier skcipher wrapper analysis, lrw was the largest
>>> skcipher wrapper:
>>> 384     struct rctx
>>>
>>> iproc_reqctx_s is an extreme outlier, with cvm_req_ctx at a bit less than half.
>>>
>>> Making this a 2920 byte fixed array doesn't seem sensible at all
>>> (though that's what's already possible to use with existing
>>> SKCIPHER_REQUEST_ON_STACK users).
>>>
>>> What's the right path forward here?
>>>
>>
>> The skcipher implementations based on crypto IP blocks are typically
>> asynchronous, and I wouldn't be surprised if a fair number of
>> SKCIPHER_REQUEST_ON_STACK() users are limited to synchronous
>> skciphers.
>
> Looks similar to ahash vs shash. :) Yes, so nearly all
> crypto_alloc_skcipher() users explicitly mask away ASYNC. What's left
> appears to be:
>
> crypto/drbg.c:  sk_tfm = crypto_alloc_skcipher(ctr_name, 0, 0);
> crypto/tcrypt.c:        tfm = crypto_alloc_skcipher(algo, 0, async ? 0
> : CRYPTO_ALG_ASYNC);
> drivers/crypto/omap-aes.c:      ctx->ctr =
> crypto_alloc_skcipher("ecb(aes)", 0, 0);
> drivers/md/dm-crypt.c:          cc->cipher_tfm.tfms[i] =
> crypto_alloc_skcipher(ciphermode, 0, 0);
> drivers/md/dm-integrity.c:              ic->journal_crypt =
> crypto_alloc_skcipher(ic->journal_crypt_alg.alg_string, 0, 0);
> fs/crypto/keyinfo.c:    struct crypto_skcipher *tfm =
> crypto_alloc_skcipher("ecb(aes)", 0, 0);
> fs/crypto/keyinfo.c:    ctfm = crypto_alloc_skcipher(mode->cipher_str, 0, 0);
> fs/ecryptfs/crypto.c:   crypt_stat->tfm =
> crypto_alloc_skcipher(full_alg_name, 0, 0);
>
> I'll cross-reference this with SKCIPHER_REQUEST_ON_STACK...

None of these use SKCIPHER_REQUEST_ON_STACK that I can find.

>> So we could formalize this and limit SKCIPHER_REQUEST_ON_STACK() to
>> synchronous skciphers, which implies that the reqsize limit only has
>> to apply synchronous skciphers as well. But before we can do this, we
>> have to identify the remaining occurrences that allow asynchronous
>> skciphers to be used, and replace them with heap allocations.
>
> Sounds good; thanks!

crypto_init_skcipher_ops_blkcipher() doesn't touch reqsize at all, so
the only places I can find it gets changed are with direct callers of
crypto_skcipher_set_reqsize(), which, when wrapping a sync blkcipher
start with a reqsize == 0. So, the remaining non-ASYNC callers ask
for:

4       struct sun4i_cipher_req_ctx
96      struct crypto_rfc3686_req_ctx
375     sum:
                160     crypto_skcipher_blocksize(cipher) (max)
                152     struct crypto_cts_reqctx
                63      align_mask (max)
384     struct rctx

So, following your patch to encrypt/decrypt, I can add reqsize check
there. How does this look, on top of your patch?

--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -144,9 +144,10 @@ struct skcipher_alg {
 /*
  * This must only ever be used with synchronous algorithms.
  */
+#define MAX_SYNC_SKCIPHER_REQSIZE      384
 #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
        char __##name##_desc[sizeof(struct skcipher_request) + \
-               crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR = { 1 } \
+               MAX_SYNC_SKCIPHER_REQSIZE] CRYPTO_MINALIGN_ATTR = { 1 } \
        struct skcipher_request *name = (void *)__##name##_desc

 /**
@@ -442,10 +443,14 @@ static inline int crypto_skcipher_encrypt(struct
skcipher_request *req)
 {
        struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);

-       if (req->__onstack &&
-           WARN_ON(crypto_skcipher_alg(tfm)->base.cra_flags &
-                       CRYPTO_ALG_ASYNC))
-               return -EINVAL;
+       if (req->__onstack) {
+               if (WARN_ON(crypto_skcipher_alg(tfm)->base.cra_flags &
+                               CRYPTO_ALG_ASYNC))
+                       return -EINVAL;
+               if (WARN_ON(crypto_skcipher_reqsize(tfm) >
+                               MAX_SYNC_SKCIPHER_REQSIZE))
+                       return -ENOSPC;
+       }
...etc

-- 
Kees Cook
Pixel Security
