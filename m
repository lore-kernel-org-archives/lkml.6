Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F10C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BF020855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eI8QLqhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BF020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbeIJSpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:45:18 -0400
Received: from mail-db5eur01on0085.outbound.protection.outlook.com ([104.47.2.85]:19296
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIJSpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj3YXrpn+LRbNPYFGOTak6YzN4oXyFFbRweLwoo84gs=;
 b=eI8QLqhVEkUonAqz+YTsrSb8Edoy78Aom3o2N8TMLInVhgmr//sMdt47jwYWZlAfnqgHKH26/XEN7DNmCYmJnxy99BSK60SaPCEeFh/kamOcct7VE6Or6tJzFKyMRdiIO9JHIIEyoTf73oxOCcrQBWhC/4g+xpMlGhgPDSpVAyI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 DB7PR04MB4476.eurprd04.prod.outlook.com (2603:10a6:5:35::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 13:49:59 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de
Cc:     m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
Date:   Mon, 10 Sep 2018 19:19:14 +0530
Message-Id: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::11) To DB7PR04MB4476.eurprd04.prod.outlook.com
 (2603:10a6:5:35::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ae3a6f-c082-49af-eda8-08d617244f9d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;3:F6mQH4ZS1P8S7c61xNF+2UpRoRXOCsx0KMgWbWj4YwDG1wxexJyPni0KV/8WOQpAzDPGxr7DEQL7uw5D+XuavPEOqpzqFzChgN+unrL7lANLK7TGhjdf8DbeGOSIzy4aYG55jmkYsW1s8JI9px5byVe9Y0oYC6EIPgPCZNSB4mogO+WnXa/wNuy1xb7E57F+b8oEJTznObS/SPASwRGybd1fg9mBFBwxxGKzKgN3z0RShXwuD2HVPLHowsDqOawn;25:DxnC3ABJdxLVUTdEV5doi9IEC+tGBDzbc5fg06SuGNydgjFUrQE1cXZY718ff6mhSYlhVQGMStASzVxLG1hAEZnflrdleVbEvVWy8yFtJEMXmDH/LY9v3NJnc3N0O1cX5cpCYH1wEICdhwFwcc5wtgSF1ho7tO0tPho40eRqYkTOkxklE2cKw/0cyHrLaH/5IfQSoR8DWoAGtfUg8/DYbPh52EcSbEZjtYavUwZbvJVw7IPi3IQF+Xv9uFFkS1t93ns0MaJXO1clS9FWH7pQuINBk/r2Z/wxDKTX7yta35/VHQbt7iv8reBTxTZw/kItDxYhTmcfqd9INi1pgUk7Og==;31:CSCpP9OAnnyNEmDfCc4GIyUKvXLWBMyX34I+0cS/ez7aDbSw4CAjmwPH01qJvpUc8pc9d5baRXQRLp/vxIWW53wUuonTZg/m8Qyt3NcXRLB9JvE4jYCyTSSUL6PHsRrqsJv7WS+yxhu6B2kfOvtdf8BvNM3TYzD/CJ2ZuxIKh4DfuiV95yrJgPp+1/7ocXL6q9SC0TEEwF8mczftk7xcEiKMgBtMSrVHgXL6ECDsR7s=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4476:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;20:lJ6jP5z5szTTga4qqm1bn0E7VqTuBj3Uf0RFvjoL7PwK+SsDQv2eg5bBqnknxzX9QoVYOvhgTaQy5V86K194H+op++Rlf7LA7E5ei08Mp5uR2jOLrTusxDHvhgvDe28Cru/qeV1ajsANQzk4t4mqqJ8TqcT1QA6LWr5yu8KVqn8zLaJMAIxOBt0frwmOx+XZjAmLuUdnS7Y7kPz4KxRXM8JyyJEh84McI7nLttNCTztO5GicgeKoaRYVzwKmmDrtL31Fn2cfSYRSTYmKLFMRJLyDry5ixVxdTnAkk/y3TqqOdM948HJ/7une8vG6vPhGptxrX4aPad3JOWtSqf7tx4CE7Tf8Npn4Bw034us75mIE12olea5VpJXpo3iFF79t6TmqagAQFkbc2OIK0iWYYsWfIAgWcB6jgGK8LaVUzDHoMSGDwXao9VlNhqOV2Fj3Ix6g/wd9gpkKplj5l/Efgbqr3o9pfNm/7JlO6MxR6lVMvBVMyGKRxp253xlFJQhz;4:HOkBTlpTrscHUzCEezSuK1OBbshVjQ5sBFCTmmVsiaqthq1JM/VtWhl8lNLk1U0qeXyvTKM/4V9kSp+pI/UAAlbFJdBD8bnwYH2BaOZZOOlKqPWi+guyrXJCFjv+NkU3bNiT0JsLDCamvuRBiszw4mjn418NvG5zP5G/D2lHdDIMRVes9+QTEqQQ89waJU2Qjk+zdJj3B2DhzpL7lbho45v8boEoXKCDyzSDoR8lFvLSrFnKBbYRqHbV3jUIs336JQDapBX1VDZEK85EhhT7Jg==
X-Microsoft-Antispam-PRVS: <DB7PR04MB44764137E4D74F76316F28D1E6050@DB7PR04MB4476.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DB7PR04MB4476;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4476;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(54534003)(48376002)(81166006)(8936002)(81156014)(105586002)(106356001)(44832011)(53936002)(6306002)(47776003)(50466002)(7416002)(316002)(956004)(16586007)(6512007)(2616005)(476003)(26005)(186003)(966005)(66066001)(486006)(25786009)(6506007)(386003)(50226002)(2906002)(16526019)(86362001)(55236004)(6116002)(3846002)(97736004)(4326008)(68736007)(7736002)(5009440100003)(305945005)(6486002)(8676002)(478600001)(52116002)(51416003)(5660300001)(39060400002)(6666003)(36756003)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4476;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4476;23:iVImMDyLBZUlxPxLghPJVIDjCl8nPyXd2MvGAMACr?=
 =?us-ascii?Q?l8QMrct0RTDYObdzfo7UTw4cwXUxGyKzAb1cIs0ufqCC56sFsHOwp2eKnph1?=
 =?us-ascii?Q?LI5YBmcnfUM6SagS8pJrGwUSyRL4j98fl+Sa7xkaDH94KJ56M+RC0jnpxyey?=
 =?us-ascii?Q?D75IcMIoPYsHgP8xqlOqrJd72aZZa+pbYpSPWHKpdrUowZfS664nN3tLJ14S?=
 =?us-ascii?Q?YjobQ+91UdpF6hB+yJD4z/uH4Gs+lUGrHYmpcxJgDgxfNTatKw+DgnXbVgAw?=
 =?us-ascii?Q?KOzsO+o5tEvZCrFa1CH23hGJimWT/2VU81mECcbU+DfAE5u9/rA+Msgtwx5w?=
 =?us-ascii?Q?YnjPyFYz/V3PqAYIY/U2LyC3Uu09xdANMe+alRRvF7yf56WYbGHelp+4BoxA?=
 =?us-ascii?Q?4Wj3HT7I6cgrgVR0o0XKpUIYMN+HErWF6Tn5Kl6T+HhkrtlrwHbXZU1X1O5C?=
 =?us-ascii?Q?qplF/uMKZj35erMZVc7nkWmzZ/cmWbodDSQrPaeF6OE8zHlC9BvKLHMEi88W?=
 =?us-ascii?Q?W3TlSTJeRR/U/4Bt5y7SZyVZGiaR5D2H+CFF8fnPpWiXVbKC7Gz3DsmSChok?=
 =?us-ascii?Q?PZhzOwtZqLXNkQe37YGO1LueKrhkMh8zOE84uapTXg4xXtP+XtfPIP8nxMIn?=
 =?us-ascii?Q?bIMNjuzKKvs+VYjcEKyL+DVve9Hz34M3i/dfD7uq9ygbYIPSDSJfXiSpnKsU?=
 =?us-ascii?Q?6fRytmYBBnJIKvSPAQR0eRBbAjhgqaEK4rJ8vkrKR8jf6+USWl7BPBrXjoIu?=
 =?us-ascii?Q?ocNPSVbi+Mm5em9qqSpVxriKCWMEKXe+CQ6BbyfmVe1iWj6KTf+vmE3w9mpV?=
 =?us-ascii?Q?RiWriYKhSSBLi4A8Hv/+ECS8ezekvGwlt+j5Ie+FOsJsh1qKaNb7ZdGR0S/k?=
 =?us-ascii?Q?O7tMurZNUuFcSEtowOMEz/IM9xAFHa0oOJVuZlUtZ3pGdVsQqXdGuKUqeQql?=
 =?us-ascii?Q?fPZgKE3zYiGOOcQ5QC5k7qrlWUUxHOnv5wPAYIZhje6ZRrLwqAUzXd2hS/gy?=
 =?us-ascii?Q?o/e4NKdZk1Njcw43gIu97+72L4nd4mCEFiWM7BdSMN2WeGMtIEr+hoztyjG3?=
 =?us-ascii?Q?oiHUJawldajB04tTq4GbmVUkNrb0ZIaWik50j/sEmPthS+Zzr9Yz/IlTYAe1?=
 =?us-ascii?Q?ozrDkZJ1vAmhjtSURJrWxh/IEF3SXFOALHGEBa8v7sxdvzTGnSlYVQE6K1aa?=
 =?us-ascii?Q?aXPFWplXP+3Truq6Zx77AKgmf7bVH23O1fRI1nE3+BoKzgQtRhNj4LSrZBrE?=
 =?us-ascii?Q?FywbEZZ8m5KTG1zTeJAFF0jw0Zo9r14qCbl+5K90KumA3vjQWqFt2C8eplQK?=
 =?us-ascii?Q?wF1fBz3u0fB58WewvH8h0yyO0BpyACwWezcMaVnHKGR?=
X-Microsoft-Antispam-Message-Info: ksJMmdCAEwAtqZwIpoSvwfF/9fC60FgRASqo1WUxCiMZvNU9yUnuSA12RifDk5X8ubSjZ58thjglRsZSZlLBTs4WqcjK7LnzfOHCLWyxZqXPQwnw/g92MmFTRMASmJwEfy4NDFMic/857t57+d1bQHaucbrryNIXoGsq5rYi2G0qRSYgSmjOLi0jdH/OofCjQrzUl2Sy1LCLoOuCWGJDkluEAasTtzZWMBy3ogH/9JO02XcdNFWI3cs3YlYhaBKkl/8P7pMS3cLvimdCA+aRBqVVfuWsBS6SAbHJ0UEVRTB4MJX1Fpze6O1Ni59/wXB+niNyH/ONqhwLFWz9mjC1jDJ+kn2sjjXfEMZRUpMPcbU=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;6:7GQfqrKfD9zV0Qba4f00W/UuJrIQrXkh63hg8zngiV/me7t98eWNNOoEL3LHY8yOJFE/vkLou5KSEJ/IiGpbY9HV5dwQC12U8yu0CzIRXQVLrWb1ymcSs7Lr3vu1Xm+udbhke0lYRxZGSQVcJSUq8LMTdfyaWVaI1IMoTs8bjH0bEj187BNY4ovBozPqSg5H4kabKcLBx+SVRxQNA7q97Pmsq8sT1WOmDNu+B6dz/eeoFdkHmoDvAxxlMvd7S6n8jPqTHakSD2K3TYuavdzxQ938PQ/+D7aXNdYdOqtDscQbhAtu9YvgmGIVb76mIo6vo2Tvv1KEssE6DX1s6MMAMrrrzNVm7JZfBIEVrNmeG1+CCdVqCHRO1iuw8Rne+l3jv2NEZ9w6XbXdgPX8uq3OLHxWuKVE8pDil/iRlq8+K0eeNTP54fO9kvNGn3E9tApo+4jV72jKiAhboXlBLbdhVQ==;5:0u+bJ2/LCtKrmO2IRgkYpw83cQb0lnvFvKINVLZRgILI6ekozjTV8osW4a/567qsmtDsA6FZtYI0NCEvaNthw7L5aytFrwLfAT00neS/YwwjU4RffT1W+VVIaKfsndRVVcJGE+ewEGcCZNm6Ge5kgWtIti3sjYLGN3ByNhk3Ckk=;7:5QsElD0Q9cD9cQ+rDMu5WcgYW1XokgQ3Pxd0GbZxOPx6giYaWRO3i6JdEOVKv7R8cwyOvkM0e/c3CepPFvIAhwXozSAjWriGmwZ/4q/u72kFDofV0josVUXklq/owz9ogeB5HWEEsEg0d/HQDT3W89qQQYn0y9JrhpOTHvLPfF3qqbQ6jZTyg+VtwjTCoq6sHhT3Js4Bgr9e7ff6h3/jXHKhsaxEMECXeH2P2jJmJsMKWs8nbtAWnylDmXPtZuFy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 13:49:59.9145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ae3a6f-c082-49af-eda8-08d617244f9d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset defines IOMMU DT binding for fsl-mc bus and adds
support in SMMU for fsl-mc bus.

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

Changes in v7:
  - Rebased over linux 4.19

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

