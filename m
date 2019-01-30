Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2956AC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2ECA2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zh9OgPv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbfA3NGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:06:12 -0500
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:28852
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731045AbfA3NGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iZyEx8VlcbHp8pVhJaRGjm6MZIDXJlNrzKc7nU2heo=;
 b=Zh9OgPv+oov330x0/pE6iuJ4WW7X4Mq8D2d/EOLC3x9IN6helNrgUyEEm+zkUnfmSRxEjVlpYy0r75X/ow40AZ3I5GLoSgILB1kwbPFdCoUT6goW71FTCGUuvxeSwi37tTnkIxLoBAHwvf25h8kjRiTM3Cn+H/j383SnrnfcsAE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6033.eurprd04.prod.outlook.com (20.179.32.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.20; Wed, 30 Jan 2019 13:06:07 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 13:06:07 +0000
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
Subject: [PATCH V2 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Topic: [PATCH V2 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Index: AQHUuJyQDrz3jPZXTky6ZbN3eVmsCA==
Date:   Wed, 30 Jan 2019 13:06:07 +0000
Message-ID: <1548853196-11447-5-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6033;6:kLCcIYEpCAphVf+zSpB4imF4zgKuC4L6xKDRzwfAeq5iyikPlzbl4YYTMXdQSa2iMReXvOiZyWOriSorZcnY+SRMcjmjGRsgSOW6V4fWl9ziHIKEoWxmq8lulA/EawmmZzLccpIpYMSXudNqY+1AWU5JzFhH5QHaD7YPRmWD8Pv3EkfUYTe9xFUaf+PrfDafyupexQeUWAaR6Tbbz2UML/mZt0quqIeBL80chKpAi8pLc6NnZt33Rbcz1jHdA7zaPHs7kjIdv7y6j7NmZYC/otKay4ElCtXU8Sav7kiGi6PVjwKUVC9TRUZ3aAiASeqmDHYPHJIUBBzfPaNLVfS9Y64sSpmwh8dyLXQWDgW8WcMXi0c5YGmZH9k5bW8tYLsxQv5rZhfQQxAGsZrYA+kZ2C+G5mIpyA5CSf897QvowO2mbwa6D79ahFEu6srVDgrE+Q4KGqHClieV6qaVYB1m4A==;5:/2DzkUBRRrU1FJXt8NV0B+Pa6Q3kO1phc2mgbQ9ahRiQ859kppyrozF6LihHgGuGlZW7veCXO+Ov2fpdZzurZsyqUREip5UdlOM4hi0g/VkpBMoMDQPl6vCXBe0pSgqUI7uculXvrE/xBNQfD0Zw1XAACfbnZZukEwB51xWxikhO9kXT+Hk2OTMxWpnt1ns2wuM2hks/UbGlGJwcdOKyWQ==;7:IUoQp9wDzhMX+e/pznwQw0n48fueNcmmQMZ/Q+v2I5XxDOdI/9x9nNe6DIt+LCdkJJfLRaA4nNCdfCmfVKtNRtqeP9Ylz6T/hzFt1tJoHxTYST5FR3VTTm98QhpeSnAY4iosHt0Q/UbeoiBzLNciTw==
x-ms-office365-filtering-correlation-id: 68a71300-6f91-4fb9-a334-08d686b3b23d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6033;
x-ms-traffictypediagnostic: AM0PR04MB6033:
x-microsoft-antispam-prvs: <AM0PR04MB603335C18A579F894AB2E2D180900@AM0PR04MB6033.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(54534003)(316002)(81156014)(50226002)(2351001)(106356001)(71190400001)(44832011)(486006)(68736007)(52116002)(186003)(71200400001)(4326008)(25786009)(26005)(105586002)(478600001)(86362001)(76176011)(102836004)(386003)(6506007)(81166006)(2906002)(8676002)(476003)(97736004)(6916009)(6512007)(53936002)(66066001)(2616005)(14444005)(8936002)(6436002)(7736002)(305945005)(14454004)(36756003)(54906003)(2501003)(6116002)(6486002)(446003)(11346002)(3846002)(5640700003)(256004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6033;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v2FVSBbHVn6K37lroBNqIXfPM22AmOrpLk6Atpt3f2sdUJ8NnbZSTtsC/OlzcoxGT6KqNZkLM84zYkmFIJbB4yj1s6wKa7BAo/zGMxBFonvzq/8hrMWW38kxk4n4m3kTxQXMeL5Nr1/9vqUtBWEDKtCOuhoVUmVR3sQVkBCrMCXwdBNXYqzZA8DjWIOUIzkq/Lb6yJdMCCQIYZ4RfoLNqqe7LGCMCXjTkoLWA0pwtLJW0MF2crrYBPCFUmXZvPfroVh4C1MMAavFFrRigHd3SnsuA8Q+K1lEEGRfLsTuNmDqgF+FGZ7IfXhEKRlmWsEarVCTzsaJ2P4mV/UZ9Q60+AjdH75qb1916uxLPIE3X8qgpCBC0nBXO4f8MWQWzE3BnzAf7ca/8PlmDlPJkXU0Wu72q3J/fopzV0pRBpNqWKw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a71300-6f91-4fb9-a334-08d686b3b23d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:06:03.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One irqsteer channel can support up to 8 output interrupts.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v1->v2:
 * calculate irq_count by fsl,num-irqs instead of parsing interrupts
   property from devicetree to match the input interrupts and outputs
 * improve output interrupt handler by searching only two registers
   withint the same group
---
 drivers/irqchip/irq-imx-irqsteer.c | 76 +++++++++++++++++++++++++++++-----=
----
 1 file changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-i=
rqsteer.c
index 67ed862..cc40039 100644
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
@@ -87,26 +91,45 @@ static const struct irq_domain_ops imx_irqsteer_domain_=
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
+			break;
+	}
+
+	return i * 64;
+}
+
 static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 {
 	struct irqsteer_data *data =3D irq_desc_get_handler_data(desc);
+	int hwirq;
 	int i;
=20
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
=20
-	for (i =3D 0; i < data->reg_num * 32; i +=3D 32) {
-		int idx =3D imx_irqsteer_get_reg_index(data, i);
+	hwirq =3D imx_irqsteer_get_hwirq_base(data, irq_desc_get_irq(desc));
+
+	for (i =3D 0; i < 2; i++) {
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
+		hwirq +=3D 32;
 	}
=20
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
@@ -117,7 +140,8 @@ static int imx_irqsteer_probe(struct platform_device *p=
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
@@ -130,12 +154,6 @@ static int imx_irqsteer_probe(struct platform_device *=
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
@@ -146,11 +164,17 @@ static int imx_irqsteer_probe(struct platform_device =
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
+	 * There is one output irqs for each group of 64 inputs.
+	 * One register bit map can represent 32 input interrupts.
+	 */
+	data->irq_count =3D irqs_num / 64;
+	if (irqs_num % 64)
+		data->irq_count +=3D 1;
+	data->reg_num =3D irqs_num / 32;
=20
 	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
 		data->saved_reg =3D devm_kzalloc(&pdev->dev,
@@ -177,8 +201,22 @@ static int imx_irqsteer_probe(struct platform_device *=
pdev)
 		return -ENOMEM;
 	}
=20
-	irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
-					 data);
+	if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
+		clk_disable_unprepare(data->ipg_clk);
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < data->irq_count; i++) {
+		data->irq[i] =3D irq_of_parse_and_map(np, i);
+		if (!data->irq[i]) {
+			clk_disable_unprepare(data->ipg_clk);
+			return -EINVAL;
+		}
+
+		irq_set_chained_handler_and_data(data->irq[i],
+						 imx_irqsteer_irq_handler,
+						 data);
+	}
=20
 	platform_set_drvdata(pdev, data);
=20
@@ -188,8 +226,12 @@ static int imx_irqsteer_probe(struct platform_device *=
pdev)
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

