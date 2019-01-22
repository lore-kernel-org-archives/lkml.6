Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3C6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1D3218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ip3JbZ8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfAVJYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:24:06 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:18912
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbfAVJYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZPnPRJWZWAcqTltd54+6+bbAEhalb0N4hv5vyQjOvk=;
 b=Ip3JbZ8Kfx8gNMjE1+mURbnf5d67tK1XdUeGtVjZCqclEQAWeEikXqNOXqj8BAVBcSyOSXH+gqKSh7yoaYFM+4QvQFerp0qevLGFhU3SdcJShbG0aURdZ7ZuCehzeJeW4OwbeXKtJwcW4Gwr6si8jXf+Qk/S1Cq8dMC2Qb/rbro=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1928.eurprd08.prod.outlook.com (10.168.83.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Tue, 22 Jan 2019 09:23:40 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:23:40 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 1/7] drm/komeda: Add d71_enum_resources and d71_cleanup
Thread-Topic: [PATCH v2 1/7] drm/komeda: Add d71_enum_resources and
 d71_cleanup
Thread-Index: AQHUsjQp+mvV9WFVFkiTNASdT0mcNQ==
Date:   Tue, 22 Jan 2019 09:23:40 +0000
Message-ID: <20190122092243.21226-2-james.qian.wang@arm.com>
References: <20190122092243.21226-1-james.qian.wang@arm.com>
In-Reply-To: <20190122092243.21226-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYCPR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:10:e::27) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1928;6:DmJxBU7iEKYVCQX5v4+RPiPc0IZ2gbfOuyRd37hCJ4AYX69q7AVKnQpIMmSKdCd1oj07C+SKY95E29HyEkUl39hAOHAHlNmgQ8dvOAcAYQlHdpqa5C6JztlsmBOlAf9+zXOljisx5AVMX2zBHMR4JjUuK5bm7FfgIztk47ieFT/VBi9l7sEyCdkkQ72flyjm/JB46fUIrK8iToo6itdrqC07kWjflIljeLNLUhwWdTxGWIG+1SuiINZWxQVwWSUJ8fiJOV/Q3/SE6HDvuG4dh+/pYdxeq588+HJhXAQqjEMqE5T7YFR8w83r+TtGxZ9LLWmRReQ/tHLV6h2ARWx0yPDxwsd3UPcBHEqIQAzWZMTFy8a6WaOfbD+/X+1dpAx3urwwcSd+x+MxB5WL5FpZMtL3M0kAc1HbdytytDmSVMUgxvukJh5VF/BaTQPMDkXHGNAqLmcm+3IbAPNBfptY5Q==;5:xsrjd2wUkXSfCEtSCwMZIK7vsHXQu1gyO/GRt56aIRua/t0lGyYdVUS5sKSYuE/y+fF1GnB09wwCZlW4+rCzBOJl2j6MjpmCgLLX5qu/kMNpXmsQRRNTudjicasFBSjmDtSJqQwd+WJVdTNW4zdbj/Tyfkecvyl2uwI3LGrUVbrCM0/JLNcExYxdAX3mQsRQWT7qUAYSLw9pW6eIqaBBDg==;7:M94aJsI82k+oxldYbunxxXdU91IIYUfVXtGIKJMVrEnHXZ/1rkDJ7lFoYBw1/6Zm79Y3VH23dmqCdbAlOOaXMuSwe98zPEYsgbuq8Sgec6V7yo83zTlOcyOXjM4W3jbeq73T7Yrnza94iVU+UaSTOA==
x-ms-office365-filtering-correlation-id: 8a24e6b4-6261-4e5b-915e-08d6804b4ad1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1928;
x-ms-traffictypediagnostic: DB6PR0801MB1928:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1928F6A9211F87B4DA367E7AB3980@DB6PR0801MB1928.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(3846002)(76176011)(99286004)(26005)(486006)(6116002)(71200400001)(110136005)(2906002)(71190400001)(316002)(103116003)(256004)(305945005)(19627235002)(14444005)(7736002)(53936002)(81166006)(8676002)(81156014)(54906003)(6436002)(6486002)(50226002)(2501003)(66066001)(68736007)(6512007)(106356001)(105586002)(52116002)(53946003)(6346003)(8936002)(1076003)(4326008)(6636002)(30864003)(476003)(97736004)(2616005)(478600001)(446003)(86362001)(102836004)(11346002)(14454004)(6506007)(386003)(186003)(55236004)(36756003)(25786009)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1928;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6BpPzUYnsFl1C1Q04TzdxqR21KbrxHk2W0OASfG73JcS1kr2RMh6YhOY0BCc2pJg7QuyYNfGFO/zjGLfuD81Y3LLgF87OE+m1ew9v4/6A1Td4/FLvhzXr4VsvJv+EL1NSNwqmti5INWiGI9t2chvwniLwpsoYgnlfNjAxFQgzTqkbA9D6eikpFk2qQlODAoEmrvJZHMrz5Pzg5iyuR+PSWu3X1FQnunfPIyNhm2t/UCIe0spw9jLJ9RhW91CQ+i7VT8ZGbqgBJGlex/JpgvmhK6kqzeMtnMrOd9ac6kExsooz5jttZ8WCY3CK9dZSbd+T4xr0CEY2tZpG7Rg9b9hG1F9+EgZoA1I5QZyeOFjh5jt/QGwkeQfz5CvGsGyGvJCSUrf8xYlr0OSJfL4tkccPRDFLncnJl0jQFL7dzicolg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a24e6b4-6261-4e5b-915e-08d6804b4ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:23:30.4716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

D71 consists of a number of Register Blocks, every Block controls a
specific HW function, every block has a common block_header to represent
its type and pipeline information.

GCU (Global Control Unit) is the first Block which describe the global
information of D71 HW, Like number of block contained and the number of
pipeline supported.

So the d71_enum_resources parsed GCU and create pipeline according
the GCU configuration, and then iterate and detect the blocks that
indicated by the GCU and block_header.

