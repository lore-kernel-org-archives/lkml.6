Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BC0BDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC39208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SjosMnhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC39208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeFNFg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:36:57 -0400
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:37120
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752664AbeFNFgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcLSFeggHVq6Eh0NyeOnnk1Sm4Eq+ynj/vQFhgKFka4=;
 b=SjosMnhs6UMDuUQfwq3JTpcE4VSE/v5uqriJ0N2nhMUnp94gbB81mnSQteqfS4dVSeoP70qASA3K3r80UEvV+LY33V0lo+mM1AiUOyuxACVoqJEOPzSo3CO30SetvBpwP/mw/k4URlx+T2Sa0Bg0Jb15T2s27ygRT4sHiGFZCnE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3222.eurprd04.prod.outlook.com (2603:10a6:6:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 14 Jun 2018 05:36:44 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v4 4/7] dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct sdma_channel'
Date:   Thu, 14 Jun 2018 21:35:34 +0800
Message-Id: <1528983337-2726-5-git-send-email-yibin.gong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5851083f-3a49-453e-5aee-08d5d1b8d223
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3222;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;3:QyoV84g1oO+UhYxeZ3ieWc5iF1nlcxxNFVtD8XcJCNLjlBnJgJ9B/gk47BUX2Z9eHB6WOqRziAyNwol6nk3GvMgylisSX21IEcdQ5oUm1fM81HhMjMwlqFpwiIA+8InZyHbApcoR0HDf5vQDDygVk9AG78LZXURHzPfChmDJDqFi2Ivh1ZSWVZsfJs5MBZczdwweAPfjQps3Iu3qSUJLIb2UmgJqX4ljtnfpOjns/DBiq9AVr7YX1omHOhuLi2A6;25:wkax4cENEiDHLmQ1/vW5HlnfXvIk9neosfCrUvxK0bMoIBuEea3Y8n9ZBE/v5g2Ds+ZZsmqGesuhbJ0DePySDv+8+FGh+L8o5Z58PzXkR9GozHmgXEQ9OZPkYxViaTJYBT7r2pQCCEeMDV5C4DKokxlGT0kQrb0WyLRL5ES7FjgkU+yUWX0OjsnK71U4x781G1KlpefbwyLQZt9Xv0I+WkAzOhc3QA0Ymnh6GI4yFGtIG9n8b2u/ToO1paayrsAS3UJqdS7Mep58ljKB8CNNoYRXBTYG2iFEv9yS4BSQWk7ytgTIb2GcA7Ldtv64h7PhYNgMsPe7ZBZqSbis+o8XtA==;31:G7feFiHsip/+Gyj/X/O5C12gtNFylWs7T8dLkOEv7nUEhlIoUnv7OstmsFzP88NhHnmlfnOvUjh2FQzYuA9meJSn+qIg+Ki41blminCUypWBqnEg7sqHhbQOuYIILhnIX4oNq4XTYt8jVwm80hJqmx/STCWkRBAZ5ddUVIjdoXp39u3Tb4VoZpW4B6V6w9ZVQuKvdV44kK8zTtCI4cAynpRxO4voqNS7kjzbTBaAZZc=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3222:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;20:zqr5qXsDPdoL1NWOQn+N3mUvuhAz5Dfj01XapFsDxnw3eAJyAde8yjK1jOdguE/Jpnk+at+dalVHMJE/9rbsMgIbRbKfwHNndaHwVx3kGCXh3FTyp3IE36mgL6z/kgOOKWoP0GKXui3mRMKRl79LXKV9DOizu5Uw9elpcEiLxsBXLVYEh9VK9mSxwHquKD5a0elxu8opLKSNu3BIZLDay3DzrhREX1ftPQ7oeuhrEScmz3IDLeaFkKWUEp0eerknzO1ee8TYgGW9ZRXsvQ7pCSXwzpNly8xQXTtIJfMT3NAxhMNN8tXXFUiVcMT/7YugUpegtudCCk/0/AVhDejs+N6yZ9FNT/LW8qEb8oFnCuEaS7MlUVsUvKUn6fhYCE1d2SGoX9b65te3JMD+1WCYftP41UailwZwGr/UinTlaLzcjxeIgJ1QweIjl4AVkWy76tUi08I0MPHItG2OTMiF0e0a2Q3JXNJnq6Q7mVSJpa0E2r/jFQ8jpru6ZWqpLI09;4:6TxPQpG1GDr2yfJ+WzdSYv2wMl/3XPvdr2EJtThh8PzbuaszLBdrNogUE0ptEf1uXP7m7fQzfo/THSW3Wl1HNpydbV1EuTgWX+0MOzVwGXb+v24lMOKjQMKb/t+KVwAu7zg524o8RqqKmOfg8YuiiQJBvqgUc21QLupNZ5FJ/aDjnrQ89diB3Fj/m8K3FJ+sTmqWYFvfIL/mdv8W6bS/91x3NW0lSk+pcVGjUFB7v6vdhIy2i4ZS77NdUAx4M4p9yOZQg4qRkV92yPxixcasC4BdYgMx1eoZzEeHUQ1xpk3bOJaCXpNzXfNrizdx4OSL
X-Microsoft-Antispam-PRVS: <DB6PR04MB3222921A6C308E8AD825974F897D0@DB6PR04MB3222.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3222;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3222;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(476003)(6486002)(11346002)(86362001)(16586007)(6666003)(50466002)(48376002)(446003)(25786009)(66066001)(305945005)(956004)(47776003)(97736004)(2616005)(59450400001)(52116002)(51416003)(76176011)(6506007)(386003)(16526019)(486006)(186003)(105586002)(106356001)(36756003)(81156014)(68736007)(3846002)(6116002)(478600001)(53936002)(26005)(6512007)(81166006)(8936002)(2906002)(316002)(8676002)(5660300001)(4326008)(7736002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3222;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3222;23:k3/5CgWQDP+yd8/EGIWxv0j5fOwQ6ckfR/XLc60hR?=
 =?us-ascii?Q?XlNLtgwNDHfS+STbFUm0KsDUz+KggeHhuzwgagfE4fNY9CM0MvIUrtvCbGub?=
 =?us-ascii?Q?iDmykGqW+YQCYvn4T5msNum2qnvvvtLe8eP/O34NgJ92PffeefoplmXYwqwH?=
 =?us-ascii?Q?wKeGQP/C/HpfFbVboabkMj+H3oqr/pwuep3wx5xYudFSfg5u9Pu8i9+Uqows?=
 =?us-ascii?Q?33BkOUzc0VhwiI5ZksupelC+121aTsnjBNGuUAmHcFOgNFcexmke0ID/+xK1?=
 =?us-ascii?Q?cibfsKl9sA2Pa1Dw2F/HbNMqm+i5Hdnm0m90hI6TLOvSd9qqnE9JGra2i8Oi?=
 =?us-ascii?Q?ltYvysOhBshdaghEcsJXDL5UKHVffLYDg3mkmiFLAGT1E8DZGqZtIrFyPytA?=
 =?us-ascii?Q?iLXTyHp7LVtWoNMhIwlO2f5cs6f8N88Ar9pifs6gLMWncCmoi0xzevR4PKS4?=
 =?us-ascii?Q?FMVk1E+m8sDzPaSKfsPSGlsVL4Hymr/4XYJmiA8lx/HpPgHIKFNOqLmQxycO?=
 =?us-ascii?Q?sIPSPWrND2tLjpmyURIeGBQHz+L3PQYx90MI7gVve0Ee0YBLkIJ6HZRw4Ko9?=
 =?us-ascii?Q?d7tHyBhgDz+1yifCP+mudikMURU+dNm0pmwdCQHT8gAffohKFYbuOPudWNiJ?=
 =?us-ascii?Q?OhoZi1I4UkEii3wi6bcBQbJc/o2P24oFBF+erxF0IApvfdLH8nxd0kpFBw/7?=
 =?us-ascii?Q?+uQVssFHu0RZI6z7NkMh8Jefo18kC4E41+1fviKwzI/GdRkHoIj8MwHp1+Vl?=
 =?us-ascii?Q?g4C8om2dhspy3MVQp/0+zWaQb1OVFRC2N8Cr7W8kTFS20DL0E7QjJYEG8HRU?=
 =?us-ascii?Q?GwN1kktNzUCO1gLZdTzx6Pgc9uTKO2UxAoLubbXem8IAmitID03Og2WUQQvY?=
 =?us-ascii?Q?OxiWRLCPaWl1MEzeORLjQFBGgDiTdO/kVWV9QTApFriLZ8HibsAM9Ppp4TNo?=
 =?us-ascii?Q?TCt5hW5LUnW6SPHzpz4YtXl4ylrQM8Vs2uVviZ58J4jh1//l5BAvxfK1nd3o?=
 =?us-ascii?Q?8K6hDlmU0fA7AL9u8c0HrbhJHvP7TqH1bNIz3Rvnuu1iJI/csyVwi+e7Bd6M?=
 =?us-ascii?Q?mznA12cDc2fF97I/IYmr06taCCK50JXka0awvcfFp1FjMTKt5Z+4KPZFuMlZ?=
 =?us-ascii?Q?I4Hm04FC+emlhSEbGg4FPFEmuU+kA4B1Lob3xJowTaPc52mhQ4NLm1CbwBqY?=
 =?us-ascii?Q?2dSJ7FiVc+NY/c=3D?=
X-Microsoft-Antispam-Message-Info: 5BiCHqC+ikVfHt1++W70mvTuWkyZNFkrwUMREtq5bK5TKQbHHvosAuYrKEfoSrUkLgZPrURjq+lQ3iYa0IswjtwaI8PJpsO1174M+yC0CncBXBlegnyFU/9u58krr56p8oPs/rFQWnVcStd6dhHKLH1B6nEOXkBOYg1W8yNEjP4CRFpvkCmJDhy3eoJpfngQ
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;6:fZGD/5QHL/zo7l5KubF09+U8WL2cGX5xNnQCYEBw1kHsm/o4k74r1iNrZ17TwvqVn807BdklYicOJt8SWboBdTkN7761XwTfvRWH1iltoH+sLZLoBtRjQ8Imq6/ZYcLmMxEDOTrJRLc0FTGGdbSJK01OjijXU4bYorWDbUGSe5/6mo7xdfkrq6HL3u+vxirTP6yQ1dyZLmtOQ/aCFAAUVw/g0IKzmzaLbNiPb1mOPnWFZqtGBhAOwzfOPPwBqXpKd6o/zpBDl10qqzDtU8tno5HjNgqXCJ6l701vuuNtxiBtybX92J5FgXjWABpEw7/zhrM5TUIJ8Cwdgl+HlAWrcejo8mPutbvJ01o462Ei4wsIrUSWuELWUd8yF26f/0V2A6MVoQpxva7fXsGwAbXZz8Y75cRgY+3zHWXsrw9fPbTFnVoNHpMCltmp6UoWs3s8DIYimCtPRisIeYcgYH1iQw==;5:ebBqKTAC7jHhsMJ2lAxjmQXlyFAMfWqN6RZXLbsV6GGv7JQXE4cBtaBqTxF975NcleKn8B1Rw0Kya2agmj35H+OlS+JihqtoY3OY9l4kUNR39jyvLJ65FepXUxJEi63XbP5Jjt/imxL4CK3w0wXzQJVJH3kgKR639AKTCprydhQ=;24:k5m+laMoNBrJq5Dow1j9wjvWgE7x59gBfcdog47f/LedlzZ50bUy7WlDUoBYMJTRHOIs0WMKmqmGwTF0hdpiSFR5NPFGVV2/BujTHTXEies=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;7:zjn48ycl9PzkAU8KS/WvZQwSgJdG6udTNdXn30GCByZffOKVzfgIjkx1DeQ0n8KEFBYBmxm7WdGoDiBDYQBvTJEAldvUIfUAuBn4so2v/of9RK8VRZuVA/z7fXRReJEBf288IN+4NtuYBASa2rmdtcqdEx77zKWfRt6kwr28Azaxhsa8hbKH2OGIRzc2Uz6PkSE7lL5CEkpl7Nz1D1OCfwPHSaE1NXCN7VBfiF/5uQW42rvg74DXYu7RtD0qsEji
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 05:36:44.1731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5851083f-3a49-453e-5aee-08d5d1b8d223
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'sdmac->vc.lock' and 'sdmac->desc' can be used as 'lock' and
'enabled' in 'struct sdma_channel sdmac', remove them.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 719bf9f..27b76eb 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -349,10 +349,8 @@ struct sdma_channel {
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
-	spinlock_t			lock;
 	enum dma_status			status;
 	struct imx_dma_data		data;
-	bool				enabled;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -613,14 +611,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
 
 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
-	unsigned long flags;
-	struct sdma_channel *sdmac = &sdma->channel[channel];
-
 	writel(BIT(channel), sdma->regs + SDMA_H_START);
-
-	spin_lock_irqsave(&sdmac->lock, flags);
-	sdmac->enabled = true;
-	spin_unlock_irqrestore(&sdmac->lock, flags);
 }
 
 /*
@@ -738,14 +729,6 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	struct sdma_buffer_descriptor *bd;
 	int error = 0;
 	enum dma_status	old_status = sdmac->status;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sdmac->lock, flags);
-	if (!sdmac->enabled) {
-		spin_unlock_irqrestore(&sdmac->lock, flags);
-		return;
-	}
-	spin_unlock_irqrestore(&sdmac->lock, flags);
 
 	/*
 	 * loop mode. Iterate over descriptors, re-setup them and
@@ -1007,15 +990,10 @@ static int sdma_disable_channel(struct dma_chan *chan)
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 	int channel = sdmac->channel;
-	unsigned long flags;
 
 	writel_relaxed(BIT(channel), sdma->regs + SDMA_H_STATSTOP);
 	sdmac->status = DMA_ERROR;
 
-	spin_lock_irqsave(&sdmac->lock, flags);
-	sdmac->enabled = false;
-	spin_unlock_irqrestore(&sdmac->lock, flags);
-
 	return 0;
 }
 
@@ -1929,7 +1907,6 @@ static int sdma_probe(struct platform_device *pdev)
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
 		sdmac->sdma = sdma;
-		spin_lock_init(&sdmac->lock);
 
 		sdmac->channel = i;
 		sdmac->vc.desc_free = sdma_desc_free;
-- 
2.7.4

