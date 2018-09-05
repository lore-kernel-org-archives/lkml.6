Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A1CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E182083D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuXNFTC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E182083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIFDWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 23:22:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55885 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeIFDWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 23:22:14 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so12208879itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yTUYLANhHS81D/QZOSbvea1+6MJREE+kMmCWZ+wQ/Jo=;
        b=GuXNFTC19u/9r3sp5udx33J1cBCikU4op6tuVVp5rqUwlUTsnI8QyBSX/rm3IDAnC7
         iaknhIA0JqJja3A339LnQ88JBQEM6PyrrZpN1zRomBQK0jBK3nSHm38i5/Bkm3xOYPY/
         dY8XTit1xIBuxRAJQTJuteu5VCgboe+f9oqMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yTUYLANhHS81D/QZOSbvea1+6MJREE+kMmCWZ+wQ/Jo=;
        b=C809CxyBGtZC1GWBD0ydKxhplos5RBUnp63KPgnBOvBDWlvMx0VhXFjGBYJT2iejFv
         vzErXSREXWxR8M7CwooUGACLXkm2gt7XdVF8qA5U5RxiHkz0X0LfZ/1lADaqBqB8LTb0
         1SZYID1mwKirmPjcZ3z9wrIfWsRz/7Ge7E7LTH9S/9a+gsTfLOFEdOZCQzGd68JayxM7
         wA0cP/pe7GUJ1zVDzQzyS6/Nljvgi46n6HcAIsfUejVvVTbJXf6C6LnyDcFzWDnxrLUe
         DDGc7l/+mugESpUytLDD6J7hgXoSg5VDYgR22tC3U1Y2KZQFNDdly7nbOzo5vz/6rDGT
         VaBA==
X-Gm-Message-State: APzg51B/9Dj5V08Oj2cfFPO8LDLT2d0x5dIyQd7KHGUZpbCZtQTVZssD
        nKBEFshMt7aCKmTO+EnWNX3OUuEqtN/P+NrsONUTQw==
X-Google-Smtp-Source: ANB0Vdb2SYkGvgfXOfRWaoKdSKAAufynI5wga7W/sp+zwECdKfj9MBe35sYvcvmPNNVTkXOpn9GioMImvALIorCJ6cM=
X-Received: by 2002:a02:59cc:: with SMTP id v73-v6mr28894402jad.5.1536187792877;
 Wed, 05 Sep 2018 15:49:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 15:49:52 -0700 (PDT)
In-Reply-To: <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com> <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Sep 2018 00:49:52 +0200
Message-ID: <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
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

On 5 September 2018 at 23:05, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Sep 5, 2018 at 2:18 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 4 September 2018 at 20:16, Kees Cook <keescook@chromium.org> wrote:
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> caps the skcipher request size similar to other limits and adds a sanity
>>> check at registration. Looking at instrumented tcrypt output, the largest
>>> is for lrw:
>>>
>>>         crypt: testing lrw(aes)
>>>         crypto_skcipher_set_reqsize: 8
>>>         crypto_skcipher_set_reqsize: 88
>>>         crypto_skcipher_set_reqsize: 472
>>>
>>
>> Are you sure this is a representative sampling? I haven't double
>> checked myself, but we have plenty of drivers for peripherals in
>> drivers/crypto that implement block ciphers, and they would not turn
>> up in tcrypt unless you are running on a platform that provides the
>> hardware in question.
>
> Hrm, excellent point. Looking at this again:
>
> The core part of the VLA is using this in the ON_STACK macro:
>
> static inline unsigned int crypto_skcipher_reqsize(struct crypto_skcipher *tfm)
> {
>         return tfm->reqsize;
> }
>
> I don't find any struct crypto_skcipher .reqsize static initializers,
> and the initial reqsize is here:
>
> static int crypto_init_skcipher_ops_ablkcipher(struct crypto_tfm *tfm)
> {
> ...
>         skcipher->reqsize = crypto_ablkcipher_reqsize(ablkcipher) +
>                             sizeof(struct ablkcipher_request);
>
> with updates via crypto_skcipher_set_reqsize().
>
> So I have to examine ablkcipher reqsize too:
>
> static inline unsigned int crypto_ablkcipher_reqsize(
>         struct crypto_ablkcipher *tfm)
> {
>         return crypto_ablkcipher_crt(tfm)->reqsize;
> }
>
> And of the crt_ablkcipher.reqsize assignments/initializers, I found:
>
> ablkcipher reqsize:
> 1       struct dcp_aes_req_ctx
> 8       struct atmel_tdes_reqctx
> 8       struct cryptd_blkcipher_request_ctx
> 8       struct mtk_aes_reqctx
> 8       struct omap_des_reqctx
> 8       struct s5p_aes_reqctx
> 8       struct sahara_aes_reqctx
> 8       struct stm32_cryp_reqctx
> 8       struct stm32_cryp_reqctx
> 16      struct ablk_ctx
> 24      struct atmel_aes_reqctx
> 48      struct omap_aes_reqctx
> 48      struct omap_aes_reqctx
> 48      struct qat_crypto_request
> 56      struct artpec6_crypto_request_context
> 64      struct chcr_blkcipher_req_ctx
> 80      struct spacc_req
> 80      struct virtio_crypto_sym_request
> 136     struct qce_cipher_reqctx
> 168     struct n2_request_context
> 328     struct ccp_des3_req_ctx
> 400     struct ccp_aes_req_ctx
> 536     struct hifn_request_context
> 992     struct cvm_req_ctx
> 2456    struct iproc_reqctx_s
>
> The base ablkcipher wrapper is:
> 80      struct ablkcipher_request
>
> And in my earlier skcipher wrapper analysis, lrw was the largest
> skcipher wrapper:
> 384     struct rctx
>
> iproc_reqctx_s is an extreme outlier, with cvm_req_ctx at a bit less than half.
>
> Making this a 2920 byte fixed array doesn't seem sensible at all
> (though that's what's already possible to use with existing
> SKCIPHER_REQUEST_ON_STACK users).
>
> What's the right path forward here?
>

The skcipher implementations based on crypto IP blocks are typically
asynchronous, and I wouldn't be surprised if a fair number of
SKCIPHER_REQUEST_ON_STACK() users are limited to synchronous
skciphers.

So we could formalize this and limit SKCIPHER_REQUEST_ON_STACK() to
synchronous skciphers, which implies that the reqsize limit only has
to apply synchronous skciphers as well. But before we can do this, we
have to identify the remaining occurrences that allow asynchronous
skciphers to be used, and replace them with heap allocations.
