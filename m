Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62289C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288282173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="J+dIuxsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfBZQVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:21:14 -0500
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:63296
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727456AbfBZQVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1mkF1ohZiKCiBmjZSvBHvHZADOJTrYEJ3Xmjd7Tn0w=;
 b=J+dIuxsEd/40NMgpecUh5Bb/Sctful3ZB0AQLbrTZf5ndf6VOyjHAZg2b9cZb6tOUux/aAC1S5709jQbSopR2ZsVSzRf0GwZPfSOLzQFrI7/V2vxoBIuEauW8/i6huSsGoiMw1xpT6o+4u5wurRUb+HrwgAY9ir5dG1ZSb2DB4E=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3682.eurprd08.prod.outlook.com (20.178.21.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 16:20:59 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 16:20:59 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [PATCH 08/10] drm/arm/malidp:- Use the newly introduced
 malidp_format_get_bpp() instead of relying on cpp for calculating framebuffer
 size
Thread-Topic: [PATCH 08/10] drm/arm/malidp:- Use the newly introduced
 malidp_format_get_bpp() instead of relying on cpp for calculating framebuffer
 size
Thread-Index: AQHUze9CPOLKNoMBdUeUyRg1WVYusg==
Date:   Tue, 26 Feb 2019 16:20:59 +0000
Message-ID: <1551198042-4314-9-git-send-email-ayan.halder@arm.com>
References: <1551198042-4314-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1551198042-4314-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::16) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e3cbb5e-e812-42ef-8a97-08d69c066478
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3682;
x-ms-traffictypediagnostic: AM0PR08MB3682:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3682;20:1yG1MbiveYeY4AfxhfznIudWID4ctwA0RqwWCwA9AiBLGROcw6Vh871Qzc1dogmw34rOu5BT2qurmjS8FAR5DGJtaWVkAakMFArXQjh6N/iQ0xsdWyNZrHgwipC3EKTEWTeu+YM3ZWz9xZISSWJuq2E/qEwXcGkv9eB6a82X93A=
x-microsoft-antispam-prvs: <AM0PR08MB3682EA2CADD47738D66CFCC3E47B0@AM0PR08MB3682.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(6116002)(8936002)(50226002)(76176011)(2906002)(99286004)(36756003)(25786009)(2501003)(97736004)(52116002)(3846002)(4326008)(68736007)(11346002)(256004)(14444005)(6486002)(446003)(6436002)(478600001)(44832011)(2616005)(486006)(476003)(26005)(105586002)(186003)(53936002)(6512007)(66066001)(7736002)(305945005)(102836004)(316002)(110136005)(71190400001)(81156014)(81166006)(71200400001)(386003)(6506007)(14454004)(5660300002)(106356001)(2201001)(86362001)(72206003)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3682;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GcA8E6zPy5gGLdYKAvbkO55Vp5Sfj5hu4V8PrJOdybwrQGncZVO8AcimnBe0QCg7Y8FTv613TJReHHzGWpnbkMyHsbuT8uAwqoGse4W5Y8PK+bbcFaC6y0e4KNmmqeyf8whOrHTYXHac56+1DDRmLsZNnZuRiWhHnS2Kz1OgXE9cEpKrqoUfuZ01oBnuNGCgSqBRGIYLIhadrTdghXgVXBExQ7SwTNHt15JpNGRQ3F3uo6RNJFnTbxmbQgsVAYI+NprKDa3qO8YQQSa2aL2sv1pEt5PtzU0uUOTH41KhE1Um5mIjkae9BXGvGUIHtdtXar53y3NOLNpfpCZEi0yPb1BbFQylOTfnMeZcQfRNfkQiB25v2ZE5nmjGK0lR1S0xG/BTyH86lxFeOEq6KPHZG5pof0O+INbbB9kqH7Yzhc0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3cbb5e-e812-42ef-8a97-08d69c066478
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 16:20:58.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ayan Kumar Halder <ayan.halder@arm.com>

Formats like DRM_FORMAT_VUY101010, DRM_FORMAT_YUV420_8BIT and
DRM_FORMAT_YUV420_10BIT are expressed in bits per pixel as they have a non
integer value of cpp (thus denoted as '0' in drm_format_info[]). Therefore,
the calculation of AFBC framebuffer size needs to use malidp_format_get_bpp=
().

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index c697664..4106f5d 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -298,6 +298,7 @@ malidp_verify_afbc_framebuffer_size(struct drm_device *=
dev,
 	struct drm_gem_object *objs =3D NULL;
 	u32 afbc_superblock_size =3D 0, afbc_superblock_height =3D 0;
 	u32 afbc_superblock_width =3D 0, afbc_size =3D 0;
+	int bpp =3D 0;
=20
 	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
 	case AFBC_SIZE_16X16:
@@ -314,15 +315,19 @@ malidp_verify_afbc_framebuffer_size(struct drm_device=
 *dev,
 	n_superblocks =3D (mode_cmd->width / afbc_superblock_width) *
 		(mode_cmd->height / afbc_superblock_height);
=20
-	afbc_superblock_size =3D info->cpp[0] * afbc_superblock_width *
-		afbc_superblock_height;
+	bpp =3D malidp_format_get_bpp(info->format);
+
+	afbc_superblock_size =3D (bpp * afbc_superblock_width * afbc_superblock_h=
eight)
+				/ BITS_PER_BYTE;
=20
 	afbc_size =3D ALIGN(n_superblocks * AFBC_HEADER_SIZE, AFBC_SUPERBLK_ALIGN=
MENT);
 	afbc_size +=3D n_superblocks * ALIGN(afbc_superblock_size, AFBC_SUPERBLK_=
ALIGNMENT);
=20
-	if (mode_cmd->width * info->cpp[0] !=3D mode_cmd->pitches[0]) {
-		DRM_DEBUG_KMS("Invalid value of pitch (=3D%u) should be same as width (=
=3D%u) * cpp (=3D%u)\n",
-			      mode_cmd->pitches[0], mode_cmd->width, info->cpp[0]);
+	if ((mode_cmd->width * bpp) !=3D (mode_cmd->pitches[0] * BITS_PER_BYTE)) =
{
+		DRM_DEBUG_KMS("Invalid value of (pitch * BITS_PER_BYTE) (=3D%u) "
+			      "should be same as width (=3D%u) * bpp (=3D%u)\n",
+			      (mode_cmd->pitches[0] * BITS_PER_BYTE),
+			      mode_cmd->width, bpp);
 		return false;
 	}
=20
--=20
2.7.4

