Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A719C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAFE20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547661161;
	bh=9m8mVnp2uFfmsr7TZZFZ4VDYn89U86Y5yXwQON6prhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CSfx1p+YRs9ANy24KgITvYw9yTlgeWDJlzZF3SyKCrOEglM0pxHbIWd2gTehU/M51
	 xNza4GDWHXCxwv6xNFD1Y+o+DyQUH4nm3wVI8lHVnnHMYdpFhUE9VY2VXmBnjXgY50
	 fWEjbka6kzi5PZv3wqSc2VBNbOQQHmUaBD53WMYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfAPRwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbfAPRwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:52:39 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455792082F;
        Wed, 16 Jan 2019 17:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547661158;
        bh=9m8mVnp2uFfmsr7TZZFZ4VDYn89U86Y5yXwQON6prhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/JDOpFG2+nzvZmXpRN6GUPxzZFcVyOUvsYqxxzzjsbYRf6mazIGszyd/707rwLn+
         hYX2PA5DzRto69AOls5jiiQmXGw8qBdsjd4Y4fBQiwbsJEYD0wEDwMQShSpHlv1AM7
         aYi6wNtzGdUGMS2ppIxP1TC0a1IdMgrxHgVKbjEk=
Date:   Wed, 16 Jan 2019 09:52:36 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, ard.biesheuvel@linaro.org,
        jonathan.cameron@huawei.com
Subject: Re: [PATCH 1/5] crypto: api - add a helper to (un)register a array
 of templates
Message-ID: <20190116175236.GB152952@gmail.com>
References: <1547607034-40948-1-git-send-email-wangxiongfeng2@huawei.com>
 <1547607034-40948-2-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547607034-40948-2-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few nits:

On Wed, Jan 16, 2019 at 10:50:30AM +0800, Xiongfeng Wang wrote:
> This patch add a helper to (un)register a array of templates. The
> following patches will use this helper to simplify the code.
> 
> Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
> ---
>  crypto/algapi.c         | 27 +++++++++++++++++++++++++++
>  include/crypto/algapi.h |  2 ++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/crypto/algapi.c b/crypto/algapi.c
> index 8b65ada..59a6599 100644
> --- a/crypto/algapi.c
> +++ b/crypto/algapi.c
> @@ -494,6 +494,24 @@ int crypto_register_template(struct crypto_template *tmpl)
>  }
>  EXPORT_SYMBOL_GPL(crypto_register_template);
>  
> +int crypto_register_templates(struct crypto_template *tmpl, int num)

Can you adjust the parameter names to make it consistent with the other bulk
registration functions?

int crypto_register_templates(struct crypto_template *tmpls, int count)

Note the 's' on 'tmpls'.

> +{
> +	int i, err;
> +
> +	for (i = 0; i < num; i++) {
> +		err = crypto_register_template(&tmpl[i]);
> +		if (err)
> +			goto out;
> +	}
> +	return 0;
> +
> +out:
> +	for (i -= 1; i >= 0; i--)

Other places write this as: 'for (--i; i >= 0; --i)'

> +		crypto_unregister_template(&tmpl[i]);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(crypto_register_templates);
> +
>  void crypto_unregister_template(struct crypto_template *tmpl)
>  {
>  	struct crypto_instance *inst;
> @@ -523,6 +541,15 @@ void crypto_unregister_template(struct crypto_template *tmpl)
>  }
>  EXPORT_SYMBOL_GPL(crypto_unregister_template);
>  
> +void crypto_unregister_templates(struct crypto_template *tmpl, int num)
> +{

Same here.

> +	int i;
> +
> +	for (i = num - 1; i >= 0; i--)
> +		crypto_unregister_template(&tmpl[i]);
> +}
> +EXPORT_SYMBOL_GPL(crypto_unregister_templates);
> +
>  static struct crypto_template *__crypto_lookup_template(const char *name)
>  {
>  	struct crypto_template *q, *tmpl = NULL;
> diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
> index 4a5ad10..e879a20 100644
> --- a/include/crypto/algapi.h
> +++ b/include/crypto/algapi.h
> @@ -143,7 +143,9 @@ struct ablkcipher_walk {
>  void crypto_mod_put(struct crypto_alg *alg);
>  
>  int crypto_register_template(struct crypto_template *tmpl);
> +int crypto_register_templates(struct crypto_template *tmpl, int num);
>  void crypto_unregister_template(struct crypto_template *tmpl);
> +void crypto_unregister_templates(struct crypto_template *tmpl, int num);

And here.

- Eric
