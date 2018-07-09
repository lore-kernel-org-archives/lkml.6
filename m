Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282F1C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F6520881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Un4h9oUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F6520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbeGILTH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:19:07 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:64784
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932634AbeGILTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFu77vhOIyYSbxd6wHPRq+KFrj0/DRgH4wul/uWhnYk=;
 b=Un4h9oUEWYKMW5jTTjDUdCpG066b+GTZ3H5iC454UlkRTfqrqPqztPb7+1NNmXAmbsBTp1jooigiGkzTDkXDGcftAM5PUdaEY4dAFZKujIVNjYvBeIaEdgg/OWzhGne1zo+/4F29ybUogecMbn/2KPE2OtdFmU4pZpEGWVoldGg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 HE1PR0401MB2427.eurprd04.prod.outlook.com (2603:10a6:3:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 11:18:55 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com, hch@lst.de
Cc:     joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 0/7 v6] Support for fsl-mc bus and its devices in SMMU
Date:   Mon,  9 Jul 2018 16:48:16 +0530
Message-Id: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::30) To HE1PR0401MB2427.eurprd04.prod.outlook.com
 (2603:10a6:3:25::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d285d86-25b0-42af-dcb7-08d5e58dc4d5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2427;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;3:ZZUUHgg4o9zopRp+SoNAhwjGRzuaOESQsQS0zIwTDPmurVDIw2kH+Xy19nz/XhtyvWcyfBxooIjazevyHQ+XK4fPR17tYySAUEPLvk0NY+hTjHnVj6MgsLyRrdZefseOJhfhv7fPAj8SoPpm1PZ2jrDgS1BSvZRg3EhGL6s1+lrJ4Sqr2dbR00q3xHwStmUI7FX5w/Vlw5wgq/+MtOh9Iwy1dUQPC215k8W/Ttblro9x/AoPNLx78erkxNWYwuST;25:B3NIqk9HwC49evrHyIlI9Jv0FdUbRrQRqQt7MjmOQ0AY+O+EkxZudcqHsdK6AVxoh8yan/jZfxFPvOEdUxgKStcJbntNNU3ryXQ+ZuKdoLoe7dX9YXcV0pHPqVgvj9XDuF5cHhiGOsuIxkqznr/wrXzABBh28Ey9rRB9p98Lm3oiggM0oq7E2EXuTyLDUPFoDbOdSEtoS/6lH6tU2NA29t+rm78UakCAYFnRhjop9RU+xHOp4GnoF74WAikTBCHbMIorb7/vgW+mtTjTNOjKwqcTT1eFijEAxL5CQ16PFiWZTHiY5CD3sbm7BjxXSbtaVu/U+XsRKNln6JB464xnIg==;31:LPkL0049BJC3zUKynQi0reULWFAT5Y74WbDKQuxPtUgXkuVlP9jHL9Sc5v8OhblJ4caqj5tJCX4CmcY09guTbf1J/4TQc+QVDd3YU50Bt18kIjFCToqhqBvw8ADT+BR21plrT8rPFqF3wUC1WC2LIzUOH+QsxDdeM7K/qUzShWiMH5aW96Hbx+xVE37y/dQLLGDiJ5iYVTyDng5s820nME5cvnI5hL0vBcPHULBuQQI=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2427:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;20:pb+RqBUI/VRqXmDVEw9NaHPN2gaH74ftX+Mu/iFOEU8zurv4cM268RINGl6dc122Q64hQvHP7w7r8BeT4m/5WhdXxuq4abdE1m5Cj8zK4unhHwovuopgZyljZXnOIGxI2oz4BixKu6b6ZT8nHd//+oFR5KLAQsW/Uo/nvU9AGF2zuMwUggDIxgcUjYjxQihyJ4keoQA+jI6NBi3dmfdrnnt0lIcvszUwLpaLgq87DFl2OZ4UrG1bGpKQnQkzx5+3pHe4xm1zGi3V8XPlH7mH4pq1WvwXcVOSh0THjaaTUPw0sKRMso39+ilscS/3ywErQbJUpv9gF82oLwDC8Oz7svBzuwKjiQCmJ1NAd8J0vmvKpSZ6mQGemSa5Q9Pf2YCdfG/sYVkU7xPJDbOGxPZBYaFpvUzc4iP56ZEs2pXRilNiqpZRZrEQHvMGVCBwb1BqDf0BHKGXOi207FhtG+W1UJq78nxcorDULKCjO+zlcI1XFkBVAuujTGGERfhFU3FR;4:89kB/k6EbB9pbb2V6iJb1kWiTgtUcullySMutLLc2ZAnBZeO+HT7piExqi0v5mTx1zI24KWG2N+gpcyCpK+uhBmZnj/Q9OZrSsq0OKcFEooFI2lvGhZo4QFeepgTUea3GGeuSXEaCRcEev3Fb/cDsVpH1tmqBSOV6olHAFziPziqzKO5vhJA+2gGOYgVlkZDSaFtsTnykV1aG3VRbOLcPufLWGzdusPMh7HuktoqLmE02qu47pVbMYbqa8qgJixi6rnGxsqU8/dELFf93ZH6nQ==
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2427A283CB164B2413197113E6440@HE1PR0401MB2427.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2427;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2427;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(54534003)(189003)(199004)(44832011)(25786009)(51416003)(486006)(81156014)(81166006)(2906002)(39060400002)(6506007)(386003)(50226002)(7416002)(316002)(476003)(4326008)(2616005)(50466002)(47776003)(8676002)(66066001)(68736007)(956004)(48376002)(5009440100003)(6486002)(7736002)(16586007)(53936002)(966005)(26005)(478600001)(55236004)(6306002)(106356001)(105586002)(5660300001)(186003)(52116002)(305945005)(97736004)(8936002)(16526019)(36756003)(3846002)(6666003)(6512007)(86362001)(6116002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2427;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2427;23:TzJ1aek9FS6gk07KKM9+qESYEWL958XX4sZyxhP?=
 =?us-ascii?Q?ct4B0ZytcBBai95vz6bg45jyt7BE9e1zRJEndlhEuQLnBasDvfjxzhearaj6?=
 =?us-ascii?Q?9sVCI1hRMWycTjViNXHCdAou9cZjN83n90gsDKrQfK1Ejl5h70u0bBZ+TKBN?=
 =?us-ascii?Q?aSynmN7uUwIA08jfEHBrfrDE4UzzAIg+CWH7wDMMvH8BNBZEbTsSIXDOgLMm?=
 =?us-ascii?Q?fmUmw1UEXnbAdoyTuQEOUiAOGgVIUNM4m2OT1jhNXM49cH4JRc1sQ/TSGA/q?=
 =?us-ascii?Q?sZBG3BXU8Zj6QvOJ2zVzkpcaWsbhUXl34jAttKolIdndU4b+Gv9VEn2JCHFA?=
 =?us-ascii?Q?aCEmzYrqCa8wSUN0B2K74NCCUfplqSgzoPTMZ5pJbqaK1SVPVmCHRs7S2Dom?=
 =?us-ascii?Q?oZRKTKOcstlolODqtg6QjsmT9GxFB3Hp/NOjh5U3isYJsaT6U6k1X0gRq5Dj?=
 =?us-ascii?Q?o7dlHAiQONAsU6VbfdX1O5cOtMyIhqC20L4jmiqi/kXhUd8HXJIN+GLQzmaV?=
 =?us-ascii?Q?I35lFjEuzRktzFUzTRGsO8jyGxPs2ltzflJV3X+8caf4rEf5jJEjdbN+sybl?=
 =?us-ascii?Q?4xseJl25SS/ZULu04aZHodgbto8CK6+CJXDKF+ghhp84OpCgpbRl/SlS+7b8?=
 =?us-ascii?Q?9y+R1qtrgQBK7LeO4/YWfBJUnH6HSpUkwUrSPNODzrflI2D1kyZ3wZAeVYG3?=
 =?us-ascii?Q?RkEicSk/UDo3qmh6q0vKJ3iwFxMO1+9EMnhovyczLRvCGYzVObazaTobZL+w?=
 =?us-ascii?Q?fHGIpUqFPivQMxbl8swSgdmaeLM4Tetlff7QqHJ7kjrlK8lQx4rCNQ+BowUb?=
 =?us-ascii?Q?MntK5P//lQ5P93rwsoE7Lo8ycjLLGjvq2zFHQ7+yQhP5Srwx1xi1AelveGa7?=
 =?us-ascii?Q?gCXxEye7R8jNHzZ4wQ3CjY+t4xLzlWV4Ladt2bDHKLnHOTIwm/nRaOuVMXbk?=
 =?us-ascii?Q?3kskYNm5aRHutWShwe7iZOfw4Rw3spGdiGG2fpDRnLGlvS9Vpmch/B62GV+K?=
 =?us-ascii?Q?GiCRqCLcYDjFsYz5WQF08ClrdkkZRKhxPtCYW6tyVDrF8BIQVJZeDtmpJUsV?=
 =?us-ascii?Q?N9KffjUygFxN7OWlWEmeth7PZRJBn7VT0Nhykbswz1Q0FtAljFn6CBONcU3+?=
 =?us-ascii?Q?wmJ7oSzhY4jYW1OQELz45i175xDsjF50agAH3rL5mJGAz2j96bPmmkZNO/P5?=
 =?us-ascii?Q?UxXX/j5PEkoIX19uH8/Uzfx3C42QEOmW/QRB03/slHo8GCydjs+gpqjJARSu?=
 =?us-ascii?Q?ihhC8NB61zKXUr9sWWANUeX8jmp7Umn1rpn4952C4pucXJ251xm2kSxtWNEx?=
 =?us-ascii?Q?g+qFzHyz3BPCoaR4bID08A33Zct/cF7m6YDxeGQuQF58C?=
X-Microsoft-Antispam-Message-Info: ErxLCEVtmx2Vl5RQBa4danPmm28XH8r7BwV6bAe20u+/Rhhyc+rJuno2IHAbEVpxUZ9CxWKZ0PpqI5buuyW/B4eoZ9Uy37D5nv8AZPeiGGrbhA/4ALb7hFNoFW7KehkR3iDPFNkCxfrfNZMWTPvM+f5ahRRyPJd/4IFPnmQnqg94IQ4bGC1A0kVOkGhllaWp11hQadaWosqOwwnlRmQT8NXTL0xkrHQBqTlY90T6guW1FKxnBSEdmzT2qSWRYcR7tTkNL48y2DwLFv+2Abix6REgV5POBDEUKSeLuSbXm5vdVo7o3bfEQtR7+aTzdWXX6dFJ6aOed2QeA7vy5yjToMoo4+VsAXPjcQ84sCJkz0Y=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;6:oWu87pwq32Ofv8w/vQGFRSNhdZI++9jXZlTrUKEAAXsIxao5oqDL6miC9o26NY6fgQZsDFk9Lx2lGnESFwtWNoD/elvfOECIvvg4GiJD5ctBHqdVAhuSibBK1UeZ7svSnsQevUlRjKGBvmAO242J5f2agOWiFycDivFBskEMIORR/RWp6h9p+czaqmXiXYDVf/uKtqMuSe+uIHWkwsCMjAubXu9YeMXCa2nLI9qRv+CiY/p72qH943m3HqK46QtE/dWsjHHVf4MExnVfD+2/7W4oaF8FPx07gPPk93EnBVdIvRShMUvC6mWlAI2IV6thvY05qKaapbXXzupo8bP6F0rlH9lo8Uu5/O+OJ6F/I4/0rwbduRXDQvlKwQnbBpohQmPHRS9zRXdoOIuPOoxeAZ35Cd9fDbaGMpBShJeQwaxgV0c36xFOeh/aJ94b0Akn70OX9beTFNx6XDVsXxWeig==;5:hL2/6L1Kt/gC/9Qthx2u29zX77GXtH7PfTgEwVyk/c5BbGOLCnrrPHC72sBVW9eE9qPrmu/dap5xYsAIBN0IFNW+jHDp/4l0zBcsoCsnmAdp9Krtx6K8W2pH8q+y4eAQRxd9uSoUdFA6CP4XOvGwtkzG26zyOCE/cUHOChCG+Mc=;24:3jCXKFQLTyFReBY3Ihu1higCXkwQrVvzcmE9bdt7NeQBUVw2nboZr4bevT2hyEE6HFzcCRHZZzkMOAcSYY509QmMotJO1vDaaE+VkexQNUE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;7:zyREVPbzsY7bfVx1n9VyXDOc9imYAElDByJldhPqpkdiwjdKIQ5HTl7VQLVu+PwPrLcJ0an2piuy3EUKRoWm1sL4EfaenQubWhhtm3KEmIKZseSJB+YBimOEz0CG2iHqJIDxKau9z4ADt5PFpP+cmjK4MiVgc/g4Q5/CQ2gu+v0pojgWkb7UY9cPb688TQ3LJr9K3B3HZG7/KGDvdJKe1qgLCVF+TQ2lrclw6Ab0Xlwam2M0UzaMPSFlRsSc3CPL
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 11:18:55.5708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d285d86-25b0-42af-dcb7-08d5e58dc4d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset defines IOMMU DT binding for fsl-mc bus and adds
support in SMMU for fsl-mc bus.

The patch series is based on top of dma-mapping tree (for-next branch):
http://git.infradead.org/users/hch/dma-mapping.git

These patches
  - Define property 'iommu-map' for fsl-mc bus (patch 1)
  - Integrates the fsl-mc bus with the SMMU using this
    IOMMU binding (patch 2,3,4)
  - Adds the dma configuration support for fsl-mc bus (patch 5, 6)
  - Updates the fsl-mc device node with iommu/dma related changes (patch 7)

Changes in v2:
  - use iommu-map property for fsl-mc bus
  - rebase over patchset https://patchwork.kernel.org/patch/10317337/
    and make corresponding changes for dma configuration of devices on
    fsl-mc bus

Changes in v3:
  - move of_map_rid in drivers/of/address.c

Changes in v4:
  - move of_map_rid in drivers/of/base.c

Changes in v5:
  - break patch 5 in two separate patches (now patch 5/7 and patch 6/7)
  - add changelog text in patch 3/7 and patch 5/7
  - typo fix

Changes in v6:
  - Updated fsl_mc_device_group() API to be more rational
  - Added dma-coherent property in the LS2 smmu device node
  - Minor fixes in the device-tree documentation

Nipun Gupta (7):
  Documentation: fsl-mc: add iommu-map device-tree binding for fsl-mc
    bus
  iommu/of: make of_pci_map_rid() available for other devices too
  iommu/of: support iommu configuration for fsl-mc devices
  iommu/arm-smmu: Add support for the fsl-mc bus
  bus: fsl-mc: support dma configure for devices on fsl-mc bus
  bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
  arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   7 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 +++-
 drivers/iommu/arm-smmu.c                           |   7 ++
 drivers/iommu/iommu.c                              |  13 +++
 drivers/iommu/of_iommu.c                           |  25 ++++-
 drivers/of/base.c                                  | 102 +++++++++++++++++++++
 drivers/of/irq.c                                   |   5 +-
 drivers/pci/of.c                                   | 101 --------------------
 include/linux/fsl/mc.h                             |   8 ++
 include/linux/iommu.h                              |   2 +
 include/linux/of.h                                 |  11 +++
 include/linux/of_pci.h                             |  10 --
 13 files changed, 224 insertions(+), 122 deletions(-)

-- 
1.9.1

