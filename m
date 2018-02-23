Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBWVJY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:09:24 -0500
Received: from mail-eopbgr40102.outbound.protection.outlook.com ([40.107.4.102]:10720
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751983AbeBWVJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:09:20 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se;
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc: Andy Tang <andy.tang@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] irqchip: add support for Layerscape external interrupt lines
Date: Fri, 23 Feb 2018 22:08:59 +0100
Message-Id: <20180223210901.23480-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180223210901.23480-1-rasmus.villemoes@prevas.dk>
References: <20180125150230.7234-1-rasmus.villemoes@prevas.dk>
 <20180223210901.23480-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM5P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::32) To DB6PR10MB0439.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:11::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14d1cce8-2871-45aa-55d9-08d57b01b2d3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR10MB0439;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0439;3:NyyD8jdXzMEes+QLj/YM94L6QThg5fE2oD4cz7jK3zj8qVJ/+91nJwHoK+PdGBluaAeXIT5BBYCpIlYFeNwDScqXlgNqH4pHaQgsP7xsRN29jDrkVQZyphEDcAxDYRx35Rr8T5ReyTUiPuEsV1aMUd29AGU4LKOXTHLwX+9pUHwm66XjQBWmfijC8uIjwpco1oBsuSeeNmwQ+oR8I/zMai1Kw/Ax3JZ1so5Gy5Q00o/SFxpoQic6GvAcqVSgg32w;25:H8iQxKfYdOLQI8FoYVkOh+f2f4qmNuMgfIU8Z6nL2i0v7UWsWvYZYj6JCX7ioMShCGEC7omeJqpiI1E0rbW0yIXqMZOH6mIZkXhZ3tl5H8DovAP6RsIpkQtuVZhrwHd+d5iTT8FTSOv1kdZBbYRjlzaspVid2sWD6Qx75HHjGFfBNW+lQRZgI/cdUEqvy0+Erxp7gtRiIxu8OK9pbpZNB2L25eQcFaa+nFn9I5osTxrXD6duo3Nw2KruEepKp0MHWdufrLoxnTaciUklWOLvDDAbkkju3GJCCKTHOVQUOMjZ9TsVdl5ccZ9dt1S7kqk+djkTrp7ND+02V2UhB4hjIw==;31:wxfSPLgqX3DGYwJAxOcv9hA/Gbma7bqFAKtqFmvNhA/q4v3ICtTnPdjJQp/28Na5vzUBHvkDRVey4vFXXFBWUwRJosMfYlN9mMJCN9AcRsUY2zP9B9oOvk7TwmOFH97Q9IOGHCojPDZhBEPcamxGs8Q3pvlwUjvY7KK3pnIE3vwwEPAxLqkNqMwcpBuNVmhh6s3aeBWPuNK3dtJzuHoFQoTZHHQeHIKl5qn5tBuP4dM=
