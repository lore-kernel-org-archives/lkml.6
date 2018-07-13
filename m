Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5378ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B753208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbQJJvIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B753208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeGMJio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:38:44 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36135 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeGMJio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:38:44 -0400
Received: by mail-lf0-f66.google.com with SMTP id b22-v6so14209000lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qfapjf3gSwWe5IOnAYLgUO/aXFRzI3w1mIr7/1H3r1Y=;
        b=AbQJJvIYU3qYLGXF9JL7KYk945uVON2pwzVoT7Y3BIWO4q3g/+VZZvv+/TBnBcIaHK
         hAdmL1XH3i+2a5LF57h18wmnBEFeFxrfUwRSXo174gra5mLyToNv+NyRgZnDCgXPndDi
         M2TWeaZShtkcYaGihoraxJ1jhMSM0vbfzfyeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qfapjf3gSwWe5IOnAYLgUO/aXFRzI3w1mIr7/1H3r1Y=;
        b=MIQfs8EMszYfsA3ZXr3wrBDfK8HsNjhGVb3rDdyrC5dhlgj0Uxq2qvIPHsurzJCYuU
         ocI15daAUuo4wTXK5ICT4vbF54EsVIL6nSAwaZvBwuoqj6fL09L8Iv56RRftzjCkLuHa
         SdppKf8TD/U/MSur+9n+5zFynQaR8k1zRmg7VKvy7aojd6wlbmQQPj8Z23okkd1ucVDX
         dNKEsy4o2m8k1gcrbBw9Cz+F9bZgWWK9D5/5DmG4CgNOTSGEMwSeb4YT3z3RyVcSPrqS
         C4lgdp2xbT5i9tU6/ri07d82xf/ePKN5NVO8r5Qh7jf+FYYzGVMak+M3/DA3/ppsKzNq
         wedg==
X-Gm-Message-State: AOUpUlEUCwbnf1hARbL20nd2/wtyMKXu2jx5BvlkuUVBmZa5KIgo2fNg
        RcA93qQIYLjXoSv1NF9R3RUNq/yiQZw=
X-Google-Smtp-Source: AAOMgpe604ENWPzCcy/in3Jy3F7StmQq0ztHs+MR0boV7uofITaTGjJ7bv8uSxMIteiQm/33YS/+NQ==
X-Received: by 2002:a19:d189:: with SMTP id i131-v6mr4620612lfg.93.1531473893375;
        Fri, 13 Jul 2018 02:24:53 -0700 (PDT)
Received: from jax.urgonet (h-84-45.A175.priv.bahnhof.se. [79.136.84.45])
        by smtp.gmail.com with ESMTPSA id 93-v6sm6702403lfy.64.2018.07.13.02.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 02:24:52 -0700 (PDT)
Date:   Fri, 13 Jul 2018 11:24:50 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org
Cc:     Zeng Tao <prime.zeng@hisilicon.com>,
        Victor Chong <victor.chong@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [RESEND PATCH] tee: add kernel internal client interface
Message-ID: <20180713092449.GA17766@jax.urgonet>
References: <20180709061549.24382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709061549.24382-1-jens.wiklander@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Sumit]

