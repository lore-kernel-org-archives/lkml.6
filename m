Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 36CB3C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65F9208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FsJxq0A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65F9208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeFNGFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:05:33 -0400
Received: from mail-ve1eur01on0052.outbound.protection.outlook.com ([104.47.1.52]:25664
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754551AbeFNGE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcLSFeggHVq6Eh0NyeOnnk1Sm4Eq+ynj/vQFhgKFka4=;
 b=FsJxq0A9UKtlpNs9jTi53h9ybr3a/ANLzcaOniKuwYJNZhih5RYBFpnmwbWj8Sj24dzgr17BUvkoCbto69waik7gzFEx00rRtVenuQ5dh+BT3v0gIseVyWMthqAn5PHwmi057CBXWV0p2MZ5i13KsQjvFVAy+mCFjkV+EqolUyY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3219.eurprd04.prod.outlook.com (2603:10a6:206:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 14 Jun 2018 06:04:20 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v4 4/7] dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct sdma_channel'
Date:   Thu, 14 Jun 2018 22:02:59 +0800
Message-Id: <1528984982-5074-5-git-send-email-yibin.gong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 860b4029-32ab-44ae-1b9b-08d5d1bcadc0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3219;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;3:ya1/ia4Alln64MdfLb6ysGF7jspwVbam/QdQfNG1WwCLm1yiOnbDgSDFl7LKkQ4lsdqvZctZrrxXzaGFLqG5xCy4mPTKhL0oCf+5wfiI0oAO55sFuoYb2DSrzQyKdvXS+6zQGN571fUu9lsHuu3figB3yMe6vUpt3K9MPlYvJqlJxLPsKkm80AEEnwHhQJRzn1wF6bxesjjm/WjWipymzfIvZx5Z28SuEAkU3jSMq8V/AkeK2haw7PDUSXSttAQo;25:9ZCMiArhP3U7lxL9J7/1qKfPqyFPAJpWqRTk39sgb1hv3qaQ2Dd9elGbgeKnjGM2hk4mXC4ahGOOK/qTV57DyB+1bATYquxpiwICZoL02tGNnfuqCXVW4oIBKXtyFe2Fr+jQReYtzZNQRK9pPmux+WWY+uUq1M++IGRuqKqesO+BF1SIas6eYUQ0CCUrEOdkr2UfwgG8sus3q3vBWter0oYhNKGF18gQ9WWfbxGvYEFUFuOEAlHwUNX6akHCyuaWwbA1ZSTwMrENW6Obd0Lx50VpG6YJysGJYl+ZcdQf64SqxFVA5zUyFVYA+mWWex5q7/HiZzdPZlYVDXdGUzUUrg==;31:3tbP/o+BtHrspsO/gR62w4db8eYMC3jxtYksvgwOB6yx5eXXFQ0qF4IAdyK/2+vJGfgmJgBYVkdgRBxS1VQ9gkIpkuE5YUl71hto9DdhkyEl1F08bA3+1Vi2OLUtgoUkb2OHKgkbyJIf5cpvt/OjX3ZBTLavJnILTSMiroFBBChiEISwhiOBUHRelPrRTaLLBDcS/u3Ha/QR9/3JQqDJY26ndOh0GeYuP1GbFMe+86c=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3219:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;20:cUfJOBiIiPPWcaug+YzK+4/sqSf8pUG8ZoaLxKknpyLYEQ9H4ivIqzph0Lpjo/8vvrP3OZIzX/Kus/cLvwSYOQJZE72XvbCpDDtl/r1o0lmBJ25UXpIyQ169bsmHHHMQkkaDehOD2dzkseWZGiLqAapfdXmY2/cXWnp2Y41xxabd2RTNJfz0G7/pDaS0wvb0Y+YuNDi4TZhtzsftZBBJQHPE1qoNuQvMZSZQn5bmJFKo2atf+UgEnkPyGPW7mQzzZ7y3r7+4eqSzcpuaiXpXuIHWDYOcsf/Zr6OPyQw9Iy+VAuWTWWNKdQPt0FpamqwyH0WfofCfLfDKR8Wy3k6+uMnlfDJYmc+/BKNSDlLUI2cNDla6UI7rSSp0IKWUoP2ofMDWxZVLdnvJ+qbcxBeqLEels0zI3qoBRgqD+cIrgR6VXUifZKSvFL+7yOdG7vlJ6YHAZiniu+4USbw2LJGKHklPRzGKgEd9BVJSkFuhpjHTedNSMp3UcC8Zw+OKqCPI;4:+dRw5edz9R69iE+RuSmziFnC4ByahcesIi1P0RHEhfqC5cd9+QdzAom5FEVQnYw/3zmYz2RQh5gNvZDpNG2RuIoc79ikFarIQnoYB5Hs0KVeHAx+mEkkEuBMwY2QKD0xipC6CxKWfUY1J89DSbap/Z6L85jtGHjFEJRRLtv3E41gA5RtngQWZeq5yWNucQCFo21mLXmAlNOZy/ebSwUvvDm6W5OsBwYS33zqG3oJ/jErMrREB00GqnwiTLVWxB4kovgxrI22hMoO8Jrp1N56dNf7K6tubkKQPbt8SxR+VFGFmTdKDLIyfOx+UCO5wHmf
X-Microsoft-Antispam-PRVS: <AM5PR04MB3219228F7B9AC2033031125F897D0@AM5PR04MB3219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3219;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3219;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39380400002)(39860400002)(199004)(189003)(68736007)(59450400001)(478600001)(7736002)(8936002)(305945005)(66066001)(50226002)(7416002)(86362001)(6512007)(3846002)(6116002)(47776003)(316002)(16586007)(8676002)(81166006)(16526019)(26005)(186003)(81156014)(386003)(6506007)(2906002)(52116002)(76176011)(51416003)(36756003)(6486002)(5660300001)(4326008)(50466002)(106356001)(25786009)(48376002)(105586002)(97736004)(6666003)(446003)(486006)(476003)(53936002)(2616005)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3219;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3219;23:99UAtZiFbIO9Qo44ZyYQd0BgNqrZt4D8PkT0pprmp?=
 =?us-ascii?Q?SwDU53bnbMYM+zOwBuecg5WoCAlZqMzR+gonWVHcE+bB76uz++2MyzuX9gcV?=
 =?us-ascii?Q?kU2l/+FeAtV12F3En+k3GXZgMAe4iJFjJaK50nXZTvTgBE5JPkSzyH5XupYe?=
 =?us-ascii?Q?DdZTm0PFG0/Q3ZQhZSwwL7L/Ni20vw7Di/kF7Bn+cKFUaAsSRUQQ7t4ehot4?=
 =?us-ascii?Q?xses9jR/cldYNzpvy0Nxd+EHa14Hk9gs+HX7k0oz0cFtxTpAg1cT3HVbUajA?=
 =?us-ascii?Q?9ZrkOHp9i5cH7Mw5M7WW42AMtmmkoh7gkCLwN4iAMoQFWBom1rXxYSGHndGO?=
 =?us-ascii?Q?vxpoeM3vALs9TA31qW7V7qVugTXTNELJuBecSbJecDie38lv0Dpqw9UAxVSE?=
 =?us-ascii?Q?2nQ6bdT2rO1/832J9SaAPIbvZKMT6Qz3YirxL2tFEo1b9kvp+g/UkKk0OkEM?=
 =?us-ascii?Q?eSyAJY56zqvtYwquR6W3bW8DUahBUlkEL2sQVhCUNKNm1YdQG/D+ra+jtggC?=
 =?us-ascii?Q?nprxyZBhOI/FKNyX5QrY8LYdQBsccyanw9/30rgxfuVl30u+DX00+0a0doS+?=
 =?us-ascii?Q?iPliR6YBNbhjsI/EDkDayJLHVeSjS6QV+s3KnUlEJlKhH9lRqVFHoYAA3P3i?=
 =?us-ascii?Q?HLdmrsuemhtSYhnGCZ8FO26bumtSOH/fc2RoGQgF+4SEvcJ8pzIjCLZrU5Jv?=
 =?us-ascii?Q?ieGYqEHadk0fQBOUPOSepl6bZawuOQT2IF0/R1sJpK587NMDubboppGsf2pX?=
 =?us-ascii?Q?f6diaJ9nxMSWJ6RoDxablEqqXVL3Lcd9+Kygqa3lhOYN7loildCUlTJMriTq?=
 =?us-ascii?Q?8RTXV3h61trB7rfEfHTwiajBHFCtSHoZx4V/pXDGR56Rb2ujTVuywCjM1t/2?=
 =?us-ascii?Q?d+u8ev1iPnkJA7hCbQR6BGA7v8kBFwf+noza/5iGu5VpcSEnzS0i6zBvDG0c?=
 =?us-ascii?Q?LY45uT6dTthuzOvVg3hhj6RXeXHTfYqtjV7GbAx9l7ZT9faTtUB0zB3nAwaK?=
 =?us-ascii?Q?4jWLalBBvt3SMyazTlrKa53HYgBHB3OlWZklF1RUa7tFz2Xqt7mfUJLRyqWg?=
 =?us-ascii?Q?FXLmHCehi/M4U9xOzzarU1cSzFHCSVagSDBGPhyqVp2DdyxZVGAkm2w3CzTS?=
 =?us-ascii?Q?3Q5e7icepWbi8CC0p/+thl9WaPYEjW36VN6qZsdWt/oTAUc5wE+q16EcGds9?=
 =?us-ascii?Q?+HyfPWiFgetGh8bcVbmxdGB6FnOagL1shfK?=
