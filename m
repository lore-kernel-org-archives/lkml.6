Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91311C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5FB20871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NQ/5EWn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5FB20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbeGJIZI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:25:08 -0400
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:55328
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751210AbeGJIY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYM+sfK23FbVXdjUGN2yhX5q3RBFq8sFEvoQjEaWgrw=;
 b=NQ/5EWn89k2G73tyIujJI419xwNXVKYEZKW+E7tz/yS2A40QQu0VqSxoWL0SWjPwTC+CC7Vhb8KTF/S+I+p1LSgKONkrA5ktXd5ATlt+YXFsv/LtcJEc6PzFSKocXRWA8fd/qgaG3sGxK/6k9ZElpfVlE0LwJuplByiffuMkBO8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3221.eurprd04.prod.outlook.com (2603:10a6:6:6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 08:24:21 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 2/4] dmaengine: imx-sdma: add check_bd_buswidth() to kill the dulicated code
Date:   Wed, 11 Jul 2018 00:23:11 +0800
Message-Id: <1531239793-11781-3-git-send-email-yibin.gong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 04835703-c1cc-4e0b-25f3-08d5e63e8c0b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3221;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;3:OM8xHqWJbPRsklShVwvUG9jdVXUGJSy3+gBDSphEtofRXBYlGX1Oy0V/u/2UEoAogiKSEqml0EeDrPFsL/AB0qA8QsMWCXcB0NJTa4xvERDJD5L44M5chhaORoNUihL3jQ5zQH6+2pOZ1Ejj8sB6jIRpMs7cLCohi4XPfKVcATOKUIoerMRew0nb72Vg+YBZ5P7aaUqGelqAOWNcWPPlCYOXMGSkLNryZljwNrn2EPvsZ1BkwAsXJ9MxEX4YsKgJ;25:2T7xEMQUr1pm1DsuHoLhainGklpibqfSMtVMsXM22OF3D9cTR4mMlCipydtLW5gyoaVshl/8BOrJggUOOEvCRtXscdG2jv9zAMTGxaWIEc9d3r8Sv/40+UuZLz8Y6AwbCVywBsL9knKLR0FI86TVp5fmhV9FbHi1nTRFXSdzG08/UsHcupsqPFUTGq+C/8El9bIEgiQcjVCalLlqRY0P7bgS2Kv3jsomWoz4F+YLhom3djSUTC9cVyJTNh8EZ4gPTGDSRdaR3269BXfYPtG6icsGkDSGKz+JOl65BfU+Ex22nXOVMtrjs/dZgczgZllrBOxjnGd/RYdMRRVmg8Uyjg==;31:ioht9stAC/s8i1Jsm9YM4L1DlNKRap9G1IK82Yq1vR9pLDNS7drcdXlXVESSboBTyXTbEp+iOtXZdTUzdelQQpnULd+4l/26F5JgZMUMfZv0RoqLu8HFe9zxWxuOANJf87Eo9z+uWgVWO9h+zgJZBcnnrwr/TVNMlg47MSG4UwH1QbahA0Uc7ATbY0MZrOohly76FRZrMWsMvjzSWxk4KUIxtbvMR4i6UiqUtwZQ5iM=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3221:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;20:xQSRIgovFhl44V4RCl2IJJyb4fm05DWlyEFiG9vhIJRe7bOboKNnXl7tn6lV9OzuBplWxg8oP6PjF13QZkyf+nJMmjX3lRQElCuMWbkPrM0nABakJDCG06cPkVhy/IN7RHp5931k7c9lQ3B6qaki6OG3+X3VPSZ8WSxBEjGCBAJERiEchnuoaCzTPJ+1n1FHwOPOckrTzMcjKTXFTVC5b9jQZATz1Wjba/s/wnLxX9V3tzQkksWRM8uccE5wwwyYCDbK0rJ4F+nWM8jFbg4uMDkw6bKhc3djgfhcqK87liRpDvdtXwHyX5wxiWpcBmq2EuPH0/a1bAHXHmD25GsOwAExApPfAnxdDzlPpRNO3BMEysT1G+jmgs1t9sVYkZWZKMjfQbBLyAZqQHPU4GSHiCn04vlba7zyI7uoncmzBN3jkGJtvas7ACPY6vJU0BK8Xnz4EKF4JsdXGErEVmNxHyaiQXAYNN5LJYgfmHyhdIXkvo7D4iHSabOvnyr1Y083;4:xnKqLqnax9HaFKLS+wa32ddWov2puX4XlVwMkYMeWqepZ0ZC8oKKfRTvJVQFwMHS75KJ1dgN6479CaloZuz/XJ/vAc0YTKwgzfEbrGF6BOuvT/aR5lBzrFpXsojyKId9uB1zHpGlJIbqfCfERr5mbUux9PsfX/eEBNh7ksSMUF7S9AmZhj1bW4PPGLemVzGZzioP/1xrgxl4f9hBEed+iXo+3gp1mGlG5wj62vVsrwOVPWrCiHJ+8SNWtyWBdvNVGy3/LEmrbA9h0s7KFQiLxVD9pW4vhRC+1lIhtHHqBjlXFh2V1qy+CQ38Bu4qeY6B
X-Microsoft-Antispam-PRVS: <DB6PR04MB3221371AFAC125263CA090B1895B0@DB6PR04MB3221.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3221;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3221;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(53936002)(36756003)(5660300001)(50466002)(50226002)(6116002)(6666003)(106356001)(97736004)(8936002)(52116002)(76176011)(51416003)(3846002)(6486002)(47776003)(68736007)(478600001)(86362001)(66066001)(25786009)(48376002)(4326008)(105586002)(2906002)(6512007)(476003)(2616005)(486006)(446003)(956004)(11346002)(305945005)(8676002)(7736002)(26005)(81156014)(16526019)(186003)(316002)(81166006)(6506007)(386003)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3221;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3221;23:2XtFE3JtxInzXLRFMyVMWYOfVX9iLG2yieYFHq7nT?=
 =?us-ascii?Q?EPNrEwvK2ViYB0KwVSxdGSEe5MTKumMu32YZN13Aa6knC93sLOr2WyXCWitX?=
 =?us-ascii?Q?kdEvjtDve5rlyYpHiCipUhveAUuN6N6JKoMZZ65QVbsd+WuGQh7ItOkXrVwn?=
 =?us-ascii?Q?Y8xJswnBpux8A4d8zHBpdUfpdwvzuz0OXxBStD74OyKwUhL0gkeJpLUz70YJ?=
 =?us-ascii?Q?nb/rmYsxZQEjJzqGIFnRVO60vqSY/nNC1Xcj0ZYT2A9gzuYeqjq9ron6TISt?=
 =?us-ascii?Q?mH4soXq8JnupG2Adp6wc0tF/mBIR21a0fi/wJ7rb30h8kN9JZBRdSthxpzAI?=
 =?us-ascii?Q?1L35/0U+vkTa1DZ6Psy4F+dH/PGJF6Rs9FrYK/qtu/avT6xSHC7QGmKH8Rdb?=
 =?us-ascii?Q?4Hb7wLSSi21Y8o9swFS6EGF0/rAxW9ngcyvRiNuyozq1CIoTLQdqFCfgeb63?=
 =?us-ascii?Q?siW9ffqnEkcRc2De2tkvKuQGe9D2uI4yAYcu1ni3X1esdURHQSGUpLmijHI/?=
 =?us-ascii?Q?pvstEE9mymUcZUTdGxuoYHQ6F7WKcCak8wAVTR8s7Pr6lxU0glmmahR7AP1b?=
 =?us-ascii?Q?iNdovkrLbvcB54kAE6TS087aFlAKya/tyDQFkd2noxwlpsoGAGzujwrkueVM?=
 =?us-ascii?Q?MAwN5KRnPBaCOR9ONfrttXW5Rv+pDQ0BslaHiLCFYhxnozNrNu40Q03EOyLA?=
 =?us-ascii?Q?qtHbxZeJzUhz2BoRSQ2oVzMqbaGMHKC0D4zD4TXSLtAVSuWXC90Wl1CqCqq3?=
 =?us-ascii?Q?1XVOsdxEUyu0PmDY7bZk90LzsTmq/orwrtPHTGNk4FgsTElNxhils+lt8Xtu?=
 =?us-ascii?Q?mjsYEXndUVs28oOKwHP/dl2NqWPTA51XZb2fMved5IAXdRwP89Yl+Mqqb4x2?=
 =?us-ascii?Q?Hhi+QGHErjLY2fD/UnYcTPqtbiRXpgebmDerzdhgXlVZLs1myq0kSkvnuRXb?=
 =?us-ascii?Q?BEvCSkadntUO1I5UWqMZ3ST8btj0sZAresRIrW8NLSf51Aewp6B3EwDaFmg1?=
 =?us-ascii?Q?FEyI+y2rK4kT8Z0XctsQ3qeWW0S1oM6CRmx7vwJyZyZpPkWwn3cXKRoc1zmw?=
 =?us-ascii?Q?U2b+5DFB/zCMStJm+czmxufSZokMbhI8NSRZ0qunYR+HFdNUQ0DrOOwT9T1F?=
 =?us-ascii?Q?5vvAFjUQm7LsaKh8a+fnrgnrlh5tVqb?=
