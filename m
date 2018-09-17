Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F6CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3CF208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dSC3T/tM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3CF208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbeIQIsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:48:41 -0400
Received: from mail-ve1eur01on0074.outbound.protection.outlook.com ([104.47.1.74]:61156
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729632AbeIQIsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97geI/AuB6OnrCBGjd8BpSO33JEu8pMzQlu6iTEhETI=;
 b=dSC3T/tMTjejV4oii5sTACQIGujqC9oBV60EOQsDpmxGR3LQgxKXnSXBkS7G6l9govIzbFZVmT3bYdSJz7FE9vpWHKyTxk2cViFmLmg1uiorGbbpwAbISvPhN8/WXgCg/+LWvkH+MdhwS8wOe7de0Ti24HDenXb/bAB1kjhfPp0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3906.eurprd04.prod.outlook.com (2603:10a6:208:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 03:23:09 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/2] cpufreq: imx6q: read OCOTP through nvmem for imx6ul/imx6ull
Date:   Mon, 17 Sep 2018 11:17:44 +0800
Message-Id: <1537154264-23252-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
References: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::30) To AM0PR0402MB3906.eurprd04.prod.outlook.com
 (2603:10a6:208:f::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2544852-6e9d-4ecf-7533-08d61c4ce70b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3906;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;3:GpRzxfvojLnYLuWj5BjUMTJV+d2X8B1GcbUsaCVgowmI3X9tges0XG7Lnx+06kKR5IwWr7EypdUHQHj6dOM4Jw7Q7g69cl+UrobuRcC3jnvU/70Fz1aOS4bGjXA0voFCndkazFT+tFZCfYqCYe+pCP7dWyz7LA6VkYzNNyPBfuPpjSJg2dn8LAwyZ7NsprCPwVfZdu2asqhy+Z/IRjICHhjpIVFmAmNxBNVjd3Hvj9vYMiTcCp+HhraIIi/equtu;25:rpchA5cmTNBr0JFXvWyuU+splP3StOahZriMD+mG4zGwCQ73Im7/S5tOHx+KLbqjs2Iyzyl9DaZnc5eOLkHp8kyLhaWnWyK0cAvnBXSoYcnRz3bu9FsMHg9TM/SS9C7RHePNrIPhXvNqsDSofAODuvd8kVx5/Ra025n0IEdYWX/6AUv4Qewhr4V2A5npITu+u/Ggc4xdoiLwoMn2MzGAVNFLpqK8mnjvOkz7czB9RK8clmu7PHgotzUhZqLwfOAgluKwJ8hEe7KhFe0vtKkIGf8UH+c56WYdHPsbHLRA9c2ZN5bMUJIxmAq6fstroEsqa+R2AvUH7bpTujyPm11QgA==;31:euJZQc1sPzpIcAd2ylxo/ajV1cmdIorkAcJ9SuCQPHPMMkTN0l1kDw3IJLtB95vAAFMOPy0QbWtlKv6qE6f5DE6dJerjW1dVniSejCml6dQasiE2TJ+81wlglg1o2xl42RZP/QrQxqAO6njhIX9KUhmwpCNnn0z0P26YcbVQxrrlV/F8MlqCPqeW34eneim3iJgqsGey933X5iTw5wpH1jxqd72+6QYoNY9PygEOdpY=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3906:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;20:UYzjOFeK64Ndxtv3/e67vk1DfswnSdBrvMHclsiRTuK80h2j2g7M+UB/Uyz7DohWdPffCfqgHvoBU91ofkxHqvBZSWaDkoACJgNVglyI6e709aN1rRqK60pOyC24sD+0uLLgAO8NJIXIkK2gfWrUK3+LRZ6xWxTbV/N23vWGgqNEJ0ejZdKNB2G4x4ci8Ta9GXwmJnqzEwUu1pXZnl8XSCLa9Xi6QPcogk1cy9c9dE0FOL1kPKk5+s48xCn/LOGNjsjh2CxaLEnFufC9MmHlCfYycMTvZCTuYsoXWo3/zrLXVkv/GKFlyFjMbKmosDNN9cY+M9ViXC/qD5XxxL/csM8lzNPhrrZzwzY/JiORLVLuEl5n6SBnXkUyF3Ezj0n3TkA2ImNNkP+F2m0KMfPe5IX352wyN3N52CKlSXOxhS50siumH2jU14PtMbtL8yebonGo01+Yce4J2b/wJeU9KgIbOz+5qiBfiwXI96n2+ncn3I5mN2qWTF5pjBFvRgES;4:o6SH0qP7C3oaKgi6EiTL9BpexQBnX3ihRNeHSg7bs9r38AD+kZMfLqQx2z3b9x3w1lpQwXlhpQgHpR8JnYCjTWIvhmww2tPvuoryyJLUHK7gtrAsj4NrDLjgMyfiKJ60CX985OF1yuGU5vGx5XRSciHSXt5apolpmh3fAAgoNNeOMywauXXdbBNAiBRHKUjzwWeEFsnrFSMUgd/0AlkgtCzCLGyc1l8uLEjGpuhlWRPxNcUuDJS8CQhm6wA71cY47FHqT4N3QBcswqAlCI6ptYjxpJ8NgbcE482SumOAuTCUQK77YGZQGJZbTLYw9+o1
X-Microsoft-Antispam-PRVS: <AM0PR0402MB39060B0D306B3B59F04D5D2BF51E0@AM0PR0402MB3906.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:AM0PR0402MB3906;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3906;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39860400002)(376002)(199004)(189003)(956004)(11346002)(186003)(3846002)(5660300001)(6506007)(486006)(16586007)(386003)(2616005)(316002)(36756003)(6116002)(52116002)(476003)(76176011)(114624004)(16526019)(48376002)(51416003)(446003)(6512007)(47776003)(2906002)(106356001)(7416002)(50226002)(25786009)(68736007)(50466002)(105586002)(81166006)(81156014)(6666003)(7736002)(305945005)(8676002)(4326008)(8936002)(86362001)(97736004)(66066001)(26005)(53936002)(478600001)(6486002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3906;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3906;23:i5TPL258B6Bx/ZzWajHadOHOkjsI+GINL+txylQ?=
 =?us-ascii?Q?cs3R8kW3G9rTc56PNmHQIJHeLt0ar8jntces9YSyBcHPrrxWLyCD5/rnHf40?=
 =?us-ascii?Q?odDKm58xSVzVuPbxJuS7hTwN7IzUJkN5/qlxteveE84WOAXJGjagmq9tYKDK?=
 =?us-ascii?Q?N/s9a0V5MCdPP1Fhoe9C5UnCqZJ61RM5RiQc4lufKwMmR46YvnCkculWvYPf?=
 =?us-ascii?Q?jm8rnuKDGGZZJe0D3uG28ljiLLeKKFM/EBym7zbWgaqXrKFww9pOaXntfYls?=
 =?us-ascii?Q?MMqTIOUab7r1rx26o3tCm0qIowT5MLg2+Jm4XfK3h0WKCPARcXsy0GD6Jbhu?=
 =?us-ascii?Q?zKWj58gvAKs0Ur91xZ1ax+ooNeNvqWV+gT0+WdrAcY0WBSPsOg2TO7nehdo4?=
 =?us-ascii?Q?fk5ezy8YuSiK4QMmYm3JxlLBnegcTTxat/a3YR33C4sqEzAZ3suu3hf8OcY6?=
 =?us-ascii?Q?c/8XYdGwjuMvB06h8lNiA/IAqQadfQm3HLVZxxU41HWq0t6yF7lxjM/j9KrH?=
 =?us-ascii?Q?S8AsqlwZRJvgNgSGJEHLprl0/OanJeuUgznlzdb6Yd19kaWeOiMMuMpaCYlp?=
 =?us-ascii?Q?N6KLkhKHapyPD7t0AW9oF5D6K/1SdjA4FQ5IZgVePxexk4KyBpu420p12c+G?=
 =?us-ascii?Q?9bT7JR9eEMXrY5yTFIPo6L0RMhnCMyff3GgjWdswFkHtjW0OegzIvk/Y6w7i?=
 =?us-ascii?Q?AZk0xVxic9oaJ6qqlDJhicFuKDncyriKBWVABiYQfT8kIhS9hxJCKXgfnIrP?=
 =?us-ascii?Q?9BUdAdDWpsYUdZkuN78WsV0nJyeZ8FztBQa8/po6auSuNwsy4OC/6Z2Hm/q/?=
 =?us-ascii?Q?Chpfe2tvK9+vS1qc2NezyhpM5CgGlzQUkoDU01lX7aVKgKwjIeMktlOs6suJ?=
 =?us-ascii?Q?PAKAOQHkWgKLlXnzZ0/9Q8SYiJQzoyaWfxvdhiacmz3d6uFX6UFKsJhe5hAD?=
 =?us-ascii?Q?ot1u9uGwOi7QH8brA+N1AmD1xC2KZ60OpKAg7KXx98089R8jzwOCsAi4tHQA?=
 =?us-ascii?Q?OKE/529OQcMlyaE1LiNpAyaxw0KvVIr7mt5V4pbi2OISJAsb6J/pPEr9QAa1?=
 =?us-ascii?Q?WcFQe5hFJfLB91g3A736nWTQ780Ihxqqn03g5/UlbKNHMNwKHlC7pK13WvXO?=
 =?us-ascii?Q?sFGKQ7oqotskQfpS/K4FcSdHQBYpU/tZ65IKAOkGLdkY6w3DywFxc8vJWJPW?=
 =?us-ascii?Q?GLIxgatWT3R+WXuEPWk9c1gDMJzuu6k1cH6QzVjp4lCp9vXK8cnYHyyMExr0?=
 =?us-ascii?Q?YCHaakZ0dQr/DACQItLQ=3D?=
X-Microsoft-Antispam-Message-Info: tbOxgXQD68bAjLzv6ieNBdM5YSFNhwdbqRxQfFy9SflSaI1+nOHH+Xh66oRBx1F6hm2M/wO0bKMkGX+ANike9fGM0GPzKnwK1AtePA9Hh10m3Z9aFAvKBEr9DHPEXA2ONarHKzP/9J4Wk4fK8+lcnYoT9tIAseL6U+jFqX3qY1cFSBZxm2RGz6rvm2b55w0xVNUFVqasWoHi+wVUtO9cHVThqtyIHzop1ApbFy5MYx7Gkzs6T8ug7nPwylMg1U2dvlZZMD9/1A7YSyIT6BkEhBq8YN4lwPY5Av+MYQdHLsQ4gbRhOR7W2b9HzOurwMpwha/fxmxWcLbHwd/O8BHtWwdHIDEiUWKIYFhAV0BlXpQ=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;6:N+e6373kvU6dBSmdmEnGzsMO8vsqseDCaGnIPGhNtfn2U155mK82TjO9EKAa/rk6qXU5pChIKmMO0UwB13XhSIHvq9lQkR3/MLUvj/xKqgXJw/pyxVnKC1kuVQDBhP3A10Ttjn4xWK1SOR1b8/OIhiKuzsuhdb+dJzP1zOaG3YTLzPjP0Qkok4nw+TTrpq2UymarDqvohG3VxfSr5OuMTt60mRryd/ki14pxbRVtU0a7xc3JR3dT0SVMdGP8tCwVB43fRCfg6bUoTcaBiUlwaIqoUFSBnemAMMmlKBS9fxC+QxITxdzO5cUObK5k8tJGQSh3Qlchr/XRt271Fc/zO1D9uq1ioOSACc5VCbXufXjRbw9FpxHwf9ztIqzEroth/Igzm0+Wsv4o9ObTTnnABHHaAVCW6yMsP9d4eTi7gV/UrLdgHlzRkNpMmkuJm1nw7Xly1LlyNkp9Y6ud+JwMmA==;5:rjI67Gb5W1ANpNguy5wdehCdJs12ls21rrrrOmu9tj3LnNtHFnuD9RiRmZwIG3X6irJGab9f32TS0J7VrYop0HRtSCAiVLVC/AimheQtlxqgdJuqnSH9BJ5K7sPAf5j0nMTzidSpV8TwTyx4LUn3HBDLLU2b+QXnfW5NpBM9nXE=;7:B8hTu355gBW9JcJkxt5oemN01jA7kyOHOK6LoFv48zgyRX1DcaUeqxXV8FMqV/P5vtQ4bDZE856sOyr/Gv83ViCClnua0fQOB2Egz3x4euoLmeAsLFfwq0IIYJuVwYHmrkeRI0mD7sPIe6s3a7DE5c/Nl5Nymjs3RcGBoGmf37oja8XyOy0anzaTNbQWRDWcD7rC9OKOP3qzfYbMyWiPbOUg6Q71E+fKuCf7KG/v296ypnbMBsgO6SM/1P8VatKz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 03:23:09.9664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2544852-6e9d-4ecf-7533-08d61c4ce70b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3906
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
changes since V1:
	add old dtb support.
 drivers/cpufreq/imx6q-cpufreq.c | 52 +++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index b2ff423..518386c4 100644
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
+		if (!base) {
+			dev_err(dev, "failed to map ocotp\n");
+			of_node_put(np);
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

