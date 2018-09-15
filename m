Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D80ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77F3208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X2vYUsAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77F3208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeIOGuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:21 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:38374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725744AbeIOGuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP+zBLkiOsjuKuCv8r7pGbLsrDS0bV4yCFhCcPTdBxo=;
 b=X2vYUsAVdKsQkbhQETOaWDavaHYMW5lAFrp9kalNMIINrH8eGHItSFkMyYMcOgjXI+j/IHcBK6kauvth4EPFDZzBRPeOPICVZKI2IMEtq1sMkCseHH6IRU4e9z+0+gP2oMonZCd0CmETtlxByezumW06ZrOxJcv7xqGpkhndKnE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thierry Reding <treding@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 31/57] drm/nouveau: tegra: Detach from ARM
 DMA/IOMMU mapping
Thread-Topic: [PATCH AUTOSEL 4.14 31/57] drm/nouveau: tegra: Detach from ARM
 DMA/IOMMU mapping
Thread-Index: AQHUTJQCIs5QaNZ5VkGQUZg+KY3kng==
Date:   Sat, 15 Sep 2018 01:32:48 +0000
Message-ID: <20180915013223.179909-31-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:qVp1rxSSgfKj5OBO6qkmFqsAv5XUkwOxdx+FudyObBw4SyL7G4L/hCtLZF+HgNDIgafW1RVaf2gHXbJQFd/PVsPv+fRHHaqusaqdvMPb3m7qd+chuoJhmD+RNqPeVCtCwhgoGPe0mmRHqiyvJ/rcKwNUdX0TP1IUzx1/8i9SEpGEUDnEoA7CEhmLPmKwO0Ns+AS5xMzDTRxoB26p3cW1CwFVPn+n6rtrgFIZXzoDJuwWpsUpXxmRdMvhwkT6rphVU3mnE6xUIf0xC2wbNhiTvP2qRR05nx/xoAIfumfOzwrwYjJtE2/ahdpxNVYxu+lESa92qtpe3nQGlMcl5hzGpKs8WsCvpUdsdSZzh/yngRQCNBrWJJExMDgET0w2YdhZ85Iwc85lrxLh5ZHqkH6jKF9cqkkp0f5RcoEpydcNkrK9/AgKvNGgkOLqP3zESq60vux+SeVSo3P6StojTQw59A==;5:uEjrL6f4LTOzH2g0yHdxpa5+wrB12vlWt85vUJxK4L7kpU9nCb8IICQmUxlImFsI3CWSLwuFznL7USVd3eI2hcwM4t7NmGAr52Q3av95wbWtNu3pz5REqKNdC6Cjjvbcehw8GC4gac9/5W0lzvk7EzqCGbihAs4a/sPwrR1xeUk=;7:SozSuFM5T4+HJB0xs3RwC//eV93mAEO0cGJ7ruWWq1a6qQ+qA01ibp9aCfna9RolaoG/QEg/Vtd/cY2WGpaJ38TZgCIKFDm6nC4k42sbPrdvINRDgkg9IRMfA5J7YGGEJJdZKWLiAqsW07FC9kTq4N+NK2wJVxTbf/He9Y7x3krx/R5TfKVHT5tpaxDRodldyCd49ead/pR1SxFB+5XrgtPJHYEGkK/Vy1RcZXAmNQOIRBEsooNw72d1kyMIYqTK
x-ms-office365-filtering-correlation-id: a6bfc583-6691-4dc7-a093-08d61aab375a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB047170530D356292542F28A7FB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(5024004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: elkcB06wPyXZct7aoPpD6tTL65KEafB8YkPBBei7ON3dQ5vZQ4qzadldnncC3HHWs8L+gylGF37Plb8tJNIXfkEx1TJmnc2qdrnTxzdzWQfZoI593GA3fxHy0OGV3yiJ4AnTSDx7dK0ElO5fe8h7//1eCY/Uy9jnAOG5725WZqEMQ+Q5UjnDGtHZe/E0rDI2wNQzQowDyxHoYkeK0afNZUCCZdAshSucKEt619qkHLSPXQ0Rv2VU/6fkyCfpaNX6QwV9SZgql3kmZd6of5hegFebnqslxeK6bWSQCTy3+4Yl9sE5WJkfvE4q23ETZoCSN4j58S0ohYGeicr2LKJBLheRS+P2tWjRqufkicYrzUE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bfc583-6691-4dc7-a093-08d61aab375a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:48.8525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index 189ed80e21ff..fa1ead337c23 100644
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
@@ -105,6 +109,15 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra=
 *tdev)
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
