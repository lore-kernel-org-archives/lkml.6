Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeC1Gi1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:38:27 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54187 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeC1GiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:38:25 -0400
X-Google-Smtp-Source: AIpwx49WwVbfjZysVD0KoqMNa2BKRWS63X5aeEcDSUEcgrNac7lgU+kTfH8CYba5EO49+gWvI+xGTsVF8jnaDZCSTWw=
MIME-Version: 1.0
In-Reply-To: <20180324110242.9474-1-stefan@agner.ch>
References: <20180324110242.9474-1-stefan@agner.ch>
From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Date: Wed, 28 Mar 2018 12:08:24 +0530
Message-ID: <CAAFb_vrFF6D8DEvnZMDda-qd-jTh3mKt0BgGBJ5eWxydY1LEXA@mail.gmail.com>
Subject: Re: [RFC PATCH] crypto: brcm - explicitly cast cipher to hash type
To: Stefan Agner <stefan@agner.ch>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, clabbe.montjoie@gmail.com,
        Scott Branden <scott.branden@broadcom.com>,
        Steven Lin <steven.lin1@broadcom.com>, garsilva@embeddedor.com,
        pravin.shedge4linux@gmail.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

The change looks to be fine.  From the IP point of view its using the
same values in case of AES cipher and hash types so explicit casting
should be ok.

-Raveendra

On Sat, Mar 24, 2018 at 4:32 PM, Stefan Agner <stefan@agner.ch> wrote:
> In the AES cases enum spu_cipher_type and enum hash_type have
> the same values, so the assignment is fine. Explicitly cast
> the enum type conversion.
>
> This fixes two warnings when building with clang:
>   drivers/crypto/bcm/cipher.c:821:34: warning: implicit conversion from
>       enumeration type 'enum spu_cipher_type' to different enumeration
>       type 'enum hash_type' [-Wenum-conversion]
>                 hash_parms.type = cipher_parms.type;
>                                 ~ ~~~~~~~~~~~~~^~~~
>   drivers/crypto/bcm/cipher.c:1412:26: warning: implicit conversion from
>       enumeration type 'enum spu_cipher_type' to different enumeration
>       type 'enum hash_type' [-Wenum-conversion]
>                 hash_parms.type = ctx->cipher_type;
>                                 ~ ~~~~~^~~~~~~~~~~
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> I am not familar with the IP... I would be glad if somebody with
> better insight could have a look whether that patch makes sense.
>
>  drivers/crypto/bcm/cipher.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
> index 2b75f95bbe1b..309c67c7012f 100644
> --- a/drivers/crypto/bcm/cipher.c
> +++ b/drivers/crypto/bcm/cipher.c
> @@ -818,7 +818,7 @@ static int handle_ahash_req(struct iproc_reqctx_s *rctx)
>
>         /* AES hashing keeps key size in type field, so need to copy it here */
>         if (hash_parms.alg == HASH_ALG_AES)
> -               hash_parms.type = cipher_parms.type;
> +               hash_parms.type = (enum hash_type)cipher_parms.type;
>         else
>                 hash_parms.type = spu->spu_hash_type(rctx->total_sent);
>
> @@ -1409,7 +1409,7 @@ static int handle_aead_req(struct iproc_reqctx_s *rctx)
>                                                 rctx->iv_ctr_len);
>
>         if (ctx->auth.alg == HASH_ALG_AES)
> -               hash_parms.type = ctx->cipher_type;
> +               hash_parms.type = (enum hash_type)ctx->cipher_type;
>
>         /* General case AAD padding (CCM and RFC4543 special cases below) */
>         aead_parms.aad_pad_len = spu->spu_gcm_ccm_pad_len(ctx->cipher.mode,
> --
> 2.16.2
>
