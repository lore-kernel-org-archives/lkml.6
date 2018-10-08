Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F46C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884AC20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DlYLUTjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884AC20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJHNZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:25:29 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:52997
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbeJHNZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piGHjMbCQmYRJWaUgbhBTWGZXNwZXD/3GnfaxQA46gE=;
 b=DlYLUTjAEGu5CvbuhiNd498gmwWT95G5y8DRtR8bVdIbZllH5haLbb+tMJTrKNtNiHB7yJLMEkOzn0C8LdQzMcv4FVnEiC5IH6FgsdSg72SCNGTtvFJNslSncF440XuaCBpiBE8pRN9NeTioM4hJwKqVeBwXEaq+LCBAlg54eCk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3911.eurprd04.prod.outlook.com (2603:10a6:209:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.21; Mon, 8 Oct
 2018 06:12:28 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4] cpufreq: imx6q: read OCOTP through nvmem for imx6ul/imx6ull
Date:   Mon,  8 Oct 2018 14:07:34 +0800
Message-Id: <1538978854-9678-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0070.apcprd03.prod.outlook.com
 (2603:1096:203:52::34) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a33c5a74-522b-49c3-b568-08d62ce50793
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3911;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;3:g/a+wbwkHKsp7lemGxqsD42xPlsQfKu/1/EadaxXT70juCgRlbxywuVuDpeZKWjaUzybMxui+up2SCIJMAJjU9geDkYzZob49OoVEQxLm2qhANdjXnUaZoUXmyhqUH2/8M1kgh2S4KtBJFgkf8SK/qu8VTKfqk0jYjRa6QRc9MTNMWjBWA76yPk2GsCk/hKwss6Gct+fIuFii4BXltuAaggW52y6Tnmomx+aieYAfSDy+PKjwsW+eqOGikSA6eOb;25:jG5v7ofO5Upveh079LrborTcrN1TYVpQ0TEgZ5jYvS9DQMpRG3ZqlDxmV1nxxasb0tlIB0vBx3R+KJ0yyeKJ486B8RgokfWc0W5GTTgvMv9BdJHcA1d7QmhpFpJpRaEGSgEoC5OQQmHW/N2xkr1suKqNRIWYWBXmWyELAqgyvP2Ed4W2xbD9ixWBXths2969akVxyNnLiC7EKKzNPhuqu20igxHY3LcSL09O85x2p/Q2V0NlHDxk/uoaeqDGrThYEZkPNuMeNCnahV+3hqks8jTn3Q4k9DVNQ0Iq7oHwjCW9ONGkykuFPV27tng2DYlraxhUTTIusd3gZ6oIwH0S7A==;31:kwiZuzKlo2VZYA8MV/znd64RY7WuzE/2Kq9c6f2AJ5ohy+ve9DN7rxQTh4xmhdDPJVKio2AOy8MMCf1Kr/TUqQoLWYt6yA+5MU5D5fvNhs2AaE+TNuvwpKAZY2Pq2WjKldceUo1k8rppmesVTP1MYxuxVYu2HpmvYZyXB66q30rUP/eTKoDiw3u++t8MzsIEv0H1qHnQtA/kjMfZEa0gwfctch5cnele7kyfVZThpLg=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3911:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;20:Vhs0yzT6WOMIXtf9F6SCC7zHWWLyKQnp+tsRCZ+tENWHDsV2VthwApiji2WhdQ79GqM14MT6egseSEWw3ELyaEBSHbWrwoEnD9ijYTcEruryCpzRZaVdV/97ebwNA9SsUqvndi3QmL78BhFX+EYLA3CCtV0HStseVo7+gEQhsR8dx3TPRUq1T/pcDzPsPzJf/7vypzu1gbEdkrkTp9Y50FyAxcdKQehQYkQw/XMGfkMyZfsJRYhWA63pxFxTG0AgNQrB7fj7DMYc+UTkk/8QqPnz4PgDjHX5jizsLFD69/rOFdNJMj5i8/M7/C5dClNqGhZv40Lw7a0Llsp9ANnGZJ4Q/UxQuPBbbzznuHTzhByLBcozgnx7gg7pg046hr8I3SGfbEtr6ee3TVS1PkxEJyLHZchuJ475wC8gC4vw+ZqqKAqAYYyXfL3PlMDeXdSHKXRKPyBt7WtiKb1ZlMswAYk0nhlBiF5xUp7nAmLwK+E5aAr9VmqTlMu+qaGS3+F2;4:sXrAQK/gZehNTp4FIq1uVCjINTmynVpZMxHbvqY5uqEzah4aG/F6PEXapkDKfaaQ1QsP/DNuVrOGdj5FgGr+1CKInuSScOKb6t0tT6V3rJ39HxQm+xJEhimFj1/afJe3DCYd+gP7lPKeZ7IKmIwtdCqF/yhlkymXWjHnZOQq/j3Z5fPNKooN/m28eKNccyA1CTMfbKXxCZmNxrTWHHYmZeGRmq6za9FRitJtsroamAl1Wn+WlgtG5EgjI7DxQIEvygbXRzEzXOVN/4D2LX5OZRcbY/K8LSYsNgjDT2IOYQ3phQR0ee0GVeFmxvIcC5od
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3911534DE56F39819C6BF179F5E60@AM6PR0402MB3911.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991055);SRVR:AM6PR0402MB3911;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3911;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(6512007)(8936002)(50226002)(3846002)(6116002)(2906002)(6506007)(386003)(51416003)(52116002)(575784001)(478600001)(316002)(8676002)(5660300001)(68736007)(81166006)(81156014)(97736004)(86362001)(26005)(956004)(476003)(36756003)(48376002)(50466002)(114624004)(2616005)(105586002)(106356001)(186003)(16526019)(66066001)(6666003)(4326008)(6486002)(16586007)(47776003)(7736002)(25786009)(305945005)(486006)(53936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3911;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3911;23:oQqX6XYP+I3FKvLtePEABJgiICaJ89Kco/+HWdA?=
 =?us-ascii?Q?Q4+Omv+LHxjvdfIxGVATJuKLEh29rDbqqqsPb5eFJAtu/NDjovZnYQmCdnnJ?=
 =?us-ascii?Q?ftLYKIUeq2kltvde2BWY/mips8K1HFR3nkx5wImisKNgipva59lhePYBO29R?=
 =?us-ascii?Q?LVRVB75HBCRwUszkooA/QP6Dkn+whAZ0FqmpwFEaDSKpVnZaOYUHOIIsXbaR?=
 =?us-ascii?Q?zAXWWQsidW8u28PuxGDUgfdoH4I2u6tUFV+4hNb3sqp50UT3gpYkEuw4RE4l?=
 =?us-ascii?Q?4L3mbGLZUaLeSIOrw4pQGJKP/c2DsQdRB4k7d7KW73t2G5YpvtAbZzLCK191?=
 =?us-ascii?Q?AolOH/VVJN3YsP1bJYbfutcXTmUt2SkTgO2jNP2AL+9XAdN22luyeph+mI+5?=
 =?us-ascii?Q?VtNh6xGS5KghchAaqcrxQxiVcfKdpF4mdcdu2H+dh+lHz3QhGFDD7iX8NJRG?=
 =?us-ascii?Q?Cz4qusLkXw7i4+Pe6efjlxJ5lP2oFo5F6sTZj7wZPF1BNaow6b3CXvxBoCF+?=
 =?us-ascii?Q?xAtuxGJlim/aEEmomow+6LG9n0zBvKYSsQ3LRQRrRJ6/Ctsq07MZhRLiW5r3?=
 =?us-ascii?Q?8EyhCRcul6dpULSFlboOw0U5/TdZD9K5yUAa649+xxPlAwkWLnIN8SGhAZcz?=
 =?us-ascii?Q?k7WFPwtg0yRB7aKVRvxoj2be9LDLLCYPYO2zBr95VW6zlRtGwOsEImFan1Nf?=
 =?us-ascii?Q?ibud/Nz4/CPUKQqWF7S/gx+Gdgv4FqbT1ZaR8nbJGpVLtFUJtwHH65JO9otr?=
 =?us-ascii?Q?vCjT3EVg3kqDZgD++y0reUw/XpcgtdKu5jyKMbXMowkWeVTjlgodB5oGz12j?=
 =?us-ascii?Q?tisTDXoeKBaOT/fdS05nuqZVSI/CTMC6vv06/z2uATQFKbptKFxCaSMb5288?=
 =?us-ascii?Q?tN8TUCCDeGLc4+B9WzPgirWTp/xIyzegsjsyGsdPZ+JsDBO9/BmbTi6IHLqi?=
 =?us-ascii?Q?UXNPsElLYyBdJLkZCDuOVcjFydxwNcrTGLyuSxrA8LquwIazzGMsJ1XF0VT/?=
 =?us-ascii?Q?K59QsRuH/vluDWoliBVevRhXbSqAE5DqrhBunjrKaxH/u0yuN9QIQ+2ZN7C0?=
 =?us-ascii?Q?3XeIoA0nVhC3w3gtSwRXYxz3EjjkJPbrGpKT8OSMYTHJh8RWRPdVKsUpPVCI?=
 =?us-ascii?Q?7dfPDHMxgVU5xXqz+zlvJ59Jqz3AcvKabqOBJenlqlyeMiU2IxfR50Q=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: kzxh6PmL05GYuXOZuBl12qOUYLQarE82vV4AOqRrAZqJJc8W3qEK2dU+ET/zAMwtioWBVH/Ur5ZcaHW5g7NaobD9/tw4m+De9RfBgSNEr4MH8eEgi84EfawJ47qWTaD/Y8jW2Mqgd4GoPb4IjmSRaUj1OM5ft5L7Jmdf48kqNq9x7sbkqDXFf8lbLDAo91dM1rFnwSMZnU7Uw2/dis+EplAUpYvERlkHgCyFsLD2kN8NVIWkP6xOIx31ZtB7BN7XgN7fXO3sY99TvTN6FConJ1PtFx/JFTDDw54yTEEe66D+xPNQBhef5FdKuQ1GwhEh5hNNVjs+2+tdy/BX7pSdDqVBIblokm1uJ0F0D4PdYBQ=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;6:lemfZ8QO736wxSHspgNVXsPQGLvudoAOPZ/6US4RlmyoVOOpPFjRqVHvXBWy3LTOwgauTTSGmRapToxP5OZNYXsbIwETVB6DQO5josXFNtopIhzZtEq9kBFMUknzvpAHTVjYX/n88xqpH76VbBR351OcSTLdEwBNAK47r4GUwcTEA9PlZUy6lWLdL7IxaHRn/bvpY3nZNMWJ9Ay0f4iE8Z21m3opQKmc5UgQWb9dNSWpnsNId68vjxh6JG90YGG8r80oSI8lxp7YPk594UnQhYvFm4qzE4gSiXmUz+oKaZUl4yrTYqbsvSd3KbornQvOlmVaDx9Jw+/xv1ee91aing+BRQCZNdJqcdUBt+aH0I7rP2LMCjrKYdl4tvauqQNAfKjc5Ek6ygI3nQCSz4oDthpwMq0QITTdYaxTMst5gfXiOQUb7C0+T32b2sWx310yqVqPiJyMQyi8uH7Hzys5/Q==;5:rzSEhv/U1ingD+4REHt0KCfYDqIAwTcwLHZ0vRYqw8XXJPWB2OEBAufjk5PVNHb/iwzkMcknlP9gBzUo4OfeL8e83r78FLatRjE3anFDbdxOg/hqqhkKhbl/S7mesCtIYY/js8IErME6zVWErIOpvdV4Hzz6crgzT/WSyJyiOuc=;7:zNC/XTIObSPOy9OhcKtv3fm6ANRHTkjNfChwShGkTysbAVSN7V453BfOHGzIdMntRMH1DK7/emVq3zTcZAzgQ9v9lUOvUc6oz4upAnJRZglHehkbYoLvTFpWc6sD//myV4VUfqqmXCVk1aMCnYZcKHrXNc/MKIe2KOnuLwpysDkJ/5Q0+7zDHV2DyvZxHf8aLrxvB+mnN0rodKn3V5mZPwHYc8NyzcSytb0OUMK9x1IN77Np79OcepDrFzmLKFwf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 06:12:28.5731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a33c5a74-522b-49c3-b568-08d62ce50793
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because
the ocotp clock needs to be enabled first. Add support for reading
OCOTP through the nvmem API, and keep the old method there to
support old dtb.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V3:
	put node earlier to save one line code.
 drivers/cpufreq/imx6q-cpufreq.c | 52 +++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index b2ff423..8cfee0a 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -12,6 +12,7 @@
 #include <linux/cpu_cooling.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pm_opp.h>
@@ -290,20 +291,32 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
 #define OCOTP_CFG3_6ULL_SPEED_792MHZ	0x2
 #define OCOTP_CFG3_6ULL_SPEED_900MHZ	0x3
 
-static void imx6ul_opp_check_speed_grading(struct device *dev)
+static int imx6ul_opp_check_speed_grading(struct device *dev)
 {
-	struct device_node *np;
-	void __iomem *base;
 	u32 val;
+	int ret = 0;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
-	if (!np)
-		return;
+	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
+		ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
+		if (ret)
+			return ret;
+	} else {
+		struct device_node *np;
+		void __iomem *base;
+
+		np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
+		if (!np)
+			return -ENOENT;
+
+		base = of_iomap(np, 0);
+		of_node_put(np);
+		if (!base) {
+			dev_err(dev, "failed to map ocotp\n");
+			return -EFAULT;
+		}
 
-	base = of_iomap(np, 0);
-	if (!base) {
-		dev_err(dev, "failed to map ocotp\n");
-		goto put_node;
+		val = readl_relaxed(base + OCOTP_CFG3);
+		iounmap(base);
 	}
 
 	/*
@@ -314,7 +327,6 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
 	 * 2b'11: 900000000Hz on i.MX6ULL only;
 	 * We need to set the max speed of ARM according to fuse map.
 	 */
-	val = readl_relaxed(base + OCOTP_CFG3);
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
@@ -334,9 +346,7 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
 				dev_warn(dev, "failed to disable 900MHz OPP\n");
 	}
 
-	iounmap(base);
-put_node:
-	of_node_put(np);
+	return ret;
 }
 
 static int imx6q_cpufreq_probe(struct platform_device *pdev)
@@ -394,10 +404,18 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	if (of_machine_is_compatible("fsl,imx6ul") ||
-	    of_machine_is_compatible("fsl,imx6ull"))
-		imx6ul_opp_check_speed_grading(cpu_dev);
-	else
+	    of_machine_is_compatible("fsl,imx6ull")) {
+		ret = imx6ul_opp_check_speed_grading(cpu_dev);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		if (ret) {
+			dev_err(cpu_dev, "failed to read ocotp: %d\n",
+				ret);
+			return ret;
+		}
+	} else {
 		imx6q_opp_check_speed_grading(cpu_dev);
+	}
 
 	/* Because we have added the OPPs here, we must free them */
 	free_opp = true;
-- 
2.7.4

