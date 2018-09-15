Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A753AECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C51B208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IoWwKMOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C51B208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbeIOGvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:42 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729633AbeIOGvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCiwNgzMRsCi8ZyI/cp3bZDG58NN+XxS8oFOniNCB1o=;
 b=IoWwKMOu8nkm+HJvd4QnIbjL2Lca7p0Lbjn8YU6WhM+3+LhpLiu2vodsFIVKeVnuI0LHGJU6yxlB919W9X4LYcSrVIHZPcr/Bt5VG6N6VdM0PK5foa0HD398gj6hiIBACV7vkM70CDaBY/6JN8wJjHi0ZsdFOVGMlR+phpQO0Ow=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thierry Reding <treding@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 16/34] drm/nouveau: tegra: Detach from ARM
 DMA/IOMMU mapping
Thread-Topic: [PATCH AUTOSEL 4.9 16/34] drm/nouveau: tegra: Detach from ARM
 DMA/IOMMU mapping
Thread-Index: AQHUTJRCUSrIrzYk9U6Mfjvm4+Ot6w==
Date:   Sat, 15 Sep 2018 01:34:35 +0000
Message-ID: <20180915013422.180023-16-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:RhAOt1fGnVa1vrhKxq0xsuELpw1YUdaGLj+0QRlggNzPqLfxNafE7BXFcY1FMJCu5D9Xqoeu7m5D7aia3A32o38tND6/TmWQ3yo9tVf6IyJFKRQL453NYPYHGXaQtQ7djygThc953S8h3spkUyV5vjNwKn01E+JmB9dy2X8Hq5w6lLOGeiA2Dq903p8rvPvsKZh8RxWxl0nleMrPAZl4SEH+7yfNpSrLBZhj7eeolh3lMJAD2uM15GujrOP5Yl2uy0E0FbpA94NNDuf9gEK/IchsIdjy8tdO1itpOWTzdKbqVIPx3xF64WRX6E/e3h1OQoRL4le7+gN1R7H6unoR8GJrGcyaPmpn/whkLJMLx9n7WGLAwHhtjY+IBXsMjVlmWSXJBOJZQBsyLn5VWgM8du3y6pQ39FwUIKlvZJyRWG2Ta3PyoQLj9iPO4NYnzrsLemr8+xhLWrKA2RGlEOkqfQ==;5:79Fslji0gT2PSwa0xsB+CxXNX81gUSXOR71f3AZzodrMJn4w3CZSpWR9iKkraRSQE6FGNDDScSkl/U+p1yTsrw5WB+aJVLiuSZHspKwlD54fQmPb4aV2+D+upO6LIT4ppJRW5ibdVdBSpP3i+Vb3+66strRghGMatXskA8BEvz8=;7:WQCn37tHTHpDtQVcHpvuP6QbRtBj+U/8l+xa9rGN7w4N5jamSTCSJiHBX8pJCOue83ljbcFfqi9NILx9mziEA5ypY1BcHiJpnZyVNZhZBxJiGl3K88JdR5407JGGgd5pmgJJ600o3i9R2Sq5k4GD930zgMql4ZsnmijHMxyDwsuY4i2jkl0BEuVIWaCnYjuCY06GPHzHQb6LEXRMD6Z/l+cqYVgUYkX6cKEXNFipFqOYBk5+zxwhjXNgoe0QuCaX
x-ms-office365-filtering-correlation-id: 45967de7-5147-4efe-aa89-08d61aab6508
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB0823CEF8BEE17C6CBDB4A67CFB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(5024004)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: dnR/ZCXGvaKfcBF+1XixdkWj/x3S3ROuvrhq2CXjRTr0xuzSPgiyo7pmKD8DBd7aUVslD4IHq9csce3McKDqbShuMkQGkYu9YRRoi673dUl7+/H95vzXU4qtvtH1H2N35C55sPPH0GV3yBli45K+VPCeyskU2QvCMNxuYQUVlDgr6s2/D619dyXlqrezXvKsROznF0WgGl4mJl8Acqd0FZVNkwf4LhpfWOa4oRli9atXrTP/H/OVm3BL2Ku7krCp6+I7d1KNm+AECfdklXJyYOTXM9Em3UFmemD+oddXEmSEpPrw7xvUZf3BQFOflpMQ8gLaR5NTKgNpmjshu0p7WFRfTCZq4BvmEBgcsjDN0RU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45967de7-5147-4efe-aa89-08d61aab6508
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:35.5050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit b59fb482b52269977ee5de205308e5b236a03917 ]

Depending on the kernel configuration, early ARM architecture setup code
may have attached the GPU to a DMA/IOMMU mapping that transparently uses
the IOMMU to back the DMA API. Tegra requires special handling for IOMMU
backed buffers (a special bit in the GPU's MMU page tables indicates the
memory path to take: via the SMMU or directly to the memory controller).
Transparently backing DMA memory with an IOMMU prevents Nouveau from
properly handling such memory accesses and causes memory access faults.

As a side-note: buffers other than those allocated in instance memory
don't need to be physically contiguous from the GPU's perspective since
the GPU can map them into contiguous buffers using its own MMU. Mapping
these buffers through the IOMMU is unnecessary and will even lead to
performance degradation because of the additional translation. One
exception to this are compressible buffers which need large pages. In
order to enable these large pages, multiple small pages will have to be
combined into one large (I/O virtually contiguous) mapping via the
IOMMU. However, that is a topic outside the scope of this fix and isn't
currently supported. An implementation will want to explicitly create
these large pages in the Nouveau driver, so detaching from a DMA/IOMMU
mapping would still be required.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/device/tegra.c
index 9b638bd905ff..d370bf8bc409 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -23,6 +23,10 @@
 #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
 #include "priv.h"
=20
+#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
+#include <asm/dma-iommu.h>
+#endif
+
 static int
 nvkm_device_tegra_power_up(struct nvkm_device_tegra *tdev)
 {
@@ -95,6 +99,15 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *=
tdev)
 	unsigned long pgsize_bitmap;
 	int ret;
=20
+#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
+	if (dev->archdata.mapping) {
+		struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
+
+		arm_iommu_detach_device(dev);
+		arm_iommu_release_mapping(mapping);
+	}
+#endif
+
 	if (!tdev->func->iommu_bit)
 		return;
=20
--=20
2.17.1
