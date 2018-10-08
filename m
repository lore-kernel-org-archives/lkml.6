Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DA5C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1ACD2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UGgEAxbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1ACD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJHIYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 04:24:19 -0400
Received: from mail-he1eur01on0060.outbound.protection.outlook.com ([104.47.0.60]:16032
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725760AbeJHIYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 04:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZoQSZo4fOpGY7zvd0OY5dW2BIQ8TuYy9tlIBz0qfCM=;
 b=UGgEAxbjxOfI/WY5dUHNQAHzm4oH0Wg+ttPpOYJ8ZVFxFXigzz0pP8JzdLBlcP3cbiQ2Xx44OEhkTnSiPXBhvNusFDa/PbkbaYokJuocjX8HsKvSaLa7+KxljhHjYLg/dZdRnnE7mUBUlIRKzaJ2Y8WPSjM99JozsCUiAcpczhI=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Mon, 8 Oct 2018 01:15:02 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3] cpufreq: imx6q: read OCOTP through nvmem for imx6ul/imx6ull
Date:   Mon,  8 Oct 2018 09:10:00 +0800
Message-Id: <1538961000-2109-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0046.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95fc8b59-6c68-433e-75da-08d62cbb7a69
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;3:r0kU0Y3uCLydktk7zc27uCuqP6Tc0+frAH5IhrRPZDN18fsH1WrBYVX2Umu6nvlQ1C+LvDCA+BPi8i0AiNxP+c2fkQIj4WM19DcnPbSZ/m+aHsyKwDoNNkt2aWv28sykJuMfT831exKSfj9eiw00ERnmnM7ubMyKYwH7GcKi1N3ABVy6gjdfR1tXmhMnwqpKQGjay1gyxnRFV4exOnKSRX6g+XfQTPP4tOsiJfSFGK+bpAunsqmQk5iEMnnEHW1y;25:+hB3xxShCEI38OqWh9XE3QnuLfHwnL591s1xmv3IPCioJZ++YOtPKaBoiMz/pXbqRVpVLiZLKTj6qPrXqWi2g2Dh9Xy2En6iR8nceqlmZWbQCuVKpVQyPrtEzcFNLzYBDEIvOiJ3RzIo6XNCn3nWWg2S3zsR57emEapHGncjam9nyqcbzblnAAyqEHcK88OZdJLsj9vsfjmi3vXRk831ABdfjCLZtuuimI/IGFvNdWYc5eArBWgfwDZD2KKm2fiQvUFETFCG3biStSGPYieUserPPVX5Z/mMFwwI5XJ75BMCRCMPwbh60FmirYe1S4zjQ4s73zUeCazpDu9L6IRqMQ==;31:ABQ6XLb3zr6yI/93+6tBWekYalavKFniXIdLLvmTRAkRfbXxyO7vwaJLIASuO2PNBP/g6gA9upfYoI9gHA1ESLglngShD0WzFD/QWGABVb8TsAh/0wAHCAnghRTQPRmkZYHODSpeDqtZRVsXMiw3bXRlsM6LpBxHiJ80zPisY7q6SDXyLyUTWrxsga/q9qna4xJcocUgLMwh9VW/hPDy34huFUw4SbQoXRUccP3M1sw=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;20:LCsRZObl9p83GMArZiFiWj64yxSxm4bgef+mEmX0wRo4FbCzJuHhkfHbF98aztRb7X8FRleullODt9i4Zbp7YQsE3dxhTp5W4zXQD7EToftgaYZPuM+4Kqlcz01a6s6rMrB4sLSvpalC04kUxkGPrAmU731QpY6hLgvgum1AyXQPnM7WVvewE8UnqLo22qQnRxpFDTJ5I0dBbBno7jwwtCgDRVEVY4qyrTbogVqP1XC1J5QxYoSE6Wy/siCa01gAvMtqslbw1Bmoi7ZnAoIEiX+tlVPkmaem1w8Jr3dsZpTPPicEbrwEFd0YjSvdi1g+bagIxJVcRfxIVYcfW4LyKxgpzUqpD9MjtQTPUKf4pf8WPmGplnZQyD20rtJuZquZS5Z8EwmHjAOQLuxDubu1vL4Q6d2YynnIINMvEWD0B6AMJpqC/2pcDZIboDPQe0kDFoyO0iZgMkyivgj5s8D+j5adeTNtLxR4kmqHvyrIo/spWdmwrGdWYqEKUI0/ylhj;4:dE82vu+lnzTSn4cLJD+2HAlb5Czm11TjRY+QhsVjjS0fWIz14KipXcoZ7GD5Yq6EkPGAil9YLiJlMyuMFQl86eWhUWnKHTLOjxWbDF0m6m0UrPKj06qRuUueD7q7fsm4z2+HB5j0Ioa2+W67V9z9NrW90U1NrMvBb/Xp7ZxGTlp7N3xC9msX18gnEAaKzUFdIM214wDxXi+9N0caWmPHfV4wDwSjzZpAmTdWalW0MGIMqtkNiAB2zEyckFaBh1Lw7/Cmy/cG+FxwO15nr0EQQmJA/LAoQ7oRldDywWTjCFFLSTsPey0UfHWSI5aKkq3a
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3916AB71108EC4580E036AC2F5E60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:DB3PR0402MB3916;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3916;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39850400004)(366004)(189003)(199004)(52116002)(48376002)(50466002)(51416003)(5660300001)(6506007)(386003)(305945005)(16586007)(53936002)(105586002)(7736002)(6512007)(106356001)(6486002)(316002)(86362001)(6116002)(3846002)(97736004)(2906002)(68736007)(478600001)(8936002)(81166006)(81156014)(8676002)(36756003)(486006)(186003)(16526019)(114624004)(25786009)(50226002)(47776003)(2616005)(956004)(26005)(4326008)(66066001)(476003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3916;23:JTo/K75RZzpxeGkYuBKIt1aPaQNW2vaIgPo9gfD?=
 =?us-ascii?Q?iIORdjwAE5whuLVi9RcShNBXTMM1cgUPr68xCb53tTc8zoOiI7KpjM1GJ9Za?=
 =?us-ascii?Q?ga/ikKY0hObLEk3MmQ+hdXotutV+b9z+fHLGi8kqyBxPRa8uYYCdAUSZLvwW?=
 =?us-ascii?Q?i+NX2xNFi42R9epBs2/H6IdDiU14Fiy5HhTCDHGZtjKG0AXj1WtR0A9Ut5+6?=
 =?us-ascii?Q?rZHAcaysL3NRsMgkz9lJW5RTYWbmgODZrmtJNfhhz3lg/Pr6aPOU0/Tugsdm?=
 =?us-ascii?Q?OsE7kg9ZiTC5T5O3w5fyvgGNvopqm7rYov4OmVSIbHmheSucAI8mlnZ46Ow5?=
 =?us-ascii?Q?F0BN4cDg5A3rmKC2wvFo2zJpdG5Wqbp6dcFbsKvZ3D8rhoOrqgqz0TQrLSK1?=
 =?us-ascii?Q?FKhjpTmI0ovruzFxKH8O6jnhG4u6GoQdMBDU94/sauQkaClN9mDOdmb+I9Vy?=
 =?us-ascii?Q?16My5aJ72T4mL5L1MAJa6RJT5dW5f3Z7SlVRO8GzYfQaL0pGT3gQ9cW+s7tn?=
 =?us-ascii?Q?ebbLdeHzbnQz0aAoDPz6Tw1lUQTaCQiU3ibhmfg9R/MlC4/OnKTQTVDLO2Gl?=
 =?us-ascii?Q?EnglmKyKVDHUxeV2oQfj4N4NgEGdP1BzHJEy7naoH9OS7gTveIkcGttjXr+I?=
 =?us-ascii?Q?gFt/AHQnqGWoVhO67kHtbfraAd8F/nKICPZb3O1YvLrF5s9k6pkVRx5XUAVC?=
 =?us-ascii?Q?3xyRzHDDdZZxkb1J44vGlHfZFBAdPi5UIna/nyjWNB9tCwAIXS44d1rb+l7G?=
 =?us-ascii?Q?zm32OnALIyqj5gYpsftXp/QcTKoYZxhf7X/NmYAM3eHSHkLC8ZAgjglr9yQH?=
 =?us-ascii?Q?iYbKD28qRzx6bM3Ssi973Idv2T55zsKhQGchu2QHWjouUuwO7LGi7/tvHFmA?=
 =?us-ascii?Q?bWwc0O/VCwUiOL474psk/scFp2ZnniwJxali9hdWOe3cmDd/yRI/8i4gKTfF?=
 =?us-ascii?Q?m4LekkRvNJLRSh/pwkrp9bzNFRUk/x8uLIHNrwB5fa6jjN6TBzEUB/12IhrZ?=
 =?us-ascii?Q?fCusVP6DEgjweWCALwhLB7okaN1ktsrFyiZmo/xOryDxyA2bYWi/qeznZwvw?=
 =?us-ascii?Q?9t007Ef5+wn+HL1OPpRT6GA2XgvjmAat/aZiRWe0Ri67WaxhLKnX9LvudoQv?=
 =?us-ascii?Q?lzLKfoykHHGo=3D?=
X-Microsoft-Antispam-Message-Info: rJH8u1iXuslBVLvczK3K42jQHxSEFJKkzXKjd6v9gCEve35jNCzR2QLtmLKMCsSfAphvv/+ULXlj9kooMfIJa5h/mec5tWv1glZt5NsP5m30kME8JoWlHhcLd6vG8sXBJRFKQ9NfGU+sDJmsVu1e/5y+HHrEcrIw2LHvH0MQl57GInqR8ALoVcc6XfZL3Od1ww5mmUcnvaJwRvmXPtl8svQJO0fw7xyrD2D6U0vVye0RDu3cpTQ715d78EiJA2eHkpaU5oEpj9bpPt6IaQMUbIHWh6i0iMqQ+G8WIonM2Bri+1XQP6MyGyyogcyQ33qBISmSITOzscBRZlzOludyYGjVVQl2tdU0/PwdORvSsQI=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;6:hV4/gdSVl6BcMxGlVUdb1Q99A/Rvr3C4diSR67y7WFP1HfRJ69SyFwqLxdKul5J/7q9qOWkacpEnmU7w5eI3JeLgZWDzjmea2tAaLBPdLbjqUodRsht46Yyfo2GIQV5ndx+/4nRW4Mb9Z9ZpSt4VKviXXHO36RGqmGKykp1QInbv+AlkOrYBy3YaP1qOSGjUsqmDF1ogLOyKE1porUPYA7KLXWKCFFwSviPPSAVzDYArLeHhaZ1Hmqlo7X1gXhGeLkz2V3fkKqYkkKkOvYnZ8dvYySoaT/Ld/KNCxBNGgwzVO9QrkJsN9GmHZDHFJsC3NLb9PR6KRyAAxSq7U7b6AdHUONuV9utaGcqEaxMNgK8Oc5a3gNXI3lLRvE69Qeq8E/LRs0gUlW4e/NNjZdh3in/TKvrnK7BFISv5XyRS+UDYJI2KGXIang+QzCCXuFo1+oupdRGfG+ffwivQIXTPyQ==;5:CPByiEUJmJQRsq+ijOUyNDRPiGrjRfOmNJr6pXemR/bkKo0lPxrKmiAmivnANGyI0V8ALiWRut1l7e6ByumZe8v9wDwDaRVLSEg27TOseALUjkb9enceVDt7tQ0m3AO5Z1PPPps80lHl1EbjmR9N/bgueBFuw0PZ+RJL5YHZLfc=;7:ViSYTvFT6vAGNR/M9BkHWmixTOpB7T3Hk+Cgh1hKkguxoFhB7UGeTSf6fbdC1QwRSA7JjLG6ePk0x35FzjBPhmtRRors7yJpHXAN8Jjno+Oa4wFX12SL3iPf97zbv/n4MwkeyoQlvTMc6D6sayDcDonfEVVni1sXg7G8YCy6qiZOzWDlGel78W3mReh2Ss0TtDnBPAwlFRkd7Fq6sBd9TSrs9AIjJN7JcBOaZ4N7oFckyH+Uen3DnKEHvGt1Ttd1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 01:15:02.4678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fc8b59-6c68-433e-75da-08d62cbb7a69
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
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
changes since V2:
	Add put node when reading ocotp register done.
 drivers/cpufreq/imx6q-cpufreq.c | 53 ++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index b2ff423..38b67f8 100644
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
@@ -290,20 +291,33 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
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
+		of_node_put(np);
 	}
 
 	/*
@@ -314,7 +328,6 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
 	 * 2b'11: 900000000Hz on i.MX6ULL only;
 	 * We need to set the max speed of ARM according to fuse map.
 	 */
-	val = readl_relaxed(base + OCOTP_CFG3);
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
@@ -334,9 +347,7 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
 				dev_warn(dev, "failed to disable 900MHz OPP\n");
 	}
 
-	iounmap(base);
-put_node:
-	of_node_put(np);
+	return ret;
 }
 
 static int imx6q_cpufreq_probe(struct platform_device *pdev)
@@ -394,10 +405,18 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
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

