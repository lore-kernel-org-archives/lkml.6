Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5744FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BE22147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JaMwGZo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BE22147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeGMFXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:23:15 -0400
Received: from mail-eopbgr00040.outbound.protection.outlook.com ([40.107.0.40]:23472
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbeGMFXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vERjg01vmtAChLbqvYSj+jReWMiqRvrAR3f5R0vOIpk=;
 b=JaMwGZo92AtKXNPLlqwVMWH3g/yx/KwbIvTFl1bNsdfXSVIhX4njAER4Top4Zf7Z19GavFAeKkWuI1drEDXvuL3OQT7St/69ALS+XVDC0nXSmAViz69ye9eVJ/2+3afr9IKWMPP2kq98U1/XpasUxxFTirohRN7ZZDqDLq+1bMM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3230.eurprd04.prod.outlook.com (2603:10a6:802:6::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Fri, 13 Jul 2018 05:10:12 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v2 2/3] dmaengine: imx-sdma: add memcpy interface
Date:   Fri, 13 Jul 2018 21:08:46 +0800
Message-Id: <1531487327-21879-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
References: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0039.apcprd03.prod.outlook.com
 (2603:1096:203:2f::27) To VI1PR04MB3230.eurprd04.prod.outlook.com
 (2603:10a6:802:6::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d640bbb-5b6a-4f27-a78b-08d5e87eeb74
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3230;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;3:0P0c3v49aONy/bmCmwZXi2kyOEdXS9Q3ULoTVC/7Z81rzr+7hUaWMfEJZ/mXTsC6/UANpx4kLSQlvPqTLsStIbvuGrJzyx0gyM41pgjO6Zx5IeZzxDEgB4ptrjA5Kt3S1XA5aodTt7RQMw9igJv5InZrU4J1fptmOqlcNM0NDTehhTaX42evi7pNrvPJh6qg2LA2o2P2Yv/Un9v4VIpJuFOo3sBCFD4CMQAKsz1iKUCcF3n/Tbi2g7dcrGvl37+Y;25:AvpoFW9L3/nvJHx8XZ/N5uMJb8yUduwgAd6HDw66MaYUoJbVaon/XXG1RYszaZ9tgJOijV9RGfwSBoqMW9NQqtjGnA+RVdub3FvySn/ru1vk40gHXX9ZOtHU1ul1PMgNI1Y+pbWej2c8yjFLkQZX4zkesM2TPF6rXHbW5MUt2k/9zaXwcPyEJwn14jcU9Ic2Ev42KCLOKPA0llsdqy3CaKWQi888deyc7fgGUuT/k9FHSgQ+LDzBm09zPYNoMESa/9Q1yDhDk/liTcKi9RneBSNAsjPAjH0CfVWCuiXuVeVJ2MIrTM0aMvdLxiafVKDqTX7gkC85odHoVz+pRlTbcw==;31:Crz4oFyL75/LEjxGFiNCZAjIDxnuIET1aQnYGu5T7h/0IAXpBK4t8vRzZGuh3sVBFsdFl2EgE51nfEvLRKcgXm2+5O5agG01wdagVr9wFQz7D+ePW1E8pgVgAbJNNE5R3CgXqpFlcmdu8XQkjDT8U+ELIdMBHuXMWZJ6jq5+/6tA+ifFJCQx949rZMgRk8P/mxU+4SbYjzk1Y1QJgjSmbXukSJcoGpYAy9kALvdaS3k=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3230:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;20:i/0dJzoBfjixti4qtY5z0UtGVtjMu4DyDq7GkQ+p7wHx3N8C7nfx5v3hKdEDxJMMMDhpR/599GRLgVYQi63dEXt+u8FP6ZolbuL3ESKf7irTY97zeUWA1U5FNdQjZtr8zcqZHZeLng4SmuRm3pPsH9ESRTjmWK+gR0CD94pLDg0ZOjVfx8Eb5F+cHGgV/xA4168DfNV3fVr/IKKnjxEDd0SCPQEc540UukdsMsq6+MJKaATZpvUXzG5XSZleYDwCDFb8e9uQCf8tuIodd1z5anWZRh0W9MkehPDD5PzBeqqC7AJR5AheZueFmB/ICt5h3vDyAa2UFyo2pkmmbhEE/G4iZWBfORFKeCISH+DnXF+uA53wbz3zwbZqV3UXIM+vtbNFAUNevoIWnNhKuXPWmfONSP/BbtunmxpNmVi4SIKxYfUOl70YG7R4206KRb+cjBIeMUjYaAujyYHgaSTMhU8X699Pj+6Tydj010tLO+lQzWdGTR/jL0lB6N+RyCKA;4:LsiCeU6DL/ZFbWD3D4lKOmBZuA369R6MwZS/7TKDBPbvx4XongExABIcbPKHtVUJplHjmgGtDlhr+2KH+Kddh+9QsH7qEGL6vLJcd3fF6hAbRmkgKA3OVbIpK8P83bhL8gXpdXDHJSxao/jg3uMzwzOKbiCzCpvZnC6F9nUFT/z8H/llgVvcosAD2Md7CQmrIuuIOiX7jssg6vbtJTPYL8Kb3g8Rmyoxx199txa1guD/W+OAjeZ5EcFCmPbVM+yMsb8BfTWfQbopSIg1OvJvfqMLe2aZqxnLUFrdEtNnl90ZO72ZFZCHSHefxzDqwWvC
X-Microsoft-Antispam-PRVS: <VI1PR04MB3230E1F7B53D4D28ECD596EC89580@VI1PR04MB3230.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3230;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3230;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(6506007)(47776003)(6486002)(4326008)(51416003)(386003)(66066001)(8676002)(76176011)(11346002)(446003)(52116002)(478600001)(48376002)(68736007)(36756003)(106356001)(6666003)(6512007)(2906002)(16526019)(105586002)(186003)(26005)(25786009)(3846002)(2616005)(476003)(305945005)(7736002)(81156014)(86362001)(956004)(14444005)(53936002)(81166006)(50466002)(8936002)(486006)(16586007)(50226002)(97736004)(5660300001)(6116002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3230;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3230;23:Ea1ix17vsd51d52OifXg0Vy3oXXl3V1nCefe3oWYK?=
 =?us-ascii?Q?4NWA9whlU+HEjJyyLx8it3Zm68N/YyrvO7mVwL7SLuJCluvTjTTwELWzXewF?=
 =?us-ascii?Q?Zuczdcb2z5+KN0G5QXWjUoXH0ZgkHxbu8K/jIuS4kqGrUPunLTZ51AzBawC3?=
 =?us-ascii?Q?nyt612Fe7ljZ1cKNWQg0VwakCCfZmAWweXnuivD3WD2oQMgIfif03SwiPM6S?=
 =?us-ascii?Q?QXoeQ/0Fu+IEkfAh87BazB7qTkXWsLXOSwUtWjKvhKK505I/LSdeoTYU/t0n?=
 =?us-ascii?Q?ZAF0dFUi0O4tztV1YfTK1lF05f/SEYthhktuuG3X5+E1I67gJDH4GsGIwWf5?=
 =?us-ascii?Q?nfuUagC3ELLthQYysp5PJSt/H9gg/oRTpcPyTFlHP/uohH/cC2SzmgynXopP?=
 =?us-ascii?Q?mzXLbRoEj4/OY9oqS/uwo4noJ4Co7zkHQni8x/vEErIkCX0iAE6RyUq3sCby?=
 =?us-ascii?Q?jhAqP3vwc3Jc9CM1damTAkBGzZJpWDo+eZiVgxN+4nXteguMPfG+8CNxQ8TS?=
 =?us-ascii?Q?XrS6sPyMIFYEKL64GONaeuopBirIqsgz3BOnl3JKEl9woDs0PYcNJm3WF4GM?=
 =?us-ascii?Q?NVY0McYKWO0v/8Ed6PG7/oPzcx2OrNbkhCYVogxTr6YUMaarjBOln/+JiPWz?=
 =?us-ascii?Q?UC3N/C38eiV7oVWM+7hZkpnk35HJ4ouh0XDZdcpG04A5qdP3Davn0GKCBLF0?=
 =?us-ascii?Q?/Mxn4m15u1YVwdeBpNx/epM+lg54ceodBHpv2NqEt2nufouDxsbeHLs+GpEQ?=
 =?us-ascii?Q?2djnpu1gDPNgNdyULtMTGAnfpdePgDo3h2CfxSTbVQ05AtXBXylZ/yeSTxHD?=
 =?us-ascii?Q?g4QyB8BM9btTRbxSBhcRLRMUiZUfenJo5gLS8RxpSElg2Zya09nr+RouMsfj?=
 =?us-ascii?Q?T752rtumYKb87pHY+956gQWbLZZEqBebl0WkSPCGPtcuImUodQrP/MSn6nln?=
 =?us-ascii?Q?Q5SSwdvH+SDwetQQkNG/wzh8ljwo31OHF46r7aAq+KMelgsKPS3qm517mOpP?=
 =?us-ascii?Q?BFLajC1/eb9YnMkPvb7oj+QizWV2Ya1iI+CoA3ICkTj1TNNaiO/iUbKXyOaO?=
 =?us-ascii?Q?cyGvhax+4Yt2rspn9J0nnvWs6ZXmxSem9NxclzyinErYnvT8dYbdszOaRaMw?=
 =?us-ascii?Q?BDh0vdqYDW048WjYh3JkOq7ym6oXDRxG3z74lWI1t6WdwnY+xjztQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 3lyC116sgHMMa0hZNq9ScMSKUIQktUzkdIy9msSbO7UFOhhG3CciqCgRLalUytT6EHYsYKX74sfrKjx1fouajh23X2g/2I7rM/Sla9aGrWu9fXWEyOY2fU6n9fewan7VO6SXo9X91IDZeDLrTkVmVFCE5JufjSVQpJL84XzNyp7mJYwbIrhdPa7E1/oqLiZcCGMtM5382rlfOA3Or8xGOQsol4yAsvXaXvyHTvCmDgiQY851uA2XFEYQduqY+om97txXBCyMjzxy+XZd5hT6+zPsI5I+vlnnG6ss7wTqgjbBE/Wyp+eBN3UeTlgvnvDOqT+YRr6D/Ng/AB9Xavv8z6J/aZlqGbrtCE4vtR1Mk14=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;6:g99nkVT5EHa1ImbPU4+M54NRR9Bl433RYtCTJnl7807QbcBqnD1f+7NFFFuA3LGygYDUXl8fogbye26nqnHtISMxua2kIBjJDiWfy5zfIHRi7jHm5SEDxh0rXkDJurIWnehwNiooLyKcxTVWe2hEZOsHgV3fxphs2bBjCR9JBDGTDEWqcfbsEwS4UJEhLc57rodTXrtWmyDSq57ynzvm3N/RjV7eMDpvPcz4Gc4RgpVI8x+RoqGzd07/9NZuWx3k2p+6DtYZIOzQiP/vVAmgJ8kmYLWjQS5lCv5EjUinGAX2ML7/HMH1fBYN53YiU+6C5SjFldS6Iit3nUezN2fymnmPuSm6142ZEQAGXUSwrwpdGysF18qpF+tRcp4yYmEO3VpSH8RShchyQNjmevhlly4qMx0XoUYeq5X53MShy4aMO+fyHWQYLvz0EQx0ONRm2uPqLERgiCorACuCw9050g==;5:P380pXi5h/UDU+cEal5em9YUq+HJM52UjyKBs6TofIYl9nC6a/zKajupL0UipOJlOFRHiAGgr1gnR9Fq68ztB1wENcZdkBoMnHIZ/fTI6EVfhhUb2qdcTso4IuIQ5Fb4hGUTeJsCRWoxCMRIn5Kf7PYzGnNoHbZFBLeN40qy9Y0=;24:XBFp34Nt5TqFTAuM5X/IyJfidXZoU0Ye7l/8UOcBRWzM43Sc6vtB5L9/Kax9n122q+lWcZZ8ZDADurt+5FyEZYB/Wi11IvLwzuf8rL85ZS4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3230;7:HOW3qC0zj78kLaywcjhqfr+oDOfLmqm48XffsyFNgBzza6CoeHtLs9Orxqh8yX4eFHBrvSNYeKI5PY/PvVGQHkDBEsnSe+j6LIH7myGDy6tXkJtvs2y682w9v6LIx99jXF32ACMto3c0Dm/aaRR3qvmUysXSS8at+zimLp3ZajwJxnDlbOV7SPgJoPvrSUQ54w/ZWt7eDAENBBRWO9GSSQoOv1b0W9dA4ibHqdec3GeUEPXJOiFXKsnIT/649HAs
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 05:10:12.3964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d640bbb-5b6a-4f27-a78b-08d5e87eeb74
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MEMCPY capability for imx-sdma driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index e3d5e73..ef50f2c 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -342,6 +342,7 @@ struct sdma_desc {
  * @pc_from_device:	script address for those device_2_memory
  * @pc_to_device:	script address for those memory_2_device
  * @device_to_device:	script address for those device_2_device
+ * @pc_to_pc:		script address for those memory_2_memory
  * @flags:		loop mode or not
  * @per_address:	peripheral source or destination address in common case
  *                      destination address in p_2_p case
@@ -367,6 +368,7 @@ struct sdma_channel {
 	enum dma_slave_buswidth		word_size;
 	unsigned int			pc_from_device, pc_to_device;
 	unsigned int			device_to_device;
+	unsigned int                    pc_to_pc;
 	unsigned long			flags;
 	dma_addr_t			per_address, per_address2;
 	unsigned long			event_mask[2];
@@ -869,14 +871,16 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	 * These are needed once we start to support transfers between
 	 * two peripherals or memory-to-memory transfers
 	 */
-	int per_2_per = 0;
+	int per_2_per = 0, emi_2_emi = 0;
 
 	sdmac->pc_from_device = 0;
 	sdmac->pc_to_device = 0;
 	sdmac->device_to_device = 0;
+	sdmac->pc_to_pc = 0;
 
 	switch (peripheral_type) {
 	case IMX_DMATYPE_MEMORY:
+		emi_2_emi = sdma->script_addrs->ap_2_ap_addr;
 		break;
 	case IMX_DMATYPE_DSP:
 		emi_2_per = sdma->script_addrs->bp_2_ap_addr;
@@ -949,6 +953,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 	sdmac->pc_from_device = per_2_emi;
 	sdmac->pc_to_device = emi_2_per;
 	sdmac->device_to_device = per_2_per;
+	sdmac->pc_to_pc = emi_2_emi;
 }
 
 static int sdma_load_context(struct sdma_channel *sdmac)
@@ -965,6 +970,8 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
 		load_address = sdmac->device_to_device;
+	else if (sdmac->direction == DMA_MEM_TO_MEM)
+		load_address = sdmac->pc_to_pc;
 	else
 		load_address = sdmac->pc_to_device;
 
@@ -1214,10 +1221,28 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct imx_dma_data *data = chan->private;
+	struct imx_dma_data mem_data;
 	int prio, ret;
 
-	if (!data)
-		return -EINVAL;
+	/*
+	 * MEMCPY may never setup chan->private by filter function such as
+	 * dmatest, thus create 'struct imx_dma_data mem_data' for this case.
+	 * Please note in any other slave case, you have to setup chan->private
+	 * with 'struct imx_dma_data' in your own filter function if you want to
+	 * request dma channel by dma_request_channel() rather than
+	 * dma_request_slave_channel(). Othwise, 'MEMCPY in case?' will appear
+	 * to warn you to correct your filter function.
+	 */
+	if (!data) {
+		dev_dbg(sdmac->sdma->dev, "MEMCPY in case?\n");
+		mem_data.priority = 2;
+		mem_data.peripheral_type = IMX_DMATYPE_MEMORY;
+		mem_data.dma_request = 0;
+		mem_data.dma_request2 = 0;
+		data = &mem_data;
+
+		sdma_get_pc(sdmac, IMX_DMATYPE_MEMORY);
+	}
 
 	switch (data->priority) {
 	case DMA_PRIO_HIGH:
@@ -1307,6 +1332,10 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	if (sdma_alloc_bd(desc))
 		goto err_desc_out;
 
+	/* No slave_config called in MEMCPY case, so do here */
+	if (direction == DMA_MEM_TO_MEM)
+		sdma_config_ownership(sdmac, false, true, false);
+
 	if (sdma_load_context(sdmac))
 		goto err_desc_out;
 
@@ -1318,6 +1347,63 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor *sdma_prep_memcpy(
+		struct dma_chan *chan, dma_addr_t dma_dst,
+		dma_addr_t dma_src, size_t len, unsigned long flags)
+{
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_engine *sdma = sdmac->sdma;
+	int channel = sdmac->channel;
+	size_t count;
+	int i = 0, param;
+	struct sdma_buffer_descriptor *bd;
+	struct sdma_desc *desc;
+
+	if (!chan || !len)
+		return NULL;
+
+	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu, channel=%d.\n",
+		&dma_src, &dma_dst, len, channel);
+
+	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM,
+					len / SDMA_BD_MAX_CNT + 1);
+	if (!desc)
+		return NULL;
+
+	do {
+		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
+		bd = &desc->bd[i];
+		bd->buffer_addr = dma_src;
+		bd->ext_buffer_addr = dma_dst;
+		bd->mode.count = count;
+		desc->chn_count += count;
+		/* align with sdma->dma_device.copy_align: 4bytes */
+		bd->mode.command = 0;
+
+		dma_src += count;
+		dma_dst += count;
+		len -= count;
+		i++;
+
+		param = BD_DONE | BD_EXTD | BD_CONT;
+		/* last bd */
+		if (!len) {
+			param |= BD_INTR;
+			param |= BD_LAST;
+			param &= ~BD_CONT;
+		}
+
+		dev_dbg(sdma->dev, "entry %d: count: %zd dma: 0x%x %s%s\n",
+				i, count, bd->buffer_addr,
+				param & BD_WRAP ? "wrap" : "",
+				param & BD_INTR ? " intr" : "");
+
+		bd->mode.status = param;
+	} while (len);
+
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+}
+
 static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -1903,6 +1989,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
+	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
 
 	INIT_LIST_HEAD(&sdma->dma_device.channels);
 	/* Initialize channel parameters */
@@ -1969,8 +2056,10 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;
 	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	sdma->dma_device.device_prep_dma_memcpy = sdma_prep_memcpy;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
 	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
+	sdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
 	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
 
 	platform_set_drvdata(pdev, sdma);
-- 
2.7.4

