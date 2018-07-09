Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98550C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FE720881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qZ/fNjEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FE720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933236AbeGILTd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:19:33 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:19376
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933135AbeGILT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMSx8Dhyy1JKyyeXqfcnt5HnU7Sl5Tn8+j+KMffUUj0=;
 b=qZ/fNjEmWsOamsr26UH7uE2auFQpadYTK+h8Ktudz4KNL7EEDDUYHpFVSptrYEv9RYd+lTkmAdus8o4ds8uk2pTnBV96fyiE3/I5fD+gAKJYfrAaWqnuAqCY/O6jWk4+7KsczpnEVixQrzD33KLX2scWHaxjua+3omjqja0+GJ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 HE1PR0401MB2427.eurprd04.prod.outlook.com (2603:10a6:3:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 11:19:19 +0000
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
Subject: [PATCH 4/7 v6] iommu/arm-smmu: Add support for the fsl-mc bus
Date:   Mon,  9 Jul 2018 16:48:20 +0530
Message-Id: <1531135103-10699-5-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::30) To HE1PR0401MB2427.eurprd04.prod.outlook.com
 (2603:10a6:3:25::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 421beeb9-2e2c-443b-03d0-08d5e58dd336
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2427;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;3:mmQA+yPlpGHMSPdNaNqcpUyaxKJYgRP6uFOMa46I42WNSuA5pTqzGGiF2+IGg7yaLbq8sndNJ8L/RnkvaxAixXBujgH008uqPk09dtEXMcDF7H5FMKarbLYXIO7uGbG6nSKDiN/LulDGbcM20cdoVzCVvMXF9R4sPTQZbb0m7wNEafz7h1DyPcHAdbp6072bD8TFo32z+czeA112yoZwXZxK0vXhLc+SQS0gD16MZ4wMoXQfYSSt7PRh7ibV2XJJ;25:rkcl2DUxvxwCa4x2v5/iFHp0XeNPHSciY4CZe+V6K04OeqCke2MP+HNDYLfVo1nIjLEuzw2IjArvdRL/umMStW5yCrinAmrM1VgnzVlmPPdxyDhybKGLnr5j9+qKLpNMaLsqaF56pracwRnVlTUN4m3LGEbbWrHMpENMtSGgtZXDQmh9nIuzKswn+PTuFCqjogo8pE2TsFxv59G1nuna/Aiu5PwITIT1Qy/eKhanha3e9wLSyQRVxFuv/aFcjXNr21oFaHrTIY7Ca9Uwrtu4wxoDRUqgi/LoveBd9nbjG5bWCUq2KZtAHQs/t32bYaozcPsW84JdF5TBsuYmTXL/4w==;31:/wG2oBYPXuQ1b2N3vbfkpzmWj9kNmJYqWP/cIAYgWO9sbXjr4x5ELxNNNNWSUd4eICVGID/Pj6v3XJyIdIyrSJJLkmYJduRxVU0ezBdU9Mb0B1Alhnzcgn5CvbjA795UI+c+m4I8pqN7Pqh6kXnQo564/jpI/7Pq8+x4T1YoQKOsPA1oLHKaH5qH+akzgCH4qCCkOLAILzKDMRCTQlasSgpz7GuGV9y2bIADiOpXeoo=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2427:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;20:xXCsu6+ZjOGL+NBwLxZ1dWWFzvClRY0b4ZxpuzzvKOBt0yWE+AQNEMTp1bdAMg73qGgT7fCqfrF/JRnhf6XNF1Cx9yUGwEwgAnQHu2Rz25XmWluTDrpe2tAauOxwl9vHHk7kd5osk8gsfir/swSZQVThovi6yndMbj7kng1D4tzJmCP3zC5WS9+zOnkAa4XKjflDQ/faWmybf79VA1O/8WVPb74eEhlK0E18ujaifGhbW2Y0O+U0HiOZJ8QGnH6EVpLxPjWEe5dnGFx8R63yrUKa+ozpZvV3wje9mDLL3YRzgE4fmsZTp9M07uaHhnQPv7HdETDiQdHtmTf+xxY8e1aO0O3wHyls/1d3U1Eos0vnbcY3JMH5Tn2ceupDetojSgKBBfrsRxoAjFOlY+bchWn25/KCft7K6Z/0WglmyTuKeQkyCMK+5cPZ29gpveAQDXHgQ5F+HBQBrayfOeyESnIkOEubEpyysP7s6hw9xjkXYwVfG+WRhszGPsbtTVhQ;4:RMJ7vZNdfSSUQigVyBLzjCYagh2GYFPi/NemJ71ibNtvcVZ4Mqau2J1iEQEGQ8TLi/A5NWVBl4Bvuyd2M8OyO6BJ2bAdeIGJ5wEjlQUOpM7UcbKgPghfEgtpvYRfZAK4SeCojdUz4kSg7CKQsLDqhIHwydo9sehm79I/2GkopzzUoM40jcNafMAK2Q6NITK7HMfhgt2dKWL+mD0zmlMYwCsZezD0Gf40oyRXD5c3fg0oG9c/yLYER6BEfEDjA+vFY1lciBejKr5cODFZe4EmD63G61aGUqdHJaEk15Z6jU1TU0QR6N7yDp5H5LB/fOUT
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2427419FE215EB23757E2C75E6440@HE1PR0401MB2427.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2427;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2427;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(44832011)(446003)(25786009)(51416003)(486006)(81156014)(81166006)(2906002)(39060400002)(6506007)(386003)(50226002)(7416002)(316002)(476003)(4326008)(2616005)(50466002)(11346002)(47776003)(8676002)(66066001)(68736007)(956004)(48376002)(5009440100003)(6486002)(7736002)(76176011)(16586007)(53936002)(26005)(478600001)(55236004)(106356001)(105586002)(5660300001)(186003)(52116002)(305945005)(97736004)(8936002)(16526019)(36756003)(575784001)(3846002)(6666003)(6512007)(86362001)(6116002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2427;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2427;23:lwmqfNI0j5sz7CU915tke8D2XqIH3iMbc3R9kA0?=
 =?us-ascii?Q?r843xzmOv5DPp6uyHna1dh+yLU979+AN4ghj7h0iAHKMmburbf5uGgk0el7X?=
 =?us-ascii?Q?qzLLvnBIyy5xExcsp7VHuAXVxqKMQDJMeGpLBiXqnyIEBiwxe07cNrI6j2B8?=
 =?us-ascii?Q?gC63HjyxkL6AN52erNgmv6P6z1PXY3UiAx523//Clv9u2sER35RIadGXYSnT?=
 =?us-ascii?Q?mfFwr5+vbVh4TKqIWFlVrO8NYOkMqJKhMFkULIl07q1iSoppe0gblUWXYkX5?=
 =?us-ascii?Q?L6oCZEfI8LJekK8PEMHw0iJkZWKWWyyzyIQbXxU4n51ycGrlD89fPJuL9ocu?=
 =?us-ascii?Q?xecI2aq6gr9CHi7aklEmzrsgd3gHpwDs3MtY0UdaC285uDBfbpMHc/V6iVxC?=
 =?us-ascii?Q?5q8fZx2zama2+KZgJZ/kBu50OjWXTveUELt9cSLikR8Xftf0Xkm+5YMbpI2+?=
 =?us-ascii?Q?SNdbrm8C0fRnFIfotUrDz4ypA19WNyam1A3M7a4rVHo/ylXa3qIlYXM0B0ON?=
 =?us-ascii?Q?sUzQUVVJpvBnWP5C1D4PrAEjwIt+0mjG3vZoVw6ykRfWRhj3OUQ18eC8wSA4?=
 =?us-ascii?Q?jKtB6dxGhkxddJhrDGssS+l0ZoeHO8hbliEdBmye5ctJCNFdIrLMeLDm5nPA?=
 =?us-ascii?Q?Gkm798BLRGYH5nBLhdEZMq9Lzipdp07x3b5Y6OItIMlj+WnG67/cx0vNj/Fe?=
 =?us-ascii?Q?uHpCkgc6siwenKTcMyAeMB1bYHMtT3P7bcHX7mNCrTm3nv2oymG/UN0m5S8Y?=
 =?us-ascii?Q?II6MJthELTctHyJPqcQL868a0CScgGSrT/kflJJnYYj5mOA0nRNgcJ1nnqJK?=
 =?us-ascii?Q?vgzem72KzQff6AnyCHS9tWF+LoMnK989m65lg0i3+3P3osxPon7T4fZB1FLs?=
 =?us-ascii?Q?OsERA5teRPyZDoAGeCRM2dWIbhBQvKVbvkI0AbcfS8ezv9bXiQiRFc+eQxiF?=
 =?us-ascii?Q?Sh2cG787djFqxo91DYGlg+rHUs9EoDYmPr1OxlnSfqzKUNxiDMKd6tTgthMc?=
 =?us-ascii?Q?vezN3Vx5VUaW53T8yXRLJWJSTl1d2omTrzn8b9dJyNFkV45I7hARWTUhtiMQ?=
 =?us-ascii?Q?4uuZGjf6j19b3A0AZOKdGW1plxBK/C1krbaQ7O4j8wcNaINrVNT+3kS3n93d?=
 =?us-ascii?Q?PkG8LNzlLl55hQQsqDC15QBEi2m/jiclKrf4d2AevkXkcTxNWQwFQtshJviY?=
 =?us-ascii?Q?1YFgflkKD/mwQZS3GWhn1xY1aAc7Z8t5PhhsbKR2vFtT4JpzE4IDhX+HcGlL?=
 =?us-ascii?Q?i/C5/El3dAtsMLByaAIq6mk910TUCMZXer4e+l0QMMhW6xOfj+rid9B1FYPb?=
 =?us-ascii?Q?Csg656znNBX2W+3SVwomF9D7zpV1y2t3lFR8A7zBrvToBxMCWAQ5U0eKPy4K?=
 =?us-ascii?Q?cAmiHow=3D=3D?=
X-Microsoft-Antispam-Message-Info: uGS/mDXoiXGMCYFe1B+Zazf+5y1al536Fejr4JiLVuNYnQHc6/6Y2FEqvgjwL6EK/vMP7pth0pSL3HWIRccJ062CJnD6aFf8Nu2bx39YKgADHIVbtnDn80W7zQxoZGSciW6I76/pPDEi5CWRAHl19LK5cqgD8QhnxgySCor8yJe1UcVyTi5o7JsL9T7EU8ZnvJmNgH2t4LPX/+F0bxxE2DLZe15E4Ix87gVlPbBGgluiary2O0YkjZaeflPYe+3d1p/O8hX7XxNg3wXUI6ErGaAjKGfzzMnpki3Vh4gQKERp4B/oDWs8dYYF3ff+hHnSRh6HJM2VWhUtXB6/2U3uIniHR3vFj3KO6TsSThk/B74=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;6:rbmIsQ6ZFVlaFfcCtcnhgU5iQqEqhNfHVbaW5fZH7Z+XmU6l3PktCqweo8s9B0LgK3IEy881UXEAswf9mmxAiEuftzIH8ffFG4XyWpeyt9AieQazGN7oGo8741D8SXqrWWmvZnYIBfddf37kB/kLMntgoxArIhHb7evREXgTGUYLyG7MWHzdQ8jZGHFKibUiXmaiU1WKCbnqH1d5TB7U0K/DjScAETsgp8oLYOV68Gx2STBslFhMYXDPsgu7uvZApsKAvjmcid//c3tWlv47jZi7cHPDn3jaGlvmCwIL9h1zsZ338wtaW4ZjC8Ti+cREtyQAvQ1gQsE+D4HfH9wR/GFsuXirI1Y4W8/G+gyAIy9s4lPsXWYGi2dTvaskNL7FbmuBI966bg9EpQe4eRjn3tn9UpNXNOPGbDXYP+pNMYDYw4QkKvUPUwUsysHwYxUneV5oyrRFD1i+i2N8oOnvdQ==;5:su4OfEH5nYp1KFPkkOGqoi2YtFIGRsqSLW7AHMRQM0sbNS8VruHZQpfDMD8eai1P0phU0x4V5FmRauXh6XXIii3KnWvBKJRdrso+Ouz7u6P9vx5X2o9jkcXwxy8GuJhbhT3s52ltjEJuE6ec+vkXpcnn4LsK1qr8U4U5iX9Yxew=;24:qIon+AsU9wbnU/9sgSJ180+znHJrccKm6UqKKHhXgY7OOgaMeQ+03848Rm78WoW2wM/27IFBISbdnbxkAnEOOnE9y5BwcgefZLfVbh/ELos=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;7:XZue4BBgtkvM4EDodBnxqnucT0ViTs0XSUwUHZpdfBGFz36k/c4ENB0lDxK9sAernQ8rAtaG2f9nV4EOLQc+ziGv2d7iF3/7a7QL4yUp5LqBnjIdh3RnzwoO2kJSv6DuRFj17U/3D4Qb73A+cDVHTWOI+t8eBkRZxzhDFiIYRSdX28LLqQ4ywYg9ni93PjbgcMgA0gX8HuL9L5wj5tWPNIqUPMe3ur5/Rvbkx8fLvOyP0UjjK+V3zUEPmfbkHID6
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 11:19:19.7191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421beeb9-2e2c-443b-03d0-08d5e58dd336
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement bus specific support for the fsl-mc bus including
registering arm_smmu_ops and bus specific device add operations.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/arm-smmu.c |  7 +++++++
 drivers/iommu/iommu.c    | 13 +++++++++++++
 include/linux/fsl/mc.h   |  8 ++++++++
 include/linux/iommu.h    |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f7a96bc..a011bb6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -52,6 +52,7 @@
 #include <linux/spinlock.h>
 
 #include <linux/amba/bus.h>
+#include <linux/fsl/mc.h>
 
 #include "io-pgtable.h"
 #include "arm-smmu-regs.h"
@@ -1459,6 +1460,8 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 
 	if (dev_is_pci(dev))
 		group = pci_device_group(dev);
+	else if (dev_is_fsl_mc(dev))
+		group = fsl_mc_device_group(dev);
 	else
 		group = generic_device_group(dev);
 
@@ -2037,6 +2040,10 @@ static void arm_smmu_bus_init(void)
 		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 	}
 #endif
+#ifdef CONFIG_FSL_MC_BUS
+	if (!iommu_present(&fsl_mc_bus_type))
+		bus_set_iommu(&fsl_mc_bus_type, &arm_smmu_ops);
+#endif
 }
 
 static int arm_smmu_device_probe(struct platform_device *pdev)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d227b86..df2f49e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/bitops.h>
 #include <linux/property.h>
