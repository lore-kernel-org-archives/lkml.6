Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F02C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2532082F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nY/Cb6da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfA2VTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:19:30 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:37920
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbfA2VTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pQBatef1UDVF2uUH19ESPKG26AR9lj7Z2VU3nHKQ4M=;
 b=nY/Cb6da7v7Y100H+3aRIoIzHf1Y3NW9pvZE5x5bR36Y0skcwMqDgPnr/XB3FYMCTfPZ66nfmeZV+11xvq+AwFJZSlDmtYJDUqkp8jt7USNWbbN4iRqNJUN/xQOYL/9XIY6T3HgyWphBsWHbahoTdOfJzmCcVKaoE7YEuajCves=
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) by
 VI1PR04MB4895.eurprd04.prod.outlook.com (20.177.49.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 21:19:19 +0000
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f]) by VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f%2]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 21:19:18 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Rob Herring <robh@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>
Subject: Re: [PATCH] soc: imx: Add psci gpc support for i.MX8MQ
Thread-Topic: [PATCH] soc: imx: Add psci gpc support for i.MX8MQ
Thread-Index: AQHUt9bU+/jArCh7A0qIut8V+yy3WaXGanOAgABWdIA=
Date:   Tue, 29 Jan 2019 21:19:18 +0000
Message-ID: <20190129211917.imy3amuguh4dqmb4@fsr-ub1664-175>
References: <1548768630-2416-1-git-send-email-abel.vesa@nxp.com>
 <1548778191.6869.7.camel@pengutronix.de>
In-Reply-To: <1548778191.6869.7.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4895;6:j7o0G5g5m4nxITEcP2bWfDde9ldq02nwSOL1ZBSdtgk8X6aUoOPgwUt+7G3j5jx3ftK5a2bUsOrHIHXrzju0ePTgfKQW0hO30s4MXdSnZhd3sZsOHE8AHESOBLQtv+Z4qdrMj1wPHVDlgbb74QJePf0rerri9N7oRpF2DXtq2sjzVcdnH8qXl/yG5MBGbdL3K6RhwzCYQxK8bSoFVl2cI26xiVnutkZd9ut/aIfE/BIFzWS8TXB208XnZSN4QvORLrWNhCOMsXTqNgIDEWYd+CIT9zMxh6ANMqIkUg9ch2NuSjs9ZNZdPoWud4LIvQBsTJ6IbRGoZM3h6dKRXnqu0JW0lJ4DaFjTooVRu536e16B5o+6FjbuH+aO0eY9Usvb+lqzyIQbsdSqkP54S3/5ZCVZR69RJ8JD3hITt8E2kMHIDKCNMIAPgHSdo14BmlasKTXjAllWyRZ4CAfqDcjOrw==;5:tKUr4S0R55VrEwUvQABDRXfrw7taZCSHW9jhBJ+wLaYU1fIL5nYaIsbXAgP6tSLAS6EjY0OV9zYvWpO+7NyEnEO4XMa8kRN0qHYaQbbwnY2+hTNFP6ppanPJgI4EHXmy+HyEwEIY53Jl5+0A2UE2jFUOSUfEVRzmJQFvaudzyZNLw5rf6j9LMY7cn4vLA2DT7NEyc8pHlTxEi83Q2qTjDw==;7:WLE8JB+i4qKCU69wBbqcyA5nJ1UbGchuzanRSM6Dr7qlQtroiSiTPEFaHzSyC2NCjJodIUl+PwvxKIY6SBzTcmjqXmOzeBukpncA44yperMH2nQS/b7/2CEoBRLusYd3mnfkB356JiqOQStyFtZlDA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 08ff229d-a91e-4b4f-ded2-08d6862f6e33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4895;
x-ms-traffictypediagnostic: VI1PR04MB4895:
x-microsoft-antispam-prvs: <VI1PR04MB48955CB9F455E14789674590F6970@VI1PR04MB4895.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(26005)(8676002)(14454004)(6916009)(476003)(9686003)(8936002)(33716001)(33896004)(6486002)(81156014)(7736002)(71200400001)(6512007)(81166006)(14444005)(2906002)(6436002)(71190400001)(106356001)(25786009)(30864003)(53936002)(6506007)(68736007)(478600001)(105586002)(486006)(44832011)(4326008)(53546011)(102836004)(86362001)(39060400002)(54906003)(6116002)(97736004)(446003)(256004)(1076003)(53946003)(6246003)(316002)(11346002)(305945005)(99286004)(66066001)(229853002)(3846002)(186003)(76176011)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4895;H:VI1PR04MB5008.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i5tyerXg+t2BKUbWxIoSXtUytBkn/vmSEE9aHsyKBCYq6GJuGiba5jmwpjv9yPjtxNDcJPMmL2PBoZSiyvVR1/pQW+wK5v9Qz9wg61oUN+c6sD5NocwQFo/icvEWFWY8pqCXPQ459FYvfj7Q1lKimuABZ7Qw2gc7IGwXXCQbC98RfSYJPP+G9MJZGWRvynjjoYMS7pHbT+sY2+23FzEMynjAzJ23kLBRBPgJ+lPRb72Up6+rVmIwsoTytKTKFaJFOLfyBL+GH9oM1pzIpbn9u9knuGyGypUC9RDw36oStSF0uLhP/4I70Qm9GWqtTwiDRYipBk2sCu8UwZMZw5si+G0jw08K7hh3onM2DrNZ2XrjmP4Pd6M5F0V5jlGek1ZfkSzKVJZjSeURzPc11EWEHej6hTzFLY8JuPfW4JD0kTk=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CC5B1D3FD5495C4BAC9A4F5181B808BB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ff229d-a91e-4b4f-ded2-08d6862f6e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 21:19:18.8575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-29 17:09:51, Lucas Stach wrote:
> Am Dienstag, den 29.01.2019, 13:30 +0000 schrieb Abel Vesa:
> > From: Anson Huang <Anson.Huang@nxp.com>
> >=20
> > Add i.MX8MQ PSCI GPC virtual driver support.
> >=20
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
>=20
> NACK, we already have a working driver for the power domains on
> i.MX8MQ, reusing the existing GPCv2 driver. This has been done in
> coordination with Anson Huang. There is no need to involve PSCI in any
> of this.
>=20

