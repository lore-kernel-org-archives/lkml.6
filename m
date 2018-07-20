Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D507EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABD520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uYTrEqK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABD520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390482AbeGTNgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:36:37 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:15725
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388476AbeGTNgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acD2/XdmvNYxlbciyzRWc2ZqKd0G3KLa/bG4DsrygKs=;
 b=uYTrEqK+1Ej8uZjKp+/RhQx4aiFAcqQmKK3OGKqMu9QN14cJShUQCYDovemVMr9Go93+ekUXkFnGIGU35p0SoNfDLlFqGeT5lQF8cpU8DcUbH75VQH19Irob9dg1rQTf4Yzx3dPZbunW963CuAy4YM1ST4hVx1PZrZpi1pvU4Z4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Fri, 20 Jul 2018 12:48:01 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
Date:   Fri, 20 Jul 2018 15:47:44 +0300
Message-Id: <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1532090446.git.leonard.crestez@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR06CA0015.eurprd06.prod.outlook.com
 (2603:10a6:206:2::28) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 842374ad-e175-4281-7a5f-08d5ee3f079b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:d+RJDemYutNXnb/s7qZSRC0JIlqGXrJYkyB78X6VT++KQP1/RbLqakWkeWT6Io155yACMa3B6yneIJQWtZZeAkRnzbEOtfTLUXd3A13pe/flHcbtidKsh3mV8qIICeQyt4WVRdd5lmQpWxWLZHa0+5sHGzU3l3AbaDBkhKh1mGifpx7FveNSH3rvJi/NXcUP5GG1p3AtWkp7ZEiAne2kJCgyfgw4q0LES5uWmtN7titT9jT+1n8nsdHjsgM8l5xo;25:8Q5JeckhwZfOiL3IsY7wSQX1R9fkICGaNHfSeesjRxJfJYx3CCuH8QMpTqfjAHnlBArOP4iZuwHpnbiPYyjF9c3FdAGEah4mk6soM13JTZjIpvk+aFmcHuYzk2k6neKLhSIQbQEiJxM8chl7odBnp5hnD1l5BYrL9bmHTvL4Cx1Kt5LEK7TGDsQCdmxM81u9FxhY5AdpxfoDKTIaI7EijX6MrBnYGIKRQ9M5LkMypOWJ6VILyB3YHdy1aakW/9K811oGQTUKXK6o3rDj9OChZvuJsrHpqR+7A8VV8ZzChev9kCxPqSpGbaZzZ11nJqyalX5GNBooMAVMjOljUihAmw==;31:IRyFagrnmeaMo5Vv6DjYSylqeOayU7aAQT6lMfK5MiuDxE620QgcUzY9Bl7Kqrs0bI9tEpD9BkY6I9kBtrcX3AqyydUIGIJOKEm689f7wXuMYpT7Wy26yY5aRjmRNsbTB1NCasaYjir5xBVbL5/FpbJlfS/DE8LdhXbYalG8BkPpL5fk+/Un30KlN/NlmQ2C6ER+1639DwWMgs+y1lUwu8ipEeKbKONTvTt4mc4ifXw=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:eBNeVonDUJ37/54D55NUPO4Xo4fSVHPzdzYZfASpuK13S32UR+YVCdnSiWpGLSno+7wOPt/y3LYn6IhvFnYsVMnZg3AxerZlGRPPhNODivgKAXwCnaRq+0z1OKAsjfN9T0rihwIYZOIh626LPBeAO8SJ/oXye3OXD230Xt3cWIa03XKiAPSeaDvdLCfyYacS4E6RQt4KpndcQSazya2TyqejVcuKQVbsyAfJjBrUXKNFfww44VvVF/8ZjamCRCnE8ldsbiD1OyZ/s8vnoMgrl0hioknRRDnnO5N29IAG9UZyJELY38rdj5Q86TD6dYBTTPALKNN0PKoCGrCRBE581g1Tuk7rHZs4R1TcG7PHLXCV6j5gJ5ikyHd602ZrMkAAoEWL2zhYr4jCa4VatQFBjA97As+i+G4GVPFjsHvLFn4Z52YxBNLQdU9ZZg98CT6rQhxfc3Gk5oPRXzjx4EscLOAIvjBn+mUhRbLQEPgjC7gZfLVvADyoo5r3i+DZUDzX;4:LU74a5NUzFyIIk7lNzuaoSsoBuvBOECqmZ8DnR0oXRASvZyOHScReoDin4LWDTQmdqR+5DpBe48QGz3cIIfcuY4pR50//YhB2FOwp8xoXW/9YrOmSHUkj4ia9ZZpH7JyF61cE/VMDsIp2vgr4g26BAn3rSymSQZcEgWCokXSMHUFCGaXxypQL/oprJoPtl+RZ0QS0WU6krefC0OEgzEfLr4dGlP6Cv0MWXaJ91aicWjnLF8WFqLv7e7IowCtoKUddyj9xeKntkWmVneJCFC3toBTHWnuNjFdt+HvT812QVCKeeF8j/Ul3N7daSmZfvw8
