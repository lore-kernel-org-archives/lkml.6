Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BDBECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B177721479
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cQESUPjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B177721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeIOHGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:06:49 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:63424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728498AbeIOGru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KsndDRrKdzL8fqsF7vY8vK6yZsRErdg0RFzd0yDRao=;
 b=cQESUPjkUy+WSg9jG2pZ2yW6wUmjvHWiAbI6MeuThj/PHMk0BTtTgq0VCfH8w5kAuWIIG/vscZMJyyBMNQCmF/QV4Uz9Vhb/QxRQNZhFVCyTcqiwd6FzGfG/7o+XRXY5NgO834je333SsW1pWHoO8FPzBLV5xD+/SJsw51sEcPw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thierry Reding <treding@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 43/92] drm/nouveau: tegra: Detach from ARM
 DMA/IOMMU mapping
Thread-Topic: [PATCH AUTOSEL 4.18 43/92] drm/nouveau: tegra: Detach from ARM
 DMA/IOMMU mapping
Thread-Index: AQHUTJOp+nVf70l2OkuIOJfvxO4reg==
Date:   Sat, 15 Sep 2018 01:30:19 +0000
Message-ID: <20180915012944.179481-43-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:1QTeycnFyKKH6x8U8ryvF4a9o/XX+IPR8dMYURMBBveNrzp3VFe/9yUTpGzoZs3knnSjZtedQzP1AqJfp0j2WheGd0KzKsiHBZG2etAOqBH1Epg/JwX0Krq2MM40Sk3cmrIiGorTVs5xsBaZtdH1oO9ozeZ82Ebkp0xJBZ/h4bmGb+ktu8uldUh+rwfw6KaF0yQqtX9dZQ1bXMAgNw+tXkopEZyxqyE0Fibyc3/tKaWIsaqfz35fiPsZMfgsSfwc1wx3uq48aZp46T7+9lV07ImnUeqyqd0kMyS3NaPlQY/lQWWc7ktX1bLkl38Lw5VYc6GqtKSwxd6tEyJ3J2fwy8hirnQ+xxDvCnv0SS64tVMKV7K13fjVOMTYO3T7h8tlXgPTfIrxyIjWDVqcMx38ImOVIZKbPRQoAO/VdrjlS8NaUWsdrh4y9exgOgrgZ71Y65GY30rTOTvrUtXlvRZuIA==;5:t6hHtTQbLxosJg4pD7RkfEFzTOOwe/JNGeA0h5EyQ2i8MluAdtRTBpeUBJkZtrGrr091CAYpgBFuKuIKG1X36UJo3vh4QM8d4Pm7fBvwWrjqoIVxBEJKyhWScf5CeOgezonmhnYOgiGVhy810VJUn4X/F9mOX8f28cAf3PglkUs=;7:UyzjM2JBIZwu2o5AWP3iv4mdOmS+7BauJ6CJDJ4YivUmpuIhITfsIcmWhaPoN7Td7QBxB/iR7DIOT8Xke7jPEB754pvLM6VS/ZtDGhEjmiAz/QeotubTMstqaKuv0Jgq1sFmkxWXM1yx+hAu9UgYVGvlBwDQ/MAeadzyTiZVuKKZW95xLazOUmGOcGH8TufIkUL2tBM6gY2WTARKk87ISSd1d0SWFmjbasu3CZPKSsR4v9SOt0TcrPQTkVjiZtQp
x-ms-office365-filtering-correlation-id: 7bb000be-343b-47b3-fce2-08d61aaadd4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB0856738A87B370A3573592B8FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(5024004)(14444005)(76176011)(68736007)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: YpMt7nMXLgscFD8XDhluwE7dFLX7YWK5eNXBvXCZ3UNE33rYTfBcWlWEFrDDWZzgBHuzvEyrBXTStiY8BGFXDY4u1MMBX9SCz8zKl5RaxT7n6PzlxfrZwzRRNF+tSwK0Sx93Qeku4nsF89o1nMt2+dqylcBpMX/KoaidFNq3Dr7g40fEPJg7k69aGz3DSvgBbt73aMrc1f75wfk8mYCY48E5q1JZpavx/mLm0KZ4c90rMkmhVfT+Nc15/ITxXWm/PvDu9/YJ7IzUSM6zmJXnvRydE0KnpgEiP32jMIgOqSIvvvnPMjZvQ6HSuBuxdtAphN8VGmgC5SJ/AThH2KlCy3wpVXX5OMxfsLFLoT+4U84=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb000be-343b-47b3-fce2-08d61aaadd4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:19.7137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index 78597da6313a..0e372a190d3f 100644
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
