Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3839BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AC62174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AC62174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeH0Jyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:54:50 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:48200 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbeH0Jyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:54:49 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fuAiO-0003RX-Lz; Mon, 27 Aug 2018 14:09:28 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fuAiF-00057S-1y; Mon, 27 Aug 2018 14:09:19 +0800
Date:   Mon, 27 Aug 2018 14:09:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jeff.Lien@wdc.com, ard.biesheuvel@linaro.org,
        david.darrington@wdc.com, hch@infradead.org, jeff.furlong@wdc.com,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 1/4] crypto: Introduce notifier for new crypto algorithms
Message-ID: <20180827060918.tfz7ljufqhlej4kq@gondor.apana.org.au>
References: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
 <20180826024006.13800-1-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180826024006.13800-1-martin.petersen@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 10:40:03PM -0400, Martin K. Petersen wrote:
>
> diff --git a/crypto/algapi.c b/crypto/algapi.c
> index c0755cf4f53f..87abad3cc322 100644
> --- a/crypto/algapi.c
> +++ b/crypto/algapi.c
> @@ -361,15 +361,12 @@ static void crypto_wait_for_test(struct crypto_larval *larval)
>  	err = crypto_probing_notify(CRYPTO_MSG_ALG_REGISTER, larval->adult);
>  	if (err != NOTIFY_STOP) {
>  		if (WARN_ON(err != NOTIFY_DONE))
> -			goto out;
> +			return;
>  		crypto_alg_tested(larval->alg.cra_driver_name, 0);
>  	}
>  
>  	err = wait_for_completion_killable(&larval->completion);
>  	WARN_ON(err);
> -
> -out:
> -	crypto_larval_kill(&larval->alg);
>  }
>  
>  int crypto_register_alg(struct crypto_alg *alg)
> @@ -390,6 +387,8 @@ int crypto_register_alg(struct crypto_alg *alg)
>  		return PTR_ERR(larval);
>  
>  	crypto_wait_for_test(larval);
> +	crypto_probing_notify(CRYPTO_MSG_ALG_LOADED, larval);
> +	crypto_larval_kill(&larval->alg);

I see that you have moved the larval_kill call into the caller.
This is a problem because there are two callers to wait_for_test.

So it's probably best to leave it in wait_for_test and add the
notify there.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