X-Microsoft-Antispam-Message-Info: uhAddcxChuiNtvdlWlvlVyEveNuDU1b5WdBsIRQdYBzMKotQmJVsOMIkTzB1+mPPogLVTpsGiIDzoCtL7CXd1WDESPWMam5PoFzsQBD7ZYccoXHpaVPbJjcqqZ8BSRPoFUuS3rmkYQsYvr9ieTVwZl1IB9gn79QcbmbdMEeVg+BgMV/TiUGlFpkIdedD7GVFUmq1ZPXcFoEpolfDJl5eqX+dgHXaSy2eTqZiv51e2DorP/FLBbhaAGZrRyPuhMKPBRD66JsmnhqW7v13SqFgzN3TxtpTHTzcvUkbXLkjsuXJK4zhBAyFIR6xjizQf+ijxjwP5S6SEKGhvA9kIYJOQIZlL/NbjapS7mj+C5qJB/A=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;6:ft0K8xNtVgrdBcEWdEx/Lria/6hqvU9AwQ9RMH1nzWVDAeUzTdMY2Z8I/ydnAzAlYyNjd0LOyr3q/yIwRFvUYuc/QDGH4/HwbvErUr7BaPdTRwA1/hxbN1T3U7TvRQfC6j+WekVIh1zR0RaifV7VxxJ1kyHNEnvzkTBkylK5c6vuuy5H+0oOv8BUFveRBiLgavUC3Ek5XjCAUGaKim2n7zEnojNDchff8RCf5v1n2CrmuKO4zhXKKUdzD45P6ybFK5fDPQJaffPNI3nKXirej3ypOFwh9mlU90sWAhJ6Ojh1Qenb0SeSQ+pZgEzMbX+ukf5tFTL29l6BOtfNkFToDXH5PTDGrD45e9jABFi1vyyEQoodUwPQ1A6hKRDhnTPtafZU0k2Xr3saxJw1aLssJ4hYh1mvbt7YzTQYoH7GE2ih5S818P6ToxHs+bap7MCZxjQ2DVwoQBxi+h76WWHJHg==;5:rT40U+i7FdnJ0zEhD4KLcaJZ9g2d10UDYyK6Q0lEwrBV1TFroKUCvUNOTXYWXYArxyFwJbYyCprfnHCO+oCqOt0A8jPM/4H6gQxe4t9e0b436HkTOXqIMkCPPuDDdMIECy1CPXtQYtVqmmQnBSxfVd2NpuvvtWBzgUUCcH2WaIE=;24:L7ak0DD5v0GML3fUkmu2i7DI3UyNXOzoD4VydkjqpRGFDnIXpmhVGHiFsYWVoQ8B7co2Lrlmt6VFoyKe6t9G746m0J59h4ChIbcB7B6si2s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;7:gQ6K3DpujrWaD89gpwhKcpD4NGfdlY9cKwcY8abEQM5rfYOoXKgcIB+7/+8W2505d4exUz8n2pf/FGuy9rFI7YElDMvqp/t+bt6ilt0XL7mFQ0iWE4cCk31zwHtPq0LS9eLsGG2PwdgGJA3Sy0HSMhJUFe5pc4+Sqp+DYKVHad9p+l7SHSzKDEcLEb29hH0r4FpLHj4/7uo+9R7/xi2pJBwLjeI1Do07kXXi4eUSab5JIEa005wEOx6718utAwTz
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 08:24:21.6557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04835703-c1cc-4e0b-25f3-08d5e63e8c0b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check_bd_buswidth() to minimize the code size.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 64 +++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 27ccabf..ed2267d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1326,6 +1326,33 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	return NULL;
 }
 
