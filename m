Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A2CADC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35249208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lGOq3+xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35249208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbeFNFiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:38:01 -0400
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:37120
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752809AbeFNFgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3CFrUpFKIveFYV2slsOsapmG3kZGgKlzElUk+EcHtU=;
 b=lGOq3+xXzO8EKgYQPV1nBleZhAZoVdiqNYvV47DGAi8F62mBsalteXxAZjAFf1vdnhEVdeC/AnPM8tloV2aM5WAdJHqFKBhKwaAMX4oFDWEQyH0pwFNunx/jzZGLjmh1Rqv83kkhKmaztdZphS3R6PEnhvLwjVVMt9CvoC88k3A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3222.eurprd04.prod.outlook.com (2603:10a6:6:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 14 Jun 2018 05:36:40 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v4 3/7] dmaengine: imx-sdma: add virt-dma support
Date:   Thu, 14 Jun 2018 21:35:33 +0800
Message-Id: <1528983337-2726-4-git-send-email-yibin.gong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 99b8789e-79af-42be-60a2-08d5d1b8cfe2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3222;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;3:NxSfx2fs3mywVqvpod0FsPnLyOZZKhUPT3ruisg73nQn0truvFX1NduMxWCkCfcCC+BwAtJm8611Lmb78ESrp0PiqrHxB6iaKxdrfyjW5ZXxgAnUJWRYbzxHTPxGUoFgKvwiuYCJxa31rjvg5GkbWDPmcK/KV0eJqmx0kMo2dGiEKVgTGoGTqM57VjJK1CZx27Q+2yll9YJgtfI3mVq2jzFi7p6jGdKOtlORrAJRCm31QGhrbvMUItMqetzwic1/;25:xv1P12YalByGInUwLa6q/aZwpoVpnTfdBHW4VmoddQFZzWj1gACdlhn90NxoOOsnua4dJVocn84iP76b9UkeL6MESTq+v9eKCKTnhQ1jmCNoFsVDF3nGZQYeCkhyrRqN6Q4vg5i0tsXVXKr0Oyk3l5mgRD2UZNREmc6J1TMA5OK3qgpAuVCu2K7xbTyWzXT9hsbfdsYl8souTrfYyxInjcBkN1DQySV1pSsm2vpljkdqO59mdCHlYDKMB8bEynCxipDLpMD96ZlCaVtf9lirQgDBAQCOwWA1MVnsqXaKHPrvt1ukigFx6OeFE0dN/5LnoZVhvhrWDrqHISgL6O+odQ==;31:OLNLXaDFwaWdERHVtIKhVICU0h0TIHMSlOhCGPJSisG3TASnfX3oT0iu2/hp1sx37sTa/rKvVd7w/CtsYPl91CVwvpvgcNFl4pK1v40I13tth9cxVYAwDTtZKThtnqsgjfQNd6nA20/kaEuCATY5OtFCFziBuimfi9AksNPvWN/+jrIDjyOJmMSnK2JSdiSEa0BhLAOPoYLqz4pOXoqOw3WkpMIM2HRX1jdEgcjJzaA=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3222:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;20:Dw8i/GxPlu872X5/NURESX+m6gglijsE+N9Rc/h9Eag30igXTU37RR0ZeTFC7Z1C7Xq/y5YDEhRPViJZD9dP+QGWPPeWHLp7KoYFhj5MBKD2SR9aMh9ALbjMzb0+ufvDVsw00Zz4ChMf0OLel5209mt4uEiIATE5rASHzjFuhCRUJ/YA5r3/IAXLmwc6Za0k2VOi2yfT3QGLnceFDCZ3AEt5nI8lWBp0S6dfCSXi6hEYMxUJqyf76Y2K2V0b+i5jeLg7D/mUUTD1lE9Ptq81IvaeMcdW6snLpKf7McHnLDJSFGo93LvxgaJgln4sCbr1Lq8oY2tVWvt5OOXIELayvqq8ypZnC5HLxzhowoksWT7SlyV6o3dvcqT4bURjM/zB5cEc6X3uN7rOiLvEWNLZfLuanK8Hcrn4a7/fokjbcX+1K6kJhE4PeOdfUzOv67pdX9tJxlxnV4+lFfT1uBea+KNsudmUsijGMXKaIFQ8fGH18QdWzVmBX1Qvf1cce4Jk;4:JNcmU8FdILC2x9q25dj9slpL5HXMvcfAxd0vE+2ukWys9eolRGYsmbPlZyS/sxdQqFAyyC3Z4XVq+wvak7+/SL/HVV9HWoobyAZ5umU7fVlWEKmn7Zav6yVnRcfT02DtjsfbZrI+1UXFZGOg/m37z0bhc04PReEUKSOmqg6ea1p+EvIetWbRV41Uiww9Qa4HILDl48PjCHbP/Mvuk1tzswsDlBPw1yhAX7K+69+yRDiGQuSCTAPAhUvBEd3eh5WHx8KB083+8qCABM94M+qVN1+QIS0fssWMSMvPtqIkwjwPOLd4/O8qxuhuiPxWGnI7
X-Microsoft-Antispam-PRVS: <DB6PR04MB322281C3E8EF816BB3C8E0B0897D0@DB6PR04MB3222.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3222;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3222;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(575784001)(476003)(6486002)(11346002)(86362001)(16586007)(6666003)(50466002)(48376002)(446003)(25786009)(66066001)(305945005)(956004)(47776003)(97736004)(2616005)(59450400001)(52116002)(51416003)(76176011)(6506007)(551934003)(386003)(16526019)(486006)(186003)(105586002)(106356001)(36756003)(81156014)(68736007)(3846002)(6116002)(478600001)(53936002)(26005)(6512007)(81166006)(8936002)(2906002)(316002)(8676002)(5660300001)(4326008)(7736002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3222;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3222;23:AxsaNvxPkF/vifNVexUC4owXbncGjQNnRzyS0ZIAF?=
 =?us-ascii?Q?PqVI6CqFasyJ1lA5mDNKktYzy3mogrFABDrARUsDml506KriQLCLP7i8uBlU?=
 =?us-ascii?Q?c0nU/cY8JAIPSd95OGx9pZfhIVCI8TNVQOMjSCyiKLmQ9s8g1JN1ayGqOuCd?=
 =?us-ascii?Q?JNXuXtXewxROvaNaBgBpI+xQxmXK+R1jnsfGriTBUzF2sjjcsrbw6sa/cafK?=
 =?us-ascii?Q?hgEIr9S5igmPKRWRqeUM3oGoGfs2NZCHgAZZ7e0ge5+Yfyr4k7DDG+qJCRro?=
 =?us-ascii?Q?zv6MI5TvX3jDsmsWy8e+r+OhQQHtjKMzzo+PUqeYMuJB3gLmsEQTL/avoNLo?=
 =?us-ascii?Q?QS2sbTgAbvRHYkkE7bkk7slyj/2l1kGursTdh0PBr8oIk4/23J1MQ5Y8C40V?=
 =?us-ascii?Q?Bv6S5M2jMWFDt9HszQPAe08eD7PhpWo9EOabY9KqNK5fsvpP7cxa31Kz3GW/?=
 =?us-ascii?Q?6eIWrTurc1jZxB+Y4qi1dq/xUMd1JY1nryUJQoSJxHpT0R/s5gyYysgjR6sf?=
 =?us-ascii?Q?VpKtzmFQthMCymhPd2Iy73yIZR9pNPVTyaIRyVOZOB69xv7GrFq7Z4iqU9+C?=
 =?us-ascii?Q?o0AObf0dj6vyUii9tP92jmxbgWUeGq8yfb1lTEK5mWv/URWne5N9w2zYueZ/?=
 =?us-ascii?Q?pzrnWYHeHLNHYmxLOnA5ztnVoxNtz4UIYkThGteD568qXYP/8E2iqWC7e+EV?=
 =?us-ascii?Q?+iorUVdowQ6fHwyGtho4p3T5R4WDV8sNfXe96C3T0VB2wSb9ZektpVF3LWGC?=
 =?us-ascii?Q?FY8AfcMWV/1/RXptxRc0iUSd0lQmkf5iBFvwBivoSRCYLuiBEO6jhfXlQWpH?=
 =?us-ascii?Q?kx2RAigPvIuy1LUy0cTR/kQi/S7CvVUHsOiKSl5e6GSG8mud0NEZ/zkge28h?=
 =?us-ascii?Q?8e3QjPSMR9bR9h1nLe3Y6xbQzHL4hvnDxoge++aON2G3tX3Srbtn+4AzhR2X?=
 =?us-ascii?Q?oCB6lgNKbkMnqH7kjpVST3WyPru07s2WEfjUHd1BJN/dLnBbqo4M9oQqDSgZ?=
 =?us-ascii?Q?JmhzcMtGNujQLeCDyI0ZxWT7Fxk1r+crv6dTDkpoT6+10uHUWl6IdpK/S+12?=
 =?us-ascii?Q?0z8e7W09t33DBmnXYJVGQCNAGfgDYaoK9LDcDJgLbgfEy3Hq/TBg6HxSrGnZ?=
 =?us-ascii?Q?AO581bdmphOUUjjNZsPTVxj/h/BbbUMuYNi42EmThcIO6vJAEMMPbntdo74k?=
 =?us-ascii?Q?fuJyBsm87/0NfBOvF3/Y3MW5N0u/oimHNCF1mGfEbMONlwvChGqkRRnbw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: ugmU33kfVcVxAfZ8F9NCFE3hBreBtZ1UXcfBexaMml6e1fI+A1fcreMNkEw1vBONdM2+9XonGV+Cgw8ISbGAabzT/lCfP//wqkEK1NpUIUsYFpDCjqi74HBAKDUGIN1a1aKaspqUimX5LQTLZzNtKA93zIlOile2vUEdzlRkhA9iL48zNZ57Gl1yfxVsHoR4
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;6:yE/iGZ1Bx5kvqjuI72/Eh5OmBi0nScK47OpAH7/uY9jv23LBgvNvgXcrRfizzOSlyFZVsvsvPLXdaCtMrny2mRKPloxKGBpoyxE83xU4DNu0QYAhLII3+2WGWI9uhuD/1m7RVznKTf9DqMbPA9N5UOP1go56N5jMy4SwMIYqvvTPExVJ3FRjc2LRQcfJUnHrREM3Lu5gWJQY1ZoyFcexd7ZpWQ/HuhrHFA0HB/93tjq0KUQD41hFtSSWuk6wEDYuJ7ez4vN7RbH19WJ+yFNVwpDlKFrabtG3Gc/ozu3wATaS8HSy052l0NDc/bWUfSPuCmlmi2Pvwivmihk7Hurf4j1rx8LTtUGnDakX6hwZ/rMd0gq51L8IiqQup0S6zaChnCBG1Do9Kr3LP7LpThBZ3W2VH7nsz67OkADrGlUxD7BVWT2ZK13vKqHWk8wkcZ3NjIIKlMsLyCrStMPOPh+uPA==;5:rItw1J38jGfVqTAYH2eaeBmx1pXnvkT7ubfiVS+C0FwEH7SBUp3WIR1kaP+9JKCXFAF9GD/wKhGyoMYBuY7FC3GwyHbF7V2MoDztPAsEVFMN46id62Wdyzq5682oxtudOHM0VrlFNEkVWM60iHux+2Q1RQ4zG+p7Cehk9sjrL40=;24:m6uQTl0tvh2eVJf/iyewy5VSy0QUx3a4LzZ2Pd+3ezalJkAY58MJUCYKtfb42vHd1yCLJPfqVkXCPvLKIAnyWvWmvk4ADeLJGTEsRA1fIUE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;7:Agz7T1XoS+X1Hl9Jt20oOc+Q2z1T23o20991iuH2fUV8F/Gj6sTGKswVLRgUOC8BuA/woGfsJpIXQ6fpaYziwnuWsj1XKVYtGeaocb6PZwMZ+anqxo5FWITMWzj7jdjcPchOKMqlWdv/rk6kyqHfDcRHqnApItyAQuhQCiPOLIvPZxHYlj8MmB/gjH8ZPygudAg6yHOHXchB0Ytntz+8sKy1/ityeENOByx7RFolVLxJ8bmIdetPpUd5dADRtZvD
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 05:36:40.3919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b8789e-79af-42be-60a2-08d5d1b8cfe2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy sdma driver has below limitations or drawbacks:
  1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
     one page size for one channel regardless of only few BDs needed
     most time. But in few cases, the max PAGE_SIZE maybe not enough.
  2. One SDMA channel can't stop immediatley once channel disabled which
     means SDMA interrupt may come in after this channel terminated.There
     are some patches for this corner case such as commit "2746e2c389f9",
     but not cover non-cyclic.

The common virt-dma overcomes the above limitations. It can alloc bd
dynamically and free bd once this tx transfer done. No memory wasted or
maximum limititation here, only depends on how many memory can be requested
from kernel. For No.2, such issue can be workaround by checking if there
is available descript("sdmac->desc") now once the unwanted interrupt
coming. At last the common virt-dma is easier for sdma driver maintain.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/Kconfig    |   1 +
 drivers/dma/imx-sdma.c | 261 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 170 insertions(+), 92 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6d61cd0..78715a2 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -257,6 +257,7 @@ config IMX_SDMA
 	tristate "i.MX SDMA support"
 	depends on ARCH_MXC
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Support the i.MX SDMA engine. This engine is integrated into
 	  Freescale i.MX25/31/35/51/53/6 chips.
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 556d087..719bf9f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -48,6 +48,7 @@
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 
 #include "dmaengine.h"
+#include "virt-dma.h"
 
 /* SDMA registers */
 #define SDMA_H_C0PTR		0x000
@@ -308,6 +309,7 @@ struct sdma_engine;
  * @bd			pointer of alloced bd
  */
 struct sdma_desc {
+	struct virt_dma_desc	vd;
 	unsigned int		num_bd;
 	dma_addr_t		bd_phys;
 	unsigned int		buf_tail;
@@ -331,8 +333,8 @@ struct sdma_desc {
  * @word_size		peripheral access size
  */
 struct sdma_channel {
+	struct virt_dma_chan		vc;
 	struct sdma_desc		*desc;
-	struct sdma_desc		_desc;
 	struct sdma_engine		*sdma;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
@@ -347,11 +349,8 @@ struct sdma_channel {
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
-	struct dma_chan			chan;
 	spinlock_t			lock;
-	struct dma_async_tx_descriptor	txdesc;
 	enum dma_status			status;
-	struct tasklet_struct		tasklet;
 	struct imx_dma_data		data;
 	bool				enabled;
 };
@@ -705,6 +704,35 @@ static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
 	writel_relaxed(val, sdma->regs + chnenbl);
 }
 
+static struct sdma_desc *to_sdma_desc(struct dma_async_tx_descriptor *t)
+{
+	return container_of(t, struct sdma_desc, vd.tx);
+}
+
+static void sdma_start_desc(struct sdma_channel *sdmac)
+{
+	struct virt_dma_desc *vd = vchan_next_desc(&sdmac->vc);
+	struct sdma_desc *desc;
+	struct sdma_engine *sdma = sdmac->sdma;
+	int channel = sdmac->channel;
+
+	if (!vd) {
+		sdmac->desc = NULL;
+		return;
+	}
+	sdmac->desc = desc = to_sdma_desc(&vd->tx);
+	/*
+	 * Do not delete the node in desc_issued list in cyclic mode, otherwise
+	 * the desc alloced will never be freed in vchan_dma_desc_free_list
+	 */
+	if (!(sdmac->flags & IMX_DMA_SG_LOOP))
+		list_del(&vd->node);
+
+	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
+	sdma_enable_channel(sdma, sdmac->channel);
+}
+
 static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 {
 	struct sdma_buffer_descriptor *bd;
@@ -723,7 +751,7 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	 * loop mode. Iterate over descriptors, re-setup them and
 	 * call callback function.
 	 */
-	while (1) {
+	while (sdmac->desc) {
 		struct sdma_desc *desc = sdmac->desc;
 
 		bd = &desc->bd[desc->buf_tail];
@@ -754,15 +782,16 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		 * SDMA transaction status by the time the client tasklet is
 		 * executed.
 		 */
-
-		dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
+		spin_unlock(&sdmac->vc.lock);
+		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
+		spin_lock(&sdmac->vc.lock);
 
 		if (error)
 			sdmac->status = old_status;
 	}
 }
 
-static void mxc_sdma_handle_channel_normal(unsigned long data)
+static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
 {
 	struct sdma_channel *sdmac = (struct sdma_channel *) data;
 	struct sdma_buffer_descriptor *bd;
@@ -785,10 +814,6 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 		sdmac->status = DMA_ERROR;
 	else
 		sdmac->status = DMA_COMPLETE;
-
-	dma_cookie_complete(&sdmac->txdesc);
-
-	dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
 }
 
 static irqreturn_t sdma_int_handler(int irq, void *dev_id)
@@ -804,12 +829,21 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 	while (stat) {
 		int channel = fls(stat) - 1;
 		struct sdma_channel *sdmac = &sdma->channel[channel];
+		struct sdma_desc *desc;
+
+		spin_lock(&sdmac->vc.lock);
+		desc = sdmac->desc;
+		if (desc) {
+			if (sdmac->flags & IMX_DMA_SG_LOOP) {
+				sdma_update_channel_loop(sdmac);
+			} else {
+				mxc_sdma_handle_channel_normal(sdmac);
+				vchan_cookie_complete(&desc->vd);
+				sdma_start_desc(sdmac);
+			}
+		}
 
-		if (sdmac->flags & IMX_DMA_SG_LOOP)
-			sdma_update_channel_loop(sdmac);
-		else
-			tasklet_schedule(&sdmac->tasklet);
-
+		spin_unlock(&sdmac->vc.lock);
 		__clear_bit(channel, &stat);
 	}
 
@@ -965,7 +999,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 static struct sdma_channel *to_sdma_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct sdma_channel, chan);
+	return container_of(chan, struct sdma_channel, vc.chan);
 }
 
 static int sdma_disable_channel(struct dma_chan *chan)
@@ -987,7 +1021,16 @@ static int sdma_disable_channel(struct dma_chan *chan)
 
 static int sdma_disable_channel_with_delay(struct dma_chan *chan)
 {
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
 	sdma_disable_channel(chan);
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vchan_get_all_descriptors(&sdmac->vc, &head);
+	sdmac->desc = NULL;
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
+	vchan_dma_desc_free_list(&sdmac->vc, &head);
 
 	/*
 	 * According to NXP R&D team a delay of one BD SDMA cost time
@@ -1116,46 +1159,56 @@ static int sdma_set_channel_priority(struct sdma_channel *sdmac,
 	return 0;
 }
 
-static int sdma_request_channel(struct sdma_channel *sdmac)
+static int sdma_request_channel0(struct sdma_engine *sdma)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	struct sdma_desc *desc;
-	int channel = sdmac->channel;
 	int ret = -EBUSY;
 
-	sdmac->desc = &sdmac->_desc;
-	desc = sdmac->desc;
-
-	desc->bd = dma_zalloc_coherent(NULL, PAGE_SIZE, &desc->bd_phys,
+	sdma->bd0 = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
 					GFP_KERNEL);
-	if (!desc->bd) {
+	if (!sdma->bd0) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
-	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
+	sdma->channel_control[0].base_bd_ptr = sdma->bd0_phys;
+	sdma->channel_control[0].current_bd_ptr = sdma->bd0_phys;
 
-	sdma_set_channel_priority(sdmac, MXC_SDMA_DEFAULT_PRIORITY);
+	sdma_set_channel_priority(&sdma->channel[0], MXC_SDMA_DEFAULT_PRIORITY);
 	return 0;
 out:
 
 	return ret;
 }
 
-static dma_cookie_t sdma_tx_submit(struct dma_async_tx_descriptor *tx)
+
+static int sdma_alloc_bd(struct sdma_desc *desc)
 {
-	unsigned long flags;
-	struct sdma_channel *sdmac = to_sdma_chan(tx->chan);
-	dma_cookie_t cookie;
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+	int ret = 0;
 
-	spin_lock_irqsave(&sdmac->lock, flags);
+	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
+					GFP_ATOMIC);
+	if (!desc->bd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+out:
+	return ret;
+}
 
-	cookie = dma_cookie_assign(tx);
+static void sdma_free_bd(struct sdma_desc *desc)
+{
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 
-	spin_unlock_irqrestore(&sdmac->lock, flags);
+	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
+}
 
-	return cookie;
+static void sdma_desc_free(struct virt_dma_desc *vd)
+{
+	struct sdma_desc *desc = container_of(vd, struct sdma_desc, vd);
+
+	sdma_free_bd(desc);
+	kfree(desc);
 }
 
 static int sdma_alloc_chan_resources(struct dma_chan *chan)
@@ -1191,19 +1244,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto disable_clk_ipg;
 
-	ret = sdma_request_channel(sdmac);
-	if (ret)
-		goto disable_clk_ahb;
-
 	ret = sdma_set_channel_priority(sdmac, prio);
 	if (ret)
 		goto disable_clk_ahb;
 
-	dma_async_tx_descriptor_init(&sdmac->txdesc, chan);
-	sdmac->txdesc.tx_submit = sdma_tx_submit;
-	/* txd.flags will be overwritten in prep funcs */
-	sdmac->txdesc.flags = DMA_CTRL_ACK;
-
 	return 0;
 
 disable_clk_ahb:
@@ -1217,9 +1261,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
-	struct sdma_desc *desc = sdmac->desc;
 
-	sdma_disable_channel(chan);
+	sdma_disable_channel_with_delay(chan);
 
 	if (sdmac->event_id0)
 		sdma_event_disable(sdmac, sdmac->event_id0);
@@ -1231,8 +1274,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_set_channel_priority(sdmac, 0);
 
-	dma_free_coherent(NULL, PAGE_SIZE, desc->bd, desc->bd_phys);
-
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
 }
@@ -1247,7 +1288,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
-	struct sdma_desc *desc = sdmac->desc;
+	struct sdma_desc *desc;
 
 	if (sdmac->status == DMA_IN_PROGRESS)
 		return NULL;
@@ -1255,23 +1296,34 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	sdmac->flags = 0;
 
+	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	if (!desc)
+		goto err_out;
+
 	desc->buf_tail = 0;
 	desc->buf_ptail = 0;
+	desc->sdmac = sdmac;
+	desc->num_bd = sg_len;
 	desc->chn_real_count = 0;
 
+	if (sdma_alloc_bd(desc)) {
+		kfree(desc);
+		goto err_out;
+	}
+
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
 
 	sdmac->direction = direction;
 	ret = sdma_load_context(sdmac);
 	if (ret)
-		goto err_out;
+		goto err_bd_out;
 
 	if (sg_len > NUM_BD) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
 				channel, sg_len, NUM_BD);
 		ret = -EINVAL;
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	desc->chn_count = 0;
@@ -1287,7 +1339,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
 					channel, count, 0xffff);
 			ret = -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		bd->mode.count = count;
