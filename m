Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B08C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D842720871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dC9lO0Qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D842720871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeGJIYh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:24:37 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:6046
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933347AbeGJIYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2G4lS+cIP2zzUnXTE7aobSTRc5UwCTnOxYI95xY1ec=;
 b=dC9lO0QqfFz8xlORS7ZkNRYVrYNWINrMAL4/3IR1EEPJi+D5faXfiZq76VEeVBuLuvq3LqME5K0CRI43g1Fb78ni9BQIS7+BaaiYXS3i4c9z4P9ba7yrIwoECNfVOYuDKD6XlxE8zw2UvWluxrj5fDjhSp+zmZQLXZQcSEyHqcQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3221.eurprd04.prod.outlook.com (2603:10a6:6:6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 08:24:25 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
Date:   Wed, 11 Jul 2018 00:23:12 +0800
Message-Id: <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::20) To DB6PR04MB3221.eurprd04.prod.outlook.com
 (2603:10a6:6:6::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28e87c44-682d-43a0-e51c-08d5e63e8e9b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3221;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;3:rOA1NZVM0qhhsWCVqSNdsqphfIJeVDrDOI2Hzf2t/CPnPuY6TnS2MylTYxQMO78ZlqJz+gLve7m24OxCWhgXvRmxilnB7bpcK/MDgT5GtAnUf4deXybbMz3oXU3IreGNSfJSQwOgsGjWJj5V2+g92lZVF/KozbWkYDKeOW7Fa77NYDjp+NY+dnilEgBXHaI+Qxd01qNZQ0hhmVq8feWS/xL5johNgnxz1lZS8L9LRSIP4oWMfrEqU3NaBIjJz04j;25:rAZ4KTyXg5BUL2nj28QHxzcA4amEKiSFudI85AS/S2gF5rIVJ6IxdhZ22dtYhXfRf4N4LbN1YR/jfq17HLSkwSC4qd5e6OtOtm2TxdiQBXOI1EyeK/RyewKKuJvczZwjtXqj3Y01ufFLwvZ3HmWQdzbWC0Nr+hYiLENvg0eJRhTfysTuS03hFzdGDxnTsODUH8K90N3vmvRhHeOU8dqH3V5f6MBdksrkACPL8mSgDHPwIxbr4AfACmzSD+Mi+c89KnjZPR8uA7JUps74pc9JEbJkDZZZNDmTVZVj+JyP6IB+w0U4BVDGd9RCRbwCyY4vV2fqqVkzsEgQx39JQEslyA==;31:ONK5Qm5V4Ni7v17n9hLZBRLTka6Gvl7+It0BrgASKIayXzEdsGzAk0PhPkxnsFeFz8LyriaGknwkcduKFd+uP4enfTql4Jpt1KdDgzyK5VYufXN1APwVGSrblLj3k4hwGGWY41odugcf+obFybuqjMxrvdVbdXrfkqynM98H6aWdheofzCYLXe4VYQsbb7Lfcaa08xUTL1ebbn1fMdTCUo9HoNGs+L/sFaWcIl4A+1Q=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3221:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;20:weVOaH00hij73JOwKXtTyvfEsJH9WrLXDuVh2RzLDVHmwwZ0lTft63QjoKeoCvwiO98HZFQT1aJUCRGzx5HYR2JN2XJCZ5wWni8np3GTtr1XtSfgEC9Y8+bly6jkWLlLM3PZouc3sNiU22PMlrBlGBJPQBRABULEwfWYP6ueXzFWITr7+GuPdWMl4D8VZxK3ZDHRFXjiVcWODAls076+eBCKk6ZQ+mzwrqZSfDjc0GD1xl2AcE90unwcQU/f0Veks3ga/V0UhpkOo+Pvfd2xiC669oeRgqjawx/Hly2dr+9QCIACaCgSYnjLNNj9JTUiBdteMD+tSlVOyJtNqhueo/VE87msHjuY3zzdy5yfuIU3Do2gJJPY9QwrG4GwKXqOOQHWAWYAyW26JQlRkKeTwBhsv9b00aS/ZL57a93sfhyNzpbK3RHFM/162ZZzY9CoB572G4BkfJdTLw0n8ypN8icTqUG96neSLhbr3i7U5ejkg62F2zfstvvd0iyahT7i;4:dx7LNrh/ZHED1gdBleg4nDUK83BEcmE1N7iu2mOHsBRmMgo0VAOPSHTtwB7tqxyhdOvJfppOzwHjheSGG00PoPZ9SJiX60+TFk8u462wMc7RwzhhzHB1pGvCAE4qrURi5Rbf3pcu+YZsFf8vxscnw2vdsDvtVNIYirWLtJY7gy4wEd2NwmMDQJsHlBIc1N5k0Q6mO4HlN/hcYBVWF9AJpN7hwc9M7yqx3zQMu+vH9BFxK+FpUdZuOxTVNqXAfcCLBxh2/EH+YFIHruyMmTC5JTMsUteuFyPZiAji8GeSrZjVYsFp8FuzbKHJ/BxxxzMP
X-Microsoft-Antispam-PRVS: <DB6PR04MB32216EA9211D4CB6B7714839895B0@DB6PR04MB3221.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3221;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3221;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(53936002)(36756003)(5660300001)(50466002)(50226002)(6116002)(6666003)(106356001)(97736004)(8936002)(52116002)(76176011)(51416003)(3846002)(6486002)(14444005)(47776003)(68736007)(478600001)(86362001)(66066001)(25786009)(48376002)(4326008)(105586002)(2906002)(6512007)(476003)(2616005)(486006)(446003)(956004)(11346002)(305945005)(8676002)(7736002)(26005)(81156014)(16526019)(186003)(316002)(81166006)(6506007)(386003)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3221;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3221;23:7/0qZE4yImTEz4yHRY6OTLUXNCyDHQmF50BOYfFyE?=
 =?us-ascii?Q?xVx186G1XDarAKMC1dKQ8l2aGUm9B2zU87IlCXOtFVM5R3tvc9qCHSL3Pt3q?=
 =?us-ascii?Q?SFlSiRKdYApon4DBl95cEiipJpXP/DDV4i5nSgpoIw7BHCl8znyVxOYNaKAw?=
 =?us-ascii?Q?CPtuMnrqSwd9YsUKLphQR0KJVgCbxJ9CyrNo8+9mxbVvTQOxLEWdt8+r+ANC?=
 =?us-ascii?Q?/9jjrz+SLC/dXHm2Ct2GhHy2jCo3LcPicVQ5z0CZ2zNhaImHkeTYleueLuGN?=
 =?us-ascii?Q?czUdxtkQ6Y1An2YEWX/50UtrmpLxcijsPEohguCspAL6cngy4SYk0MvVwaEu?=
 =?us-ascii?Q?9ahlDJZp9wKkBHZwHm7oADe6tp95sAwRMWkDVed83ds2o90cyn/tJbZBta8G?=
 =?us-ascii?Q?1bxRtzL4Q1OjQ5sZGscEn1scp3NrjWTbHjnHjhmxIRB5jL2z6OTSN3VVin8C?=
 =?us-ascii?Q?qW8rZpdy8PmWdxp9EbyCv15iABWOHrZxqCXBKei0OkyPpGT/JSRhT4wXrsdE?=
 =?us-ascii?Q?IPfNXfEOQxs9vL/UWR7pq69Uav402eAVNPFhBlBDH/liTpqB8cdfbk7Ua0l7?=
 =?us-ascii?Q?+p+m2DIsJzdEeEpD3gM9MuRKcrgVm3whns06kU5MvPQbEwSu+smY7hmbiVEI?=
 =?us-ascii?Q?UkoZUdMZhk/ku2g4zGA6kaLmSiIaiNHhAjTDa8ii2JG8dMHccfdXRk34kD2r?=
 =?us-ascii?Q?b32IBxxuRypngLWP7G4SmXPKRu1AT6SOzip3ZCC3ki4CpS58TNDh70/pKnZQ?=
 =?us-ascii?Q?OOtSeAZpgxAGbw3lk6QBmW5JFWBg/Y+IYYgFoBPimhKnz4WxZxVb2ExgTJHL?=
 =?us-ascii?Q?YOsCJZiPdimwmKo1BZluQHhb4qSFq6VwaQcRQ7WpES+lkl8GuTangnnG0DbG?=
 =?us-ascii?Q?lgnBP29AXCtP5TX1f9hCqZu9oCMANIs26huY/WfqfHZ9HPmbKDEzEDA72scq?=
 =?us-ascii?Q?YipaTKn1U39KsEookWGSC2EX+DMUJ4FXuKRh5WYqTZW35pPxtJ1FU5iXCBJ9?=
 =?us-ascii?Q?uFpDAonWzx1lgLsX/zCou/n1SMRsBz68O9Ixak8gkSHpiM/hEMqXJrmNqbXv?=
 =?us-ascii?Q?qakVIS1paBWBbqhba19ETEcc3D373fgrEREvxxI42ScuCrbMuWpWlYt037eB?=
 =?us-ascii?Q?Aa2q41zw60WJEosL5K9Fs3puo+rSjQvsNoCeffN9kpPhJIU2MWn3g=3D=3D?=
X-Microsoft-Antispam-Message-Info: 4qh8sT4+RJP3fF4AfhebgYuEqEhVqMgDOgP63E9cRbkTUTpVIufw+Nq5VD/lS77j3LzF6LCk0sF0FgWcpBTKRSSRSP4OQRRZsyvjd7pv+utqmhrbbtlCc2ZuhKu+vGrXL1a+07KNVltNQ7LfY/xiTV3JcESoGZ/8fb1mxIjvEh0m+rHgKqbq9dn1HumsE6zyO5eS1061GfTe6i5AVICAu7OjfUqm71uID0s1CBKdgxCbA0jAGTFHiL73AoYZSYkIyadGu0sSQvs5lCD/hWB3jPRgkaUc3BxdMbZPxUSfstx1HMBsnXYnczrvtW0OXgYXMtQUjtMk1qRfSxGqmS/KXnAaQWSu4YxvE9DWcyQd/6M=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;6:v8LfU4URnECOcQw1ctDq0yaZY3BLXv3iCAoiu4oPYmIaY8oVAthnU5IpksT9aiTIWtCfhXYl/qJyXccwFfVlK9VFBfU1xmvwlxTDalP/B33tZmaM40Cl9uWGp4z5WXGU4sMkK1zCL8jXK0NOky/pHkPyQr+i34tsG04zPfixlN3o1VAUwN9yITQ3gOonjGaKiqUqk7t9sEGBImI/h8BadAfqTN9DO535pjyjhhXs5Fzt6jT7cOuEeD0DFTaBNktfkyrnRtEAu5MOzpP+iKkPSBxNOsV/d9mF1pzBzK31XarBDGGnqvQ24J0lKxqEGxTANoNOb+/j58KVwujYDQXuj0+R6A5cEC0P8+c3nOF/abEz7p8KqNRECX4lvocVI+LHNnr+djzTSh4YXElUEwGju1MxP07MZImXKHXP96IUwegWN1rOCoOxSj9z85UoW7W7Flzx1+ESfZI86PDB6+krXQ==;5:pb7zJoO4nbNrv5pGrcrDco0F5YnTcGdhrZjbc/Z2Kf1JbPWJjvJMFDR5loLUAr9bb2l7XP+5XkODJikFR+gy+niKoJ1xM/U8IeQ/om622rNPTzMfKULlrnSL9t1NKsT1Zxpn8tTuu3a5lx8UFh+lbDuMwCz0oT1NI8ibTMzY2n4=;24:XkyCMFz4TZ8WCVg7U3nXr+e292fUAkanp447knu24mpFi9LcHsBL0fpP6XuET8idcOGzfkDbmZ3URLJHCxY9g9Ns7nKWZo/JRWot0OOItO8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;7:5LikvaEmQuW1Uc9C2wuHJIP/MaQKeRJ2Tpzr9E2991lNWQ6Kahjzqx2v8c2a/LM+5X+KbuLD/b/wpttxSM0PohyGUowfQVOZ4ZUQJ5H1Q8hJ0g4jaJdmRTDkjYCKaDWYqhncXl9Zig9tmeywIdcT6pNC4DPvtBDQQ17QHD18KqOAZOEkN5wFpNyspgA3UfsPfsZPiltx6z9GA4toJaAEC5lU6fTxOkGZBR6kfiHZ+e0iCVdDclMNmxH5oKDMhn53
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 08:24:25.9638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e87c44-682d-43a0-e51c-08d5e63e8e9b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmatest(memcpy) will never call dmaengine_slave_config before prep,
so jobs in dmaengine_slave_config need to be moved into somewhere
before device_prep_dma_memcpy. Besides, dmatest never setup chan
->private as other common case like uart/audio/spi will always setup
chan->private. Here check it to judge if it's dmatest case and do
jobs in slave_config.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ed2267d..48f3749 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1222,10 +1222,36 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct imx_dma_data *data = chan->private;
+	struct imx_dma_data default_data;
 	int prio, ret;
 
-	if (!data)
-		return -EINVAL;
+	ret = clk_enable(sdmac->sdma->clk_ipg);
+	if (ret)
+		return ret;
+	ret = clk_enable(sdmac->sdma->clk_ahb);
+	if (ret)
+		goto disable_clk_ipg;
+	/*
+	 * dmatest(memcpy) will never call dmaengine_slave_config before prep,
+	 * so jobs in dmaengine_slave_config need to be moved into somewhere
+	 * before device_prep_dma_memcpy. Besides, dmatest never setup chan
+	 * ->private as other common cases like uart/audio/spi will setup
+	 * chan->private always. Here check it to judge if it's dmatest case
+	 * and do jobs in slave_config.
+	 */
+	if (!data) {
+		dev_warn(sdmac->sdma->dev, "dmatest is running?\n");
+		sdmac->word_size  =  sdmac->sdma->dma_device.copy_align;
+		default_data.priority = 2;
+		default_data.peripheral_type = IMX_DMATYPE_MEMORY;
+		default_data.dma_request = 0;
+		default_data.dma_request2 = 0;
+		data = &default_data;
+
+		sdma_config_ownership(sdmac, false, true, false);
+		sdma_get_pc(sdmac, IMX_DMATYPE_MEMORY);
+		sdma_load_context(sdmac);
+	}
 
 	switch (data->priority) {
 	case DMA_PRIO_HIGH:
@@ -1244,13 +1270,6 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	sdmac->event_id0 = data->dma_request;
 	sdmac->event_id1 = data->dma_request2;
 
-	ret = clk_enable(sdmac->sdma->clk_ipg);
-	if (ret)
-		return ret;
-	ret = clk_enable(sdmac->sdma->clk_ahb);
-	if (ret)
-		goto disable_clk_ipg;
-
 	ret = sdma_set_channel_priority(sdmac, prio);
 	if (ret)
 		goto disable_clk_ahb;
-- 
2.7.4

