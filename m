Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C12FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4922083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q1McUyFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4922083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeIGUo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:44:29 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45105 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeIGUo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:44:29 -0400
Received: by mail-yb1-f193.google.com with SMTP id h22-v6so5616008ybg.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GclgBvFrVu0raBIwVIf48JNcf1SgxjZVhfDXfihyusc=;
        b=Q1McUyFWOr7DEgKJec3j+BZfo4pZe5Znw801IzuFJxVKToicpFFkcl4BYrrtZoFaxl
         UGSyxT+TDG/PdpCp9LYGXd1r+8A7sbzK7qkQACpr8svYg0RVl1z4qEQ6S9q/KmBala4N
         klS6scCnYKpIkcOcQzPGlPU3e1741e7OVGOY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GclgBvFrVu0raBIwVIf48JNcf1SgxjZVhfDXfihyusc=;
        b=lj9Wakl2s5WOX5XzEvfCIWPQnGgOXTVqZq+UUAjsIrbMkW0W02wU2/MQXh45g5Zqe2
         6cFjhSsYF0vOWQG4Jg1Lx0BKoF+jRSVv968Qdj0ZoSn594lBkCjwLQaxiacLwvmfVmfH
         SPdD/xLLouWvRNoBKFxL5yZWT23a9aBBngnJB1oqUHekAyG//5Isa9cBe9jCPOlIsjzJ
         lUASn/3UrTgTr8JLdekF//BEwVkng6wX6tcGfGiUKDe4M2FhHWa6f04pIZTchmavrOEj
         sXTagYNQ8GLTJvLLcaUiSlrv0MYVY3yw/4AoLB3Gr8kmG8PO/nwXp+MNeQ3sMIfLHUxW
         76qg==
X-Gm-Message-State: APzg51BFSYwjyjBptNzo8/1uz9Z+DydpnWb4sICPPk8crKuobb74UhGY
        +GCzncHWRdE2cuugxqMfeGwOSuQ/gPo=
X-Google-Smtp-Source: ANB0VdanAKAnGZmieQqomRaBHBg9TpLtn2L1jYfgM8XKeSHfeFMrxYD2GcoA5WqP/3JXl0smosFkOQ==
X-Received: by 2002:a25:c89:: with SMTP id 131-v6mr4386840ybm.35.1536336173496;
        Fri, 07 Sep 2018 09:02:53 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id p126-v6sm2998644ywf.22.2018.09.07.09.02.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:02:53 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id c4-v6so5631367ybl.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:02:52 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr4331177ybh.209.1536336166057;
 Fri, 07 Sep 2018 09:02:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 09:02:45 -0700 (PDT)
In-Reply-To: <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
References: <20180906225854.40989-1-keescook@chromium.org> <20180906225854.40989-3-keescook@chromium.org>
 <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 7 Sep 2018 09:02:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLx8bdr+Ld7QE1LxttPB-LOs-H96kyx0O0MXq9MzX2vNw@mail.gmail.com>
Message-ID: <CAGXu5jLx8bdr+Ld7QE1LxttPB-LOs-H96kyx0O0MXq9MzX2vNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack requests
To:     Herbert Xu <herbert@gondor.apana.org.au>
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
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 8:42 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Sep 06, 2018 at 03:58:52PM -0700, Kees Cook wrote:
>>
>> @@ -437,6 +442,12 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm_check(
>>  {
>>       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
>>
>> +     if (req->__onstack) {
>> +             if (WARN_ON(crypto_skcipher_alg(tfm)->base.cra_flags &
>> +                             CRYPTO_ALG_ASYNC))
>> +                     return ERR_PTR(-EINVAL);
>> +     }
>
> Sorry but I don't like imposing a run-time check on everybody when
> stack-based requests are the odd ones out.  If we're going to make
> this a run-time check (I'd much prefer a compile-time check, but I
> understand that this may involve too much churn), then please do it
> for stack-based request users only.

I'll continue to investigate alternatives, but I wanted to point out
that the struct change actually fills an existing padding byte (so no
change in memory usage) and marking this as an unlikely() test means
it wouldn't even be measurable due to the branch predictor (so no
change in speed). encrypt/decrypt entry is a tiny tiny fraction of the
actual work done during encryption/decryption, etc.

-Kees

-- 
Kees Cook
Pixel Security
