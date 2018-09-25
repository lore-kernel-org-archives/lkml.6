Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05CFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FE220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfdtVP5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FE220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeIYPct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:32:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50777 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeIYPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:32:49 -0400
Received: by mail-it1-f194.google.com with SMTP id j81-v6so14502832ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wVPTjtwlGpCbqzX7BIYG1ExhfQSIL3qQVfogfwv3fw=;
        b=jfdtVP5PGXpaHGiYO7+JGEKRysIeMFYGIDEw1Qvtj7aKXQh9NCPcwxxn/76H8t4HeY
         XBIAcxlAvC0EWX/Nxshdi9almYlYQWPWp8CNJqucCioSYt9sRfJAg8TQ3pdzrGAdAde/
         214fswon2fI1tNJeLCwa+xh+s2abBiiHrA8YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wVPTjtwlGpCbqzX7BIYG1ExhfQSIL3qQVfogfwv3fw=;
        b=PoL/oqcnwamopMVLPxaJoIE+yFVxSDqnkR7ruDtUmH/ZUP8wdbFUL1ip7CkhlMRpvO
         iX66ZQ9TG0bWKFIKdfH09XZuXBL6aAV/wKEw47VLNRqnDOjAiRrZBX7z96p/GjFHUO+G
         4W5+97pAKgL4+UTijl7Ana5yYhAI2n0o05SPB0w9MFCuqkmiv0Hcb4gUQVxeq4amm6kp
         B8HUoeAgmLkOuz7daHqXRAQcOLdfbDBiFR1iJxg7TIkdr6APi4MvIDhdXccVICToKg1A
         uVx76re2OO/KvMOQr4JO3ZQOR/nnn/4glnDEiT8/x2WOitm1sIoOwF7oTvop1119vK4A
         iVcQ==
X-Gm-Message-State: ABuFfoivB+jkGToYGYqkmsT2XW5+0HzbZ7D7/3EE0t0lb24SICskYG4L
        vB2lwxs4vM9PmgAkNL24N20s18ZsdGN6G3JVl0ZDoQ==
X-Google-Smtp-Source: ACcGV63GnW+X5t5UwDEs1gADge5k/F7qK+N5sBGPskQcZP/aHG5zisAXyrXDpSk2tEuFATOcWkTrglEi8/5J3kKA1ZM=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr48106ite.123.1537867570466;
 Tue, 25 Sep 2018 02:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180919021100.3380-1-keescook@chromium.org> <20180919021100.3380-8-keescook@chromium.org>
 <CAKv+Gu8ynaVi1KCMNsjCU0ucAjFFku=ourh9Yc9Rizoc4ztvOQ@mail.gmail.com> <CAGXu5jLw3+nvb9opPeoCyH0MhyVK5UY7H5qeQ2b8GFTUGDGrUQ@mail.gmail.com>
In-Reply-To: <CAGXu5jLw3+nvb9opPeoCyH0MhyVK5UY7H5qeQ2b8GFTUGDGrUQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 25 Sep 2018 11:25:57 +0200
Message-ID: <CAKv+Gu-xKWsiegZXnsMvmMVgKTo7S2cm4wEqdaL7w9z64X7SAA@mail.gmail.com>
Subject: Re: [PATCH crypto-next 07/23] block: cryptoloop: Remove VLA usage of skcipher
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 at 19:53, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Sep 24, 2018 at 4:52 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > On Wed, 19 Sep 2018 at 04:11, Kees Cook <keescook@chromium.org> wrote:
> >> @@ -119,7 +119,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
> >>         unsigned in_offs, out_offs;
> >>         int err;
> >>
> >> -       skcipher_request_set_tfm(req, tfm);
> >> +       skcipher_request_set_sync_tfm(req, tfm);
> >>         skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
> >>                                       NULL, NULL);
> >>
> >
> > Does this work?
>
> Everything is a direct wrapper for existing types and functions, so I
> wouldn't expect any functional change. I haven't been able to test
> this particular interface, though. cryptoloop is very deprecated,
> isn't it?
>

Ah yes, I managed to confuse myself there. This looks all fine to me.

In any case, this is another example where we may decide to fix the
code rather than retain the request allocation on the stack (but that
is Jens's call ultimately, I suppose)

diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
index 7033a4beda66..5ed2167219ba 100644
--- a/drivers/block/cryptoloop.c
+++ b/drivers/block/cryptoloop.c
@@ -110,7 +110,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
                    int size, sector_t IV)
 {
        struct crypto_skcipher *tfm = lo->key_data;
-       SKCIPHER_REQUEST_ON_STACK(req, tfm);
+       struct skcipher_request *req;
        struct scatterlist sg_out;
        struct scatterlist sg_in;

@@ -119,7 +119,10 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
        unsigned in_offs, out_offs;
        int err;

-       skcipher_request_set_tfm(req, tfm);
+       req = skcipher_request_alloc(tfm, GFP_NOIO);
+       if (!req)
+               return -ENOMEM;
+
        skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
                                      NULL, NULL);


or if we stick with the current change to sync:

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
