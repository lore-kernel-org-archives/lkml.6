Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE72C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FDF21729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fDRNMAl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FDF21729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbeHNTjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:39:20 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:35184
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730635AbeHNTjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbakp1dOU7bUrEddsQf8AthdS8rMaFs4matwXeJTTBs=;
 b=fDRNMAl9YQ0lVxSilZoGrJ819Rs1kYIxNlwgxxoiDs9k50WPHEUnhxCXHCarIQaC+SwVEihYeh13iIuT3VbebiXwSHscAN+/WsW4fkgGa3HKSKztQTjx6sVg+ADvZyfF15gJSsA7VkioO+MG5xj+zRkgWwkeBpBgnE+ijk87vJ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Tue, 14 Aug 2018 16:51:06 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 6/6] PCI: imx: Add PME_Turn_Off support
Date:   Tue, 14 Aug 2018 19:50:20 +0300
Message-Id: <7079253f4622c78a6c8a911dda1df60a3198a9a9.1534264292.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1534264292.git.leonard.crestez@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0102CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::18) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69913165-7cb6-49d7-a6f0-08d602062183
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:y6eKM+AMuIG94qQIwqfVoams6guFLHhEl1CgqPP2fx7XBeBwL4Lwimjn6vGm99blxSq3A2VKcFQAV1T0dtrgjEah/HXhjEvBwuU5MBgau9XucLJZzjqLuP4aa/7LZFmZAEjlAhXlKqmg1ejFtpM8w4A3l8C1ekHvHErWLjTPvrU6lByyNXzC80ngulVrHH6DU8srymJxYhuvkWlgip+EfRhOCUYue6AuTcC0cWlFlTTcVpnavJM2K+uy5VrstDgy;25:dQoVkd4opzXNO2M0fKALZRtshvbCFL3XvRuKwouPAg16V/nJcniWNja29Fdaw+ErYgB8QjGoAzLklIE1u0ec0UmCNV4B3mb2HmJ9CojQsjF9RKEoccT+joG70c59YkYoKkFFZ6cjp8V2AokO3afTju3ktY/q399YWyBQYHGdX04Zk6M7E6cQA7Er2V/ksxFhauXChMRO/gH8OnuFgcyITKAO2qGgU1NwEh92yqW6i6nVnxoMbZe+xlmpPx81xk2i+I7xbIJs/sbq6WvXCLKIgh9RE1t6ie1tNG3fV9VGsy7ykiN/D68mC+vFoOH9wyqwnHM7IhXKn/9daeBx8ZMJQA==;31:klKgXHUBpVTWZjW3ARAv63A4pFUNAsA+Otoc2G90agiF2vREG+ETkX9pMLlO4tX5HmCFzDo4WsBmI68O9nIHglLFMsx8x1X+3JrUbMkkide1jmTKYY4y5SL2qcou/8sKQSA6ugkh6P7lEplXHIksF5Mk5cK6X4+3ys31q1S5++agwNEVNKZ/bxMbAB2QQGuD1s+6nXUjWKwIfG+hlDSKn8O0Wl4wee3Dy7fPpaaxqtA=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:e3x/TliQOPPJx/6Kdj1pqrsriUB01CoZAafJwuriKYJv85r/JLUQc3KsfuDcjK8pb0S7Q1nYs/+BfFV9uDWZAPM0pFnA6TUaG920ZuehlorYuTHjoSvodl+oMXKqEVPWOVZD18q8kb7QoLBao6NhmB3g9SFff4OExF+rrlwgFqqxg9cKnW9O98kkNSkZpIZeuBK6aVbba30olXjrxNOMB+hZM1by9PNGdpE5lnRYBqUWa8aK/AnisI/fSzyFBoLQKIxt7+IS9JK66pG5qmZ250w0BeEVCG5WOWnFxoWhmJcydWp5RAllnLFe1wKrK4XsTt3bWWB/R2zMKjVbO5M9JGBgQaj5fJRCeyWf3kzb8RiVIR/Ar/9I20gpjvTuoC7BBmfHWerIgWXrnqy3FQiZMgF4eh3Vy6d3IVTp82ZjcuYew0Nsf3UzMuxAcQBxuUe2NktrMHa9FKSZ6qgx+7ww66L0bVvsdzER1CaWXmz+Yo6qHP2vd6i7W7ZqaGrKcZkg;4:Vq9C7bsud+TvS5Vy4SqsMbobu1nOfJC7iByxPn7KiwFVCbYFQTy8ZozWxLgC4H+986nvZYCEFL+FEEp6hJWcLpJ+/DqFGMH8Vsg0s+h4DTe9IuUMhfu81OUYqrLrBdKZQB4LC9aYqtddHGxdRQ6AvLYXeBflo+WcMjIgnrlM+K3Gx6F4eW+MbhNdyC/GegRRSRDmxZ3ptzXS5t3/5L9fjsaVZd+u2HMXGeJ59RhLiEY/MEwCAS3XFBc5pUf0fMePxYPnltvrxmdyroUKJOjxeLTL5+oN3mu5PvIUMdiCxp3X0xykYXYa1YihFd9Xe60R
X-Microsoft-Antispam-PRVS: <AM6PR04MB4293C888ABC741B43FD37DD5EE380@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(118296001)(16586007)(6116002)(3846002)(50226002)(478600001)(36756003)(16526019)(316002)(386003)(26005)(186003)(97736004)(6506007)(86362001)(2906002)(68736007)(76176011)(54906003)(8676002)(81166006)(81156014)(8936002)(110136005)(66066001)(25786009)(50466002)(48376002)(446003)(11346002)(105586002)(106356001)(47776003)(486006)(44832011)(476003)(2616005)(6486002)(53936002)(51416003)(52116002)(7736002)(14444005)(956004)(5660300001)(6666003)(4326008)(7416002)(305945005)(39060400002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:hk6bCyPbbTw9XluI53AuRCmuQdXwdi2eOxijIV5t3?=
 =?us-ascii?Q?g4SLiMucIOBk4/cJXt6ctbXBALZIRfI4IwitPjnhFAqRwXXUyR4M4KE5dbEl?=
 =?us-ascii?Q?AWQPgv5xVvBFDTP/wswiR83o3PYet0PUZfvTB8IdRDOIeVgMuhb7VcZsq/V5?=
 =?us-ascii?Q?Qp3fQoc3VcTnfHLuWElJOXxu9OLPTcRg7B1OvXu3lzLC5AG4JErQjQkTyVwu?=
 =?us-ascii?Q?EVC/IX+7MbqbfEpLHEVJeq7PN9AjSXJQ05bEofwtkQ0QvSxG1GGkAKtACZXn?=
 =?us-ascii?Q?xtBtuajFDnhyMdFxJ6cflQxIE27X32ko7ezaYA9eIsSax/I+jThfmhBmnFvg?=
 =?us-ascii?Q?ThKA9GHQh2loHIoTN3YpyrlJMxOIiRd0Sbg+NJ3oCuf8flwvrbNUcnBE6RSE?=
 =?us-ascii?Q?3rUpEtndq/8PdShOJm7BRdAzYVZKDuEAo9XTKixcY8ULSsHrtc7O+/wA2j7y?=
 =?us-ascii?Q?EmqQPwH6hmspTpXdA14F0FloyMnTTjMKE2MXVDXvUkvndHrrKt8drKO/qBbJ?=
 =?us-ascii?Q?0m1bZL9doR66YI05dof7PixGU4UoC7XpVruXtv2FwcpH/9gio8DjBUz67YmL?=
 =?us-ascii?Q?X3bnxF7aeNMWSe+0nnIYs0gnnufeASGoRYXdy++9a6KFRuWIFlOQi3t5Yq7q?=
 =?us-ascii?Q?ytONxWmgB1BRy3ucscoJEWfPTonO1G4OaEkuYeQ2HzEnvVcoUU4P+/VEzBPj?=
 =?us-ascii?Q?6QZ5BiM2Mr5DILAUWV1enBj1r4XU0oqMBmj6NQ7tMcT24wDZ8ZT90sJh7lZ8?=
 =?us-ascii?Q?YhaV7p0Drjac7gyOHzCqxeauIvtvBb4/ZbKgdRM521iLRSWlKWMv40Jg3hfL?=
 =?us-ascii?Q?b0pwiS7nUXmzSbJvxuF22vUww/TUKIAQLvNCj1F+ErU6VbuqlOinCj5WOQDc?=
 =?us-ascii?Q?eMpf8wPyhyjB0kmztNiqWNaGnOaN2sSXovO7oP+Ic9tYef3yrNe5DFvX1KRZ?=
 =?us-ascii?Q?+Zr5yH217CQ0amC5zpk4IXmO7ds+qtXpur00Ay9LOKdT5L/gC03j2unby/L4?=
 =?us-ascii?Q?Oap+5+KIwNSYeEBz+pe2xWmbb5TccxqySZ1fyAI2i+gPLMm9yOQPKmi79Pyq?=
 =?us-ascii?Q?2b2FnEZlkqkBShtdDIxWH+8+2STVx/2Qx+YAR6NaUWwwtwXsLKgtC46t8DA/?=
 =?us-ascii?Q?IRZ7MUBkQ2/IXlHuaACXkHcaG1yoqG42OxElPFwlyEy5/wCh2MGdGL+aJqSg?=
 =?us-ascii?Q?m6KEnl3roUVkusl+GRyFclwLcoDYwmqfX+I9T9eLWrHoQDHCSRUJgpPNZ/ae?=
 =?us-ascii?Q?TvCzlpOMOOhRw07l5oTDPxULsp78ryXZSO1E3SPo/cCzUEXy/Fs7ZjpNtsu1?=
 =?us-ascii?Q?5IU6wWkFUeqQ5N5hgytSus=3D?=
X-Microsoft-Antispam-Message-Info: bvs7+rSsg/i0t2Ke9ciJUjuyKu8glz6ISX+EfWW6xB1JGlmkxj2mLupuBYynTnn82JaxjA+oeMjx7xQ+9sMmQxWYE7P5DRkFhKDZ5dsLjCbKtlqZGRn2DxvL5NKWBLHUax+JOTgI7RvgCuaINszQFZSOWbbjvcOb9+P+2rlQQXtZOzDIMiazuTEnoA3/ydbVSH61RCaEHZ7uHiTRt00+PxHcllxibSN1pb+sZKkCkHpSHCKHrFJyGJzPR/zTAmNxv/AFRxgQCQa9SSq+iiBDunKv/ww1Ij0Uo4Bv19WEdIRPx0JXcBuMmDIndt5pRCxtyAAgR59pBfVUMZo3DHZo41TumF3WQuTh61pi3S86gO8=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:ulCgvg5UFk1kIP7vhGgSIuB93sP1I/WvfdHPVrbupzir6Lqzd1gvrbckOLjslwk05BlBxCXsPRBtLjiH5vnhGWMXsPU6IdFhh2kek2KMal+9SKVyRd+ILQ/vvYxc2pTijSapwxD7VBVM2GiMRFZ+dG2Gn4xyDHUtfieGgmDdARqDBDd5Sbv9RaVdy72HeLwjiH1Brj//nHSpdfpPcqe0s3iOGhulnCR9wKARbcXNJPsUoDuNjsG5ds43NwxRg0C2T2nYGN3W63I/3j1KW9c92Ducd1caIPfPJ5X2lhTiTr22oum4FiGfriw6oFq6X9PpGYZRCetvEejc49/iZkQKRa1TNn4ZnW6nWZOa6Q4wWWlUr/2uF7+9aYlGYWa4Q8ROyYS+v8JPFq72kLgWmA8ahzYca/RgCThLo0ak9CRxblc7nu3oKnmMg8ypcp5iRS7T2kDaCZD3cvlosRkhni9QXQ==;5:S4h3XUVw/TvIndaVtqm22hfAHPzvRckk12S+wdU7F5+MB9UFgMEq8tJbD+/LefpNjlPbQ9j3iPdwaZw0keiATM0L2W0GZM27F8TZeisJyEskWidXtrTdFxvPnsdTWWO2yxmPKPP1nZGI0h+kvUzYsqv4OFDkby4T+2Apow4LQhg=;7:Y8/888liRqqurkmeEArOxBph8HNAZbo2C5VHxwWpefhH0ORLDZxysC7uwVsrPacS31/b8rNMb4IRz51WvJ1noc1GSK5fQ5DAwbM80WmtfxYLv0rsmhAGEOm1vcRR7dmZB3sWJgPth4PeVilyGxrr19T+cHi0ACDuj+GCSWLymMOB6bGbYuOx7zw3j27SM6A6KsFD4RPd2UvcbkuRGa42pWFtY6LaaRpc0h1eagDi0yOw2eh+CgU4xh+Y/ef0oIkN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 16:51:06.3701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69913165-7cb6-49d7-a6f0-08d602062183
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the root complex suspends it must send a PME_Turn_Off TLP.
Implement this by asserting the "turnoff" reset.

On imx7d this is functionality is part of the SRC and exposed through
the linux reset-controller subsystem. On imx6 equivalent bits are in the
IOMUXC GPR area which the imx6-pcie driver accesses directly.

This is only for imx7d right now but it's deliberately implemented as an
optional reset, ignoring the chip variant:
* Older dtbs won't have this reset so it will be ignored.
* Future chips might also expose this as a reset controller.

For example imx8m (not yet supported) has the exact same
PCIE_CTRL_APPS_TURNOFF bit in the same location.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 926858701726..eeba64392dba 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -50,10 +50,11 @@ struct imx6_pcie {
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct regmap		*iomuxc_gpr;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
+	struct reset_control	*turnoff_reset;
 	enum imx6_pcie_variants variant;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
@@ -757,10 +758,16 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 	default:
 		dev_err(dev, "ltssm_disable not supported\n");
 	}
 }
 
+static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
+{
+	reset_control_assert(imx6_pcie->turnoff_reset);
+	reset_control_deassert(imx6_pcie->turnoff_reset);
+}
+
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	clk_disable_unprepare(imx6_pcie->pcie);
 	clk_disable_unprepare(imx6_pcie->pcie_phy);
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
@@ -777,10 +784,11 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
 	if (imx6_pcie->variant != IMX7D)
 		return 0;
 
+	imx6_pcie_pm_turnoff(imx6_pcie);
 	imx6_pcie_clk_disable(imx6_pcie);
 	imx6_pcie_ltssm_disable(dev);
 
 	return 0;
 }
@@ -904,10 +912,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		break;
 	default:
 		break;
 	}
 
+	/* Grab turnoff reset */
+	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
+	if (IS_ERR(imx6_pcie->turnoff_reset)) {
+		dev_err(dev, "Failed to get TURNOFF reset control\n");
+		return PTR_ERR(imx6_pcie->turnoff_reset);
+	}
+
 	/* Grab GPR config register range */
 	imx6_pcie->iomuxc_gpr =
 		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
 	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
 		dev_err(dev, "unable to find iomuxc registers\n");
-- 
2.17.1

