Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 884F1C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2867D208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8ma58c6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2867D208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbeFNGEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:04:36 -0400
Received: from mail-he1eur01on0044.outbound.protection.outlook.com ([104.47.0.44]:7680
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754618AbeFNGEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzXj5DspRIP00rNRShWIPH0cgSdGIn/3XWRtqDe1EZk=;
 b=f8ma58c6eBMgoWtnxskZ0Y5w2qF+fXnY9NnZIkCc/I6cGTE5mcFPJ4b1++S+Zsg8w+2dBU0cWo7BK/GTtZM9otRnjhVAACRB4FSvqizjREU5b7T5XkVArHy2Y+ElMkCwGyFST92I2z5121wDOklgkypn6XreL5+1xFHBMXmcnrU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3219.eurprd04.prod.outlook.com (2603:10a6:206:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 14 Jun 2018 06:04:24 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v4 5/7] dmaengine: imx-sdma: remove the maximum limitation for bd numbers
Date:   Thu, 14 Jun 2018 22:03:00 +0800
Message-Id: <1528984982-5074-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
References: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:203:2e::26) To AM5PR04MB3219.eurprd04.prod.outlook.com
 (2603:10a6:206:7::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c97dee5-756c-488a-a236-08d5d1bcaffd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3219;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;3:1Yv/eT4WdQQOGkfWjQi/7Oxlmvq0bSzFnEMvsqd0kfE1IlWuH3YR7b5ufN/AVlnfFhCUPMWGZ2b5zvGRo9K/GNqSbg5S5XZya/UXCQ0sCOczR1oxy0MFSYYtd0ZZ+ZcpdIOm/OIR/K4T7/GjtufcP8/P7dr/vesLD10AQijN5TPOdNRnczopHvGPsHTBtKFUX18QOHddC5Htu5XS9YGKRGFu+4w3PC5rIDXU59sgzCfnE4I61Q7QUNAuME/UPe+I;25:Ya3jHtB6PMJEyE7zfMqOG21OEpHY8zkfxhPaviT2YgbWMwksNEm7xuHKYYnXzxf322+LVswZFPaHf/YDJ1OH2bSLbjA/kJ1qCHMGt0rVsEuGV8EGWm211n/nVHgCFbcUpon+ueWXfQa3eNUBvcjbF7fsdOZFwAItp1zCHBIWRH/S4WFUaUGFrFb0mRZJ/KzZYp0I6SBnDQzA90to/YBhtDG553dwBkHvx19ZGlujhW95i17jRLobYSJ6FEliUqVSMaYLUmCRkGWRIU3+VbZ1pAkigV7MbCbOPZ+0uaLXUzkvkcfVB5AXpG2N/tPO4ys4n5I68z2Gs8+/N1NEkOEkoA==;31:ak72Vj9E6r92cjKgJVzjDHtQKxybknScTjSqloOM57gZrGkG53TWqILVIVkHUzmFsGNRDxmf8QHi1SmOeMzahQtguihapIelEKtCIGYGpHwEa+G44jeqKs30aSJo3uU2ddj5yFls3KGhS+N5D/fK4OpwE4Jt/RwrMdzPMKY9gKv8XdRE8s7+ziLHFrtDRJk/X9XUZ44o4y50H2p0EGE7xdXJsM7eScfgosBdCdmrieE=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3219:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;20:QqWbf3yj0vKk0u9k4NDJQ0X9rYYEuqm6Q68yIxE1E2Nez5dd8S4Ck+qFlyv9wCR3SXZpIwO718uI7ZaKDgvcaEhWsjouYgzgchI0n3lG+1mgrVh4rcVOVitujJCb1D4YuI8BSDiFjoeOK43f5knbyKwL9LvbmDrceB8sFxufVPJcfH57dNxoPdgn4+BUWLHORyi92KHCgsXsBjhXvkChxYEUyeUoNpE/dAPuvcR1RYBTBBhASmP+/ibniS7xOAI0MKJWret+rk1QIsli4LPeRP1plmUmXJVvo73KDkIrZzE0ft4hqq1icaGLimT2qUA03jjNitX0wWwh858aKHatWY+usXnY/F7ULINowc5HUswX5qt5LHO7enZQpnccLwmOg2qJV+bqI2ptgEVVhittwBZ/Hcxns2w+OalCgrlQpas+gWxc75+SPAgqhCbZQVzZ7K2QvYBcG4a18+9aK4X2yewlqIYNuWzRWtEI0pg/MOL65fGwPFRbuDZPPiI4lOhe;4:T5yAN7XYd4Cz3b4oDngZBacc7h4DRU4VldAJ6FjsW9f/aziMteYsHRdYf2BDRGMEv6+EgjOtrI8JEB+O0c17B5/APh0+ey4WSZD2JX/BjUVQ7NwdNidUCXTIb260O+1QQju+Qf/KXxEpPyEmwktO/fE+ec1BNmQ58hjRSlpDbBE03T8CdsBW7fHj3utMrZqPfD4fpjPb+KhHQsH+w9rxXBcXdVtxCcYdXyh9X+z3d+lNT3ca3JNneu7+3L49EnrolnPNfKc04XIk5m9nVu9nZGhk5KDi1wkfSvfpWgfpAa+1dbfDI9GRUBZaRO6fnvKn
X-Microsoft-Antispam-PRVS: <AM5PR04MB3219A58197B708CA06BC250E897D0@AM5PR04MB3219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3219;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3219;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39380400002)(39860400002)(199004)(189003)(68736007)(478600001)(7736002)(8936002)(305945005)(66066001)(50226002)(7416002)(86362001)(6512007)(3846002)(6116002)(47776003)(316002)(16586007)(8676002)(81166006)(16526019)(26005)(186003)(81156014)(386003)(6506007)(2906002)(52116002)(76176011)(51416003)(36756003)(6486002)(5660300001)(4326008)(50466002)(106356001)(25786009)(48376002)(105586002)(97736004)(6666003)(446003)(486006)(476003)(53936002)(2616005)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3219;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3219;23:K6ujktFAylohkZFlRmv/GUN5AiQUHN3gu2uKHc4Pg?=
 =?us-ascii?Q?SFKbAToqNxMPLLmRewJr9cvI7gyHhag6peuOkIvL9DmcYmYsPMWruLXgPAbD?=
 =?us-ascii?Q?pZkWM4EUygG+fa9PPtVKkcFcCiRDIwTt79KHUiSz7NIGgVWc7w8nl8uFQwbY?=
 =?us-ascii?Q?guNJF2PvXEyvrUaj9kabwQWon06kfgtTHNcZm9n2au2DOMt0rXr/Bc9ELa1M?=
 =?us-ascii?Q?TZ42gBhQ7F8sc6vS72qcsOaqt7ZJIXX0Clefgx2MZ9YETqdT104rA8B3cBWC?=
 =?us-ascii?Q?R/Pre3ekc9neUyY5lXwUfDCKool3gGSqbhJDZphBYqvCEaF8k0mp80kKsC8z?=
 =?us-ascii?Q?pxcsagkZvdzkuVnCaeUv7z53OGtQK3+pWqltWAZZGbNYPBWuIc2SJwVzKUbP?=
 =?us-ascii?Q?Ltt8boowEk5dou3Vz69rCAot+E3SSZSH6wzzkcB839hskEai/RvBoe0PLb4B?=
 =?us-ascii?Q?5qT3OcFA+Qh2IdM9uiAlAQYlF+1KVr3IA5bC/4EJ6A8kmNwx3Ypxg9tHKoqr?=
 =?us-ascii?Q?Uf5BRorFtlCoEjxsUT7jWzQ6oSUGMrYGC3pTOjGT55vR9BNNKI+7IQ1M4XhB?=
 =?us-ascii?Q?v4xogE0Q9FEnZ3JbQ/aNpHrG2EihHLCyFILBmu2d2PQdQOX5PwOzy7kOiMm0?=
 =?us-ascii?Q?CH3UCMWdYdsVuQdD26eACzHyiC+KX9xgKcuiiGB7xwTwVT8ljlKgUi3YXSNG?=
 =?us-ascii?Q?hFN34ge84gGtrUq1gMxk3Oxgf/3tbW5saVU82vRVkqH/nbjA49bS2FM/DQ3K?=
 =?us-ascii?Q?bmJo8ORzQxuX2dYpywN5vTW8+VXEZY+8o8GeEdfNs1C72PiW5KWq9zhbYPIt?=
 =?us-ascii?Q?IcbtZRtpH/GyXqsIPzGmarkn5Tk5whND3KpGt1EMpI3EiOsvc+yBpz3bLrsf?=
 =?us-ascii?Q?dfkhusKwDwWwCnZGDPWpeyKS6yN+FXHEw43YJI2p2IKM8Ks/0N603WZp55VC?=
 =?us-ascii?Q?SrpgUXdCo+Pa40nwsA2YZUv7c7v9FjnxBRm38JQMOKnNiXNNHUJF4yqkEG+R?=
 =?us-ascii?Q?NwNhGEsE4vAVUNDZNoeUog0g5+WnZ2EsXhbYdNYwXwjXlXWh7vxa59BUqQoU?=
 =?us-ascii?Q?rQiK4+uh8Pt2EbAAAMgUJvHRk3U7LP4C85gPQ0r75som7ONzfVMV2c5q8dAx?=
 =?us-ascii?Q?1rGqmdRwedZXYGtH+7l2GdT3K8YMRHiMJO6LbE8kD/fRfZ2spuklkPWjo+9i?=
 =?us-ascii?Q?Yv/hqJdRCRWBpw=3D?=