X-Microsoft-Antispam-Message-Info: arj1IGG2KybRl5z+W8371gK+u6Cocx3xNWYlnybe8v+OVF3sxsJQY7yE3IvzD+sH96ufCH092QMfpttEBiye3HqwAu03JnvSFgLH6hAmdb98vRuLPXG8A7cLihCfMNtQURXZDIOMS2FI5J2sxTYwM8D7R9+BdneLLxPoeYgTMEqQ5ZVbnaAbijCldMHJKGQn
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;6:Snq3oEXILDkHHM3IeB0F26TC5qzFFZoiekZssvFmXwO812ieY3lACxl36Oq3MsS7+YQS+hKFFdpMWHlzcSddcKPpcZXbLKytEBvJib1VWjdSIow4cUeDcWq01o9UXg8UC0sbQ4S/FJxpizJNt5w07T6C6YsFdR+/0kqXBMSS81HbOUXry64FGakIFSMgQOTUQefol+mL1vvkpXlDkavUB9zuRO47m/pK/TZ+5YyP0WAE56//cWCp3/Gnzy0BPBYWUMGsJzbUTPu+pPCBZWqXcTXFIppE8EYsOsKdvpGW6IxvMzSUk5fad4lcJP6A6zJG7l9pW/VIYwsLlW7eDnKhxtwSOIaa8p2b759BiD4dEi5dKrHHQmr/wNaEl3Z2HDiLJrtwSG8SsoazTR3IFtLMw/sVfX/z6XPCcKgzXSoIgG0HNMEMi8omPC4IHZ+Wq15nxH4QNQZld0aLwTbqw0OlXA==;5:4qYdDcLeBF693joEwKf0mEEtwQYT2wKs3ut89oKVaNIltKdHeK7xPq4yx24DWsUZNA7eshTNr/O2rG0UeOnT9ZSt26BqOwV6ObF8NOlLqS92mdxdw5nzpAxNTu62NxGVaLy+7opVyxuwdwDHAykBkTejZMlQK3OAiyGU5Vcqgw0=;24:W0Jc67EJ6Yr3zF6xpmgBM0EX+5Iu6ljGsKugOQlxsVTmwhVQLdLQ2pMMAyUsJrGvRwTpXnlSSyviqtsob+inFgJD12m9sz/b8maa4BFl010=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;7:mrZbVQTerTszV1nScZpsqqXXQC64Us07mkZ+BBt1TUZmVOUqW2O410C5tDj77RCp0v4+NV9G8PwEwlqCYFPqx0ZKNIfH9ijLL95NV9UGnoVd1eFC+86zv4lDmftors73yzx3xK/iyyBLlq/NUgSV6SWpjfUJGl0p0/cxOROHV5glfzhEhJ/Tw0g4ldYQALPYb29WBJ6Qw1VzRNSxD9vMq9HUqwSFmOT24vez9znGf6uR6aFrpvUYpHxp0Z7yONBU
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 06:04:20.9075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860b4029-32ab-44ae-1b9b-08d5d1bcadc0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3219
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

