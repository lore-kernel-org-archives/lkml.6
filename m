Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4FBC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347A5218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qj+6EivJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfAXQTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:19:47 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51007 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfAXQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:19:44 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so5867386iti.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MfDhyDuR/Zb7WxDMUlVeIwcU+XD2G4F2gkmp10wb3k=;
        b=Qj+6EivJrL6iw+ZzBfb8QggWcOaCD0osehsHN8Rq7brAgt0gjIGZ8AoNEHXLicyVje
         TTazv5SE5uV5VJGM9kk0RPsaF5fGxv38rbbnbpX3WQEocNfuTIQ0TJfMcfzkKi8v3RN6
         Z3AXxIboNZjNZ9DfPC/4RiV89D0SuklPQDj78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MfDhyDuR/Zb7WxDMUlVeIwcU+XD2G4F2gkmp10wb3k=;
        b=HIAtujsRakCskaFXUFrudpKU9lxEe5X/1Q3Pclt33iwsjWKncqDWzzxjRnSLkb9G75
         71xm9Xc1+jz6Yd+1w2GQ5gkj3ij9uNGuiauLk2aYAJSmbMN6cxj8aMb4PIRtSd/NBEW5
         37+txQC7HtpppP9gEtGh+WAOxDe9OkZuZm5afVBBw3jVT52DzkT4Ud9XLLTcoYUBUAp+
         2TSR61JTqTfbNStq/b0cJDjQR29IFbX+Q0HmYNAG3sw/olLF3z9abFFKzRJiCpJJfK8P
         A8oza2yGWVrISgnGIQIF3MfwocghbwwHFwRKJ/VWBr8sbLlxh43Y8uGLs3ktr6blfyr+
         6WTw==
X-Gm-Message-State: AJcUukfQ57ZHxDbS5LrM/CLJEzI9+PtJHI+gpuTPiD8EFe+I8LHsD6XK
        8wFPhLKwEcn2sCMx0+B/y9oBOMoukKn50QWZg8k3ow==
X-Google-Smtp-Source: ALg8bN5Smg0K66IXfd7AMvp9R4ibd2MArN2BLsjUzitvvoKWhCXx1aILvqI3UNWfkGWUnPhLigVSdYBvfRsaGQfBPvo=
X-Received: by 2002:a24:874a:: with SMTP id f71mr1752492ite.120.1548346782796;
 Thu, 24 Jan 2019 08:19:42 -0800 (PST)
MIME-Version: 1.0
References: <1548335501-7868-1-git-send-email-igor.opaniuk@linaro.org>
In-Reply-To: <1548335501-7868-1-git-send-email-igor.opaniuk@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 24 Jan 2019 17:19:31 +0100
Message-ID: <CAHUa44Gar3JTzSNroJe2Ws_ZAHUC0bewubd8X2uKyssmghKd4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: add cancellation support to client interface
To:     Igor Opaniuk <igor.opaniuk@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 2:11 PM Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
>
> Add support of cancellation request to the TEE kernel internal
> client interface. Can be used by software TPM drivers, that leverage
> TEE under the hood (for instance in TPM2.0 mobile profile), for requesting
> cancellation of time-consuming operations (RSA key-pair generation etc.).
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
> ---
>  drivers/tee/tee_core.c  | 12 ++++++++++++
>  include/linux/tee_drv.h | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 7b2bb4c..aba71a8 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1027,6 +1027,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
>  }
>  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>
> +int tee_client_cancel_req(struct tee_context *ctx,
> +                         u32 cancel_id,
> +                         u32 session)
> +{
> +
> +       if (!ctx->teedev->desc->ops->cancel_req)
> +               return -EINVAL;
> +       return ctx->teedev->desc->ops->cancel_req(ctx, cancel_id,
> +                                                 session);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_cancel_req);
> +
>  static int __init tee_init(void)
>  {
>         int rc;
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 6cfe058..62a0b56 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -526,6 +526,20 @@ int tee_client_invoke_func(struct tee_context *ctx,
>                            struct tee_ioctl_invoke_arg *arg,
>                            struct tee_param *param);
>
> +/**
> + * tee_client_cancel_req() - Request cancellation of the previous open-session
> + * or invoke-command operations in a Trusted Application
> + * @ctx:       TEE Context
> + * @arg:       Unique cancel request id
> + * @param:     Session id

These need to be updated, see struct tee_ioctl_cancel_arg in
include/uapi/linux/tee.h

Thanks,
Jens

> + *
> + * Returns < 0 on error else see @arg->ret for result.
> + */
> +int tee_client_cancel_req(struct tee_context *ctx,
> +                         u32 cancel_id,
> +                         u32 session);
> +
> +
>  static inline bool tee_param_is_memref(struct tee_param *param)
>  {
>         switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
> --
> 2.7.4
>
