Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451CCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B139B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ds9+qXrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B139B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeKAAH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:07:59 -0400
Received: from mail-ty1jpn01on0101.outbound.protection.outlook.com ([104.47.93.101]:23232
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728649AbeKAAH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ll/ivju1NRJ/klOIj8GO35/7d+7KLbOOnf4E5LzDV8=;
 b=ds9+qXrSFBJW1jP5kwvguHaqYoa58JulDBsnCKl0y7dVLtUsz1eVySMN/zUENih5c2IIWTnh77FpGs3yQHi370VTZmhlk0Eb4Zxvk6363FCp8Zc0ElmHrv0E/FZXSq2xEHkrBkX20LOmiSo8hgCwRiOOHvZluXSFu1PZBFJI4lU=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB0208.jpnprd01.prod.outlook.com (10.161.135.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Wed, 31 Oct 2018 15:09:26 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%4]) with mapi id 15.20.1273.028; Wed, 31 Oct 2018
 15:09:26 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Topic: [PATCH v2 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Index: AQHUcD2lJIxNUCxga0G4J4tYz/ve2aU4/58AgABgR3A=
Date:   Wed, 31 Oct 2018 15:09:26 +0000
Message-ID: <TY1PR01MB176959B0CF663D0ECB298924F5CD0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181030104438.27827-1-phil.edworthy@renesas.com>
        <20181030104438.27827-3-phil.edworthy@renesas.com>
 <86d0rq35o1.wl-marc.zyngier@arm.com>
In-Reply-To: <86d0rq35o1.wl-marc.zyngier@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0208;20:IwUzK/WEltNmEulrBiPtRwkre/einbuPX2GXXnxvs/y8JMkttM8xChFumlf/fa+BQ1dIbIehpPYy84zsWz8CvBJkIQ0970wKDfBW3y7Pk01R7y+ynHBpFhnlE3rq/8N2Lp+D0Fba2NvmZJivvXPOxRGQOKLiOpn/96DlLY+MjT8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c685f823-1b74-426a-ba56-08d63f42d94b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0208;
x-ms-traffictypediagnostic: TY1PR01MB0208:
x-microsoft-antispam-prvs: <TY1PR01MB02088837EB50F8C8ACC0ADC4F5CD0@TY1PR01MB0208.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB0208;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0208;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(55016002)(97736004)(478600001)(71200400001)(25786009)(6246003)(6436002)(86362001)(9686003)(316002)(486006)(4326008)(44832011)(68736007)(476003)(2906002)(71190400001)(3846002)(6116002)(446003)(256004)(5660300001)(53936002)(54906003)(4744004)(5250100002)(11346002)(305945005)(7736002)(76176011)(2900100001)(74316002)(26005)(99286004)(6916009)(186003)(229853002)(14454004)(105586002)(106356001)(8936002)(102836004)(6506007)(33656002)(8676002)(7696005)(81166006)(81156014)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0208;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SUoZdIUonem9u56BV1uFAZkmtq9ywa1HGIVtVLSOCKLndaJ7G05sVc52xTXoVu6vwqCCrWv5kWDXJFrAld55CSouUKXkckyCRism/r0h3aNGbI447df5uhFF3K7gs7offWQxlCuXf8lLNZfwO4CpRfEUWYaLrzLtAc3SxtsQk/Tl1Q9Pt1J/H1/cajvYrcp6eBXcRvdJY9yeIv/9fquFxxcu7WsqjPV7KD0ZSIqpnueM9WjHmj3FR1dFeGRptA+n+/Sr5+vJYLMT+4R4zc7RVo0zzJmf4co04AFtPDZHWAknwhoHd1R+7KIVvmU2qKx7+0nUjyJWRckX8pNi7WW0efMBs+LoUJSJFvPxACXAzvY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c685f823-1b74-426a-ba56-08d63f42d94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 15:09:26.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Many thanks for a quick response!

On 31 October 2018 08:02, Marc Zyngier wote:
> On Tue, 30 Oct 2018 10:44:38 +0000, Phil Edworthy wrote:
> >
> > On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks each
> > configured to have 32 interrupt outputs, so we have a total of 96 GPIO
> > interrupts. All of these are passed to the GPIO IRQ Muxer, which
> > selects
> > 8 of the GPIO interrupts to pass onto the GIC. The interrupt signals
> > aren't latched, so there is nothing to do in this driver when an
> > interrupt is received, other than tell the corresponding GPIO block.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v2:
> >  - Use interrupt-map to allow the GPIO controller info to be specified
> >    as part of the irq.
> >  - Renamed struct and funcs from 'girq' to a more comprehenisble 'irqmu=
x'.
> > ---
> >  drivers/irqchip/Kconfig        |  10 ++
> >  drivers/irqchip/Makefile       |   1 +
> >  drivers/irqchip/rzn1-irq-mux.c | 235
> > +++++++++++++++++++++++++++++++++
> >  3 files changed, 246 insertions(+)
> >  create mode 100644 drivers/irqchip/rzn1-irq-mux.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig index
> > 96451b581452..3a60a8af60dd 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -204,6 +204,16 @@ config RENESAS_IRQC
> >  	select GENERIC_IRQ_CHIP
> >  	select IRQ_DOMAIN
> >
> > +config RENESAS_RZN1_IRQ_MUX
> > +	bool "Renesas RZ/N1 GPIO IRQ multiplexer support"
> > +	depends on ARCH_RZN1
> > +	select IRQ_DOMAIN
> > +	select IRQ_DOMAIN_HIERARCHY
> > +	help
> > +	  Say yes here to add support for the GPIO IRQ multiplexer
> embedded
> > +	  in Renesas RZ/N1 SoC devices. The GPIO IRQ Muxer selects which of
> > +	  the interrupts coming from the GPIO controllers are used.
> > +
> >  config ST_IRQCHIP
> >  	bool
> >  	select REGMAP
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile index
> > b822199445ff..b090f84dd42e 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -45,6 +45,7 @@ obj-$(CONFIG_SIRF_IRQ)			+=3D
> irq-sirfsoc.o
> >  obj-$(CONFIG_JCORE_AIC)			+=3D irq-jcore-aic.o
> >  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+=3D irq-renesas-intc-irqpin.o
> >  obj-$(CONFIG_RENESAS_IRQC)		+=3D irq-renesas-irqc.o
> > +obj-$(CONFIG_RENESAS_RZN1_IRQ_MUX)	+=3D rzn1-irq-mux.o
> >  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+=3D irq-versatile-fpga.o
> >  obj-$(CONFIG_ARCH_NSPIRE)		+=3D irq-zevio.o
> >  obj-$(CONFIG_ARCH_VT8500)		+=3D irq-vt8500.o
> > diff --git a/drivers/irqchip/rzn1-irq-mux.c
> > b/drivers/irqchip/rzn1-irq-mux.c new file mode 100644 index
> > 000000000000..767ce67e34d2
> > --- /dev/null
> > +++ b/drivers/irqchip/rzn1-irq-mux.c
> > @@ -0,0 +1,235 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * RZ/N1 GPIO Interrupt Multiplexer
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Europe Limited
> > + *
> > + * On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks each
> > +configured
> > + * to have 32 interrupt outputs, so we have a total of 96 GPIO interru=
pts.
> > + * All of these are passed to the GPIO IRQ Muxer, which selects 8 of
> > +the GPIO
> > + * interrupts to pass onto the GIC.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip/chained_irq.h> #include <linux/irqdomain.h>
> > +#include <linux/kernel.h> #include <linux/module.h> #include
> > +<linux/of_irq.h> #include <linux/of_platform.h>
> > +
> > +#define GPIO_IRQ_SPEC_SIZE	3
> > +#define MAX_NR_GPIO_CONTROLLERS	3
> > +#define MAX_NR_GPIO_IRQ		32
> > +#define MAX_NR_INPUT_IRQS	(MAX_NR_GPIO_CONTROLLERS *
> MAX_NR_GPIO_IRQ)
> > +#define MAX_NR_OUTPUT_IRQS	8
> > +
> > +struct irqmux_priv;
> > +struct irqmux_one {
> > +	unsigned int mapped_irq;
> > +	unsigned int input_irq_nr;
> > +	struct irqmux_priv *priv;
> > +};
> > +
> > +struct irqmux_priv {
> > +	struct device *dev;
> > +	struct irq_chip irq_chip;
>=20
> Do we really need this to be per-device? See below.
I thought we generally wanted everything to be per-device so that we can
cope when someone sticks two of these in a device. Am I wrong?

>=20
> > +	struct irq_domain *irq_domain;
> > +	unsigned int nr_irqs;
> > +	struct irqmux_one irq[MAX_NR_OUTPUT_IRQS]; };
> > +
> > +static void irqmux_handler(struct irq_desc *desc) {
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	struct irqmux_one *girq =3D irq_desc_get_handler_data(desc);
> > +	struct irqmux_priv *priv =3D girq->priv;
> > +	unsigned int irq;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	irq =3D irq_find_mapping(priv->irq_domain, girq->input_irq_nr);
> > +	generic_handle_irq(irq);
>=20
> No error handling? See below again, as I think this outline a fundamental=
 flaw
> in the driver.
>=20
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int irqmux_domain_map(struct irq_domain *h, unsigned int irq,
> > +			     irq_hw_number_t hwirq)
> > +{
> > +	struct irqmux_priv *priv =3D h->host_data;
> > +
> > +	irq_set_chip_data(irq, h->host_data);
> > +	irq_set_chip_and_handler(irq, &priv->irq_chip, handle_simple_irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops irqmux_domain_ops =3D {
> > +	.map	=3D irqmux_domain_map,
> > +};
> > +
> > +static int irqmux_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct resource *res;
> > +	u32 __iomem *regs;
> > +	struct irqmux_priv *priv;
> > +	u32 int_specs[MAX_NR_OUTPUT_IRQS][GPIO_IRQ_SPEC_SIZE];
> > +	DECLARE_BITMAP(irqs_in_used, MAX_NR_INPUT_IRQS);
> > +	unsigned int irqs_out_used =3D 0;
> > +	unsigned int i;
> > +	int nr_irqs;
> > +	int ret;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev =3D dev;
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	regs =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(regs))
> > +		return PTR_ERR(regs);
> > +
> > +	nr_irqs =3D of_irq_count(np);
> > +	if (nr_irqs < 0)
> > +		return nr_irqs;
> > +
> > +	if (nr_irqs > MAX_NR_OUTPUT_IRQS) {
> > +		dev_err(dev, "too many output interrupts\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	priv->nr_irqs =3D nr_irqs;
> > +
> > +	/* Get the interrupt specifers */
> > +	if (of_property_read_u32_array(dev->of_node, "interrupts",
> > +				       (u32 *)int_specs,
> > +				       priv->nr_irqs * GPIO_IRQ_SPEC_SIZE)) {
> > +		dev_err(dev, "cannot get interrupt specifiers\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	bitmap_zero(irqs_in_used, MAX_NR_INPUT_IRQS);
> > +
> > +	/* Check the interrupt specifiers */
> > +	for (i =3D 0; i < priv->nr_irqs; i++) {
> > +		u32 *int_spec =3D int_specs[i];
> > +		u32 input_irq =3D int_spec[1] * MAX_NR_GPIO_IRQ +
> int_spec[2];
> > +
> > +		dev_info(dev, "irq %u=3Dgpio%ua:%u\n", int_spec[0],
> int_spec[1],
> > +			 int_spec[2]);
> > +
> > +		if (int_spec[0] >=3D MAX_NR_OUTPUT_IRQS ||
> > +		    int_spec[1] >=3D MAX_NR_GPIO_CONTROLLERS ||
> > +		    int_spec[2] >=3D MAX_NR_GPIO_IRQ) {
> > +			dev_err(dev, "invalid interrupt args\n");
> > +			return -ENOENT;
> > +		}
> > +
> > +		if (irqs_out_used & BIT(int_spec[0]) ||
> > +		    test_bit(input_irq, irqs_in_used)) {
> > +			dev_err(dev, "irq %d already used\n", i);
> > +			return -ENOENT;
> > +		}
>=20
> I don't think the driver should be in the business of DT validation, and =
that
> you should simply drop this code.
When I implement Rob H's feedback on the binding, this should no longer be
needed.

>=20
> > +
> > +		irqs_out_used |=3D BIT(int_spec[0]);
> > +		set_bit(input_irq, irqs_in_used);
> > +	}
> > +
> > +	/* Create IRQ domain for the interrupts coming from the GPIO blocks
> */
> > +	priv->irq_chip.name =3D dev_name(dev);
>=20
> OK, that's where I think we have a problem. Your irqchip structure seem t=
o
> only be used to display a name?!?
Right, that wasn't the intention! So, how do I hook in my own interrupt han=
dler
without calling irq_set_chip_and_handler()?
That's what led me to think I need an irq_chip instance.

>=20
> To start with, that's not really the primary use for this object, and I'd=
 like it to
> be a single static structure for the whole driver. Userspace doesn't need=
 to
> know about the name, so please get rid of this.
>=20
> The real issue is that you build the whole thing as a chained interrupt
> controller, meaning that nothing controls the masking of the interrupt. I=
f, as I
> understand it, this IP is an interrupt router that selects 8 out of 32 in=
terrupts
> and passes them onto the GIC, then a noisy device can just take the whole
> CPU down by keeping the line asserted, and SW cannot mask it.
The interrupts into this mux come from GPIO blocks that do the masking. The
GPIO blocks in this case are standard Synopsys IP blocks.
There is nothing in the irq mux hardware that can mask them, or do anything
other than select which one to use, hence why this is a chained interrupt
controller. Should I be using something else in this case?

> By the look of it, this should be turned into an interrupt hierarchy, and=
 not a
> chained interrupt. You do select IRQ_DOMAIN_HIERARCHY, and completely
> fail to use the API...
Ok, I should not have selected that.

>=20
> > +	priv->irq_domain =3D irq_domain_add_linear(np,
> MAX_NR_INPUT_IRQS,
> > +						 &irqmux_domain_ops, priv);
> > +	if (!priv->irq_domain)
> > +		return -ENOMEM;
> > +
> > +	/* Setup the interrupts */
> > +	for (i =3D 0; i < priv->nr_irqs; i++) {
> > +		struct of_phandle_args ofirq;
> > +		u32 *int_spec =3D int_specs[i];
> > +		u32 input_irq =3D int_spec[1] * MAX_NR_GPIO_IRQ +
> int_spec[2];
> > +		struct irqmux_one *irq =3D &priv->irq[i];
> > +
> > +		if (of_irq_parse_one(dev->of_node, i, &ofirq)) {
> > +			ret =3D -ENOENT;
> > +			goto err;
> > +		}
>=20
> Why isn't this irq_of_parse_and_map, so that we get rid of the below
> create_of_mapping? And if you turn this into a full interrupt hierarchy, =
this
> will completely go away.
That was due to the way I abused the interrupt-map, and should go.

>=20
> > +
> > +		priv->irq[i].mapped_irq =3D irq_create_of_mapping(&ofirq);
> > +		if (!priv->irq[i].mapped_irq) {
> > +			dev_err(dev, "cannot get interrupt\n");
> > +			ret =3D -ENOENT;
> > +			goto err;
> > +		}
> > +
> > +		irq->priv =3D priv;
> > +		irq->input_irq_nr =3D input_irq;
> > +
> > +		irq_set_chained_handler_and_data(irq->mapped_irq,
> > +						 irqmux_handler, irq);
> > +
> > +		/* Set up the hardware to pass the interrupt through */
> > +		writel(irq->input_irq_nr, &regs[int_spec[0]]);
> > +	}
> > +
> > +	dev_info(dev, "probed, %d gpio interrupts\n", priv->nr_irqs);
> > +
> > +	return 0;
> > +
> > +err:
> > +	while (i--) {
> > +		struct irqmux_one *irq =3D &priv->irq[i];
> > +
> > +		irq_set_chained_handler_and_data(irq->mapped_irq, NULL,
> NULL);
> > +		irq_dispose_mapping(irq->mapped_irq);
> > +	}
> > +	irq_domain_remove(priv->irq_domain);
> > +
> > +	return 0;
> > +}
> > +
> > +static int irqmux_remove(struct platform_device *pdev) {
> > +	struct irqmux_priv *priv =3D platform_get_drvdata(pdev);
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < priv->nr_irqs; i++) {
> > +		struct irqmux_one *irq =3D &priv->irq[i];
> > +
> > +		irq_set_chained_handler_and_data(irq->mapped_irq, NULL,
> NULL);
> > +		irq_dispose_mapping(irq->mapped_irq);
> > +	}
> > +	irq_domain_remove(priv->irq_domain);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id irqmux_match[] =3D {
> > +	{ .compatible =3D "renesas,rzn1-gpioirqmux", },
> > +	{ /* sentinel */ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, irqmux_match);
> > +
> > +static struct platform_driver irqmux_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "gpio_irq_mux",
> > +		.owner =3D THIS_MODULE,
> > +		.of_match_table =3D irqmux_match,
> > +	},
> > +	.probe =3D irqmux_probe,
> > +	.remove =3D irqmux_remove,
> > +};
> > +
> > +module_platform_driver(irqmux_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas RZ/N1 GPIO IRQ Multiplexer Driver");
> > +MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1
> >
>=20
> To sum it up, I think the structure of this driver is flawed. Please
> turn it into a full hierarchy, or alternatively tell me that I have
> the wrong end of the stick!
I'm hoping you got the wrong end of the stick! If not, I have some
excavation ahead to work out how I should have done this...

Thanks!
Phil

>=20
> Thanks,
>=20
> 	M.
>=20
> --
> Jazz is not dead, it just smell funny.