On Mon, Jul 09, 2018 at 08:15:49AM +0200, Jens Wiklander wrote:
> Adds a kernel internal TEE client interface to be used by other drivers.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c  | 113 +++++++++++++++++++++++++++++++++++++---
>  include/linux/tee_drv.h |  73 ++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index dd46b758852a..7b2bb4c50058 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -38,15 +38,13 @@ static DEFINE_SPINLOCK(driver_lock);
>  static struct class *tee_class;
>  static dev_t tee_devt;
>  
> -static int tee_open(struct inode *inode, struct file *filp)
> +static struct tee_context *teedev_open(struct tee_device *teedev)
>  {
>  	int rc;
> -	struct tee_device *teedev;
>  	struct tee_context *ctx;
>  
> -	teedev = container_of(inode->i_cdev, struct tee_device, cdev);
>  	if (!tee_device_get(teedev))
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
>  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx) {
> @@ -57,16 +55,16 @@ static int tee_open(struct inode *inode, struct file *filp)
>  	kref_init(&ctx->refcount);
>  	ctx->teedev = teedev;
>  	INIT_LIST_HEAD(&ctx->list_shm);
> -	filp->private_data = ctx;
>  	rc = teedev->desc->ops->open(ctx);
>  	if (rc)
>  		goto err;
>  
> -	return 0;
> +	return ctx;
>  err:
>  	kfree(ctx);
>  	tee_device_put(teedev);
> -	return rc;
> +	return ERR_PTR(rc);
> +
>  }
>  
>  void teedev_ctx_get(struct tee_context *ctx)
> @@ -100,6 +98,18 @@ static void teedev_close_context(struct tee_context *ctx)
>  	teedev_ctx_put(ctx);
>  }
>  
> +static int tee_open(struct inode *inode, struct file *filp)
> +{
> +	struct tee_context *ctx;
> +
> +	ctx = teedev_open(container_of(inode->i_cdev, struct tee_device, cdev));
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	filp->private_data = ctx;
> +	return 0;
> +}
> +
>  static int tee_release(struct inode *inode, struct file *filp)
>  {
>  	teedev_close_context(filp->private_data);
> @@ -928,6 +938,95 @@ void *tee_get_drvdata(struct tee_device *teedev)
>  }
>  EXPORT_SYMBOL_GPL(tee_get_drvdata);
>  
> +struct match_dev_data {
> +	struct tee_ioctl_version_data *vers;
> +	const void *data;
> +	int (*match)(struct tee_ioctl_version_data *, const void *);
> +};
> +
> +static int match_dev(struct device *dev, const void *data)
> +{
> +	const struct match_dev_data *match_data = data;
> +	struct tee_device *teedev = container_of(dev, struct tee_device, dev);
> +
> +	teedev->desc->ops->get_version(teedev, match_data->vers);
> +	return match_data->match(match_data->vers, match_data->data);
> +}
> +
> +struct tee_context *
> +tee_client_open_context(struct tee_context *start,
> +			int (*match)(struct tee_ioctl_version_data *,
> +				     const void *),
> +			const void *data, struct tee_ioctl_version_data *vers)
> +{
> +	struct device *dev = NULL;
> +	struct device *put_dev = NULL;
> +	struct tee_context *ctx = NULL;
> +	struct tee_ioctl_version_data v;
> +	struct match_dev_data match_data = { vers ? vers : &v, data, match };
> +
> +	if (start)
> +		dev = &start->teedev->dev;
> +
> +	do {
> +		dev = class_find_device(tee_class, dev, &match_data, match_dev);
> +		if (!dev) {
> +			ctx = ERR_PTR(-ENOENT);
> +			break;
> +		}
> +
> +		put_device(put_dev);
> +		put_dev = dev;
> +
> +		ctx = teedev_open(container_of(dev, struct tee_device, dev));
> +	} while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
> +
> +	put_device(put_dev);
> +	return ctx;
> +}
> +EXPORT_SYMBOL_GPL(tee_client_open_context);
> +
> +void tee_client_close_context(struct tee_context *ctx)
> +{
> +	teedev_close_context(ctx);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_close_context);
> +
> +void tee_client_get_version(struct tee_context *ctx,
> +			    struct tee_ioctl_version_data *vers)
> +{
> +	ctx->teedev->desc->ops->get_version(ctx->teedev, vers);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_get_version);
> +
> +int tee_client_open_session(struct tee_context *ctx,
> +			    struct tee_ioctl_open_session_arg *arg,
> +			    struct tee_param *param)
> +{
> +	if (!ctx->teedev->desc->ops->open_session)
> +		return -EINVAL;
> +	return ctx->teedev->desc->ops->open_session(ctx, arg, param);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_open_session);
> +
> +int tee_client_close_session(struct tee_context *ctx, u32 session)
> +{
> +	if (!ctx->teedev->desc->ops->close_session)
> +		return -EINVAL;
> +	return ctx->teedev->desc->ops->close_session(ctx, session);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_close_session);
> +
> +int tee_client_invoke_func(struct tee_context *ctx,
> +			   struct tee_ioctl_invoke_arg *arg,
> +			   struct tee_param *param)
> +{
> +	if (!ctx->teedev->desc->ops->invoke_func)
> +		return -EINVAL;
> +	return ctx->teedev->desc->ops->invoke_func(ctx, arg, param);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_invoke_func);
> +
>  static int __init tee_init(void)
>  {
>  	int rc;
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index a2b3dfcee0b5..6cfe05893a76 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -453,6 +453,79 @@ static inline int tee_shm_get_id(struct tee_shm *shm)
>   */
>  struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
>  
> +/**
> + * tee_client_open_context() - Open a TEE context
> + * @start:	if not NULL, continue search after this context
> + * @match:	function to check TEE device
> + * @data:	data for match function
> + * @vers:	if not NULL, version data of TEE device of the context returned
> + *
> + * This function does an operation similar to open("/dev/teeX") in user space.
> + * A returned context must be released with tee_client_close_context().
> + *
> + * Returns a TEE context of the first TEE device matched by the match()
> + * callback or an ERR_PTR.
> + */
> +struct tee_context *
> +tee_client_open_context(struct tee_context *start,
> +			int (*match)(struct tee_ioctl_version_data *,
> +				     const void *),
> +			const void *data, struct tee_ioctl_version_data *vers);
> +
> +/**
> + * tee_client_close_context() - Close a TEE context
> + * @ctx:	TEE context to close
> + *
> + * Note that all sessions previously opened with this context will be
> + * closed when this function is called.
> + */
> +void tee_client_close_context(struct tee_context *ctx);
> +
> +/**
> + * tee_client_get_version() - Query version of TEE
> + * @ctx:	TEE context to TEE to query
> + * @vers:	Pointer to version data
> + */
> +void tee_client_get_version(struct tee_context *ctx,
> +			    struct tee_ioctl_version_data *vers);
> +
> +/**
> + * tee_client_open_session() - Open a session to a Trusted Application
> + * @ctx:	TEE context
> + * @arg:	Open session arguments, see description of
> + *		struct tee_ioctl_open_session_arg
> + * @param:	Parameters passed to the Trusted Application
> + *
> + * Returns < 0 on error else see @arg->ret for result. If @arg->ret
> + * is TEEC_SUCCESS the session identifier is available in @arg->session.
> + */
> +int tee_client_open_session(struct tee_context *ctx,
> +			    struct tee_ioctl_open_session_arg *arg,
> +			    struct tee_param *param);
> +
> +/**
> + * tee_client_close_session() - Close a session to a Trusted Application
> + * @ctx:	TEE Context
> + * @session:	Session id
> + *
> + * Return < 0 on error else 0, regardless the session will not be
> + * valid after this function has returned.
> + */
> +int tee_client_close_session(struct tee_context *ctx, u32 session);
> +
> +/**
> + * tee_client_invoke_func() - Invoke a function in a Trusted Application
> + * @ctx:	TEE Context
> + * @arg:	Invoke arguments, see description of
> + *		struct tee_ioctl_invoke_arg
> + * @param:	Parameters passed to the Trusted Application
> + *
> + * Returns < 0 on error else see @arg->ret for result.
> + */
> +int tee_client_invoke_func(struct tee_context *ctx,
> +			   struct tee_ioctl_invoke_arg *arg,
> +			   struct tee_param *param);
> +
>  static inline bool tee_param_is_memref(struct tee_param *param)
>  {
>  	switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
> -- 
> 2.17.1
> 
