Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6FCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642E220850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ny8CGAvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfARHyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:54:04 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:43232
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfARHyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIGfn5A46yStq9TWiDBGW+Fpnt/K8/D1H2RpO8tkrmw=;
 b=Ny8CGAvbi9sG+Rgznw2gn3pHUeuyaEn6Z+bsuCDVZG+3YZyjmEYpIJNbHfXFJAnB3TNOnFA8mMc+xvwnF4eqrmaso7jxkvSqWXJjnPcNdAIQOu4DXPyLGwown3icBr462AuuRLjw7oqheejppLQwzwQ6Lmea8n61yPW923SG6rs=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6001.eurprd04.prod.outlook.com (20.178.114.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 18 Jan 2019 07:53:58 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 07:53:58 +0000
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
Subject: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts support
Thread-Topic: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Index: AQHUrwL34aHTasx2wUetvBoWoE17FQ==
Date:   Fri, 18 Jan 2019 07:53:58 +0000
Message-ID: <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6001;6:Zmysa1xNPkMohOVRPC0Y4RM0D7qLtcSvYNl3W19BNkGRgeuygxrNONoLmJbI7OwpVi1YzOQ3C5oMcmHKurrTWijZoaKgmvBiiWNhmCzacmzefChg4l9UEFPTBy4gAowr47FFV9G/rTRINxtAoLU7wsboAemqHTwoEGpo+kqoj6Qy8PLsxglxPFO8VUHWt48ZnV1Fpw5vwTniEvpDFhAAm/4s0Ui8foatL/2z3DREr7xkLug6T2x7JwtzBWK+bfLQxNyh4x7qDquCE9i+8Vz/gYGbfeIa4j5uYJvn0cXY/tXodVLe51E9C42KCFiEUY4Uwb3pOGoBfnqjJM0nEx+XL1HF6ytvo/KhL7tOmiRqJiWfZ05JLhfquhKZ91HjSUdyAyoDIi3Cm5/9LhAOGOW+BNSMG8fTBaVE05SvYPeha9VbWBC+/78jrcXmbL/HKMbosbuosu9rJxtoJsPup7hnjA==;5:44hsmSN+EplNiMjcnEAycUW1VfFkDmpHWxCv9ZHxufS0xztK/6KtC0WYPmTyAWDfRDvD4XdHMa6gPMOUiAe5rhzzUEP7wOszXcI6Qr97aTMUJF/GafhOvyCrERUMVCXgYG4i0B1iCnO4KmL2A+o3TH1CaY8IjRJ8kr73SLK4Io/fN8WQZqgiuh7P4EwuCCgEqGevaBlSA/4ddJTKawNlwQ==;7:a62NV5sYlxjzLY2ZFKnW5xcVHGCM5dPn5zsPDmjWD8ktNCjH1TbE2L22nQQ94A9yWxcn39Q3Cqm4tali2N5aIvGJDA3LGNe/OdVJQns2NI0edbdgV6rXxT49i6dZY5kzfb2P+1EKeDZ7of22G4NAHg==
x-ms-office365-filtering-correlation-id: d146110a-99bc-4847-310b-08d67d1a1a4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6001;
x-ms-traffictypediagnostic: AM0PR04MB6001:
x-microsoft-antispam-prvs: <AM0PR04MB600100E098FB83BD71225C6E809C0@AM0PR04MB6001.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(7736002)(486006)(54906003)(81156014)(316002)(256004)(6486002)(305945005)(53936002)(99286004)(44832011)(8936002)(8676002)(36756003)(81166006)(6512007)(2501003)(5660300001)(6116002)(446003)(3846002)(2616005)(5640700003)(11346002)(50226002)(97736004)(26005)(105586002)(6506007)(71190400001)(71200400001)(2351001)(476003)(186003)(102836004)(6436002)(76176011)(4326008)(25786009)(52116002)(386003)(86362001)(6916009)(2906002)(68736007)(66066001)(478600001)(14454004)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6001;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /SCkvsexO/G5F2pQKAlvy+fDvEcn8uNKafXu1VbMOfu2Npj0Az5nexLV63+dILfqi1GSou4G+9QWc4NlVQHZlCaaG2zSWoP24+aGggok9aXt8tW9BEoRdMkvEy37u/VixDl0rKlP6CPfdAEDvP29q4hBkpdbM/r7TIuvbcsSCBm+GiaYcHbU1lMwUJBphSFKnznHw23CeH2a6qsyYDxCI/027xAIjPxPHo4jd/jhuVdq7H9Y43GrJxazD3S95gWS448Fz7ZbPQ6HwjuNrDlDwRMu8vHfYOu5FhhGpW2xtnRzH1EWxLvJxrb4y4iQu6K6SgJ0C4HWjKRrarX5AuPCA0trWS5TkYkuhOHvPPyT0KT2FKVWCO8rggSzv50Ejwn27lmQWrpVG9BK8ZSyO8NzQExVKFxmKGTV+nzSxV7ssb4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d146110a-99bc-4847-310b-08d67d1a1a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 07:53:54.2842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6001
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
 drivers/irqchip/irq-imx-irqsteer.c | 39 +++++++++++++++++++++++++++-------=
----
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-i=
rqsteer.c
index 1bebf0a..54802fa 100644
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
@@ -117,7 +121,7 @@ static int imx_irqsteer_probe(struct platform_device *p=
dev)
 	struct device_node *np =3D pdev->dev.of_node;
 	struct irqsteer_data *data;
 	struct resource *res;
-	int ret;
+	int i, ret;
=20
 	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -130,12 +134,6 @@ static int imx_irqsteer_probe(struct platform_device *=
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
@@ -177,8 +175,23 @@ static int imx_irqsteer_probe(struct platform_device *=
pdev)
 		return -ENOMEM;
 	}
=20
-	irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
-					 data);
+	data->irq_count =3D of_irq_count(np);
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
@@ -188,8 +201,12 @@ static int imx_irqsteer_probe(struct platform_device *=
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

