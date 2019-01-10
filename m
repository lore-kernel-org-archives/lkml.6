Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9522C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654A9214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NthSexCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfAJOYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:24:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35214 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfAJOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:24:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so11607167wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ODmRSNXYzDZYBjs73e9EhrnGPHZIJk5SgZpuFr3KRS4=;
        b=NthSexCozzlW10P5ac9BmBmt9XnyEvqXtLDGuldcxfS1rCbCfBIvBOU8drU4b4LY/Z
         nbuOlcQxs9stvsQggyh62dEZ/KaSWriHmnxRVoF514ZFJhMqDRaqnR2Bu5LgeWQduzO5
         yPLa7u7Q7xPwMCnDDcxSstfnpBj82TepvRaOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ODmRSNXYzDZYBjs73e9EhrnGPHZIJk5SgZpuFr3KRS4=;
        b=aK0R/2MM9RrmV41OpvGPXN6Fb377rLewt7G31mkOwaCdk3SQPgMJIrcH0Q5etHvKet
         Nk1hqaOTblNcgc6+ZEbNKeNtmSZiTkwnhcwdWLYw06Ds4d0Uheenwfk0FpdwvA+gzK/c
         MIusnz6Sry2GpALTJTHbmNJ0ygkF5TGfn3+nXZKG3b7QhWjrmqVhWrXWAOr2xEJPqjxq
         uQ0kmC3NeeHR+XXrZV0U0/XlZktMwEUk02S0BnHLjm8za/J4b0mcDbbXZvhaAQP8AgUE
         f+gqCjS2iGlQecbaEnJAc5XBawz33KBAjg0AOKVfxDFgr38fPUriWhQ8jlsxz8Vz1QG9
         2kUg==
X-Gm-Message-State: AJcUukfskfu4DeNLX7kF2sc8Zt7VG9wJCrBtVqP4zuhv2fKwAInHSc2y
        uWNclL8mVmA9Y0Qz3tbySisOzQ==
X-Google-Smtp-Source: ALg8bN4T+K684/spLpfMbsFFMq8fyrJgnnFsgQycCCYNy+10bkt1Yqmp6l4DCz2SzC82pWKcMDL0mg==
X-Received: by 2002:a5d:6487:: with SMTP id r7mr9725231wru.263.1547130238457;
        Thu, 10 Jan 2019 06:23:58 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id l15sm50004944wrw.4.2019.01.10.06.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 06:23:57 -0800 (PST)
Date:   Thu, 10 Jan 2019 14:23:55 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, jens.wiklander@linaro.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v2 3/4] tee: add supp_nowait flag in tee_context struct
Message-ID: <20190110142355.bcgw62w2qk2mlzj6@holly.lan>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547123097-16431-4-git-send-email-sumit.garg@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:54:56PM +0530, Sumit Garg wrote:
> This flag indicates that requests in this context should not wait for
> tee-supplicant daemon to be started if not present and just return
> with an error code. It is needed for requests which should be
> non-blocking in nature like ones arising from TEE based kernel drivers
> or any in kernel api that uses TEE internal client interface.

This patch seems out of order in the patch set: Doesn't
optee_enumarate_devices() require this feature if it is to
work correctly with a TEE that does not implement the enumeate pTA.

If so better to implement the feature first so that
optee_emumerate_devices() works correctly when it first appears.

> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/supp.c | 10 +++++++++-
>  drivers/tee/tee_core.c   |  2 ++
>  include/linux/tee_drv.h  |  6 ++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index 43626e1..92f56b8 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -88,10 +88,18 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
>  {
>  	struct optee *optee = tee_get_drvdata(ctx->teedev);
>  	struct optee_supp *supp = &optee->supp;
> -	struct optee_supp_req *req = kzalloc(sizeof(*req), GFP_KERNEL);
> +	struct optee_supp_req *req;
>  	bool interruptable;
>  	u32 ret;
>  
> +	/*
> +	 * Return in case there is no supplicant available and
> +	 * non-blocking request.
> +	 */
> +	if (!supp->ctx && ctx->supp_nowait)
> +		return TEEC_ERROR_COMMUNICATION;
> +
> +	req = kzalloc(sizeof(*req), GFP_KERNEL);
>  	if (!req)
>  		return TEEC_ERROR_OUT_OF_MEMORY;
>  
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 9ddb89e..5d6c317 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -105,6 +105,7 @@ static int tee_open(struct inode *inode, struct file *filp)
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
>  
> +	ctx->supp_nowait = false;
>  	filp->private_data = ctx;
>  	return 0;
>  }
> @@ -981,6 +982,7 @@ tee_client_open_context(struct tee_context *start,
>  	} while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
>  
>  	put_device(put_dev);
> +	ctx->supp_nowait = true;

Why automatically set supp_nowait inside open_context() ?


>  	return ctx;
>  }
>  EXPORT_SYMBOL_GPL(tee_client_open_context);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index ed16bf1..fe1a920 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -49,6 +49,11 @@ struct tee_shm_pool;
>   * @releasing:  flag that indicates if context is being released right now.
>   *		It is needed to break circular dependency on context during
>   *              shared memory release.
> + * @supp_nowait: flag that indicates that requests in this context should not
> + *              wait for tee-supplicant daemon to be started if not present
> + *              and just return with an error code. It is needed for requests
> + *              that arises from TEE based kernel drivers that should be
> + *              non-blocking in nature.
>   */
>  struct tee_context {
>  	struct tee_device *teedev;
> @@ -56,6 +61,7 @@ struct tee_context {
>  	void *data;
>  	struct kref refcount;
>  	bool releasing;
> +	bool supp_nowait;
>  };
>  
>  struct tee_param_memref {
> -- 
> 2.7.4
> 
