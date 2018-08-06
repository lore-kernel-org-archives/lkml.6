Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF8FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27953219DD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i0MgBI+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27953219DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeHFIwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:52:36 -0400
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:28608
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725739AbeHFIwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xpW+TEGULKyl4MTv9nLkaaQsSSpu77JqGoykO0pjSI=;
 b=i0MgBI+y3cCKTccuI9ErH9UC0QVZJ05ZwdVXCRFEmeoZa8qSAt7tAxqmNo6bRxS5KEDXmdsQ87xhPeX6mH7Ik72jP9RP0T4prR8AlWA0a7xlorEEb/Vc5M7PpUP/WJbPLUoI0NaQo/tyWP5AlsYSYhGM6c2jR+SqCstZZ/iQz88=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.17; Mon, 6 Aug
 2018 06:44:10 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] soc: imx: gpc: use A_CORE instread of A7 for more i.MX platforms
Date:   Mon,  6 Aug 2018 14:39:48 +0800
Message-Id: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0078.apcprd03.prod.outlook.com
 (2603:1096:203:72::18) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ec30f15-dc51-461f-e126-08d5fb6805a8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:k0RIj17A7P29zC2McKzLvm+zeinf2TXyCdkRQ1SGam81enxJzuq4w2X9WOLca3pq4958We3dUy0xFE/+gMzIQmPa7GmcuLsTX0RPeaysEiuSLHzWHvlr/O/Y7K7XbUhVlQ8vIG0ByPD/K5TQU+3Y2mU7oar03bOu80b/BAF8ozrlzX2wNZ558nKc69Fo6aVoCR+wqLt5vilErF4UOYIbG3Rh7/mp+zEG9p7hB8KLJyZhdKIPLgsVZtp/H594yXKc;25:CR4XWV2J5M1Wrpw29qINeq8Ogylf/O4CzSSoloZ0EBEBJQAxJw5tzo+wri2WCBgg/7czCrcr3msR2f/KGJuRcKiVe+OYkmnHcvcBjK+H8aqh5UcfyVSfkKDwK/vIHqn0gnW5iktWY51iVpJiUQQQIwqnzZrfpuZxAxImxzfxkYit2N4+rH72AZzeGpiVvPLuE92qkpr0C5ZtlP7zOtxPhdzkc6clQQ8wME8vFgv/pIpnXGfvOxQf+GJMEXuGrtftr0ndeNUjDy9lnHasmIIUbgBYsLyHlgmRkHlyG6prkMSm4xlSoMmnwhrFL0PgJDe7X0UzPsuCU7CaWe++arLsQA==;31:fQoeS9C9UoF+m2NMr5yugxKaJjC2YmnbgIIgBHISuKw9rW4RJxVAP7PqJKDvSwqCX1bO/hbITPur3IXMw5DasV3zkorT0M+97DxQD+6MxJ6nMaZurQRyvPPOrkQeFc9RfRiJGEzDAHYhoNiMvayuZnTB4zpu9aSx/r03sez1hxXybrQYHyYBDTQiAM+1ZDktiBVVOSHmkPhp2WSqxFnDEfwR1s0uHfTZZftEak69TMI=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:UX3dj8bE1H2jQBQO4c14J60KlJdUkyB5ciDAWirSfNGig2KiA4gKWScEo9UPf6E6fFh1C0ZYKBhngoLqh9tLAnMMjHrp3gspQe8mjNN/ATvBEl0tFIoo9FDS9RpZb0fjw+jiAyY0ktexFQxvoyt671zuFWr5vxFgpVO1Ltu/9WZ4nMvCySwJpwTDLQ2+ytS7akqAnUotymwrcZrF5BaydeFIjKDbh/w7yld9cJx+lzZbME99IN4cqmegwI+Jg+1DlfXIl7T8Dpx5/qXOMOB3dN059ty8hllFA1w5c56lYRK6r/KpA3YHI7WhVb++TWAEpcKXaQyGztAIeycbrlFITtijGpjHMktZ7UBTnX8yKeYhZvQx0QGEUuQ9W3WpYJO0kTIWlpAWNRLPbtVK/aiZteakJSE6F/sDlh7cTzcy9sQPx0twLO/VUX+i7GrJX9sEl0pK36PTuF1pKanAkNsVVeQWA+ezvubg9LWB4vSqj9JpdWUC7bHsiSiu0QwikB8R;4:E5r1URhUcI63hEFoxFw0aG046cyQKAZeeZax8/3cluh+D0BPhn6s/cPb549GqVk7WwPzmityUUwKHIvmK91uW6kFO5xsGlHcBigKhryK+hkBrwi8UyH4ceYcZGiLWKv5iRwcYHLyigkR7DYLSaEZzX1Ppm7v5Lr4O45bHK0NeFI3DrR+1o1uPBCtrFv/IJ6K6PQFNK33wdLhKkuYkdNfOKZyx5lWyzsRCksQNYQBIkl4J+iigdOm01Xcb/j6G5GvQBmIvUDzDGiB/u3lv5kzBRaAaWh957bNA82o4U0doB5/ANevyu+EMyafvWC3EW4l