And this change also added two struct d71_dev/d71_pipeline to extend
komeda_dev/komeda_pipeline to add some d71 only members.

v2:
- Return the specific errno not -1.
- Use DRM_DEBUG as default debug msg printer.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/include/malidp_utils.h    |  12 +
 drivers/gpu/drm/arm/display/komeda/Makefile   |   3 +-
 .../arm/display/komeda/d71/d71_component.c    | 120 ++++
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 138 ++++-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.h  |  50 ++
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 530 ++++++++++++++++++
 .../drm/arm/display/komeda/komeda_pipeline.c  |  16 +-
 7 files changed, 852 insertions(+), 17 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h

diff --git a/drivers/gpu/drm/arm/display/include/malidp_utils.h b/drivers/g=
pu/drm/arm/display/include/malidp_utils.h
index 63cc47cefcf8..b7bf8db39a64 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_utils.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_utils.h
@@ -13,4 +13,16 @@
 #define dp_for_each_set_bit(bit, mask) \
 	for_each_set_bit((bit), ((unsigned long *)&(mask)), sizeof(mask) * 8)
=20
+#define dp_wait_cond(__cond, __tries, __min_range, __max_range)	\
+({							\
+	int num_tries =3D __tries;			\
+	while (!__cond && (num_tries > 0)) {		\
+		usleep_range(__min_range, __max_range);	\
+		if (__cond)				\
+			break;				\
+		num_tries--;				\
+	}						\
+	num_tries;					\
+})
+
 #endif /* _MALIDP_UTILS_ */
diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index 1b875e5dc0f6..d593125236ae 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -16,6 +16,7 @@ komeda-y :=3D \
 	komeda_private_obj.o
=20
 komeda-y +=3D \