@@ -1295,25 +1347,25 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES) {
 			ret =  -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		switch (sdmac->word_size) {
 		case DMA_SLAVE_BUSWIDTH_4_BYTES:
 			bd->mode.command = 0;
 			if (count & 3 || sg->dma_address & 3)
-				return NULL;
+				goto err_bd_out;
 			break;
 		case DMA_SLAVE_BUSWIDTH_2_BYTES:
 			bd->mode.command = 2;
 			if (count & 1 || sg->dma_address & 1)
-				return NULL;
+				goto err_bd_out;
 			break;
 		case DMA_SLAVE_BUSWIDTH_1_BYTE:
 			bd->mode.command = 1;
 			break;
 		default:
-			return NULL;
+			goto err_bd_out;
 		}
 
 		param = BD_DONE | BD_EXTD | BD_CONT;
@@ -1332,10 +1384,10 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.status = param;
 	}
 
-	desc->num_bd = sg_len;
-	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
-
-	return &sdmac->txdesc;
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1351,7 +1403,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
-	struct sdma_desc *desc = sdmac->desc;
+	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
@@ -1360,27 +1412,39 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->status = DMA_IN_PROGRESS;
 
+	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	if (!desc)
+		goto err_out;
+
 	desc->buf_tail = 0;
 	desc->buf_ptail = 0;
