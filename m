Return-Path: <kernel-hardening-return-12232-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELus/sFP10V92c6dDLfJDY2qiBn49rvKOq6GqIlXT3osITpMJi+qNHfab3P/bgMeZiV9oLO7
ARC-Seal: i=1; a=rsa-sha256; t=1520502597; cv=none;
        d=google.com; s=arc-20160816;
        b=uMQil7WUtjRSx0IPV8FQR5htkvdLcaTGE6aDNbFa6KWrRQgBYC/oZF8wFYfWnZtsMm
         2oC8SSGmzaJDDsSbtT63+hi9fD5e5Yiz7WEUTqqcG0AYBh6HQgihr1GK6OQP/5wkrnt6
         TDqkFZAoTYf/SD8TTcTIhrXIZtPhLZgyVuQxLqYVJnGWMdbh2IIzrKeaAxn5ErN3z1I2
         7CR39GKNYi6g8yoDJNwFXX1T/RekXhoVQzVi59T2jPkXAOlZFRRgych+pmakCZqnp9uA
         +/SaxYK+Dz7YoZR79L9bIh1gUKeb41iKNvMtaoMfVJW6VlgoA/kvxj/xX0EloU2naoqJ
         mIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=5NU/weS4tUvY14wWwo9TVgwuBjuuv9KpQcpF3Gvd/oo=;
        b=ATAWN9o5gJnhDQw2iV8vbKTvHQmKdn5DwXiUb9zClfFqRPtN4GZPP+yZGMUzKAGv9v
         eGkh8I0esNX0ncejerS7Z7FvHnevZ9VJp1SxN7P85MWLJHWxrZRStfTSkSTKlX9pdPo9
         0DUknZeAVp60HvWpSwBWUz3LEjfgNYp6Ry88LsOZP5vo78nhNflDrt1ctxPVwu9CPE1I
         Naw5LRSB6B1ZYgh3cJ8hkFxcUf6MRWYrUwZBw5huYjqT8xAARlH5jHh4WbeeZ/gHkUWr
         /J+NxdvsVjsjmOm5e/0cw24LtfusObN8Ai5KbpAdEIlGjbjLENdWJCS6T74kEveosjUu
         jscw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12232-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12232-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12232-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12232-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.47,440,1515481200";
   d="scan'208";a="9966864"
Subject: Re: [PATCH] crypto/ecc: Remove stack VLA usage
To: Kees Cook <keescook@chromium.org>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	<linux-crypto@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180307215615.GA18928@beast>
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <4fbe11f1-c92e-a4d5-616d-01e983f5405f@microchip.com>
Date: Thu, 8 Mar 2018 11:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180307215615.GA18928@beast>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317666211482580?=
X-GMAIL-MSGID: =?utf-8?q?1594362531762435721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Kees,

On 03/07/2018 11:56 PM, Kees Cook wrote:
> On the quest to remove all VLAs from the kernel[1], this switches to
> a pair of kmalloc regions instead of using the stack. This also moves
> the get_random_bytes() after all allocations (and drops the needless
> "nbytes" variable).
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   crypto/ecc.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index 18f32f2a5e1c..5bfa63603da0 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -1025,9 +1025,7 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
>   {
>   	int ret = 0;
>   	struct ecc_point *product, *pk;
> -	u64 priv[ndigits];
> -	u64 rand_z[ndigits];
> -	unsigned int nbytes;
> +	u64 *priv, *rand_z;
>   	const struct ecc_curve *curve = ecc_get_curve(curve_id);
>   
>   	if (!private_key || !public_key || !curve) {
> @@ -1035,14 +1033,22 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
>   		goto out;
>   	}
>   
> -	nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
> +	priv = kmalloc_array(ndigits, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>   
> -	get_random_bytes(rand_z, nbytes);
> +	rand_z = kmalloc_array(ndigits, sizeof(*rand_z), GFP_KERNEL);
> +	if (!rand_z) {
> +		ret = -ENOMEM;
> +		goto kfree_out;
> +	}
>   
>   	pk = ecc_alloc_point(ndigits);
>   	if (!pk) {
>   		ret = -ENOMEM;
> -		goto out;
> +		goto kfree_out;
>   	}
>   
>   	product = ecc_alloc_point(ndigits);
> @@ -1051,6 +1057,8 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
>   		goto err_alloc_product;
>   	}
>   
> +	get_random_bytes(rand_z, ndigits << ECC_DIGITS_TO_BYTES_SHIFT);
> +
>   	ecc_swap_digits(public_key, pk->x, ndigits);
>   	ecc_swap_digits(&public_key[ndigits], pk->y, ndigits);
>   	ecc_swap_digits(private_key, priv, ndigits);
> @@ -1065,6 +1073,9 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
>   	ecc_free_point(product);
>   err_alloc_product:
>   	ecc_free_point(pk);
> +kfree_out:
> +	kfree(priv);

I think we should use kzfree here.

> +	kfree(rand_z);

Probably here too. Looks like there are few intermediate buffers in ecc
that should be zeroized as well.

Best,
ta
>   out:
>   	return ret;
>   }
> 
