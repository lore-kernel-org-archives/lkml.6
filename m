Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952FFECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A46208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fz+bURwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A46208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbeIOGwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:30 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:18669
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729865AbeIOGw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1ZCiznIhelSl0hDUNlXUleUIMH/FRegd1i7oxVgzxU=;
 b=fz+bURwd2S55Uce2RKWRwqbtoLoSJs4ix5MICy/9+1oVTUnXvuNXKcDXCUruwkwlbnQ/Rizg4gaTHaHzR0rQtpxssML0pevctj1iPiU0qegDgx/vogMkDDcD9caep6QwqkHVv8z74Yh0MxgI90X/sqwlf/vLmC1kfZ8Rp723TiI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thierry Reding <treding@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 09/20] drm/nouveau: tegra: Detach from ARM
 DMA/IOMMU mapping
Thread-Topic: [PATCH AUTOSEL 4.4 09/20] drm/nouveau: tegra: Detach from ARM
 DMA/IOMMU mapping
Thread-Index: AQHUTJRXANohlmzDakSdVGlRcudntA==
Date:   Sat, 15 Sep 2018 01:35:10 +0000
Message-ID: <20180915013502.180110-9-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:IcdrFeGGY9irhxCMMbxAY7iNJVSW/8bAjjRnmAVigZKwNFXv16dXiaSVwHgNWrPHA+FvlCF3FofASmsx0pPFj+9fHT8uEjyH4LtxuSIKBiCcDmID1YK7KKpELzMsRWDu1wCXKSiygM3VNRv9mAZjRVN+bkyvnRRnS9sQ3Aiih+MyPrcRm0xXglN8A84imW9Wed+xEX1KVYPAGpkCfQ+HpMqGsuG/oB/9t68N+NV+UHgFzEyZqCz5CSVie4KB1DUnhHG8hzGSR7j+S7JqJhEmiaYZFJcuBd5Obtju/PXGjORCdZLUiPSmT4MQkjdfcbuqtzDbNtwUPx7/kQ8JiqMr/YEMWMuIroUJGHPRaiHax7wwpWOuhcjvhdhbHWSvOacG4d9c8FOoKwsSlgLOaw2OOnHAhZDJHTeU6kl2fK4Qnbb3xXmLrNTxujd8XRtqBPPGiIjfSce8LWHLIYQR2og0bA==;5:APqJWd0oct6HxFs330dnna+vweqo0ZFkQaN+bZ2mYcHC1i+Wksr3U+Z/DpCEz7NNIzGpAmSsbP7PZP8Nn5LnSy4Pi2ZH2pRe/vGcyvfmJUPTDgOsjIBrqVmRK/MBKXQtULlo5+xE6DwtF3heEPSczQvsXfW4ov9A9tvvTRgzcv8=;7:iZa+2GHbcFkEmbCxknpxoA1QyrWuE7bsYUcpnXe9vSk8lSLLklRUqpjZj7E0H64vrLLOFXX66cuRhmF/xV4IO+pgv6kpJ1+EsMlTLyZ5wbiQ1Dx3zl4GhboShcK/PGvCZ7onriUHqrb2Av5q5el6th4zCYrz4v7j/DB/0a2mZiiKhBCmyalH2wiVc9fSupUliIxJyXs9x8FXjyF8uiVDYuhd2CQchXRvbWa0r1WXYub8V1CNEbc+o4DI1fd6KQv5
x-ms-office365-filtering-correlation-id: fa44ae73-36e7-4547-4179-08d61aab7fab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB018180B637A05D8CB6F93B5DFB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(5024004)(256004)(14444005)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: d2obNiA361CqqL9UCPZzA2dw9+7boe76YUR5B6Jwj76hc732CYcy37BIsObrVTe4lpVQbDjVJ3DuLHHYvdKIXJK5QhjCu4qkIxMBQkGj2xjZhri/VeNiGap1HPK7oEsh7VdAnlkjmQgWe9zeY7MKvn2v9q1IN66/4luYQ1Z+/hg4VuzHmMO1/9nqj/xxILw/5O+FXhY8nPd5I+xX31TVTqAmdrr2rAIRfS0ruTyIPV2M8XhMMv1Ysi9KcgOU44c2eYvlrukZQ3mPHLmOlcr1746EDKzY+kJ4GcMXbGt8QOdod2VOdFH+orlP8HTNkraFxTpV0Xxvi0ZMpXLQquHgmkFEmG1Oi9Hkzw1K3jz0F/4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa44ae73-36e7-4547-4179-08d61aab7fab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:10.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index e7e581d6a8ff..1bfc4807ce5b 100644
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
@@ -85,6 +89,15 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *=
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