+	desc->sdmac = sdmac;
+	desc->num_bd = num_periods;
 	desc->chn_real_count = 0;
 	desc->period_len = period_len;
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 	sdmac->direction = direction;
+
+	if (sdma_alloc_bd(desc)) {
+		kfree(desc);
+		goto err_bd_out;
+	}
+
 	ret = sdma_load_context(sdmac);
 	if (ret)
-		goto err_out;
+		goto err_bd_out;
 
 	if (num_periods > NUM_BD) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
 				channel, num_periods, NUM_BD);
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
 				channel, period_len, 0xffff);
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	while (buf < buf_len) {
@@ -1392,7 +1456,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		bd->mode.count = period_len;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
-			goto err_out;
+			goto err_bd_out;
 		if (sdmac->word_size == DMA_SLAVE_BUSWIDTH_4_BYTES)
 			bd->mode.command = 0;
 		else
@@ -1415,10 +1479,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		i++;
 	}
 
-	desc->num_bd = num_periods;
-	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
-
-	return &sdmac->txdesc;
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1457,14 +1521,31 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 				      struct dma_tx_state *txstate)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_desc *desc = sdmac->desc;
+	struct sdma_desc *desc;
 	u32 residue;
+	struct virt_dma_desc *vd;
+	enum dma_status ret;
+	unsigned long flags;
 
