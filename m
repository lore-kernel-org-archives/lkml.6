Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82C6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAAA20847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qbhLfhoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAAA20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeH2Qw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:52:26 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:45091
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727692AbeH2QwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qAGmDD6BF63dOo/zUTsXb7go2KPJgKODZlAmitxuJU=;
 b=qbhLfhoyRU6e3nZXLVLN8120vSTgIFYuayLxj8eTV3kCIVLRNOXwyEtrqGBit3SNbbumqOq6nW+njuP8NWyXDulJYql+9afCGbvGvg4ZRP1lE4R032NJgQ74K3Zr3WJ/20tw3bXpeVw6CpZXSJ6sfp7nEzQc+JCavOdyCsU0T5U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 12:55:27 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V4 4/4] video: simplefb: switch to use clk_bulk API to simplify clock operations
Date:   Wed, 29 Aug 2018 20:51:40 +0800
Message-Id: <1535547100-25634-5-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535547100-25634-1-git-send-email-aisheng.dong@nxp.com>
References: <1535547100-25634-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:36::15) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed464481-d1dd-4eff-0c2e-08d60daeb493
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4211;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;3:lsl6JyZ//rUTcBHS7Y3cB7zAQJDjCMW/1TgKLHf+WgTbCvkVIuyRnFp4GsbinrJa5nDMOLI1vMw0GHEJLG1QpeIixV5XJIOos78+DhSKQQK0ori4nmpLjV+1axBb07zcPYb9oF/EgvFzbY1B/SGtIF5u+qohSjfYzYeKwGMepBmgFLyhaCGkY2YBMzV8qLmAXgBn48n8cCZJtnHWlFB9ozeGYbyxBeXpygzF3FPKmJrGyiPFtWSZC9/xDXGIbVtb;25:0AZQ5bptMfdBMB0Yh10S5NzC1EePslfy0BEXDrOuwL53OGgRJvpPqQRDd8YgAFO6qHNRP4UZFbnBd3uLc5CqqMR8UrHguAKHLokfX+roRrkhrcytVLDVb2qZsO/qpeBsV7n7lq47FrHHRg+UNCmjnf/LANAz7DUXDgkYHLS/cDNXjDpx7DVbOTpjhzagxSDlXbr7f/Py+1BedR5Om4EIvi65qxBkG5lUIPVoFzflgN7NnDZoeivnpj8yUZavjtR6pmTlrDmpkSKqL3OI+OVqMJAoF6fIiZpNz+kOR/gXNiyR3FdtEIMWJrpF/Qbit9Qye0E//DUH63Hl4heoHH0TWA==;31:YVPBBhqbbBJpWsttHONWEQ1Pf7pgJEDn+Ba2NY93DZF0/fhhtUXgHCoyzUr+DSLk4XfOW2gqAH9FHIvSXrSy0674DSxWCgFTjptIuQHjK/e/nkNSaRPfSuS21n3z+2kDkdIKO9V9zGTW/pjAMaiYVL7MVh9rU5ohGjdMTYNufgDylTRXJvyj1PcguOFRW7NG9uNJFe+YdfqaPKDKBOhOU0t3bOaVEbCGl8tZqQeL7ik=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;20:azmr4IE27z/yJD49GH9JQSk1NLaZxZiNvhZWyqGYL5XYX86DJvAIIJ6Q4xDndwGf1oSftNBU2fHUEaJ4B3I5NAP2GTS+748mxkVZfBHhfASEeFsIVr9xviP64j09vIqSftGGHNiGzdWPkst9Jk9oXfBUoo4wOOaTebIwvQTtzdn0ybXFtHxDj8gwabxFBN9kL7wRT6W4TAiTRswyreFamIkLNZzxlEzsyVLe6mxSKDNzOuJ+6rVrwGXhRPEJozjX1tvEZ+naAcCLALtTBQYoUHMGF8gTRt2s+hwJQsrWtwTeeyTy4/5WVd3RRmNuXyalLXGWYqTgTde7e089pwv3zoCEK2vDXXCDNq/AMfDdzC3G3ommeciO7AbBd4hIpq+ub4x5V0Sy0st7azqoOc9YqYjziQkRGpNjOnkV9HkDXVgYbzYSU1AJaavx823rZ5dfXSDfRF2yZQR/K1d8jTEV3TpliptyTdE6esoyIgybOT/IaM0w+9L4zmjxNWY8k/nc;4:z1B3PjfI8Kact8tL8xHEq0g54f4Y77P8MKFa6tiX5m6W6L35XYb/B2zraYOuksl2LQP7SKzC6iCEkXcLPtE3tGhRT524rsflEiLMs+joIYHynhjHDzqoWRzhMDaxBOfm2o93D6JKXAZqqlk0AEGEPYRcATlRRN7yZBK8IcgKl/jG0sU/eWnKebTspDfQqfwLbgK3qTbPdMMW1CWlVc07oVA18enqsIk92Vy8B4ZC+o0yTSM0UUbULRq+7g4y5ODxyVqdM0f2dlclqEIbRTndRT5aHs+P/XmmM7B7l/mR13h9ZDg+OAgQY2q8A9pRX0nxX/Jh9Dh91dGQQ6WVHRaKAdjhrfF2lqZgYmojsKWlAEZLhkMiUWgCRpWggYQVYSg0g87P55rpUrf6n36+bx++cfI/IXrgdXT+CToruojJ9aY=
X-Microsoft-Antispam-PRVS: <AM0PR04MB421148AA53C329AB6F3C137380090@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197)(7411616537696)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:AM0PR04MB4211;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4211;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(51416003)(50226002)(3846002)(6116002)(68736007)(2361001)(8676002)(50466002)(48376002)(2351001)(2906002)(97736004)(106356001)(105586002)(36756003)(8936002)(7736002)(305945005)(53936002)(6512007)(386003)(47776003)(81166006)(6506007)(14444005)(7416002)(6916009)(2616005)(4326008)(26005)(446003)(16526019)(66066001)(25786009)(956004)(81156014)(476003)(86362001)(186003)(76176011)(486006)(5660300001)(16586007)(316002)(478600001)(52116002)(54906003)(6486002)(11346002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4211;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4211;23:wj2sW4Prl5wm8Ps0Yrq+DNYflHRP1EY+owJ7MGrte?=
 =?us-ascii?Q?CVcuTFd79ZgEGLOm4huGf1LHrBb0ULac955dVMiOGsc6d/rNOoPO2Y06xrAO?=
 =?us-ascii?Q?k5I5H6dzpM/RiF5nrCuI7sGWbJYb/J4Nc/d3aQhGl4FExMxeUYFcJQ9cdUO8?=
 =?us-ascii?Q?n7g7OHE8IUT8xO3O9wSwWolijlTzEjK5uJn8lEzmpQoc/pFHV+S0QzkpZx8d?=
 =?us-ascii?Q?sLi4g2rBZXZQ0xXwYHmVcr+gF4sWQguPiNt7Gb2tOtzD74aucFPuaVe1soVf?=
 =?us-ascii?Q?zBUgO0UDPjxTSQA+4rMqVY1mu/6zSUOuyPvFzhPJACDrmviYUTV2+Gp27zlA?=
 =?us-ascii?Q?86Fon1vOm/IKqksa1KSlOQ8gY1xOVcCYSDSRBKDy7kQfYb3tfMYnEd+bBly3?=
 =?us-ascii?Q?Sud+xdqDffvdPa3hsokbu99zCunqagmZALqgo0Zj4JPP0dyCu1cM1Q3i/5Zp?=
 =?us-ascii?Q?hv9oLQnA3hSGVKVDKEr3n4yae+kHw13CMHqQlT53XRtVRKL6DWVoqdW4t3/+?=
 =?us-ascii?Q?ZiMz1ArLlJlIn7ID9V5RBICQQu2oA98NY9ZvO1Sjwf6R7HancB+p4FpDsh0G?=
 =?us-ascii?Q?ImX9dVxskSMrGA14R4L1JgXY1mpTjCehYenJdp4vDr7U4L0wNIark8diywiH?=
 =?us-ascii?Q?HYKnvFPmJT3DmD7tCupSD6J2+HMln8m9s2r42flLBedwuC73b6+feDmhkSNw?=
 =?us-ascii?Q?UUOYdtC3F7MTebMi0fgGG12zS1eWvG82YYx9Fks4/xW8sFKgg6NWl0Wln7aQ?=
 =?us-ascii?Q?LM2yWQRWcD8wJIw17sgrdVGRZ61OiXsqRoD+QFjlfXlI0m3M6wPhrrqtw6EC?=
 =?us-ascii?Q?dqF9D97kg09vnpWQ3fzAB3Kg4CYufNeSuJAZnScvEfjBJ15RBm32YaBCvsZE?=
 =?us-ascii?Q?5xt/muy7qZy+gxAIzd7BInJuCAnHkQw8PMlVtNr80ep1yLkyfv9v2dVVg9xF?=
 =?us-ascii?Q?eCBcfQO9jPJs0wDq+2kIfDrsRDIj6R5wjrClpy6sGHzu5UJ85UdZCr4IJ2kr?=
 =?us-ascii?Q?yrzFz5U7bB9qXN4VTIUdxRiR3wwJpvBrD0aGQzrXvJBrcdfuTm1mDD8xfHFa?=
 =?us-ascii?Q?h2kPbFkMKzJuRF2PvXIOp++MVqPYsmRWc+JmPLGbWr/qjGMie4xMQGxjF2l3?=
 =?us-ascii?Q?Z0AHevAV/UzEop9WkrrjTtc9hb4ks/q4RqCDNFibL06mirdD3XEy3GXoaA2+?=
 =?us-ascii?Q?shoh3dXcH+7xL+TLsylQ0RI3GeSZprE80X1M+k6cACocq7hP42JAy3oti3o1?=
 =?us-ascii?Q?K6KAhmc2Dn0Dz8d+IeE46uKk8p5+wOLnidpcUnE?=
X-Microsoft-Antispam-Message-Info: SyQpsCYupTjXkyEXrO2lOlrzlMRsq/VOXfLwlH3wfvjlf7dyunTz/VWO25gh5q/w4X8dgz5R+IbKFzarTlztl5g90mblvJQ2s2h1E1V8hERvKQVr+vWZ9qv6xWvPB7NK75OxV4HfEb24bugnohn6iW7mAV8LgSspXMdpz8SSA895W6lHzuVda3fh96xgCR/eXogsYttFF0d+VK873gdz43YIysKB/y2DKC2sCUDqwHSyJ/N5Z85QgPuCAZ4YuL9+ixl0lMAbsccasAuWRQTNSPjS/jmejwfnQ1X9Z5TRC0BCILVJEZJguixk5PN0r4/HqA4DPoHJiTS/pPd8MiT1a1RkuQuBLobed91zogRKa+A=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;6:Mh1+mMFVHv+N4xBveu1M3p45rA/EE3aCTbZNdKb1m3CUtoiyZzioPf/vgXDwPNqRDLlbEjNQ7+d8GCoyhK3igB0IqQi7YPxcA0xNw6K3mCJAToAx0+jc+ktrtXBb4qTKYCYmjr24FrmLTR0XVPCTeCForpbPj0w+zf2lSDS/DWpVmBFxVYoEXIyPp/yJPYFPy8WXCt/Iv2J0E3NLykEJ3gLObd3LpKZLybmsdqGgd0khNdcC4NlyhkyXKDmCuiGtYhIrBjHQLte5zyrpKm+AY1GcEGsqo08HlsUMCM3TCY2y/wkWpTqinbP7+X2iRX/3KCPcPRj7aGRALaR5Y4es/H9lfP9Av0HhzPU89j2VLtqBY7OZRQb3i2XJzfxh5uLR7wsUHN2hdP5jCF82eczuJlqNc3aIp3hvFZnfgMNescFU5Lc55tCMXx0WMIGaICSLN6YweBES7BvfftSZbMHBiQ==;5:c8THV1A9Ow/bBkPiASqr3j5aX0NmKbhgz7lrhLQzjhuLzYVeF+c74YiqgZ5DdoZmVw/YJQmp2xGdZR898ZX5MUYbvjoWEUdUYjk2vx5i8acztx4qBepKAfDO6p9RctSQA9ToJ9F/dB0nEhns0QJjIIFTlUT6icYbFHGiXxS6wvM=;7:0ji0xkRKplEZq0H+pVh+SEsKofgNlqARjt9ybtW3LP/BDxeRWZJr2TbCMJab/lzRk5V7opGgkY1g5NXWb4bZnU7rczlMgu/dU+aa+ULDrbwn3edaMHk9BiKvr10SdVIloWDnJLY6ubuEMNcyJfJU5YnxDeKYXjDqM9Ilq9uydNokZg67i2w7Gmp8VebHzbFiL9KB7t7WAG7Mx7FI9WXXBQAJATYqw36k/clG1+uk/Flwy4RK/oW+Me/7dhYCEPS9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 12:55:27.6854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed464481-d1dd-4eff-0c2e-08d60daeb493
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to use clk_bulk API to simplify clock operations.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v3->v4:
 * no changes
v2->v3:
 * fix a build warning on x86 platform due to a wrong
   of the prototype of simplefb_clocks_enable
v1->v2:
 * switch to clk_bulk_get_all from of_clk_bulk_get_all
---
 drivers/video/fbdev/simplefb.c | 66 ++++++++----------------------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 9a9d748..ed9a4c8 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -182,7 +182,7 @@ struct simplefb_par {
 #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
 	bool clks_enabled;
 	unsigned int clk_count;
-	struct clk **clks;
+	struct clk_bulk_data *clks;
 #endif
 #if defined CONFIG_OF && defined CONFIG_REGULATOR
 	bool regulators_enabled;
@@ -214,37 +214,13 @@ static int simplefb_clocks_get(struct simplefb_par *par,
 			       struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct clk *clock;
-	int i;
 
 	if (dev_get_platdata(&pdev->dev) || !np)
 		return 0;
 
-	par->clk_count = of_clk_get_parent_count(np);
-	if (!par->clk_count)
-		return 0;
-
-	par->clks = kcalloc(par->clk_count, sizeof(struct clk *), GFP_KERNEL);
-	if (!par->clks)
-		return -ENOMEM;
-
-	for (i = 0; i < par->clk_count; i++) {
-		clock = of_clk_get(np, i);
-		if (IS_ERR(clock)) {
-			if (PTR_ERR(clock) == -EPROBE_DEFER) {
-				while (--i >= 0) {
-					if (par->clks[i])
-						clk_put(par->clks[i]);
-				}
-				kfree(par->clks);
-				return -EPROBE_DEFER;
-			}
-			dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
-				__func__, i, PTR_ERR(clock));
-			continue;
-		}
-		par->clks[i] = clock;
-	}
+	par->clk_count = clk_bulk_get_all(&pdev->dev, &par->clks);
+	if ((par->clk_count < 0) && (par->clk_count == -EPROBE_DEFER))
+		return -EPROBE_DEFER;
 
 	return 0;
 }
@@ -252,39 +228,21 @@ static int simplefb_clocks_get(struct simplefb_par *par,
 static void simplefb_clocks_enable(struct simplefb_par *par,
 				   struct platform_device *pdev)
 {
-	int i, ret;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(par->clk_count, par->clks);
+	if (ret)
+		dev_warn(&pdev->dev, "failed to enable clocks\n");
 
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			ret = clk_prepare_enable(par->clks[i]);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"%s: failed to enable clock %d: %d\n",
-					__func__, i, ret);
-				clk_put(par->clks[i]);
-				par->clks[i] = NULL;
-			}
-		}
-	}
 	par->clks_enabled = true;
 }
 
 static void simplefb_clocks_destroy(struct simplefb_par *par)
 {
-	int i;
-
-	if (!par->clks)
-		return;
-
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			if (par->clks_enabled)
-				clk_disable_unprepare(par->clks[i]);
-			clk_put(par->clks[i]);
-		}
-	}
+	if (par->clks_enabled)
+		clk_bulk_disable_unprepare(par->clk_count, par->clks);
 
-	kfree(par->clks);
+	clk_bulk_put_all(par->clk_count, par->clks);
 }
 #else
 static int simplefb_clocks_get(struct simplefb_par *par,
-- 
2.7.4

