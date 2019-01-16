Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7EDC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9472086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547661426;
	bh=LqNnElH0GNood3aNFKq5Q8oAXnnzecCJ6fo9bR6y1X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pac6aGRqIMOjvuhV2McbZn70W3VQXQxsGJ8n6qmPGdfDnRJbPBHGkpGZcalE71IUk
	 i+aoGRmeF6PCdia9ZaOlLQ9gH5Kf9ZmfxcDZPhuYRBDcludUsifldWP2jHLwPF1TRE
	 qW4Uyu4ET2w9CrpFencR6aEX59HJ1zUZgv2Zg+60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfAPR5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbfAPR5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:57:03 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9178520859;
        Wed, 16 Jan 2019 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547661422;
        bh=LqNnElH0GNood3aNFKq5Q8oAXnnzecCJ6fo9bR6y1X0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=19M8g7T1HetZE2UvNfLZzB+A2K8vuqOGRPbIp4WtdkyOlG8JR7x6o4qgyxf3cuUK+
         wm8zADG47yWS9ZJ6NfYzF+vQvEuv8Mi2qUZFuTtYJ0H7rD1jBc66sW6rd9O32tg6vh
         /29FN18t0w8azFTrmSWnc9x6ewaY9WjdL0mjNk8k=
Date:   Wed, 16 Jan 2019 09:57:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, ard.biesheuvel@linaro.org,
        jonathan.cameron@huawei.com
Subject: Re: [PATCH 2/5] crypto: ccm - use template array registering API to
 simplify the code
Message-ID: <20190116175700.GC152952@gmail.com>
References: <1547607034-40948-1-git-send-email-wangxiongfeng2@huawei.com>
 <1547607034-40948-3-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547607034-40948-3-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:50:31AM +0800, Xiongfeng Wang wrote:
> Use crypto template array registering API to simplify the code.
> 
> Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
> ---
>  crypto/ccm.c | 81 +++++++++++++++++++-----------------------------------------
>  1 file changed, 26 insertions(+), 55 deletions(-)
> 
> diff --git a/crypto/ccm.c b/crypto/ccm.c
> index b242fd0..8949aa2 100644
> --- a/crypto/ccm.c
> +++ b/crypto/ccm.c
> @@ -589,12 +589,6 @@ static int crypto_ccm_create(struct crypto_template *tmpl, struct rtattr **tb)
>  					mac_name);
>  }
>  
> -static struct crypto_template crypto_ccm_tmpl = {
> -	.name = "ccm",
> -	.create = crypto_ccm_create,
> -	.module = THIS_MODULE,
> -};
> -
>  static int crypto_ccm_base_create(struct crypto_template *tmpl,
>  				  struct rtattr **tb)
>  {
> @@ -618,12 +612,6 @@ static int crypto_ccm_base_create(struct crypto_template *tmpl,
>  					cipher_name);
>  }
>  
> -static struct crypto_template crypto_ccm_base_tmpl = {
> -	.name = "ccm_base",
> -	.create = crypto_ccm_base_create,
> -	.module = THIS_MODULE,
> -};
> -
>  static int crypto_rfc4309_setkey(struct crypto_aead *parent, const u8 *key,
>  				 unsigned int keylen)
>  {
> @@ -854,12 +842,6 @@ static int crypto_rfc4309_create(struct crypto_template *tmpl,
>  	goto out;
>  }
>  
> -static struct crypto_template crypto_rfc4309_tmpl = {
> -	.name = "rfc4309",
> -	.create = crypto_rfc4309_create,
> -	.module = THIS_MODULE,
> -};
> -
>  static int crypto_cbcmac_digest_setkey(struct crypto_shash *parent,
>  				     const u8 *inkey, unsigned int keylen)
>  {
> @@ -999,51 +981,40 @@ static int cbcmac_create(struct crypto_template *tmpl, struct rtattr **tb)
>  	return err;
>  }
>  
> -static struct crypto_template crypto_cbcmac_tmpl = {
> -	.name = "cbcmac",
> -	.create = cbcmac_create,
> -	.free = shash_free_instance,
> -	.module = THIS_MODULE,
> +static struct crypto_template crypto_ccm_tmpl[] = {

Add an 's':  'crypto_ccm_tmpls'.  Likewise everywhere else in this patch series
where you're defining an array of crypto_templates.

> +	{
> +		.name = "cbcmac",
> +		.create = cbcmac_create,
> +		.free = shash_free_instance,
> +		.module = THIS_MODULE,
> +	},
> +	{

In a list of struct definitions, the { should be on the same line as the
previous '},'.  Likewise everywhere else in this patch series where you're
defining an array of crypto_templates.

> +		.name = "ccm_base",
> +		.create = crypto_ccm_base_create,
> +		.module = THIS_MODULE,
> +	},
> +	{
> +		.name = "ccm",
> +		.create = crypto_ccm_create,
> +		.module = THIS_MODULE,
> +	},
> +	{
> +		.name = "rfc4309",
> +		.create = crypto_rfc4309_create,
> +		.module = THIS_MODULE,
> +	},
>  };
>  
>  static int __init crypto_ccm_module_init(void)
>  {
> -	int err;
> -
> -	err = crypto_register_template(&crypto_cbcmac_tmpl);
> -	if (err)
> -		goto out;
> -
> -	err = crypto_register_template(&crypto_ccm_base_tmpl);
> -	if (err)
> -		goto out_undo_cbcmac;
> -
> -	err = crypto_register_template(&crypto_ccm_tmpl);
> -	if (err)
> -		goto out_undo_base;
> -
> -	err = crypto_register_template(&crypto_rfc4309_tmpl);
> -	if (err)
> -		goto out_undo_ccm;
> -
> -out:
> -	return err;
> -
> -out_undo_ccm:
> -	crypto_unregister_template(&crypto_ccm_tmpl);
> -out_undo_base:
> -	crypto_unregister_template(&crypto_ccm_base_tmpl);
> -out_undo_cbcmac:
> -	crypto_register_template(&crypto_cbcmac_tmpl);
> -	goto out;
> +	return crypto_register_templates(crypto_ccm_tmpl,
> +			ARRAY_SIZE(crypto_ccm_tmpl));
>  }

Please fix the indentation here, so the continuation line is aligned.

	return crypto_register_templates(crypto_ccm_tmpl,
					 ARRAY_SIZE(crypto_ccm_tmpl));

Likewise everywhere else in the patch series where you're registering or
unregistering templates.

>  
>  static void __exit crypto_ccm_module_exit(void)
>  {
> -	crypto_unregister_template(&crypto_rfc4309_tmpl);
> -	crypto_unregister_template(&crypto_ccm_tmpl);
> -	crypto_unregister_template(&crypto_ccm_base_tmpl);
> -	crypto_unregister_template(&crypto_cbcmac_tmpl);
> +	crypto_unregister_templates(crypto_ccm_tmpl,
> +			ARRAY_SIZE(crypto_ccm_tmpl));
>  }

Same here.

	crypto_unregister_templates(crypto_ccm_tmpl,
				    ARRAY_SIZE(crypto_ccm_tmpl));

>  
>  module_init(crypto_ccm_module_init);
> -- 
> 1.7.12.4
> 

Thanks,

- Eric
