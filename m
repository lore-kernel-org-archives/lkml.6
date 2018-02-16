Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeBPJmK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:42:10 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35412 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeBPJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:42:09 -0500
X-Google-Smtp-Source: AH8x224ZdHf3eJ08S+09n3sNS0skLy64Sh7JnIZIOw4JgbzvGK2hKB0ZipOWp/PvtisaudxXoNOPk6wqAC+r5QlfTjo=
MIME-Version: 1.0
In-Reply-To: <20180209161456.18951-1-tony@atomide.com>
References: <20180209161456.18951-1-tony@atomide.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Feb 2018 10:42:07 +0100
X-Google-Sender-Auth: N5_iyIBexTzQgzH0qdWPrd8cGIQ
Message-ID: <CAJZ5v0iF0M+X5vujyaKmXrEWpBEceQ=PX6bhgcwFf8P-q7Cu-Q@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 5:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> This makes it easy to grep :wakeup /proc/interrupts.
>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Suggested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/base/power/power.h   |  1 +
>  drivers/base/power/wakeirq.c | 18 +++++++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -31,6 +31,7 @@ struct wake_irq {
>         struct device *dev;
>         unsigned int status;
>         int irq;
> +       char *name;
>  };
>
>  extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -112,6 +112,7 @@ void dev_pm_clear_wake_irq(struct device *dev)
>                 free_irq(wirq->irq, wirq);
>                 wirq->status &= ~WAKE_IRQ_DEDICATED_MASK;
>         }
> +       kfree(wirq->name);
>         kfree(wirq);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
> @@ -175,7 +176,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
>  int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>  {
>         struct wake_irq *wirq;
> -       int err;
> +       int err, namelen;
> +       const char *postfix = ":wakeup";
>
>         if (irq < 0)
>                 return -EINVAL;
> @@ -184,6 +186,14 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>         if (!wirq)
>                 return -ENOMEM;
>
> +       namelen = strlen(dev_name(dev)) + strlen(postfix) + 1;
> +       wirq->name = kzalloc(namelen, GFP_KERNEL);
> +       if (!wirq->name) {
> +               err = -ENOMEM;
> +               goto err_free;
> +       }
> +
> +       snprintf(wirq->name, namelen, "%s%s", dev_name(dev), postfix);

As Andy said you can do

wirq->name = kasprintf(GFP_KERNEL, "%s:wakeup", dev_name(dev));
if (!wirq->name) {
        err = -ENOMEM;
        goto err_free;
}

here and it will allocate the buffer for you.
