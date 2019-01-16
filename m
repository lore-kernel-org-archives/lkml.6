Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60376C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591020657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MGDo5f+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392638AbfAPLtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:49:21 -0500
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:27264
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392567AbfAPLs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+gN+/DvuBoE4/q2O0atgMWTOzv1ylFXWdauO0BJNFs=;
 b=MGDo5f+mAUsEIMCm3CtbW6l0ygBNAPmHlsDkurYQ6HOBB7bgTBPGdgOC5Zdw/oQKhj4tl/15JGAq5fc1mp2onzxRxPgF0huFj+Cl4DkA/c0BoiGD029UMI8stbE4rhmGqlFcDseUR0JeC3LQM+crkLsZjB2lck8WmsgrJhxCboI=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6101.eurprd04.prod.outlook.com (20.179.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:44 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:44 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
CC:     Mirela Rabulea <mirela.rabulea@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Anson Huang <anson.huang@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/11] drm/mxsfb: Add support for new pixel formats in eLCDIF
Thread-Topic: [PATCH 06/11] drm/mxsfb: Add support for new pixel formats in
 eLCDIF
Thread-Index: AQHUrZFuCcJLoRFpvkKuYXlUDwBNcQ==
Date:   Wed, 16 Jan 2019 11:48:44 +0000
Message-ID: <1547639306-19151-7-git-send-email-robert.chiras@nxp.com>
References: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:203:91::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6101;6:idCa9M0rjoDIMEZMkJ/cCFN7x0Hpt00JENkQs3ylXmQuSA9ySPfDbZEsr4ojAzzphecRY5/phRMCCT13mkhbSsRUcVmQo/lb3ZBZO0oHlR+e04Y2qfVk9fQSnxlX/N3E/4rFjjbAly7fuwHDBMbKjN/ksxb+Fo5VS1BmG1xp3IOLO8Lb1sTK9kYeyR1dz3314/8I4GgZOvTbBw604LYIyJ2s6FNljnpNpT4hPukfACyr8uHigraGvDoy3FIyZ6MEbqUJhyRlWu+BWQ8AigIRyImgFJuN4nwREKg8BrII7lkLuuvxzLvNw97l6zlsN9uB8UREHUMi40QBuUFUBbBvITmEuy7WQVHSQ65HRiOjGEkq8a3Nb6jIlcduoD11ug56z2DsgsWVrEcJrJ6m76PPsT73P7C32FaaiHNrfMLNBmBdqg/47a8IEoMkICMPgUKOadBNw5PMevFW0ndEMeHy8w==;5:E7uJCz1sVjl9T0rVtD7ZwNXg/Nm4KzFe/r+P5R0yuV6mGmBaw7gIlHehE2DPuhgta3UHDoZA0GMPTkviZV/seH8ZRemNnP8PXpBQ42tbNpcRCQH5E9tyB817NZSl+9ugX57/8dxkb16K56YYPlksSSKEPi9OyQKEcmhJ8RytQx2SNswntPjT5HvJk5d5bmI54oBt3HlbdjdMt8KmYcjkTw==;7:J78LTWY4QVAPb0GknEY+/0Jz0MGJOFVp6ieAAbBLj5kUS34/bT4LfEtTQ91pq2GV7CqMbFMG3MEbsl/8aFtOnwPoBO+IpiGR01fm84Y2ArdPDSX1K4fTLTW3LbAHfb1EhOnbmBArAPr3rFN+H6wmvA==
x-ms-office365-filtering-correlation-id: e3b856c8-f8f4-4cb8-1fee-08d67ba89109
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6101;
x-ms-traffictypediagnostic: AM6PR04MB6101:
x-microsoft-antispam-prvs: <AM6PR04MB61012B0FA277922981739B8CE3820@AM6PR04MB6101.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(316002)(81156014)(110136005)(102836004)(81166006)(476003)(26005)(2616005)(186003)(8676002)(7736002)(66066001)(3846002)(50226002)(105586002)(305945005)(6486002)(8936002)(99286004)(54906003)(6436002)(106356001)(6116002)(86362001)(2906002)(44832011)(14454004)(478600001)(486006)(71200400001)(68736007)(97736004)(5660300001)(53936002)(76176011)(36756003)(256004)(446003)(14444005)(11346002)(25786009)(386003)(6506007)(6512007)(52116002)(4326008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6101;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wxDYi3ETtWNqQvToNCafD6tMGtxcMA9LuZFNfNjmyDSiGmYjMkWqX5SSi+1K2V7stF3DjtLlRlYFQ9JG3kfgFMieq9TzPA5we2YPJh60vMmGnHiN9DixyA36mQIMmBscqoeJdiHspdd/MlgVTGfv0NSRaB/yiA5gyog+ZCEGC4FkLZc8fU0DQJf7NS0CenbEwrH7nuWAr2ERnZmpAjVdQ35pzVKn0AMZ6pe73l2MThBUh85i9Tvmuvfe+SzppZdR6rwOCWSVmmECxlQO92QEoOcrNm5wNTvnyqfiuqypEWhszr/p5bu/aulI8Wji9Vz+hukYzPR3FWvmiqXbl4DFHYCtfG7i97c9IcFBpBQwQu/lsNHZeRE3l9kUKL9r9nOwcZf0qCIEiS85KGxCvCN1/IfQJjlZCyrDkLZinY+ZwtM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b856c8-f8f4-4cb8-1fee-08d67ba89109
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:43.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mirela Rabulea <mirela.rabulea@nxp.com>

Add support for the following pixel formats:
	16 bpp: RG16 ,BG16, XR15, XB15, AR15, AB15
Set the bus format based on input from the user and panel capabilities.
Save the bus format in crtc->mode.private_flags, the DSI will use it.
Use drm_get_format_name instead of locally defined fourcc_to_str.

Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 100 ++++++++++++++++++++++++++-------=
----
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  |   5 ++
 2 files changed, 76 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxs=
fb_crtc.c
index 2fdb268..b1d0267 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -48,24 +48,6 @@ static u32 set_hsync_pulse_width(struct mxsfb_drm_privat=
e *mxsfb, u32 val)
 		mxsfb->devdata->hs_wdth_shift;
 }
