Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104E7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9502085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548948864;
	bh=jqJoO8+takE9SVBvydOJUosnwnEEgj/g6VrKUJd5uL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bcQUtzlWKR54eQTo5CK9zRVsJlHy2afcJ/bWf8oglYjwPhcuvD4Qt+b/URCD7veRl
	 qyiNR6u2A/ck3Iy8YsTW//9O3sljDUQBq2CKBtSIZIm3zqB/zkggPYWjColfu7azwV
	 ThVU24x/gKVwQ//PQ4gx4/R9uPTJKB74Hnbi7FTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfAaPeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:34:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfAaPeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:34:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 577822085B;
        Thu, 31 Jan 2019 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548948861;
        bh=jqJoO8+takE9SVBvydOJUosnwnEEgj/g6VrKUJd5uL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ba71ut2PZl1X/Cr2AvYXa2Z2sX9mwragyPYpqeP5EIZ30GGCtVmtsBSWQmJkRPaWq
         OYZN+WZYCeHmyQPri7qfLPsOZhVAbPA8baXMFLZRbfBPi4PDeSA6mqTj+mFKeBNHKR
         lfOQPYlnMoqQ0iJaWn0ywaZjbSMfj645kQQ9+VgI=
Date:   Thu, 31 Jan 2019 16:34:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, bkumar@qti.qualcomm.com,
        linux-arm-msm@vger.kernel.org, thierry.escande@linaro.org
Subject: Re: [PATCH v4 3/5] misc: fastrpc: Add support for context Invoke
 method
Message-ID: <20190131153419.GA18667@kroah.com>
References: <20190124152412.10503-1-srinivas.kandagatla@linaro.org>
 <20190124152412.10503-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124152412.10503-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 03:24:10PM +0000, Srinivas Kandagatla wrote:
> This patch adds support to compute context invoke method
> on the remote processor (DSP).
> This involves setting up the functions input and output arguments,
> input and output handles and mapping the dmabuf fd for the
> argument/handle buffers.
> 

This says _what_ this code does, but not why.  What about all of that
explaination you had in the 0/5 patch, shouldn't that be here, or on
patch 2/5?

Some nits below:

> +static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
> +{
> +	struct fastrpc_invoke_args *args = NULL;
> +	struct fastrpc_invoke inv;
> +	u32 nscalars;
> +	int err;
> +
> +	if (copy_from_user(&inv, argp, sizeof(inv)))
> +		return -EFAULT;
> +
> +	nscalars = REMOTE_SCALARS_LENGTH(inv.sc);
> +	if (nscalars) {
> +		args = kcalloc(nscalars, sizeof(*args), GFP_KERNEL);

Yeah, let's not bounds check the input variables and suck up all of the
kernel memory!

Remember:
	ALL INPUT IS EVIL

> +		if (!args)
> +			return -ENOMEM;
> +
> +		if (copy_from_user(args, (void __user *)(uintptr_t)inv.args,
> +				   nscalars * sizeof(*args))) {

That could be very big, again, check the input.

> +			kfree(args);
> +			return -EFAULT;
> +		}
> +	}
> +
> +	err = fastrpc_internal_invoke(fl, false, inv.handle, inv.sc, args);

What's the odds you check the input values here...  :(

> +static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
> +				 unsigned long arg)
> +{
> +	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
> +	char __user *argp = (char __user *)arg;
> +	int err;
> +
> +	switch (cmd) {
> +	case FASTRPC_IOCTL_INVOKE:
> +		err = fastrpc_invoke(fl, argp);
> +		break;
> +	default:
> +		err = -ENOTTY;
> +		dev_err(fl->sctx->dev, "bad ioctl: %d\n", cmd);

Don't spam the syslog if someone sends you an invalid ioctl.  That's a
sure way to DoS the system.

> +		break;
> +	}
> +
> +	if (err)
> +		dev_dbg(fl->sctx->dev, "Error: IOCTL Failed with %d\n", err);
> +
> +	return err;
> +}
> +
>  static const struct file_operations fastrpc_fops = {
>  	.open = fastrpc_device_open,
>  	.release = fastrpc_device_release,
> +	.unlocked_ioctl = fastrpc_device_ioctl,
> +	.compat_ioctl = fastrpc_device_ioctl,
>  };
>  
>  static int fastrpc_cb_probe(struct platform_device *pdev)
> @@ -260,9 +932,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
>  }
>  
> +static void fastrpc_notify_users(struct fastrpc_user *user)
> +{
> +	struct fastrpc_invoke_ctx *ctx, *n;
> +
> +	spin_lock(&user->lock);
> +	list_for_each_entry_safe(ctx, n, &user->pending, node)
> +		complete(&ctx->work);

Why safe?  You aren't deleting the list here.

> +	spin_unlock(&user->lock);
> +}
> +
>  static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  {
>  	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
> +	struct fastrpc_user *user, *n;
> +
> +	spin_lock(&cctx->lock);
> +	list_for_each_entry_safe(user, n, &cctx->users, user)
> +		fastrpc_notify_users(user);

Same here.

> +	spin_unlock(&cctx->lock);
>  
>  	misc_deregister(&cctx->miscdev);
>  	of_platform_depopulate(&rpdev->dev);
> @@ -272,6 +960,31 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  				  int len, void *priv, u32 addr)
>  {
> +	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
> +	struct fastrpc_invoke_rsp *rsp = data;
> +	struct fastrpc_invoke_ctx *ctx;
> +	unsigned long flags;
> +	unsigned long ctxid;
> +
> +	if (len < sizeof(*rsp)) {
> +		dev_err(&rpdev->dev, "invalid response or context\n");
> +		return -EINVAL;
> +	}

Again, don't allow userspace to spam the syslog.

> +
> +	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
> +
> +	spin_lock_irqsave(&cctx->lock, flags);
> +	ctx = idr_find(&cctx->ctx_idr, ctxid);
> +	spin_unlock_irqrestore(&cctx->lock, flags);
> +
> +	if (!ctx) {
> +		dev_err(&rpdev->dev, "No context ID matches response\n");
> +		return -ENOENT;
> +	}
> +
> +	ctx->retval = rsp->retval;
> +	complete(&ctx->work);
> +
>  	return 0;
>  }
>  
> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
> new file mode 100644
> index 000000000000..a69ef33dc37e
> --- /dev/null
> +++ b/include/uapi/misc/fastrpc.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __QCOM_FASTRPC_H__
> +#define __QCOM_FASTRPC_H__
> +
> +#include <linux/types.h>
> +
> +#define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
> +
> +struct fastrpc_invoke_args {
> +	__u64 ptr;
> +	__u64 length;
> +	__s32 fd;
> +	__u32 reserved;

Are you checking that reserved is all 0 now?

> +};
> +
> +struct fastrpc_invoke {
> +	__u32 handle;
> +	__u32 sc;
> +	__u64 args;
> +};

Do you need packed here?  What about endian issues?

thanks,

greg k-h