-	d71/d71_dev.o
+	d71/d71_dev.o \
+	d71/d71_component.o
=20
 obj-$(CONFIG_DRM_KOMEDA) +=3D komeda.o
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
new file mode 100644
index 000000000000..18a36dd71567
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include "d71_dev.h"
+#include "komeda_kms.h"
+#include "malidp_io.h"
+
+static int d71_layer_init(struct d71_dev *d71,
+			  struct block_header *blk, u32 __iomem *reg)
+{
+	DRM_DEBUG("Detect D71_Layer.\n");
+
+	return 0;
+}
+
+static int d71_wb_layer_init(struct d71_dev *d71,
+			     struct block_header *blk, u32 __iomem *reg)
+{
+	DRM_DEBUG("Detect D71_Wb_Layer.\n");
+
+	return 0;
+}
+
+static int d71_compiz_init(struct d71_dev *d71,
+			   struct block_header *blk, u32 __iomem *reg)
+{
+	DRM_DEBUG("Detect D71_compiz.\n");
+
+	return 0;
+}
+
+static int d71_improc_init(struct d71_dev *d71,
+			   struct block_header *blk, u32 __iomem *reg)
+{
+	DRM_DEBUG("Detect D71_improc.\n");
+
+	return 0;
+}
+
+static int d71_timing_ctrlr_init(struct d71_dev *d71,
+				 struct block_header *blk, u32 __iomem *reg)
+{
+	DRM_DEBUG("Detect D71_timing_ctrlr.\n");
+
+	return 0;
+}
+
+int d71_probe_block(struct d71_dev *d71,
+		    struct block_header *blk, u32 __iomem *reg)
+{
+	struct d71_pipeline *pipe;
+	int blk_id =3D BLOCK_INFO_BLK_ID(blk->block_info);
+
+	int err =3D 0;
+
+	switch (BLOCK_INFO_BLK_TYPE(blk->block_info)) {
+	case D71_BLK_TYPE_GCU:
+		break;
+
+	case D71_BLK_TYPE_LPU:
+		pipe =3D d71->pipes[blk_id];
+		pipe->lpu_addr =3D reg;
+		break;
+
+	case D71_BLK_TYPE_LPU_LAYER:
+		err =3D d71_layer_init(d71, blk, reg);
+		break;
+
+	case D71_BLK_TYPE_LPU_WB_LAYER:
+		err =3D d71_wb_layer_init(d71, blk, reg);
+		break;
+
+	case D71_BLK_TYPE_CU:
+		pipe =3D d71->pipes[blk_id];
+		pipe->cu_addr =3D reg;
+		err =3D d71_compiz_init(d71, blk, reg);
+		break;
+
+	case D71_BLK_TYPE_CU_SPLITTER:
+	case D71_BLK_TYPE_CU_SCALER:
+	case D71_BLK_TYPE_CU_MERGER:
+		break;
+
+	case D71_BLK_TYPE_DOU:
+		pipe =3D d71->pipes[blk_id];
+		pipe->dou_addr =3D reg;
+		break;
+
+	case D71_BLK_TYPE_DOU_IPS:
+		err =3D d71_improc_init(d71, blk, reg);
+		break;
+
+	case D71_BLK_TYPE_DOU_FT_COEFF:
+		pipe =3D d71->pipes[blk_id];
+		pipe->dou_ft_coeff_addr =3D reg;
+		break;
+
+	case D71_BLK_TYPE_DOU_BS:
+		err =3D d71_timing_ctrlr_init(d71, blk, reg);
+		break;
+
+	case D71_BLK_TYPE_GLB_LT_COEFF:
+		break;
+
+	case D71_BLK_TYPE_GLB_SCL_COEFF:
+		d71->glb_scl_coeff_addr[blk_id] =3D reg;
+		break;
+
+	default:
+		DRM_ERROR("Unknown block (block_info: 0x%x) is found\n",
+			  blk->block_info);
+		err =3D -EINVAL;
+		break;
+	}
+
+	return err;
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index edbf9daa1545..b87ffae62dbe 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -4,13 +4,139 @@
  * Author: James.Qian.Wang <james.qian.wang@arm.com>
  *
  */
+#include "d71_dev.h"
 #include "malidp_io.h"
-#include "komeda_dev.h"
+
+static int d71_reset(struct d71_dev *d71)
+{
+	u32 __iomem *gcu =3D d71->gcu_addr;
+	int ret;
+
+	malidp_write32_mask(gcu, BLK_CONTROL,
+			    GCU_CONTROL_SRST, GCU_CONTROL_SRST);
+
+	ret =3D dp_wait_cond(!(malidp_read32(gcu, BLK_CONTROL) & GCU_CONTROL_SRST=
),
+			   100, 1000, 10000);
+
+	return ret > 0 ? 0 : -ETIMEDOUT;
+}
+
+void d71_read_block_header(u32 __iomem *reg, struct block_header *blk)
+{
+	int i;
+
+	blk->block_info =3D malidp_read32(reg, BLK_BLOCK_INFO);
+	if (BLOCK_INFO_BLK_TYPE(blk->block_info) =3D=3D D71_BLK_TYPE_RESERVED)
+		return;
+
+	blk->pipeline_info =3D malidp_read32(reg, BLK_PIPELINE_INFO);
+
+	/* get valid input and output ids */
+	for (i =3D 0; i < PIPELINE_INFO_N_VALID_INPUTS(blk->pipeline_info); i++)
+		blk->input_ids[i] =3D malidp_read32(reg + i, BLK_VALID_INPUT_ID0);
+	for (i =3D 0; i < PIPELINE_INFO_N_OUTPUTS(blk->pipeline_info); i++)
+		blk->output_ids[i] =3D malidp_read32(reg + i, BLK_OUTPUT_ID0);
+}
+
+static void d71_cleanup(struct komeda_dev *mdev)
+{
+	struct d71_dev *d71 =3D mdev->chip_data;
+
+	if (!d71)
+		return;
+
+	devm_kfree(mdev->dev, d71);
+	mdev->chip_data =3D NULL;
+}
=20
 static int d71_enum_resources(struct komeda_dev *mdev)
 {
-	/* TODO add enum resources */
-	return -1;
+	struct d71_dev *d71;
+	struct komeda_pipeline *pipe;
+	struct block_header blk;
+	u32 __iomem *blk_base;
+	u32 i, value, offset;
+	int err;
+
+	d71 =3D devm_kzalloc(mdev->dev, sizeof(*d71), GFP_KERNEL);
+	if (!d71)
+		return -ENOMEM;
+
+	mdev->chip_data =3D d71;
+	d71->mdev =3D mdev;
+	d71->gcu_addr =3D mdev->reg_base;
+	d71->periph_addr =3D mdev->reg_base + (D71_BLOCK_OFFSET_PERIPH >> 2);
+
+	err =3D d71_reset(d71);
+	if (err) {
+		DRM_ERROR("Fail to reset d71 device.\n");
+		goto err_cleanup;
+	}
+
+	/* probe GCU */
+	value =3D malidp_read32(d71->gcu_addr, GLB_CORE_INFO);
+	d71->num_blocks =3D value & 0xFF;
+	d71->num_pipelines =3D (value >> 8) & 0x7;
+
+	if (d71->num_pipelines > D71_MAX_PIPELINE) {
+		DRM_ERROR("d71 supports %d pipelines, but got: %d.\n",
+			  D71_MAX_PIPELINE, d71->num_pipelines);
+		err =3D -EINVAL;
+		goto err_cleanup;
+	}
+
+	/* probe PERIPH */
+	value =3D malidp_read32(d71->periph_addr, BLK_BLOCK_INFO);
+	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH) {
+		DRM_ERROR("access blk periph but got blk: %d.\n",
+			  BLOCK_INFO_BLK_TYPE(value));
+		err =3D -EINVAL;
+		goto err_cleanup;
+	}
+
+	value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
+
+	d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
+	d71->max_vsize		=3D 4096;
+	d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
+	d71->supports_dual_link	=3D value & PERIPH_SPLIT_EN ? true : false;
+	d71->integrates_tbu	=3D value & PERIPH_TBU_EN ? true : false;
+
+	for (i =3D 0; i < d71->num_pipelines; i++) {
+		pipe =3D komeda_pipeline_add(mdev, sizeof(struct d71_pipeline),
+					   NULL);
+		if (IS_ERR(pipe)) {
+			err =3D PTR_ERR(pipe);
+			goto err_cleanup;
+		}
+		d71->pipes[i] =3D to_d71_pipeline(pipe);
+	}
+
+	/* loop the register blks and probe */
+	i =3D 2; /* exclude GCU and PERIPH */
+	offset =3D D71_BLOCK_SIZE; /* skip GCU */
+	while (i < d71->num_blocks) {
+		blk_base =3D mdev->reg_base + (offset >> 2);
+
+		d71_read_block_header(blk_base, &blk);
+		if (BLOCK_INFO_BLK_TYPE(blk.block_info) !=3D D71_BLK_TYPE_RESERVED) {
+			err =3D d71_probe_block(d71, &blk, blk_base);
+			if (err)
+				goto err_cleanup;
+			i++;
+		}
+
+		offset +=3D D71_BLOCK_SIZE;
+	}
+
+	DRM_DEBUG("total %d (out of %d) blocks are found.\n",
+		  i, d71->num_blocks);
+
+	return 0;
+
+err_cleanup:
+	d71_cleanup(mdev);
+	return err;
 }
=20
 #define __HW_ID(__group, __format) \
@@ -93,13 +219,9 @@ static void d71_init_fmt_tbl(struct komeda_dev *mdev)
 static struct komeda_dev_funcs d71_chip_funcs =3D {
 	.init_format_table =3D d71_init_fmt_tbl,
 	.enum_resources	=3D d71_enum_resources,
-	.cleanup	=3D NULL,
+	.cleanup	=3D d71_cleanup,
 };
