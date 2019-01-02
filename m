Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F97C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499EB218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8NnlhuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbfABJa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:30:29 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34909 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbfABJa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:30:28 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so38091162itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 01:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5Ke8eYw+zh7CxllxjV9oNaftn96IKy9eV7VpLHXus8=;
        b=e8NnlhuOm8aS5O800aQgKlv0RmA7YZSTWV/v6OZ3gCrKw5uDBVRTPw8MECqe1GRj8S
         w6gT7p5g+PQETnrEuUMVTlK1IDYm8RqQHbMuNb9W0xkdhxc0RfuhxflboNZSwuKMsn8o
         Px9ipA9g7bKaIX5NXP1eecDfnTpaBWzHvcwiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5Ke8eYw+zh7CxllxjV9oNaftn96IKy9eV7VpLHXus8=;
        b=RzOn4qMoN3Cx7/Hyspctxp4EE6N1cgSCMx3MKRi2H1nB61d52WGvk49szD+D7BjuRW
         wKOaMldFE6FdQ/Adnsnb7uG7xfY8EIHYLFE0AEy7QDh0F1jfctjEA7iwFqmZDihIJ8Zq
         /AwPSMxKoOJgeoNk4etDAjnrD6FEW/FN1b96bsQxlSvFXX8K9Xt9YzlNPJ1yVGhB/9/N
         IJtOJMIxORr6Po+bBuiGr+5fjheAf2qCzvGJJcOPCKLmz/fk9y/ShVhrgl8trfVkLy5r
         u8ObnBu0yfnUCkCpP4Yh44Fr4B4Yb9nve8wzk9ebs/lsH4SqthYQyI4mzp2xNwON5jS6
         NR+g==
X-Gm-Message-State: AA+aEWbJoWUR593wYxJjjWp5mukKqIhYkK/t4p4w7qqnHtA6lmMEX8aG
        ol2Ean2Bi3oRd16tRe5ODzmecK8nzwaCHk+WpMM1cw==
X-Google-Smtp-Source: AFSGD/XTIBkJqwR2vMJb6NDDdIRbpvGocUV92xfrEu+o99b80gpuI2A4zV7z2Ub5RvFKFI1HTSGLkO1UpMvXuOPeUgc=
X-Received: by 2002:a24:784a:: with SMTP id p71mr31280975itc.158.1546421427351;
 Wed, 02 Jan 2019 01:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20181227190122.23149-1-ard.biesheuvel@linaro.org> <20181227190122.23149-2-ard.biesheuvel@linaro.org>
In-Reply-To: <20181227190122.23149-2-ard.biesheuvel@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 2 Jan 2019 10:30:16 +0100
Message-ID: <CAHUa44GNhkbsM6RuVdsc3=BU0xtD8iCzrz+7p-AN2Due_w8BGA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] optee: model OP-TEE as a platform device/driver
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard and Arnd,

On Thu, Dec 27, 2018 at 8:01 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> To simplify adding ACPI support to the OP-TEE driver, model it as
> a platform driver. This will permit us to use the generic device
> property layer for parsing additional properties, regardless of
> whether DT or ACPI is being used.
>
> Note that this change will result in the OP-TEE driver to be loaded
> automatically on systems that advertise the presence of OP-TEE via
> the device tree.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/tee/optee/core.c | 86 ++++++++------------
>  1 file changed, 32 insertions(+), 54 deletions(-)

