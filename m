Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63278C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A3220C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fbx5kM0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfBTLk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:40:59 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:56108
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726853AbfBTLkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66lBuPnT7BDBPQcI8Nv6QxBT8Qk825Pi1B0VQELDVwE=;
 b=Fbx5kM0yeo5gT4J/gSDH3RpilAdFtXKZeF2jJqMyiFiAq0XUidFHO9RChbQi+nYZDrfmynzVLjaSy3r7j9zMvQNYfcpmJeb5thXZoW0B32MRo+6WoKT5fYw4VyREa5mSk5PRZz6e6+h7PDQekzG0D4lN6FuvnBIf44vLYFLpntQ=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB6152.eurprd04.prod.outlook.com (20.179.6.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 11:40:51 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 11:40:51 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH V4 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Topic: [PATCH V4 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Index: AQHUyREhEvd4FRk+jEqxfGczDO8qTw==
Date:   Wed, 20 Feb 2019 11:40:51 +0000
Message-ID: <1550662447-8565-5-git-send-email-aisheng.dong@nxp.com>
References: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To AM6PR04MB4215.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0649e01-ca57-4081-0abc-08d6972843cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6152;
x-ms-traffictypediagnostic: AM6PR04MB6152:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6152;23:hvh/C3oWqU7DX75ajO29XGzkK1xuRwTa7YYxkaY?=
 =?iso-8859-1?Q?kBKssoc8SoCAy0IDT3Jy7blYMqd2tw77Je6yKN0ktlR0ITKntxMk5Nukl6?=
 =?iso-8859-1?Q?tOnA0fYLJI83Wq3HJTKkAJsh47B1CYtYhawMdPSdbHGcY5d35Z8UYcScAs?=
 =?iso-8859-1?Q?EUmSCdMfayt78F9Zr6nPKh8dl5DRsJU97pqoDkxWG1XGHeM1dZJODxw25f?=
 =?iso-8859-1?Q?A8gni6ttFXyYTcdMRQqG8+bEHylqk8uscnL44elhXk0fNr8Z8jS/brqIYc?=
 =?iso-8859-1?Q?MZq1epEShCCAgOxqjADufPbrwZJumtPqpqwHcnqjs4mMcGJAajoagDIg5X?=
 =?iso-8859-1?Q?OLVaQQODUFxFZSj7FnFlTp91lLY3xfDrj5H8nTvwP3BCpzSmIel6K/ZT7z?=
 =?iso-8859-1?Q?rFsS0/aN5NGvyraLJXlMHtTmAJisBLLqHKSf1JLPQmpF46oYK73SjuZ/Tr?=
 =?iso-8859-1?Q?8DJZdopsFOYKei7P1uMHo0sEJ9wJ8Um9uSvE7q+CfDZ1JMikEoGgawXgfY?=
 =?iso-8859-1?Q?ZcrM/Jte1oYjZS30NmAE+NfzYpzPZtjy6h1dFqrENypbkrGjs8VFwXbwia?=
 =?iso-8859-1?Q?f4WN2r3LccFPc3XjwRtzv66x2tNo8STUPSw6UIeGkcv9nMfJrO6GKmSsCx?=
 =?iso-8859-1?Q?8+abMzFBTKPAIB9rGBCManGA+LXj9jZmeV9ynd4B5nqNz9TMGUIGtCWsgm?=
 =?iso-8859-1?Q?xwyYTqsgMbHloMoIQW2aFO/4G7ytCJxEeY36d0kYVTD3wuK7bD2HGuqBuG?=
 =?iso-8859-1?Q?GLAuAl9n/bzSxNpr3DRVQhP3ossW0cSVsZo11p0IIljiRoUoMBDMtDAeYT?=
 =?iso-8859-1?Q?jtz2zz+JTA9JT/D3yYX4hVjQyoX6reCVC3zXOtMRlfTooU4gHOiOWCZpTD?=
 =?iso-8859-1?Q?gYPsyBYfbBPtuFzD/g1hWNI0/Mk6ObKSnDmNdAHHJtsZqCdLbjL68kRskV?=
 =?iso-8859-1?Q?F/M9e+JImV8alRBoAPCXxL+vy+BMZoOOcqtHyD6fErS0ZO6Fzk+Fxb2woM?=
 =?iso-8859-1?Q?hgY46NFbmsz/7hK2pHfv/J51jcwFE1kfozuBzz6qhrT2RUu1C4IRfnutmN?=
 =?iso-8859-1?Q?cuWKXtfzOnDY6Jy1/rCeMzHOMTjESbk4Bo5NGH558445PUr9H6eEiQ/I9+?=
 =?iso-8859-1?Q?OeLRISko7AFL4mqgWeDIFIOZFZhypPlLIVIJGBNLHRqpHLt70wnwCofitv?=
 =?iso-8859-1?Q?fxwQDDOeH/y8IG8MdKWoU802U+2pEINZTwpOO4363uAzupA/fR0eNn4O0l?=
 =?iso-8859-1?Q?hiAsPLARlM9m1HC04N/+B5dgHSdEUiuI/10YhCZ6jdVsKpZc0mWoI1hk5j?=
 =?iso-8859-1?Q?XHTxFAbMIFCWnx+7g8GRPJVtLHolt78OrBSij71F5HpH6CLablfPXLfEg/?=
 =?iso-8859-1?Q?mb3kxJUU=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB61521AB60AAB7EE723B590EB807D0@AM6PR04MB6152.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(54534003)(189003)(199004)(486006)(8676002)(97736004)(81156014)(11346002)(2616005)(446003)(36756003)(478600001)(81166006)(476003)(53936002)(316002)(4326008)(5640700003)(25786009)(50226002)(44832011)(52116002)(7736002)(305945005)(76176011)(186003)(26005)(2351001)(99286004)(106356001)(8936002)(105586002)(6512007)(14444005)(386003)(256004)(6506007)(2906002)(86362001)(6486002)(71200400001)(54906003)(102836004)(6916009)(6116002)(68736007)(66066001)(71190400001)(14454004)(6436002)(2501003)(3846002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6152;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UGLlFBsnfwDZaeLOfNqIzpTOsM5xXy1YkEahAB4euiGuyPs3aMu2MMy5h9zl1BJs1tvns1mE8x026KQop6rZeMwcdExl59rIK5NNGjJiw54xz6j5bjX87vn9cFiJBfzM3xl/9mpKn9ckGSgo/SBNdeMvDJc6WR3IpsySnBfb5urvY1O6B2Pv6nv0ZM5pn38IvFBhrM21bDJTcMEyc+R9GYGHZYebeKSsPZfI4JP3tKzCUiosWTdcLLpOxFojSSTW0piYlCPwfijX69uPTln5G0xVYw9dYsHrVqRVZYs1e+Gjho63oxKLHlZB8F9ZXP5vueRxrB8Fh6s5AoMcNHfl6qelKYJf8foqliLoVXGlVZv49cTovG8pLVncFtZWTfEKDfIj8wsah+JtVrytzAeUcx/6Wc4WWic1e6Z2LxaJll0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0649e01-ca57-4081-0abc-08d6972843cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:40:47.8346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One irqsteer channel can support up to 8 output interrupts.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * add error check for imx_irqsteer_get_hwirq_base
 * use DIV_ROUND_UP
 * merge 'hwirq +=3D32' into for loop
 * common error path in probe to avoid replicating clk_disable_unprepare
v1->v2:
 * calculate irq_count by fsl,num-irqs instead of parsing interrupts
   property from devicetree to match the input interrupts and outputs
 * improve output interrupt handler by searching only two registers
   withint the same group
---
 drivers/irqchip/irq-imx-irqsteer.c | 88 +++++++++++++++++++++++++++++-----=
----
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-i=
rqsteer.c
index 67ed862..d1098f4 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -10,6 +10,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
=20
@@ -21,10 +22,13 @@
 #define CHAN_MINTDIS(t)		(CTRL_STRIDE_OFF(t, 3) + 0x4)
 #define CHAN_MASTRSTAT(t)	(CTRL_STRIDE_OFF(t, 3) + 0x8)
=20
+#define CHAN_MAX_OUTPUT_INT	0x8
+
 struct irqsteer_data {
 	void __iomem		*regs;
 	struct clk		*ipg_clk;
-	int			irq;
+	int			irq[CHAN_MAX_OUTPUT_INT];
+	int			irq_count;
 	raw_spinlock_t		lock;
 	int			reg_num;
 	int			channel;
@@ -87,23 +91,47 @@ static const struct irq_domain_ops imx_irqsteer_domain_=
ops =3D {
 	.xlate		=3D irq_domain_xlate_onecell,
 };
=20
+static int imx_irqsteer_get_hwirq_base(struct irqsteer_data *data, u32 irq=
)
+{
+	int i;
+
+	for (i =3D 0; i < data->irq_count; i++) {
+		if (data->irq[i] =3D=3D irq)
+			return i * 64;
+	}
+
+	return -EINVAL;
+}
+
 static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 {
 	struct irqsteer_data *data =3D irq_desc_get_handler_data(desc);
-	int i;
+	int hwirq;
+	int irq, i;
=20
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
=20
-	for (i =3D 0; i < data->reg_num * 32; i +=3D 32) {
-		int idx =3D imx_irqsteer_get_reg_index(data, i);
+	irq =3D irq_desc_get_irq(desc);
+	hwirq =3D imx_irqsteer_get_hwirq_base(data, irq);
+	if (hwirq < 0) {
+		pr_warn("%s: unable to get hwirq base for irq %d\n",
+			__func__, irq);
+		return;
+	}
+
+	for (i =3D 0; i < 2; i++, hwirq +=3D 32) {
+		int idx =3D imx_irqsteer_get_reg_index(data, hwirq);
 		unsigned long irqmap;
 		int pos, virq;
=20
+		if (hwirq >=3D data->reg_num * 32)
+			break;
+
 		irqmap =3D readl_relaxed(data->regs +
 				       CHANSTATUS(idx, data->reg_num));
=20
 		for_each_set_bit(pos, &irqmap, 32) {
-			virq =3D irq_find_mapping(data->domain, pos + i);
+			virq =3D irq_find_mapping(data->domain, pos + hwirq);
 			if (virq)
 				generic_handle_irq(virq);
 		}
@@ -117,7 +145,8 @@ static int imx_irqsteer_probe(struct platform_device *p=
dev)
 	struct device_node *np =3D pdev->dev.of_node;
 	struct irqsteer_data *data;
 	struct resource *res;
-	int ret;
+	u32 irqs_num;
+	int i, ret;
=20
 	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -130,12 +159,6 @@ static int imx_irqsteer_probe(struct platform_device *=
pdev)
 		return PTR_ERR(data->regs);
 	}
=20
-	data->irq =3D platform_get_irq(pdev, 0);
-	if (data->irq <=3D 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
-		return -ENODEV;
-	}
-
 	data->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(data->ipg_clk)) {
 		ret =3D PTR_ERR(data->ipg_clk);
@@ -146,11 +169,15 @@ static int imx_irqsteer_probe(struct platform_device =
*pdev)
=20
 	raw_spin_lock_init(&data->lock);
=20
-	of_property_read_u32(np, "fsl,num-irqs", &data->reg_num);
+	of_property_read_u32(np, "fsl,num-irqs", &irqs_num);
 	of_property_read_u32(np, "fsl,channel", &data->channel);
=20
-	/* one register bit map represents 32 input interrupts */
-	data->reg_num /=3D 32;
+	/*
+	 * There is one output irq for each group of 64 inputs.
+	 * One register bit map can represent 32 input interrupts.
+	 */
+	data->irq_count =3D DIV_ROUND_UP(irqs_num, 64);
+	data->reg_num =3D irqs_num / 32;
=20
 	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
 		data->saved_reg =3D devm_kzalloc(&pdev->dev,
@@ -173,23 +200,44 @@ static int imx_irqsteer_probe(struct platform_device =
*pdev)
 					     &imx_irqsteer_domain_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "failed to create IRQ domain\n");
-		clk_disable_unprepare(data->ipg_clk);
-		return -ENOMEM;
+		ret =3D -ENOMEM;
+		goto out;
 	}
=20
-	irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
-					 data);
+	if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	for (i =3D 0; i < data->irq_count; i++) {
+		data->irq[i] =3D irq_of_parse_and_map(np, i);
+		if (!data->irq[i]) {
+			ret =3D -EINVAL;
+			goto out;
+		}
+
+		irq_set_chained_handler_and_data(data->irq[i],
+						 imx_irqsteer_irq_handler,
+						 data);
+	}
=20
 	platform_set_drvdata(pdev, data);
=20
 	return 0;
+out:
+	clk_disable_unprepare(data->ipg_clk);
+	return ret;
 }
=20
 static int imx_irqsteer_remove(struct platform_device *pdev)
 {
 	struct irqsteer_data *irqsteer_data =3D platform_get_drvdata(pdev);
+	int i;
+
+	for (i =3D 0; i < irqsteer_data->irq_count; i++)
+		irq_set_chained_handler_and_data(irqsteer_data->irq[i],
+						 NULL, NULL);
=20
-	irq_set_chained_handler_and_data(irqsteer_data->irq, NULL, NULL);
 	irq_domain_remove(irqsteer_data->domain);
=20
 	clk_disable_unprepare(irqsteer_data->ipg_clk);
--=20
2.7.4

