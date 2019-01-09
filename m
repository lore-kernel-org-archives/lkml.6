Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F1CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42FA206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U1BXJN/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfAIOOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:14:23 -0500
Received: from mail-eopbgr00047.outbound.protection.outlook.com ([40.107.0.47]:52304
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731409AbfAION4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv+IbJoJgHv/DOLKMaH7MdWL/3jDdKpTZsgFDvUOIUY=;
 b=U1BXJN/7GDVxKHHsGoa8u6zFwEGJ+SF8NXTYMPWnEhKVTkOa38BxxHQ8PilZDBt0V+0eBj5iFqvVFZD2z+WP0EuNHmotE5LsEInafjnYnbn832SQz68DKmcTCfMex77p2OdNmtS7eVu+D0oLQ3ay/54FNHup8rSmZNDPtAx1vrg=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB5157.eurprd04.prod.outlook.com (20.177.34.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 14:13:46 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:13:46 +0000
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
Subject: [PATCH 06/10] drm/mxsfb: Add support for new pixel formats in eLCDIF
Thread-Topic: [PATCH 06/10] drm/mxsfb: Add support for new pixel formats in
 eLCDIF
Thread-Index: AQHUqCWIpokjXRlY4kiQhbXvgCRsqA==
Date:   Wed, 9 Jan 2019 14:13:46 +0000
Message-ID: <1547043209-8283-7-git-send-email-robert.chiras@nxp.com>
References: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5157;6:4J6mm9DtVbJt0jfQkJ0mtgQ8p1Fm29YXbLlj3a4kVomLXmylV3F9ysoHz9wrX12T5/IqGnNxTF6kGddMbNZs2PrM2SO+Wq5Q5ZvkGzntXxPTc0vR3dXTyoTR4JP6piRaGuEQU2duyAxKbjKlGWGwpUf1SjpzrSXR8s6xmo6hSOMZ5qAkscwPZhjDDxXwiRUFmHLfWbBBsT1EZJEZJ0tLrlSHd6cOykEN6y/8u07eWftsWAQwzAOq+2ACgkaKvJHSjWbRbHwIkvJiX8aGYdjUfJwQvHfX5uwt39wJockt5XS2lTBNlpNMj1kIzBE0CF0MKfJoAT5wXQJsqqsKGecW3mIpWbLjw0L+B1fdC0ejAK3p2YmftXWM+FhKOdkHBaMtNEMAQLimWh64MGhBQtMkW04sm+JmGarFGYzB/8GEQVg4bqTRA5QtBJHjH0D2nZCKRUfqvgTy5fd6Hd9Rmk2YVQ==;5:AoiZNGV8uYr9UazYG1diPutYYy2iwJKEa354jIyczv9QW5ZFgWmUOslh2WiVpDOtMx2J3tOQG5bin6sEtkzkFzAkSBiUWrvJDeRGJpf7uuzo5F93Q8sNXAoDWxLSHWOHNOrMSkuj81W2Mws6t9YLd219RxrsERuZSCNsvTQzU9/2oHx69kYbwy4O9306q0wnim3yZ8ejtxWrY/MP7utOFg==;7:BHMmWhExGudH/Y5+ZJPWl3QFWXCJaVzDNpEOW7cjEJ+hvILhzKioOURAPp/3ub8gQWTg8gphGv56b8Z2ju0GgMjgHwghXuViVHYpRSfeyjsPzP1kl/HzyjEJc4tQCy1I6UWchuGu8E0Vjj9lq51FGA==
x-ms-office365-filtering-correlation-id: 58631782-5d47-43c7-77b1-08d6763cab1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5157;
x-ms-traffictypediagnostic: AM6PR04MB5157:
x-microsoft-antispam-prvs: <AM6PR04MB515703EAECD618159FEB7529E38B0@AM6PR04MB5157.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5157;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5157;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(50226002)(99286004)(11346002)(110136005)(2616005)(256004)(316002)(86362001)(14444005)(54906003)(305945005)(7736002)(8676002)(71190400001)(6486002)(71200400001)(446003)(8936002)(105586002)(97736004)(81166006)(81156014)(36756003)(106356001)(476003)(25786009)(486006)(6436002)(186003)(3846002)(6116002)(478600001)(68736007)(53936002)(102836004)(6512007)(14454004)(5660300001)(44832011)(76176011)(52116002)(386003)(26005)(6506007)(2906002)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5157;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vSkT2nxUC0zG4WHiwV/xHEZUzpEMzOp8/k+TbKGQg1/Pka6mpE2bkWUqwSrfmmsFxXb1mhMPR8p5JwcwV+Iz69WuUk42U1vkKTeq4IM87Mf/+Gv8bfr9+zSA+ubnOegFWFGpTB23lHGvZrNqaIU7FrzMAD7DNzlHP0AVuR1d+3L3kVbdd5hhlLRg921zLWdenRNmONs8tgCLhry0YKqFA1+YPFY6/InlgJIZKzFl9ZFZcCN/KmeN8ocD367OEtcjIajF5Pe8mYHNO1+utmj5gAzfjHUVFCUIGoid/Ps3SefQRItQy4ZS84IDYfhAeu9g
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58631782-5d47-43c7-77b1-08d6763cab1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:13:45.4275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5157
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
index 6aa8804..b62b607 100644
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
index aa35c43..d3fb3a8 100644
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

