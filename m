Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C79F2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UG4KSxnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeLXI7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:59:24 -0500
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:25878
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbeLXI7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQOW+haGrVigKwXeom9IQQzdKgiAQlFfFjt41EAiz/0=;
 b=UG4KSxnto7xiJZvgkbfW1JvJsUiQyGvNg0ddEPM9IOTzKI5w+HOyZfRS9N01h7roA6HTUnTrzwyqTyYl6y9/zKnqgNKsN4mi9mbq4stS7yJkgJ9djYnxTy4s7/DZJz3VqXJQ8eF5GHla3mjZZDNT8GKz5Ncls0Ltk2Ho9xZtp34=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0609.eurprd08.prod.outlook.com (10.163.188.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 08:59:16 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 08:59:16 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 4/7] drm/komeda: Add D71 improc and timing_ctrlr
Thread-Topic: [PATCH 4/7] drm/komeda: Add D71 improc and timing_ctrlr
Thread-Index: AQHUm2bykGJNmtYMPUSjzzCHM8UsYQ==
Date:   Mon, 24 Dec 2018 08:59:16 +0000
Message-ID: <20181224085716.2325-5-james.qian.wang@arm.com>
References: <20181224085716.2325-1-james.qian.wang@arm.com>
In-Reply-To: <20181224085716.2325-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:4::24) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0609;6:RmpinBlDuexBhRIEE/kq4KZ9NDJkzNWaQgyfIplKLt66ws22gBrO5quDb5TYaoVLIlluoih27qM+R2m7hrOAMyBkxwM1fhEucYn0WKjCPyrXeu8qf5ukfe9Y/thZC/lEWt418I8Rb9y1sjx+phb4CHSPR++n3ybZA8C9UrHOKmcnN55erLvoqrkpGx6852aeXO4NOcTcsidJwnn9SS84xDf6Vlhn64ySE+PHTIrwfEuURVFTeyiLNfZZcDFqVvwmxqj45VpfVbzNaRzwcjqScp+sRmIDBO88JPw26GfIoYPRDandzVrRdb2qyacP7giCwX/C8b2QOFyLdHk17G34fo5O+HocKu6iWOrFYZShfRgbslD6/xnVba24RDuM37RGq3kG2Fait7ekZgbMKqpF2yqRyJ1OJAgIbMFVLxcxrsnfuULm+UUsd2hzkZN+zf4SVJdpCEUxlk4DrNIupAV53w==;5:R7z7/fWmAZ6b3Cx6SKTl+oy2XMxaOj7M9FXWLkXWMOp/KqF8F7iTJRP12cI7i5MFeoyfpuiOUBppuXWfAn/6lfEVU9eDvRxC6bSZ+jcbiMixlSmCO7adli7hfs6ozHrGZ1pdNlrRBP3TbLXGtvFOQqwNA//WJGPNrI7ChARwW/U=;7:H81pYwHEQGB0VOZnF3edApW4sy4y+QT9DmO/7KgSl9RG2P5V5Kp7JYB6ZBtoBuyYW9g3gEjxiIxNdGX4iXXPT3J2UxTV2NYKhdrHTDsMLBBGuXIdnuscV5DyzRqKz7+qWorN28esbiUZ35oCU6nwEQ==
x-ms-office365-filtering-correlation-id: eab3a841-8a59-439b-51e4-08d6697e14f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0609;
x-ms-traffictypediagnostic: AM3PR08MB0609:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB06093FBF9159DAF56B3BD836B3BB0@AM3PR08MB0609.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0609;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0609;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(66066001)(386003)(102836004)(305945005)(53936002)(3846002)(6116002)(6506007)(1076003)(5660300001)(478600001)(7736002)(186003)(97736004)(103116003)(6512007)(11346002)(68736007)(14454004)(71190400001)(55236004)(71200400001)(6636002)(446003)(99286004)(476003)(2616005)(76176011)(36756003)(486006)(4326008)(2906002)(6862004)(316002)(256004)(8936002)(25786009)(54906003)(37006003)(26005)(52116002)(8676002)(14444005)(81166006)(106356001)(86362001)(105586002)(6436002)(6486002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0609;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vole+Y6YnzJ4Hu4tM0FGX90MUXiQgOUsG1yv3k5RoEpad7ld7sCLwgcLR8JFooJqWE5ONdXI+eImXiA8KrdcWlYGEuLhU3e06zz6mrPUiIjjJostWiG3QakOHpkzDMhnj0859tEcmpSpsBB9Y/KgwsQujWpFT1n+5eq2o062zU2nSqkGmW4DxxsaeR4BNehbsTei/7z6zOdlYMRb3rTU1ojsIIk4jAOy5R+q9LMkb1NYq8ZV8b5twCgY9HGr44/Cu958RpwT3hWX/8/zJfkt1sbP9GrmfgqFf/xal/hJ/qD9Qu/xDJ+iryzT4vtMlTSb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab3a841-8a59-439b-51e4-08d6697e14f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 08:59:16.1398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and initialize improc and timing_ctrlr according to D71 capablitites

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 108 +++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |   7 ++
 3 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 5458df726b08..811634ec1193 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -285,18 +285,122 @@ static int d71_compiz_init(struct d71_dev *d71,
 	return 0;
 }
=20
+static void d71_improc_update(struct komeda_component *c,
+			      struct komeda_component_state *state)
+{
+	struct komeda_improc_state *st =3D to_improc_st(state);
+	u32 __iomem *reg =3D c->reg;
+	u32 index, input_hw_id;
+
+	for_each_changed_input(state, index) {
+		input_hw_id =3D state->active_inputs & BIT(index) ?
+			      to_d71_input_id(&state->inputs[index]) : 0;
+		malidp_write32(reg, BLK_INPUT_ID0 + index * 4, input_hw_id);
+	}
+
+	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
+}
+
+struct komeda_component_funcs d71_improc_funcs =3D {
+	.update		=3D d71_improc_update,
+	.disable	=3D d71_component_disable,
+};
+
 static int d71_improc_init(struct d71_dev *d71,
 			   struct block_header *blk, u32 __iomem *reg)
 {
-	DRM_INFO("Detect D71_improc.\n");
+	struct komeda_component *c;
+	struct komeda_improc *improc;
+	u32 blk_id =3D BLOCK_INFO_BLK_ID(blk->block_info);
+	u32 value;
+
+	c =3D komeda_component_add(&d71->pipes[blk_id]->base, sizeof(*improc),
+				 KOMEDA_COMPONENT_IPS0 + blk_id,
+				 BLOCK_INFO_INPUT_ID(blk->block_info),
+				 &d71_improc_funcs, IPS_NUM_INPUT_IDS,
+				 get_valid_inputs(blk),
+				 IPS_NUM_OUTPUT_IDS, reg, "DOU%d_IPS", blk_id);
+	if (!c) {
+		DRM_ERROR("Failed to add improc component\n");
+		return -EINVAL;
+	}
+
+	improc =3D to_improc(c);
+	improc->supported_color_depths =3D BIT(8) | BIT(10);
+	improc->supported_color_formats =3D DRM_COLOR_FORMAT_RGB444 |
+					  DRM_COLOR_FORMAT_YCRCB444 |
+					  DRM_COLOR_FORMAT_YCRCB422;
+	value =3D malidp_read32(reg, BLK_INFO);
+	if (value & IPS_INFO_CHD420)
+		improc->supported_color_formats |=3D DRM_COLOR_FORMAT_YCRCB420;
+
+	improc->supports_csc =3D true;
+	improc->supports_gamma =3D true;
=20
 	return 0;
 }
=20
+static void d71_timing_ctrlr_disable(struct komeda_component *c)
+{
+	malidp_write32_mask(c->reg, BLK_CONTROL, BS_CTRL_EN, 0);
+}
+
+static void d71_timing_ctrlr_update(struct komeda_component *c,
+				    struct komeda_component_state *state)
+{
+	struct drm_crtc_state *crtc_st =3D state->crtc->state;
+	u32 __iomem *reg =3D c->reg;
+	struct videomode vm;
+	u32 value;
+
+	drm_display_mode_to_videomode(&crtc_st->adjusted_mode, &vm);
+
+	malidp_write32(reg, BS_ACTIVESIZE, HV_SIZE(vm.hactive, vm.vactive));
+	malidp_write32(reg, BS_HINTERVALS, BS_H_INTVALS(vm.hfront_porch,
+							vm.hback_porch));
+	malidp_write32(reg, BS_VINTERVALS, BS_V_INTVALS(vm.vfront_porch,
+							vm.vback_porch));
+
+	value =3D BS_SYNC_VSW(vm.vsync_len) | BS_SYNC_HSW(vm.hsync_len);
+	value |=3D vm.flags & DISPLAY_FLAGS_VSYNC_HIGH ? BS_SYNC_VSP : 0;
+	value |=3D vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ? BS_SYNC_HSP : 0;
+	malidp_write32(reg, BS_SYNC, value);
+
+	malidp_write32(reg, BS_PROG_LINE, D71_DEFAULT_PREPRETCH_LINE - 1);
+	malidp_write32(reg, BS_PREFETCH_LINE, D71_DEFAULT_PREPRETCH_LINE);
+
+	/* configure bs control register */
+	value =3D BS_CTRL_EN | BS_CTRL_VM;
+
+	malidp_write32(reg, BLK_CONTROL, value);
+}
+
+struct komeda_component_funcs d71_timing_ctrlr_funcs =3D {
+	.update		=3D d71_timing_ctrlr_update,
+	.disable	=3D d71_timing_ctrlr_disable,
+};
+
 static int d71_timing_ctrlr_init(struct d71_dev *d71,
 				 struct block_header *blk, u32 __iomem *reg)
 {
-	DRM_INFO("Detect D71_timing_ctrlr.\n");
+	struct komeda_component *c;
+	struct komeda_timing_ctrlr *ctrlr;
+	u32 blk_id =3D BLOCK_INFO_BLK_ID(blk->block_info);
+
+	c =3D komeda_component_add(&d71->pipes[blk_id]->base, sizeof(*ctrlr),
+				 KOMEDA_COMPONENT_TIMING_CTRLR,
+				 BLOCK_INFO_INPUT_ID(blk->block_info),
+				 &d71_timing_ctrlr_funcs,
+				 1, BIT(KOMEDA_COMPONENT_IPS0 + blk_id),
+				 BS_NUM_OUTPUT_IDS, reg, "DOU%d_BS", blk_id);
+	if (!c) {
+		DRM_ERROR("Failed to add display_ctrl component\n");
+		return -EINVAL;
+	}
+
+	ctrlr =3D to_ctrlr(c);
+
+	ctrlr->supports_dual_link =3D true;
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index f13666004a42..f519a4c587e6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -11,6 +11,8 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_writeback.h>
+#include <video/videomode.h>
+#include <video/display_timing.h>
=20
 /** struct komeda_plane - komeda instance of drm_plane */
 struct komeda_plane {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 22baeb5e1b61..b2bd6ab282cb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -258,15 +258,22 @@ struct komeda_compiz_state {
=20
 struct komeda_improc {
 	struct komeda_component base;
+	u32 supported_color_formats;  /* DRM_RGB/YUV444/YUV420*/
+	u32 supported_color_depths; /* BIT(8) | BIT(10)*/
+	u8 supports_degamma : 1;
+	u8 supports_csc : 1;
+	u8 supports_gamma : 1;
 };
=20
 struct komeda_improc_state {
 	struct komeda_component_state base;
+	u16 hsize, vsize;
 };
=20
 /* display timing controller */
 struct komeda_timing_ctrlr {
 	struct komeda_component base;
+	u8 supports_dual_link : 1;
 };
=20
 struct komeda_timing_ctrlr_state {
--=20
2.17.1

