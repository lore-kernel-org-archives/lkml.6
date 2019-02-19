Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B0DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ECC217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="K4ioKesi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfBSPlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:41:36 -0500
Received: from mail-eopbgr1400109.outbound.protection.outlook.com ([40.107.140.109]:51630
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfBSPlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ+vNXzJ85UeZz8WzorGNF1VywZU8U/XuqC0xzWpNvw=;
 b=K4ioKesiFhjQ440HkgwK+wjsv+wf/iR0dpfXGAmy4OH9EzjxQYXp9N+71aRrGilWJMxTczNGtXlFLDJh2SrB7Ul4xM2TAEUwyIiW6M4nFWO99STxtWle2Gya08KL7s9aDIlb98ZZMrPqMAkEVkkfbbIPyJuW7jghVFBGOt+NCTs=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1577.jpnprd01.prod.outlook.com (52.133.162.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.17; Tue, 19 Feb 2019 15:41:29 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::4cc6:14ba:d8cd:4107]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::4cc6:14ba:d8cd:4107%2]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 15:41:29 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Topic: [PATCH v3 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Index: AQHUe1IlvyEF46yudE+txVssKQML5aXn2EqwgAADzgCAAAA+EA==
Date:   Tue, 19 Feb 2019 15:41:29 +0000
Message-ID: <TY1PR01MB17690D419F4BA84B4743D215F57C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181113130910.22130-1-phil.edworthy@renesas.com>
        <20181113130910.22130-3-phil.edworthy@renesas.com>
        <TY1PR01MB1769ECBED0DE9BCC39DF1FDCF57C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20190219153958.5cff032b@why.wild-wind.fr.eu.org>
In-Reply-To: <20190219153958.5cff032b@why.wild-wind.fr.eu.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da84a8a0-707c-46ea-8d45-08d69680b759
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1577;
x-ms-traffictypediagnostic: TY1PR01MB1577:
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1577;20:0vU/3NBIX20Y+9V6S8u538nRIQ5onqeTPh8g5Kng2dnY5QPri+l8Y1AFD7PlNycBCe2Om28zOKofMVEkQ+TUcMSX9y2M7vwn4cXEKCGNnFRJyqN9y1a1eDOXMKvTkDhgBoQp5mLTZXOUZGKzcanqhiorolxiR6WhP4uFyxw9n6o=
x-microsoft-antispam-prvs: <TY1PR01MB15773C9434125338B3944E37F57C0@TY1PR01MB1577.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(13464003)(93886005)(55016002)(305945005)(97736004)(7736002)(14444005)(256004)(105586002)(106356001)(102836004)(9686003)(2906002)(68736007)(6246003)(53936002)(53546011)(6506007)(81156014)(81166006)(8676002)(14454004)(478600001)(8936002)(229853002)(71200400001)(6436002)(71190400001)(33656002)(316002)(26005)(74316002)(86362001)(99286004)(44832011)(7696005)(54906003)(66066001)(3846002)(6916009)(6116002)(76176011)(25786009)(11346002)(446003)(186003)(6346003)(476003)(5660300002)(486006)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1577;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: urybGjMDoC5BL0scO/Qdtv70sT66NLexEtU0/ybF2K8QyNcFK4YmJGzmXhAfGbUlTb5j2kO5HGDamuffiBf6kV30KdtOwZVaNBKuUKp/WUdo341U7cXOY81A2yJqj/LC5HbmZL8gGj4Uz6ov5l8rEZLo8NFvJjhWn82CmfmqrVyV/fOFjs1G5Y6mkFCocObdGG6995IefZxZbPzzhra/PJ2Osho1mpVQI78TVMWWHe8oDoDmd2C7uV9xo20mJIibiK/5zfnFNb7Yll+J0Q0J2oV/ngHr16QKbBpWjNp0qObwQnJJeDrJso4uskXj2o35ewWVceIL9SNZooZQH3GahLbPh4C0KRPaawsgPxuHpRU/URc8rvFhxE6vonbN9TFMePt6cqzT2espC9qjfF16JY9rAljehoG1s9wz+6ZVD98=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da84a8a0-707c-46ea-8d45-08d69680b759
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 15:41:29.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> On Tue, 19 Feb 2019 15:27:25 +0000
> Phil Edworthy <phil.edworthy@renesas.com> wrote:
>=20
> > Hello,
> >
> > Any comments on this patch?
>=20
> Err... I'm afraid it fell through the cracks. It's been three months, and=
 I've
> paged out most of last year.
>=20
> Can you please resend it on top of a recent -rc, and I'll try to have a l=
ook. No
> promise though.

Thanks, appreciate it you can!
Phil

>=20
> Thanks,
>=20
> 	M.
>=20
> >
> > Thanks
> > Phil
> >
> > > -----Original Message-----
> > > From: Phil Edworthy <phil.edworthy@renesas.com>
> > > Sent: 13 November 2018 13:09
> > > To: Marc Zyngier <marc.zyngier@arm.com>; Thomas Gleixner
> > > <tglx@linutronix.de>; Jason Cooper <jason@lakedaemon.net>
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>; linux-renesas-
> > > soc@vger.kernel.org; linux-kernel@vger.kernel.org; Phil Edworthy
> > > <phil.edworthy@renesas.com>
> > > Subject: [PATCH v3 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
> > > interrupt multiplexer
> > >
> > > On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks each
> > > configured to have 32 interrupt outputs, so we have a total of 96
> > > GPIO interrupts. All of these are passed to the GPIO IRQ Muxer,
> > > which selects
> > > 8 of the GPIO interrupts to pass onto the GIC. The interrupt signals
> > > aren't latched, so there is nothing to do in this driver when an
> > > interrupt is received, other than tell the corresponding GPIO block.
> > >
> > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > ---
> > > v3:
> > >  - Use 'interrupt-map' DT property to map the interrupts, this is ver=
y
> similar
> > >    to PCIe MSI. The only difference is that we need to get hold of th=
e
> interrupt
> > >    specifier for the interupts coming into the irqmux.
> > >  - Do not use a chained interrupt controller.
> > > v2:
> > >  - Use interrupt-map to allow the GPIO controller info to be specifie=
d
> > >    as part of the irq.
> > >  - Renamed struct and funcs from 'girq' to a more comprehenisble
> 'irqmux'.
> > > ---
> > >  drivers/irqchip/Kconfig        |   9 ++
> > >  drivers/irqchip/Makefile       |   1 +
> > >  drivers/irqchip/rzn1-irq-mux.c | 205
> > > +++++++++++++++++++++++++++++++++
> > >  3 files changed, 215 insertions(+)
> > >  create mode 100644 drivers/irqchip/rzn1-irq-mux.c
> > >
> > > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig index
> > > 96451b581452..53c54bba1dd8 100644
> > > --- a/drivers/irqchip/Kconfig
> > > +++ b/drivers/irqchip/Kconfig
> > > @@ -204,6 +204,15 @@ config RENESAS_IRQC
> > >  	select GENERIC_IRQ_CHIP
> > >  	select IRQ_DOMAIN
> > >
> > > +config RENESAS_RZN1_IRQ_MUX
> > > +	bool "Renesas RZ/N1 GPIO IRQ multiplexer support"
> > > +	depends on ARCH_RZN1
> > > +	select IRQ_DOMAIN
> > > +	help
> > > +	  Say yes here to add support for the GPIO IRQ multiplexer
> > > embedded
> > > +	  in Renesas RZ/N1 SoC devices. The GPIO IRQ Muxer selects which of
> > > +	  the interrupts coming from the GPIO controllers are used.
> > > +
> > >  config ST_IRQCHIP
> > >  	bool
> > >  	select REGMAP
> > > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > > index b822199445ff..b090f84dd42e 100644
> > > --- a/drivers/irqchip/Makefile
> > > +++ b/drivers/irqchip/Makefile
> > > @@ -45,6 +45,7 @@ obj-$(CONFIG_SIRF_IRQ)			+=3D
> irq-
> > > sirfsoc.o
> > >  obj-$(CONFIG_JCORE_AIC)			+=3D irq-jcore-aic.o
> > >  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+=3D irq-renesas-intc-irqpin.o
> > >  obj-$(CONFIG_RENESAS_IRQC)		+=3D irq-renesas-irqc.o
> > > +obj-$(CONFIG_RENESAS_RZN1_IRQ_MUX)	+=3D rzn1-irq-mux.o
> > >  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+=3D irq-versatile-fpga.o
> > >  obj-$(CONFIG_ARCH_NSPIRE)		+=3D irq-zevio.o
> > >  obj-$(CONFIG_ARCH_VT8500)		+=3D irq-vt8500.o
> > > diff --git a/drivers/irqchip/rzn1-irq-mux.c
> > > b/drivers/irqchip/rzn1-irq-mux.c new file mode 100644 index
> > > 000000000000..ee7810b9b3f3
> > > --- /dev/null
> > > +++ b/drivers/irqchip/rzn1-irq-mux.c
> > > @@ -0,0 +1,205 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * RZ/N1 GPIO Interrupt Multiplexer
> > > + *
> > > + * Copyright (C) 2018 Renesas Electronics Europe Limited
> > > + *
> > > + * On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks
> > > +each configured
> > > + * to have 32 interrupt outputs, so we have a total of 96 GPIO inter=
rupts.
> > > + * All of these are passed to the GPIO IRQ Muxer, which selects 8
> > > +of the GPIO
> > > + * interrupts to pass onto the GIC.
> > > + */
> > > +
> > > +#include <linux/interrupt.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/irqdomain.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_irq.h>
> > > +#include <linux/of_platform.h>
> > > +
> > > +#define MAX_NR_INPUT_IRQS	96
> > > +#define MAX_NR_OUTPUT_IRQS	8
> > > +
> > > +/*
> > > + * "interrupt-map" consists of 1 interrupt cell, 0 address cells,
> > > +phandle to
> > > + * interrupt parent, and parent interrupt specifier (3 cells for
> > > +GIC), giving
> > > + * a total of 5 cells.
> > > + */
> > > +#define IMAP_LENGTH		5
> > > +
> > > +struct irqmux_priv;
> > > +struct irqmux_one {
> > > +	unsigned int irq;
> > > +	unsigned int src_hwirq;
> > > +	struct irqmux_priv *priv;
> > > +};
> > > +
> > > +struct irqmux_priv {
> > > +	struct device *dev;
> > > +	struct irq_domain *irq_domain;
> > > +	unsigned int nr_irqs;
> > > +	struct irqmux_one mux[MAX_NR_OUTPUT_IRQS]; };
> > > +
> > > +static irqreturn_t irqmux_handler(int irq, void *data) {
> > > +	struct irqmux_one *mux =3D data;
> > > +	struct irqmux_priv *priv =3D mux->priv;
> > > +	unsigned int virq;
> > > +
> > > +	virq =3D irq_find_mapping(priv->irq_domain, mux->src_hwirq);
> > > +
> > > +	generic_handle_irq(virq);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int irqmux_domain_map(struct irq_domain *h, unsigned int irq,
> > > +			     irq_hw_number_t hwirq)
> > > +{
> > > +	irq_set_chip_data(irq, h->host_data);
> > > +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> > > handle_simple_irq);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct irq_domain_ops irqmux_domain_ops =3D {
> > > +	.map =3D irqmux_domain_map,
> > > +};
> > > +
> > > +static int irqmux_probe(struct platform_device *pdev) {
> > > +	struct device *dev =3D &pdev->dev;
> > > +	struct device_node *np =3D dev->of_node;
> > > +	struct resource *res;
> > > +	u32 __iomem *regs;
> > > +	struct irqmux_priv *priv;
> > > +	unsigned int i;
> > > +	int nr_irqs;
> > > +	int ret;
> > > +	const __be32 *imap;
> > > +	int imaplen;
> > > +
> > > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	priv->dev =3D dev;
> > > +	platform_set_drvdata(pdev, priv);
> > > +
> > > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	regs =3D devm_ioremap_resource(dev, res);
> > > +	if (IS_ERR(regs))
> > > +		return PTR_ERR(regs);
> > > +
> > > +	nr_irqs =3D of_irq_count(np);
> > > +	if (nr_irqs < 0)
> > > +		return nr_irqs;
> > > +
> > > +	if (nr_irqs > MAX_NR_OUTPUT_IRQS) {
> > > +		dev_err(dev, "too many output interrupts\n");
> > > +		return -ENOENT;
> > > +	}
> > > +
> > > +	priv->nr_irqs =3D nr_irqs;
> > > +
> > > +	/* Look for the interrupt-map */
> > > +	imap =3D of_get_property(np, "interrupt-map", &imaplen);
> > > +	if (!imap)
> > > +		return -ENOENT;
> > > +	imaplen /=3D IMAP_LENGTH * sizeof(__be32);
> > > +
> > > +	/* Sometimes not all muxs are used */
> > > +	if (imaplen < priv->nr_irqs)
> > > +		priv->nr_irqs =3D imaplen;
> > > +
> > > +	/* Create IRQ domain for the interrupts coming from the GPIO
> > > +blocks
> > > */
> > > +	priv->irq_domain =3D irq_domain_add_linear(np,
> > > MAX_NR_INPUT_IRQS,
> > > +						 &irqmux_domain_ops, priv);
> > > +	if (!priv->irq_domain)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i =3D 0; i < MAX_NR_INPUT_IRQS; i++)
> > > +		irq_create_mapping(priv->irq_domain, i);
> > > +
> > > +	for (i =3D 0; i < priv->nr_irqs; i++) {
> > > +		struct irqmux_one *mux =3D &priv->mux[i];
> > > +
> > > +		ret =3D irq_of_parse_and_map(np, i);
> > > +		if (ret < 0) {
> > > +			ret =3D -ENOENT;
> > > +			goto err;
> > > +		}
> > > +
> > > +		mux->irq =3D ret;
> > > +		mux->priv =3D priv;
> > > +
> > > +		/*
> > > +		 * We need the first cell of the interrupt-map to configure
> > > +		 * the hardware.
> > > +		 */
> > > +		mux->src_hwirq =3D be32_to_cpu(*imap);
> > > +		imap +=3D IMAP_LENGTH;
> > > +
> > > +		dev_info(dev, "%u: %u mapped irq %u\n", i,  mux-
> > > >src_hwirq,
> > > +			 mux->irq);
> > > +
> > > +		ret =3D devm_request_irq(dev, mux->irq, irqmux_handler,
> > > +				       IRQF_SHARED | IRQF_NO_THREAD,
> > > +				       "irqmux", mux);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "failed to request IRQ: %d\n", ret);
> > > +			goto err;
> > > +		}
> > > +
> > > +		/* Set up the hardware to pass the interrupt through */
> > > +		writel(mux->src_hwirq, &regs[i]);
> > > +	}
> > > +
> > > +	dev_info(dev, "probed, %d gpio interrupts\n", priv->nr_irqs);
> > > +
> > > +	return 0;
> > > +
> > > +err:
> > > +	while (i--)
> > > +		irq_dispose_mapping(priv->mux[i].irq);
> > > +	irq_domain_remove(priv->irq_domain);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int irqmux_remove(struct platform_device *pdev) {
> > > +	struct irqmux_priv *priv =3D platform_get_drvdata(pdev);
> > > +	unsigned int i;
> > > +
> > > +	for (i =3D 0; i < priv->nr_irqs; i++)
> > > +		irq_dispose_mapping(priv->mux[i].irq);
> > > +	irq_domain_remove(priv->irq_domain);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id irqmux_match[] =3D {
> > > +	{ .compatible =3D "renesas,rzn1-gpioirqmux", },
> > > +	{ /* sentinel */ },
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(of, irqmux_match);
> > > +
> > > +static struct platform_driver irqmux_driver =3D {
> > > +	.driver =3D {
> > > +		.name =3D "gpio_irq_mux",
> > > +		.owner =3D THIS_MODULE,
> > > +		.of_match_table =3D irqmux_match,
> > > +	},
> > > +	.probe =3D irqmux_probe,
> > > +	.remove =3D irqmux_remove,
> > > +};
> > > +
> > > +module_platform_driver(irqmux_driver);
> > > +
> > > +MODULE_DESCRIPTION("Renesas RZ/N1 GPIO IRQ Multiplexer Driver");
> > > +MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.17.1
> >
>=20
>=20
>=20
> --
> Without deviation from the norm, progress is not possible.
