Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BB4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E9220874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YYGLwrLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E9220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965731AbeFSI7W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:59:22 -0400
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:3242
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937412AbeFSI6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUQ7j/w7lXhImpCgyGI+ylm9bMN+etJKK1LSVM8WSVY=;
 b=YYGLwrLjjXLBSJn2N4lK+o+l7goAM2LSbXGScXkcv48p5zi3Pv/SX1pTChGPRbzZH68ZlipkmuxNL15ItvNX71KFPdzw5mtsYPsFt2Fv+0893bX5gYJHKq2uBtFu/htb6NRi5IEgzAT4hGr/PkTEsYCL2cW/V13v6nwICevlF/k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3231.eurprd04.prod.outlook.com (2603:10a6:802:6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 08:58:08 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v5 5/7] dmaengine: imx-sdma: remove the maximum limitation for bd numbers
Date:   Wed, 20 Jun 2018 00:57:02 +0800
Message-Id: <1529427424-12321-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0073.apcprd03.prod.outlook.com
 (2603:1096:203:72::13) To VI1PR04MB3231.eurprd04.prod.outlook.com
 (2603:10a6:802:6::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85552779-f19d-494d-9dac-08d5d5c2c961
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3231;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;3:HyXq1pbGGTLe6Fh1DwqBBMI8qH6LBLpLCKW3tLfL8/GW3ag4x4aoYWZixRAZ3UwymdLTlkm19wPJH/AxA2Llzy7TasALdmY/ChUSpmO6cyhh18cI5LOvWUx41djv0HRSPwL6iWsEL7ZcJiBMi4vC5TMCxsOd+8kZIbzRUWAtHinCznyN5pF33RVAAEpQBp2ISSPSCfDMhVJi016azGuurcfqIyWq8+MlsG+usqUwoLaeW79UqiqqjVkizH2LU/Sh;25:9aFXO6/HhAph13RCXCFXhqwWAaQPTkamk2fivDEo/1BynB3nUmsJ60K2IwAnCt0+X0aUOfGGwBtrZ711Kd8iUuOkw2rbK1xEuhRArkT4mMv6+d0HR8GWtKRvAJwIk0wAMo37GxPL0suk+Lo4MoK7ECji6WLJ4hkRpPr0D2vmOkFVEfa/DgS4Xsgu3AvqBzs1pmv7b+rmDXOrlpDXOHz2dLeWc3e0CgqPvUIR1kJ9zViZ0+qC5xUN8uy7SNnpYx63SkUhF2Oh5xEv17i7h04kigjjCidWvPTFUnsbUwmh2IRybePfsS1v1YP3hP2LXE33aCl1T1SyTvMtlxOrqqATBg==;31:YyNnimJWfmqk+ck/McFeCC/qWFdPen0xokCYCySwzztNvxUWGE+A0Dgm87lR19DWlVurpyMYCsxgPVx26adP/yzqckLY7mRHTUNLLNGCNX8VGlY4CpG2s3WX9gd2ZAi197o9SxOW3+X4ErQk9JcBHgpI7hTfYDDavEx0bz6ol7JusiwfTQg5dx5NMdktg4YyoUafUJE6b1SX14khMSpW6DnNQgXgqR3KArjk/HyFhgg=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3231:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;20:AuoS3nBpPW43U24HSBXoLTv15ZERygJiiDNrbf3j8TIPCH5xPBIrUx1eUVVpN5Dlyp/FhDMQvIdScOLtymjhmHdwsjyVo30LxawrqwB0jd3SDn8iK9WAYyLZy5hcln8AxZJParYwUYBSg6cF3XjkG2SGpcL1mimE+2LaA4Dc99f31t5Z7Y66drnKVMkBL95Qj3IYptU9+/vTTwKaSITEKwl/B7oK2Or/oZETp1qQ4eKKohTI4DmhCwdQQaEY+pjCZP0uT71Xxzw+47UV1PEaSDi76WohwQv1loW0FgVfws4z4recph5z0xc8AYTg0l2Xze0VpdRxJS6GJ0pK56wNVVfEn3GxlzwuI/fo+0xKiY7w/uHCpHNKlfwhA6J1ab4xc+QnX37FtTKGq7a+Ej/y6mQCrqSznYCfLYUf2A1HjbSITguGokU2MG1e0U5NjpTrMPbMGhV4zfMYaiD4nFDBMmPqQsIsTFWXaRyalAMuW5dfyk+1EPPqD5gnDPGGIVAc;4:spzBVQ35YqACYCVXQIbypS94jyFqMJctAA+GxhiJYTYMFbCaK6ZbQYQL0jo9aYxS9IJ0fbhNyTg2xmzeHakL8lkkbG8sR+RcUw5k6gpPmqDWVK3s9Ifi+rqYZt3b1w/xDhthQ6pFQ+tqI9515CkGjNttmVXweM2Lxrgi3/3zJUMc2WCb+0EVnAI7q6dmE441h7+92jW7GjlIwZmu33IY/2zn6vVTKMlenApy337S5zjmfmCZR1kPaT4O5dYRZIcMX1Rd+kHXGrUdt6SJ2wRdykBKScxsbJw0CAzktZHAiA28YGFn8KrnMUiHE/FCWef/
X-Microsoft-Antispam-PRVS: <VI1PR04MB323131BC1F436E49DCCCF7DE89700@VI1PR04MB3231.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3231;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3231;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(53936002)(6512007)(5660300001)(478600001)(386003)(6506007)(26005)(52116002)(4326008)(25786009)(97736004)(51416003)(76176011)(68736007)(47776003)(86362001)(66066001)(7416002)(6666003)(105586002)(36756003)(50466002)(6486002)(48376002)(106356001)(316002)(11346002)(446003)(476003)(186003)(16526019)(2616005)(956004)(486006)(81156014)(8936002)(2906002)(3846002)(305945005)(6116002)(50226002)(7736002)(8676002)(16586007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3231;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3231;23:iy0BKcF2qpez8YGzHoUHSkuxmZp/Cz6f3xiC7SkJW?=
 =?us-ascii?Q?3i70M2MhUrgDDB4smFZf/ZLgGpXm0rJ0sy/zS1c6wZdjAd0raMTs0ODjh8bf?=
 =?us-ascii?Q?GyLS1MkpLL80FOR8CS2MK1Mxa7UKiuZKwF+y/5KT0/Gzkhx5tgtSs56db+vw?=
 =?us-ascii?Q?NU6/KCR0pYVyGT28xiRPrK3XelmKEe/0WKakT87MJ54RQhwfkmECoSYmb/bc?=
 =?us-ascii?Q?3Bg0JpKQOqA+n2nsyEhEPOAykWzsj4m/QjIgEupyFYwUtPPkf5Bs843Mwphz?=
 =?us-ascii?Q?yaayvRXWyiBn9wnSzlOsWxs6hZNqjoX+5ecM2ws7Yr/EUF3rDegKybME2cEH?=
 =?us-ascii?Q?18+DKE8OGBJidE09ggSCVePEN20y42SdSpG2GNuq3TwaZyJNIZZUs4spCZI9?=
 =?us-ascii?Q?AwjsV0HQlhROPioX/YJ0DwG278tJ+RuQJ41Ve1AARMmpFt7X0KPOJTdxz4A3?=
 =?us-ascii?Q?Y9syUbRA93VQLt5XBvxA6ErnEAGVyDkDPQOoOz//bPf5/L6QyM5TVZJKt8Zf?=
 =?us-ascii?Q?mn7xxF9gRlH67/C8LEci6CEDOOYOBaTRnKezYHIixjqCcPvg4Iaktznt3PKB?=
 =?us-ascii?Q?WQvopfhf5czHvjzpObw8PG4a1Jhu7QRaoMQeI9eJEMqOjyKldHXKmUyI9WBZ?=
 =?us-ascii?Q?elomLqkKlwM+w8hEk3j4DcSkKvInxvlWXmdFFAYeIGwOxuXnL6inT6z8VQUZ?=
 =?us-ascii?Q?0Ay8Vqssab0sWwSQ4Glf6BVmruC/9h8CNyM/gcIWUtZXKeEeiqsaUfI2HS19?=
 =?us-ascii?Q?7hd5Q2WmA9zFCTc+J51EkyBa7qVnxJE3KW20y2zF1aSfwZsz786dOmTQcrLU?=
 =?us-ascii?Q?LfwPZMpbLD/nIuQyPUd7SkvnaWP7+3/CITsmURw3pwLO/tQApK5CZkGZdfG1?=
 =?us-ascii?Q?Zj+lLMMsvSS+EBV2CkhczP/lkJ6ic17M9BYqq8/xQl4ZGTJhRvau1krkjR5J?=
 =?us-ascii?Q?xGN9muodBNU0cMxeyYorAwrvfHm4DFV68O3y6rMVpOL+up1h6AINaN4jUzsT?=
 =?us-ascii?Q?wwiMySSdS+msKvIgEiGN8f0DOMFDSIX5+y48CqGGDlIxNU2ZdCdjgfwsx9bp?=
 =?us-ascii?Q?63ycJWmvD5g00u4esWje8cbirNoNpLWjGunwMRJvB0B8Sd0xHUrWqydYVZsm?=
 =?us-ascii?Q?RxSFkIyNNPJp/bdGFomPujrH9eJSKwnJlFsJ14ppHQPco08Pcy3ccUUdQn47?=
 =?us-ascii?Q?L0lU6oaZBg0nww=3D?=
X-Microsoft-Antispam-Message-Info: Xa/8EotfDpmchJkj0UTmNU7cCDcSXezfN3SylBMzjvhYLYdLRuSddcr4zXjv/BnpO6hYPPv6nVenUJ8axz2Uct93hE0broq/DUIbgza5z1FEGMelkMvGTuLIiB5W6FRTef8GYZqQ7ydYqL8wSwIFEWdJ5DClEYbZQmLUUeSOxzg8U/NEG31iPl4YXEFr1iZbxDSnKfXgKdHmqu2RwaWOX3slck+pNyy7KaegsU8onvq1A35WicTXGqc1nEMoXXP3z1E1sgsHOqQlgbYiDbf+yn/+15szfpEPYJrLbiiQUa4DDv4PnqR4Xzp8Zt/OVrpSa6qJOcnNlc4GcdsMdjP+IA==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;6:Al5YakZK5pXM8D45B+gMW0CnrDv0pg7kM99lYHZRIYdAPaceAy6+1G35Vj6k8qO0PQpNqus18NMIpKucKb6hZKldE8j2AaALafLCIZtfHUCGd/+TggKedWEse10l+tGzmaJO6+QTRIB7oMEYFlVPkKreWy7ES1HSkazIDOmsKKseg4Pollz1FpylhX9SFoO9+hGEZldM1/sIkPXtOquoyDbBLIVWvX3t9QEdD81HLtzHJuvPTPZT4DZz9WrsjcEpKeDWtGiEiP4B0ayqN3hMVOneG84pX9YCm2dWJkesDRo9MgDI+XGFAvIAX7n9vzX9rbCgIyi1AfAv29UnVUdoPJzmxzhitqCBeQDo4dPKjPEmsutmkYYV+58yJGbydQKvaIMicdaQO2kCjUY19oImotHzCCtF3FK+Q2WCeSz76fwHH4OMpTHdSNbv9PMaOZMCO5yS/5GT82PCsWsFPeXdUA==;5:5ytSgFBLjLKatHRIoAO/L8ySBmZuZrO+L8QNWpQNdEzUBUbHgJaix8tuTKi+zUyeZ0POQs0uLXSdSnCsCi5frOWQe88imeclDB4ZcdofWWqwZLDTMLrDcHodsr2+fE36aCP75eogTA4zCZQ54PXUT0xCk2rCDUxPyPQLtj2QHNk=;24:WhBwpVLIPZ99x0zGo974+w8f+f1U+cUjteyMcqRqQyx5MfNeD2CRhHiw9VjLHhq/Li1IUxBQr6Hmg/IBFarhjxh/k+7fQs/S0QhIisbriAs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;7:gcwARPWyq6pnw6zVhfKl1lR3UAMo7rlvtGcidNsxTaLNtB0NgeZHsBIzKv6A57T3DMijMXpG8O7tUZ66jYVW7kQou2YDE7eneylEIL0eHPoZc83X7x9g/uHS88zzQnFaviKWROxusUAbK57CX/L/zs/+uWk+UkmIgdwYcAgCvCy9Y8MMfRrOGzAVmmV0Viq8hJUJb7FqJGEvLFXvrpXFpCtlvfH3iPhxNcfl+WQukeONrvzDNmanpliVc7YO/QBM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:58:08.8199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85552779-f19d-494d-9dac-08d5d5c2c961
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No this limitation now after virtual dma used since bd is allocated
dynamically instead of static.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d1d3494..9f1a462 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -285,7 +285,6 @@ struct sdma_context_data {
 	u32  scratch7;
 } __attribute__ ((packed));
 
-#define NUM_BD (int)(PAGE_SIZE / sizeof(struct sdma_buffer_descriptor))
 
 struct sdma_engine;
 
@@ -1290,13 +1289,6 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	if (ret)
 		goto err_bd_out;
 
-	if (sg_len > NUM_BD) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
-				channel, sg_len, NUM_BD);
-		ret = -EINVAL;
-		goto err_bd_out;
-	}
-
 	desc->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct sdma_buffer_descriptor *bd = &desc->bd[i];
@@ -1406,12 +1398,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	if (ret)
 		goto err_bd_out;
 
-	if (num_periods > NUM_BD) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
-				channel, num_periods, NUM_BD);
-		goto err_bd_out;
-	}
-
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
 				channel, period_len, 0xffff);
-- 
2.7.4

