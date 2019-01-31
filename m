Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EDAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD6B2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xmZmZaeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbfAaIDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:03:52 -0500
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:11079
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731484AbfAaIDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW2lhuIyoeeQJ+rie/Bh1DR7IkliEsQER/dZQJDLces=;
 b=xmZmZaeW+UMMuVUdhQacNcfJij1ghKMQLaZBTCNAjq4MQmwSWx1+hSk6CKdwsOGHMa10UHAW0SeFnY0oQ4ABqIgg2HlLxr+0uNY4CFVwj4jFtfZNYbC/KSBqphr8ceCNUz/bcNw3t89Hzn5S1dE5qTSvzzuCxj4t1c57Q2YkjKQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5796.eurprd04.prod.outlook.com (20.178.202.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 08:03:47 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.019; Thu, 31 Jan 2019
 08:03:47 +0000
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
Subject: [PATCH V3 3/4] irq: imx-irqsteer: change to use reg_num instead of
 irq_group
Thread-Topic: [PATCH V3 3/4] irq: imx-irqsteer: change to use reg_num instead
 of irq_group
Thread-Index: AQHUuTt+3c32KigClkm9+7rmTqo/Dg==
Date:   Thu, 31 Jan 2019 08:03:47 +0000
Message-ID: <1548921464-28917-4-git-send-email-aisheng.dong@nxp.com>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5796;6:C75flqW07dOR5djipAgLXLkmODDtwXRtcPuyo1fOIw7yOYqEYusRBW9bFGI8m5mbMt0/qDxpWRH1wLEjd7VjsuF0feIvGgXVq+NAsorAP/Kz9Knhjm5C7HEt20LT7Oy4uQvGRra0raEkIRjF0IFHQgEyaK9SO68vMDM3r38m0Q+nHyNuOzi99l0X+JjufRCAAjBkT7FEudSwJMDWqxX4XeQp0U/w2lvnakhB3T+a7cspQgQdeVzna28otPqpeXxXZoCQbFVjkd0YuVtts9vYNGjmujtZ47Fv48iYAQIEGSyoo1eUAYEeyB/O1+E0Nhk/eRtJYWIddeZzwDPMRMjEDPU3LUj6YjRzdHWcNtHWzKcEQHMonyTldQ8hzgfBRwDmlWtYsJ+fgaEl0P6MXsH9FMaf8ib9JDQuuZdR7+G3RmHzGzEIrIsBHEQJqNCeiD8wAEUwKFy5YsgDLTL/rnNUKQ==;5:T7MCPQA86BVbiZXd9riD648G8578pdxOOSzqHNaZ/at9w/9XdT+Yjen20WyWGyLK3A6zPWM0w/oujQYWcN9/noBHfOK7C2E69Xsy3p61UIosL9wepRODAJD432jbMPv3TLzz5KymHnZwQ8kjLNHq/NERavIzoewiXTlcpuyaD2YrVOShZxzHL46ZDZLiD1kf2peD8XqT52IqKOKH+Chhxg==;7:BD3HxkpG9YC73d05NLDToOel9V04oJ337wejSe7BKxo1vkhqfhODXCzGDkOzuN4da+o5gwN+bs9RilVPDkaBWpzLv148xC6uJUohJ8JqKZWLF7+rhFSggDzh0tVFyXZE7rhGQ4HPrVzuS7Qq5f8MSg==
x-ms-office365-filtering-correlation-id: 1734262b-f61c-4372-55df-08d68752a09b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5796;
x-ms-traffictypediagnostic: AM0PR04MB5796:
x-microsoft-antispam-prvs: <AM0PR04MB5796801C078DC0909AA5168D80910@AM0PR04MB5796.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(36756003)(8936002)(71190400001)(25786009)(6512007)(106356001)(50226002)(4326008)(99286004)(14444005)(81166006)(71200400001)(8676002)(52116002)(6916009)(53936002)(76176011)(81156014)(14454004)(2906002)(256004)(478600001)(2501003)(3846002)(486006)(44832011)(476003)(102836004)(2616005)(7736002)(6436002)(316002)(6116002)(6486002)(5640700003)(68736007)(26005)(186003)(446003)(66066001)(86362001)(97736004)(6506007)(54906003)(105586002)(386003)(2351001)(11346002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5796;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CPHWHPMoERdvemyoSo2sx9Qj0++MVvvxqcV0JGDqFZVX7yLY1cQVg5B5zMpBZvXw8TIeBgmByCKIoCvOi0+awW3JPyiBz+3scy/N8fnAc8OKaQzzeG/4z/swV9DONFj69c8sknvHUR3VMXqf/gPiGag6cR6zUWtfu2qo0RHjIXfibETkZ8fRuMx4ck5tO8YdxwOQ7kj1pwQw5DJ8GmbiiDfq/tbG4B/wTeBu8TVhX5cnqMNLdG2LqhE3EIQBv9MihaqTUOqidkRspsH3H22E/qPkrtZd/Gmkw4M7sYeSswoTmMWkp0hacn5+w4JJaq0yY0XmtQMHOTRhJUt0XUh/KK9T1TDsfuLn4HLwGCrs9HDjlqMuNLW0qjMjnHnGFHNGqG7g0Uv6JqYMV2fbbmk+kDkuh6qYW3NJsITzwYPx7Dk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1734262b-f61c-4372-55df-08d68752a09b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 08:03:43.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5796
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
Cc: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * no changes
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

