Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F6AC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A8620866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QWG8BYuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A8620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeIMWuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:50:51 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37665 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIMWuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:50:51 -0400
Received: by mail-yb1-f193.google.com with SMTP id g79-v6so990682ybf.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XfQ9mMphLBm+NgVyGzZ7LpR7O+UfAkqjABPxoAdBK7Y=;
        b=QWG8BYuRbhUjB3PrR4PSU/TVTDnuuJWeabU7XWH+SjW96znT9ItHuDIqcbkVqJabW/
         /bmAEbCo8o7w7kZH5AE6XNJyGcJIVqe7HsR9bHbw/kH5nv8FvhH9s0htWu/PlYugT++M
         A0GA9RDPEvlXMNoUh5yL4x6JwPWhnOmj9r13A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XfQ9mMphLBm+NgVyGzZ7LpR7O+UfAkqjABPxoAdBK7Y=;
        b=K8KXiJ4u4mnxITiK+s2Zgy6/wocsCVyvRmCn44mFjxU0DvTM840BW+thvg6VW4vj87
         AXyg1ohJx0nOykIwFIO+jreBXMEF9T6GpuVBIBHEXkp8b47ZMQvsGmTYV3q/30HM/lMk
         8epdL9NjgSmLbqb0lr1HYgUzyCGRIXEP/ZsO+q+We9BAyLpRNpjZM0SmvFbWR/gvweXS
         FWKx3qtWjvFwnxsPdumgKJdyuExLRB8eG5OORFmwChiHPGUbWczNV7+XQ35GV3SASUei
         mf3XrAK2yiwwK/tm6TZQWi4iaYhImY6zsbLToNSXFaqOJ5Cfx+tnXErsz/IwkQeMecOE
         kYwA==
X-Gm-Message-State: APzg51BtFr6Q67Yu+EdxDm6BSGvArvefgZn/CJNMFwMIGCWG9YgtHeAb
        AJrvVmx11iHBfbQZ+7Wvr/+j8GJwDiw=
X-Google-Smtp-Source: ANB0VdbhbeZiK3h1ULah7svCUegnZIeh2lLTP12RU5LFC1+hqDoFSg3J3hSHg/ZtdwYLRptItSK6xw==
X-Received: by 2002:a25:8190:: with SMTP id p16-v6mr3969938ybk.303.1536860420078;
        Thu, 13 Sep 2018 10:40:20 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id b2-v6sm1532419ywd.48.2018.09.13.10.40.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 10:40:18 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id m62-v6so1508092ywd.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 10:40:17 -0700 (PDT)
X-Received: by 2002:a81:4e01:: with SMTP id c1-v6mr4162996ywb.237.1536860417593;
 Thu, 13 Sep 2018 10:40:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 10:40:16
 -0700 (PDT)
In-Reply-To: <CAGXu5j+ti_nzxeu64e-X+igNEsnXiW1rjkn7R63DMBCxBOeTNg@mail.gmail.com>
References: <20180906225854.40989-1-keescook@chromium.org> <20180906225854.40989-3-keescook@chromium.org>
 <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au> <CAKv+Gu9kHpBTKjQKA3W4Q424FeY+Zq4srq2-r0MxjfCNKHT_5A@mail.gmail.com>
 <20180911055230.iiiq2uu5gczlwjon@gondor.apana.org.au> <CAGXu5j+ti_nzxeu64e-X+igNEsnXiW1rjkn7R63DMBCxBOeTNg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 10:40:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+bpLK=EQ9LHkO8V=sdaQwt==6fbGhgn2Vi1E9_WxSGRQ@mail.gmail.com>
Message-ID: <CAGXu5j+bpLK=EQ9LHkO8V=sdaQwt==6fbGhgn2Vi1E9_WxSGRQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack requests
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
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
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 9:46 AM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Sep 10, 2018 at 10:52 PM, Herbert Xu
> <herbert@gondor.apana.org.au> wrote:
>> On Fri, Sep 07, 2018 at 08:56:23AM +0200, Ard Biesheuvel wrote:
>>>
>>> OK, so given that all SKCIPHER_REQUEST_ON_STACK occurrences are
>>> updated in this series anyway, perhaps we should add
>>> skcipher_[en|de]crypt_onstack() flavors that encapsulate the
>>> additional check? Only question is how to enforce at compile time that
>>> those are used instead of the ordinary ones when using a stack
>>> allocated request. Would you mind using some macro foo here involving
>>> __builtin_types_compatible_p() ?
>>
>> Something like a completely new type which in reality is just a
>> wrapper around skcipher:
>>
>>         struct crypto_sync_skcipher {
>>                 struct crypto_skcipher base;
>>         } tfm;
>>
>>         tfm = crypto_alloc_sync_skcipher(...);
>>
>>         crypto_sync_skcipher_encrypt(...)
>>         crypto_sync_skcipher_decrypt(...)
>>
>> These functions would just be trivial inline functions around their
>> crypto_skcipher counterparts.
>
> This means new wrappers for the other helpers too, yes? For example:
>
>         SKCIPHER_REQUEST_ON_STACK(nreq, ctx->null);
>
>         skcipher_request_set_tfm(nreq, ctx->null);
>         skcipher_request_set_callback(nreq, req->base.flags, NULL, NULL);
>         skcipher_request_set_crypt(nreq, req->src, req->dst, nbytes, NULL);
>
>         return crypto_skcipher_encrypt(nreq);
>
> For the above, we'd also need:
>
> sync_skcipher_request_set_tfm()
> sync_skcipher_request_set_callback()
> sync_skcipher_request_set_crypt()

Wait, I think I misunderstood you. Did you mean a new top-level thing
(tfm?) not a new request type?

That would mean at least replacing skcipher_request_set_tfm() with a
wrapper (since the tfm argument is different), but _not_
encrypt/decrypt like you mention. I could perform a type test in
SKCIPHER_REQUEST_ON_STACK().

Globally:
- add struct crypto_sync_skcipher wrapper
- add crypto_alloc_sync_skcipher() to check non-ASYNC and request size
of actual tfm
- add skcipher_request_set_sync_tfm() to attach the wrapped tfm to the request
- SKCIPHER_REQUEST_ON_STACK() would verify the tfm was a struct
crypto_sync_skcipher.

Two changes per user:
- change allocation to use new crypto_alloc_sync_skcipher() which does
the runtime checking
- change skcipher_request_set_tfm() to skcipher_request_set_sync_tfm()

This means struct skcipher_request is unchanged, along with
_set_callback, _set_crypt, _zero, and en/decrypt.

API misuse would be caught at build-time (via
SKCIPHER_REQUEST_ON_STACK type checking) and any request size problems
would be caught at allocation time.

Does this sound like what you had in mind?

-Kees

-- 
Kees Cook
Pixel Security