=20
-#define GLB_ARCH_ID		0x000
-#define GLB_CORE_ID		0x004
-#define GLB_CORE_INFO		0x008
-
 struct komeda_dev_funcs *
 d71_identify(u32 __iomem *reg_base, struct komeda_chip_info *chip)
 {
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.h
new file mode 100644
index 000000000000..7465c57d9774
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#ifndef _D71_DEV_H_
+#define _D71_DEV_H_
+
+#include "komeda_dev.h"
+#include "komeda_pipeline.h"
+#include "d71_regs.h"
+
+struct d71_pipeline {
+	struct komeda_pipeline base;
+
+	/* d71 private pipeline blocks */
+	u32 __iomem	*lpu_addr;
+	u32 __iomem	*cu_addr;
+	u32 __iomem	*dou_addr;
+	u32 __iomem	*dou_ft_coeff_addr; /* forward transform coeffs table */
+};
+
+struct d71_dev {
+	struct komeda_dev *mdev;
+
+	int	num_blocks;
+	int	num_pipelines;
+	int	num_rich_layers;
+	u32	max_line_size;
+	u32	max_vsize;
+	u32	supports_dual_link : 1;
+	u32	integrates_tbu : 1;
+
+	/* global register blocks */
+	u32 __iomem	*gcu_addr;
+	/* scaling coeffs table */
+	u32 __iomem	*glb_scl_coeff_addr[D71_MAX_GLB_SCL_COEFF];
+	u32 __iomem	*periph_addr;
+
+	struct d71_pipeline *pipes[D71_MAX_PIPELINE];
+};
+
+#define to_d71_pipeline(x)	container_of(x, struct d71_pipeline, base)
+
+int d71_probe_block(struct d71_dev *d71,
+		    struct block_header *blk, u32 __iomem *reg);
+void d71_read_block_header(u32 __iomem *reg, struct block_header *blk);
+
+#endif /* !_D71_DEV_H_ */
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/drivers/gp=
u/drm/arm/display/komeda/d71/d71_regs.h
new file mode 100644
index 000000000000..2d5e6d00b42c
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
@@ -0,0 +1,530 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#ifndef _D71_REG_H_
+#define _D71_REG_H_
+
+/* Common block registers offset */
+#define BLK_BLOCK_INFO		0x000
+#define BLK_PIPELINE_INFO	0x004
+#define BLK_VALID_INPUT_ID0	0x020
+#define BLK_OUTPUT_ID0		0x060
+#define BLK_INPUT_ID0		0x080
+#define BLK_IRQ_RAW_STATUS	0x0A0
+#define BLK_IRQ_CLEAR		0x0A4
+#define BLK_IRQ_MASK		0x0A8
+#define BLK_IRQ_STATUS		0x0AC
+#define BLK_STATUS		0x0B0
+#define BLK_INFO		0x0C0
+#define BLK_CONTROL		0x0D0
+#define BLK_SIZE		0x0D4
+#define BLK_IN_SIZE		0x0E0
+
+#define BLK_P0_PTR_LOW		0x100
+#define BLK_P0_PTR_HIGH		0x104
+#define BLK_P0_STRIDE		0x108
+#define BLK_P1_PTR_LOW		0x110
+#define BLK_P1_PTR_HIGH		0x114
+#define BLK_P1_STRIDE		0x118
+#define BLK_P2_PTR_LOW		0x120
+#define BLK_P2_PTR_HIGH		0x124
+
+#define BLOCK_INFO_N_SUBBLKS(x)	((x) & 0x000F)
+#define BLOCK_INFO_BLK_ID(x)	(((x) & 0x00F0) >> 4)
+#define BLOCK_INFO_BLK_TYPE(x)	(((x) & 0xFF00) >> 8)
+#define BLOCK_INFO_INPUT_ID(x)	((x) & 0xFFF0)
+#define BLOCK_INFO_TYPE_ID(x)	(((x) & 0x0FF0) >> 4)
+
+#define PIPELINE_INFO_N_OUTPUTS(x)	((x) & 0x000F)
+#define PIPELINE_INFO_N_VALID_INPUTS(x)	(((x) & 0x0F00) >> 8)
+
+/* Common block control register bits */
+#define BLK_CTRL_EN		BIT(0)
+/* Common size macro */
+#define HV_SIZE(h, v)		(((h) & 0x1FFF) + (((v) & 0x1FFF) << 16))
+#define HV_OFFSET(h, v)		(((h) & 0xFFF) + (((v) & 0xFFF) << 16))
+#define HV_CROP(h, v)		(((h) & 0xFFF) + (((v) & 0xFFF) << 16))
+
+/* AD_CONTROL register */
+#define AD_CONTROL		0x160
+
+/* AD_CONTROL register bits */
+#define AD_AEN			BIT(0)
+#define AD_YT			BIT(1)
+#define AD_BS			BIT(2)
+#define AD_WB			BIT(3)
+#define AD_TH			BIT(4)
+
+/* Global Control Unit */
+#define GLB_ARCH_ID		0x000
+#define GLB_CORE_ID		0x004
+#define GLB_CORE_INFO		0x008
+#define GLB_IRQ_STATUS		0x010
+
+#define GCU_CONFIG_VALID0	0x0D4
+#define GCU_CONFIG_VALID1	0x0D8
+
+/* GCU_CONTROL_BITS */
+#define GCU_CONTROL_MODE(x)	((x) & 0x7)
+#define GCU_CONTROL_SRST	BIT(16)
+
+/* GCU opmode */
+#define INACTIVE_MODE		0
+#define TBU_CONNECT_MODE	1
+#define TBU_DISCONNECT_MODE	2
+#define DO0_ACTIVE_MODE		3
+#define DO1_ACTIVE_MODE		4
+#define DO01_ACTIVE_MODE	5
+
+/* GLB_IRQ_STATUS bits */
+#define GLB_IRQ_STATUS_GCU	BIT(0)
+#define GLB_IRQ_STATUS_LPU0	BIT(8)
+#define GLB_IRQ_STATUS_LPU1	BIT(9)
+#define GLB_IRQ_STATUS_ATU0	BIT(10)
+#define GLB_IRQ_STATUS_ATU1	BIT(11)
+#define GLB_IRQ_STATUS_ATU2	BIT(12)
+#define GLB_IRQ_STATUS_ATU3	BIT(13)
+#define GLB_IRQ_STATUS_CU0	BIT(16)
+#define GLB_IRQ_STATUS_CU1	BIT(17)
+#define GLB_IRQ_STATUS_DOU0	BIT(24)
+#define GLB_IRQ_STATUS_DOU1	BIT(25)
+
+#define GLB_IRQ_STATUS_PIPE0	(GLB_IRQ_STATUS_LPU0 |\
+				 GLB_IRQ_STATUS_ATU0 |\
+				 GLB_IRQ_STATUS_ATU1 |\
+				 GLB_IRQ_STATUS_CU0 |\
+				 GLB_IRQ_STATUS_DOU0)
+
+#define GLB_IRQ_STATUS_PIPE1	(GLB_IRQ_STATUS_LPU1 |\
+				 GLB_IRQ_STATUS_ATU2 |\
+				 GLB_IRQ_STATUS_ATU3 |\
+				 GLB_IRQ_STATUS_CU1 |\
+				 GLB_IRQ_STATUS_DOU1)
+
+#define GLB_IRQ_STATUS_ATU	(GLB_IRQ_STATUS_ATU0 |\
+				 GLB_IRQ_STATUS_ATU1 |\
+				 GLB_IRQ_STATUS_ATU2 |\
+				 GLB_IRQ_STATUS_ATU3)
+
+/* GCU_IRQ_BITS */
+#define GCU_IRQ_CVAL0		BIT(0)
+#define GCU_IRQ_CVAL1		BIT(1)
+#define GCU_IRQ_MODE		BIT(4)
+#define GCU_IRQ_ERR		BIT(11)
+
+/* GCU_STATUS_BITS */
+#define GCU_STATUS_MODE(x)	((x) & 0x7)
+#define GCU_STATUS_MERR		BIT(4)
+#define GCU_STATUS_TCS0		BIT(8)
+#define GCU_STATUS_TCS1		BIT(9)
+#define GCU_STATUS_ACTIVE	BIT(31)
+
+/* GCU_CONFIG_VALIDx BITS */
+#define GCU_CONFIG_CVAL		BIT(0)
+
+/* PERIPHERAL registers */
+#define PERIPH_MAX_LINE_SIZE	BIT(0)
+#define PERIPH_NUM_RICH_LAYERS	BIT(4)
+#define PERIPH_SPLIT_EN		BIT(8)
+#define PERIPH_TBU_EN		BIT(12)
+#define PERIPH_AFBC_DMA_EN	BIT(16)
+#define PERIPH_CONFIGURATION_ID	0x1D4
+
+/* LPU register */
+#define LPU_TBU_STATUS		0x0B4
+#define LPU_RAXI_CONTROL	0x0D0
+#define LPU_WAXI_CONTROL	0x0D4
+#define LPU_TBU_CONTROL		0x0D8
+
+/* LPU_xAXI_CONTROL_BITS */
+#define TO_RAXI_AOUTSTDCAPB(x)	(x)
+#define TO_RAXI_BOUTSTDCAPB(x)	((x) << 8)
+#define TO_RAXI_BEN(x)		((x) << 15)
+#define TO_xAXI_BURSTLEN(x)	((x) << 16)
+#define TO_xAXI_AxQOS(x)	((x) << 24)
+#define TO_xAXI_ORD(x)		((x) << 31)
+#define TO_WAXI_OUTSTDCAPB(x)	(x)
+
+#define RAXI_AOUTSTDCAPB_MASK	0x7F
+#define RAXI_BOUTSTDCAPB_MASK	0x7F00
+#define RAXI_BEN_MASK		BIT(15)
+#define xAXI_BURSTLEN_MASK	0x3F0000
+#define xAXI_AxQOS_MASK		0xF000000
+#define xAXI_ORD_MASK		BIT(31)
+#define WAXI_OUTSTDCAPB_MASK	0x3F
+
+/* LPU_TBU_CONTROL BITS */
+#define TO_TBU_DOUTSTDCAPB(x)	(x)
+#define TBU_DOUTSTDCAPB_MASK	0x3F
+
+/* LPU_IRQ_BITS */
+#define LPU_IRQ_IBSY		BIT(10)
+#define LPU_IRQ_ERR		BIT(11)
+#define LPU_IRQ_EOW		BIT(12)
+#define LPU_IRQ_PL0		BIT(13)
+
+/* LPU_STATUS_BITS */
+#define LPU_STATUS_AXIED(x)	((x) & 0xF)
+#define LPU_STATUS_AXIE		BIT(4)
+#define LPU_STATUS_AXIRP	BIT(5)
+#define LPU_STATUS_AXIWP	BIT(6)
+#define LPU_STATUS_ACE0		BIT(16)
+#define LPU_STATUS_ACE1		BIT(17)
+#define LPU_STATUS_ACE2		BIT(18)
+#define LPU_STATUS_ACE3		BIT(19)
+#define LPU_STATUS_ACTIVE	BIT(31)
+
+#define AXIEID_MASK		0xF
+#define AXIE_MASK		LPU_STATUS_AXIE
+#define AXIRP_MASK		LPU_STATUS_AXIRP
+#define AXIWP_MASK		LPU_STATUS_AXIWP
+
+#define FROM_AXIEID(reg)	((reg) & AXIEID_MASK)
+#define TO_AXIE(x)		((x) << 4)
+#define FROM_AXIRP(reg)		(((reg) & AXIRP_MASK) >> 5)
+#define FROM_AXIWP(reg)		(((reg) & AXIWP_MASK) >> 6)
+
+/* LPU_TBU_STATUS_BITS */
+#define LPU_TBU_STATUS_TCF	BIT(1)
+#define LPU_TBU_STATUS_TTNG	BIT(2)
+#define LPU_TBU_STATUS_TITR	BIT(8)
+#define LPU_TBU_STATUS_TEMR	BIT(16)
+#define LPU_TBU_STATUS_TTF	BIT(31)
+
+/* LPU_TBU_CONTROL BITS */
+#define LPU_TBU_CTRL_TLBPEN	BIT(16)
+
+/* CROSSBAR CONTROL BITS */
+#define CBU_INPUT_CTRL_EN	BIT(0)
+#define CBU_NUM_INPUT_IDS	5
+#define CBU_NUM_OUTPUT_IDS	5
+
+/* CU register */
+#define CU_BG_COLOR		0x0DC
+#define CU_INPUT0_SIZE		0x0E0
+#define CU_INPUT0_OFFSET	0x0E4
+#define CU_INPUT0_CONTROL	0x0E8
+#define CU_INPUT1_SIZE		0x0F0
+#define CU_INPUT1_OFFSET	0x0F4
+#define CU_INPUT1_CONTROL	0x0F8
+#define CU_INPUT2_SIZE		0x100
+#define CU_INPUT2_OFFSET	0x104
+#define CU_INPUT2_CONTROL	0x108
+#define CU_INPUT3_SIZE		0x110
+#define CU_INPUT3_OFFSET	0x114
+#define CU_INPUT3_CONTROL	0x118
+#define CU_INPUT4_SIZE		0x120
+#define CU_INPUT4_OFFSET	0x124
+#define CU_INPUT4_CONTROL	0x128
+
+#define CU_PER_INPUT_REGS	4
+
+#define CU_NUM_INPUT_IDS	5
+#define CU_NUM_OUTPUT_IDS	1
+
+/* CU control register bits */
+#define CU_CTRL_COPROC		BIT(0)
+
+/* CU_IRQ_BITS */
+#define CU_IRQ_OVR		BIT(9)
+#define CU_IRQ_ERR		BIT(11)
+
+/* CU_STATUS_BITS */
+#define CU_STATUS_CPE		BIT(0)
+#define CU_STATUS_ZME		BIT(1)
+#define CU_STATUS_CFGE		BIT(2)
+#define CU_STATUS_ACTIVE	BIT(31)
+
+/* CU input control register bits */
+#define CU_INPUT_CTRL_EN	BIT(0)
+#define CU_INPUT_CTRL_PAD	BIT(1)
+#define CU_INPUT_CTRL_PMUL	BIT(2)
+#define CU_INPUT_CTRL_ALPHA(x)	(((x) & 0xFF) << 8)
+
+/* DOU register */
+
+/* DOU_IRQ_BITS */
+#define DOU_IRQ_UND		BIT(8)
+#define DOU_IRQ_ERR		BIT(11)
+#define DOU_IRQ_PL0		BIT(13)
+#define DOU_IRQ_PL1		BIT(14)
+
+/* DOU_STATUS_BITS */
+#define DOU_STATUS_DRIFTTO	BIT(0)
+#define DOU_STATUS_FRAMETO	BIT(1)
+#define DOU_STATUS_TETO		BIT(2)
+#define DOU_STATUS_CSCE		BIT(8)
+#define DOU_STATUS_ACTIVE	BIT(31)
+
+/* Layer registers */
+#define LAYER_INFO		0x0C0
+#define LAYER_R_CONTROL		0x0D4
+#define LAYER_FMT		0x0D8
+#define LAYER_LT_COEFFTAB	0x0DC
+#define LAYER_PALPHA		0x0E4
+
+#define LAYER_YUV_RGB_COEFF0	0x130
+
+#define LAYER_AD_H_CROP		0x164
+#define LAYER_AD_V_CROP		0x168
+
+#define LAYER_RGB_RGB_COEFF0	0x170
+
+/* L_CONTROL_BITS */
+#define L_EN			BIT(0)
+#define L_IT			BIT(4)
+#define L_R2R			BIT(5)
+#define L_FT			BIT(6)
+#define L_ROT(x)		(((x) & 3) << 8)
+#define L_HFLIP			BIT(10)
+#define L_VFLIP			BIT(11)
+#define L_TBU_EN		BIT(16)
+#define L_A_RCACHE(x)		(((x) & 0xF) << 28)
+#define L_ROT_R0		0
+#define L_ROT_R90		1
+#define L_ROT_R180		2
+#define L_ROT_R270		3
+
+/* LAYER_R_CONTROL BITS */
+#define LR_CHI422_BILINEAR	0
+#define LR_CHI422_REPLICATION	1
+#define LR_CHI420_JPEG		(0 << 2)
+#define LR_CHI420_MPEG		(1 << 2)
+
+#define L_ITSEL(x)		((x) & 0xFFF)
+#define L_FTSEL(x)		(((x) & 0xFFF) << 16)
+
+#define LAYER_PER_PLANE_REGS	4
+
+/* Layer_WR registers */
+#define LAYER_WR_PROG_LINE	0x0D4
+#define LAYER_WR_FORMAT		0x0D8
+
+/* Layer_WR control bits */
+#define LW_OFM			BIT(4)
+#define LW_LALPHA(x)		(((x) & 0xFF) << 8)
+#define LW_A_WCACHE(x)		(((x) & 0xF) << 28)
+#define LW_TBU_EN		BIT(16)
+
+#define AxCACHE_MASK		0xF0000000
+
+/* Layer AXI R/W cache setting */
+#define AxCACHE_B		BIT(0)	/* Bufferable */
+#define AxCACHE_M		BIT(1)	/* Modifiable */
+#define AxCACHE_RA		BIT(2)	/* Read-Allocate */
+#define AxCACHE_WA		BIT(3)	/* Write-Allocate */
+
+/* Layer info bits */
+#define L_INFO_RF		BIT(0)
+#define L_INFO_CM		BIT(1)
+#define L_INFO_ABUF_SIZE(x)	(((x) >> 4) & 0x7)
+
+/* Scaler registers */
+#define SC_COEFFTAB		0x0DC
+#define SC_OUT_SIZE		0x0E4
+#define SC_H_CROP		0x0E8
+#define SC_V_CROP		0x0EC
+#define SC_H_INIT_PH		0x0F0
+#define SC_H_DELTA_PH		0x0F4
+#define SC_V_INIT_PH		0x0F8
+#define SC_V_DELTA_PH		0x0FC
+#define SC_ENH_LIMITS		0x130
+#define SC_ENH_COEFF0		0x134
+
+#define SC_MAX_ENH_COEFF	9
+
+/* SC_CTRL_BITS */
+#define SC_CTRL_SCL		BIT(0)
+#define SC_CTRL_LS		BIT(1)
+#define SC_CTRL_AP		BIT(4)
+#define SC_CTRL_IENH		BIT(8)
+#define SC_CTRL_RGBSM		BIT(16)
+#define SC_CTRL_ASM		BIT(17)
+
+#define SC_VTSEL(vtal)		((vtal) << 16)
+
+#define SC_NUM_INPUTS_IDS	1
+#define SC_NUM_OUTPUTS_IDS	1
+
+#define MG_NUM_INPUTS_IDS	2
+#define MG_NUM_OUTPUTS_IDS	1
+
+/* Merger registers */
+#define MG_INPUT_ID0		BLK_INPUT_ID0
+#define MG_INPUT_ID1		(MG_INPUT_ID0 + 4)
+#define MG_SIZE			BLK_SIZE
+
+/* Splitter registers */
+#define SP_OVERLAP_SIZE		0xD8
+
+/* Backend registers */
+#define BS_INFO			0x0C0
+#define BS_PROG_LINE		0x0D4
+#define BS_PREFETCH_LINE	0x0D8
+#define BS_BG_COLOR		0x0DC
+#define BS_ACTIVESIZE		0x0E0
+#define BS_HINTERVALS		0x0E4
+#define BS_VINTERVALS		0x0E8
+#define BS_SYNC			0x0EC
+#define BS_DRIFT_TO		0x100
+#define BS_FRAME_TO		0x104
+#define BS_TE_TO		0x108
+#define BS_T0_INTERVAL		0x110
+#define BS_T1_INTERVAL		0x114
+#define BS_T2_INTERVAL		0x118
+#define BS_CRC0_LOW		0x120
+#define BS_CRC0_HIGH		0x124
+#define BS_CRC1_LOW		0x128
+#define BS_CRC1_HIGH		0x12C
+#define BS_USER			0x130
+
+/* BS control register bits */
+#define BS_CTRL_EN		BIT(0)
+#define BS_CTRL_VM		BIT(1)
+#define BS_CTRL_BM		BIT(2)
+#define BS_CTRL_HMASK		BIT(4)
+#define BS_CTRL_VD		BIT(5)
+#define BS_CTRL_TE		BIT(8)
+#define BS_CTRL_TS		BIT(9)
+#define BS_CTRL_TM		BIT(12)
+#define BS_CTRL_DL		BIT(16)
+#define BS_CTRL_SBS		BIT(17)
+#define BS_CTRL_CRC		BIT(18)
+#define BS_CTRL_PM		BIT(20)
+
+/* BS active size/intervals */
+#define BS_H_INTVALS(hfp, hbp)	(((hfp) & 0xFFF) + (((hbp) & 0x3FF) << 16))
+#define BS_V_INTVALS(vfp, vbp)  (((vfp) & 0x3FFF) + (((vbp) & 0xFF) << 16)=
)
+
+/* BS_SYNC bits */
+#define BS_SYNC_HSW(x)		((x) & 0x3FF)
+#define BS_SYNC_HSP		BIT(12)
+#define BS_SYNC_VSW(x)		(((x) & 0xFF) << 16)
+#define BS_SYNC_VSP		BIT(28)
+
+#define BS_NUM_INPUT_IDS	0
+#define BS_NUM_OUTPUT_IDS	0
+
+/* Image process registers */
+#define IPS_DEPTH		0x0D8
+#define IPS_RGB_RGB_COEFF0	0x130
+#define IPS_RGB_YUV_COEFF0	0x170
+
+#define IPS_DEPTH_MARK		0xF
+
+/* IPS control register bits */
+#define IPS_CTRL_RGB		BIT(0)
+#define IPS_CTRL_FT		BIT(4)
+#define IPS_CTRL_YUV		BIT(8)
+#define IPS_CTRL_CHD422		BIT(9)
+#define IPS_CTRL_CHD420		BIT(10)
+#define IPS_CTRL_LPF		BIT(11)
+#define IPS_CTRL_DITH		BIT(12)
+#define IPS_CTRL_CLAMP		BIT(16)
+#define IPS_CTRL_SBS		BIT(17)
+
+/* IPS info register bits */
+#define IPS_INFO_CHD420		BIT(10)
+
+#define IPS_NUM_INPUT_IDS	2
+#define IPS_NUM_OUTPUT_IDS	1
+
+/* FT_COEFF block registers */
+#define FT_COEFF0		0x80
+#define GLB_IT_COEFF		0x80
+
+/* GLB_SC_COEFF registers */
+#define GLB_SC_COEFF_ADDR	0x0080
+#define GLB_SC_COEFF_DATA	0x0084
+#define GLB_LT_COEFF_DATA	0x0080
+
+#define GLB_SC_COEFF_MAX_NUM	1024
+#define GLB_LT_COEFF_NUM	65
+/* GLB_SC_ADDR */
+#define SC_COEFF_R_ADDR		BIT(18)
+#define SC_COEFF_G_ADDR		BIT(17)
+#define SC_COEFF_B_ADDR		BIT(16)
+
+#define SC_COEFF_DATA(x, y)	(((y) & 0xFFFF) | (((x) & 0xFFFF) << 16))
+
+enum d71_blk_type {
+	D71_BLK_TYPE_GCU		=3D 0x00,
+	D71_BLK_TYPE_LPU		=3D 0x01,
+	D71_BLK_TYPE_CU			=3D 0x02,
+	D71_BLK_TYPE_DOU		=3D 0x03,
+	D71_BLK_TYPE_AEU		=3D 0x04,
+	D71_BLK_TYPE_GLB_LT_COEFF	=3D 0x05,
+	D71_BLK_TYPE_GLB_SCL_COEFF	=3D 0x06, /* SH/SV scaler coeff */
+	D71_BLK_TYPE_GLB_SC_COEFF	=3D 0x07,
+	D71_BLK_TYPE_PERIPH		=3D 0x08,
+	D71_BLK_TYPE_LPU_TRUSTED	=3D 0x09,
+	D71_BLK_TYPE_AEU_TRUSTED	=3D 0x0A,
+	D71_BLK_TYPE_LPU_LAYER		=3D 0x10,
+	D71_BLK_TYPE_LPU_WB_LAYER	=3D 0x11,
+	D71_BLK_TYPE_CU_SPLITTER	=3D 0x20,
+	D71_BLK_TYPE_CU_SCALER		=3D 0x21,
+	D71_BLK_TYPE_CU_MERGER		=3D 0x22,
+	D71_BLK_TYPE_DOU_IPS		=3D 0x30,
+	D71_BLK_TYPE_DOU_BS		=3D 0x31,
+	D71_BLK_TYPE_DOU_FT_COEFF	=3D 0x32,
+	D71_BLK_TYPE_AEU_DS		=3D 0x40,
+	D71_BLK_TYPE_AEU_AES		=3D 0x41,
+	D71_BLK_TYPE_RESERVED		=3D 0xFF
+};
+
+/* Constant of components */
+#define D71_MAX_PIPELINE		2
+#define D71_PIPELINE_MAX_SCALERS	2
+#define D71_PIPELINE_MAX_LAYERS		4
+
+#define D71_MAX_GLB_IT_COEFF		3
+#define D71_MAX_GLB_SCL_COEFF		4
+
+#define D71_MAX_LAYERS_PER_LPU		4
+#define D71_BLOCK_MAX_INPUT		9
+#define D71_BLOCK_MAX_OUTPUT		5
+#define D71_MAX_SC_PER_CU		2
+
+#define D71_BLOCK_OFFSET_PERIPH		0xFE00
+#define D71_BLOCK_SIZE			0x0200
+
+#define D71_DEFAULT_PREPRETCH_LINE	5
+#define D71_BUS_WIDTH_16_BYTES		16
+
+#define D71_MIN_LINE_SIZE		64
+#define D71_MIN_VERTICAL_SIZE		64
+#define D71_SC_MIN_LIN_SIZE		4
+#define D71_SC_MIN_VERTICAL_SIZE	4
+#define D71_SC_MAX_LIN_SIZE		2048
+#define D71_SC_MAX_VERTICAL_SIZE	4096
+
+#define D71_SC_MAX_UPSCALING		64
+#define D71_SC_MAX_DOWNSCALING		6
+#define D71_SC_SPLIT_OVERLAP		8
+#define D71_SC_ENH_SPLIT_OVERLAP	1
+
+#define D71_MG_MIN_MERGED_SIZE		4
+#define D71_MG_MAX_MERGED_HSIZE		4032
+#define D71_MG_MAX_MERGED_VSIZE		4096
+
+#define D71_PALPHA_DEF_MAP		0xFFAA5500
+#define D71_LAYER_CONTROL_DEFAULT	0x30000000
+#define D71_WB_LAYER_CONTROL_DEFAULT	0x3000FF00
+#define D71_BS_CONTROL_DEFAULT		0x00000002
+
+struct block_header {
+	u32 block_info;
+	u32 pipeline_info;
+	u32 input_ids[D71_BLOCK_MAX_INPUT];
+	u32 output_ids[D71_BLOCK_MAX_OUTPUT];
+};
+
+static inline u32 get_block_type(struct block_header *blk)
+{
+	return BLOCK_INFO_BLK_TYPE(blk->block_info);
+}
+
+#endif /* !_D71_REG_H_ */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index edb1cd7795f9..f755280caa3e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -17,17 +17,17 @@ komeda_pipeline_add(struct komeda_dev *mdev, size_t siz=
e,
 	if (mdev->n_pipelines + 1 > KOMEDA_MAX_PIPELINES) {
 		DRM_ERROR("Exceed max support %d pipelines.\n",
 			  KOMEDA_MAX_PIPELINES);
-		return NULL;
+		return ERR_PTR(-ENOSPC);
 	}