=20
-/*  Print Four-character-code (FOURCC) */
-static char *fourcc_to_str(u32 fmt)
-{
-	/* Use 10 chars so we can simultaneously print two codes */
-	static char code[10], *c =3D &code[0];
-
-	if (c =3D=3D &code[10])
-		c =3D &code[0];
-
-	*(c++) =3D (unsigned char)(fmt & 0xff);
-	*(c++) =3D (unsigned char)((fmt >> 8) & 0xff);
-	*(c++) =3D (unsigned char)((fmt >> 16) & 0xff);
-	*(c++) =3D (unsigned char)((fmt >> 24) & 0xff);
-	*(c++) =3D '\0';
-
-	return (c - 5);
-}
-
 /* Setup the MXSFB registers for decoding the pixels out of the framebuffe=
r */
 static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *mxsfb, bool updat=
e)
 {
@@ -74,6 +56,7 @@ static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *=
mxsfb, bool update)
 	const u32 format =3D crtc->primary->state->fb->format->format;
 	u32 ctrl =3D 0, ctrl1 =3D 0;
 	bool bgr_format =3D true;
+	struct drm_format_name_buf format_name_buf;
=20
 	if (!update)
 		ctrl =3D CTRL_BYPASS_COUNT | CTRL_MASTER;
@@ -92,7 +75,7 @@ static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *=
mxsfb, bool update)
 	}
=20
 	DRM_DEV_DEBUG_DRIVER(drm->dev, "Setting up %s mode\n",
-		fourcc_to_str(format));
+			drm_get_format_name(format, &format_name_buf));
=20
 	/* Do some clean-up that we might have from a previous mode */
 	ctrl &=3D ~CTRL_SHIFT_DIR(1);
@@ -103,19 +86,41 @@ static int mxsfb_set_pixel_fmt(struct mxsfb_drm_privat=
e *mxsfb, bool update)
 		       mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
