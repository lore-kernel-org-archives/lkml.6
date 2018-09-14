Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D407C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4229820882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f0U7+aZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4229820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeINIQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:16:36 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:50144
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbeINIQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/e+lBZ4Dt54mw56jHQoFwITKRUpQ91uHY0C1EnI3bc=;
 b=f0U7+aZ/RHPqvjZybkwwN1RZe5a0IxO2mPtzxbhbzPU+4nyZ08KsPhrlAlsy1weWIPmAWpd78xJMYPvYPBWEpE683OO4HwQXa8QTJhhW67FfF7MOLPRPS2c8OwFSZAikM80rMhxayjb0f4OB1BPOcsOs7Ge27GKyd9OUBr2ZW4w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3911.eurprd04.prod.outlook.com (2603:10a6:209:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Fri, 14 Sep
 2018 03:04:07 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] cpufreq: imx6q: read OCOTP through nvmem for imx6ul/imx6ull
Date:   Fri, 14 Sep 2018 10:59:22 +0800
Message-Id: <1536893962-11200-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536893962-11200-1-git-send-email-Anson.Huang@nxp.com>
References: <1536893962-11200-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:203:52::28) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f172404-9b3d-437d-a9cc-08d619eebeb4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3911;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;3:HWe7f6FP4EALZVUP5LUG6PEJ4ZNoyEvfodeErX5dKCya00LIswHhQbJaLfSTiib5Z0dICBg09BdD7MHLl2KC+fcn/UKxS2mEBdRAMtFjtJ/Rmf4AG5KRBk/1omohA5Gd9yfp/3JegIVk8ZwjEmKp4LUEf6uYG+GKjrCn6mfSr5gxRVUvDcC9Mg+VWTE1bbJjmQIAosLDcd6mNm+ZDaKsOVf1kKwGU+XpR/UPFddW+AJXt2yszILzzz/rI1jbq8g5;25:fB/fETp2idjMB1te5QLmiIb2vukQjsivoo2aH5l985pS+Ec83YdNNEja9pn+BUhEXqv2yt/nFmXmVSWr4X+WWz7zEs0TvsvXGJJsEh9vCEFp/DqicIgQ3gkg60GoRN/KNB39lJNLdCe9QBlzcRiX96N7NU+konkHPp9sgMlHqxS2Nc0Y2J3RFyE6tKZu3LzmYmZSTJ5pzabCZTd6ykfReWvwI2HQ2X6+ejaBMfBJmFm6fRa7ZYx9GWhHqOXWn4sI3niKZlUyHMqGxs2qx8YVYDRua0Tb74N++paXhoL/1nPY74rPgxnX74ylc+6QLl14HabWcsymaflQWyRKoKhzmw==;31:R+mZTXMCr01jbI0usG6+tIdprSMOJ0HmQskmyu7iftZCItjj0J14nsgbKeChpLjS0BV8By/0kJh+QWapaX1dMO7LIyGLB/cDCav1iMONM/u1cta8ykQm95BNAY9ceGtbrQXu60A36U4DeoT4E7jEm8ogvlofBI7NnKOkSK2oRl7H5j7L9z22Gh5iaERCKGRQPcFLoRv7XAmT/CAKmZYIMj3E1chv3eXToshtwHpshH0=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3911:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;20:UX67Z0naZMuN13+elyl2J8UebzU5OAVg6ku29NOBs6YUaCcvJbFTOsY6DNFrGWLGF+hrY9jCibrku8MySR/gEXH40Vb/kaCCH3CwEMyMPaA08GVGHFtgNbCMu6yyLPAojaH8xYrE7FdB1eVACaLtXUSVkJs3tWyaBTJjudt8gMHX1ZduoV7cCIWHmfSa6Wbi/uD6wt0FoJDGegrNIpVeSkzSVa5Q75QovatBuELYB41Dbzdy4Zu/LgsOKgX9s379U/JzVh2xvg/uoAUXAQU4pZHtihJMMtNis1k/pjmj9Jg5tSK3B81zZUD4cL6Bm+DFfw86o+SYOPy2PFcN9bVmXV65EL1danw9wBEZx6ZwGVSxuxQalzRSB04L38rOiAHumBn/zJVziMRLs/0s73p9ZQz/0Exs7jbqpkEAkGyn11czkycdiHKgRa4PdGDXQDTe8cqhjlwXSom4fkzSqv9gSIbNgOidkb8DIQSiJP8jtsrfSchc75eRaXJlJl1wV/vf;4:r0KiiR/Wc57WoKvPWi7XKFZUwrcyPq9S5ZH9trf8OmRRblF+BrNwra2YA0AEy8YW1rz7TtH8ar2IczKvXBqlZV+1wZWspLbyXs6COLN/6WAMLs1vxoJYGcPUXrIqnspQssO03nQ15n1df2WIn8mSD1+f/jCwM0kaHt4IoyX69S6+pn390hjI0//yB4QRlBE6JbzuzW/VZiHBn4ya5AX7YysyIB73fMAzeh+zcf7FOKdSfe+4pKEvY2uWcla32SeXnwu/EqBv7zo1N77v/FpP6ZuvE+a6izveP+lm0KoTjgwxCg7876h6iMHlQzgyFuon
X-Microsoft-Antispam-PRVS: <AM6PR0402MB391182454CA81F9BDF320EE7F5190@AM6PR0402MB3911.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:AM6PR0402MB3911;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3911;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(956004)(2616005)(81156014)(81166006)(6512007)(36756003)(47776003)(476003)(6506007)(386003)(5660300001)(7736002)(2906002)(305945005)(478600001)(26005)(3846002)(76176011)(446003)(316002)(6486002)(11346002)(66066001)(105586002)(16586007)(8936002)(97736004)(68736007)(4326008)(114624004)(486006)(52116002)(53936002)(106356001)(51416003)(186003)(86362001)(25786009)(16526019)(48376002)(8676002)(6666003)(6116002)(50466002)(50226002)(7416002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3911;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3911;23:Jml1N1p+zQbuXZa522384SmHQJDkfO0yOPUcY3j?=
 =?us-ascii?Q?yE5U2DhnT1E4hN1889cZ57psDbhqfLoy1OH4IG2bWrEugbP1cF/MySaNYEFT?=
 =?us-ascii?Q?kyHeXcADPUMT5tcNri8+pOelrazhg6beH0gwROQtMLGnW7+hlxmwqSSvXKxT?=
 =?us-ascii?Q?dtz47Or1aPCTIGJVBRpWcPbRT31eNx7KUmzXmEyhjly+y0vmzD8Fd+q6f08g?=
 =?us-ascii?Q?syAOE0sfQC0iazCcgA7Go1+F6L6QVsOP9CPJADQFycNxo4zvCt6tWAHR0gVy?=
 =?us-ascii?Q?OlbEbUJMOAqK8KE0LHGXpBQiZc/hcM1yllNanwxp0PjNuJ7fMcPwtMTmqBCk?=
 =?us-ascii?Q?EpDZDVZ61L29byJfasp+uNEL+xtZKVNtILGg5W+IHAgXLfVaZhzOhoOhcd0d?=
 =?us-ascii?Q?B7lVbJJ/CtaYK4fT1xRew3ZCf6ojx52vxdIs2KUYXgd/so/puExaR0tx49cB?=
 =?us-ascii?Q?wUDPyB1wkjPgEafcwDLrDXNgDNG2m8feev30QKYTrXcM/egHApzWiWE2K25v?=
 =?us-ascii?Q?1KZsFNjQU4sJLT1tfDuJ0ftWaL+dbQN6pnQ1kAWOEGIzU9XF+dVlZD3qJNPm?=
 =?us-ascii?Q?TxgHm20w4W8yWkgjvA5njITwqQD5scZKy8uxPKgEZSWrpQNj0W6Rb62JibBZ?=
 =?us-ascii?Q?b+A5W1y30rU4kAR0kmSHev34I4yXV0VeHeLGF4ar8OzADWyzStSk6/3+5yGM?=
 =?us-ascii?Q?/kBJ0jx9ep3nz2dirSnuAdLjNz7o/w7EP6vrIztzdfE+BhFCfz8kAS4m8Y5h?=
 =?us-ascii?Q?pKuMAIeguLZaB99Ai9rRcBSmEJHxEFVDfMNg/PlY+qOC2BNMxkGaSTxi6yrx?=
 =?us-ascii?Q?6KcfFkPals0AXk0g/z2yR2UMpHsHktr9LEED4U0lxcoQ8tLCq4TyXXyfi5xm?=
 =?us-ascii?Q?+tdCscegzimM8a5C9gCUntgXDNG5QLVrwbo8pHAgkT7hw9WXfUfSbKEYaf19?=
 =?us-ascii?Q?hnBbT+V27i2TtD4AsQa4HgaGbh70JXWX0MTy2kySTGAZIsnkR5g0AaOD40hy?=
 =?us-ascii?Q?Fj2mZEAqqij44nYEBbRTVceKvXRfi/gsmbEejooNjuZP0sEUMUhqAv49WlOG?=
 =?us-ascii?Q?eEGesfxDHMSnACq/zCWD3uqhXT5VvfEikAyR5GVNCBso60mhji9X88EoGPIg?=
 =?us-ascii?Q?jafEbtwW0R95pHTXDLeCluJxh3gldwG9ou5KplipqrrWeg0f6TIPPOn4RL3J?=
 =?us-ascii?Q?v43ijz+1j0cNa6w896b6nUvmJ2uT8r1DbOzcTKTliZjVBti6xGenkJ4r1XK1?=
 =?us-ascii?Q?/nyopW3eFoJ30o6PAXC0=3D?=
X-Microsoft-Antispam-Message-Info: 14tpTxkq5JVr5D6fCc+67g+XBrhljxe3JtSGjned0x+HksllS/s7Av8jdGe9u8BAP8Qx0vo3s6+CoJdHOr6sB7kWYnl/0F0G4RoQhzsRevCgA9Xq1JlcK8zJV6+lpfZPIn4PsLLIavRdoeM0Vh+MdJOcs1beY2G0d8TUW9k729uvzKpW6URmF1nWm7tP37rxU5j5inc2vXE+1Obj7UpbXvAIAGTKrp+sQPeTCqeGWvX0lL3suOvv9tgeEDSrDSu12hQqS/XSJH3lRn5ebe0AqBkG+RKUholOS5C51oNCmR4h2Se8Gh7H0/MWZuHnjZGEqYHKMgqbE3O+ZayTipjaGHku0GePKa96TO1L5JQLsPE=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;6:62X9pWkAMsgLLqq3jZc/B6CVy2Gvb1VJKNMrWYM063GEgstqCfXA6YNVbYGD40IusFESbojnxuDiySW2tkfHr3lwdBNPaDWpumHXcSVZSuR8ZOR7Umnxlpnxhew6NFiGTK0uxL2/wGBifa7HSdcJd7bVuHXhnVAdqLpy1hIwRCQzJEKM7QAzCz5YM5meN8JqNX95C7mQcYwZRY5THyr/F61km2+s3F92FnCR4cexNpJnZKiLK19kD62M8GZjT70OPjq9Cck36+UD3gmbqF2D5bjfNok7Mtf13GM0F4kfBaKWYLJvU4dJXX84kKxF1Oj2caW9JJNyvvOW1dT7TJv51GyyXNDN04KnLlqeFSdhyVikJF2oqGFAww3CrlAf7zLXpiXpqeD5unYQdn/N1LNu1NMFBkUAt9ItMQ5avlRDiOICW/L2NIf4ygY/zUJEdR66SoX48nd71xtU8TjIYU6CnQ==;5:weq8sI1U6x+CA0XJADmOhXklLtwtwwCPQ7+P79a2phWEzD2St2CAm/Htb0ivu1tRxlyj2H1zxxiI/YNCd6yNJ/GsigaO8SLjpBKdrOSoV12TJ42wCY8A50hgM7oGgucK4uKXLaEkAiyKrz1t7dZZQa2zXPBqfmb/08kBk4lZnQQ=;7:u9qmrdJPQ5TvQ6O4X3tTafZrsGry2Q3G28Nvuip6KPPW5ErC84ojiioDGOVDx9A9WJ4VWRgndCET2yYWWx1n1owt8tBPRPbMj3uK139lIPv/iYjoRd6HVVcJzejuY/YxVPnx/GJAk/1DyVxV/QDxAeLX44JMXvjiRhp3OlxBMKrmu0GNcG0i4jlnMQ99b9jUnIowyzryTefMpitzO70UhMZLLWsQ0qF6ffFFIjJyCxbxVEgOvcD5jkD0d8Wkg9uY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 03:04:07.2247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f172404-9b3d-437d-a9cc-08d619eebeb4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because
the ocotp clock needs to be enabled first. Add support for reading
OCOTP through the nvmem API instead.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index b2ff423..4ae6c74 100644
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
@@ -290,22 +291,11 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
 #define OCOTP_CFG3_6ULL_SPEED_792MHZ	0x2
 #define OCOTP_CFG3_6ULL_SPEED_900MHZ	0x3
 
-static void imx6ul_opp_check_speed_grading(struct device *dev)
+static int imx6ul_opp_check_speed_grading(struct device *dev)
 {
-	struct device_node *np;
-	void __iomem *base;
+	int ret;
 	u32 val;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
-	if (!np)
-		return;
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		dev_err(dev, "failed to map ocotp\n");
-		goto put_node;
-	}
-
 	/*
 	 * Speed GRADING[1:0] defines the max speed of ARM:
 	 * 2b'00: Reserved;
@@ -314,7 +304,10 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
 	 * 2b'11: 900000000Hz on i.MX6ULL only;
 	 * We need to set the max speed of ARM according to fuse map.
 	 */
-	val = readl_relaxed(base + OCOTP_CFG3);
+	ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
+	if (ret)
+		return ret;
+
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
@@ -334,9 +327,7 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
 				dev_warn(dev, "failed to disable 900MHz OPP\n");
 	}
 
-	iounmap(base);
-put_node:
-	of_node_put(np);
+	return ret;
 }
 
 static int imx6q_cpufreq_probe(struct platform_device *pdev)
@@ -394,10 +385,18 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
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
+			dev_err(cpu_dev, "failed to read from nvmem: %d\n",
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

