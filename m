Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886DCC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516FE2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516FE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeLCSji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:39:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45327 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLCSjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:39:37 -0500
Received: by mail-oi1-f195.google.com with SMTP id b141so11840187oii.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6n/oxCL8XduT0iPyabgGeKYtciBEEj11+xCAlfZn8pA=;
        b=d0wSGfoQ+pRuZzVCSZ9Gz63tKfUD6yo5k9xQV9wVXZx1R606ekPoaZkKCcEiGbQT1O
         z7s6Gy2e7jdfYY537MViKh4tbFM2gf0TK5Ap6BHk7+dt4yUZPIYdRXpNOA34KlCV2OfW
         f03lCvWlwIweS2EvhAF7JQcDRY9MeUXD164zC/doT8G3EIKC0MNXbplmmyioXYtCezTn
         OMwF8suVEJU7kCpq1ActGCg9YHSOAjYGQWxRomj1BRLpfdDOwtUcPlW0aTvosx5bu2EB
         tU+De27hX1mqEL+pD985p9NvI5IImBoWhUpcVG4p84ozZBjoggmdy0lvrGJ9j/cimSuZ
         JHWg==
X-Gm-Message-State: AA+aEWb+QDSwj8CrReRZKwpcIpj1JEYlBSUKKaKeLdo1L4gvob83uoLb
        VujWqgaIxmTUeZoGhHNalbtoQgM/
X-Google-Smtp-Source: AFSGD/WM/BruO7lNSGoVo8Lk7s3gZKX/jcy789PHJwCzqWGUemWaeo4xBvIEhtl5D0W+TDYvTrxaQg==
X-Received: by 2002:aca:ac13:: with SMTP id v19mr10127469oie.160.1543862373063;
        Mon, 03 Dec 2018 10:39:33 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id b124sm7024426oia.35.2018.12.03.10.39.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:39:32 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id w13so11856702oiw.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:39:32 -0800 (PST)
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr11042322oia.154.1543862372213;
 Mon, 03 Dec 2018 10:39:32 -0800 (PST)
MIME-Version: 1.0
References: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com> <1541410219-9943-3-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1541410219-9943-3-git-send-email-ioana.ciornei@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 3 Dec 2018 12:39:21 -0600
X-Gmail-Original-Message-ID: <CADRPPNRiem+c2fK2RWyvopvre9ZBqT=6n8KxGJ1THtBpbA0d-Q@mail.gmail.com>
Message-ID: <CADRPPNRiem+c2fK2RWyvopvre9ZBqT=6n8KxGJ1THtBpbA0d-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: fsl: dpio: use a cpumask to identify which cpus
 are unused