+#include <linux/fsl/mc.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -988,6 +989,18 @@ struct iommu_group *pci_device_group(struct device *dev)
 	return iommu_group_alloc();
 }
 
+/* Get the IOMMU group for device on fsl-mc bus */
+struct iommu_group *fsl_mc_device_group(struct device *dev)
+{
+	struct device *cont_dev = fsl_mc_cont_dev(dev);
+	struct iommu_group *group;
+
+	group = iommu_group_get(cont_dev);
+	if (!group)
+		group = iommu_group_alloc();
+	return group;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index f27cb14..dddaca1 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -351,6 +351,14 @@ struct fsl_mc_io {
 #define dev_is_fsl_mc(_dev) (0)
 #endif
 
+/* Macro to check if a device is a container device */
+#define fsl_mc_is_cont_dev(_dev) (to_fsl_mc_device(_dev)->flags & \
+	FSL_MC_IS_DPRC)
+
+/* Macro to get the container device of a MC device */
+#define fsl_mc_cont_dev(_dev) (fsl_mc_is_cont_dev(_dev) ? \
+	(_dev) : (_dev)->parent)
+
 /*
  * module_fsl_mc_driver() - Helper macro for drivers that don't do
  * anything special in module init/exit.  This eliminates a lot of
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7447b0b..209891d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -389,6 +389,8 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
 extern struct iommu_group *pci_device_group(struct device *dev);
 /* Generic device grouping function */
 extern struct iommu_group *generic_device_group(struct device *dev);
+/* FSL-MC device grouping function */
+struct iommu_group *fsl_mc_device_group(struct device *dev);
 
 /**
  * struct iommu_fwspec - per-device IOMMU instance data
-- 
1.9.1