X-MS-TrafficTypeDiagnostic: DB6PR10MB0439:
X-Microsoft-Antispam-PRVS: <DB6PR10MB0439084ED59AC93F057433108ACC0@DB6PR10MB0439.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231197)(944501161)(52105095)(93006095)(3002001)(6041288)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR10MB0439;BCL:0;PCL:0;RULEID:;SRVR:DB6PR10MB0439;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0439;4:dmzj/bzjST5/sTLYnvbjkbojAdDBMv6TBfDAP2jsdTmusBXlVfkcbx/AuLEtGgRoWF/oLCucQIpDovIE1agx/IymNXyXl4pe3UQK5drb/uZqqxSEgjwObV03fzv5rXDoJO0FzkgcbA5texqYZVzgojCPUSueJX5pbjvAwno//wWZi5i5xFjkoPWDaXrIGWYxyFqGYRiJa9Llx55asHUs6QwT4rcxXJLfRhtk6TSmMQl6VuRnjPjLvK7nl0H1sXPhhDs2XF6fsv9uqVAIUbtgig==
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39850400004)(376002)(346002)(189003)(199004)(51444003)(16586007)(76176011)(8656006)(386003)(110136005)(54906003)(6506007)(51416003)(81156014)(53416004)(316002)(2906002)(59450400001)(8676002)(8936002)(81166006)(72206003)(53936002)(74482002)(8976002)(305945005)(478600001)(6512007)(50466002)(6116002)(7736002)(186003)(1076002)(3846002)(16526019)(50226002)(5660300001)(25786009)(66066001)(26005)(6486002)(97736004)(47776003)(106356001)(68736007)(48376002)(6666003)(42882006)(2950100002)(52116002)(36756003)(4326008)(105586002)(69596002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR10MB0439;H:prevas-ravi.prevas.se;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR10MB0439;23:qLD3Rmach6EWxLbLVsbVAPpwZ962ZK5O8cZ82s4r6?=
 =?us-ascii?Q?7bqTopmO/J8jv0M2MT3nsoVA5ueBX7I1I6rL2WclvGm0VY1cQIGOw6Tu4xcP?=
 =?us-ascii?Q?frj2cjLGeckJfIsOqJfie3mmSPe4lvE4VvIApTZWnozeWSqQAFdWN+iGss0q?=
 =?us-ascii?Q?F8xIu4Z5oUAsiY5kxNf5KoY7dI0HueJ4XsALMNp36dRzAwvo4TSYAK03ErHE?=
 =?us-ascii?Q?NvBHt/jCkW2G7axGBaEGl4Lcwmg5Jo895XjaksLc6Fb5Gav4rxyBJipxiRzO?=
 =?us-ascii?Q?trxI8yNJ3cDONdMjLsPD6b1lDPnW3YeWR7AkwKTgIwDyeX/ImtBBnlVRUflF?=
 =?us-ascii?Q?jZkrYlzXsgMWFRNwO0pJqovYrY3ehSp7Tsn4fVb4dZ7+vbRFZ8qfaKQWERuq?=
 =?us-ascii?Q?hqdifo3Ix6DuT5FcqJBY/x5xcskTuv9kcaEvKP5/w6lp/qfqLXzoy+0yXo0y?=
 =?us-ascii?Q?/0ABVnGhBAti4PBUqG4KZpBiT2frK+9EjHS8d2S4OuT7pDDWtuUUEIQMeU9l?=
 =?us-ascii?Q?3BQDGhK4NHzUBUxuqVHfy/nqoNZQPszXYYxACbudK/3pP++mKFAFM4pLJys+?=
 =?us-ascii?Q?oC8rUMqFdvcbwxjVyL12rfof1YJG/3INb9rTCQJnJ1qb/O1Rh2gtVxvDs9Qm?=
 =?us-ascii?Q?ttreQsEQUnT1E7FPfO9F6ilHAtFcxh/Fvm38VVtRGU/+9chuKdSslkBW0tj3?=
 =?us-ascii?Q?oupID25wv1Hzz8fIt/ur0g1ZFEOp6OyN+cY3tMnWwpdwdcCA7jqPOBHruDct?=
 =?us-ascii?Q?NomZxM1GpuCAupDmz1vOB3I5vKNRYLE5oIdKu4HzC2mEo7CEaCEC2EVP9PtF?=
 =?us-ascii?Q?DQSlFP5VR2GwT9wmwZcVH3VIaI2WEdKSYul7OjBeZ9YpibqVQ07ZINZx86bg?=
 =?us-ascii?Q?QqmuiEhaqIbi85vxc6UwB1lXDoAoyVwF5Wdak1yccPXtBoGDUtd2AC7RiqOC?=
 =?us-ascii?Q?cRLsQNFmZUsUO41jLBw7iwFW88SZe4xYhthlbcYVR+P5B/yBNiamObAFLGKA?=
 =?us-ascii?Q?G9i/Zg2DLd1jwaJUNe/YgxvhCslWZOy5cPHP5kql/yEbfu09Eyay+h3RssB4?=
 =?us-ascii?Q?NzswCRj6GXlyurp/Ls94NDM8qv7qR+PT9UqI84U5paRCBaffRaW+oKm7W3VK?=
 =?us-ascii?Q?RXi/GwPUtZFr3l10mOsXiaU0si4mr3CbQH6sLIzheVaUgF9olFFriuNhyt2s?=
 =?us-ascii?Q?pcF3FN7wBJs04aYhxoN6yRhcDj7vv8CR5UWxz1/5762iXRjPOqlYdH7jhvrr?=
 =?us-ascii?Q?hGEGeZn5lINoxvo2bL2JOAltxX0h/wqwoUgCXU/EVwMGJ9OegMbjbQJBHzlJ?=
 =?us-ascii?Q?e7fnzsVc4uRpX+Cd/U3z1Y=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0439;6:JVJ94dtugb7itHqlj4dMY7B6MBenrvcEbwIs48YK55I/bQNHywhyRnRiXUvDG4wi8t67eJDChvwKWK3aBCZedl6xm/ZFRK/U8FZOBKu1V4wo1QCAXjPUdc4e4iKwQkaZXCJmdzd8Pls8wSMsLCbXOEKlL+6GGb+EaVwt8X7Z14XVLaBMQ2049S95FV3XNTGb9raaFsUzqQXlYj6hsTiUh8ncx5MuRRrkHWg/Ewp8neyqVFCuxIP2UFUZrxlTrsEnFHgT7iyEuVZPr+aBw2DWR4PB6g4/+TkBxFYwD2MqsZsUyPblqOhcCxI3BCGUe1M10TfCzK2J/vmVNJVLy2DYlylOsBSBnedxm74F5LBQkDs=;5:ZD6fekvupsHBaWU4WXa0ho2o9MlkefmUU8WoByWz95MJD5xHtPFD77LLnw9y0O957KKQhO+oLrY4SHlHZUzhbiLBQ3mn3wQPCSK38+UG1jP6aD6c2GDaiPnlvKQLtooFGVyIfQHkxrhixQZsA7vNKyevKXe/26i0M1Wb7WBiZxY=;24:vWvLNTSyktlN7SPKDtUTrY0t+aQPgSXBc80jFhX1iNExqXCHcQh0o8OxDpwupDm6U9T17AoQCZ/+R3rT6wzITKEI0pIRZgXXx+jGWOm3syc=;7:BasDMdoz9ZFzEzny/YJoRD6WtZ4xf/7A8PkIxJ3ijJBGfUYGGqJ+RfEI49qOhPLQfG3sitWRGKldhjS3YJk+gxu0D7lcUrRPbQVsIKckuf3wOjR/C33VJhKXTfLRizOe9oERsYdEflHkNiNwpycRCFcJN9WZVFzAbVermi42WK1wx37so65vWuChaCVqOYwtw+H5nMOf+bdVbvJXO7541hymBORm/v0PV4r3QnzWDj7U6O+H2Z81fclAFLEQM3n6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 21:09:16.1764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d1cce8-2871-45aa-55d9-08d57b01b2d3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB0439
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1021A allows inverting the polarity of six interrupt lines
IRQ[0:5] via the scfg_intpcr register, effectively allowing
IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING for those. We just need to
check the type, set the relevant bit in INTPCR accordingly, and fixup
the type argument before calling the GIC's irq_set_type.

In fact, the power-on-reset value of the INTPCR register on the LS1021A
is so that all six lines have their polarity inverted. Hence any
hardware connected to those lines is unusable without this: If the line
is indeed active low, the generic GIC code will reject an irq spec with
IRQ_TYPE_LEVEL_LOW, while if the line is active high, we must obviously
disable the polarity inversion (writing 0 to the relevant bit) before
unmasking the interrupt.

Some other Layerscape SOCs (LS1043A, LS1046A) reportedly have a similar
feature, just with a different number of external interrupt lines (and a
different POR value for the INTPCR register). This driver should be
prepared for supporting those by properly filling out the device tree
node, but I don't have the full reference manual, nor the hardware to be
able to test it. I do know, from a tiny clipout from one of the other
reference manuals I was shown, that 1U<<n is the right formula to
use for setting/clearing the bit corresponding to the external IRQn, but
I don't know which interrupts on the GIC those lines represent.

There's also a little Kconfig/Kbuild issue: For now, I've let the driver
be built if CONFIG_SOC_LS1021A is set. For the others, it might make
sense to instead use CONFIG_ARCH_LAYERSCAPE, but SOC_LS1021A does not
select ARCH_LAYERSCAPE. The simplest solution is probably to do what is
done for irq-ls-scfg-msi.c: introduce a "def_bool y if SOC_LS1021A ||
ARCH_LAYERSCAPE" symbol. But I think that can wait until somebody with
the hardware actually tests that this works for the other platforms. At
that point, one can also add the extra IRQCHIP_DECLARE instances.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-ls-extirq.c | 176 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 drivers/irqchip/irq-ls-extirq.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d27e3e3619e0..6fe8612e6a49 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_MVEBU_ICU)			+= irq-mvebu-icu.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
+obj-$(CONFIG_SOC_LS1021A)		+= irq-ls-extirq.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
new file mode 100644
index 000000000000..e5665ad867d6
--- /dev/null
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "irq-ls-extirq: " fmt
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define MAXIRQ 12
+
+struct extirq_chip_data {
+	struct regmap *syscon;
+	u32           intpcr;
+	bool          bit_reverse;
+	u32           nirq;
+	u32           parent_irq[MAXIRQ];
+};
+
+static int
+ls_extirq_set_type(struct irq_data *data, unsigned int type)
+{
+	irq_hw_number_t hwirq = data->hwirq;
+	struct extirq_chip_data *chip_data = data->chip_data;
+	u32 value, mask;
+
+	if (chip_data->bit_reverse)
+		mask = 1U << (31 - hwirq);
+	else
+		mask = 1U << hwirq;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_LOW:
+		type = IRQ_TYPE_LEVEL_HIGH;
+		value = mask;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type = IRQ_TYPE_EDGE_RISING;
+		value = mask;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_EDGE_RISING:
+		value = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(chip_data->syscon, chip_data->intpcr, mask, value);
+
+	data = data->parent_data;
+	return data->chip->irq_set_type(data, type);
+}
+
+static struct irq_chip extirq_chip = {
+	.name			= "extirq",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= ls_extirq_set_type,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags                  = IRQCHIP_SET_TYPE_MASKED,
+};
+
+static int
+ls_extirq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+			   unsigned long *hwirq, unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode))
+		return -EINVAL;
+
+	if (fwspec->param_count != 2)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	return 0;
+}
+
+static int
+ls_extirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+		       unsigned int nr_irqs, void *arg)
+{
+	irq_hw_number_t hwirq;
+	struct irq_fwspec *fwspec = arg;
+	struct irq_fwspec gic_fwspec;
+	struct extirq_chip_data *chip_data = domain->host_data;
+
+	if (fwspec->param_count != 2)
+		return -EINVAL;
+
+	hwirq = fwspec->param[0];
+	if (hwirq >= chip_data->nirq)
+		return -EINVAL;
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &extirq_chip,
+				      chip_data);
+
+	gic_fwspec.fwnode = domain->parent->fwnode;
+	gic_fwspec.param_count = 3;
+	gic_fwspec.param[0] = GIC_SPI;
+	gic_fwspec.param[1] = chip_data->parent_irq[hwirq];
+	gic_fwspec.param[2] = fwspec->param[1];
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &gic_fwspec);
+}
+
+static const struct irq_domain_ops extirq_domain_ops = {
+	.translate	= ls_extirq_domain_translate,
+	.alloc		= ls_extirq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int __init
+ls_extirq_of_init(struct device_node *node, struct device_node *parent)
+{
+
+	struct irq_domain *domain, *domain_parent;
+	struct extirq_chip_data *chip;
+	const __be32 *intpcr;
+	int ret;
+
+	domain_parent = irq_find_host(parent);
+	if (!domain_parent) {
+		pr_err("interrupt-parent not found\n");
+		return -EINVAL;
+	}
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->syscon = syscon_node_to_regmap(node->parent);
+	if (IS_ERR(chip->syscon)) {
+		ret = PTR_ERR(chip->syscon);
+		pr_err("Failed to lookup parent regmap\n");
+		goto err;
+	}
+	intpcr = of_get_address(node, 0, NULL, NULL);
+	if (!intpcr) {
+		ret = -ENOENT;
+		pr_err("Missing INTPCR offset value\n");
+		goto err;
+	}
+	chip->intpcr = __be32_to_cpu(*intpcr);
+
+	ret = of_property_read_variable_u32_array(node, "fsl,extirq-map",
+						  chip->parent_irq,
+						  1, ARRAY_SIZE(chip->parent_irq));
+	if (ret < 0)
+		goto err;
+	chip->nirq = ret;
+	chip->bit_reverse = of_property_read_bool(node, "fsl,bit-reverse");
+
+	domain = irq_domain_add_hierarchy(domain_parent, 0, chip->nirq, node,
+					  &extirq_domain_ops, chip);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	kfree(chip);
+	return ret;
+}
+
+IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", ls_extirq_of_init);
-- 
2.15.1
