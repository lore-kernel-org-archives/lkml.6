Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EC2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7346320883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547780286;
	bh=sEfR3ok3RYwVP6HM0cIrTT7/A5Sy8ExwvvafJSQ/sgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rSr0QV6SgqPlLOBD+J6mfsNlGp2GpFNOVLVgThCMRIa6Qwl2qXsEYzTocctlrb2y/
	 uZVd4o1XqyS3Ulk0ceFu0ZLIDVnDcW5tTbS6ZJTZaikyu90eFnCy7o0y5KtnI31bZW
	 p0r6PCrSR3Eg9r2u1LcbxxZdsbhxpQ+UH8Uhm7XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfARC6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:58:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfARC6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:58:03 -0500
Received: from sol.localdomain (c-24-23-143-129.hsd1.ca.comcast.net [24.23.143.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D4AC20873;
        Fri, 18 Jan 2019 02:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547780283;
        bh=sEfR3ok3RYwVP6HM0cIrTT7/A5Sy8ExwvvafJSQ/sgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HMF2bYQ241btn0PHaEggxr8xcHiYsSf8qbrxK7Fxqr4+VuzVqiqR2xNdLehFkKUz
         i8vwnMvF8fCMUppihukvcV1bJeiO+8lqFPILNdNXzvQRR+E1oLxGRW/XoMGLioqwuP
         CMUp7FE3bXGzN3q58fCcJlp79yPh2gWUF7gz/6Yw=
Date:   Thu, 17 Jan 2019 18:58:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, ard.biesheuvel@linaro.org,
        jonathan.cameron@huawei.com
Subject: Re: [PATCH V2 4/5] crypto: ctr - use template array registering API
 to simplify the code
Message-ID: <20190118025800.GB737@sol.localdomain>
References: <1547707683-45878-1-git-send-email-wangxiongfeng2@huawei.com>
 <1547707683-45878-5-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547707683-45878-5-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:48:02PM +0800, Xiongfeng Wang wrote:
> Use crypto template array registering API to simplify the code.
> 
> Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
> ---
>  crypto/ctr.c | 43 +++++++++++++++----------------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/crypto/ctr.c b/crypto/ctr.c
> index 4c743a9..d9f9d65 100644
> --- a/crypto/ctr.c
> +++ b/crypto/ctr.c
> @@ -171,12 +171,6 @@ static int crypto_ctr_create(struct crypto_template *tmpl, struct rtattr **tb)
>  	return err;
>  }
>  
> -static struct crypto_template crypto_ctr_tmpl = {
> -	.name = "ctr",
> -	.create = crypto_ctr_create,
> -	.module = THIS_MODULE,
> -};
> -
>  static int crypto_rfc3686_setkey(struct crypto_skcipher *parent,
>  				 const u8 *key, unsigned int keylen)
>  {
> @@ -366,36 +360,29 @@ static int crypto_rfc3686_create(struct crypto_template *tmpl,
>  	goto out;
>  }
>  
> -static struct crypto_template crypto_rfc3686_tmpl = {
> -	.name = "rfc3686",
> -	.create = crypto_rfc3686_create,
> -	.module = THIS_MODULE,
> +static struct crypto_template crypto_ctr_tmpls[] = {
> +	{
> +		.name = "ctr",
> +		.create = crypto_ctr_create,
> +		.module = THIS_MODULE,
> +	}, {
> +		.name = "rfc3686",
> +		.create = crypto_rfc3686_create,
> +		.module = THIS_MODULE,
> +	},
>  };
>  
> +

If you resend please also remove the extra blank line here.

- Eric
