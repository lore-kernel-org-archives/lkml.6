Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D864C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180B52087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JF5VEHbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbfAaID7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:03:59 -0500
Received: from mail-eopbgr150057.outbound.protection.outlook.com ([40.107.15.57]:30816
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727365AbfAaID5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqCduKBcshxl+DEEKlQRby/4/v2bbF8FG40FIoXkymI=;
 b=JF5VEHbpPx0qhInARIZtx841OQcQ+PTRKpdhPz1inbVhKZ8HoezKLf3uyWpmW8R21w+r+PufP2+PGESUlHmFO4HEZTElerhz9ZFhDu//RqE+KnTOrQuHptMoXp9ONO75JRtRKxvf1G5V8ZYts7nnxqr36pQf7iIr7QsRxcZWMoc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5796.eurprd04.prod.outlook.com (20.178.202.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 08:03:51 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.019; Thu, 31 Jan 2019
 08:03:51 +0000
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
Subject: [PATCH V3 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Topic: [PATCH V3 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Index: AQHUuTuAmCHwpO5YikqgCmsF+8ZU4g==
Date:   Thu, 31 Jan 2019 08:03:51 +0000
Message-ID: <1548921464-28917-5-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5796;6:DdwLQ8LnTK4sWHvmTnIkEMkB2O61t1sYmn8sODu+7XGsVC3esDYMeveAorwItETzrt6ENjBvSLJGX9r5wDTz4uac18vHb0kV+pIweD/+GWtm5JeM5aJW0QlFIFutFIFdTbQgHZ5K+ljfXPG8wtxyQZnyQ/SWOE7sLiqTXAzW4tC/IDYEJMn/g7ISiq+Vvicht6buoU97WkFCQC85hNuNInklXo7EuMNawgj5jTUSI5Zwgvn0DX9q46+n1AUNDa2+1JeeZlzQymkC3rCu7mmS/zoFInUxpIu2N7L6laqEiF7+3blCMyngyG4MQp4L7xrE2MhE4NyNl71omuPMDEKxTmKzNMcUKNKHZlc34CNABwXTgpniRGmqAckpsId5sISSIPkV/sl+fI63HDGDvG9o8gI6o2XP+P4rqBusCgLPMOfZsWxsUiyKIvqimb54c+ji7aw4BKBlkE6sTghIeokHgg==;5:jn5/0KP+naxlfAq8GiTl+ankb1sd2r7H7qzkyq2Ssf17j+LuWElx99UvLJrBd60nImZqZjtfk+JvzmmoP+CXCbgvn044GVWylnY33oI0v/kw83pVan17i9JsIquSeDSF3tQni/yVLhZ2uI39M+JM31ML7BV+FLsL57A1xRm4pN1I97RdDgeEiuHm9oG/hvy96PyI+avWjFncb8W+/0c5vg==;7:qQYzCRJNkMZDqnmtDCCREy8t+vi+gDscS3SdxW/fWzguyrFtckaoWuKa+P85Z5WaXEYMHzGqyugKPdew/5Lnrv3w/EjQVaTMwkvQ/0Xp6RX7ejZJkoVoXNccVcN3gXNI/dQ7pgzv/jRFir/olbLWkA==
x-ms-office365-filtering-correlation-id: 0edae114-4623-42d3-9940-08d68752a2e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5796;
x-ms-traffictypediagnostic: AM0PR04MB5796:
x-microsoft-antispam-prvs: <AM0PR04MB57968D6E795C34ABEA82A90480910@AM0PR04MB5796.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(54534003)(199004)(36756003)(8936002)(71190400001)(25786009)(6512007)(106356001)(50226002)(4326008)(99286004)(14444005)(81166006)(71200400001)(8676002)(52116002)(6916009)(53936002)(76176011)(81156014)(14454004)(2906002)(256004)(478600001)(2501003)(3846002)(486006)(44832011)(476003)(102836004)(2616005)(7736002)(6436002)(316002)(6116002)(6486002)(5640700003)(68736007)(26005)(186003)(446003)(66066001)(86362001)(97736004)(6506007)(54906003)(105586002)(386003)(2351001)(11346002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5796;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VYS7SHiD8bwS/YMIPh6npLxqJB1zITS7OcuY7SVd7HXEF0oiAUGYLcvhuSrl/3pyJytaGvzY3pMXwJde7BvGv9JTX/P0Kr/1n50P2pEn7e1iUdBMkeoBj6s9IXxcOcUDEJvoYsXNNsj42CkRHYwkMAyvmnUU9x8x2qY6NZyf+OQvP7PprRHxMQ4C0nm7DiU8/yapS6V1EH+L5H9IteoLaJYo4Eiz/z47QWl+UoqNLIuS1KN8xo0y/cj5H05i1G0Se98ooR44Qwj2jJZMmWFVlTUYMsPCw7DkmCtzdDvVaU/MTsHYW2KS0YQ8KJFV2Ba/C+fRpxTwwqoISlQ6meqyfLN2mMCGg9wWLdoyyL2pK8dT04PlN3wce+P3SH4TMi0bjK5FD/29fdtuuiJXxLEmeDFqr9QCriCHml/+iRRFwT4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edae114-4623-42d3-9940-08d68752a2e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 08:03:47.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5796
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

