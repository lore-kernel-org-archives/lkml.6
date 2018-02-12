Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932581AbeBLXMW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:12:22 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36357 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932376AbeBLXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:12:20 -0500
X-Google-Smtp-Source: AH8x225NzzLeE5PtPIzsvFR9nbrb5IWtxRTYWTPz3CpWJjUyMjRAgU9w/akgFtaqHDJR9y7kZ7ghlw==
Subject: Re: [PATCH 14/14] x86/crypto: aesni: Update aesni-intel_glue to use
 scatter/gather
To: Dave Watson <davejwatson@fb.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
References: <cover.1518211765.git.davejwatson@fb.com>
 <20180212195128.GA61087@davejwatson-mba.local>
From: Junaid Shahid <junaids@google.com>
Organization: Google
Message-ID: <dc69bdfa-6dc2-da54-9d9a-b171aeb3212b@google.com>
Date: Mon, 12 Feb 2018 15:12:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180212195128.GA61087@davejwatson-mba.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,


On 02/12/2018 11:51 AM, Dave Watson wrote:

> +static int gcmaes_encrypt_sg(struct aead_request *req, unsigned int assoclen,
> +			u8 *hash_subkey, u8 *iv, void *aes_ctx)
>  
> +static int gcmaes_decrypt_sg(struct aead_request *req, unsigned int assoclen,
> +			u8 *hash_subkey, u8 *iv, void *aes_ctx)

These two functions are almost identical. Wouldn't it be better to combine them into a single encrypt/decrypt function, similar to what you have done for the assembly macros?

> +	if (((struct crypto_aes_ctx *)aes_ctx)->key_length != AES_KEYSIZE_128 ||
> +		aesni_gcm_enc_tfm == aesni_gcm_enc) {

Shouldn't we also include a check for the buffer length being less than AVX_GEN2_OPTSIZE? AVX will not be used in that case either.


Thanks,
Junaid
