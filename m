Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEE6C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0617221729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s8yYfi4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0617221729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbeHNTjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:39:08 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:21050
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728458AbeHNTjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeAPlxJejbTEhRZ3mbDL7cvFdqYLwf0Bx6eDOcVL78w=;
 b=s8yYfi4KG5lK93TVlIQnJ2orb00mv+MCBjHNdc8hiI5DN2ofBE145tdACKLwU2Ly6sOKbr0wvS1bTkERcKtUJ2+9x/7F4Zn+pgCD9esEBKjaMvoDNQwf+9tGvomETDajH6hXG3eP4QB6AGaJtS+y0WWKoKzSp+2xOYv5aIEU48Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Tue, 14 Aug 2018 16:51:00 +0000
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
Subject: [PATCH v4 2/6] PCI: imx: Initial imx7d pm support
Date:   Tue, 14 Aug 2018 19:50:16 +0300
Message-Id: <4b786ba5d84a0ba90d2f04beacedb0de1e529fd8.1534264292.git.leonard.crestez@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3322c2ed-c278-4889-09f0-08d602061e0c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:pE0ieR4/dAnmg1ZgB/3xLSvyodgwNdazKFzG/q7WRnplBQDH7aN22h7Dg6qP4MvBEcEL3L6EZB4ftAuqRjTfnrBtQpdeq9uDMCxgi7wkVnAJcOj/nPty4+8/L69t1EtKcCN9OVGvlLbI+iqlQ6uRF5T0+ndGZaLnIxkKwVAUphP0TiC6HY6klXhS8U+OmlCQNfcwquMQddZiLj/St6WmezSDQyV6gJRQfgzGkmJQT3j+DBgyhnC+7HP+2KtZDWlP;25:cKrXMV5BCuzmi+NjAoweVOncs8TRtPNGDN+8lROlT9l7Ig34jjRS2TuRpLBT+kzwVJAokkMZrEXNDR7IZuvPeDeNP8ieetkfz3FfGZAUKCw27wX0EnGed9n45TmSoqjr+Q7NCQs9zDeBG52a1OkYmsWr9/pJlBzkcbrOUq+ws1/FrWPSRp3Src8yFDHJ/8ezd98HPIhW4NRxzTOv7ijmDk/L+kvJEuqfXrZEhiTQzauL/rojAMppAINThRCTi32jTsLAygWdNRXg3g1rTv2SUvZMbtklMQK4P6a4hvnmqQ3lDcK2f0jGZMtxMVyBeV0YSDFnIlRd3XGMoBQF1yK3Qg==;31:3iV1V64zwArz9kxwa6vAZ/9K7lebXxWnTnGhZ5eOe6W8LucmAZRwnnIY+Mgk7cXuxBYU+ZgvWyYH/pPAipAIK3NVGKvXrrfADACSXAPklQxnmrclCGat+rhPSoMPcHP3D2p/J4e1g7wxwfo8mcYVDHTKSwIR+QxLMYM7trreR9Avbvg/NtM5oBkxecJ/HrNeiAX7zFbXXgI5aop932EVVXGpxdh2lhhugs0Urihjtj0=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:YAFB+fFRrvdcipJfmQkfPpBT5ArTNj9NhsrrlnEipxnim00a9bM7U1hD7QzGtcufZ6OwMkQSTI1Y4KoQNIkejsRZw5O69lStRGTDDXI9fJKyx4kI1fD8sQQpzSGCmcTP/1YLxd/De4moCAsr3doHoM5E1uR7UVOQIOBuQsbRwLuGLdZ/YMt6+9MpDreHW9+CB1Xj7/7GDWqVlh3oY9F8HmwNeFkEucxCtIGW3xi+Rkvqr7Eq0Dmpmw9ONzEcxAAoFoqUKEx6T1fDZg8EReEFzeQIo5GLqH5tSKpB0rQIMnv5Cn4WFfsdSViDPu88xjSB+wbvZkmdGrPmgGQvd0kTQlKfgTCxKT0eMQBegNma8Nc0GrYow1lxv0Yltt4vqrnK9EdXzSWdfCPuSQbskTycJfhlsmAIUaJ82X073hHvriQwEK87rQAj1U8WD9tVaLTpp8uMbzEKBubIUliqlFVkfo2J30eX5fYAm2yeiFM0wr0MUdjv6uFNOAXQgF/LZmx3;4:vMSKKL1ZKOZkPXOAkM94S87ejULsivQLVF4mLcTznjmT95Wixz5KQXbvKFC3bjsrqIB9bq4WPruIp5+fFEpb3CjKkKOEgdXNPrlECtFQnE2vd/jET4chCZ7qm4xxte+l69qYZKnADBqQ96gKgBVUWwxuaIz4pBSW+4dgMtmfNZnvO6P1QJLxHiVhATOLEYlUgyv+Kmt6hFm7gzMVEI/o58az3DWcQmZL41p7CWIFXjXHVTit5JOeCWI/z80ZtEC7FaJrPS2dCzL8WUoZW0QI2nRG3CB40oiNfZRMUdzEY4NxqzkC/gIXwO3HpHY5UzwJ
X-Microsoft-Antispam-PRVS: <AM6PR04MB42932FA59B442B1148E3CF53EE380@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(118296001)(16586007)(6116002)(3846002)(50226002)(478600001)(36756003)(16526019)(316002)(386003)(26005)(186003)(97736004)(6506007)(86362001)(2906002)(68736007)(76176011)(575784001)(54906003)(8676002)(81166006)(81156014)(8936002)(110136005)(66066001)(25786009)(50466002)(48376002)(446003)(11346002)(105586002)(106356001)(47776003)(486006)(44832011)(476003)(2616005)(6486002)(53936002)(51416003)(52116002)(7736002)(14444005)(956004)(5660300001)(6666003)(4326008)(7416002)(305945005)(39060400002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:xMRMBBTpYqWO/4fWXOWMx3xKAuKfOOfkCW0lQqeKY?=
 =?us-ascii?Q?Pu1h0bF1JK2b3UC/RC2D5mkO4dHYtMe6gzSSy0tvJaz64DQnoqduaESJcO63?=
 =?us-ascii?Q?jRDStZLThW2d+au9LveJBKj297B179u61wmRAFy3e2IwICwY5h7YDyE4bRXm?=
 =?us-ascii?Q?4MP5/P3FaBUUWShVb3dF6DhRC5yk6QSzIQD+cu/8A2BygwUus3nl6L39Hz4I?=
 =?us-ascii?Q?L//prlTuEst5OEmi3PBj7NX7alwBHPWDuDkLJMOYN90BNLijWOThuI8I0RwP?=
 =?us-ascii?Q?Z0sX0qecILI2t3jNpCCye7dJieKg+o72UJRFou/a1n4tG0LMPIKYza7ebBeq?=
 =?us-ascii?Q?xsLeoeq+G1FUsocedzR7JQbee9GOLFoJ4ZZohS4X7fcbO6VQbSlaY6CSnJah?=
 =?us-ascii?Q?0Pfc6+7/c5Q3jDTwEXDDeI7B1cUZRKvsnLDB5ZDbGicdxf20V1Df5kWMe3c1?=
 =?us-ascii?Q?O2ogul05mucmCKwKLusfs/bgpEsH07DevuqcOk2Qhoa0BFCuAl8yA8O6j8fD?=
 =?us-ascii?Q?9VI6ddWoHMu8TJEavs+NnV5MsH6NjXMl/l5JptYexxHQBZvKrJyKabkBdKgA?=
 =?us-ascii?Q?0tFa6onBjGJzirz6dzynhUKeBihkVq+/SG4gSBYkxwrM+KS/ys4O7u0Szq0y?=
 =?us-ascii?Q?c/9dchxEtulIC0m3ExfafGjcHKWn1qeUHB5PLFY5Mke3iTFkGlJKZ28w2MuM?=
 =?us-ascii?Q?6p3otu2QHo7hLiqIMtg3kEzYp3BEiXcPmdhzwWjHHb9/su+KFkh7CNKXFHvR?=
 =?us-ascii?Q?3empwm7VZhlEyH+r9lb0hfnO9ewG9QIO8ANYQNKqYfYpG1g10gRiBBeUq91V?=
 =?us-ascii?Q?Cstxb1v2dOVy3VABQWFgqLpuZLCRu65os742B0c5H59uoic3vz09/EwqHKSe?=
 =?us-ascii?Q?/GyYng+98AnywMKH4HEI2zQIGfYNPjBrs/XcFG8KkRV9uEmMh80nk6EecQoN?=
 =?us-ascii?Q?7da/v2KPXtmB4a8oMqY9se7kfGOrvyVbhNz4VGmpmw2zTUoeawNK5MFIPAob?=
 =?us-ascii?Q?mZi7G/VOl0BnpBuVisOqCu4cLC1ip9OQOGS6bmdWmXRi8rannr1XB6Nm7B8q?=
 =?us-ascii?Q?7wU9BklrBxcZi/aIkpouNKvNUcJOkESdjQqR+MxoBQ1dsVCOLTnqXnVxNtr1?=
 =?us-ascii?Q?lZh2sRa3fHvQ4YZu2I9e4tC0ouY6+YDmZbO/TRQD2QI5vPQ0zBwmtOjB/l3O?=
 =?us-ascii?Q?7srS2EdXB4hcS7hUvMyJX+nRM3b9JW6VyNRweIIxecCRpIsQTM/KUhg4uoBY?=
 =?us-ascii?Q?Da3rqkD+CDJ2u2M3F6AeLBxQqcmOKRv5YCIFCz9Xh8hFG/X93JtlprEMLhwF?=
 =?us-ascii?Q?+K9CflhKeUov6ZdH9OyLwrg3L64gHpGiCsWwZMjrUF2?=
X-Microsoft-Antispam-Message-Info: DNq9B3612BCMgWOujXBcaFlxBuyRLysecEsNEvJEaDMyghKR/VGNVjV6l7quCVyY3BdOEpbPH2InWhIJfdsza2LWD7i/qCZETCloD9NRan4ON3NP0tEzagQIECB3KNXyEFmUQC6oalBJFyIlGIGmGR8BrJ4z/LfTrE7v6sKiDr3PK2HPkSdZ7erFJNiNaGXGWeAwTN3LCGaXovKHavoBP0d3GYuLT5BJHkWih9brgU8jSm8EpHKC7orM+PAqsMrq1TBiRg/k2yuZDZlTw1zX9mRF3IZqkOmI5K80KTDpqYE3WCqj30yzwFiMRFInklbCTNoaZGxgF8R5VNMk7dKxb8AMtAFQ+kj4tsJCAGLDL1E=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:hysyMJ5pQzXexq7QG+cIV0W5WD4ox+45JAi//vu8WH4pavZ3+9hA0WmFLqesNfAH0irC8g2FDJ6ilhixnbiCxWlDxGl3h6U/9wWMxxOv4yGl8hGJddU7Olc+t1ALaQLXLxZl7CejOck1GFkwlx5Jwe1sSCcwGx1wV/rbhUCAJssScYqFzU4mn0ZcGbSbPFJTqBAkxvzB/s1+gOqzG0WKJylqDmsSj8+aKwVENAPGAp7lAeKynROHX6u8E/gia1lxB8/YwBhORsS9Yn+FYUOQhQk5f+b9DnOuUS6DCRAOry/m2sYfO1MOdmRTl3LK8XIBE9cYZSZHPdLzpNPHRIoMld3OVPI2FDVRvXtTgjeeJO95MeRaIt9tqyrkA9/oeSJcT62CpmFnxyAiAylaE49Ii4AfORahzaAi7FTVkCwUyqizrObZX6KH3knuzu9xM/DA70ODH8j2R+fjs/AqL4t8Tg==;5:4+mVTB2bVUrNLUBj1cGQeAzXLeo1hmn0cmH78U5HlnG9SKP5smXr1+tSjDWYJccVcxj9oKVznqQcaPR92ifjSsmnp/7NpYQAENQTCa8aH47gsJtDnLX6m1MSBXBcw2f0kXSRtV+YlTtxGDtKZAhZrb71089x6unOOJVPwj1g8vY=;7:nhTvNRQljMMWFy7jksS3VpnFUZvfuTfSfYsHvPDmbkuvslixDRON6ohy8U9U6Q6jwI7taZ9x4++5kf9h/RDUf5dHdlosSQicAgi6UNFyIE8wRfGLqP+KssPylIlpKJdiQPsL4fVcQbp3THsu0IfrtD1iCqK8ZrqaGO8rCeSyVyry4Yso8lSVFAE9ZSmBbIHxfmql69aa7srBXY9KHvi9qP0v2jhuo8CcoYCqlub2/kpF1beK1guA2wb97LGbXhgv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 16:51:00.5520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3322c2ed-c278-4889-09f0-08d602061e0c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On imx7d the pcie-phy power domain is turned off in suspend and this can
make the system hang after resume when attempting any read from PCI.

Fix this by adding minimal suspend/resume code from the nxp internal
tree. This will prepare for powering down on suspend and reset the block
on resume.

Code is only for imx7d but a very similar sequence can be used for
other socs.

The original author is mostly Richard Zhu <hongxing.zhu@nxp.com>, this
patch adjusts the code to the upstream imx7d implemention using reset
controls and power domains.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 97 +++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 84c33e0c049d..926858701726 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -584,10 +584,28 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 
 	dev_err(dev, "Speed change timeout\n");
 	return -EINVAL;
 }
 
