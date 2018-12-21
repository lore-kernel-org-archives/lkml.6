Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E76C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2567E21908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KY0kJ3x/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbeLUKAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:00:21 -0500
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:29356
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389218AbeLUKAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHA1lwedM3HQpNrtov1jujUM5Xpn8l1w5/VoIGaE6QI=;
 b=KY0kJ3x/7fvbKPyar8njgK4puPuF+qKXF4FCiOj+/IDGpsrq95t9YSoaPwL+m8owQs+mId3OsNcFSOCkKAJKTT0VJt+0AZilRsa7hlaFVnGFoQrfHbrtrdSX3FX22F3YCDyZA20Pnj67/f0BzRVYQs4GcjFnw5hJVBqkpXRnyOw=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3187.eurprd08.prod.outlook.com (52.134.93.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 10:00:01 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 10:00:01 +0000
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
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 5/9] drm/komeda: Add komeda_format_caps for format handling
Thread-Topic: [PATCH v3 5/9] drm/komeda: Add komeda_format_caps for format
 handling
Thread-Index: AQHUmRPvU4LkUcpS4kOIzGljKTtMXA==
Date:   Fri, 21 Dec 2018 10:00:01 +0000
Message-ID: <20181221095757.15510-6-james.qian.wang@arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
In-Reply-To: <20181221095757.15510-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY3PR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:19::32) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3187;6:gJxHu13bmbiqCaWXCVtlbMFVL2hmcMfRFISk50jlA6hoAKrZvPuidv5A3jZ/VPcrSoammBIkROKiGH9EnOzGPNEB8wL62wo6luN0aHQhjqRi59YkWJ+LYf8WmmEKrb0l31LT7J/fIttyzfPOVTxL7pGiIg+On5QXaxaf0retr3vspo2cA7a0RakShABwLD1igZDgaLKtePsJwhG27TULaYlOIKai11U72aK0e84aHninGpZLyFMu3xcfzTodGotkxDuuescDt0O+jG3hqaCriaUWdxEd4W4yb51w9/uOCqOeqB+exaCpOetPXdGWTEdKQJmlPd44z5GNCNbb1mAPB1Mkc7mkU6cSDsqTHnMDjvVu8F1ke1G3xc2SvfMGBlXmDdD/1wXeEJQKQnQTOnpNuRCcUab5aYhE+sFvdukJqLLFBDOXfwS4uhiGiuWgoz4oaA4OguYJodTWC/PtEvroMg==;5:/f6pUOoV8XVoSJ9NT0SDFdzWDcF0NnOYSF2Ag6UmWsANFq4me+vmOBsHvnfGcPi2e7UUZ1HafiSvPSNPcyS2QEBdFJGBTvL8L/7neDaDzt2O//NMbfTREGmrdbqj2mKWeK/VxQ1ij3limyTLn+A7bvCwS461GqMFaj4v1rxhIF4=;7:eH0uXIJQHchOh+YFoiNnQw7HclHkYznbDXv1EUmx1a6zl5+mHQlpubFacssoK2PjOkUXrPq3E6NOiq7rY4Q3utHK4rQbmOPNq8YY9tl2TQakuZ9HOgLyiOHmSjvjwpFFuaO4yA2YHlAc8dNOEaLP3g==
x-ms-office365-filtering-correlation-id: c3809185-1943-4488-3d39-08d6672b1241
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3187;
x-ms-traffictypediagnostic: AM0PR08MB3187:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB31874B17EFC97C776E7B6ABDB3B80@AM0PR08MB3187.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3187;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3187;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(396003)(39860400002)(376002)(136003)(366004)(189003)(199004)(71200400001)(97736004)(575784001)(71190400001)(103116003)(86362001)(14454004)(4744004)(2906002)(5660300001)(106356001)(6116002)(105586002)(66066001)(54906003)(6636002)(3846002)(37006003)(99286004)(68736007)(478600001)(25786009)(6486002)(7736002)(36756003)(6436002)(76176011)(316002)(186003)(386003)(6506007)(55236004)(1076003)(26005)(6512007)(256004)(14444005)(6862004)(52116002)(81156014)(476003)(486006)(81166006)(7416002)(102836004)(8676002)(305945005)(2616005)(8936002)(53936002)(4326008)(446003)(11346002)(21314003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3187;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4+1HHLso6RTLOhBc2NajMpdS3hGQdXsPT6QZ9dgx1UOwaK7o/F4lugMWuOUtRxgOZVQ8X+00SPSIdsE0+omQUKiNtHq0+heCzbAZ48hmHzUYeaVTllS03avIc8Tbe0bnLYObyAlGALoiS7HWF/G7AqwCPL9/P4m9mubLWPy1atcNxH/PEp8um4bwJjVkD1m7ctCdH1sfBX/idmBd/lis0ngcmAOJAYro0WiFzyuDHmQOjfKztTzGI7DedafU4uR+22ugGOZUtQLZHa1PIOkT9LLxc5Itn9U5C/yWKJtd3taak+be1GNiq76OsHV9oK7o
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3809185-1943-4488-3d39-08d6672b1241
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 10:00:01.0496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

komeda_format_caps is for describing ARM display specific features and
limitations of a specific format, and format_caps will be linked into
&komeda_framebuffer like a extension of &drm_format_info.
And komed_format_caps_table will be initialized before the enum_resources,
since the layer features description depend on this format_caps table, so
we'd better initialize the table first.

Changes in v3:
- Fixed style problem found by checkpatch.pl --strict.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/Makefile   |  1 +
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 78 ++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  2 +
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 11 ++-
 .../arm/display/komeda/komeda_format_caps.c   | 75 ++++++++++++++++
 .../arm/display/komeda/komeda_format_caps.h   | 89 +++++++++++++++++++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 7 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h

diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index c03d6876ef75..394fc2aa434a 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -7,6 +7,7 @@ ccflags-y :=3D \
 komeda-y :=3D \
 	komeda_drv.o \
 	komeda_dev.o \
+	komeda_format_caps.o \
 	komeda_pipeline.o
=20
 komeda-y +=3D \
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index af3dabb499cd..edbf9daa1545 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -13,7 +13,85 @@ static int d71_enum_resources(struct komeda_dev *mdev)
 	return -1;
 }
