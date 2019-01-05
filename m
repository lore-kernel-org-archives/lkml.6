Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0085CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D9920874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546647927;
	bh=qsP+Llq3C8/U6fIc4Q5I6w4U4eUiSh7tO0xFNhqB4P4=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=qJcBxQmmJw3kSn5KquA2hOs/GCfyGqQWL9Oo9DeCEGz6K269naFgT+q7/G0amy0uE
	 rKXHWPRX7y/0QZPBbavk5qxSJgE6JY1E+WRPJaB6m/bSj/5tn8wytfp/ySJsXsduxz
	 rb/AYzCTGvFs0UvbdyqrWpWK5apnfailG00vCZbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfAEAZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAEAZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:25:26 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD1F120874;
        Sat,  5 Jan 2019 00:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546647924;
        bh=qsP+Llq3C8/U6fIc4Q5I6w4U4eUiSh7tO0xFNhqB4P4=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=RwB0CvbjO2RUKlaa/HxDWYTIoHPROxnJYs2GYzT9tpUG2TXI4rhqxCrgSBGZ4F+mE
         Pi3BRtTEuAOccMPmImJqMn+eUr9mK9/iA54E8N64CZeRfm/Yw8CmzyHr2lsGHcz1e9
         A7JsIrA5vKr0peRuS9YBsrJcJo1/2LEFsKD/L3Pk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical IRQ chips
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
In-Reply-To: <20181229114755.8711-2-masneyb@onstation.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181229114755.8711-1-masneyb@onstation.org> <20181229114755.8711-2-masneyb@onstation.org>
Message-ID: <154664792383.15366.9346249356552958882@swboyd.mtv.corp.google.com>
Date:   Fri, 04 Jan 2019 16:25:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2018-12-29 03:47:53)
> Convert the spmi-pmic-arb IRQ code to use the version 2 IRQ interface
> in order to support hierarchical IRQ chips. Code was tested on a LG
> Nexus 5 (hammerhead) phone.

Can you add the motivation for this change here? Why should we care?

