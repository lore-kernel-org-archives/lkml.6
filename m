Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489A1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24E220693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jY+XlLuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24E220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754975AbeFTJkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:40:08 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:37599
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754304AbeFTI3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=326dECGZxvuGYBVT4L5N7JAlOkOvtazvTaNyXqFO6DM=;
 b=jY+XlLuNcnUKQDsGNw9vy6Lp6/sDLpUqBaYfHG7IHowuhOS6lxgQWG24y9+FRmXJzegcEUKxRl5q3ylfkOYbrWo5OiGeP8VEa395L+0SoNjNUWZc5dHqn5PrkwKVEQpyiloQE7qwAtz7GuXRpAdY3bET4oId7RlgpY0gzrqxOxY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1610.eurprd04.prod.outlook.com (2a01:111:e400:59a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Wed, 20 Jun
 2018 07:24:49 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 2/3] pinctrl: imx: allow to configure SION with generic pinconf
Date:   Wed, 20 Jun 2018 10:24:22 +0300
Message-Id: <1529479463-26961-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529479463-26961-1-git-send-email-abel.vesa@nxp.com>
References: <1529479463-26961-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0701CA0001.eurprd07.prod.outlook.com
 (2603:10a6:203:51::11) To HE1PR04MB1610.eurprd04.prod.outlook.com
 (2a01:111:e400:59a9::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70482a54-0450-4cd6-b64f-08d5d67ee92a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1610;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;3:Yh11rNPvI2Xvq/A9OyA228BZLxQJFQZ6TNQFLNUYQxiPZ7QdQZR/CtPXuVICqsKFdwtfzAGA5hqMAxSk3Cu0+IYaep7Kq78j69gXmF3FYnLzG4wFbRbk+veIkZ0ZET9Me+1TZglCZMadL5Tz1NzZnW5K+nWaNrH3oqW0iDpRNFHONnY9lUDIjH0eG7UPOWOoHgXv16PM/2I5ea1LvI+F23Ly91y6chc4oV3F8Fn66m7h9kfk5bQxSkMeCL0UqcVU;25:DSuAEkJd8rnGhoNT45w+99rMl71bC/nMMxSjdu+PERASqZE1C8B3OaRvTKcLbyiJ2wlPm5gGe4ymohWF6oCDC+YbnLsgm1tDoszUXwPFhCyoO4bAJGURPz5TEl4RJSSZrwFav7VxKpdsBcdEoZ/5JvdMEuT65+Iotvy7D3Z4hG6aU8YPbt9cClx0rh/ROF3VjPHbdG2nEAyv8fDv/OzHKrmoF01eehWjmVGN/yDobvFRoi16p8z3QRq0aIA/yIWbmSMICfupcpfkSbZ4eeBhYEmn67pXM9v51xIOneIVWw3uU14UsU6yBB/adOAMdXt8gyBQj2zO8oofmIBCju4vGg==;31:LrxCfTILTDmMRJ8Drr59o+aGqCzqBqUkFaAb5A8D7UTQ3LHLFd3UcCzqmy4lIhz68WB7TLjP7PfrzrrnpWSrauMXufGLSoZQQ8F+2RoVqC6qYrattMkOl6+gPY9akj2TwS1VfnhJPDH6EScGS69Ir3Oq34mMVXcLr/8HuQrMGsmrJCjdeL1BEv1dxtmxddDue1flb4h8VhwV0SVSBJsm9bECKN+Fd30RI8W6AedcoPY=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1610:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;20:sqG7lHv2kISXpnM0GJrwK+kMcXAI5ANakX8PmQMLWUvxOfrDeYFeOD9WVGVvA+irkpugqDhKopsO7XW6fxyMtEtDSq1Y+9gZUfs+4c2fdCVUsAkEcRgpQ+1r834OSYmDf5buB6gs4kFt/xhZA9p4at0x7LqMpcy8AzmEhqB4ThMKdRZgmMD20S2plLVLw1n/5vWO8meVMXYx/VfG4JwZc89EoWxZz0JDrs3XavCgLCA45vzGQ3GmjbmY3wmzRbhfPBwd0ZSv1Cit4ncKS8wfwZEotCiBJNpw8NEaSAMhCfU6a9P9YACm72FMHyiufHC+S1slm6SeXwOsp63FTFcvlwOdGfcF3/8tSqG7pEEUtA0pPxcgACdUuFoQsaLvuavYRmgv4ZQu6U8WJxIpnD4VYPJSKf8FByXilpxVK7TOrXUairxLUdmG/QA2wIiFN5pNx/9TJqpRW/512Q5+wCVTN/TXLY45yOmyEtOPFpGcFJV6IzhDlGHdfCn/i5JeFN1L;4:goJuwJsa5eaRF3OsgbIbLxCgFswCbgPDWEIYDpAlcgi5TVBgdFjqgdFvIPfhlH6AAIp5L3zVZ5WTTcd/4MUvAKVTReh+XNC7wJxyG4FAJLS7P0s9ZmYq2MZOOTZIMHPVima8qbXRAAPwqGKnaNK0QPNOhLxUzOGFnfzuHa/lt1Cjpt7nrZf7x1mXMjeL2GnYRFQ7o8OIN0dBNFweElahUCOLkksxT8/4vVrGygBB61A08AqXSnLqNxI8o42IBoGZpFO1uUbUhAO7aCpAjgK5BrfHPmOyhXddcA3cw9lCQD/M2OHlkbBrSpX1VxOSC+yC
X-Microsoft-Antispam-PRVS: <HE1PR04MB161089549B76311F7B38D3F8F6770@HE1PR04MB1610.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1610;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1610;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(396003)(39380400002)(189003)(199004)(47776003)(66066001)(54906003)(16586007)(81166006)(76176011)(3846002)(6116002)(110136005)(6486002)(8676002)(81156014)(50466002)(51416003)(48376002)(476003)(305945005)(2616005)(44832011)(446003)(11346002)(956004)(7736002)(52116002)(5660300001)(486006)(7416002)(97736004)(6512007)(6666003)(6636002)(50226002)(186003)(16526019)(316002)(8936002)(2906002)(53936002)(36756003)(478600001)(26005)(105586002)(25786009)(106356001)(86362001)(386003)(4326008)(68736007)(6506007)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1610;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1610;23:6oTKV4wPJAE0ctj+D1xaWJvU1VI9da55fzRbON9NF?=
 =?us-ascii?Q?uTgjDEz5qX9GZQx/sm34lq7YDHR+CfV3etkj3viHZki36TbY/YkkCEpMo2t+?=
 =?us-ascii?Q?vIx9LRReu5BVX31GVPQ71C5rrnS96dW0No88g6xDQKi4yJg3ZIP+gbAF1z14?=
 =?us-ascii?Q?2J7m/dR9xzpZViUYIM+tGgV9lZvnK1SqPGY331306pbXR9gFSjbFGgZ6SIjL?=
 =?us-ascii?Q?S/w/FVAeH65h9w2/cCBFxGbTHkUsfFJJ2VfOu+yFUbg48UmhoKwnpmrWdez/?=
 =?us-ascii?Q?TzGewX1+xeHpGKd3VTVUvdX/aKca7oVrNzM81TQauLJ7xlODLxTNOv/gMvAo?=
 =?us-ascii?Q?C93/DVVu/RgfDVQp+z7ZBCJnQhasfDrzYYA4I4cM29KxYfEtl3FpD9AYs2RI?=
 =?us-ascii?Q?ACRdWD1zTsz/P1pN3OrWlVuEpZAze3cVA4FBA9Qy1rxzh77NP2HdxKpxWGNv?=
 =?us-ascii?Q?CX3m04zO6mi1aGGabvIjTcIeZdEUVa81Z5d7WnL2yUUdwDpjH8xYeJSPwZzQ?=
 =?us-ascii?Q?zMPljILV5tR6uaysctdXR3LUBCoI4f4qSO8+7lUIbE/VktDNU8jZZTIm9Vf1?=
 =?us-ascii?Q?Z3aBPz/eD8UcjWQ1wOzQBldL/fT+QQGGFCAhFhaj0gQJndysVVFNfqZwPw/W?=
 =?us-ascii?Q?uTZWgYIPX/meFXUycr1EhfUWikF5OObpwhjOXpO3/bZVv5R8R+nuNvqwHGNg?=
 =?us-ascii?Q?cZwIEMkVj2yfUcUoBskDXpvfIzsDcS+qW80OJ9rthwlRj+eVXI632JTJmINc?=
 =?us-ascii?Q?YYSQSjE5SBwkbRAnyXylfJvPZIqKpow9rETf9zub4d4iLztVO13ijVuW3EyW?=
 =?us-ascii?Q?B/IaXEunE5PK7vtkLN8tTHcd90wBK8qJS5ZwT85Quti+mOla+h9hW/tSroH2?=
 =?us-ascii?Q?zaRmWJH33OdhZxrKa/cbdMi/SAYqor1c6fWY3UF5u4kgXUybz+jipPXnM0cO?=
 =?us-ascii?Q?VICIpMpPcbZP3OiQ+A4etFgq5GxTBwDrTfuhThNzpMxFyYLNZgQhFzLuHMFs?=
 =?us-ascii?Q?Rc+1sJC8cCHKzZvDTrRBVl/DG42j4Z0O60qf+ad84ALgKMfTqOeYg5rUL/3i?=
 =?us-ascii?Q?Gbd3NcFRnB1VpIIxKbHviXsRKGdBs2daf+PhMcsfqQTgaZgoIHiTJqV66EnS?=
 =?us-ascii?Q?pa6aDbO6FMMEuYgh7T1GODOid+MdVlTquQxTkwbHECST/9aNNHvlz+uIdnf1?=
 =?us-ascii?Q?AMkOZp2ebhstqW5mZk8xD+/pB895UvU6Q66DQWpwE5V0z7gcHmfDgY8oAehj?=
 =?us-ascii?Q?hfPKwcWcfu+Ad/uiN5d1yR+y12yKkRhvVSJXQ7B1Gde7nnlrelqR89GBHq8w?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: Zdb6UhjnrFPqUIANKq0y4fCSub9go7kWUV1AcGTBY96E9mMNDnbCl4GCNKdf11CiHPG/QU0cIf2Z329Qc6ROfJKMF51HMV8d0A90Nu+5V9u94yA0kpl9hHaDGKQntRnm5LwyomIA12pcrwAPzCgwFDxub74jFPE98oXRY5o7gY8O9ewQksvdrLEfeWXBzpO/mXtvzwEKnggqzowEdChPds9uVALe+oYgF8AJe5s5nAPu5C7fzL0TMASZwIb0KjUU2wxydSsoRzN/izZWJmxiPTMvziKDN2ciiBY65S4vyj8Isxwhark0K0yOgI1TjaiWVF9Z3RWQMi68fQsmA+4fbA==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;6:ROkwcrMZ3l+XJZETzAPT0XCRSzb0i35jYrPszJ4no0z1UvlMlPr+xcv8M6L7Ythz7EPgs+44cxRn2lSCeVd3KQ8OdWIjE4ZTK7nWmnuIZY/a/g65ZpPfUrjDUCYF9WNs+gTpu0oxEu1/jgmJ1livtfDJ7SFIpYvxQgiZ84hom0Ih+5/diqCgAhJ5yKN1E9kjFyeMFpKk28Myx0muLnLxZkzv4a/nJqVQ1gqOQACbNDCK9fqMSWCwOTOhfxi/Jk5iHwqopJPr27pNVmVPcJI1qGGffMlhiYWtZ3wN1r6GDeYFf2KRX8sZPmEF+n+GAGEYE4EoskdrSNw7lsInX+YfyDxuufASBMM/chOv/bDyBBJOAXmQKJaDFCurV/NstPo/EArZne2iMTxNxzrxbNV/udi4WHOeTM2qDtlkXPYqFe1JrzNwpcvjC0HBQb73Z7B5fpRTY9bIs7XgmMJWCU5l7w==;5:Xug8VzuPBGAB/6m8FQrXNXT/Ub6+ubqNrn9snUTifcN2mrtZuz/O40Ybev5wMYVznUGQkU0C2b5GVx/cxrsVi8jix5Da1X9N7oNcGr5HScvziA1XmTvquYJkIu4oKQOu6vIL5ndnr7FLth7TSmTADhIyxOhNeuIujs+PYU8PDPU=;24:V5HYX2ja7gmCqVMYBpPqHXtYzs5U1Ltm6obH+9d/SogrC1/j8QUEu1xYi9wJRMwOvnyyFtKAHm6R2N9N5Dorv3Wt8g3/ayhTe8qFVi4V1f4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;7:mkWhXRGrM7jGJSCsGCNDiXdpTYO0Z2x5mOYI3f//uuwgAePbmxtiBXS9RdxIIvKWAi7ryhe3d59BMvZnHtXysDP2p3jT/zu2DQ9AwV+61pGrNbC8o6xzGheOiF/EBo/zPvRiJo+CqtJX0VsP9gNjWgRhJJDTBBP2DA5lCqTroKkv4InH6fQ4hu5nuvJS+4zRLU2wbxzZJAgDLfL4AuZfbMXiLH9pLuF31HWOubMVHBCh5HiwqeJtgSFUVAHJIMPh
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 07:24:49.7376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70482a54-0450-4cd6-b64f-08d5d67ee92a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The SION bit force enables the input buffer, overriding the configuration
driven by the muxed module. It is not located in the pad config register,
but in the mux register and thus needs special handling.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 19 +++++++------------
 drivers/pinctrl/freescale/pinctrl-imx.h |  4 ++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 1c6bb15..335edc9 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -26,10 +26,6 @@
 #include "../pinmux.h"
 #include "pinctrl-imx.h"
 
-/* The bits in CONFIG cell defined in binding doc*/
-#define IMX_NO_PAD_CTL	0x80000000	/* no pin config need */
-#define IMX_PAD_SION 0x40000000		/* set SION */
-
 static inline const struct group_desc *imx_pinctrl_find_group_by_name(
 				struct pinctrl_dev *pctldev,
 				const char *name)
@@ -514,18 +510,17 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 		pin->mux_mode = be32_to_cpu(*list++);
 		pin->input_val = be32_to_cpu(*list++);
 
-		if (info->generic_pinconf) {
+		if (info->generic_pinconf)
 			/* generic pin config decoded */
 			pin->config = config;
-		} else {
+		else
 			/* legacy pin config read from devicetree */
-			config = be32_to_cpu(*list++);
+			pin->config = be32_to_cpu(*list++);
 
-			/* SION bit is in mux register */
-			if (config & IMX_PAD_SION)
-				pin->mux_mode |= IOMUXC_CONFIG_SION;
-			pin->config = config & ~IMX_PAD_SION;
-		}
+		/* SION bit is in mux register */
+		if (pin->config & IMX_PAD_SION)
+			pin->mux_mode |= IOMUXC_CONFIG_SION;
+		pin->config = pin->config & ~IMX_PAD_SION;
 
 		dev_dbg(ipctl->dev, "%s: 0x%x 0x%08lx", info->pins[pin_id].name,
 				pin->mux_mode, pin->config);
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
index 4b8225c..44567a6 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx.h
@@ -14,6 +14,10 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
 
+/* The bits in CONFIG cell defined in binding doc*/
+#define IMX_NO_PAD_CTL	0x80000000	/* no pin config need */
+#define IMX_PAD_SION 0x40000000		/* set SION */
+
 struct platform_device;
 
 extern struct pinmux_ops imx_pmx_ops;
-- 
2.7.4

