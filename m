Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3DBC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B3220834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cm1VpG9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B3220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJYT12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:27:28 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52043 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeJYT11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:27:27 -0400
Received: by mail-it1-f196.google.com with SMTP id 74-v6so1107346itw.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=91RvJe7/alk299YZMUdYP/OE9E9RDgjMc8GG+uqBQK4=;
        b=cm1VpG9Te0JOzgnik2PNiLNh08XmBAUasxwDy9DHogArURJ+sNvamWnci4xVh0h6q7
         e8HIPE6GcF0MwLePC5KAjUAp6FIbXzv/dsE0HNAPoLalx6w8gEyOFOE8cqgmtD8zYLcY
         Gihnj6H8GfjOpEfaFb6KMJSZPJPzXyY8XuTX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=91RvJe7/alk299YZMUdYP/OE9E9RDgjMc8GG+uqBQK4=;
        b=iVqf6PJqJ0eF6hIh8arvj74MRTeR0oVSTiyuQhNR15A4UoeJcq8rK9fF0hdMGng6a9
         m5tJ4TkaruJbi2Lfrdig0Q2nC6/UIWr28L5IOHrVgnAVe/qxbXCNamWk26tOp3KA8UXc
         I1HSz+pohMNtXzH9f59w6C/4r+exMr0mIqzpjvg619sC/bBjcvuTWNBDYMmqtvHt8APx
         nzMHOqMXHbTlB/eEcWFm4Cq1AzjuCQQItLulJph0wNx0oGenx+XNXF65Sl7cmTFY4Vm5
         BVuXjBEZ8YPpFthecFl4rmYEgV8M+0foMvwAFQZCxvk7LgPLyzWl0Ta6T8nAHOeORg1T
         Fxiw==
X-Gm-Message-State: AGRZ1gI6NHfVP8B5Ej5rAt06vXhh8wXMtaD9I7Q9C2+3uJp+4slHxfzo
        +kMQN60h9Y3uxFqXDTkl9QZb5YFFMkNIDRtvwwGYpii4
X-Google-Smtp-Source: AJdET5fDMS0hNiX55vQOwK+di0tRrSwJgiLoM0h1Rkyy7M7Gw2+Z9Ki9z3IX9FqogN3CZdFqRTobO7PZNkvgMVvVq6k=
X-Received: by 2002:a24:47c5:: with SMTP id t188-v6mr583344itb.78.1540464913228;
 Thu, 25 Oct 2018 03:55:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 03:54:32
 -0700 (PDT)
In-Reply-To: <d5f993001c97895d82bb68e246f6eaafce6dc795.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org> <d5f993001c97895d82bb68e246f6eaafce6dc795.1540446493.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Oct 2018 12:54:32 +0200
Message-ID: <CAPDyKFqb0kuZdpBeV2Uktd0gDXAg+v2p=a1vuRowj7f2zk1NOA@mail.gmail.com>
Subject: Re: [PATCH V3 01/10] PM / Domains: Rename genpd virtual devices as virt_dev
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 October 2018 at 07:52, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> There are several struct device instances that genpd core handles. The
> most common one is the consumer device structure, which is named
> (correctly) as "dev" within genpd core. The second one is the genpd's
> device structure, referenced as genpd->dev. The third one is the virtual
> device structures created by the genpd core to represent the consumer
> device for multiple power domain case, currently named as genpd_dev. The
> naming of these virtual devices isn't very clear or readable and it
> looks more like the genpd->dev.
>
> Rename the virtual device instances within the genpd core as "virt_dev".
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, this make the code more clear!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7f38a92b444a..fe9b0527b161 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2338,7 +2338,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>                                          unsigned int index)
>  {
> -       struct device *genpd_dev;
> +       struct device *virt_dev;
>         int num_domains;
>         int ret;
>
> @@ -2352,31 +2352,31 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>                 return NULL;
>
>         /* Allocate and register device on the genpd bus. */
> -       genpd_dev = kzalloc(sizeof(*genpd_dev), GFP_KERNEL);
> -       if (!genpd_dev)
> +       virt_dev = kzalloc(sizeof(*virt_dev), GFP_KERNEL);
> +       if (!virt_dev)
>                 return ERR_PTR(-ENOMEM);
>
> -       dev_set_name(genpd_dev, "genpd:%u:%s", index, dev_name(dev));
> -       genpd_dev->bus = &genpd_bus_type;
> -       genpd_dev->release = genpd_release_dev;
> +       dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
> +       virt_dev->bus = &genpd_bus_type;
> +       virt_dev->release = genpd_release_dev;
>
> -       ret = device_register(genpd_dev);
> +       ret = device_register(virt_dev);
>         if (ret) {
> -               kfree(genpd_dev);
> +               kfree(virt_dev);
>                 return ERR_PTR(ret);
>         }
>
>         /* Try to attach the device to the PM domain at the specified index. */
> -       ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index, false);
> +       ret = __genpd_dev_pm_attach(virt_dev, dev->of_node, index, false);
>         if (ret < 1) {
> -               device_unregister(genpd_dev);
> +               device_unregister(virt_dev);
>                 return ret ? ERR_PTR(ret) : NULL;
>         }
>
> -       pm_runtime_enable(genpd_dev);
> -       genpd_queue_power_off_work(dev_to_genpd(genpd_dev));
> +       pm_runtime_enable(virt_dev);
> +       genpd_queue_power_off_work(dev_to_genpd(virt_dev));
>
> -       return genpd_dev;
> +       return virt_dev;
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
>
> --
> 2.19.1.568.g152ad8e3369a
>