=20
+#define __HW_ID(__group, __format) \
+	((((__group) & 0x7) << 3) | ((__format) & 0x7))
+
+#define RICH		KOMEDA_FMT_RICH_LAYER
+#define SIMPLE		KOMEDA_FMT_SIMPLE_LAYER
+#define RICH_SIMPLE	(KOMEDA_FMT_RICH_LAYER | KOMEDA_FMT_SIMPLE_LAYER)
+#define RICH_WB		(KOMEDA_FMT_RICH_LAYER | KOMEDA_FMT_WB_LAYER)
+#define RICH_SIMPLE_WB	(RICH_SIMPLE | KOMEDA_FMT_WB_LAYER)
+
+#define Rot_0		DRM_MODE_ROTATE_0
+#define Flip_H_V	(DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y | Rot_0)
+#define Rot_ALL_H_V	(DRM_MODE_ROTATE_MASK | Flip_H_V)
+
+#define LYT_NM		BIT(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16)
+#define LYT_WB		BIT(AFBC_FORMAT_MOD_BLOCK_SIZE_32x8)
+#define LYT_NM_WB	(LYT_NM | LYT_WB)
+
+#define AFB_TH		AFBC(_TILED | _SPARSE)
+#define AFB_TH_SC_YTR	AFBC(_TILED | _SC | _SPARSE | _YTR)
+#define AFB_TH_SC_YTR_BS AFBC(_TILED | _SC | _SPARSE | _YTR | _SPLIT)
+
+static struct komeda_format_caps d71_format_caps_table[] =3D {
+	/*   HW_ID    |        fourcc        | tile_sz |   layer_types |   rots  =
  | afbc_layouts | afbc_features */
+	/* ABGR_2101010*/
+	{__HW_ID(0, 0),	DRM_FORMAT_ARGB2101010,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, =
0},
+	{__HW_ID(0, 1),	DRM_FORMAT_ABGR2101010,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, =
0},
+	{__HW_ID(0, 1),	DRM_FORMAT_ABGR2101010,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_=
NM_WB, AFB_TH_SC_YTR_BS}, /* afbc */
+	{__HW_ID(0, 2),	DRM_FORMAT_RGBA1010102,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, =
0},
+	{__HW_ID(0, 3),	DRM_FORMAT_BGRA1010102,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, =
0},
+	/* ABGR_8888*/
+	{__HW_ID(1, 0),	DRM_FORMAT_ARGB8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(1, 1),	DRM_FORMAT_ABGR8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(1, 1),	DRM_FORMAT_ABGR8888,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_=
WB, AFB_TH_SC_YTR_BS}, /* afbc */
+	{__HW_ID(1, 2),	DRM_FORMAT_RGBA8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(1, 3),	DRM_FORMAT_BGRA8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	/* XBGB_8888 */
+	{__HW_ID(2, 0),	DRM_FORMAT_XRGB8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(2, 1),	DRM_FORMAT_XBGR8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(2, 2),	DRM_FORMAT_RGBX8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(2, 3),	DRM_FORMAT_BGRX8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	/* BGR_888 */ /* none-afbc RGB888 doesn't support rotation and flip */
+	{__HW_ID(3, 0),	DRM_FORMAT_RGB888,	1,	RICH_SIMPLE_WB,	Rot_0,			0, 0},
+	{__HW_ID(3, 1),	DRM_FORMAT_BGR888,	1,	RICH_SIMPLE_WB,	Rot_0,			0, 0},
+	{__HW_ID(3, 1),	DRM_FORMAT_BGR888,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_WB=
, AFB_TH_SC_YTR_BS}, /* afbc */
+	/* BGR 16bpp */
+	{__HW_ID(4, 0),	DRM_FORMAT_RGBA5551,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
+	{__HW_ID(4, 1),	DRM_FORMAT_ABGR1555,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
+	{__HW_ID(4, 1),	DRM_FORMAT_ABGR1555,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_=
WB, AFB_TH_SC_YTR}, /* afbc */
+	{__HW_ID(4, 2),	DRM_FORMAT_RGB565,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
+	{__HW_ID(4, 3),	DRM_FORMAT_BGR565,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
+	{__HW_ID(4, 3),	DRM_FORMAT_BGR565,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_WB=
, AFB_TH_SC_YTR}, /* afbc */
+	{__HW_ID(4, 4), DRM_FORMAT_R8,		1,	SIMPLE,		Rot_0,			0, 0},
+	/* YUV 444/422/420 8bit  */
+	{__HW_ID(5, 0),	0 /*XYUV8888*/,		1,	0,		0,			0, 0},
+	/* XYUV unsupported*/
+	{__HW_ID(5, 1),	DRM_FORMAT_YUYV,	1,	RICH,		Rot_ALL_H_V,	LYT_NM, AFB_TH}, =
/* afbc */
+	{__HW_ID(5, 2),	DRM_FORMAT_YUYV,	1,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(5, 3),	DRM_FORMAT_UYVY,	1,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(5, 4),	0, /*X0L0 */		2,		0,			0, 0}, /* Y0L0 unsupported */
+	{__HW_ID(5, 6),	DRM_FORMAT_NV12,	1,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(5, 6),	0/*DRM_FORMAT_YUV420_8BIT*/,	1,	RICH,	Rot_ALL_H_V,	LYT_NM=
, AFB_TH}, /* afbc */
+	{__HW_ID(5, 7),	DRM_FORMAT_YUV420,	1,	RICH,		Flip_H_V,		0, 0},
+	/* YUV 10bit*/
+	{__HW_ID(6, 0),	0,/*XVYU2101010*/	1,	0,		0,			0, 0},/* VYV30 unsupported =
*/
+	{__HW_ID(6, 6),	0/*DRM_FORMAT_X0L2*/,	2,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(6, 7),	0/*DRM_FORMAT_P010*/,	1,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(6, 7),	0/*DRM_FORMAT_YUV420_10BIT*/, 1,	RICH,	Rot_ALL_H_V,	LYT_N=
M, AFB_TH},
+};
+
+static void d71_init_fmt_tbl(struct komeda_dev *mdev)
+{
+	struct komeda_format_caps_table *table =3D &mdev->fmt_tbl;
+
+	table->format_caps =3D d71_format_caps_table;
+	table->n_formats =3D ARRAY_SIZE(d71_format_caps_table);
+}
+
 static struct komeda_dev_funcs d71_chip_funcs =3D {
+	.init_format_table =3D d71_init_fmt_tbl,
 	.enum_resources	=3D d71_enum_resources,
 	.cleanup	=3D NULL,
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index d0cc4f758077..2f8f4685eb62 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -138,6 +138,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
)
 		 MALIDP_CORE_ID_MAJOR(mdev->chip.core_id),
 		 MALIDP_CORE_ID_MINOR(mdev->chip.core_id));
=20
+	mdev->funcs->init_format_table(mdev);
+
 	err =3D mdev->funcs->enum_resources(mdev);
 	if (err) {
 		DRM_ERROR("enumerate display resource failed.\n");
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 4a27a44e2ec6..555510be66f1 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include "komeda_pipeline.h"
 #include "malidp_product.h"
+#include "komeda_format_caps.h"
=20
 /* malidp device id */
 enum {
@@ -44,6 +45,13 @@ struct komeda_dev;
  * Supplied by chip level and returned by the chip entry function xxx_iden=
tify,
  */
 struct komeda_dev_funcs {
+	/**
+	 * @init_format_table:
+	 *
+	 * initialize &komeda_dev->format_table, this function should be called
+	 * before the &enum_resource
+	 */
+	void (*init_format_table)(struct komeda_dev *mdev);
 	/**
 	 * @enum_resources:
 	 *
@@ -66,7 +74,8 @@ struct komeda_dev {
 	u32 __iomem   *reg_base;
=20
 	struct komeda_chip_info chip;
-
+	/** @fmt_tbl: initialized by &komeda_dev_funcs->init_format_table */
+	struct komeda_format_caps_table fmt_tbl;
 	/** @pclk: APB clock for register access */
 	struct clk *pclk;
 	/** @mck: HW main engine clk */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_format_caps.c
new file mode 100644
index 000000000000..1e17bd6107a4
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+
+#include <linux/slab.h>
+#include "komeda_format_caps.h"
+#include "malidp_utils.h"
+
+const struct komeda_format_caps *
+komeda_get_format_caps(struct komeda_format_caps_table *table,
+		       u32 fourcc, u64 modifier)
+{
+	const struct komeda_format_caps *caps;
+	u64 afbc_features =3D modifier & ~(AFBC_FORMAT_MOD_BLOCK_SIZE_MASK);
+	u32 afbc_layout =3D modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK;
+	int id;
+
+	for (id =3D 0; id < table->n_formats; id++) {
+		caps =3D &table->format_caps[id];
+
+		if (fourcc !=3D caps->fourcc)
+			continue;
+
+		if ((modifier =3D=3D 0ULL) && (caps->supported_afbc_layouts =3D=3D 0))
+			return caps;
+
+		if (has_bits(afbc_features, caps->supported_afbc_features) &&
+		    has_bit(afbc_layout, caps->supported_afbc_layouts))
+			return caps;
+	}
+
+	return NULL;
+}
+
+u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table,
+				  u32 layer_type, u32 *n_fmts)
+{
+	const struct komeda_format_caps *cap;
+	u32 *fmts;
+	int i, j, n =3D 0;
+
+	fmts =3D kcalloc(table->n_formats, sizeof(u32), GFP_KERNEL);
+	if (!fmts)
+		return NULL;
+
+	for (i =3D 0; i < table->n_formats; i++) {
+		cap =3D &table->format_caps[i];
+		if (!(layer_type & cap->supported_layer_types) ||
+		    (cap->fourcc =3D=3D 0))
+			continue;
+
+		/* one fourcc may has two caps items in table (afbc/none-afbc),
+		 * so check the existing list to avoid adding a duplicated one.
+		 */
+		for (j =3D n - 1; j >=3D 0; j--)
+			if (fmts[j] =3D=3D cap->fourcc)
+				break;
+
+		if (j < 0)
+			fmts[n++] =3D cap->fourcc;
+	}
+
+	if (n_fmts)
+		*n_fmts =3D n;
+
+	return fmts;
+}
+
+void komeda_put_fourcc_list(u32 *fourcc_list)
+{
+	kfree(fourcc_list);
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/driv=
ers/gpu/drm/arm/display/komeda/komeda_format_caps.h
new file mode 100644
index 000000000000..60f39e77b098
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+
+#ifndef _KOMEDA_FORMAT_CAPS_H_
+#define _KOMEDA_FORMAT_CAPS_H_
+
+#include <linux/types.h>
+#include <uapi/drm/drm_fourcc.h>
+#include <drm/drm_fourcc.h>
+
+#define AFBC(x)		DRM_FORMAT_MOD_ARM_AFBC(x)
+
+/* afbc layerout */
+#define AFBC_16x16(x)	AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 | (x))
+#define AFBC_32x8(x)	AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_32x8 | (x))
+
+/* afbc features */
+#define _YTR		AFBC_FORMAT_MOD_YTR
+#define _SPLIT		AFBC_FORMAT_MOD_SPLIT
+#define _SPARSE		AFBC_FORMAT_MOD_SPARSE
+#define _CBR		AFBC_FORMAT_MOD_CBR
+#define _TILED		AFBC_FORMAT_MOD_TILED
+#define _SC		AFBC_FORMAT_MOD_SC
+
+/* layer_type */
+#define KOMEDA_FMT_RICH_LAYER		BIT(0)
+#define KOMEDA_FMT_SIMPLE_LAYER		BIT(1)
+#define KOMEDA_FMT_WB_LAYER		BIT(2)
+
+#define AFBC_TH_LAYOUT_ALIGNMENT	8
+#define AFBC_HEADER_SIZE		16
+#define AFBC_SUPERBLK_ALIGNMENT		128
+#define AFBC_SUPERBLK_PIXELS		256
+#define AFBC_BODY_START_ALIGNMENT	1024
+#define AFBC_TH_BODY_START_ALIGNMENT	4096
+
+/**
+ * struct komeda_format_caps
+ *
+ * komeda_format_caps is for describing ARM display specific features and
+ * limitations for a specific format, and format_caps will be linked into
+ * &komeda_framebuffer like a extension of &drm_format_info.
+ *
+ * NOTE: one fourcc may has two different format_caps items for fourcc and
+ * fourcc+modifier
+ *
+ * @hw_id: hw format id, hw specific value.
+ * @fourcc: drm fourcc format.
+ * @tile_size: format tiled size, used by ARM format X0L0/X0L2
+ * @supported_layer_types: indicate which layer supports this format
+ * @supported_rots: allowed rotations for this format
+ * @supported_afbc_layouts: supported afbc layerout
+ * @supported_afbc_features: supported afbc features
+ */
+struct komeda_format_caps {
+	u32 hw_id;
+	u32 fourcc;
+	u32 tile_size;
+	u32 supported_layer_types;
+	u32 supported_rots;
+	u32 supported_afbc_layouts;
+	u64 supported_afbc_features;
+};
+
+/**
+ * struct komeda_format_caps_table - format_caps mananger
+ *
+ * @n_formats: the size of format_caps list.
+ * @format_caps: format_caps list.
+ */
+struct komeda_format_caps_table {
+	u32 n_formats;
+	const struct komeda_format_caps *format_caps;
+};
+
+const struct komeda_format_caps *
+komeda_get_format_caps(struct komeda_format_caps_table *table,
+		       u32 fourcc, u64 modifier);
+
+u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table,
+				  u32 layer_type, u32 *n_fmts);
+
+void komeda_put_fourcc_list(u32 *fourcc_list);
+
+#endif
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index d1e0c1140273..2d68ffeae25d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -213,6 +213,7 @@ static inline u16 component_changed_inputs(struct komed=
a_component_state *st)
 struct komeda_layer {
 	struct komeda_component base;
 	/* layer specific features and caps */
+	int layer_type; /* RICH, SIMPLE or WB */
 };
=20
 struct komeda_layer_state {
--=20
2.17.1