-	if (sdmac->flags & IMX_DMA_SG_LOOP)
-		residue = (desc->num_bd - desc->buf_ptail) *
-			   desc->period_len - desc->chn_real_count;
-	else
-		residue = desc->chn_count - desc->chn_real_count;
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE || !txstate)
+		return ret;
+
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vd = vchan_find_desc(&sdmac->vc, cookie);
+	if (vd) {
+		desc = to_sdma_desc(&vd->tx);
+		if (sdmac->flags & IMX_DMA_SG_LOOP)
+			residue = (desc->num_bd - desc->buf_ptail) *
+				desc->period_len - desc->chn_real_count;
+		else
+			residue = desc->chn_count - desc->chn_real_count;
+	} else if (sdmac->desc && sdmac->desc->vd.tx.cookie == cookie) {
+		residue = sdmac->desc->chn_count - sdmac->desc->chn_real_count;
+	} else {
+		residue = 0;
+	}
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 
 	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
 			 residue);
@@ -1475,10 +1556,12 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 static void sdma_issue_pending(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	unsigned long flags;
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		sdma_enable_channel(sdma, sdmac->channel);
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	if (vchan_issue_pending(&sdmac->vc) && !sdmac->desc)
+		sdma_start_desc(sdmac);
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 }
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
@@ -1684,12 +1767,10 @@ static int sdma_init(struct sdma_engine *sdma)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++)
 		writel_relaxed(0, sdma->regs + SDMA_CHNPRI_0 + i * 4);
 