=20
 	switch (format) {
-	case DRM_FORMAT_RGB565:
+	case DRM_FORMAT_BGR565: /* BG16 */
+		if (mxsfb->devdata->ipversion < 4)
+			goto err;
+		writel(CTRL2_ODD_LINE_PATTERN(0x5) |
+			CTRL2_EVEN_LINE_PATTERN(0x5),
+			mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+		/* Fall through */
+	case DRM_FORMAT_RGB565: /* RG16 */
 		ctrl |=3D CTRL_SET_WORD_LENGTH(0);
+		ctrl &=3D ~CTRL_DF16;
 		ctrl1 |=3D CTRL1_SET_BYTE_PACKAGING(0xf);
 		break;
-	case DRM_FORMAT_RGBX8888:
-	case DRM_FORMAT_RGBA8888:
+	case DRM_FORMAT_XBGR1555: /* XB15 */
+	case DRM_FORMAT_ABGR1555: /* AB15 */
+		if (mxsfb->devdata->ipversion < 4)
+			goto err;
+		writel(CTRL2_ODD_LINE_PATTERN(0x5) |
+			CTRL2_EVEN_LINE_PATTERN(0x5),
+			mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+		/* Fall through */
+	case DRM_FORMAT_XRGB1555: /* XR15 */
+	case DRM_FORMAT_ARGB1555: /* AR15 */
+		ctrl |=3D CTRL_SET_WORD_LENGTH(0);
+		ctrl |=3D CTRL_DF16;
+		ctrl1 |=3D CTRL1_SET_BYTE_PACKAGING(0xf);
+		break;
+	case DRM_FORMAT_RGBX8888: /* RX24 */
+	case DRM_FORMAT_RGBA8888: /* RA24 */
 		/* RGBX - > 0RGB */
 		ctrl |=3D CTRL_SHIFT_DIR(1);
 		ctrl |=3D CTRL_SHIFT_NUM(8);
 		bgr_format =3D false;
 		/* Fall through */
-	case DRM_FORMAT_XBGR8888:
-	case DRM_FORMAT_ABGR8888:
+	case DRM_FORMAT_XBGR8888: /* XB24 */
+	case DRM_FORMAT_ABGR8888: /* AB24 */
 		if (bgr_format) {
 			if (mxsfb->devdata->ipversion < 4)
 				goto err;
@@ -124,8 +129,8 @@ static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private=
 *mxsfb, bool update)
 			       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
 		}
 		/* Fall through */
-	case DRM_FORMAT_XRGB8888:
-	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_XRGB8888: /* XR24 */
+	case DRM_FORMAT_ARGB8888: /* AR24 */
 		ctrl |=3D CTRL_SET_WORD_LENGTH(3);
 		/* Do not use packed pixels =3D one pixel per word instead. */
 		ctrl1 |=3D CTRL1_SET_BYTE_PACKAGING(0x7);
@@ -146,19 +151,56 @@ static int mxsfb_set_pixel_fmt(struct mxsfb_drm_priva=
te *mxsfb, bool update)
=20
 err:
 	DRM_DEV_ERROR(drm->dev, "Unhandled pixel format: %s\n",
-		      fourcc_to_str(format));
+			drm_get_format_name(format, &format_name_buf));
+
 	return -EINVAL;
 }
=20
+static u32 get_bus_format_from_bpp(u32 bpp)
+{
+	switch (bpp) {
+	case 16:
+		return MEDIA_BUS_FMT_RGB565_1X16;
+	case 18:
+		return MEDIA_BUS_FMT_RGB666_1X18;
+	case 24:
+		return MEDIA_BUS_FMT_RGB888_1X24;
+	default:
+		return MEDIA_BUS_FMT_RGB888_1X24;
+	}
+}
+
 static void mxsfb_set_bus_fmt(struct mxsfb_drm_private *mxsfb)
 {
 	struct drm_crtc *crtc =3D &mxsfb->pipe.crtc;
+	unsigned int bits_per_pixel =3D crtc->primary->state->fb->format->depth;
 	struct drm_device *drm =3D crtc->dev;
 	u32 bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
+	int num_bus_formats =3D mxsfb->connector->display_info.num_bus_formats;
+	const u32 *bus_formats =3D mxsfb->connector->display_info.bus_formats;
 	u32 reg =3D 0;
+	int i =3D 0;
+
+	/* match the user requested bus_format to one supported by the panel */
+	if (num_bus_formats) {
+		u32 user_bus_format =3D get_bus_format_from_bpp(bits_per_pixel);
+
+		bus_format =3D bus_formats[0];
+		for (i =3D 0; i < num_bus_formats; i++) {
+			if (user_bus_format =3D=3D bus_formats[i]) {
+				bus_format =3D user_bus_format;
+				break;
+			}
+		}
+	}
=20
-	if (mxsfb->connector->display_info.num_bus_formats)
-		bus_format =3D mxsfb->connector->display_info.bus_formats[0];
+	/*
+	 * CRTC will dictate the bus format via private_flags[16:1]
+	 * and private_flags[0] will signal a bus format change
+	 */
+	crtc->mode.private_flags &=3D ~0x1FFFF; /* clear bus format */
+	crtc->mode.private_flags |=3D (bus_format << 1); /* set bus format */
+	crtc->mode.private_flags |=3D 0x1; /* bus format change indication*/
=20
 	DRM_DEV_DEBUG_DRIVER(drm->dev,
 		"Using bus_format: 0x%08X\n", bus_format);
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.c
index d292192..eb01484 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -65,6 +65,11 @@ static const uint32_t mxsfb_formats[] =3D {
 	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_RGBX8888,
 	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_BGR565
 };
=20
 static const struct mxsfb_devdata mxsfb_devdata[] =3D {
--=20
2.7.4

