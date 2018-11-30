Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40978C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0759220863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d65ntuwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0759220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeLAANa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:13:30 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52082 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLAANa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:13:30 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so9031053itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFVPVykKhhf/x8jT0ihL71hfqREGdZP+wppfzLDZltk=;
        b=d65ntuwNy0VyYxZbcWQyCo1fUH65lihcIeKG3KZ0bMrpgmxASd+GC7G3VMMFGl2YFV
         dX70Q1jfbiaY3aL3Hyyr59GL2tXKn1P+UA1Ojh8JllqyI5EI03/rPCgy3GKiK8UatJj5
         uerETN08Oz/ZtDWPXEIO+fpthA+3CpTsPgWHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFVPVykKhhf/x8jT0ihL71hfqREGdZP+wppfzLDZltk=;
        b=PT1UhxmbNuetSo5uvGGehX0d6XZsvuwqz8RCUpgSNZX8UzBQWeSiylFxAXswpjRD3j
         sKSW4CYJHQIHrxdfh0IaM19TAwndtuWa1c+MihXgub5QPvm50pcVrvLSoO1TCZfUZ1W4
         8LA3mheuka5BPvEFkX6z2ZE4NbuN7NU7wxY9d8XXWOmbMeHLVv92Aq9rFw7S3jlyQ47c
         1nwDW14MwaV55zc0XtntYwfxg7/MYuPC+GBV/m5uJXaLHVF+9jz6YjAEbM+hzdAb1z0A
         XG/iN0/wQKubK5Evmi6Iy0yFXOlNpPpzcatGjD+Wi2DeXuPfLjNB/R4G1ycUMo58k1un
         rY5A==
X-Gm-Message-State: AA+aEWYeHGnYIFV0bHd3KYIlI6L9NjvonJC9JBsPTSRmgiYMWNWSF+HW
        VXBx+rQiistGzguCOmAKop2dKJzO53pmbdqhcdhrPQ==
X-Google-Smtp-Source: AFSGD/XyzF5330+oMqKSAVRc0LfmX828V/W+hC6wWtMuIlydUC1FVX6rWZM4THuqW3K3uwbJjgQ5bk6RpkQgyrlLOgI=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr5043419jah.130.1543583054564;
 Fri, 30 Nov 2018 05:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20181129063422.24307-1-ebiggers@kernel.org> <20181129063422.24307-5-ebiggers@kernel.org>
In-Reply-To: <20181129063422.24307-5-ebiggers@kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 30 Nov 2018 14:04:03 +0100
Message-ID: <CAKv+Gu_Hu7+_0cec7CkPkONYXjmJ2az2XEpuzLv12FT7=0Tpaw@mail.gmail.com>
Subject: Re: [PATCH 4/4] crypto: arm64/chacha - add XChaCha12 support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 at 07:35, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Now that the ARM64 NEON implementation of ChaCha20 and XChaCha20 has
> been refactored to support varying the number of rounds, add support for
> XChaCha12.  This is identical to XChaCha20 except for the number of
> rounds, which is 12 instead of 20.  This can be used by Adiantum.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/crypto/Kconfig            |  2 +-
>  arch/arm64/crypto/chacha-neon-glue.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> index d54ddb8468ef5..d9a523ecdd836 100644
> --- a/arch/arm64/crypto/Kconfig
> +++ b/arch/arm64/crypto/Kconfig
> @@ -101,7 +101,7 @@ config CRYPTO_AES_ARM64_NEON_BLK
>         select CRYPTO_SIMD
>
>  config CRYPTO_CHACHA20_NEON
> -       tristate "ChaCha20 and XChaCha20 stream ciphers using NEON instructions"
> +       tristate "ChaCha20, XChaCha20, and XChaCha12 stream ciphers using NEON instructions"
>         depends on KERNEL_MODE_NEON
>         select CRYPTO_BLKCIPHER
>         select CRYPTO_CHACHA20
> diff --git a/arch/arm64/crypto/chacha-neon-glue.c b/arch/arm64/crypto/chacha-neon-glue.c
> index 4d992029b9121..346eb85498a1e 100644
> --- a/arch/arm64/crypto/chacha-neon-glue.c
> +++ b/arch/arm64/crypto/chacha-neon-glue.c
> @@ -161,6 +161,22 @@ static struct skcipher_alg algs[] = {
>                 .setkey                 = crypto_chacha20_setkey,
>                 .encrypt                = xchacha_neon,
>                 .decrypt                = xchacha_neon,
> +       }, {
> +               .base.cra_name          = "xchacha12",
> +               .base.cra_driver_name   = "xchacha12-neon",
> +               .base.cra_priority      = 300,
> +               .base.cra_blocksize     = 1,
> +               .base.cra_ctxsize       = sizeof(struct chacha_ctx),
> +               .base.cra_module        = THIS_MODULE,
> +
> +               .min_keysize            = CHACHA_KEY_SIZE,
> +               .max_keysize            = CHACHA_KEY_SIZE,
> +               .ivsize                 = XCHACHA_IV_SIZE,
> +               .chunksize              = CHACHA_BLOCK_SIZE,
> +               .walksize               = 4 * CHACHA_BLOCK_SIZE,
> +               .setkey                 = crypto_chacha12_setkey,
> +               .encrypt                = xchacha_neon,
> +               .decrypt                = xchacha_neon,
>         }
>  };
>
> @@ -187,3 +203,5 @@ MODULE_ALIAS_CRYPTO("chacha20");
>  MODULE_ALIAS_CRYPTO("chacha20-neon");
>  MODULE_ALIAS_CRYPTO("xchacha20");
>  MODULE_ALIAS_CRYPTO("xchacha20-neon");
> +MODULE_ALIAS_CRYPTO("xchacha12");
> +MODULE_ALIAS_CRYPTO("xchacha12-neon");
> --
> 2.19.2
>
