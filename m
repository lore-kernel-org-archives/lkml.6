Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AA7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F942075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bKa5W7Th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F942075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIFBmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:42:32 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38237 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIFBmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:42:31 -0400
Received: by mail-yw1-f68.google.com with SMTP id n21-v6so3235294ywh.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OKsie9R6idiavEQFA9FzG93r8uZfFlPtlZcfLIjtdqs=;
        b=bKa5W7ThY9VKsL9/BZRzf23mnVpiITRCKunuyfyXaAjXo4JDPKw99Z/n1Rhng3CItn
         hLYM+wWgMlxnu2v40tAhArrsawosRJUsB0TgAGnJLT5oDl3nRfnQpqrWa58vPAMVoZZ+
         0b0YAfeIFXI0nGv6+bfqE+AFepEacOz9CutrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OKsie9R6idiavEQFA9FzG93r8uZfFlPtlZcfLIjtdqs=;
        b=roi5l59DaT1mkxWIJOJpXY4f1e26a6TLrGpNbl1BCXfpNiiHyXeehBWE6r07nkNWWK
         TlZOq9MnXCHohpqEmYrE++bS20gsBSpfcnm2IhmMl6WqSDw0EQpmwv7+OTUf2TB951em
         4BblOPtBXFv6h4gTp9XEVkX+joGgWUZFEhUuMclyauWgMAhKUY3vKtiJGNtENJ83oZzw
         5cg2SD0+cHh981qW8mrFhVR7k5UaBrxCVcE8Cb5e2S2GvFyWIdIw/IJeRMwmnVXPR33b
         QpWUZzRlDx5TflfFU9Kcu76HOUAfjiC7ImJvOQkQGomN99OxXG6inHQ8yn4w6uPaCNsU
         mGsA==
X-Gm-Message-State: APzg51CvMPYyFt6W663fspBr67jmtDQerUlQ/PFBh2TOArqPlz2rX7Fd
        6YcJ6eUZx9fEmTgNjWguGd+bsLOx1xA=
X-Google-Smtp-Source: ANB0VdZXF3iZZgnm4RvLuacDcP7ggLF89fqPfJ7WqRYhPJ3cDV0NxEJOJ30rnawAEpgaSgHfedA36Q==
X-Received: by 2002:a81:288d:: with SMTP id o135-v6mr22178024ywo.171.1536181832455;
        Wed, 05 Sep 2018 14:10:32 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id k186-v6sm991604ywd.106.2018.09.05.14.10.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 14:10:32 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id z143-v6so3230364ywa.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:10:32 -0700 (PDT)
X-Received: by 2002:a0d:db10:: with SMTP id d16-v6mr22890053ywe.124.1536181520543;
 Wed, 05 Sep 2018 14:05:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 14:05:19 -0700 (PDT)
In-Reply-To: <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Sep 2018 14:05:19 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
Message-ID: <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
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

On Wed, Sep 5, 2018 at 2:18 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 4 September 2018 at 20:16, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> caps the skcipher request size similar to other limits and adds a sanity
>> check at registration. Looking at instrumented tcrypt output, the largest
>> is for lrw:
>>
>>         crypt: testing lrw(aes)
>>         crypto_skcipher_set_reqsize: 8
>>         crypto_skcipher_set_reqsize: 88
>>         crypto_skcipher_set_reqsize: 472
>>
>
> Are you sure this is a representative sampling? I haven't double
> checked myself, but we have plenty of drivers for peripherals in
> drivers/crypto that implement block ciphers, and they would not turn
> up in tcrypt unless you are running on a platform that provides the
> hardware in question.

Hrm, excellent point. Looking at this again:

The core part of the VLA is using this in the ON_STACK macro:

static inline unsigned int crypto_skcipher_reqsize(struct crypto_skcipher *tfm)
{
        return tfm->reqsize;
}

I don't find any struct crypto_skcipher .reqsize static initializers,
and the initial reqsize is here:

static int crypto_init_skcipher_ops_ablkcipher(struct crypto_tfm *tfm)
{
...
        skcipher->reqsize = crypto_ablkcipher_reqsize(ablkcipher) +
                            sizeof(struct ablkcipher_request);

with updates via crypto_skcipher_set_reqsize().

So I have to examine ablkcipher reqsize too:

static inline unsigned int crypto_ablkcipher_reqsize(
        struct crypto_ablkcipher *tfm)
{
        return crypto_ablkcipher_crt(tfm)->reqsize;
}

And of the crt_ablkcipher.reqsize assignments/initializers, I found:

ablkcipher reqsize:
1       struct dcp_aes_req_ctx
8       struct atmel_tdes_reqctx
8       struct cryptd_blkcipher_request_ctx
8       struct mtk_aes_reqctx
8       struct omap_des_reqctx
8       struct s5p_aes_reqctx
8       struct sahara_aes_reqctx
8       struct stm32_cryp_reqctx
8       struct stm32_cryp_reqctx
16      struct ablk_ctx
24      struct atmel_aes_reqctx
48      struct omap_aes_reqctx
48      struct omap_aes_reqctx
48      struct qat_crypto_request
56      struct artpec6_crypto_request_context
64      struct chcr_blkcipher_req_ctx
80      struct spacc_req
80      struct virtio_crypto_sym_request
136     struct qce_cipher_reqctx
168     struct n2_request_context
328     struct ccp_des3_req_ctx
400     struct ccp_aes_req_ctx
536     struct hifn_request_context
992     struct cvm_req_ctx
2456    struct iproc_reqctx_s

The base ablkcipher wrapper is:
80      struct ablkcipher_request

And in my earlier skcipher wrapper analysis, lrw was the largest
skcipher wrapper:
384     struct rctx

iproc_reqctx_s is an extreme outlier, with cvm_req_ctx at a bit less than half.

Making this a 2920 byte fixed array doesn't seem sensible at all
(though that's what's already possible to use with existing
SKCIPHER_REQUEST_ON_STACK users).

What's the right path forward here?

-Kees

-- 
Kees Cook
Pixel Security