In the earlier postings of the TEE subsystem (v8) the OP-TEE device
was based on a platform device. Arnd didn't like this back then so it
was dropped. The situation has changed a bit now. A platform device
will make it easier to add ACPI support. Arnd, what do you think?

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index e1aafe842d66..61ea65cfaedd 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -529,13 +529,13 @@ static void optee_smccc_hvc(unsigned long a0, unsigned long a1,
>         arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
>  }
>
> -static optee_invoke_fn *get_invoke_func(struct device_node *np)
> +static optee_invoke_fn *get_invoke_func(struct device *dev)
>  {
>         const char *method;
>
> -       pr_info("probing for conduit method from DT.\n");
> +       pr_info("probing for conduit method.\n");
>
> -       if (of_property_read_string(np, "method", &method)) {
> +       if (device_property_read_string(dev, "method", &method)) {
>                 pr_warn("missing \"method\" property\n");
>                 return ERR_PTR(-ENXIO);
>         }
> @@ -549,7 +549,7 @@ static optee_invoke_fn *get_invoke_func(struct device_node *np)
>         return ERR_PTR(-EINVAL);
>  }
>
> -static struct optee *optee_probe(struct device_node *np)
> +static int optee_probe(struct platform_device *pdev)
>  {
>         optee_invoke_fn *invoke_fn;
>         struct tee_shm_pool *pool;
> @@ -559,25 +559,25 @@ static struct optee *optee_probe(struct device_node *np)
>         u32 sec_caps;
>         int rc;
>
> -       invoke_fn = get_invoke_func(np);
> +       invoke_fn = get_invoke_func(&pdev->dev);
>         if (IS_ERR(invoke_fn))
> -               return (void *)invoke_fn;
> +               return PTR_ERR(invoke_fn);
>
>         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
>                 pr_warn("api uid mismatch\n");
> -               return ERR_PTR(-EINVAL);
> +               return -EINVAL;
>         }
>
>         optee_msg_get_os_revision(invoke_fn);
>
>         if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
>                 pr_warn("api revision mismatch\n");
> -               return ERR_PTR(-EINVAL);
> +               return -EINVAL;
>         }
>
>         if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps)) {
>                 pr_warn("capabilities mismatch\n");
> -               return ERR_PTR(-EINVAL);
> +               return -EINVAL;
>         }
>
>         /*
> @@ -585,11 +585,11 @@ static struct optee *optee_probe(struct device_node *np)
>          * doesn't have any reserved memory we can use we can't continue.
>          */
>         if (!(sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
> -               return ERR_PTR(-EINVAL);
> +               return -EINVAL;
>
>         pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm, sec_caps);
>         if (IS_ERR(pool))
> -               return (void *)pool;
> +               return PTR_ERR(pool);
>
>         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
>         if (!optee) {
> @@ -600,6 +600,8 @@ static struct optee *optee_probe(struct device_node *np)
>         optee->invoke_fn = invoke_fn;
>         optee->sec_caps = sec_caps;
>
> +       platform_set_drvdata(pdev, optee);
> +
>         teedev = tee_device_alloc(&optee_desc, NULL, pool, optee);
>         if (IS_ERR(teedev)) {
>                 rc = PTR_ERR(teedev);
> @@ -632,7 +634,7 @@ static struct optee *optee_probe(struct device_node *np)
>         optee_enable_shm_cache(optee);
>
>         pr_info("initialized driver\n");
> -       return optee;
> +       return 0;
>  err:
>         if (optee) {
>                 /*
> @@ -648,11 +650,13 @@ static struct optee *optee_probe(struct device_node *np)
>                 tee_shm_pool_free(pool);
>         if (memremaped_shm)
>                 memunmap(memremaped_shm);
> -       return ERR_PTR(rc);
> +       return rc;
>  }
>
> -static void optee_remove(struct optee *optee)
> +static int optee_remove(struct platform_device *pdev)
>  {
> +       struct optee *optee = platform_get_drvdata(pdev);
> +
>         /*
>          * Ask OP-TEE to free all cached shared memory objects to decrease
>          * reference counters and also avoid wild pointers in secure world
> @@ -675,51 +679,25 @@ static void optee_remove(struct optee *optee)
>         mutex_destroy(&optee->call_queue.mutex);
>
>         kfree(optee);
> +
> +       return 0;
>  }
>
> -static const struct of_device_id optee_match[] = {
> +static const struct of_device_id optee_dt_match[] = {
>         { .compatible = "linaro,optee-tz" },
>         {},
>  };
> -
> -static struct optee *optee_svc;
> -
> -static int __init optee_driver_init(void)
> -{
> -       struct device_node *fw_np;
> -       struct device_node *np;
> -       struct optee *optee;
> -
> -       /* Node is supposed to be below /firmware */
> -       fw_np = of_find_node_by_name(NULL, "firmware");
> -       if (!fw_np)
> -               return -ENODEV;
> -
> -       np = of_find_matching_node(fw_np, optee_match);
> -       if (!np)
> -               return -ENODEV;
> -
> -       optee = optee_probe(np);
> -       of_node_put(np);
> -
> -       if (IS_ERR(optee))
> -               return PTR_ERR(optee);
> -
> -       optee_svc = optee;
> -
> -       return 0;
> -}
> -module_init(optee_driver_init);
> -
> -static void __exit optee_driver_exit(void)
> -{
> -       struct optee *optee = optee_svc;
> -
> -       optee_svc = NULL;
> -       if (optee)
> -               optee_remove(optee);
> -}
> -module_exit(optee_driver_exit);
> +MODULE_DEVICE_TABLE(of, optee_dt_match);
> +
> +static struct platform_driver optee_driver = {
> +       .probe  = optee_probe,
> +       .remove = optee_remove,
> +       .driver = {
> +               .name = "optee",
> +               .of_match_table = optee_dt_match,
> +       },
> +};
> +module_platform_driver(optee_driver);
>
>  MODULE_AUTHOR("Linaro");
>  MODULE_DESCRIPTION("OP-TEE driver");
> --
> 2.19.2
>
