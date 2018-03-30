Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeC3R03 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:26:29 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:51518 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeC3R02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:26:28 -0400
Date: Sat, 31 Mar 2018 01:26:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: ccree: enable support for hardware keys
Message-ID: <20180330172616.GB28120@gondor.apana.org.au>
References: <1522049540-10042-1-git-send-email-gilad@benyossef.com>
 <1522049540-10042-3-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522049540-10042-3-git-send-email-gilad@benyossef.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 08:32:19AM +0100, Gilad Ben-Yossef wrote:
> Enable CryptoCell support for hardware keys.
> 
> Hardware keys are regular AES keys loaded into CryptoCell internal memory
> via firmware, often from secure boot ROM or hardware fuses at boot time.
> 
> As such, they can be used for enc/dec purposes like any other key but
> cannot (read: extremely hard to) be extracted since since they are not
> available anywhere in RAM during runtime.
> 
> The mechanism has some similarities to s390 secure keys although the keys
> are not wrapped or sealed, but simply loaded offline. The interface was
> therefore modeled based on the s390 secure keys support.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

...

>  static const struct cc_alg_template skcipher_algs[] = {
>  	{
> +		.name = "xts(haes)",
> +		.driver_name = "xts-haes-ccree",
> +		.blocksize = AES_BLOCK_SIZE,
> +		.template_skcipher = {
> +			.setkey = cc_cipher_sethkey,
> +			.encrypt = cc_cipher_encrypt,
> +			.decrypt = cc_cipher_decrypt,
> +			.min_keysize = CC_HW_KEY_SIZE,
> +			.max_keysize = CC_HW_KEY_SIZE,
> +			.ivsize = AES_BLOCK_SIZE,
> +			},
> +		.cipher_mode = DRV_CIPHER_XTS,
> +		.flow_mode = S_DIN_to_AES,
> +		.min_hw_rev = CC_HW_REV_630,
> +	},

How can this possibly pass the self-test?

If we want to add hardware keys we will need to figure out how
to deal with it in the top-level API first.

Are there other crypto drivers doing this?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
