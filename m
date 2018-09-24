Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D712EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89448214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SmbZnz/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89448214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeIXRyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:54:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33558 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeIXRyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:54:44 -0400
Received: by mail-it1-f195.google.com with SMTP id j198-v6so4546279ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oxp16H4knVPTwz5O5a7i2IP4cHNgixzcMCWoMpsCtsM=;
        b=SmbZnz/lgdU6Cyu1689xC2QixSVS4/bYEC66NzVDgM35IM5M0g7+65/1XaYC59o0j+
         /c16iNpZnY7VZNWpEW4Ko+ogJ3IZOdxinylaGPUQotfcUdiEm6FsQYxuk9rp5cbhv3BN
         VdkbNU4Wb1zPHWM8RGkjeyhJvWemEcbJagfoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oxp16H4knVPTwz5O5a7i2IP4cHNgixzcMCWoMpsCtsM=;
        b=Qg/qIzJUXoOM9cKKbwIsM9z5ZnANxxcsMsDc7WZdMWcu/S4t9Jr706J4WuUsLipBZO
         KeNr+0XgbWELXda3Gjyb3z/Dj/yuGDYC7QfPh+BRb/Os6+Zx3bUq0sUzkeqFRAhKY2f7
         Xfc5IteMD1iSGqopFKyFqB6Jt/loB0QVYWP/YFNzPYTefUJdq4UsN02FCxS7jC6Dv9/n
         M+ma71t2SUZ/4knhGK88RvYBSGCqILmxj580OvPZM/tHwNXX8GEVnnXg7cfMe3diCNq8
         XAYeclecG6vMHSCNlP/zjQpDc0X3FdctIYMJxX/sa+1BNAfSl8F+7PU8ewSJ83iXEhJ7
         2Ong==
X-Gm-Message-State: APzg51AXs1o1hRWOpczHGdwfaYcIdO4WJ6IfbYO7FTiXf2QkzJTLSwC2
        Pts8jys6Db5NoRGOhkomVC4hT791EIECOxjuqTcuY4Fr
X-Google-Smtp-Source: ANB0VdYgFDd/MrgTjFgbIlyUtZ4v7CCZLe/jl5bRqkMnsMHdrUMAdevNzmomp9RmYgmx/cRotaH8WPmLeUQJipKLgwI=
X-Received: by 2002:a02:59cc:: with SMTP id v73-v6mr9089743jad.5.1537789979963;
 Mon, 24 Sep 2018 04:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180919021100.3380-1-keescook@chromium.org> <20180919021100.3380-8-keescook@chromium.org>
In-Reply-To: <20180919021100.3380-8-keescook@chromium.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 24 Sep 2018 13:52:47 +0200
Message-ID: <CAKv+Gu8ynaVi1KCMNsjCU0ucAjFFku=ourh9Yc9Rizoc4ztvOQ@mail.gmail.com>
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

On Wed, 19 Sep 2018 at 04:11, Kees Cook <keescook@chromium.org> wrote:
>
> In the quest to remove all stack VLA usage from the kernel[1], this
> replaces struct crypto_skcipher and SKCIPHER_REQUEST_ON_STACK() usage
> with struct crypto_sync_skcipher and SYNC_SKCIPHER_REQUEST_ON_STACK(),
> which uses a fixed stack size.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/block/cryptoloop.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
> index 7033a4beda66..254ee7d54e91 100644
> --- a/drivers/block/cryptoloop.c
> +++ b/drivers/block/cryptoloop.c
> @@ -45,7 +45,7 @@ cryptoloop_init(struct loop_device *lo, const struct loop_info64 *info)
>         char cms[LO_NAME_SIZE];                 /* cipher-mode string */
>         char *mode;
>         char *cmsp = cms;                       /* c-m string pointer */
> -       struct crypto_skcipher *tfm;
> +       struct crypto_sync_skcipher *tfm;
>
>         /* encryption breaks for non sector aligned offsets */
>
> @@ -80,13 +80,13 @@ cryptoloop_init(struct loop_device *lo, const struct loop_info64 *info)
>         *cmsp++ = ')';
>         *cmsp = 0;
>
> -       tfm = crypto_alloc_skcipher(cms, 0, CRYPTO_ALG_ASYNC);
> +       tfm = crypto_alloc_sync_skcipher(cms, 0, 0);
>         if (IS_ERR(tfm))
>                 return PTR_ERR(tfm);
>
> -       err = crypto_skcipher_setkey(tfm, info->lo_encrypt_key,
> -                                    info->lo_encrypt_key_size);
> -
> +       err = crypto_sync_skcipher_setkey(tfm, info->lo_encrypt_key,
> +                                         info->lo_encrypt_key_size);
> +
>         if (err != 0)
>                 goto out_free_tfm;
>
> @@ -94,7 +94,7 @@ cryptoloop_init(struct loop_device *lo, const struct loop_info64 *info)
>         return 0;
>
>   out_free_tfm:
> -       crypto_free_skcipher(tfm);
> +       crypto_free_sync_skcipher(tfm);
>
>   out:
>         return err;
> @@ -109,8 +109,8 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
>                     struct page *loop_page, unsigned loop_off,
>                     int size, sector_t IV)
>  {
> -       struct crypto_skcipher *tfm = lo->key_data;
> -       SKCIPHER_REQUEST_ON_STACK(req, tfm);
> +       struct crypto_sync_skcipher *tfm = lo->key_data;
> +       SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
>         struct scatterlist sg_out;
>         struct scatterlist sg_in;
>
> @@ -119,7 +119,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
>         unsigned in_offs, out_offs;
>         int err;
>
> -       skcipher_request_set_tfm(req, tfm);
> +       skcipher_request_set_sync_tfm(req, tfm);
>         skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
>                                       NULL, NULL);
>

Does this work?

> @@ -175,9 +175,9 @@ cryptoloop_ioctl(struct loop_device *lo, int cmd, unsigned long arg)
>  static int
>  cryptoloop_release(struct loop_device *lo)
>  {
> -       struct crypto_skcipher *tfm = lo->key_data;
> +       struct crypto_sync_skcipher *tfm = lo->key_data;
>         if (tfm != NULL) {
> -               crypto_free_skcipher(tfm);
> +               crypto_free_sync_skcipher(tfm);
>                 lo->key_data = NULL;
>                 return 0;
>         }
> --
> 2.17.1
>
