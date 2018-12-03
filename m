Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EF0C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA8220834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rJ5oAQDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA8220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeLCLc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:32:58 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:21376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeLCLcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdh3NHny5Jk/CWNQBJv7x1e9taL4sFVzooXeEhz+Vqo=;
 b=rJ5oAQDt2VY/YXYLmnbkw14gydZMDKZk1tyJrHZ4Z9cd7aEUhCN1N4mZj6yStU9F53Cy0P6QzFN9vg3cu5dpecmMKjC67xcvTc2SHRauLegXRCpxm3yhOZQuV3LL7knvyQEaqfQz+exPXPe9UB3YCc3XEUnoqsdNRmeuB7HeTWU=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:32:04 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:32:04 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [RFC AFBC 10/12] drm/arm/malidp:- Use the newly introduced
 malidp_format_get_bpp() instead of relying on cpp for calculating framebuffer
 size
Thread-Topic: [RFC AFBC 10/12] drm/arm/malidp:- Use the newly introduced
 malidp_format_get_bpp() instead of relying on cpp for calculating framebuffer
 size
Thread-Index: AQHUivvQHh1qBrcHw0685ENPd/8CJw==
Date:   Mon, 3 Dec 2018 11:32:04 +0000
Message-ID: <1543836703-8491-11-git-send-email-ayan.halder@arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::27) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:NUslAUKtdecZW3YYPqKRqNlJmBfcPwLKBq1f4ZuCB4mQaUvhtAQa+zzeaKIjT/wedEy7k3z7MPFe4zoTtKl4mzZb8sDpwHESqTQDSw2Lu33iHfWmCLbVkbc/iZrHu+RnLrCgXp2Ds9MxKOjaD3b6FvZ9xe+6S2kI+k7dXw2NRkN6i3DO6jKFeG4oWghuKwlLabcoJxsQKy4F6zQ2Bfb5WHOz284PrOJ2Oh6q5v/HueseHGGy/1FiIPDGYb/gja9Wmc09/bET1TIPemeDpAxJOSjYRLmGnINEI755rK3pHQwQlPVjqgmCzwg43vImBurGlC/V1nBCf2Ag2yKsUfziHGvlPkhhVD17w/XoZt87mSa4TL38QrKOqt/5SLhv3YvuZ3mzwgE7N2kLRd8nVwUU1OabMaO1DJoeKxkjzCl1L1yLIYCbV7Eagr3UWhA3of/brXUqSfA4Amk89C4IZsv0SQ==;5:R4l6j5Edzw7m5Xq4PNLcncoMnzHsd8yYFEGLzwggcNve790FIBtOx/RmTkCWrYvOyx89ZV2NQd/EahBdPonAR12KbtQdMRMKzsBfnxJWOMXULTRRby5pAH+2NKW86IL1Xig8pkAvfjrKbMMRWSZ4UdSH9ZYHdNCwo9PL3JTp9RU=;7:8afJYT0bStmkBCFaqXq2472iwlvSyFaVHTALz6bQesM3Xq7rU4/JtlMKbt84rd4epEl+G3e3XU2Uwe2BqLrRQw3fmIFdMxbMro1HuV9CX34LLGgFbLdVgKJj/zZw2cheHP4Y9Nn5xCy5gkP+JLRbcg==
x-ms-office365-filtering-correlation-id: 952ef909-aa1e-4f94-0d48-08d65912f32d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3491D1C7CFCB70A60C0417E1E4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(11346002)(486006)(2906002)(2501003)(8676002)(14444005)(575784001)(2616005)(44832011)(476003)(6512007)(105586002)(217873002)(53936002)(52116002)(446003)(386003)(6506007)(86362001)(110136005)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4+EIBAmEimz6u8kHCFNHbu9R73gnpQO0YEkV661pKFbBuFq1zHPp93dH1Qhcvw28MM7in0a33ff4F7OUjTqGeqA3NAMsDDVY/AYROLIfuhZEW9eg4jr/VPewyI6YplN1sEuPNQePxUdum8FoTBOiHhksUbztPBoKPK8J56v4U6RT+hxpSCEFMvPCIjzbaMD7DwfKuFt7EW/5FsuU/iWeeyXkYFFU5hTGoWJD1OPCcUEaSUMApsKMHWfMgjUhRHFlmbGhtP5z5E+WRiYkrObLegVVkNRTTBuB6EiiNY3i9s+iKPAjs0adRhOS8PajR8V1hTHjPp+YevtxQy6jZ+ww+YUvkNOIfPMynTSWxtOGoF8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952ef909-aa1e-4f94-0d48-08d65912f32d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:32:04.6085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formats like DRM_FORMAT_VUY101010, DRM_FORMAT_YUV420_8BIT and
DRM_FORMAT_YUV420_10BIT are expressed in bits per pixel as they have a non
integer value of cpp (thus denoted as '0' in drm_format_info[]). Therefore,
the calculation of AFBC framebuffer size needs to use malidp_format_get_bpp=
().

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index 2f0b553..b2b97db 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -297,6 +297,7 @@ malidp_verify_afbc_framebuffer_size(struct drm_device *=
dev,
 	struct drm_gem_object *objs =3D NULL;
 	u32 afbc_superblock_size =3D 0, afbc_superblock_height =3D 0;
 	u32 afbc_superblock_width =3D 0, afbc_size =3D 0;
+	int bpp =3D 0;
=20
 	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
 	case AFBC_SIZE_16X16:
@@ -313,15 +314,17 @@ malidp_verify_afbc_framebuffer_size(struct drm_device=
 *dev,
 	n_superblocks =3D (mode_cmd->width / afbc_superblock_width) *
 		(mode_cmd->height / afbc_superblock_height);
=20
-	afbc_superblock_size =3D info->cpp[0] * afbc_superblock_width *
-		afbc_superblock_height;
+	bpp =3D malidp_format_get_bpp(info->format);
+
+	afbc_superblock_size =3D (bpp * afbc_superblock_width * afbc_superblock_h=
eight) / BITS_PER_BYTE;
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
+			      (mode_cmd->pitches[0] * BITS_PER_BYTE), mode_cmd->width, bpp);
 		return false;
 	}
=20
--=20
2.7.4