Hmmm, didn't see that until now. You're right, no point in adding this then=
.
So I guess the upcomming drivers will have to switch from this old one to t=
he
one already existing when upstreaming.

I'll drop this then.=20
Thanks.

> Regards,
> Lucas
>=20
> > ---
> > =A0drivers/soc/imx/Makefile=A0=A0=A0|=A0=A0=A01 +
> > =A0drivers/soc/imx/gpc-psci.c | 423
> > +++++++++++++++++++++++++++++++++++++++++++++
> > =A0include/soc/imx/fsl_sip.h=A0=A0|=A0=A031 ++++
> > =A03 files changed, 455 insertions(+)
> > =A0create mode 100644 drivers/soc/imx/gpc-psci.c
> > =A0create mode 100644 include/soc/imx/fsl_sip.h
> >=20
> > diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> > index 506a6f3..83a38ac 100644
> > --- a/drivers/soc/imx/Makefile
> > +++ b/drivers/soc/imx/Makefile
> > @@ -1,2 +1,3 @@
> > =A0obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
> > =A0obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
> > +obj-$(CONFIG_ARCH_MXC) +=3D gpc-psci.o
> > diff --git a/drivers/soc/imx/gpc-psci.c b/drivers/soc/imx/gpc-psci.c
> > new file mode 100644
> > index 0000000..4f8fee9
> > --- /dev/null
> > +++ b/drivers/soc/imx/gpc-psci.c
> > @@ -0,0 +1,423 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2019 NXP.
> > + *
> > + */
> > +
> > +#include <linux/arm-smccc.h>
> > +#include <linux/clk.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/arm-gic.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/pm_domain.h>
> > +#include <soc/imx/fsl_sip.h>
> > +
> > +#define GPC_MAX_IRQS		(4 * 32)
> > +
> > +struct imx_gpc_pm_domain {
> > +	const char name[30];
> > +	struct device *dev;
> > +	struct generic_pm_domain pd;
> > +	u32 gpc_domain_id;
> > +	struct clk **clks;
> > +	unsigned int num_clks;
> > +	struct regulator *reg;
> > +};
> > +
> > +enum imx_gpc_pm_domain_state {
> > +	GPC_PD_STATE_OFF,
> > +	GPC_PD_STATE_ON,
> > +};
> > +
> > +#define to_imx_gpc_pm_domain(_genpd) \
> > +	container_of(_genpd, struct imx_gpc_pm_domain, pd)
> > +
> > +static DEFINE_SPINLOCK(gpc_psci_lock);
> > +static DEFINE_MUTEX(gpc_pd_mutex);
> > +
> > +static void imx_gpc_psci_irq_unmask(struct irq_data *d)
> > +{
> > +	struct arm_smccc_res res;
> > +
> > +	spin_lock(&gpc_psci_lock);
> > +	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_UNMASK, d-
> > >hwirq,
> > +		=A0=A0=A0=A0=A0=A00, 0, 0, 0, 0, &res);
> > +	spin_unlock(&gpc_psci_lock);
> > +
> > +	irq_chip_unmask_parent(d);
> > +}
> > +
> > +static void imx_gpc_psci_irq_mask(struct irq_data *d)
> > +{
> > +	struct arm_smccc_res res;
> > +
> > +	spin_lock(&gpc_psci_lock);
> > +	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_MASK, d-
> > >hwirq,
> > +		=A0=A0=A0=A0=A0=A00, 0, 0, 0, 0, &res);
> > +	spin_unlock(&gpc_psci_lock);
> > +
> > +	irq_chip_mask_parent(d);
> > +}
> > +static int imx_gpc_psci_irq_set_wake(struct irq_data *d, unsigned
> > int on)
> > +{
> > +	struct arm_smccc_res res;
> > +
> > +	spin_lock(&gpc_psci_lock);
> > +	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_SET_WAKE, d-
> > >hwirq,
> > +			on, 0, 0, 0, 0, &res);
> > +	spin_unlock(&gpc_psci_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_gpc_psci_irq_set_affinity(struct irq_data *d,
> > +					=A0const struct cpumask *dest,
> > +					=A0bool force)
> > +{
> > +	/* parse the cpu of irq affinity */
> > +	struct arm_smccc_res res;
> > +	int cpu =3D cpumask_any_and(dest, cpu_online_mask);
> > +
> > +	irq_chip_set_affinity_parent(d, dest, force);
> > +
> > +	spin_lock(&gpc_psci_lock);
> > +	arm_smccc_smc(FSL_SIP_GPC, 0x4, d->hwirq,
> > +		=A0=A0=A0=A0=A0=A0cpu, 0, 0, 0, 0, &res);
> > +	spin_unlock(&gpc_psci_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct irq_chip imx_gpc_psci_chip =3D {
> > +	.name			=3D "GPC-PSCI",
> > +	.irq_eoi		=3D irq_chip_eoi_parent,
> > +	.irq_mask		=3D imx_gpc_psci_irq_mask,
> > +	.irq_unmask		=3D imx_gpc_psci_irq_unmask,
> > +	.irq_retrigger		=3D
> > irq_chip_retrigger_hierarchy,
> > +	.irq_set_wake		=3D imx_gpc_psci_irq_set_wake,
> > +	.irq_set_affinity	=3D imx_gpc_psci_irq_set_affinity,
> > +};
> > +
> > +static int imx_gpc_psci_domain_translate(struct irq_domain *d,
> > +				=A0=A0=A0=A0struct irq_fwspec *fwspec,
> > +				=A0=A0=A0=A0unsigned long *hwirq,
> > +				=A0=A0=A0=A0unsigned int *type)
> > +{
> > +	if (is_of_node(fwspec->fwnode)) {
> > +		if (fwspec->param_count !=3D 3)
> > +			return -EINVAL;
> > +
> > +		/* No PPI should point to this domain */
> > +		if (fwspec->param[0] !=3D 0)
> > +			return -EINVAL;
> > +
> > +		*hwirq =3D fwspec->param[1];
> > +		*type =3D fwspec->param[2];
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int imx_gpc_psci_domain_alloc(struct irq_domain *domain,
> > +				=A0=A0unsigned int irq,
> > +				=A0=A0unsigned int nr_irqs, void *data)
> > +{
> > +	struct irq_fwspec *fwspec =3D data;
> > +	struct irq_fwspec parent_fwspec;
> > +	irq_hw_number_t hwirq;
> > +	int i;
> > +
> > +	if (fwspec->param_count !=3D 3)
> > +		return -EINVAL;	/* Not GIC compliant */
> > +	if (fwspec->param[0] !=3D 0)
> > +		return -EINVAL;	/* No PPI should point to
> > this domain */
> > +
> > +	hwirq =3D fwspec->param[1];
> > +	if (hwirq >=3D GPC_MAX_IRQS)
> > +		return -EINVAL;	/* Can't deal with this */
> > +
> > +	for (i =3D 0; i < nr_irqs; i++)
> > +		irq_domain_set_hwirq_and_chip(domain, irq + i, hwirq
> > + i,
> > +					=A0=A0=A0=A0=A0=A0&imx_gpc_psci_chip,
> > NULL);
> > +
> > +	parent_fwspec =3D *fwspec;
> > +	parent_fwspec.fwnode =3D domain->parent->fwnode;
> > +
> > +	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs,
> > +					=A0=A0=A0=A0&parent_fwspec);
> > +}
> > +
> > +static const struct irq_domain_ops imx_gpc_psci_domain_ops =3D {
> > +	.translate =3D imx_gpc_psci_domain_translate,
> > +	.alloc	=3D imx_gpc_psci_domain_alloc,
> > +	.free	=3D irq_domain_free_irqs_common,
> > +};
> > +
> > +static int __init imx_gpc_psci_init(struct device_node *node,
> > +			=A0=A0=A0=A0=A0=A0=A0struct device_node *parent)
> > +{
> > +	struct irq_domain *parent_domain, *domain;
> > +
> > +	if (!parent) {
> > +		pr_err("%s: no parent, giving up\n", node-
> > >full_name);
> > +		return -ENODEV;
> > +	}
> > +
> > +	parent_domain =3D irq_find_host(parent);
> > +	if (!parent_domain) {
> > +		pr_err("%s: unable to obtain parent domain\n",
> > +			node->full_name);
> > +		return -ENXIO;
> > +	}
> > +
> > +	domain =3D irq_domain_add_hierarchy(parent_domain, 0,
> > GPC_MAX_IRQS,
> > +					=A0=A0node,
> > &imx_gpc_psci_domain_ops,
> > +					=A0=A0NULL);
> > +	if (!domain)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +IRQCHIP_DECLARE(imx_gpc_psci, "fsl,imx8mq-gpc", imx_gpc_psci_init);
> > +
> > +static int imx_gpc_pd_power_on(struct generic_pm_domain *domain)
> > +{
> > +	struct imx_gpc_pm_domain *pd =3D to_imx_gpc_pm_domain(domain);
> > +	struct arm_smccc_res res;
> > +	int index, ret =3D 0;
> > +
> > +	/* power on the external supply */
> > +	if (pd->reg) {
> > +		ret =3D regulator_enable(pd->reg);
> > +		if (ret) {
> > +			dev_warn(pd->dev, "failed to power up the
> > reg%d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	/* enable the necessary clks needed by the power domain */
> > +	if (pd->num_clks) {
> > +		for (index =3D 0; index < pd->num_clks; index++)
> > +			clk_prepare_enable(pd->clks[index]);
> > +	}
> > +
> > +	mutex_lock(&gpc_pd_mutex);
> > +	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_PM_DOMAIN,
> > +			pd->gpc_domain_id,
> > +			GPC_PD_STATE_ON, 0, 0, 0, 0, &res);
> > +	mutex_unlock(&gpc_pd_mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_gpc_pd_power_off(struct generic_pm_domain *domain)
> > +{
> > +	struct imx_gpc_pm_domain *pd =3D to_imx_gpc_pm_domain(domain);
> > +	struct arm_smccc_res res;
> > +	int index, ret =3D 0;
> > +
> > +	mutex_lock(&gpc_pd_mutex);
> > +	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_PM_DOMAIN,
> > +			pd->gpc_domain_id, GPC_PD_STATE_OFF,
> > +			0, 0, 0, 0, &res);
> > +	mutex_unlock(&gpc_pd_mutex);
> > +
> > +	/* power off the external supply */
> > +	if (pd->reg) {
> > +		ret =3D regulator_disable(pd->reg);
> > +		if (ret) {
> > +			dev_warn(pd->dev, "failed to power off the
> > reg%d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	/* disable the necessary clks when power domain on finished
> > */
> > +	if (pd->num_clks) {
> > +		for (index =3D 0; index < pd->num_clks; index++)
> > +			clk_disable_unprepare(pd->clks[index]);
> > +	}
> > +
> > +	return ret;
> > +};
> > +
> > +static int imx8m_pd_clk_init(struct device_node *np,
> > +			=A0=A0=A0=A0=A0struct imx_gpc_pm_domain *domain)
> > +{
> > +	struct property *pp;
> > +	struct clk **clks;
> > +	int index;
> > +
> > +	pp =3D of_find_property(np, "clocks", NULL);
> > +	if (pp)
> > +		domain->num_clks =3D pp->length / 8;
> > +	else
> > +		domain->num_clks =3D 0;
> > +
> > +	if (domain->num_clks) {
> > +		clks =3D kcalloc(domain->num_clks, sizeof(*clks),
> > GFP_KERNEL);
> > +		if (!clks) {
> > +			domain->num_clks =3D 0;
> > +			domain->clks =3D NULL;
> > +			return -ENOMEM;
> > +		}
> > +
> > +		domain->clks =3D clks;
> > +	}
> > +
> > +	for (index =3D 0; index < domain->num_clks; index++) {
> > +		clks[index] =3D of_clk_get(np, index);
> > +		if (IS_ERR(clks[index])) {
> > +			for (index =3D 0; index < domain->num_clks;
> > index++) {
> > +				if (!IS_ERR(clks[index]))
> > +					clk_put(clks[index]);
> > +			}
> > +
> > +			domain->num_clks =3D 0;
> > +			domain->clks =3D NULL;
> > +			kfree(clks);
> > +			pr_warn("imx8m domain clock init failed\n");
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx8m_add_subdomain(struct device_node *parent,
> > +			=A0=A0=A0=A0=A0=A0=A0struct generic_pm_domain *parent_pd)
> > +{
> > +	struct device_node *child_node;
> > +	struct imx_gpc_pm_domain *child_domain;
> > +	int ret =3D 0;
> > +
> > +	/* add each of the child domain of parent */
> > +	for_each_child_of_node(parent, child_node) {
> > +		if (!of_device_is_available(child_node))
> > +			continue;
> > +
> > +		child_domain =3D kzalloc(sizeof(*child_domain),
> > GFP_KERNEL);
> > +		if (!child_domain)
> > +			return -ENOMEM;
> > +
> > +		ret =3D of_property_read_string(child_node, "domain-
> > name",
> > +					=A0=A0=A0=A0=A0=A0&child_domain-
> > >pd.name);
> > +		if (ret)
> > +			goto exit;
> > +
> > +		ret =3D of_property_read_u32(child_node, "domain-id",
> > +					=A0=A0=A0&child_domain-
> > >gpc_domain_id);
> > +		if (ret)
> > +			goto exit;
> > +
> > +		child_domain->pd.power_off =3D imx_gpc_pd_power_off;
> > +		child_domain->pd.power_on =3D imx_gpc_pd_power_on;
> > +		/* no reg for subdomains */
> > +		child_domain->reg =3D NULL;
> > +
> > +		imx8m_pd_clk_init(child_node, child_domain);
> > +
> > +		/* power domains as off at boot */
> > +		pm_genpd_init(&child_domain->pd, NULL, true);
> > +
> > +		/* add subdomain of parent power domain */
> > +		pm_genpd_add_subdomain(parent_pd, &child_domain-
> > >pd);
> > +
> > +		ret =3D of_genpd_add_provider_simple(child_node,
> > +						=A0&child_domain->pd);
> > +		if (ret)
> > +			pr_err("failed to add subdomain\n");
> > +	}
> > +
> > +	return 0;
> > +exit:
> > +	kfree(child_domain);
> > +	return ret;
> > +};
> > +
> > +static int imx_gpc_pm_domain_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct imx_gpc_pm_domain *imx_pm_domain;
> > +	int ret =3D 0;
> > +
> > +	if (!np) {
> > +		dev_err(dev, "power domain device tree node not
> > found\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	imx_pm_domain =3D devm_kzalloc(dev, sizeof(*imx_pm_domain),
> > GFP_KERNEL);
> > +	if (!imx_pm_domain)
> > +		return -ENOMEM;
> > +	imx_pm_domain->dev =3D dev;
> > +
> > +	ret =3D of_property_read_string(np, "domain-name",
> > +					&imx_pm_domain->pd.name);
> > +	if (ret) {
> > +		dev_err(dev, "get domain name failed\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D of_property_read_u32(np, "domain-id",
> > +					&imx_pm_domain-
> > >gpc_domain_id);
> > +	if (ret) {
> > +		dev_err(dev, "get domain id failed\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	imx_pm_domain->reg =3D devm_regulator_get_optional(dev,
> > "power");
> > +	if (IS_ERR(imx_pm_domain->reg)) {
> > +		if (PTR_ERR(imx_pm_domain->reg) =3D=3D -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +
> > +		imx_pm_domain->reg =3D NULL;
> > +	}
> > +
> > +	imx8m_pd_clk_init(np, imx_pm_domain);
> > +
> > +	imx_pm_domain->pd.power_off =3D imx_gpc_pd_power_off;
> > +	imx_pm_domain->pd.power_on =3D imx_gpc_pd_power_on;
> > +	/* all power domains as off at boot */
> > +	pm_genpd_init(&imx_pm_domain->pd, NULL, true);
> > +
> > +	ret =3D of_genpd_add_provider_simple(np,
> > +				=A0&imx_pm_domain->pd);
> > +
> > +	/* add subdomain */
> > +	ret =3D imx8m_add_subdomain(np, &imx_pm_domain->pd);
> > +	if (ret)
> > +		dev_warn(dev, "please check the child power domain
> > init\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id imx_gpc_pm_domain_ids[] =3D {
> > +	{.compatible =3D "fsl,imx8mq-pm-domain"},
> > +	{.compatible =3D "fsl,imx8mm-pm-domain"},
> > +	{},
> > +};
> > +
> > +static struct platform_driver imx_gpc_pm_domain_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "imx8m_gpc_pm_domain",
> > +		.owner	=3D THIS_MODULE,
> > +		.of_match_table =3D imx_gpc_pm_domain_ids,
> > +	},
> > +	.probe =3D imx_gpc_pm_domain_probe,
> > +};
> > +
> > +module_platform_driver(imx_gpc_pm_domain_driver);
> > +
> > +MODULE_AUTHOR("NXP");
> > +MODULE_DESCRIPTION("NXP i.MX8M GPC power domain driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/soc/imx/fsl_sip.h b/include/soc/imx/fsl_sip.h
> > new file mode 100644
> > index 0000000..c3867a2
> > --- /dev/null
> > +++ b/include/soc/imx/fsl_sip.h
> > @@ -0,0 +1,31 @@
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017 NXP
> > + *
> > + * This program is free software; you can redistribute it and/or
> > modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __SOC_FSL_SIP_H
> > +#define __SOC_FSL_SIP_H
> > +
> > +#define FSL_SIP_GPC			0xC2000000
> > +#define FSL_SIP_CONFIG_GPC_MASK		0x00
> > +#define FSL_SIP_CONFIG_GPC_UNMASK	0x01
> > +#define FSL_SIP_CONFIG_GPC_SET_WAKE	0x02
> > +#define FSL_SIP_CONFIG_GPC_PM_DOMAIN	0x03
> > +
> > +#define IMX8MQ_PD_MIPI		0
> > +#define IMX8MQ_PD_PCIE1		1
> > +#define IMX8MQ_PD_OTG1		2
> > +#define IMX8MQ_PD_OTG2		3
> > +#define IMX8MQ_PD_GPU		4
> > +#define IMX8MQ_PD_VPU		5
> > +#define IMX8MQ_PD_HDMI		6
> > +#define IMX8MQ_PD_DISP		7
> > +#define IMX8MQ_PD_MIPI_CSI1	8
> > +#define IMX8MQ_PD_MIPI_CSI2	9
> > +#define IMX8MQ_PD_PCIE2		10
> > +
> > +#endif=