X-Microsoft-Antispam-PRVS: <AM6PR04MB42937B1A4CD4FEE8DC6269A5EE510@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(2616005)(39060400002)(110136005)(54906003)(50466002)(86362001)(4326008)(305945005)(8676002)(48376002)(7416002)(8936002)(105586002)(81156014)(2906002)(81166006)(106356001)(51416003)(11346002)(14444005)(486006)(53936002)(97736004)(52116002)(956004)(25786009)(6666003)(16586007)(478600001)(476003)(76176011)(316002)(5660300001)(3846002)(6512007)(44832011)(36756003)(6116002)(6486002)(26005)(6506007)(50226002)(186003)(16526019)(386003)(66066001)(118296001)(446003)(7736002)(47776003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:ldT/JTNHF2Kv90pAYiltXxwIs044S0UW2TC3VLo9O?=
 =?us-ascii?Q?yZ8kG8GGFj23mssDcrFHK4jjTFn2fvDNvUITfbddyMKD7MYLAnP9I81Gs/rE?=
 =?us-ascii?Q?WmOgxLp9oZGmnuPFsFYbqNOuy47cDY87leDxrjw7Ro7wOI/8w7CojrdBoi0y?=
 =?us-ascii?Q?ovnc/FR7D5wPhoXSEExFDL0rfLEZCJrcz6HTfljumN5FW5JiDZ7umvX3oBss?=
 =?us-ascii?Q?yBWCzrot0+Ck0zimqhOpKxWskKqq+vSiXqwKRksy6xs0/kLX4KNTXeMIJxfW?=
 =?us-ascii?Q?5GRuukpAvH3U1gU1TF3BYiU4HHqh8ETXaT0OXbTIipbyFj+DgRW+4+gZcpRk?=
 =?us-ascii?Q?aYLiTZp+U9voFTRCxzeglzvX9SL5g+LZVan9iul2uBYpTxDsZP9Tio4xljPK?=
 =?us-ascii?Q?3Bm40tjBQrrJ41bYXF1Gd2y31tSiAtpkUIKTAIjDIvEK/NQHeoe22/VEJh4+?=
 =?us-ascii?Q?Q7kCAydNz8BUHhcNiTnKxek+AFqPZ1yozQRUmQu/0C22zrjLXRBe7zHa3Glk?=
 =?us-ascii?Q?cJWrYRcJ02xRwZfR3nzi6bvxukxqi2QPZcNZ8TZThu01R/s0PBMJEtdujOHX?=
 =?us-ascii?Q?PINla/HmE4Uifjl1aNk7tGSeoprSfGtu4tVHR4X0Mqfo4RibZ3ixTZgzMDlE?=
 =?us-ascii?Q?NX/acKKpJCzf5baUgcUIN6aPWiI8g1gBEQHaPJtJd1sFI0zYritQqrP+A24v?=
 =?us-ascii?Q?SFCc15ZonWb1v3Ahp3QbyTyATEEpjbTGtt8Gb/qU/rHJip1uWLkqwEfdneD+?=
 =?us-ascii?Q?z7gLAgsomWpIkHbGUoC3IPq7kO6/LgbiwdwCeqpxfSFuLmsfp9NSezM9IWdP?=
 =?us-ascii?Q?OMdcqkYOHNaENb1O4IfuChcLvwJqvbZOooZajJXXl/jPaxoVchnE+m7FyEjy?=
 =?us-ascii?Q?FE6rzyNF7Hwz7Xo+GeH0myWU0EdW7yBDUJQqttAvEnYa2VGFbop7p55koNLG?=
 =?us-ascii?Q?eOztBZ+AEIbtnW2QbXm3jGBgzbREqurxwi4tBaVH4oCGcYEse7zR4m9C0U0O?=
 =?us-ascii?Q?fuWxmV5pRfSkqurJ8UL3IvT3hU0/wHn2GolxeJJr32XPZ6uLhyjytgqeVYES?=
 =?us-ascii?Q?ZE5akzw4rluzfrx9uDttQSbfIkFwR7cAQiWw1ygb4JHG96aM5tHDFyOF8R7o?=
 =?us-ascii?Q?wdh78LMiTkrZghcGcCVsbkgn0cZWKxBeEHoIJbveDFQV816bO+t/a+5C6/nk?=
 =?us-ascii?Q?eo1VHX0XPMOlrADeSjfIFc1HCQKIHoYIHe71XlrfTv4aaE0e5WOzyhCZUCOV?=
 =?us-ascii?Q?D2zcRnI3RxRFzznH+BXg2DcwzwiWeg5LNXBCPfoLDPd+2m/pZfbyBg35T1hf?=
 =?us-ascii?Q?TAVzrlq3VEHBc/RqGhvwZw=3D?=
X-Microsoft-Antispam-Message-Info: 0DUw9BNc2HZ5I6MHWRJ3dE3lQnROt8y8tKN+KSQtukUFmFDQWcADjhx6EKRfjoOQ0jDZRUt7PPsF2JEHzGsbBc30oEf/WoYj+yHUTcF82E4pQToDrpbUSUZVOTBfEitEEUQrO9yRKppWKoFGFH81ygNLhAC50ABCdWVAz3QGoA2g5OgNmCEpPP/Ml1egWBtst1EFdnpxWR4mZiQxNnbz+9/UtZDU50motPyjeIk+4GBOvGgIH0SMtuWrAuKhFFPQwTp6fqHR3dOqbkqh7BPjxQeBBCvXGViYW2X12yWvpMGB6wAZ2OGIJMu88DwDT/Hfc54fC1I2KY5yP/G3vyGUo/mdjOy5wLCDqSPUm6ItwAM=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:V+ZSydo6vozC+YHRQUkkvCBEt2mk2l6bcm65Nd3jAVdF1/qJ637JNP9GwLyZ8Qcen4o7wNvLQ5XqO2IMFinjF8J1dYGcpRH13L/pa6ElIvZ1tZOVFOdCDr3BbwGyVHkkAgVQwyBz/Rqt+jjObrJaKX4P8MS5RXUfMVZ0FXA7YcMzIkj2sY4x3negNlqnhpsl0+nZSRTkq0jC6Voerj5TGUUY97SW+PlRE8FWHbBvmnwwCAfOggxvJky9H4CYILvBuXT8xmO9Wk31t56ukSHhq9e2hutDylPgrOKWuGveqR4rSWrKVjVU2Z0AgzH4hiRUcikvM5tVhK4zbqFaAxhJUBxrEtjZqZol4lQMR55mn8ajGF4sOhmJdstkdTg5HsyNVMjgpymS7gYlQAqvijitZYVj1uPvnW+yhTYv/IX5GIgUM4qoCJttmJiA1ndABdmfmn8jIgJjc3feDERdnbFSOg==;5:+gIaYEN3eJHjXRRaLT4ndvg/tzW/UmkJChwAitFlqTeN7fJRiPI83gM0AcgBfnNX6JHQ3mu9rH82raxRNeQA50CXCS0MfMImJaWo2PBDyBphwsPKC/JgjuG1Dzl9ctO6jV9Xt1qu0UHEhFeWcc0dWt+v38PHagYOC24yHjMt3y0=;24:uimU6S/9GB4R4fIyNirKjeP3AU0ZkfjimLm4CSBScY0L1aCAmWunf21B8AoJjSRTAP56olGwcSkZJu//Ks97ekewKJlfiH4/2c5vbeXMEtw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;7:Ur4pyb8m6SvD/gH/zgsO+FJnblyM9hJioDu1k7mmiZ3rO+EWv+BbS7UFY0xcEw4cD1E2el5VG+KwHS/041BuSdrVfBXP3uBO8gOjUjI95I/5WthFUWaA5BcG1zVavvMOIlaz35PLflkKE25OkIROXJW9W/C+pKY58/ZTnANY8evSKv1M8JACFcN5YXwpTMhpIjHqx1rLIiwcGoNad9oAclrMF/OCw//08IHkqHVz7lUeqFh88FBV0tn2nbdkZyAP
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 12:48:01.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842374ad-e175-4281-7a5f-08d5ee3f079b
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
---
 drivers/pci/controller/dwc/pci-imx6.c | 95 +++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80f604602783..daebee905108 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -540,10 +540,27 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 
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
+	}
+}
+
 static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
 	u32 tmp;
@@ -558,15 +575,11 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
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
 
@@ -681,10 +694,81 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = imx6_pcie_link_up,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static void imx6_pcie_ltssm_disable(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	switch (imx6_pcie->variant) {
+	case IMX6Q:
+	case IMX6SX:
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_PCIE_CTL_2, 0);
+		break;
+	case IMX7D:
+		reset_control_assert(imx6_pcie->apps_reset);
+		break;
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
+	int ret = 0;
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
+		pr_err("pcie link is down after resume.\n");
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
@@ -847,10 +931,11 @@ static const struct of_device_id imx6_pcie_of_match[] = {
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