=20
 	if (size < sizeof(*pipe)) {
 		DRM_ERROR("Request pipeline size too small.\n");
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
=20
 	pipe =3D devm_kzalloc(mdev->dev, size, GFP_KERNEL);
 	if (!pipe)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
=20
 	pipe->mdev =3D mdev;
 	pipe->id   =3D mdev->n_pipelines;
@@ -140,32 +140,32 @@ komeda_component_add(struct komeda_pipeline *pipe,
 	if (max_active_inputs > KOMEDA_COMPONENT_N_INPUTS) {
 		WARN(1, "please large KOMEDA_COMPONENT_N_INPUTS to %d.\n",
 		     max_active_inputs);
-		return NULL;
+		return ERR_PTR(-ENOSPC);
 	}
=20
 	pos =3D komeda_pipeline_get_component_pos(pipe, id);
 	if (!pos || (*pos))
-		return NULL;
+		return ERR_PTR(-EINVAL);
=20
 	if (has_bit(id, KOMEDA_PIPELINE_LAYERS)) {
 		idx =3D id - KOMEDA_COMPONENT_LAYER0;
 		num =3D &pipe->n_layers;
 		if (idx !=3D pipe->n_layers) {
 			DRM_ERROR("please add Layer by id sequence.\n");
-			return NULL;
+			return ERR_PTR(-EINVAL);
 		}
 	} else if (has_bit(id,  KOMEDA_PIPELINE_SCALERS)) {
 		idx =3D id - KOMEDA_COMPONENT_SCALER0;
 		num =3D &pipe->n_scalers;
 		if (idx !=3D pipe->n_scalers) {
 			DRM_ERROR("please add Scaler by id sequence.\n");
-			return NULL;
+			return ERR_PTR(-EINVAL);
 		}
 	}
=20
 	c =3D devm_kzalloc(pipe->mdev->dev, comp_sz, GFP_KERNEL);
 	if (!c)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
=20
 	c->id =3D id;
 	c->hw_id =3D hw_id;
--=20
2.17.1