X-Microsoft-Antispam-PRVS: <AM3PR04MB131527184B2F7E6F16D72447F5200@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(199004)(189003)(316002)(5660300001)(6486002)(36756003)(16586007)(6666003)(53936002)(7736002)(6512007)(25786009)(97736004)(305945005)(4326008)(106356001)(105586002)(486006)(956004)(476003)(47776003)(8676002)(48376002)(50466002)(66066001)(81156014)(81166006)(8936002)(50226002)(2906002)(86362001)(575784001)(52116002)(26005)(478600001)(68736007)(6116002)(386003)(6506007)(51416003)(186003)(16526019)(3846002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:olMCCC9H7LUyP9Wufq5TcavtZRlQ/h90suAsJyBbm?=
 =?us-ascii?Q?XIT2u72fVEA5+igPQLWfl1DVohnhT7r6+pKdFvL1Wlz8EK3bbHqiyklD0G6S?=
 =?us-ascii?Q?KQSJvZo2JT4b2GjhXXWuK4s+EyIRe5dS27Xl83GnhQ/PWFBl24ey0L5kmgAE?=
 =?us-ascii?Q?9fE7rklvKfaqe28+wcuLlrzB608iKfTeHQGRbALf/EJQhSYJkPcLI61KCFbx?=
 =?us-ascii?Q?7rk7Bdh/Sy0oCN08gXJPuUp0ucQVbxWm43GoNRy6pgZJljy5jnSnHfJnImNG?=
 =?us-ascii?Q?mgMuEP70ZChzefmXUjAgCRPKDSq89thN1rjiESNz9zrM9RN1o35N0ZkQgdzi?=
 =?us-ascii?Q?yXaW5TdDdstlYNYQ70Li5OC8vS7vXhNBwZaq2dzlWhyiBvaH6g6O5HFlZxWD?=
 =?us-ascii?Q?gDtuDWmAL/hfIaakcY5Mg1M2zZJ5mtxQ3Kry85igVN7TwFWFl3XqJu2p0y0b?=
 =?us-ascii?Q?KqX4l6x1OEab4Kb5d4OPL1DM+ZoteTUq0+NYo6KpDTZi3M/Ev0eV7Dlq938L?=
 =?us-ascii?Q?7ATFc/5YkVtHhZSY3K1EIjeSEBOl3/91QClzZbJbRReawfwWIiZkdBO8KVh9?=
 =?us-ascii?Q?5Kdpb5KKfDID8sxP7/am7jjIwxSvW68NLA8JKy77YcwolprEwEEjZ/lKyI6/?=
 =?us-ascii?Q?FG1cGPwmv3GpOjHiS76nf4jZd8gZyNnaEAnarx+vUTWtJraSforV04wmPGaO?=
 =?us-ascii?Q?OomHA6l7uZT8see+k8q8hp5kC01oMxSDITAXp2NG0Iv2ROtw9ubn61s0ntzX?=
 =?us-ascii?Q?1xLWJMYlhX1OnQUKcgUyW28m4ckuTX5MpnRVDGQqnnp/ISv0wjYSueY74FA8?=
 =?us-ascii?Q?0yfzmrOhISsxTLkE599Sx4C56meab8eQNErUZrJlSJPcMatsCqGLD0R9BWhK?=
 =?us-ascii?Q?fLGosh4e/AR9OJhcho5ZycklLUBgyASGO6d1xwmYnC1Pgq9++qp0IlHLdcyC?=
 =?us-ascii?Q?GU+ewRi4kxTRc4w8qljJgrQyqwvwA5yrjey+uhBRAbsmxDDcUHrk16wG9oHb?=
 =?us-ascii?Q?Y7A0sYNeh7KCl+24irOOpwDpiMc10O462XGzvDXxHwWvio3yC2GzAQzYx0gd?=
 =?us-ascii?Q?CA4M9lKNPF2mTbbLtKZpZIvjpufDiTpQfGrR6LgXLbjlP/m5rIlrtskhFfdw?=
 =?us-ascii?Q?bctgTfrCpE=3D?=
X-Microsoft-Antispam-Message-Info: OeuwBV+ULVQJM3xP/fbRpovTT6MuB81+r2/MUvHtU/4oGwpRg350PfsPTBJfOV2WXBbrmUQu8xfeEAOmcfcsXE0Pm+OQA0raWekdeBh9/YhFzRdDSQQuUYtiwMhJ0VAedCl/MR0jwtLrGm3WbXkiWT2PbVGvjQtyRwfsA+BVUqv0G2/VvhTlOyWRONpvlwuPvxkPcspLD43g8UBjS9qbTNFiJgSjnQWQCKeuIM1DTKv9bxg0NhdoQLqGGlsFg/6hDyO4uBgE2WaIDzPz0K/gwW/iUfbmgT8IQY9X6KJQk4jiP9L7RrNUVQk2HtJhyDVxAIdCqgPY+LGzrr+Mo8sI4r7Sq0l4A2djidqvaNtb+Vg=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:Kmxi6/OVk6IT62CasZC3hD2dg/C6zZ4WngIjVmIfN2vWmUtSQXiaM1l+LVQRnrIH4iJN3OA0QtB165GGKabH5OnPpnxzl/5EL8qzcA47izTva167pOLpWYNe2zen/ix/gdWak5ekZt9lVTTlPCbFuZdr5batpyjRg0fX+DSuL/CkYlUzo/eIy974/ia2nrKw18+pqDrWuAfO3CitdpgqBLgwLZg0usPErgTPyPmLVN4KVROe9uwXIJfMNo/+K0fbV/3/VBM6rzPy/s6lOJTcSZa2MJEMeSho8OoBiEMzi2FHGAwmMf/smQjtZPejpvzGgBayOTWY4YKAsbhn94biYQujpIbi6T5KnysHzmNh2r/1vfAbFFVCyNJwBqblNudvsSzVd+wg5FEY2l+cJBS/SD6hM56FW1298dE29BA9+InewGoiLefzr0NNzzYJ8rkeQ+gPewkkEKIpgHvvPWXrBw==;5:WxWoZ+fEndWuIs5es9ZLSTmMlZOpJ7ZeD9KqIub71r7pOYvL5jqyucZ0rohQYhSLLaJbQe2y5p2VMRfl2RrbcWrgO3976XLNNSaOaKq7L1bPyeAu6tcoxXoS3KPwxfzNtN9gQ00Klnr+7VCgDBykklmfzo4/PxDSQlbsllJDuNE=;7:cDgAwnQBYAJpbCj2IgNsHrQzWaBIl8urRtebZFOS7WFfWTwq+p8GJ+uYgQDgOxqnIKzhGj8uY5LIkhdWlcSDHzVYp8q8vqHRl+AT2td/P7OAMCgZ01ZCyYWg7Zjz5/TgIyuNB9gcCO73ewFgU/wscpAR5Vk9AuzHHzaZmzOcuqt9QZY3kThWzHE/rd9u6rxdpKK+D3pGv3EUst8QgU2jjgdxxd8TG+JOa3QNxdHPfu+0lw+mXDxLsQEMDCmKDH9X
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 06:44:10.7176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec30f15-dc51-461f-e126-08d5fb6805a8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpcv2 driver is NOT just used on i.MX7D which has Cortex-A7
cores, but also on i.MX8MQ/i.MX8MM platforms which use Cortex-A53
cores, so let's use A_CORE instread of A7 to avoid confusion.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 6ef18cf..0e31465 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -20,14 +20,14 @@
 #include <linux/regulator/consumer.h>
 #include <dt-bindings/power/imx7-power.h>
 
-#define GPC_LPCR_A7_BSC			0x000
+#define GPC_LPCR_A_CORE_BSC			0x000
 
 #define GPC_PGC_CPU_MAPPING		0x0ec
-#define USB_HSIC_PHY_A7_DOMAIN		BIT(6)
-#define USB_OTG2_PHY_A7_DOMAIN		BIT(5)
-#define USB_OTG1_PHY_A7_DOMAIN		BIT(4)
-#define PCIE_PHY_A7_DOMAIN		BIT(3)
-#define MIPI_PHY_A7_DOMAIN		BIT(2)
+#define USB_HSIC_PHY_A_CORE_DOMAIN		BIT(6)
+#define USB_OTG2_PHY_A_CORE_DOMAIN		BIT(5)
+#define USB_OTG1_PHY_A_CORE_DOMAIN		BIT(4)
+#define PCIE_PHY_A_CORE_DOMAIN		BIT(3)
+#define MIPI_PHY_A_CORE_DOMAIN		BIT(2)
 
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
@@ -167,7 +167,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 		},
 		.bits  = {
 			.pxx = MIPI_PHY_SW_Pxx_REQ,
-			.map = MIPI_PHY_A7_DOMAIN,
+			.map = MIPI_PHY_A_CORE_DOMAIN,
 		},
 		.voltage   = 1000000,
 		.pgc	   = PGC_MIPI,
@@ -179,7 +179,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 		},
 		.bits  = {
 			.pxx = PCIE_PHY_SW_Pxx_REQ,
-			.map = PCIE_PHY_A7_DOMAIN,
+			.map = PCIE_PHY_A_CORE_DOMAIN,
 		},
 		.voltage   = 1000000,
 		.pgc	   = PGC_PCIE,
@@ -191,7 +191,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 		},
 		.bits  = {
 			.pxx = USB_HSIC_PHY_SW_Pxx_REQ,
-			.map = USB_HSIC_PHY_A7_DOMAIN,
+			.map = USB_HSIC_PHY_A_CORE_DOMAIN,
 		},
 		.voltage   = 1200000,
 		.pgc	   = PGC_USB_HSIC,
@@ -261,7 +261,7 @@ builtin_platform_driver(imx7_pgc_domain_driver)
 static int imx_gpcv2_probe(struct platform_device *pdev)
 {
 	static const struct regmap_range yes_ranges[] = {
-		regmap_reg_range(GPC_LPCR_A7_BSC,
+		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
 				 GPC_M4_PU_PDN_FLG),
 		regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
 				 GPC_PGC_SR(PGC_MIPI)),
-- 
2.7.4

