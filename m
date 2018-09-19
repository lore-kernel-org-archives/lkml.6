Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF88C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58467214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q6n8O3Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58467214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeISMq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:46:29 -0400
Received: from mail-cys01nam02on0089.outbound.protection.outlook.com ([104.47.37.89]:53472
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbeISMq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo6ZzA+ikK6yBwW85dXIckS0T2aL9S6JZ03Er0zUOd8=;
 b=q6n8O3SaoMYheu4wKaCcBo3QxXnUsUraJNq6MxMRJ50rjHUyS6ZlyB+gspANm+GEXh2GukVwgoeqp0lQI7E04AfLDmKP9Zvg9xwq18G56KSUR7RfwPcnQr2BfH6nOQ7tAKzvoPuRKeAoURjUxXm/UfOJSvPQMOlltta5tv8bVtI=
Received: from CY4PR1201MB2534.namprd12.prod.outlook.com (10.172.121.7) by
 CY4PR1201MB0022.namprd12.prod.outlook.com (10.172.77.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Wed, 19 Sep 2018 07:09:53 +0000
Received: from CY4PR1201MB2534.namprd12.prod.outlook.com
 ([fe80::b08f:8c8e:9b73:a942]) by CY4PR1201MB2534.namprd12.prod.outlook.com
 ([fe80::b08f:8c8e:9b73:a942%9]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 07:09:53 +0000
From:   "An, Jiandi" <Jiandi.An@amd.com>
To:     "airlied@linux.ie" <airlied@linux.ie>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "An, Jiandi" <Jiandi.An@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: [PATCH] drm/virtio: add dma sync for dma mapped virtio gpu
 framebuffer pages
Thread-Topic: [PATCH] drm/virtio: add dma sync for dma mapped virtio gpu
 framebuffer pages
Thread-Index: AQHUT+fDclDjDpRXP0aRLuJQkBOXsw==
Date:   Wed, 19 Sep 2018 07:09:53 +0000
Message-ID: <20180919070931.91168-1-jiandi.an@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DF4PR8401CA0037.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7602::23) To CY4PR1201MB2534.namprd12.prod.outlook.com
 (2603:10b6:903:da::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR1201MB0022;20:epSWnjZhepvrxJZlFh2M4dr4D5+i5ilyjY+dErTJt3ReIjU0vuIalYeOyzGsPbmA5WoR2TApm0lRP6GgegAmQ30h7qPE6BGoyE3MUkX3ANGiVkQ0TRDRr0ldSZEOMIuXcC3QcXJbBBuBnDEHdF74nTI1em9YKxewrkPP/gijHmPt70Ni0mDgSMX54H9V18XFOoayyc0OJX2dwDzZwyI4MDS5yRxA5jnuDWGmRqrLdO0zhhJ65xVVVhoPPnf9w7wz
x-ms-office365-filtering-correlation-id: 047934b0-f370-4554-ac35-08d61dfee5b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB0022;
x-ms-traffictypediagnostic: CY4PR1201MB0022:
x-microsoft-antispam-prvs: <CY4PR1201MB0022C55D0D80DD9443B46D2BFD1C0@CY4PR1201MB0022.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR1201MB0022;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB0022;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(106356001)(6512007)(53936002)(66066001)(5660300001)(26005)(54906003)(110136005)(99286004)(68736007)(105586002)(316002)(6346003)(6486002)(52116002)(6436002)(4326008)(6506007)(2616005)(8936002)(81156014)(81166006)(1076002)(2900100001)(305945005)(14454004)(476003)(6116002)(14444005)(256004)(2201001)(3846002)(478600001)(1857600001)(7736002)(86362001)(102836004)(2501003)(8676002)(186003)(2906002)(486006)(386003)(72206003)(36756003)(5250100002)(97736004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0022;H:CY4PR1201MB2534.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
x-microsoft-antispam-message-info: UZ56XW34l0IQHF78I5TthYgotKpP0NobyZe2sqDN0NGzLkwd+aYWI/MmCEf935aYk6i6LD3vtZt9Zv0/OGxPrs4GGT3yV+LCuE08P3tRaTCl4caXLun6G4e+O0fjBf+uH3rQ5M3c7RB5TYEGC1nIK2dXH78YODIjPjj2V0GYwkamoe0sON7GvpCzfPiwtnUURGeRXZ4UjSFPnFi2h4qFMIusrXYZUBaLZTJdFs6ObN1040NEnaq7UHjmuWfmPS0/X8TredwkmYVh3Z0jUNd/9BMwW/y1z2sUlt7OmlWLaXEgqfgbeg7MYxV/qjIHE2LJQR0/0A6+JHP4ewPygNXSXhwAc7ZpXUctStM9w41p0g0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047934b0-f370-4554-ac35-08d61dfee5b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 07:09:53.6551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With virtio gpu ttm-pages being dma mapped, dma sync is needed when
swiotlb is used as bounce buffers, before TRANSFER_TO_HOST_2D/3D
commands are sent.

Signed-off-by: Jiandi An <jiandi.an@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  8 ++++++++
 drivers/gpu/drm/virtio/virtgpu_fb.c  |  7 -------
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index ec9a38f99558..4dafe712c81b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -36,6 +36,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
@@ -132,6 +133,13 @@ struct virtio_gpu_framebuffer {
 #define to_virtio_gpu_framebuffer(x) \
 	container_of(x, struct virtio_gpu_framebuffer, base)
=20
+struct virtio_gpu_fbdev {
+	struct drm_fb_helper           helper;
+	struct virtio_gpu_framebuffer  vgfb;
+	struct virtio_gpu_device       *vgdev;
+	struct delayed_work            work;
+};
+
 struct virtio_gpu_mman {
 	struct ttm_bo_global_ref        bo_global_ref;
 	struct drm_global_reference	mem_global_ref;
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/v=
irtgpu_fb.c
index b5cebc9a179a..b9678c4082ac 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -29,13 +29,6 @@
=20
 #define VIRTIO_GPU_FBCON_POLL_PERIOD (HZ / 60)
=20
-struct virtio_gpu_fbdev {
-	struct drm_fb_helper           helper;
-	struct virtio_gpu_framebuffer  vgfb;
-	struct virtio_gpu_device       *vgdev;
-	struct delayed_work            work;
-};
-
 static int virtio_gpu_dirty_update(struct virtio_gpu_framebuffer *fb,
 				   bool store, int x, int y,
 				   int width, int height)
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index bf631d32d497..817ba156514e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -490,6 +490,15 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_=
gpu_device *vgdev,
 {
 	struct virtio_gpu_transfer_to_host_2d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
+	struct virtio_gpu_fbdev *vgfbdev =3D vgdev->vgfbdev;
+	struct virtio_gpu_framebuffer *fb =3D &vgfbdev->vgfb;
+	struct virtio_gpu_object *obj =3D gem_to_virtio_gpu_obj(fb->base.obj[0]);
+	bool use_dma_api =3D !virtio_has_iommu_quirk(vgdev->vdev);
+
+	if (use_dma_api)
+		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
+				       obj->pages->sgl, obj->pages->nents,
+				       DMA_TO_DEVICE);
=20
 	cmd_p =3D virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
@@ -788,6 +797,15 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_=
gpu_device *vgdev,
 {
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
+	struct virtio_gpu_fbdev *vgfbdev =3D vgdev->vgfbdev;
+	struct virtio_gpu_framebuffer *fb =3D &vgfbdev->vgfb;
+	struct virtio_gpu_object *obj =3D gem_to_virtio_gpu_obj(fb->base.obj[0]);
+	bool use_dma_api =3D !virtio_has_iommu_quirk(vgdev->vdev);
+
+	if (use_dma_api)
+		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
+				       obj->pages->sgl, obj->pages->nents,
+				       DMA_TO_DEVICE);
=20
 	cmd_p =3D virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
--=20
2.17.1

