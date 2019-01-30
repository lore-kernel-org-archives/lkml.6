Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBF8C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE5921473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xBkkq1Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfA3NGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:06:09 -0500
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:54669
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730979AbfA3NGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7msFvan8Dl/n0+dabE4fBcDUeL4umXBPtYx/wRZvyYM=;
 b=xBkkq1QbYnvuTXEG6qxvyL6A8/bJsazpVOmbNhdeIH3WReoispjxDOPSq4Sd3UEC9VNt1cMEHST4+dmO7CAN1yPH5S+71ZqHhXwr3OyMfNW0rLYqSw/arcIjEvESCil08sRZVbND+7ahe/cMGNEmuHSvIRailwF/b3vX8rl/6O8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6033.eurprd04.prod.outlook.com (20.179.32.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.20; Wed, 30 Jan 2019 13:06:03 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 13:06:03 +0000
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
Subject: [PATCH V2 3/4] irq: imx-irqsteer: change to use reg_num instead of
 irq_group
Thread-Topic: [PATCH V2 3/4] irq: imx-irqsteer: change to use reg_num instead
 of irq_group
Thread-Index: AQHUuJyNnC/wXmpemEueUk0sVv7qiw==
Date:   Wed, 30 Jan 2019 13:06:03 +0000
Message-ID: <1548853196-11447-4-git-send-email-aisheng.dong@nxp.com>
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::33) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6033;6:pjYCmkkG5fMbxvRlzrXhHgg8AH5YSq8w+hMdvMGC0aVk97ed9UOW9pN/BzV+NRpZDts+gJ/w0HM7i7WLs9a79GI6LfhREnx6hsnCBBAd4u4Zlx0crRPEvEK9p/dPs7iuo9sOzwXyN+c8V5kKyKtufp4/6B1yYFnqqT38JRxjUKm7HvqUhNbmuna4eBmKq25TSyXwsZeue6YeMzPDskIEgBKx9ZdaTKRfTtBD0N+qxxAMFUoekrL4s5AkdCAORJFC/OvWo9IsN1qsRWb6E+2T/jc8s1dJF2z9SnNh+Q+lVtUfSQMFHPYAB4OIpnDWr6FpwzH00wA19DuOQ9nP6acPNgZkzU/Q/Iay5NEpQVBOAHWvocFusg24S9fyZg9CS7MRKpf5QF+UDfvahkmvfR5R2gXxOsB5zwuFKyi8scJ4Wrc0kodN7DkMvvOK27j4Ey6FtLc672/Q8ek8IwQ6nmnX7A==;5:GqVur9JycZT3JA+hSMO5HBtmH8TYHyteGcSXUm0XRx3E7NgiHTbswQpJ33GsCw8vG34+gGdGCk24K6iRCgxO83Rbpgv0fSE+27limBT1W8RO1DjWzVPZqeJS/fdzuj9o2bfJWsY7oFYGS8+bJDkcw9nb+qN8xUbBsJ3mx6XBX6LerXRtpydnm5Eqsxeqi5JpgYINlojXj2gBlqBw/TWchg==;7:txhLYWmODbcvVOzSCoEFMzGNQwUK3wWTxdWxzfPohZlykaWJAWIOIZ4gXWoyFMMCb9naJrwNQxDEMeYmYAIRbSOWadhT44ugDjD25ewwdXhK+8q8GORVNEpsHNxFFDdqmER5+vNZyC7V+MgtZOPa8Q==
x-ms-office365-filtering-correlation-id: c77d88e5-92d6-4402-67f3-08d686b3aff7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6033;
x-ms-traffictypediagnostic: AM0PR04MB6033:
x-microsoft-antispam-prvs: <AM0PR04MB6033B9805657CEBA0EFB8F4C80900@AM0PR04MB6033.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(316002)(81156014)(50226002)(2351001)(106356001)(71190400001)(44832011)(486006)(68736007)(52116002)(186003)(71200400001)(4326008)(25786009)(26005)(105586002)(478600001)(86362001)(76176011)(102836004)(386003)(6506007)(81166006)(2906002)(8676002)(476003)(97736004)(6916009)(6512007)(53936002)(66066001)(2616005)(14444005)(8936002)(6436002)(7736002)(305945005)(14454004)(36756003)(54906003)(2501003)(6116002)(6486002)(446003)(11346002)(3846002)(5640700003)(256004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6033;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y0nEhO05NV+/CLIvG/b7E46gk1UiCAbJ4iaKfwkFwJGqzCNSVtrnLXFpSHWKVZwKfX23ek/JHMtrdlRFTC2+YeBRM+7ENGF5MXz9Krt6sCmlZoUNoMRd0b/+qjWc+yQNlBF6am6JwkiOpd7sj5xQLjuN1Vs9HxVWqyPvrMnu3oPBl6TjYYFkBpLV2ABMIc6RIMBTdk1G6B7m9VGZKL5DqpWbahy84z0yxTRHaXPlfyWx/+qTGJ7TyjD+6hYy1Log/ru+UXNnpNN2QZ/j2HjtGa3BuZvTtQ82Rt464rjA33Q+ChdrSVGTnBUCpFJeoTf91rv3KwU0k79KiNNfgv4XYVHLBZAUFyUKKWnQuRmpcNdHh92SOF/bT+V0yTmIn9e4ERpVXhhyQYJsgIPeu5t4rz6mSsdk4Z00ys7FcFCTXX8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77d88e5-92d6-4402-67f3-08d686b3aff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:05:59.6335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One group can manage 64 interrupts by using two registers (e.g. STATUS/SET)=
.
However, the integrated irqsteer may support only 32 interrupts which
needs only one register in a group. But the current driver assume there's
a mininum of two registers in a group which result in a wrong register map
for 32 interrupts per channel irqsteer. Let's use the reg_num caculated by
interrupts per channel instead of irq_group to cover this case.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v1->v2:
 * The using of property name updated accordingly
---
 drivers/irqchip/irq-imx-irqsteer.c | 35 +++++++++++++++++++---------------=
-
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-i=
rqsteer.c
index 5b3f1d7..67ed862 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -13,7 +13,7 @@
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
=20
-#define CTRL_STRIDE_OFF(_t, _r)	(_t * 8 * _r)
+#define CTRL_STRIDE_OFF(_t, _r)	(_t * 4 * _r)
 #define CHANCTRL		0x0
 #define CHANMASK(n, t)		(CTRL_STRIDE_OFF(t, 0) + 0x4 * (n) + 0x4)
 #define CHANSET(n, t)		(CTRL_STRIDE_OFF(t, 1) + 0x4 * (n) + 0x4)
@@ -26,7 +26,7 @@ struct irqsteer_data {
 	struct clk		*ipg_clk;
 	int			irq;
 	raw_spinlock_t		lock;
-	int			irq_groups;
+	int			reg_num;
 	int			channel;
 	struct irq_domain	*domain;
 	u32			*saved_reg;
@@ -35,7 +35,7 @@ struct irqsteer_data {
 static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
 				      unsigned long irqnum)
 {
-	return (data->irq_groups * 2 - irqnum / 32 - 1);
+	return (data->reg_num - irqnum / 32 - 1);
 }
=20
 static void imx_irqsteer_irq_unmask(struct irq_data *d)
@@ -46,9 +46,9 @@ static void imx_irqsteer_irq_unmask(struct irq_data *d)
 	u32 val;
=20
 	raw_spin_lock_irqsave(&data->lock, flags);
-	val =3D readl_relaxed(data->regs + CHANMASK(idx, data->irq_groups));
+	val =3D readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
 	val |=3D BIT(d->hwirq % 32);
-	writel_relaxed(val, data->regs + CHANMASK(idx, data->irq_groups));
+	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
=20
@@ -60,9 +60,9 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	u32 val;
=20
 	raw_spin_lock_irqsave(&data->lock, flags);
-	val =3D readl_relaxed(data->regs + CHANMASK(idx, data->irq_groups));
+	val =3D readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
 	val &=3D ~BIT(d->hwirq % 32);
-	writel_relaxed(val, data->regs + CHANMASK(idx, data->irq_groups));
+	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
=20
@@ -94,13 +94,13 @@ static void imx_irqsteer_irq_handler(struct irq_desc *d=
esc)
=20
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
=20
-	for (i =3D 0; i < data->irq_groups * 64; i +=3D 32) {
+	for (i =3D 0; i < data->reg_num * 32; i +=3D 32) {
 		int idx =3D imx_irqsteer_get_reg_index(data, i);
 		unsigned long irqmap;
 		int pos, virq;
=20
 		irqmap =3D readl_relaxed(data->regs +
-				       CHANSTATUS(idx, data->irq_groups));
+				       CHANSTATUS(idx, data->reg_num));
=20
 		for_each_set_bit(pos, &irqmap, 32) {
 			virq =3D irq_find_mapping(data->domain, pos + i);
@@ -146,12 +146,15 @@ static int imx_irqsteer_probe(struct platform_device =
*pdev)
=20
 	raw_spin_lock_init(&data->lock);
=20
-	of_property_read_u32(np, "fsl,irq-groups", &data->irq_groups);
+	of_property_read_u32(np, "fsl,num-irqs", &data->reg_num);
 	of_property_read_u32(np, "fsl,channel", &data->channel);
=20
+	/* one register bit map represents 32 input interrupts */
+	data->reg_num /=3D 32;
+
 	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
 		data->saved_reg =3D devm_kzalloc(&pdev->dev,
-					sizeof(u32) * data->irq_groups * 2,
+					sizeof(u32) * data->reg_num,
 					GFP_KERNEL);
 		if (!data->saved_reg)
 			return -ENOMEM;
@@ -166,7 +169,7 @@ static int imx_irqsteer_probe(struct platform_device *p=
dev)
 	/* steer all IRQs into configured channel */
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
=20
-	data->domain =3D irq_domain_add_linear(np, data->irq_groups * 64,
+	data->domain =3D irq_domain_add_linear(np, data->reg_num * 32,
 					     &imx_irqsteer_domain_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "failed to create IRQ domain\n");
@@ -199,9 +202,9 @@ static void imx_irqsteer_save_regs(struct irqsteer_data=
 *data)
 {
 	int i;
=20
-	for (i =3D 0; i < data->irq_groups * 2; i++)
+	for (i =3D 0; i < data->reg_num; i++)
 		data->saved_reg[i] =3D readl_relaxed(data->regs +
-						CHANMASK(i, data->irq_groups));
+						CHANMASK(i, data->reg_num));
 }
=20
 static void imx_irqsteer_restore_regs(struct irqsteer_data *data)
@@ -209,9 +212,9 @@ static void imx_irqsteer_restore_regs(struct irqsteer_d=
ata *data)
 	int i;
=20
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
-	for (i =3D 0; i < data->irq_groups * 2; i++)
+	for (i =3D 0; i < data->reg_num; i++)
 		writel_relaxed(data->saved_reg[i],
-			       data->regs + CHANMASK(i, data->irq_groups));
+			       data->regs + CHANMASK(i, data->reg_num));
 }
=20
 static int imx_irqsteer_suspend(struct device *dev)
--=20
2.7.4