+static void imx6_pcie_ltssm_enable(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	switch (imx6_pcie->variant) {
+	case IMX6Q:
+	case IMX6SX:
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_PCIE_CTL_2,
+				   IMX6Q_GPR12_PCIE_CTL_2);
+		break;
+	case IMX7D:
+		reset_control_deassert(imx6_pcie->apps_reset);
+		break;
+	}
+}
+
 static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
 	u32 tmp;
@@ -602,15 +620,11 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
 	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
 
 	/* Start LTSSM. */
-	if (imx6_pcie->variant == IMX7D)
-		reset_control_deassert(imx6_pcie->apps_reset);
-	else
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
+	imx6_pcie_ltssm_enable(dev);
 
 	ret = imx6_pcie_wait_for_link(imx6_pcie);
 	if (ret)
 		goto err_reset_phy;
 
@@ -724,10 +738,82 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = imx6_pcie_link_up,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static void imx6_pcie_ltssm_disable(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	switch (imx6_pcie->variant) {
+	case IMX6SX:
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_PCIE_CTL_2, 0);
+		break;
+	case IMX7D:
+		reset_control_assert(imx6_pcie->apps_reset);
+		break;
+	default:
+		dev_err(dev, "ltssm_disable not supported\n");
+	}
+}
+
+static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
+{
+	clk_disable_unprepare(imx6_pcie->pcie);
+	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_disable_unprepare(imx6_pcie->pcie_bus);
+
+	if (imx6_pcie->variant == IMX7D) {
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	}
+}
+
+static int imx6_pcie_suspend_noirq(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	if (imx6_pcie->variant != IMX7D)
+		return 0;
+
+	imx6_pcie_clk_disable(imx6_pcie);
+	imx6_pcie_ltssm_disable(dev);
+
+	return 0;
+}
+
+static int imx6_pcie_resume_noirq(struct device *dev)
+{
+	int ret;
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct pcie_port *pp = &imx6_pcie->pci->pp;
+
+	if (imx6_pcie->variant != IMX7D)
+		return 0;
+
+	imx6_pcie_assert_core_reset(imx6_pcie);
+	imx6_pcie_init_phy(imx6_pcie);
+	imx6_pcie_deassert_core_reset(imx6_pcie);
+	dw_pcie_setup_rc(pp);
+
+	ret = imx6_pcie_establish_link(imx6_pcie);
+	if (ret < 0)
+		dev_info(dev, "pcie link is down after resume.\n");
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops imx6_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
+				      imx6_pcie_resume_noirq)
+};
+
 static int imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct imx6_pcie *imx6_pcie;
@@ -894,10 +980,11 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 static struct platform_driver imx6_pcie_driver = {
 	.driver = {
 		.name	= "imx6q-pcie",
 		.of_match_table = imx6_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &imx6_pcie_pm_ops,
 	},
 	.probe    = imx6_pcie_probe,
 	.shutdown = imx6_pcie_shutdown,
 };
 
-- 
2.17.1