>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/spmi/spmi-pmic-arb.c | 91 +++++++++++++++++++++++++-----------
>  1 file changed, 64 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 360b8218f322..c651d19f0623 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -666,7 +666,8 @@ static int qpnpint_get_irqchip_state(struct irq_data =
*d,
>         return 0;
>  }
> =20
> -static int qpnpint_irq_request_resources(struct irq_data *d)
> +static int qpnpint_irq_domain_activate(struct irq_domain *domain,
> +                                      struct irq_data *d, bool reserve)
>  {
>         struct spmi_pmic_arb *pmic_arb =3D irq_data_get_irq_chip_data(d);
>         u16 periph =3D hwirq_to_per(d->hwirq);
> @@ -692,36 +693,37 @@ static struct irq_chip pmic_arb_irqchip =3D {
>         .irq_set_type   =3D qpnpint_irq_set_type,
>         .irq_set_wake   =3D qpnpint_irq_set_wake,
>         .irq_get_irqchip_state  =3D qpnpint_get_irqchip_state,
> -       .irq_request_resources =3D qpnpint_irq_request_resources,
>         .flags          =3D IRQCHIP_MASK_ON_SUSPEND,
>  };
> =20
> -static int qpnpint_irq_domain_dt_translate(struct irq_domain *d,
> -                                          struct device_node *controller,
> -                                          const u32 *intspec,
> -                                          unsigned int intsize,
> -                                          unsigned long *out_hwirq,
> -                                          unsigned int *out_type)
> +static int qpnpint_irq_domain_translate(struct irq_domain *d,
> +                                       struct irq_fwspec *fwspec,
> +                                       unsigned long *out_hwirq,
> +                                       unsigned int *out_type)
>  {
>         struct spmi_pmic_arb *pmic_arb =3D d->host_data;
>         u16 apid, ppid;
>         int rc;
> =20
> -       dev_dbg(&pmic_arb->spmic->dev, "intspec[0] 0x%1x intspec[1] 0x%02=
x intspec[2] 0x%02x\n",
> -               intspec[0], intspec[1], intspec[2]);
> +       dev_dbg(&pmic_arb->spmic->dev,
> +               "param[0] 0x%1x param[1] 0x%02x param[2] 0x%02x\n",
> +               fwspec->param[0], fwspec->param[1], fwspec->param[2]);
> =20
> -       if (irq_domain_get_of_node(d) !=3D controller)
> +       if (irq_domain_get_of_node(d) !=3D pmic_arb->spmic->dev.of_node)
>                 return -EINVAL;
> -       if (intsize !=3D 4)
> +       if (fwspec->param_count !=3D 4)
>                 return -EINVAL;
> -       if (intspec[0] > 0xF || intspec[1] > 0xFF || intspec[2] > 0x7)
> +       if (fwspec->param[0] > 0xF || fwspec->param[1] > 0xFF ||
> +           fwspec->param[2] > 0x7)
>                 return -EINVAL;
> =20
> -       ppid =3D intspec[0] << 8 | intspec[1];
> +       ppid =3D fwspec->param[0] << 8 | fwspec->param[1];
>         rc =3D pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
>         if (rc < 0) {
> -               dev_err(&pmic_arb->spmic->dev, "failed to xlate sid =3D %=
#x, periph =3D %#x, irq =3D %u rc =3D %d\n",
> -               intspec[0], intspec[1], intspec[2], rc);
> +               dev_err(&pmic_arb->spmic->dev,
> +                       "failed to xlate sid =3D %#x, periph =3D %#x, irq=
 =3D %u rc =3D %d\n",
> +                       fwspec->param[0], fwspec->param[1], fwspec->param=
[2],

Why not assign a u32 *intspec to fwspec->param and then not change many
lines in this function? Reducing the diff is useful to avoid glossing
over some mistake in variable renames.

> +                       rc);
>                 return rc;
>         }
> =20
> @@ -732,25 +734,58 @@ static int qpnpint_irq_domain_dt_translate(struct i=
rq_domain *d,
>         if (apid < pmic_arb->min_apid)
>                 pmic_arb->min_apid =3D apid;
> =20
> -       *out_hwirq =3D spec_to_hwirq(intspec[0], intspec[1], intspec[2], =
apid);
> -       *out_type  =3D intspec[3] & IRQ_TYPE_SENSE_MASK;
> +       *out_hwirq =3D spec_to_hwirq(fwspec->param[0], fwspec->param[1],
> +                                  fwspec->param[2], apid);
> +       *out_type  =3D fwspec->param[3] & IRQ_TYPE_SENSE_MASK;
> =20
>         dev_dbg(&pmic_arb->spmic->dev, "out_hwirq =3D %lu\n", *out_hwirq);
> =20
>         return 0;
>  }
> =20
> -static int qpnpint_irq_domain_map(struct irq_domain *d,
> -                                 unsigned int virq,
> -                                 irq_hw_number_t hwirq)
> +
> +static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
> +                                  struct irq_domain *domain, unsigned in=
t virq,
> +                                  irq_hw_number_t hwirq)
>  {
> -       struct spmi_pmic_arb *pmic_arb =3D d->host_data;
> +       unsigned int old_virq;
> =20
>         dev_dbg(&pmic_arb->spmic->dev, "virq =3D %u, hwirq =3D %lu\n", vi=
rq, hwirq);
> =20
> -       irq_set_chip_and_handler(virq, &pmic_arb_irqchip, handle_level_ir=
q);
> -       irq_set_chip_data(virq, d->host_data);
> -       irq_set_noprobe(virq);
> +       /*
> +        * Check to see if the hwirq is already associated with another v=
irq on
> +        * this IRQ domain. If so, then disassociate it before associatin=
g the
> +        * hwirq with the new virq. IRQs are all initially setup without =
an IRQ
> +        * hierarchy when this driver is probed and when mfd/qcom-spmi-pm=
ic.c is
> +        * probed. Later in the boot process, an IRQ hierarchy is request=
ed by
> +        * pinctrl-spmi-gpio.c, and the same hwirq is now associated with=
 a new
> +        * virq.

Is that because we count the irqs in the pmic gpio driver? It looks like
we should remove that code from the driver then and use the compatible
string to figure out how many gpios are present. It will make this
comment and disassociate code unnecessary, but unfortunately it will
mean we have to add all the compatible strings to the pmic gpio driver
just so we know how many gpios are there.

> +        */
> +       old_virq =3D irq_find_mapping(domain, hwirq);
> +       if (old_virq)
> +               irq_domain_disassociate(domain, old_virq);
> +
> +       irq_domain_set_info(domain, virq, hwirq, &pmic_arb_irqchip, pmic_=
arb,
> +                           handle_level_irq, NULL, NULL);
> +}
> +
> +static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
> +                                   unsigned int virq, unsigned int nr_ir=
qs,
> +                                   void *data)
> +{
> +       struct spmi_pmic_arb *pmic_arb =3D domain->host_data;
> +       struct irq_fwspec *fwspec =3D data;
> +       irq_hw_number_t hwirq;
> +       unsigned int type;
> +       int ret, i;
> +
> +       ret =3D qpnpint_irq_domain_translate(domain, fwspec, &hwirq, &typ=
e);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < nr_irqs; i++)
> +               qpnpint_irq_domain_map(pmic_arb, domain, virq + i, hwirq =
+ i);
> +
>         return 0;
>  }
> =20

Otherwise patch looks good to me. Thanks for working on this. Are you
going to convert the ssbi master and gpio chip too?

