Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30759C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FD12075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i3d6N8Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FD12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965149AbeFSJAN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:00:13 -0400
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:3242
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937490AbeFSI6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RURCRxIrLULd8sZB9l/TvT9SOSvRKuexY5mpWnZyvAg=;
 b=i3d6N8MxObUfSrPIufLbdb4BCIVhrRURn3MVgK/Oiwoeow78UtkFtvLHPw4V/zjblKutQZYOVz0PTRMOrn+Nx7clzWdichHzdz7Bw49U0hlET1ojKCT47oC+3UAYiUnKi93sn35FLpW5nzq4mdvPaFAoDs6kH+IDlGJLYaD2Pkk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3231.eurprd04.prod.outlook.com (2603:10a6:802:6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 08:58:00 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v5 3/7] dmaengine: imx-sdma: add virt-dma support
Date:   Wed, 20 Jun 2018 00:57:00 +0800
Message-Id: <1529427424-12321-4-git-send-email-yibin.gong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a8e77b6-ff16-4edb-77a7-08d5d5c2c4b6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3231;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;3:e3IXjz/KpC5lZHlDK2K2kKL1izbmhJI8hMd62wJv6+/y1s2RPZOxRPZku0foejdP7sBIUiHpcyKp1KO5w4bzNtCplXAbiPvTSvWlQwlawaqvCQIXPsOlqTT7GjewxDi4cAg/Axl/T6BRbk2I0zEHeDY5EtVCYdoaK5n3/olr3rrXL3PyV96s/fO35Q1t5cnyA2IVvQGTcpBDKFXkFO329aO+e/XOybrvtIgpFLk+V9IVpyM7rtDrV9hVEGcDs8ct;25:BvyQAiRd+13d3z6+kgN9pZar6HvxsjfI/k2js18gHv2JtfwGGh0AfOb8qw2QyoUiM2AYUoxplrx9utNFpluk+MtOPTU746aQFB1Eb9JXoNzIUjY138owv1EOO4AoGmqH3qfnT2ZHg6Qii7uiQJYE6d81AV4J9z2EWpbLNoMGTUGTbO6wpLNS75r0mJpeU1zG6u6EwceSVw3rvSL32M8cEK3ArY+IYVt6330daRwT7PO20RLPwJZnOgJDIxtMeGUFisHBmroyz3TwxrsKrUeAN3FBaIvEMn2bWfG127tq4T/dD6kynMwRgIPQbtRoa+pS6KwG4KGqAS4uX+nZv8qvWA==;31:XKCXcawxEXiIS1dXKEEHQ6mRkzvBUlDciYzvEpZsdKsDbBwdnwQW4bCxJOz99T+F31f55/xMc5CEozjTS//HuBnZG82N32q9Tp+NPa3gvO3Tj2PQCa+ShUSwAlWNlx+qT/4wGQ+Yi0NU/NsWPV+ji53DshfaJeQSOuxyqUaIAWUYw+g9UMXiNb4W3GMM5lKVpsE4yblr44hx4HIo0BLww560dMpy3LZ8va3aJ9IvSVg=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3231:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;20:pM9FdwIZrPwhk+/QmkH+qrrj2MFZOnS7+MC/JWXBFarguCnRwluFwL/A3Mq9f7ReRr/7le0iV9uFbAN9xOac2shTtC1NQkHHi3XEsYI2r/SHB7Nlp6rl0eUtpNMgu5adzNIUidTtkEyio76NpPRvJbBnewIjHeCgf1cScIg77PR2z7xJ0Iho3ltfYY2RXzNbr52OQvi5fK3tErL7uHVzcpxE1I8VC2K39sXdz/2os9N2FtjGbKV+gI9DAPLX9lukhB507rv8CGsEr2I1CTHyvMmFsuT3+7tFLtgXSrPoDmpDobRDqY1fBi2WAMB5IrArMEiG50sZH0i8iBXZQ46U+vCCX0rZKMy67MJoost8MQtwU73J+65E9ER3joz4rrAFDl68ikWelyHkccBdgH/EQ+UKBTctuuUrYUX++sBo8fAHD3B5RNTlacwshKP/gQ09InvaeKoDFkVVXxQlX5Lk3c9+3IzCkqqsWTuiR24B6Ds0mandNM669+4iDywemWen;4:QYyE5xYL2T3TqZEsGyRuAb5U/PpiFTLvjUI4ljHpAx4HF2dmqLgg18kk518Cg0qRp4JhPnp0S1YMPh35ewHFvkDe8H5G+Buc9T0mrYVmQKmqyxkIiVb/V017Qth1UmW49zyuGh5NXZnFh238g+/aOLGz5xor9TWyhy1284CJ5RYAXI5ucmd+c7xbPeMqzrs8z4jsoUCCW9upzM1W3fK4DUu2ObgqGRW8whcyBvkZl1CtNpqutTD1VLY5ilWSCmvT4NduOdwktFAacDd2TY20XLSHCVD5LCBjxID0PVzp1k3MNbyRWxnuhE7/ciWNZF4a
X-Microsoft-Antispam-PRVS: <VI1PR04MB323179CC2E5481BCDB3002A589700@VI1PR04MB3231.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3231;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3231;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(53936002)(6512007)(5660300001)(478600001)(386003)(6506007)(59450400001)(26005)(52116002)(4326008)(25786009)(97736004)(51416003)(76176011)(68736007)(47776003)(86362001)(66066001)(575784001)(551934003)(7416002)(105586002)(36756003)(50466002)(6486002)(48376002)(106356001)(316002)(11346002)(446003)(476003)(186003)(16526019)(2616005)(956004)(486006)(81156014)(8936002)(2906002)(3846002)(305945005)(6116002)(50226002)(7736002)(8676002)(16586007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3231;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3231;23:6wCLlDWvdMktBf+jI7xkHfbuEcEOETH3HxBqZBbwZ?=
 =?us-ascii?Q?qSMzjVi4LZmO0nA+xqrkGSQ0+T0QwCetIhSjW4Qu9jwCnnKE/mp0zDK4btHz?=
 =?us-ascii?Q?8VQpUFc0dvHg6h6j6FC9SqXtj5ltY8sjFquOnmjB7pQBccpkjV9eUcr3iCnq?=
 =?us-ascii?Q?sTGE/o2AzIAB76CfqS4TtncDXJPDhG0Ph0jiYSEgV7ZCbhSGWIgZL8lk1k1S?=
 =?us-ascii?Q?ZOA8MrUK8WmNcYipAM8fAyR5sZP3H7kd3n1RkPJzNG6uazL+t7x+sYXDdPL1?=
 =?us-ascii?Q?e9plFH5a2/cC3a0qecSJcq5BPvNet+pIInUbGpFYj4VXAtKPfiFqn7wnmbRn?=
 =?us-ascii?Q?hAOpp2YSjqLZ0vzYMrxStSZIs/Rdd360y9ZWaFsmrRARKoBFjbs1CsS4cp5K?=
 =?us-ascii?Q?K3PJVnhoSItQGj0U7v5VrYAftuh3Gj6Rn0dVj5yBYsJMaJm+fc3FNtGuCEBf?=
 =?us-ascii?Q?QGANYDXUz/vG88CzfnDSpFOdeT2ogjQorUYrBJEAg2jTVqL0mtXvyy4Y1yL3?=
 =?us-ascii?Q?GEIWPTdmsLgkDcKzeC0VuVQYNFgtU2Tnwy4wfj/F7y59hA6mDn7iwoItKaTa?=
 =?us-ascii?Q?z2QhzLw0X7Ioeby1ZyvsoOEjfzkfFNoqnuMLJQXRmgZcFTFF+RWtdy4G11ya?=
 =?us-ascii?Q?dMt9T0zq01hs9NeTh1i4hf7L9OtWa2A4oHooZqNFa/I6sF7k7FGIk2FmZf03?=
 =?us-ascii?Q?mGakqH9p4bPuM+Fr9yStix2WDqBJ/wSGK3+7bMe1Kywgchx1hk1PnUxyvqmI?=
 =?us-ascii?Q?jcsEZtdN1Te9aeTlTLk0GP8bFIgP3AhkA+tx0hmal8CPLcmz47yMveMST0hm?=
 =?us-ascii?Q?QNesWmkaMwUpuQsxbhzHaV7yr5Gyq+oJPoKooFt+TOHcR9EJZ64fRszZyatf?=
 =?us-ascii?Q?kkLXI26VAVL6PuPSyiOB1F8L3BZMkUbuYqiAG923LNeUZGc75wIfms0Q7D7r?=
 =?us-ascii?Q?JsR4yt/sclAX8l9KiVmhRPXdYpcTi81IPsxqlpudkU2mUMQY/KDMvkA1T7uP?=
 =?us-ascii?Q?RFhaE73r9xOI7rHAe1+ntU1G52ncv+NskYDtbP/SeVh9sJsYQAbdDW4sp4Vr?=
 =?us-ascii?Q?7QWttQThzjSm84iJ2OAUrlHxg/VxNMXWlung2sHJi7blpMOHB6LRF8gi78aF?=
 =?us-ascii?Q?TolgVsqDY6/HmUptOhQjGj1zp4d/eaYgjZgcwxjSUDRj65tCe6sbMLYRbvUy?=
 =?us-ascii?Q?8onFUNkhBNNx0krks/VxqZHzMJKcoaWxWGiS/WTUVM7R3o/G38yVANzLA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Koi9uAibjn6HR01csjber5jj2HWIlFZ5s3ibkkX6Zvxzcojuf8EGjeQipgs/qrvLSDdrhmQqDHN9nb105Nlk7CNbWoUHn//Uyz/XxkKL9VaJS2w1fKBASH0sJ1WR7zCN3C2atb02eoGoh7Zae041+YqNlmEHdzhaaGTU38O2patjR54kJXJAYIjsxkX4uY1yBmngBkfCkL7zdBCbI11MrUqyO3iA2agHJFylbTeHza4TWTIxj3dgeZEwG1zs+sTVPZw7ulb5d8SrHxtlemUpnKrNYIc+f3bgpeyMaQlvqI1Kspero1pdqwjLFG1LU+H6s2xHBHLugppuH7RnLzcU0Q==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;6:ybryKQxTbH+k8Q2NdU7M+ZEXZcX3LyAx3+C28ujazjffTpGQY1ceQT2XbVLZhSAM60wM/Hdq8HTPdZ6Cmh+/2FmthiLCliOhm+nXDigevXaRsv6kXXKMeF79h+vulIjLJqrNvTqbKqloQjf09P1SgcQYDs427llcwND7OEV825h0L/kcz3aFUMsIJ/xWLC6Z71vM9yARHPPi9i3svBDNIS9/H3b77l/Q4Ud2Pf29fIlK4Q0fa0moQDAia2Gg/2093H88MDeBaesTnRKMaQr8SUHgwTAXOQBXisl2ca4DI1m3jD+uRMCj7AmyXZqA6pg+5YuMAtHVZZOfUcVPxOqNTdOkBqSDJl/YHt87wuZPGiB4PXJfaeSBKd8Fjz6VcfTc5EuxC7SWN6WV9z6vcVaTFsAIhcZ/5Prfsu9PT/koTpqEnHc+9qp2NVjemVYGEbRg11+UBaqkTAh6de9rPiCTDg==;5:WAw399sZHjFCgN9Y0f9Oo8xlGkdrdVCDKfEyx5y/qzRM2JjWMMMAhRk/1IZwLtCjTIBL9M1s72/zgoe/JLqMJ9f+zCIm4IeZH+1gt8zM7msRxvWcvpOZDT6z/YTX/XGxHaXCE/d+BZLMbQvHkXB8fKsKGhN+FSE1nf/RoKZUyWo=;24:qNXPCh2QamLs9m7KDXwTHnZZ7SOwMMsxcqZW+UDyQNx18fVxJjHKZ84+VopEY5ENckN0NTqMOaC+buFCuiD2uXR9tfXFy2Z1tC+uhF0rg3o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;7:FOwM9z2BzWrDgyJ7mprOzZwLMUpQdlvFgW24k5FrBiLczgSS7bHOgafdGgoxbaVeXoPe9W6F7ZooP1Ust1yMuZfFY5BxQt1qP46UZ7mn6PfPNAZcE4T49vephoFySnk8GgIW66MgcJeBf/68ByYPv+BcPKfYgHCv/hkGPe0RyJycO1b72EZokuha68VKIXvsRpeJ8gm743wu7m0nwdeZ3Ou0Gfom76QLZCq93KKKZUu7suw2KA9SooSkB1b3pdWv
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:58:00.9963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8e77b6-ff16-4edb-77a7-08d5d5c2c4b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3231
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
 drivers/dma/imx-sdma.c | 263 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 171 insertions(+), 93 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ca1680a..d4a4230 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -250,6 +250,7 @@ config IMX_SDMA
 	tristate "i.MX SDMA support"
 	depends on ARCH_MXC
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Support the i.MX SDMA engine. This engine is integrated into
 	  Freescale i.MX25/31/35/51/53/6 chips.
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 19c351f..86fa799 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -41,6 +41,7 @@
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 
 #include "dmaengine.h"
+#include "virt-dma.h"
 
 /* SDMA registers */
 #define SDMA_H_C0PTR		0x000
@@ -301,6 +302,7 @@ struct sdma_engine;
  * @bd			pointer of alloced bd
  */
 struct sdma_desc {
+	struct virt_dma_desc	vd;
 	unsigned int		num_bd;
 	dma_addr_t		bd_phys;
 	unsigned int		buf_tail;
@@ -324,8 +326,8 @@ struct sdma_desc {
  * @word_size		peripheral access size
  */
 struct sdma_channel {
+	struct virt_dma_chan		vc;
 	struct sdma_desc		*desc;
-	struct sdma_desc		_desc;
 	struct sdma_engine		*sdma;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
@@ -340,11 +342,8 @@ struct sdma_channel {
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
@@ -698,6 +697,35 @@ static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
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
@@ -716,7 +744,7 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	 * loop mode. Iterate over descriptors, re-setup them and
 	 * call callback function.
 	 */
-	while (1) {
+	while (sdmac->desc) {
 		struct sdma_desc *desc = sdmac->desc;
 
 		bd = &desc->bd[desc->buf_tail];
@@ -747,15 +775,16 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
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
@@ -778,10 +807,6 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 		sdmac->status = DMA_ERROR;
 	else
 		sdmac->status = DMA_COMPLETE;
-
-	dma_cookie_complete(&sdmac->txdesc);
-
-	dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
 }
 
 static irqreturn_t sdma_int_handler(int irq, void *dev_id)
@@ -797,12 +822,21 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
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
 
@@ -958,7 +992,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 static struct sdma_channel *to_sdma_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct sdma_channel, chan);
+	return container_of(chan, struct sdma_channel, vc.chan);
 }
 
 static int sdma_disable_channel(struct dma_chan *chan)
@@ -980,7 +1014,16 @@ static int sdma_disable_channel(struct dma_chan *chan)
 
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
@@ -1109,46 +1152,56 @@ static int sdma_set_channel_priority(struct sdma_channel *sdmac,
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
-					GFP_KERNEL);
-	if (!desc->bd) {
+	sdma->bd0 = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
+					GFP_NOWAIT);
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
@@ -1184,19 +1237,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
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
@@ -1210,9 +1254,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
-	struct sdma_desc *desc = sdmac->desc;
 
-	sdma_disable_channel(chan);
+	sdma_disable_channel_with_delay(chan);
 
 	if (sdmac->event_id0)
 		sdma_event_disable(sdmac, sdmac->event_id0);
@@ -1224,8 +1267,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_set_channel_priority(sdmac, 0);
 
-	dma_free_coherent(NULL, PAGE_SIZE, desc->bd, desc->bd_phys);
-
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
 }
@@ -1240,7 +1281,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
-	struct sdma_desc *desc = sdmac->desc;
+	struct sdma_desc *desc;
 
 	if (sdmac->status == DMA_IN_PROGRESS)
 		return NULL;
@@ -1248,23 +1289,34 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	sdmac->flags = 0;
 
+	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
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
@@ -1280,7 +1332,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
 					channel, count, 0xffff);
 			ret = -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		bd->mode.count = count;
@@ -1288,25 +1340,25 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
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
@@ -1325,10 +1377,10 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
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
@@ -1344,7 +1396,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
-	struct sdma_desc *desc = sdmac->desc;
+	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
@@ -1353,27 +1405,39 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->status = DMA_IN_PROGRESS;
 
+	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
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
@@ -1385,7 +1449,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		bd->mode.count = period_len;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
-			goto err_out;
+			goto err_bd_out;
 		if (sdmac->word_size == DMA_SLAVE_BUSWIDTH_4_BYTES)
 			bd->mode.command = 0;
 		else
@@ -1408,10 +1472,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
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
@@ -1450,14 +1514,31 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
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
@@ -1468,10 +1549,12 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
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
@@ -1677,12 +1760,10 @@ static int sdma_init(struct sdma_engine *sdma)
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
@@ -1843,20 +1924,15 @@ static int sdma_probe(struct platform_device *pdev)
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
@@ -1961,7 +2037,8 @@ static int sdma_remove(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->tasklet);
+		tasklet_kill(&sdmac->vc.task);
+		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
 
 	platform_set_drvdata(pdev, NULL);
-- 
2.7.4