X-Microsoft-Antispam-Message-Info: /udzgcGMjS/nUpDhSMzL+g8Hzo6bnoKpTLBx/23wSRpQy1iv3OoQsEBjuNSgIFbatrgMpaQX11fZP4mH2Ip+1Csl8jjz6XdUHtvgO7PDc6Kj/MEGMfTYKO313IJfu/vfWYxZhYBSHDFO328pHoogTau3DVD6MHKkzjQz1foRnWpwBT6e+wyUCtHz9lSLm2FM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;6:UM7rj+CJ4zufeeeiGkTx4hjo/mIx2Z2qngrI8tDfkJZU+SVlQXvkdqXu92UgqndDOnIxolW/2JPxvCiwu6hkNhFPUP5cmvu438oCzxKxbrFSoXNC3AjeM5VKJQgyqMSqS9GKAH8PCZXBOWvJCKahWUu9hV0JxBmfaZ9F0D39om61yRUEQganaLugqvGWe0VvmXw7gS62Rim0kM6vNxF8iv34R0Bz/qAeuEF1d4QyJSCq7YOh4tLGb+YFznPWaEXQXbhuBFmGX75TdDPpA/9QZD3nauQTmEpB09d9LJ3yBFu1WnCcWYSSY1A9tVtj09zgcCAMscSBAz+8yYipnsLUb4bhWu18g/lN1UhJvIqi4G6yFSl8WyjThvap8DZVEMxvPpPi8CA0WegbUDBbKGpcSyZPZjoWN8Ekv2cy/1dsSbYPaP7a8dRPnPGVTrP92cbBEj6A8kbZ7ngd0wacvhYUow==;5:nckzip0lmU+mQqjDTEzQtYWrB36gv3rszrHzWwX8tcsovl1elgc4fQ8lr4/IXL5zJuSd9Li+alOqFdSDWMC4poYX7H0R3kbbyMKJPbx5D01v77p0EB1xlxAw+eTFM3nuqJMt8M9iGdf1Bkl5xMJEDxjtHId8EHeAC8OuGKObwuU=;24:frYJUD2tg4lFT0u2HwemGkuoo0JRRFaxXNgaK5iuPKCry/fGCGx7LUUZCvp+bmYeIFRApOQR+OrqswkAutfmg2QDTqQAfEG+4BjZMWZCZIQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;7:vLPKGusHjYWuZFT/8KZBgikFxSh7qpYRUF0mRG83fcuPpXVhnPF8NQtsGlTPaAfOXDodOGbTTclSBMgc1H/UtwmeljmnvER6Dn1tLlQ7zIKFs0lvDpimM2JrC1CGZGDKUQ8ImcegX7+nFpiN/E8DpESO0AM44FZGMm7H+COHVFNkji+Pu/4tRXC5/wCk2tBawgZNTjD+OZbWW33hsfpntxRk1ohoQdxKMlK31fsNI6rQQvpCk4MJoU9V2tNCtGYB
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 06:04:24.6701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c97dee5-756c-488a-a236-08d5d1bcaffd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3219
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

