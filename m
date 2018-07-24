Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5F320880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J/+P54Q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5F320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbeGXRWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:22:35 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:43936
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388321AbeGXRWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND4YWGkHWotnvSOJ36ySVVbPGq7f7PkYyTJaPsqrfDU=;
 b=J/+P54Q6YzccAKVWR/gwk7cgGSSr4sc7ZdhyOU21zpcWtFpwwMSKFJ4RpSxX0eVWFyOmgTHDutxjw/BGL403VqtorwwysmW68HMDH3eEmvrhvzwOKpcVsY7CwctBidyJWnrTEtGcuwi6tjvllp7OY4FxAbfBX2XV7LlCqMRsdbU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 16:15:13 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] PCI: imx: Initial imx7d pm support
Date:   Tue, 24 Jul 2018 19:14:20 +0300
Message-Id: <acafccc294f15a281cf1d253c15a3eec2d1c8cc5.1532448745.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1532448745.git.leonard.crestez@nxp.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:207:3::15) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6f0d4d7-a093-45ed-6078-08d5f180a391
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:7LmRvPp+IbC+flaOiLySQJAD5xSSC4PsSllTvwK4aFsx3Gp+lYZsHznPn2EgMPFhVrLhMYXxn3QQCptlEm/iZoDVg1DOTZ0DUP99PzneTC3Qz8HITCtLwosgT1O058gCTWUEVDtJTA6wDO6kmoLIgcgYefib3YlMj5gcuhXXHnjtyZ5HPI3EPAj3lFHkq/TOzateK0+DvVy1E1BgaVw73j3KpNdBqsEAz+Ok0fgus4PlThGdRYa9rYqCxCyn3cLr;25:ifVi7l5yVDqMeSb5p0kKDIsuhxiDncO3VjAfYMXfPBalKSQul++2mQNR/D5KL2P+nTfARg/+b6KYnYNj0LZFNBQi5fQH64BBEi6gjZyVVZU/LmQh4Mx6cf+Zak/y38AdgsEAsxYIcVx5vRSSYA7XyBngfglpRuAC5d7N1oDrbGFYyVdbFgvaIYRBxIzb61gMKO9ub8x/5Vdmnzwbyuwr3pujbymTDLZ4HlrLth3D6zEKobqqsQVzzlyodXYSipb9CawQdHuUUSXrlORNap/mYp3KkdYg3b5BwDafCIGPCSmkan2B8LepIheJ/tNjbxXHU1CqCb3qLnBPcylP7E721g==;31:VUlj62MsQVrtnN323XWfDinAvZ102C7whAZffKygme1tL3fPzGHdOyX3kdaCw0Ho8A3QcaQZejo/lKokn9+CwLPq9FRqktfjTGed6m6WbPhZK5OwDpolLIokLmL3CY1yoLMUO7bCfh2t913/Dk7fdLb5oZ1G9HdeB6Wqu4s1Qp/Oza+R8UzgHgz4Duk+uN5qT0zYpAOGxFmp7sMMC2TR45ruM1laUprwmrGcnreZ3cY=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:dUasxGyVZor3naTUWe2iIsQJMjaCsCNATu/hC85QqKXsAyV6zZragmI9XbS608iBEIRuuSEZuZvshXvLDKfXtORZpsTLpkgT8vWKo454jhBkJhQs+NBTi3ma/Ay6n5wyct248BKv+U9CQ1V5NY+RuPMYhJ3myRWDbjdnRNIi/RHDx0nG9OLQj+gkBMO96xaP2vPtZA/hKSprDNt4R4qociWQFHFhsq1upaI5Q46eR2B+dJXhi4zrak5RBnTHzT3iVD+EA+4v3Od36VQ+vRLQe+mpI/AN4u+G4kZKjA4+RVssdVbEykYCFXzeab7TrAF+ujNoO4ZjYH2DkKZdBy9mo4FCUW0vu+Ed8OkArqoXa+ZECevRJcjSakAbsFXfk+fwYW1XineUIpD7lNAAVcoMEsokiXqeYWrV76yDgIxPEIXhvJw1hubBwJdu5bk7FOe0Xfwu2ueRkBnAyQq02BMvq/yeGCjVZ9X7loecCM07bwkAQaPB/VfQzRwMt8LDRHN6;4:uSyUr0fbB46C3IysdUaMMH5CVMlgMTcOTO3G+Bed1eXwIVEYO9k4qYDn5p4aTfHHQfcMMETSyThVPln7YN3jKXvD5vCjWPM3I9ap5oO+Xoda5VAhyvdbIfWsgHeJOWsKsGFcbSwlHiw60AqIrdSYz1K/m9ksoxZDdjL+3PaTQ9EKGRMV0rU0Be/jl5RbyyvYgODj15y43CGY0tGY8YBDWkvADtkdcw8JroKaGASgaFXTFNfiM6tOMTTQq3c+Z6r1yhva2n/VlDNAqU4wGMe/+CHnIgYrH8UGOovO5DE7G6u70x5tMJebIQkFKRlHSrmo
X-Microsoft-Antispam-PRVS: <AM0PR04MB429039219CDDDF4B834A0CBFEE550@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(366004)(39860400002)(346002)(136003)(189003)(199004)(446003)(44832011)(86362001)(11346002)(54906003)(81156014)(50226002)(47776003)(97736004)(81166006)(2906002)(110136005)(8676002)(14444005)(316002)(16586007)(4326008)(16526019)(8936002)(25786009)(305945005)(486006)(66066001)(39060400002)(2616005)(186003)(6506007)(386003)(6116002)(3846002)(7416002)(118296001)(68736007)(53936002)(76176011)(476003)(7736002)(26005)(52116002)(6512007)(51416003)(106356001)(36756003)(5660300001)(6666003)(105586002)(50466002)(956004)(6486002)(478600001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:FjIlKAYxt3n7dZv4/bChJDc9s6HStkVKa44JLMFZP?=
 =?us-ascii?Q?OC2HnfSq38rWS56yMMswFW51rfQflUuMewwWKPumMRtelb7Pem/T1vbBta/H?=
 =?us-ascii?Q?ASSCNi/5s1aWfLfa2S1oBe+P5qMVBbI2Q5rY70zEZkGfXywNXhZXNk+lGL+Y?=
 =?us-ascii?Q?6emwchiZNK0gcktFCND1Hdo71GBDFvTriu6kX4ZbkM2RbExqcIeoCBQ0XK00?=
 =?us-ascii?Q?IhKaWAIsLoIrhGut8i9li8qIaT2ikz8MVH+g+u0NEubAP2IRxe5Wx6uRnTAZ?=
 =?us-ascii?Q?9seAOmZPnY4aqpZGLdb7ozk0/Ohm0HlGb3WL3PbqFyBa+PW2kfRtODC7Cdlp?=
 =?us-ascii?Q?E0bUNOXNZ0t2Uq5LHF68ALA7eSkpaini9mkajJw8e1xQIEkJGvJZ3DfYkfem?=
 =?us-ascii?Q?hHQV1x5gZL8SoKWeSoOsqAxVuefhP9JVvmssQoClfwRIP2Ew6L7MnJrAR7G3?=
 =?us-ascii?Q?OaENXOz+ePxMlfoAfGkxLJz+olHKikMuxWQJmzOfq32SUY5TQceJxkqZWwLI?=
 =?us-ascii?Q?sALyl2Kwrxp4W2QdnR8tEZecijY19gGMC57n7K26K8FpYAbFRgRK/YxLKYlV?=
 =?us-ascii?Q?aQZk8j6I/bPJptirBmmpciI+hQIKKGRFmkss0krj8RPZcJXBntXDoZXAby9T?=
 =?us-ascii?Q?I31voZbWRdFBhWEF9+D9wYTLbG4b7mcTbKEo0t7WZhmx9pGFx9RPMgRgqihB?=
 =?us-ascii?Q?A4iVCWs0IWCoDgj/CZwsBAtUAgueMujt8U71+KdV8iAXtGQcjU/R63roIaPG?=
 =?us-ascii?Q?rHhBqTXKUtYfF9G+k17tp6TwSzSN7M6GKE7/m6GeHBLSbI9N/u609ecbJO5w?=
 =?us-ascii?Q?W35ZBl4ondG/m+0lpUJ3/cDPsRG+ETEknS4bvrE+bQkjFUKk7XZi/nlp+Gm9?=
 =?us-ascii?Q?qj3Q8Ei46PN/R1RdwC6GfWAyQFnw4PyrABowZvRYKyXwB0vGSfMMjRx4clx5?=
 =?us-ascii?Q?T6AEgx+CYCcZ/XG2rzu0K+YxHuZqGBcFnwReCqeZirLFLYhtWjpx9zQNrdMM?=
 =?us-ascii?Q?VQqTVr49xfhS1CEdI/Nq7546uJwHzFrzCuXc+6h/yMxDucQ7RkAdhB7dTUdV?=
 =?us-ascii?Q?lAT0sRPMPWfoiB5jvuP4EnnDM9ljKhQqMOY/AWgp5jnRwoYPO5SNZ7wGrDzk?=
 =?us-ascii?Q?PHuCKBOAR9T7xJ4EWdcWvHZIHbnJ5cUuqnnVotX2NcAUNfXnSewhuHhRxwuo?=
 =?us-ascii?Q?NSPY0MvBbppkW9BWlCBLI3nLBGqYMot6hTV4q5TRhhPgJpCRpr96q0Uxtpys?=
 =?us-ascii?Q?WcpaOiBbBaUxzw0EqSiMKpX2UPjW6W7algHW78XsC1sFzYJpWx+z+Lf30QuW?=
 =?us-ascii?Q?9xIZUJxnYaDvvjrOCRpjjU=3D?=
X-Microsoft-Antispam-Message-Info: Z/AYVLXA2P1hidVapOXos9nfDBSRfoFlVayhup8x2vB7yaLjd8fvNl1xoNHEUcMkZzVTKesntNtn7U+RID6tWiHZDzj568xVK+w4oDY5KwSWFpoL25OmDvgw3U3HQA3Y0j5brgVinYc08Hm8qskDtjbMTJQCoP7DF/6L1txTi7BXcZRYZ3ER5x2s0WXZeB4072sNg6UxxXAAQtFV7kHbnPz5NEV4Noi1DbHM+g3xv+e6XJCb8o1J+7bPSMZ0YsVb4x/L4UHVzICf8BnmnegwgiopRYJoUhOg3RQI2SHX4QOA/0MUaTBhAj9NWnwURAR+5LKWYy1cKFEko4aUXtkhUomBDlcN9IbxJRx7ZOTnv6o=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:AE5PVSFdfF7BveTvzxsdixKlTcAFn0LDOIe07VSs43e8ZVlzxvJTDNAWnD+wyOP4qmpFqP+8XKijDr/x8dG6U3/u7I40x6leF3bEUDvzovCB0qX9DcA4ivl9EAvGiwSs/j0jYhcGKA+OBeQzYldaIyFp9jPx1+mwhSa7tRIUiXHGFeC8xGEdaK5s2A066ya7IAZSxQypTmTGgXym9WnqdU+xpTh+/0L352XjUQjMrV0osKdA4+ChmGckm/f6uQbBc+bawgjSlOC3JhR9RfhNwCtoxCF/Pl7xjMy9h6UCSF88D6mXeB+G3cGb1CQdVdvd0cqT+Hm48PrH/F23bDKblHNn+79Ju7SROfaBj4yA9MLbDQTzMQXciJBRSUdezPAQQ8uOWWoECshuCx+6/S2DBd9RB7kI4WiF+lX019oXDh8n/LHVPP9xtbv5YGsxAICUKCJJOfVaRSgN+PXKSaCgJg==;5:uIzElYlSfAZlxxeOT+gRPuJF9FoqMkTZQ06E5n2C2rwjr+OOQ5NBwJyLIgX6O7nZUXSgy5Vp48r4QFRWBYCXSkakHnPNfmsTzDRcBuxB8CJLKDzziETfzIFjU98G58X1rE07c6Ig5y+nEDZoj/noQeOKrdSwtndatcO9Q5AsDQE=;7:1xzoGDSaZAKj7qMm6rvs6GEGNipsF6ol0uox6tVu1jwgS9FUkME7NTA4ySTH8EFZnX/Fbs+4tNtfWysNoP2ozDbAceYyRd0c8cbcJ2/sez+fe0FipzzmZ3jw6yV2GtkSbZ8apb9VUcDzw8tannxm5dqYOA4+bTt/9GIYmkuwDG2mhMRM28eXY9PJlsHUiKxbAZF+TG5N+SOygS8vb0tYES0GNotl+yqZ+w7SQkvKa5HDgFb+NBNOvAuynhCiFJ/W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 16:15:13.6208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f0d4d7-a093-45ed-6078-08d5f180a391
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
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
 drivers/pci/controller/dwc/pci-imx6.c | 97 +++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4a9a673b4777..65b6d1015723 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -540,10 +540,28 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 
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
@@ -558,15 +576,11 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
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
 
@@ -680,10 +694,82 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 
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
@@ -846,10 +932,11 @@ static const struct of_device_id imx6_pcie_of_match[] = {
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

