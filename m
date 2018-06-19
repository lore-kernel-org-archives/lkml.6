Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB93FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3F320874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cy7SEW40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3F320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937534AbeFSI6W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:58:22 -0400
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:3242
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937494AbeFSI6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKYPuBoPK0L6YvBUiBDXiYLweEyo3FJ2rbPsUvyPt68=;
 b=cy7SEW40G9WARYVOEcXBbeGRTRr7kRsrdBdPtBFb45PSnE3whLLkF1gAgvPy1b3c65VJu81TA3iQGeqQXC9n+wJsq7svx56/Wa9R248h/nbxhbGt3aJ+X/aHbFxsDD7kyWowYqTmWfxlaELGgAFkNmetcjzL9b25W+zt5ck5bBw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3231.eurprd04.prod.outlook.com (2603:10a6:802:6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 08:58:04 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v5 4/7] dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct sdma_channel'
Date:   Wed, 20 Jun 2018 00:57:01 +0800
Message-Id: <1529427424-12321-5-git-send-email-yibin.gong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77126f42-7a94-4a44-b09c-08d5d5c2c707
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3231;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;3:POL7+Ev13iYApj7OfHCDlTax9iORi3P/Jeai0/JRYbkEEwwVH84cqU2u3QjiPUiTvf2bVX4199NmuhsyfZItpd1lTLMcxBpcvEePFsILLWi6alsSmnYpPMGwqV0BeM+R5G163/XusbzzCWrKg41Zjsp2r6LjAVGMsXlrGJTlW+XFgUlv+kjCWciNo24WkaBr5vyHxS80BsK5GUk+kxbMWFKgX5+J70w6YTV04xGSNCN+hcTJ4gDWM4Fl/aOXzxYH;25:/w9HUmBoJSubP6eV88AGlR8e+48nkKFUdlNVjsGkCS93nbMsZw7VRZFhi+Rk9kEFY9kscDIzPhTmDSRcTZhOLujNxHFKcPGsKPLaT0w1m0lz+cHJwAu8LXU3GwcI6z1U8r03owaJ8kWvcL/n8IQgGR7OD3/hnOD17wl30TK7Lu6SbVh8M5jIcGH1n2zma8BIZjiaf+PoWYofZqcOGqelFf7jBSpWsFFSnD85IDqyQQGIQVgTsEyITRsipa0V4EnWHtPNqVsnwZ4JIBCer+TlgwdE1D+bsTVrCjE4k8GGn5ighMbyeZ/B5hArDS1j3/pSZV+eZ16KFO1ZlOabG3KaNg==;31:R2b8niKhPqzdFeS6g2k4O6E0yA0XslNqKZsUq77g+fqAM55+5N/Qpc2DbMsS9YdAWQSbmZRzYaW+GT0uT6oCulKEDp+HkCFwztrMqonIR3BW52/V3ozSKo2gtbMAouYhpv8oivSRWQpN0OG6xJ7POd5HggeJIvdZZ2qi1y+wzqO0A/IeSauAk3FjczESE+E9GRfwCuWjtmvPYOcqIZuIRzQdhBKmxAJDN8DvPiQ0yTg=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3231:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;20:Wl0w2BVIFM6/z5XeXr4VqdwWfTi1dlWeGAYIPq8RlENuUyW2lj/AWahSQfieZFnr/k+TrQMuqSBEEGsutU4eCq4UOQjTSdZANSJ2iwWyX/lcWrtNeVusGbplslspjnqATfisHgwxtXJ9h5/oBjjEZ1Dx50iDogZ2E5VrYDOsoPEIEECBiGfvATWw4Q3vK4BKiwT7hNovMFEGgq423PD3Do90TpafuZ6YbHarGIBYQSRebAdSMPeFAJU7KHRBHUOCKzPKWUzXZAhDQebda+GgPKHgwbK2JcIzfWl6LDfOfl0pPJxt+BaZMCOHGGShljUH3De3nb/asUEEn4voQijqPN5pnw5HcGfTLAjjhBLJsdjBqUtXymxt34yZnubWVK4L1IiFDboC6D0BBBQ9/tQelYSKFT3M06q0lZ3sLTFcbJ0uFghYUW7iJ9WqtD5yMXpbnpf9qJGYgUgio9UmYMzmDb+ifXXzNtk6SE4ll6hgy0kNZ8ZLe7/cdaBH4UcUedsZ;4:tB0IWz4KvPEE5blTxThf/WqvMUAjWZ3V1y+ftUJRXq8JC7XV5qzOqiqqO9RtKHLwfguDJDf0uHgR96oIwjRZ/gaXqYBuoY/4MCbrJPS4n9KDgg0rkyJ3Ch0f7FJnLSUx+edU6nQrIuToovqDyyTl1ry9LKZ5/e973lm0pVULcyZ6vxyzCOulcygeQE/8dkyNgrTtoB5mnW7wEbbFxt3yLBfkwLvKflrjaLA5HMtDyWHl4FcfIJNpKU4KdOR4sYnzEe+vhi8+4gI064TUf3IPVF2+taFRcxPc4zec9WbEn55swblWycj2sEBx5BOuaWMX
X-Microsoft-Antispam-PRVS: <VI1PR04MB32315281BF822C74ED0D093989700@VI1PR04MB3231.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3231;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3231;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(53936002)(6512007)(5660300001)(478600001)(386003)(6506007)(59450400001)(26005)(52116002)(4326008)(25786009)(97736004)(51416003)(76176011)(68736007)(47776003)(86362001)(66066001)(7416002)(6666003)(105586002)(36756003)(50466002)(6486002)(48376002)(106356001)(316002)(11346002)(446003)(476003)(186003)(16526019)(2616005)(956004)(486006)(81156014)(8936002)(2906002)(3846002)(305945005)(6116002)(50226002)(7736002)(8676002)(16586007)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3231;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3231;23:paEdhQ2s20eFH+D8c9/xotkd+/eMJv7TGLYFAt7v6?=
 =?us-ascii?Q?QcUEFcLdiUkdc2+MguMIHS/oo0jFM8krF+hTCj6VpVnkxfW0F/ryVD7RRtkZ?=
 =?us-ascii?Q?7pTgizYTGN6ssRBCqnDixMi8EjUwU1XvX74A673L30wxwLnRq1f1XyAyRJe+?=
 =?us-ascii?Q?zNe6vHTCywft0n/QS4S9HGnK09ov4R2mWlgOdrSSjPf9NWTR5yD0O3I2zxnX?=
 =?us-ascii?Q?/yO92ENZVhUsBfmZifF6miEAD1fWQKl2C/XBldDEBlHVg5RtTDi7A0LEOGz1?=
 =?us-ascii?Q?TOu6ANEu1ePK5Y6ZXZMF+woOrHkn6YXMnbv4aMHOYLocbFm5lGcSj/T66nne?=
 =?us-ascii?Q?n3TXjvYvq6nQ7ixoAaQzdO8qTDl3DadthcSiX5cwJVQJKJ4iD12dviVs8fql?=
 =?us-ascii?Q?QKTa6r37S20pk5W78P4RkJr0LY80hJDwwu8iGN2R8YHbecoPMcQlx4HD11Q7?=
 =?us-ascii?Q?LyPC2HxUu2XnfJ/kzBBLPkGhxSHjkv7DQSWpfdlxbGp96fGrtQukGq4yw3Qd?=
 =?us-ascii?Q?qrcmQfDuXEHVdMii2RoasBQx3sFdgjONzbb8HdkZTF5cxUb87NI2xFXYB/xp?=
 =?us-ascii?Q?vSMQbFDrfSIj9R384bUyqs0ESlDV+jgNBmkRfPmIPrejLcQFUxZypc9RiHO9?=
 =?us-ascii?Q?MmPFqbOu6F3cJ3e4V0HGdJNUYrO6RIaliaoWZVtwjk539mykpdLoAvtn1Xi2?=
 =?us-ascii?Q?2Iw1Wk71PTsqI8ykP/4YUizLrel4ddGQ3dA9WUpJ7VTRANQ76FKvoGrIi+kO?=
 =?us-ascii?Q?nZfhTiQ9ztzM6QeiycMiU+6O6/hxoSENYyYXEoBPLNjm9n63YNPKKiN+S51z?=
 =?us-ascii?Q?LMRj4wmeBWdUZ9NwSGqN9J9DheEG6Od/mKNyhuxDJuJShEVP9GJa1RYSWQsD?=
 =?us-ascii?Q?bztmGKVUgLB8DRj0a8R+WAbKYu7ugyhBoAfGhLqxOyLq6ZMJ1A5UiEB22f+W?=
 =?us-ascii?Q?tKzieYzsBrhf9Hdc1lyve47Hz7Duh0n7v6qCsJLNhPcJ3ef06ndt+iOlNUmu?=
 =?us-ascii?Q?3yNcX3MNyGgjoTTGesHsKppjIiifKDmavBm8ndBk9YBFUPrvknyNwSZrL/D/?=
 =?us-ascii?Q?mlUrYx49+VEwFGJhp42KXsgBkQM6tKCoks8fFoLbo6hsg/i2OxvWRRUps3b8?=
 =?us-ascii?Q?2F0J72bBArfjO8vvGMD/Bc1Wbl2hQ/UZOqrlcSnp9qu/WjTHz+fwdLGDlEX/?=
 =?us-ascii?Q?zTgEgu5ENhx/d51gi/MMVDzdDitlFTlDgdBJ8FMLtri8RTFvIZqmAatXHwP0?=
 =?us-ascii?Q?V+6M/9cDyJbLX6b/qT/qxPeVRHkRiu8sQFghu/nV2WJ1v6vFpVUuaEvrSjt/?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: 7SsVyQA+WMo3nJpF1LpKl+KYKr7uEIH43UREcIdzE4Zz21IhqRmXaw8pKGe4OG/H88nhUO9qcC28Y56JoAVQWmvlA0zu0O0Mwq/oTIypuud6aGHfZRmi4d9kDmwpQdbUvj80M/mC3REuTuo2Ehw757ZbO69XNHEf+TIck7VDgYZItDvvLP48XYeN+65jX1wRmlIfLnFbtnccOM8QZWdxqZFSWHXGGFmg0+ZDaGNPoaAEFI6enqeunfnG7J5L+h8/xlkJ8CBXq69OC7n8ODsTQ51T+1graVThEh+b3HV6OOPl/uOefIIUHLPakpt2wdUbGbuh6apioDhep090aizQdQ==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;6:QD2bw13cI/TjCarrP1ComwECoyzFvUyUe9mUwhEWcRzevI6J4/2KOaaQnEn+4Zy2vDhvsI5o96imsRtqVy2EewRCyEnCMguofgKXyaMY3AKymGcsaAPhGfxrdYofA/7Q6DurPlxB+6k7J+8mVlcEPfZi+rRJBnMUmzPUuykvp0gqpD2S2F+b9Wau1RxN3oLac3q2irCgA9ZNkCZkj/yDrDVoheAWdoHi0XD5dT+0/QI1GfgdNFujoKCunjqX3a24ED/cXHw8krb/fU5CZETZZrNo5JSPIm+YXWS+NLYGvUJR4IkHokRRr1p6AntpAmW8QaTtwkCSAD1gHOpBkdEpejgVqJpJjciMYKHBJ3nSck9l3KLP38DEZSVEOadcUuB9byYeF0tPEU2cgn3hogPT3Ss58njney/zONycXugvA6yglfKvBwkQ9hrTA2X/K1Dvk3OcMbPivdvoLvgWADmCHg==;5:cq5atI9k7rKndRLgyxDP1CgMF3OQFWObz2my/4+1J6TFDWoSDzSg6teqcNACPYmRSfMhzAFJglaElHXFfTbWYc+IM1HcFT/wianmznsNTnc0Etj+jdwVr6L48usHDOSlSobUS+SDDTZcz8wa5AK2UQvRnqtuH16tD25cOedKtwU=;24:s+XMIUkxACfGjCKZee806mdmYxjMHqACvLT70NVwO83vyd6U1M7RdyocbFCNNqKrUdom4PQB6wkOwyk65ikrmq94yHKyGDZlaMWx4jo6NGI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;7:AmNkHK8P3zzuZH/kWQ7VYwHjn3o801ZOA+eJiTYbNhgq5p74rpxkXLFezBSNm9l+AbcK2XlS5UWDULqrBee4m17Zq8lFHgDINxgD1XeXk7gyUAwfmvN9zwL2zaDQ0ZFT7TN0p4Ocsq0A/wu6HqNyB9wPRjNmvqRGpdqS6YJjCxI7uWQeH2FG1X7MFvZPuJ6jWboWM1/qo8VUudmt2Hhx36P0tsydERYDD0zI0RHnVMqVa9evVlXj7pMGzF4AqaYg
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:58:04.8901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77126f42-7a94-4a44-b09c-08d5d5c2c707
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3231
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
index 86fa799..d1d3494 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -342,10 +342,8 @@ struct sdma_channel {
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
-	spinlock_t			lock;
 	enum dma_status			status;
 	struct imx_dma_data		data;
-	bool				enabled;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -606,14 +604,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
 
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
@@ -731,14 +722,6 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
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
@@ -1000,15 +983,10 @@ static int sdma_disable_channel(struct dma_chan *chan)
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
 
@@ -1922,7 +1900,6 @@ static int sdma_probe(struct platform_device *pdev)
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
 		sdmac->sdma = sdma;
-		spin_lock_init(&sdmac->lock);
 
 		sdmac->channel = i;
 		sdmac->vc.desc_free = sdma_desc_free;
-- 
2.7.4

