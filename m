Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365D0208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lIrIAkCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365D0208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeH0PPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:15:18 -0400
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:11424
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbeH0PPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnNxjrhbGg0wNbsallEvFRK62BojjLoThzOBnqWDmhE=;
 b=lIrIAkCgrgu4dgsfRwyWSvZ/hGYAVt/CAljOrhsO1HM/igo9JwNYoR/2XsOwPJjkXWXvuNJZqDHjSph+ITgoOXdtTYcINj7e/TkCDN2LSHRwvLW3r1MvELW/nQ/bLZn93ae8TjQg1tboMpH9psyENIAKPHcussKYMJmctxIECf0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4296.eurprd04.prod.outlook.com (2603:10a6:209:50::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Mon, 27 Aug 2018 11:28:55 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND] PCI: imx: Initial imx7d pm support
Date:   Mon, 27 Aug 2018 14:28:37 +0300
Message-Id: <d577303de61fb060aa428898f5df1d0bc9be89b8.1535369231.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0302CA0006.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::16) To AM6PR04MB4296.eurprd04.prod.outlook.com
 (2603:10a6:209:50::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20eeb764-8eb0-441d-49a4-08d60c1046c1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4296;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4296;3:3Xp7G1Mz/6NoNSNTh9jGy4H36v7mEaaFaDoPNn0N8g/8KZo8vunTrnBehhK1KmZnk3nkMk9e4UCn7KNoR5VwTBcSERf1G59xT5A0G+xGuf/Yf3qM2oFBz8P2H1Qo7TQ1ip7fmhFKDpXWDlVw4DGE2YUFOXLKwf4drG8JXYAfCfA6+v5JJ/ZC9advh37xdSHjOLxhNl96pd7UotKwTW56PHUYk9S0pHMxTDJJxa1Dp99952pajKU0zKfjjJGZ75qG;25:A2h6ntaZITa3QueY6wK+3jAQShHrBVv30Eg+8wKMoGIa0jEXOkEDX1tVf2UQ6CjnjFSxbHG3QzrQ171nzfWPfKxYmTBAnN3LD1hVyPZV4wYvPd1Ijkpzw4KvyNRtAQlTDKI44CBAnP2JSW2DBiphYY4p5yCDIgVhX+ChgR92a5oXQr9Jgbz02NiMBziDvN4qeBgpIpdTj68QdNhJfbamHLL6EfmO2WxCt9gOYS2Vxukfd4akCZmewSyKIp4tGnAj6rF/S5f4eqT1fU4Wudf6MYZdUDlHO7t66BBo8xB2+Yq+M4CR21spDb7r+8rTSYmKsvkVOa6mQrw+YiaLAbo96Q==;31:2tgUDRq8wVznkT6WrpPOKyBOabhuUe1DKnFty2r5C+asUn1AK/4U3RSY222lzQq7P6xTiKHMrZLnTCvmcyTq/HsYbSik+DNyxOGGC3J/oV570L4geUouc6VgUYPgGvzAyum0fAfOFbmKyOdcsydVkBRM2vas9W227QAFejVKwOq1VqNQbOI90L5nAcyeMP6xEk0lrew/MhnCM+pGRoFdeV5NIrdQPKdNy1ba1q/+AKI=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4296:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4296;20:aEVZNf1U2WGDI9IEhvgxj99PDaGOKJmUqSPk4/SEl6VekT9RaI4Szx6C5wd1iBhe6Ju9RMwkG2z+pUsivo/dpJY1lruLEAEzUc703tIfwlwF6NwMn1KXZ392ZSaHgqkAOKa6dPJKtWWR2bq125AsBKLh+DsnownDbcF00nqpLUX23F3Bo4ipGZQtjbXc1JPDeOhIDCkVfHwqezoeXmdk4ZsMYgirme+pxAeb3tJKJowpiRq4POosASu9ijD5BOwdE0hKI7FM5ifkxZZSpvKIT2x0+hYlK0U/bQ3laGW0dymZ8ar2DsOXU0dfPf9xvgyeqAmOtpq1OY/D26vBxbYY2366TZjHdilE5BEM1o8AODZRE3gP4BnaML/2jinrWQrhktzHKVJR4MFEblG39SIGF9avURnRc7UKAn3qmsKGRVay3X9cjlG0FjsAzyGDnPLsWhkBS1FIlT+/h7bnnT139PhntO1NublXh34I85BdvzCoTWrYr0R/lg2MieD2V79P;4:J0uP6RK3l2gvQw/iELV3hLJTlT6Tn+7H3WJXj90zk1nD2mVhJ9TSkjQ9NHLW6Q+ZxQm2pO98KjgRFTQm/dB7xYytEHjKwc0rZe9i3aBKh8ZZ/MaVUkkxrT/kfYm3FvRFX+k3TCsP6qSlBRbjWgpWjQYT5n8K2UFAEAUeKBteyO3zGo7doaBhg9t/OKa6L/aT9Pj0n7MtFgdc/+w89QybBhUqlo4bjT6rzxvB59iR9rwo0u9+7aH2U6JFzwY6ndg+JKJsey+KiFCmdrVrqWkMSeLJ9T3GSDxBKUsrEKqiZxVhb6lyB33VBMYc4rCWZ+Zt
X-Microsoft-Antispam-PRVS: <AM6PR04MB4296E862398B9D504F04A362EE0B0@AM6PR04MB4296.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:AM6PR04MB4296;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4296;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(136003)(39860400002)(366004)(376002)(396003)(199004)(189003)(476003)(86362001)(2616005)(956004)(5660300001)(68736007)(54906003)(2906002)(53936002)(14444005)(478600001)(25786009)(8936002)(39060400002)(47776003)(4326008)(7416002)(966005)(66066001)(44832011)(486006)(48376002)(3846002)(6116002)(8676002)(50466002)(50226002)(81156014)(81166006)(51416003)(6916009)(97736004)(52116002)(16526019)(186003)(1857600001)(7736002)(6506007)(105586002)(386003)(36756003)(305945005)(106356001)(16586007)(26005)(6486002)(6512007)(6306002)(316002)(118296001)(6666003)(69590400005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4296;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4296;23:rq442ramJnbO84ton5r7t2LDRtPJzpHkxcw4PGLM5?=
 =?us-ascii?Q?bQKg+coGsk5alGfds+NN9+nv4H3cYeMzDWI8mHOxYtr7T4KMmaT0lOxDfF6B?=
 =?us-ascii?Q?wICIJ7jFvqAUsjlwjMRW2qGu7uQ3/dvtWUF2jYoZmawNtyirkwdR9ig12RaF?=
 =?us-ascii?Q?oS9CrptZiIJv2G2hDGtCxXH/0DTi1gqVwuXW1m1nfvq2rg0p4YGcTAITvwpY?=
 =?us-ascii?Q?5t83FDmBkEOEGGyajFi0E43/9sZwnksUOM2I78ap4eb2BNqB2/iabbZXIAPP?=
 =?us-ascii?Q?4W+z9/MC/nAIki/W2xo9QM0BFXbgglwfmOds3sNQlGhgB0fF8WjV0qkNbuVd?=
 =?us-ascii?Q?0Vb8k7eOjrxpB1ks0PVbWek51llG1EysXmAexAPBbPWpqh0OoxfmoXFgMf8K?=
 =?us-ascii?Q?X9Ng1G+j507uu8BI/+ZpU4WI+zWjNqnuQyGt8/8z9vZxwhrIYnPaAbya//cx?=
 =?us-ascii?Q?nLBKcF0Uzw45wMm/l8r6n5WgSktXxk6HzV4G8VwyjnY+EaMkjfCX7oYUqXTp?=
 =?us-ascii?Q?klMY+Ih9HsX8DW455V/XjIXq3REjLyr3XRnuBzFzEYfpKvAvNucgHYqJbOYx?=
 =?us-ascii?Q?vpvAxGOOUZdXAVvJVqFuVhTWOr5sDmvSrNm5AkEwLBiNIcYVvBV6q0wBp4WO?=
 =?us-ascii?Q?Vo5HOQKnLLHRD6saDASf5+hlghEfw/N2j2TLNgMo9+arNqL/dRmUQTUMeiu0?=
 =?us-ascii?Q?P6EDHSBChO2i3haRwbt65n3WO+NdE1k+YNoHi9tve00qBVO0lJcBiBlO10xS?=
 =?us-ascii?Q?b4yWdTMUVIGNtxpB2sStW0Y0vT9nBILKG9w4aA1mVsC2uv7p3ObbHI5lSQg1?=
 =?us-ascii?Q?AaF8K+hpKOGG6kg8oecRUdY/8w14/zSMmVC5qCs422u92gcIftv35FIOcdn/?=
 =?us-ascii?Q?ILpfkIDLgH7YosPNrMSxbFKAJ/wBEvHuY3jUqXZL7Fq2XPPW7MQyJjB/KwS0?=
 =?us-ascii?Q?M8P3E/GH88E2Z4P0MP7N8NliLZC76YNct37wqpTO/Z7qJbuA4mjIifzH1ag1?=
 =?us-ascii?Q?2WzGAFHHW8F5gs+GlW6fMUMP2eUdc+OXXzWiXtc93w+wZ1/gHEkX9H+K3Fit?=
 =?us-ascii?Q?GlB9FMSjY9rlX+1EaLYLnE86Rt+H1mL1Ek+dzY3heaTH2ycQB9Hz/CqjuOCB?=
 =?us-ascii?Q?wfOVPLo6jQLAsd2mEs4P6f97DoCBX5w9KcDeQX/Fu7PqQvlu18Z4qY9CkykR?=
 =?us-ascii?Q?MCJZhg4u9Ta4zzo/42wcC0/97wFzmHw7jzruFTWMPTDL30rHG1O8Pm/Hx6Qn?=
 =?us-ascii?Q?8Io0j5dCdUJSfc8zgKENN0WkJC2qTjk1J45qvafFXGYuryA6lAHmy/lSrKtI?=
 =?us-ascii?Q?7Xm3KNRXEFAek3DMFpzpw487hzf+ZVyEi4pAdY1IyVPXAnprO/j49HAmFc3y?=
 =?us-ascii?Q?ttWrQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: aaOW7i9ojL0YfmSgQLJt97gkkTogv7XqtUj8vZRbag/MH5n4bGA1LWhgOlqHkTLW25Ak/7rto6KAM+SmKdnlRBMyTYDXBeSLEqWLUZzCPxYQg8365904rzUWAzPdWlKKZwDyCaBNVGgBFrrzayyL8MPnARU8DvMl9MDeQlv83a5kDWFFSX233PzXt8TbC4FjBd/iZBXBw/c2sd0w2n20RKdCRWGPzkfIVoow2mEMgq6JQ2Iy502MZXhl06Iujsr1invbgOmU4MFT2Oz3QKoxGsJn24k9ORrfq5MthBXk5IRdjC7mcIJZz0sKQoxebQ+qX3i5JXOXT6ZhXIVeOPpfE5+C/ut4y4r5CDl2qkCjXng=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4296;6:w0YK6zpYzVmZmKOW6gVGV6XZgF9xd+u+8AT5r7YiBr3nZoz4Zk4k2TFVbqghf7RAZW3gghrFmjHeFymb3toZ+MfmPH+N7g+mAh/PUFAiiMQXuqfKuBSU0S7C8NKfc7RSN9ELmjpOORrh501jfrZ4Rmt0X49UJSUINZY80v4bjvCHtRS9fdu1Dr2P2/IZ4owcbjMEpikBE/KiKbKX5Lz37THIM9jeS3CHWCO7CVRzWRk3OjjmvKJgLMcRzgvh/HsPwUQflaSsaPc0Wl3dYCootqAZ2glp9ugPT0SddZXIhyMei4c0hq4toj2/1mrsxa8ZJBf8W9ZKI5Fk5kH8uDfwLrGQILDX9DLCnBgO7+PZBM0HesaN78H6SnGheb3ai1OVGs1sBUqNqth9mEqt71A48DlAMT7oR2s6g8sLqtlMO7/tqz/EuhypZJLPuBTrOBENNw4gw9rebBpyDHLzsCn1oQ==;5:itX0HH01/G0bH0QF7Ib6pzF+najsy+wuUcslRhI0haRfNnsmXWPtbiUnIDm9G20O5uJy58TUjOTZa6yVLIkZ90XKZ08VQXBtv1BcuktIBX0QztgUjgDTeARKYVu8g+We3Y9dhLsHUSmkRY8Qfbip/g3lh+bKJ4V5OntQD4vnv3w=;7:LRrWZYtzLjPyhs75iMEhBm7BwtsOS/WdS8ZnZ4g8+1O8SrLuVgqVxVIaVT0dQ7NysFMu6L5dADzPlcTUcsQe1ioqhnps3h80hcKZXhzko38KFdLGJKI6Hgr+ezZL1f8wgpir1CFDhE32QaUtg2+0aFyXf8duMo4HFgPK3ex5/iedZX9foxKPLGvPbx4yy9Mosxtqhq1mcLOsJhRZDYT5QbzihNzfWxjY3KnCcFJCc5O39LGl2e2YgieXz3qQkr7s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 11:28:55.5339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20eeb764-8eb0-441d-49a4-08d60c1046c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4296
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

Resending after RC1 as suggested here: https://lkml.org/lkml/2018/8/8/496

This was initially sent together with a dts fix, that was already
accepted by Shawn: https://lkml.org/lkml/2018/8/21/529

Some dependencies in this area are complicated but as far as I know
including this patch without others should not break anything that was
not already broken. Since this is a patch for something that has never
worked before it should be treated as a feature not a bugfix.

I have a few other patches for imx pci but it's better to deal with them
separately. This initial patch adding suspend support is useful by
itself.

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