+static int check_bd_buswidth(struct sdma_buffer_descriptor *bd,
+			     struct sdma_channel *sdmac, int count,
+			     dma_addr_t dma_dst, dma_addr_t dma_src)
+{
+	int ret = 0;
+
+	switch (sdmac->word_size) {
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		bd->mode.command = 0;
+		if ((count | dma_dst | dma_src) & 3)
+			ret = -EINVAL;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		bd->mode.command = 2;
+		if ((count | dma_dst | dma_src) & 1)
+			ret = -EINVAL;
+		break;
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		 bd->mode.command = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static struct dma_async_tx_descriptor *sdma_prep_memcpy(
 		struct dma_chan *chan, dma_addr_t dma_dst,
 		dma_addr_t dma_src, size_t len, unsigned long flags)
@@ -1357,23 +1384,8 @@ static struct dma_async_tx_descriptor *sdma_prep_memcpy(
 		bd->mode.count = count;
 		desc->chn_count += count;
 
-		switch (sdmac->word_size) {
-		case DMA_SLAVE_BUSWIDTH_4_BYTES:
-			bd->mode.command = 0;
-			if ((count | dma_src | dma_dst) & 3)
-				goto err_bd_out;
-			break;
-		case DMA_SLAVE_BUSWIDTH_2_BYTES:
-			bd->mode.command = 2;
-			if ((count | dma_src | dma_dst) & 1)
-				goto err_bd_out;
-			break;
-		case DMA_SLAVE_BUSWIDTH_1_BYTE:
-			bd->mode.command = 1;
-			break;
-		default:
+		if (check_bd_buswidth(bd, sdmac, count, dma_dst, dma_src))
 			goto err_bd_out;
-		}
 
 		dma_src += count;
 		dma_dst += count;
@@ -1440,27 +1452,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.count = count;
 		desc->chn_count += count;
 
-		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
+		if (check_bd_buswidth(bd, sdmac, count, 0, sg->dma_address))
 			goto err_bd_out;
 
-		switch (sdmac->word_size) {
-		case DMA_SLAVE_BUSWIDTH_4_BYTES:
-			bd->mode.command = 0;
-			if (count & 3 || sg->dma_address & 3)
-				goto err_bd_out;
-			break;
-		case DMA_SLAVE_BUSWIDTH_2_BYTES:
-			bd->mode.command = 2;
-			if (count & 1 || sg->dma_address & 1)
-				goto err_bd_out;
-			break;
-		case DMA_SLAVE_BUSWIDTH_1_BYTE:
-			bd->mode.command = 1;
-			break;
-		default:
-			goto err_bd_out;
-		}
-
 		param = BD_DONE | BD_EXTD | BD_CONT;
 
 		if (i + 1 == sg_len) {
-- 
2.7.4