To:     ioana.ciornei@nxp.com
Cc:     Roy Pledge <roy.pledge@nxp.com>, youri.querry_1@nxp.com,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 3:31 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> The current implementation of the dpio driver uses a static next_cpu
> variable to keep track of the index of the next cpu available. This
> approach does not handle well unbinding and binding dpio devices in a
> random order. For example, unbinding a dpio and then binding it again
> with the driver, will generate the below error:
>
> $ echo dpio.5 > /sys/bus/fsl-mc/drivers/fsl_mc_dpio/unbind
> $ echo dpio.5 > /sys/bus/fsl-mc/drivers/fsl_mc_dpio/bind
> [  103.946380] fsl_mc_dpio dpio.5: probe failed. Number of DPIOs exceeds
> NR_CPUS.
> [  103.955157] fsl_mc_dpio dpio.5: fsl_mc_driver_probe failed: -34
> -bash: echo: write error: No such device
>
> Fix this error by keeping a global cpumask of unused cpus that will be
> updated at every dpaa2_dpio_[probe,remove].
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------
>  drivers/soc/fsl/dpio/dpio-service.c |  6 ++++++
>  include/soc/fsl/dpaa2-io.h          |  2 ++
>  3 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index e58fcc9..832175c 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -30,6 +30,8 @@ struct dpio_priv {
>         struct dpaa2_io *io;
>  };
>
> +static cpumask_var_t cpus_unused_mask;
> +
>  static irqreturn_t dpio_irq_handler(int irq_num, void *arg)
>  {
>         struct device *dev = (struct device *)arg;
> @@ -86,7 +88,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>         struct dpio_priv *priv;
>         int err = -ENOMEM;
>         struct device *dev = &dpio_dev->dev;
> -       static int next_cpu = -1;
> +       int possible_next_cpu;
>
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -128,17 +130,14 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>         desc.dpio_id = dpio_dev->obj_desc.id;
>
>         /* get the cpu to use for the affinity hint */
> -       if (next_cpu == -1)
> -               next_cpu = cpumask_first(cpu_online_mask);
> -       else
> -               next_cpu = cpumask_next(next_cpu, cpu_online_mask);
> -
> -       if (!cpu_possible(next_cpu)) {
> +       possible_next_cpu = cpumask_first(cpus_unused_mask);
> +       if (possible_next_cpu >= nr_cpu_ids) {
>                 dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
>                 err = -ERANGE;
>                 goto err_allocate_irqs;
>         }
> -       desc.cpu = next_cpu;
> +       desc.cpu = possible_next_cpu;
> +       cpumask_clear_cpu(possible_next_cpu, cpus_unused_mask);
>
>         /*
>          * Set the CENA regs to be the cache inhibited area of the portal to
> @@ -211,7 +210,7 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
>  {
>         struct device *dev;
>         struct dpio_priv *priv;
> -       int err;
> +       int err = 0, cpu;
>
>         dev = &dpio_dev->dev;
>         priv = dev_get_drvdata(dev);
> @@ -220,6 +219,9 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
>
>         dpio_teardown_irqs(dpio_dev);
>
> +       cpu = dpaa2_io_get_cpu(priv->io);
> +       cpumask_set_cpu(cpu, cpus_unused_mask);
> +
>         err = fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
>         if (err) {
>                 dev_err(dev, "MC portal allocation failed\n");
> @@ -267,11 +269,16 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
>
>  static int dpio_driver_init(void)
>  {
> +       if (!zalloc_cpumask_var(&cpus_unused_mask, GFP_KERNEL))
> +               return -ENOMEM;
> +       cpumask_copy(cpus_unused_mask, cpu_online_mask);
> +
>         return fsl_mc_driver_register(&dpaa2_dpio_driver);
>  }
>
>  static void dpio_driver_exit(void)
>  {
> +       free_cpumask_var(cpus_unused_mask);
>         fsl_mc_driver_unregister(&dpaa2_dpio_driver);
>  }
>  module_init(dpio_driver_init);
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index 21c3e32..3198265 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -214,6 +214,12 @@ irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
>         return IRQ_HANDLED;
>  }
>
> +int dpaa2_io_get_cpu(struct dpaa2_io *d)
> +{
> +       return d->dpio_desc.cpu;
> +}
> +EXPORT_SYMBOL(dpaa2_io_get_cpu);

Although this function is very simple function and probably
self-explanatory, it is required that exported APIs have a kernel-doc
comment just like other functions in the file.

> +
>  /**
>   * dpaa2_io_service_register() - Prepare for servicing of FQDAN or CDAN
>   *                               notifications on the given DPIO service.
> diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
> index ab51e40..1c1764f 100644
> --- a/include/soc/fsl/dpaa2-io.h
> +++ b/include/soc/fsl/dpaa2-io.h
> @@ -90,6 +90,8 @@ struct dpaa2_io_notification_ctx {
>         void *dpio_private;
>  };
>
> +int dpaa2_io_get_cpu(struct dpaa2_io *d);
> +
>  int dpaa2_io_service_register(struct dpaa2_io *service,
>                               struct dpaa2_io_notification_ctx *ctx);
>  void dpaa2_io_service_deregister(struct dpaa2_io *service,
> --
> 1.9.1
>
