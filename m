Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A105CECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A6F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ih4pQnJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A6F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJYTlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:41:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39731 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeJYTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:41:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id p11-v6so6431712lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duKLKQnRkBZ0ojpGj9+M/BPo3ZbsI4zGe5/wO8u6Pxg=;
        b=Ih4pQnJExfEXA3bP1h/K007axxJoYKBfbegXnKEt9dpsISL/vssfVhqhXo+jnertny
         Bah8JwJmXh6VVNN2Aqn8ceJ/R05qBuaE+ydyjXN/SKMDApyw711u9lYLKbbK+t/ynGa5
         jnMns7jOs1oaaIY69B7xzCU+Fzds3UqmtwoRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duKLKQnRkBZ0ojpGj9+M/BPo3ZbsI4zGe5/wO8u6Pxg=;
        b=h8YHJA45Or+9mzRxppXCRvtONNpgw123/KvUiFxA4Hc7SFPH3H/X8iCmG0ScLexqiV
         2vveg9oImlYGk/Q9yyNk4Rp6z7pE8jERSNuqxApdE0xKWcF3jXKslHAxMy73eU3Pj5BT
         xUdfHLsbL0yFQxqIrJkbMC7H8tm4cLCeVKKdG+j0jlwxQlfWr1kBELFU2y0ALatG9a/C
         2i24jW8x7JndPXX1NGQ1Uq86jdOq8zV7Y9tfg6utriZn/1LroytHRqFQ0qYNN2eq5q/e
         rIByiD64ETol5QnwX9PglAUDFofFGp7NHQa8CQYDr1KRDyFvau/lsKrgVVkitReqKMAh
         VyWw==
X-Gm-Message-State: AGRZ1gJg5qf7r51DnKc1It6GG36s1tX7tr/O+K16ofE2adc3B1HhDv2M
        gj+prMpP48SuYpr0DSxWl4TVnk0tTX26sHamhnQbhw==
X-Google-Smtp-Source: AJdET5cf7jqKAZHeqWsCmBdnI++5HsurX8ol4chiREZI7XV93audK1WhfSYDhzyb4llFsRfZ/qi8kGrER4g1oHgN2rc=
X-Received: by 2002:a19:1549:: with SMTP id l70mr843031lfi.53.1540465729373;
 Thu, 25 Oct 2018 04:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181024142456.10084-1-svendev@arcx.com> <20181024142456.10084-4-svendev@arcx.com>
In-Reply-To: <20181024142456.10084-4-svendev@arcx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Oct 2018 13:08:35 +0200
Message-ID: <CACRpkdbtR7mi1VPhA6dpX05-gqDQABKGLRVV7-tmRYzDfP+SQg@mail.gmail.com>
Subject: Re: [PATCH anybus v1 3/4] bus: support HMS Anybus-S bus.
To:     svendev@arcx.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>, yuanzhichang@hisilicon.com,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        bogdan.purcareata@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

thanks for your patch!

On Wed, Oct 24, 2018 at 4:25 PM Sven Van Asbroeck <svendev@arcx.com> wrote:

> This driver implementation is designed to be almost completely independent
> from the way the Anybus-S hardware is accessed by the SoC. All it needs is:
>
> - a regmap which accesses the underlying Anybus-S dpram by whatever means;
> - an interrupt line, ultimately connected to the Anybus-S card;
> - a reset function.

Overall this commit message is a good start! You explain what this thing is
and what it does.

What you need to add is a bit of how the driver is architected. That can also
be added as comment in the header of the driver file, maybe that is even
better, i.e. here:

+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMS Anybus-S Host Driver

<architecture description goes here>

This is really needed because the driver is starting threads and
running completions and tasks and whatnot to the left and
right, and when random people come in to maintain this code they
will be puzzled. You need an overarching description of how the
driver is constructed here.

Please add proper kerneldoc to the struct anybus_host
also "buss" is a germanism isn't it?  It should be just "anybus"?