-	ret = sdma_request_channel(&sdma->channel[0]);
+	ret = sdma_request_channel0(sdma);
 	if (ret)
 		goto err_dma_alloc;
 
-	sdma->bd0 = sdma->channel[0].desc->bd;
-
 	sdma_config_ownership(&sdma->channel[0], false, true, false);
 
 	/* Set Command Channel (Channel Zero) */
@@ -1850,20 +1931,15 @@ static int sdma_probe(struct platform_device *pdev)
 		sdmac->sdma = sdma;
 		spin_lock_init(&sdmac->lock);
 
-		sdmac->chan.device = &sdma->dma_device;
-		dma_cookie_init(&sdmac->chan);
 		sdmac->channel = i;
-
-		tasklet_init(&sdmac->tasklet, mxc_sdma_handle_channel_normal,
-			     (unsigned long) sdmac);
+		sdmac->vc.desc_free = sdma_desc_free;
 		/*
 		 * Add the channel to the DMAC list. Do not add channel 0 though
 		 * because we need it internally in the SDMA driver. This also means
 		 * that channel 0 in dmaengine counting matches sdma channel 1.
 		 */
 		if (i)
-			list_add_tail(&sdmac->chan.device_node,
-					&sdma->dma_device.channels);
+			vchan_init(&sdmac->vc, &sdma->dma_device);
 	}
 
 	ret = sdma_init(sdma);
@@ -1968,7 +2044,8 @@ static int sdma_remove(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->tasklet);
+		tasklet_kill(&sdmac->vc.task);
+		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
 
 	platform_set_drvdata(pdev, NULL);
-- 
2.7.4

