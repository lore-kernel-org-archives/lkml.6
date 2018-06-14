Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0887FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8A1208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="edVWLlYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8A1208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeFNFg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:36:59 -0400
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:37120
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751560AbeFNFgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzXj5DspRIP00rNRShWIPH0cgSdGIn/3XWRtqDe1EZk=;
 b=edVWLlYBbnUUWcJuN5r9D/oKeF773WUYnVJhDPlxDqpHgfZUjL6R5QOg6IXUalxJ5matZKdS1+NHB8MY4JombPrbcZkTqpHEu6wfYqTxS9Mpm0NlreMfk1PZD4Vhw82ItEoUsKetNtAK+z5sjMdx7Fo9X0LgE0TLA5NGs/hQmfc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3222.eurprd04.prod.outlook.com (2603:10a6:6:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 14 Jun 2018 05:36:47 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v4 5/7] dmaengine: imx-sdma: remove the maximum limitation for bd numbers
Date:   Thu, 14 Jun 2018 21:35:35 +0800
Message-Id: <1528983337-2726-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
References: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To DB6PR04MB3222.eurprd04.prod.outlook.com
 (2603:10a6:6:6::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42d25113-ddeb-467a-424e-08d5d1b8d451
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3222;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;3:mV2VYsHQ9BY9/yws8jNkKzmd21iE/3OCKqgRwYs80qd6QQ9kxTTVQhDTpM5VeNOFxfWWSyA5FCcyJTlYA4aXKrZkrfMIEquzyUt/gaB6gb4vUE85QJJdFOg1fXA5XXV3z7Y0yLQNrVb18nu0+KKECTzxgmJNnYS5qld3z09tPc5udpG8NhfCvYljtRVelGDLS2VN+3IZAPjExvojhTi73Gz1CNVBQ/TyYPHB0RcylfI3RaWcPGZ2aRWVCNHHyBvg;25:EfWMalOxu4rGe1TAjrTR+9pUXkTJOmk3ji7wqD7XTvUTRnbcsEP6FGvLhOKWNwdeRXOpzkk623p2k4wyHVJgFvvIcGIAtLJxTjJGC+8SKTjvr/1Hgzfifg6kjPm0ULIXIP5N7jSoXGX8dIEoBQAxqySzLCSr3fQQ2kPTL1Y7/ZIyx6vH5iMe9dvJ/tQhs+YK25mDTxjPgBHNak0uYxfWmFUSNCrugIhlKpOqYcjdjbeUwfcA5l6sbR62JXm9adWiZUzJeiwpQaviU/+OBLS2PFMXkDGbhesgW9uvizd1CIJBjD6n9sq480X/YlSwviLJ5LiSWk8rQ2veCM4QYBZLYQ==;31:kKMm9fC1yF7zh3hNUPdN8Yk2RBgdQ1B3XCRvvR5en1poWQmJYTEQ6cT/hNs0ZcgI2ITGL/YoyjVDrll1WV2XKVrOeZ+2vGPZ9aACW/BB8x4GIgn2wHrnJEY2O3bfaDbuGYta9IjtbLTYzhGVmoH/PMTVr2V0zNGv1aSA2zKzVemgj/QCBetrcQG1R4J6fH/qnPiS3A7Jybh1HzNVudK2o6CuklyS274n3TmnvNNYHi8=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3222:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;20:yIxdeoU4QK7JJfHMPy+BbFscuguzC4iK+ND53Te0Zr/21kcO9PgYvV3sQEyu0fkTWpls0G1XUjHMqV7cvB0AQwPOtESx/tPUQLs01QOCiwHo/vyeQ3GH9XZqWSNPpFGiWEIcVDi1cKB0oe48GyVngf2eOh9Lg/fwRIEtnly2KJoeEplZjiOe/9xM2FVAxXpQVZ2VjPDepjYk8HM9TFJCAmQPQXdm2I84wpokEf3xuj4DHdV4Ef/f1YAAgGPuH4wkWT8klQ3P8IgWuGnU28A1V5YK/TGP0NhihDqsl+j7SN0nsYZa8q3/E33be5OXh6iMIfuD5/nUuMOsVJb4Ud8tZkP9dnyYn3Sskl2WL9Bjyr5ie3eSFSt4JnuP8ePwgCjXpI4NGh/2F9VOm4nJBrY4q8OCrN+CXqf1/eGWtrQwzCY8t1QjWziUW1O5gHeFQbGktWlmOpTerDkW/y4yEHzz98cmZolxkPO73fVCTUde+GJsBh72XPzcekVJM0fTDYKH;4:JUXjibBcZAe0kjbrOrvz2XggaW2j8Ogq8A2LHPXIQXJuJ5NDCEECKKVTdgXQJ0K1NZuzuvQqGjtwzFI93El4fqq8qspgUgtAKHQsosTQNUogjV9WrA9STy545+Msoll+OMbXf7xLEcujkJ3RprM+YcpxQaxKWrrfiEMqneGOzPq0/7guN9uFMMZIChU1OUeY1FjM8HGemWwIJXwoEfYGKvc4YSvuTSw/JEeo1EMoYWZB1/lRhnbHcQN36tM3NRxtyZfRBudfk8WdIJrl5ozGP/TdPLFBZm1bLHhA9/sHf+pFY/uP33jxc+ust6DcDemD
X-Microsoft-Antispam-PRVS: <DB6PR04MB32228A44CEA89D8AC4F0C6D2897D0@DB6PR04MB3222.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3222;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3222;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(476003)(6486002)(11346002)(86362001)(16586007)(6666003)(50466002)(48376002)(446003)(25786009)(66066001)(305945005)(956004)(47776003)(97736004)(2616005)(52116002)(51416003)(76176011)(6506007)(386003)(16526019)(486006)(186003)(105586002)(106356001)(36756003)(81156014)(68736007)(3846002)(6116002)(478600001)(53936002)(26005)(6512007)(81166006)(8936002)(2906002)(316002)(8676002)(5660300001)(4326008)(7736002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3222;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3222;23:oQIm8xoUSdNWa94RgCf2HhIALVIprQVUKcAjrfajY?=
 =?us-ascii?Q?vvX+8ZKUxmU0MZd294wp6LMX72SwSPqZjAoDMCHZAjjwM7x1lIgIOHG+WUNS?=
 =?us-ascii?Q?8v2+tTI7l752CThlfikkaOjTrg9OGO52nPHoy3xetx6AM7SlVM3riIFSbeJH?=
 =?us-ascii?Q?/x/C+IDyweBfiT/7CIXIWurwCWbHnpIZGsI0bZQE3EyVso2/V8x5tuoPioBp?=
 =?us-ascii?Q?SSxMm9LT9nIqXwL60iOB9f/QJZqayzLvXhGCKrPlEPuPAYls8sVfJSWjnCdL?=
 =?us-ascii?Q?n81ELK5uzYjR7Zr/AXAHHCZHWLuzKGTGDLJaDUsCy4D2JseAVQCIy78966Bg?=
 =?us-ascii?Q?9IZqmKAtCRse/EZtZtYg3n2wQsf47l8pnWHuUrjbq/ykpks2zcixJBOLkZaz?=
 =?us-ascii?Q?XzdgdBzaRDs/HFQ46rw5qE55LTyecKkiLxVqz35nvFBmk0gWDnhzHzlW9mhd?=
 =?us-ascii?Q?5/46LBTr6hBgjDvKh4cGJt+bKgwX6SmRMa4XvvIoUNvDeeY04SzTy2EVgKyZ?=
 =?us-ascii?Q?SABopK3xIXtuUUQEtHP32fjwiyfxW0JlPbFlT4R7Zbv2IHpFx0i9pDfjUjl0?=
 =?us-ascii?Q?hbsJtquotvocFsiSuLUx4ZWMKfdZzzBmKzck+Z4RvrsrGkmqs+25gEKhpMoL?=
 =?us-ascii?Q?XyKrtQjxjrBGHwF32DYulQHxK+/8Y+5hCLA6qj604dw0z5lr7Lxod6ZBDuGY?=
 =?us-ascii?Q?rMETB0hVFZ6JuSvqDJpaj8oPqLyZ9QIsORafmtrV7QKJ6occdHblCU5FZre6?=
 =?us-ascii?Q?puOqUTo6gAFujFHDoh07TYRv+GSjvjJ6sb6uIErsu/9rPF2TzJbAQ77aKUEI?=
 =?us-ascii?Q?uJoLlxP8ieAOTkkEGkJezgeGHZUkyHpKI8i3T4HBpbQSQCI1tYLssIIoEdLZ?=
 =?us-ascii?Q?1e/ume8U4S60yT4qPvmniDsTBxY+91/t+s4AMg/a2czuF/y8D+rRkEYzpN3w?=
 =?us-ascii?Q?vG0u/M64/666XxSIW1ul5oEj4KJW68QUwqa5e3BBe3i1NMqhmHuEhuhbRB5Q?=
 =?us-ascii?Q?wD9im2N/5TMwhj5zAAylSNy86WsvELPMtLoSKmvNPxcOnkxq8+tEW4OLM8r5?=
 =?us-ascii?Q?9pjeJukIh70l708QFfy3ckN9f3I4XErVn7Co51BJG6OwyBlrs+atZqOjbgjS?=
 =?us-ascii?Q?tBBh//oO2xARwinrYN/7j82RffELCZc427++sDx91kUz4gDqdx1nQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: NB15n4gxJ5UWQhv0hr+Odo0Adqg+W2oCkkeZ56xJ2TPyA1YEHCyz3qD9BOQL8d+w/+CO3pNiFtNNjaih9btPI5nKkzvlIkb/9rJIU32sUQwadzm+IK5eDJKSwaEXCWmWVfOWvi+IV6fL5kpSHRAfeNQxlsMpY/t8KAd8lFdSXz/KwBxwqQoJTb4ChM4juFhE
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;6:nmrhAnjBIOWV0YpxE5lkCkBtFmQvkvXg+IgYfNe+RW596adG9xo7hybAqjW3nKm4WC7Y2AvMh8kwknVZ4Heg/mbEq6iKAC4BnRtnrj27gCB361HLJUnoWWr6zKYwEcoju4GxP439Qwy78xub3Dq5PqgVgxI6UIIGDLnwT2aTl2NdmN1SLKPllDSh3JxGyjeOA8OOWV/04cwoo6tU1r019bGt63Ef15PK20MlaK4TyqxsJkte/XLDn8/ocgbe6bVqBF0ZiajGufxQ1utn16C51VioGxFyDgQkfwDScV1L+IIp8YGpbBzI3zRMWTk1qm1NNgzHOUPi02Alj0bgQDDPsAHplajsjm5DostGKIeMh8u3jD8RJapwWwbPxZ34Du7LNhSOo37Mr3T44bQXqRot7c7FbNInv/7/MclKLDOLKtmPuwGzBfnth3NcK8V+7amI5I2lsMJn9Y+jVgGgDC5nIQ==;5:r4Pa5xD3qoRhxeSNSkryS5tKQjuhcUWRKG9DUoZ52h8JKBfuF1wOgo52TFkh+I2MFYWFP/5pb4NvtkhvgoEsLLIeTVCB6MxnoKZ4oj1UPKzZNqf09hqm9GPlFCwo9sFBhkGoE+11lfoGBPGkho8QD6pJRoJMb/EPe2b8750PYPY=;24:HL/lHcPGJo93hK/ekqOXznKe2NHidCwHLkhIS1BtpUteZQrCYYYgzvIxvt4cLaJVmbi0JnL9hGr85297zxa9BOaHj1ZzEXCZgnr3Hi56SwA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;7:odPFyc87TMK2wbjTR8C5Ukb8MJ+U1URW2Buue2+O3wlsOAEvZp8/v84FvpQglrTOPd3VQ78Z9/KFkT+CK65DFhyLVXvdJYb8OVOkCrC98gsF0WpDY6mTfQjO3KYcBrnJYxeAaTDstR8tjJp7wmlYq0dfjwclIe5r7jp6Tfn7i5ECmGPAzceCvQO6h8XcS5ufea3XB9UY/FBwJr1OAiLoeu3QrCUAsIhjlFZPx2bDgc4LZ8198EBHbvm+v2f/RM6M
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 05:36:47.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d25113-ddeb-467a-424e-08d5d1b8d451
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3222
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
index 27b76eb..f56226f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -292,7 +292,6 @@ struct sdma_context_data {
 	u32  scratch7;
 } __attribute__ ((packed));
 
-#define NUM_BD (int)(PAGE_SIZE / sizeof(struct sdma_buffer_descriptor))
 
 struct sdma_engine;
 
@@ -1297,13 +1296,6 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
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
@@ -1413,12 +1405,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
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