> +struct anybuss_host {
> +       struct device *dev;
> +       struct device *parent;
> +       struct anybuss_client *client;

There as well?

Just search/replace "s/buss/bus/g" everywhere I suspect.

> +static irqreturn_t irq_handler(int irq, void *data)
> +{
> +       struct anybuss_host *cd = data;
> +       int ind_ab;
> +
> +       /* reading the anybus indicator register acks the interrupt */
> +       ind_ab = read_ind_ab(cd->regmap);
> +       if (ind_ab < 0)
> +               return IRQ_NONE;
> +       atomic_set(&cd->ind_ab, ind_ab);
> +       complete(&cd->card_boot);
> +       wake_up(&cd->wq);
> +       return IRQ_HANDLED;
> +}

It looks a bit like you reinvent threaded interrupts but enlighten me
on the architecture and I might be able to get it.

> +static int task_fn_power_on_2(struct anybuss_host *cd,
> +                               struct ab_task *t)
> +{
> +       if (completion_done(&cd->card_boot)) {
> +               cd->power_on = true;
> +               return 0;
> +       }
> +       if (time_after(jiffies, t->start_jiffies + TIMEOUT)) {
> +               disable_irq(cd->irq);
> +               ab_reset(cd, true);
> +               dev_err(cd->dev, "power on timed out");
> +               return -ETIMEDOUT;
> +       }
> +       return -EINPROGRESS;
> +}
> +
> +static int task_fn_power_on(struct anybuss_host *cd,
> +                               struct ab_task *t)
> +{
> +       unsigned int dummy;
> +
> +       if (cd->power_on)
> +               return 0;
> +       /* anybus docs: prevent false 'init done' interrupt by
> +        * doing a dummy read of IND_AB register while in reset.
> +        */
> +       regmap_read(cd->regmap, REG_IND_AB, &dummy);
> +       reinit_completion(&cd->card_boot);
> +       enable_irq(cd->irq);
> +       ab_reset(cd, false);
> +       t->task_fn = task_fn_power_on_2;
> +       return -EINPROGRESS;
> +}

This looks complex. Why can't you just sleep() and then
retry this instead of shuffleing around different "tasks"?
Are you actually modeling a state machine? In that case
I can kind of understand it, then you just need one
thread/work and assign it an enum of states or
something, maybe name that "state" rather than task
so we see what is going on.

> +static int task_fn_area_3(struct anybuss_host *cd, struct ab_task *t)
> +static int task_fn_area_2(struct anybuss_host *cd, struct ab_task *t)
> +static int task_fn_area(struct anybuss_host *cd, struct ab_task *t)
> +static struct ab_task *
> +create_area_reader(struct kmem_cache *qcache, u16 flags, u16 addr,
> +                               size_t count)
> +static struct ab_task *
> +create_area_writer(struct kmem_cache *qcache, u16 flags, u16 addr,
> +                               const void *buf, size_t count)
> +static struct ab_task *
> +create_area_user_writer(struct kmem_cache *qcache, u16 flags, u16 addr,
> +                               const void __user *buf, size_t count)

So there are many different tasks going on.

Are they just created to get something going in process context?

> +static void softint_ack(struct anybuss_host *cd)
> +static void process_softint(struct anybuss_host *cd)

This looks like MSI (message signalled interrupt) and makes me think
that you should probably involve the irqchip maintainers. Interrupts
shall be represented in the irqchip abstraction.

> +int anybuss_client_driver_register(struct anybuss_client_driver *drv)
> +{
> +       drv->driver.bus = &anybus_bus;
> +       return driver_register(&drv->driver);
> +}

There is nice use of the bus abstractions here.

> +       cd->reset = pdata->reset;

This callback thing to handle reset doesn't seem right.

The kernel has a reset for assert/deassert och just assert()
reset handling that you can find in
drivers/reset/*

Maybe that is what you should be using instead of
rolling your own reset handling?

> +       cd->reset(parent, true);

So this would just be something like
#include <linux/reset.h>

r = devm_reset_control_get_exclusive(dev, id);
ret = reset_control_assert(r);

> +       regmap_bulk_read(cd->regmap, REG_SERIAL_NO, val, 4);
> +       dev_info(dev, "Serial number: %02X%02X%02X%02X",
> +               val[0], val[1], val[2], val[3]);

This looks like device-unique data so please do this:

#include <linux/random.h>

add_device_randomness(val, 4);

I guess I can provide better review once you add some
information on this task state machine business and how
it is engineered, looking forward to the next iteration!

Yours,
Linus Walleij
