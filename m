Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3857EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088D92175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfBEJbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:31:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44640 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfBEJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:31:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id g16so4532210otg.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtmGn+xXsDk5C/YUn8SkWO501C3T7/VLddv7mal6Tyc=;
        b=YMqaoNgY1y0M8852biBvLKth2rU+TF4vm9IqzwUlD7gQz7JlhZuPff77p+mHM0oisM
         FyCYnAI/WF93M3B8DiI5vxAoKNN8CCu4u7wrwzV4Jb9RqNhhSIvWy9cmmv2usz/kIE8c
         aTdrFK7kGRyTMiD14dC1DplIc7fcmLsKxAEntGBWfQSrwjgbS6aOexHyQ+BRKuLeAvgh
         v7YoHxgmRI2YcEA9M56qF1nXPvwzgb8mGDOUy8do1Ma5TePKdhINy4TMjqcMJQ5q85KX
         0WMUoyax2C4jpduV31Lb5p+hUDGqMbGI91Kc0bcAW9Z34zwSSNeu36OSeVG7DtPX8cUy
         OD4Q==
X-Gm-Message-State: AHQUAuY+93poEqnPGRFMarzXO2otRQhUibEAAGtp51tWeTaGj22bHG+h
        ycqkw5VPBvFIK+Dqc4PdhvFe5c4UVF9SaXomNLT/SQ==
X-Google-Smtp-Source: AHgI3IZeaHVB2+0X5o/rGob63wmfRSc7/uZpsVMynWAF02NquH9eqCYRpzvPEOXXfDC0jOHpmQdM5kvwzF7nG+d+eFU=
X-Received: by 2002:aca:2403:: with SMTP id n3mr2048061oic.328.1549359068575;
 Tue, 05 Feb 2019 01:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20190201075150.18644-1-ebiggers@kernel.org> <20190201075150.18644-3-ebiggers@kernel.org>
In-Reply-To: <20190201075150.18644-3-ebiggers@kernel.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 5 Feb 2019 10:30:57 +0100
Message-ID: <CAFqZXNtqwiEZCd1Ua2NMHX8Lr20ptbM7yQL5m-bwXUztXGAWdA@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] crypto: morus - fix handling chunked inputs
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 8:52 AM Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> The generic MORUS implementations all fail the improved AEAD tests
> because they produce the wrong result with some data layouts.  The issue
> is that they assume that if the skcipher_walk API gives 'nbytes' not
> aligned to the walksize (a.k.a. walk.stride), then it is the end of the
> data.  In fact, this can happen before the end.  Fix them.
>
> Fixes: 396be41f16fd ("crypto: morus - Add generic MORUS AEAD implementations")
> Cc: <stable@vger.kernel.org> # v4.18+
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>


> ---
>  crypto/morus1280.c | 13 +++++++------
>  crypto/morus640.c  | 13 +++++++------
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/crypto/morus1280.c b/crypto/morus1280.c
> index 78ba09db7328c..0747732d5b78a 100644
> --- a/crypto/morus1280.c
> +++ b/crypto/morus1280.c
> @@ -362,18 +362,19 @@ static void crypto_morus1280_process_crypt(struct morus1280_state *state,
>                                            const struct morus1280_ops *ops)
>  {
>         struct skcipher_walk walk;
> -       u8 *dst;
> -       const u8 *src;
>
>         ops->skcipher_walk_init(&walk, req, false);
>
>         while (walk.nbytes) {
> -               src = walk.src.virt.addr;
> -               dst = walk.dst.virt.addr;
> +               unsigned int nbytes = walk.nbytes;
>
> -               ops->crypt_chunk(state, dst, src, walk.nbytes);
> +               if (nbytes < walk.total)
> +                       nbytes = round_down(nbytes, walk.stride);
>
> -               skcipher_walk_done(&walk, 0);
> +               ops->crypt_chunk(state, walk.dst.virt.addr, walk.src.virt.addr,
> +                                nbytes);
> +
> +               skcipher_walk_done(&walk, walk.nbytes - nbytes);
>         }
>  }
>
> diff --git a/crypto/morus640.c b/crypto/morus640.c
> index 5cf530139b271..1617a1eb8be13 100644
> --- a/crypto/morus640.c
> +++ b/crypto/morus640.c
> @@ -361,18 +361,19 @@ static void crypto_morus640_process_crypt(struct morus640_state *state,
>                                           const struct morus640_ops *ops)
>  {
>         struct skcipher_walk walk;
> -       u8 *dst;
> -       const u8 *src;
>
>         ops->skcipher_walk_init(&walk, req, false);
>
>         while (walk.nbytes) {
> -               src = walk.src.virt.addr;
> -               dst = walk.dst.virt.addr;
> +               unsigned int nbytes = walk.nbytes;
>
> -               ops->crypt_chunk(state, dst, src, walk.nbytes);
> +               if (nbytes < walk.total)
> +                       nbytes = round_down(nbytes, walk.stride);
>
> -               skcipher_walk_done(&walk, 0);
> +               ops->crypt_chunk(state, walk.dst.virt.addr, walk.src.virt.addr,
> +                                nbytes);
> +
> +               skcipher_walk_done(&walk, walk.nbytes - nbytes);
>         }
>  }
>
> --
> 2.20.1
>


--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
