Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDEDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A5C2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546898146;
	bh=gEvBrye+lMOTBpKp8oW5/Glq2fltd3QplQrEoL8Ojak=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=GcwgLBHpO8Qurw/9yiNtlxHurmaFUHHaC3GpsrZ15BhsoJAfSrVW9HErzJXIgFDNU
	 nDUh8rAKAoy++ImyLph2rg+awt6J2gO6UOKcpZRJa8NgyXnneqWUvU0qy9X+CD2oVI
	 XfyDr3a/Wg5XzJTXwVg7izHkiHe9jACJVQZTi2Ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfAGVzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfAGVzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:55:45 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997602089F;
        Mon,  7 Jan 2019 21:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546898143;
        bh=gEvBrye+lMOTBpKp8oW5/Glq2fltd3QplQrEoL8Ojak=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=0RdK3SOmKSaSfGHHc3O32kfQEMYb+PPEBVmTVQxIUPUiAdGjVQ9R9gJz8ZztdTv/m
         TSt4FSGQoIWSUw6UuHhV859C3QLHj7PV7fbTo/d3tvWSHeejfzvu5n9NniMoKAtxp6
         Q8NHNWGYLYjI+ORtJFd12TLA955NrXTzG1fCpqAc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/5] qcom: spmi-gpio: add support for hierarchical IRQ chip
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
In-Reply-To: <20190107021145.6370-5-masneyb@onstation.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20190107021145.6370-1-masneyb@onstation.org> <20190107021145.6370-5-masneyb@onstation.org>
Message-ID: <154689814280.15366.2705028033847856491@swboyd.mtv.corp.google.com>
Date:   Mon, 07 Jan 2019 13:55:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-06 18:11:44)
> @@ -762,11 +763,14 @@ static int pmic_gpio_of_xlate(struct gpio_chip *chi=
p,
>  static int pmic_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
>  {
>         struct pmic_gpio_state *state =3D gpiochip_get_data(chip);
> -       struct pmic_gpio_pad *pad;
> +       struct irq_fwspec fwspec;
> =20
> -       pad =3D state->ctrl->desc->pins[pin].drv_data;
> +       fwspec.fwnode =3D state->fwnode;
> +       fwspec.param_count =3D 2;
> +       fwspec.param[0] =3D pin + 1;

There seems to be PMIC_GPIO_PHYSICAL_OFFSET for these purposes.

> +       fwspec.param[1] =3D IRQ_TYPE_NONE;
> =20
> -       return pad->irq;
> +       return irq_create_fwspec_mapping(&fwspec);
>  }
> =20
>  static void pmic_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chi=
p)
> @@ -936,6 +940,86 @@ static int pmic_gpio_populate(struct pmic_gpio_state=
 *state,
>         return 0;
>  }
> =20
> +static struct irq_chip pmic_gpio_irq_chip =3D {
> +       .name =3D "spmi-gpio",
> +       .irq_ack =3D irq_chip_ack_parent,
> +       .irq_mask =3D irq_chip_mask_parent,
> +       .irq_unmask =3D irq_chip_unmask_parent,
> +       .irq_set_type =3D irq_chip_set_type_parent,
> +       .irq_set_wake =3D irq_chip_set_wake_parent,
> +       .flags =3D IRQCHIP_MASK_ON_SUSPEND,
> +};
> +
> +static int pmic_gpio_irq_activate(struct irq_domain *domain,
> +                                 struct irq_data *data, bool reserve)
> +{
> +       struct pmic_gpio_state *state =3D domain->host_data;
> +
> +       return gpiochip_lock_as_irq(&state->chip, data->hwirq);
> +}
> +
> +static void pmic_gpio_irq_deactivate(struct irq_domain *domain,
> +                                    struct irq_data *data)
> +{
> +       struct pmic_gpio_state *state =3D domain->host_data;
> +
> +       gpiochip_unlock_as_irq(&state->chip, data->hwirq);
> +}

I meant these sorts of wrappers that could be used by other drivers
possibly, if all they need to store in their domain->host_data is the
gpiochip structure (they can probably indirect through the gpiochip
again to get their driver specific structure).

int gpiochip_irq_domain_activate(struct irq_domain *domain,
				 struct irq_data *data, bool reserve)
{
	struct gpiochip *chip =3D domain->host_data;

	return gpiochip_lock_as_irq(chip, data->hwirq);
}

void gpiochip_irq_domain_deactivate(struct irq_domain *domain,
				    struct irq_data *data)
{
	struct gpiochip *chip =3D domain->host_data;

	return gpiochip_unlock_as_irq(chip, data->hwirq);
}

> +
> +static int pmic_gpio_domain_translate(struct irq_domain *domain,
> +                                     struct irq_fwspec *fwspec,
> +                                     unsigned long *hwirq,
> +                                     unsigned int *type)
> +{
> +       struct pmic_gpio_state *state =3D domain->host_data;
> +
> +       if (fwspec->param_count !=3D 2 || fwspec->param[0] >=3D state->ch=
ip.ngpio)
> +               return -EINVAL;
> +
> +       *hwirq =3D fwspec->param[0] - 1;

There seems to be PMIC_GPIO_PHYSICAL_OFFSET for these purposes.

> +       *type =3D fwspec->param[1];
> +
> +       return 0;
> +}
> +
> +static int pmic_gpio_domain_alloc(struct irq_domain *domain, unsigned in=
t virq,
> +                                 unsigned int nr_irqs, void *data)
> +{
> +       struct pmic_gpio_state *state =3D domain->host_data;
> +       struct irq_fwspec *fwspec =3D data;
> +       struct irq_fwspec parent_fwspec;
> +       irq_hw_number_t hwirq;
> +       unsigned int type;
> +       int ret, i;
> +
> +       ret =3D pmic_gpio_domain_translate(domain, fwspec, &hwirq, &type);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < nr_irqs; i++)
> +               irq_domain_set_info(domain, virq + i, hwirq + i,
> +                                   &pmic_gpio_irq_chip, state,
> +                                   handle_level_irq, NULL, NULL);
> +
> +       parent_fwspec.fwnode =3D domain->parent->fwnode;
> +       parent_fwspec.param_count =3D 4;
> +       parent_fwspec.param[0] =3D 0;
> +       parent_fwspec.param[1] =3D fwspec->param[0] + 0xc0 - 1;

Is the -1 there twice, once in pmic_gpio_domain_translate() and then
here?

> +       parent_fwspec.param[2] =3D 0;
> +       parent_fwspec.param[3] =3D fwspec->param[1];
> +
> +       return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> +                                           &parent_fwspec);
> +}
> +
