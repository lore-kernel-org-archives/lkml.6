Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 50F45C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA533208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LSjh+MBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA533208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeFNFgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:36:38 -0400
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:14002
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751731AbeFNFgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuOr+/lAF+pp7lYOi3KFSvyQ6VBjf0al83Kp++cy0Q8=;
 b=LSjh+MBsMHFcMNXyH3Os+pdKEZd06jt/9TR0fCL/Gtdv+VwqcQUt1ArpiyoPaSZFRua3KeBB+NHFoGkkjFpyhZ1aoyPX5AQ0BKUEMji015P8C9mZYzlbr1+lW9Rqj0oI0HX4o/34Qe+94Ct9dQVGxV8YMzAWi4Soz4Fod+bjRY0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3222.eurprd04.prod.outlook.com (2603:10a6:6:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 14 Jun 2018 05:36:29 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v4 0/7] add virt-dma support for imx-sdma
Date:   Thu, 14 Jun 2018 21:35:30 +0800
Message-Id: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To DB6PR04MB3222.eurprd04.prod.outlook.com
 (2603:10a6:6:6::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6df9f4a1-ef61-4922-84fc-08d5d1b8c932
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3222;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;3:RkfGw1CgzSXFUWxzi173Qbj6DngMSyt2T77OYUQgTMpt0+s5fAKnnsEqHrALqnPs2A9fEVlskJbUEvwBsDCaVFoTIC/DzNNZIxFinCvIe5AefWuozo/N5aY55xg+eNTnSuoL/wst4zBgXUBxIkJylb2bIRaEtY5pOWCBX0iywDblpEkmps9JfxVe2vFVWiDVmqNRpuLEiM3I40d8AudLIxqQ7/ckMy9S8iCR/QSDC89C4VAVCSNAGr4IameJSjXy;25:AuLiJso1U5Gbe3MYGwbVKsu0F7+v/0SC1aMYdCeXM0UCGpQSu7KIDYVjtm15H/yF31oV0uxmEWEgHWBBat2iDUYMm64btPlzxCf+mcbHD+AHShhl02LXXtMe6KFxWrr9oy4xMlTH7nA5Wc8Lq9CJhQBgzoXwKZ2HvTqxgsAeM7We4SOXIM/f9w111bgoYqBUtUcnsYNAJSWeuuGfOMU8TbYggCFxQ/bXVkq9z6o4Qkq3YE1QhLSP4au9CEBwuNvZKwbtWbL31Z0mw4RgAC44QlMUc0c+ig9pWeXNF2QIlFeNQt3Hr4iTcGwnap+F4ko1kQVRyho+EzySpTSRPRNQNw==;31:X+thJMTffeXH8rJ/yMUZzZM/R2apKa7UCfYa1IX5IO822sKOMsuaxYkBa5a1M6AZ0DnQ09710r2zvmzfjnm2BS9DO8yyt1rm2xJ7c1mHWB/uUpkEkg6DmJBUJQ6cGZG5sZiz7WkxFSCUgtMvdbhRamVtDlBdr0fbS8hU6+eF98PFVl4ULhCKQvp8HD8qtw1wNGfgyuoeH0orlJTGahkyyvbmKZ/lzbGQTRrFYQDBehA=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3222:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;20:Xyp9+3VllElrfULCoRm/XhDsv2SWLPe1mnQtESN+g5XaDqhYasN24X+SAU+Py2yI9eKpDB34cMmE8Lm2TbJOSBRawW9Z07C6/tky5qSZcIyMR1rmNo3Fnv5fxXvKX8Kke1mOscWz03gPRrq3sUiEEGwSjM1yeipZ1mjUuS67D9nLlXupmxEdDZP7puzMPHe+Go+fFfX3nHWvN4qs6H1nniKhoSRzGcs6FZFSrIfZfetS/AAlFRNn7u+oSFujD/ev+mpOLHh8yAb/+BTCd6a7sSe69vdnF7ztrzsw9zGKun54E7Yj9E5w1G+tgK/MpF4d9gBnwlUVH4zOfQmfS3TrccUHWL2WbXWyLqSPOhWAwVVOINB7/FLe4l3LxJ37fAP8/eqccBVMx1tlAmzjcsiK106DTWxAnsXgHhNrVNrzxAl+ofBPYHrUKhS69IcR/y/1ddYZH/A0NOw/sICzVdhh/vzG3KDaXxKZM39rkOCMWtd6RU//opCAvD2yQAMlb0GA;4:vAXVPldVh2ltQZsMioX2wVf3252Q/c7HXahTT4gkc/dPerUc9wxDhMEibp0HSBcaLelE+koufamQpUDb9LWHt0/fMWCgvvZp2DbgWVD3w/uhCUXGjwdpMcf88MebtKKv9qv6mHUXrQHidEuRrASoj+CphPKuWMulzEeZIyyuanQCfjlmISvcX314WY3NQQtOMbUCoLMMf59TvIv/35IPmWxJrqhVPDQdvWlVxrrd4ebxMw0d3FzNcg1AgFKSk1ZUBm+xPjpIf4R5MI1PL3Z//g==
X-Microsoft-Antispam-PRVS: <DB6PR04MB3222252678F5BAB7EE1637B8897D0@DB6PR04MB3222.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3222;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3222;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(476003)(6486002)(86362001)(16586007)(6666003)(50466002)(48376002)(25786009)(66066001)(305945005)(956004)(47776003)(97736004)(2616005)(59450400001)(52116002)(51416003)(6506007)(386003)(16526019)(486006)(186003)(105586002)(106356001)(36756003)(81156014)(68736007)(3846002)(6116002)(478600001)(53936002)(26005)(6512007)(81166006)(8936002)(2906002)(316002)(8676002)(5660300001)(4326008)(7736002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3222;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3222;23:ZYpeuo08uf5dntNmFe29JvPrV2MqZ6rgMQmmdGhzB?=
 =?us-ascii?Q?Cko29zwuLx3UDrWGgXFI7SXqznibxdyYy1xfJFg5FBcxcVWG4BOwzzP5cdlM?=
 =?us-ascii?Q?0qwAYvh2Ad1NeG3XSjJekL7bLF1llQoEsCOfzJ78QSSLje9jJHEQ8u4KHNn4?=
 =?us-ascii?Q?m/cpWNTAd8caju9IRV2zXfp559L6DNiQaQ9lJ3AZ3/WvqopbRiNnE7JogVi5?=
 =?us-ascii?Q?N18SberUup3NZKdJbhGcAJped/scUuogrC8/1nBywp+H5kWgjqCzk4oba4AS?=
 =?us-ascii?Q?vR8zQwVk2DJT0KtGx8FlTzfD32yOgHtYNt9rU8gYUkWa+QeBv30gHqgcIKm0?=
 =?us-ascii?Q?0f77HoRZH3wJsXzMDaWWKmS7IPmuCRqKfaYOCuUV6rC0TJoRJB+CPgufT6Tt?=
 =?us-ascii?Q?VyhgblReDNpvwcOk5el+i1E7P9nwna58WSXiTyDtpCbQOszuGaTMYVnZ0CFQ?=
 =?us-ascii?Q?ncMYsicf5Rj4H7uZFWBuFJ/17k19RaqjKbpwUwTnWmJjpTAEc7XAUIkwzkMX?=
 =?us-ascii?Q?Wj8Nx690EpPbkzbcCkx3rX+sFaMXur+FpPIQddiJXAL7x0x3FvfzkFrBhkD+?=
 =?us-ascii?Q?lbRbvSMOMlPvbSdTbKCT9HEgLq8jmbnir5++xxwDfP5l83daYUOO030XriHA?=
 =?us-ascii?Q?xQIOuY/02TkBnS/Ke9yCS/L3sGVoLp/CWW3VPRLKMb3dlL2ewrz2C0vG8qop?=
 =?us-ascii?Q?v3e1zqCY/lM548k/bme8UTb1H8XyzQsFZ1y4j9tR06gKzn21A8v15Uv9U1Vn?=
 =?us-ascii?Q?REWN9PjSmfnP05iDq1FBii0aBugPsfd2HVVIGFbtAKD52DGlMp2cMlueCXr0?=
 =?us-ascii?Q?eP9AhWYDybE0fU+Zh4WO4oxpujBxhg0igsVu13lzdGx9udI8Kl3HPNUZGGqt?=
 =?us-ascii?Q?RrwThfmD2vAIs79zRNbFCxGaB55Cezc7tZ72uk1PzVjvvolB4VsvCsHQvFf0?=
 =?us-ascii?Q?1e2M24/SVhQN+Ri5Bm/VGZzqqtUHlOTWGs2dQV0P+ruiX1QZ7aIpD9OH6LMV?=
 =?us-ascii?Q?KhSmQSNEbYJRHAweTpJMVFY2uhDKqSsGB5Htkdsg88aPDwn6S7IgY7XvMODb?=
 =?us-ascii?Q?Ie4rw96Qwtb3h4N94Zwk1ad3kzcSfmp0JmLtVZKtrciF1DFQKNvnnG4DCT9i?=
 =?us-ascii?Q?nfDOuu2ocE=3D?=
X-Microsoft-Antispam-Message-Info: lIC70+0yzBPhqky7uWayp53REKpaDidp80ubepmoD81B6YJSLhGYJab6MArdyX3dss4U5HASI9nR8fzKlPDcPivq43vGQIYdryvpyQwPf4IN97OufMVQwafqvHym93iYc17Kmf4rUnUli9xnEx0CVfK5reHbkmyJa7LydDJvPwaRFYr7KfXGYfBJdSlvzcRl
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;6:kAGPwNE9hGQF2vZPNVJDcyjlJa6nVTjdS+6cw8tqrNvJSZg6uNv2+GFHEMz5gNmuNU3DNB8/eHkaMHNICtF9O6Rm5T4gpbzUVhTSOATLax9qFsBaz04ztALF4J+r4yDEh2HFj/0FFDgrBfEDo4NiZK7TJ8CQviAqEfXcKcf8Sc+djI8ssJYLZSwRrF8oavhGnM3H0hWPp1/97BwQaWLhXVWkP/L3IJmVJXWElsfxIGrLcgYLLo9Akhy1RsUcyQaiYBgNJMlLYzS1qMxPDRmA+cn8x847xfewMeXZBsqFXBNI6Zyp7dRfMq6ckil4I+UYPHPq4A7xKxk3lBDGBNRxGu8cUKsA4QrPSfSM2AeMDke9s3BGmpX+l1DtMoaaVd8QPChzDgtjski1CCruVd4OD+F2Fl5LlVAkvQZmc7jaQ8v1Ceb8gwo/kL3AimvPTJgp1tlbMalshp2PCsN1cyAHGA==;5:GC3w3bA1DPPGdE0/NhgB9VT4GbQxqCYGyCrjxWtf9l3SY1/C3N9ff1hTQrQRAMW/EuBOKsBVDuJbjlHV5OQpJ+d+boMk/avsoMVz3FvEWg3PM0lHxHq+Qvs7AzgyG4DTx9Glgll5VNPAU8ICwPTf1HuP2nZ15yni/dJSvjJjH8A=;24:7PWGyQw1w5QQHdVzi/rMr655F89hKxAR1ZTzfvu9WuVFXGwmI5PZfb5U/QZV3qP/WyI15Yz0aXRpeyO7jW8p54tqt7faMSz9SWbpp2qttfA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;7:JkMGTnDrPUPoyOloc91CC+LWseeHCqMbTsJaDBjLDN531vMRchu/jxt2ozvvwKhGCRR2O/qZyDeXLle/fMpcAMqsWRTZn4rCsY1yrbY0KMnFcVuZFO4+Z5ZBQn6BITp9oFGtBB6cNVJ6bZdX5qHC/bqIpct6zierMNYN7ohknkXEIuY9XsVaxmcSbQ4+4qqLxAcQXsaTKmHQfSAjwre/cZ7bJiL5geWKyJM/YUEddp87Dzb0q0EusMnNynwZ/SxZ
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 05:36:29.1574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df9f4a1-ef61-4922-84fc-08d5d1b8c932
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

Change from v3:
  1. add two uart patches which impacted by this patchset.
  2. unlock 'vc.lock' before cyclic dma callback and lock again after
     it because some driver such as uart will call dmaengine_tx_status
     which will acquire 'vc.lock' again and dead lock comes out.
  3. remove 'Revert commit' stuff since that patch is not wrong and
     combine two patch into one patch as Sascha's comment.

Change from v2:
  1. include Sascha's patch to make the main patch easier to review.
     Thanks Sacha.
  2. remove useless 'desc'/'chan' in struct sdma_channe.

Change from v1:
  1. split v1 patch into 5 patches.
  2. remove some unnecessary condition check.
  3. remove unnecessary 'pending' list.

Robin Gong (6):
  tty: serial: imx: correct dma cookie status
  dmaengine: imx-sdma: add virt-dma support
  dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct
    sdma_channel'
  dmaengine: imx-sdma: remove the maximum limitation for bd numbers
  dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
  tty: serial: imx: split all dma setup operations out of 'port.lock'
    protector

Sascha Hauer (1):
  dmaengine: imx-sdma: factor out a struct sdma_desc from struct
    sdma_channel

 drivers/dma/Kconfig      |   1 +
 drivers/dma/imx-sdma.c   | 394 +++++++++++++++++++++++++++--------------------
 drivers/tty/serial/imx.c |  99 ++++++------
 3 files changed, 282 insertions(+), 212 deletions(-)

-- 
2.7.4

