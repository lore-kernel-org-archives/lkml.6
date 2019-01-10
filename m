Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953ABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA12214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="tg7/f3AZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfAJPKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:10:51 -0500
Received: from mail-eopbgr70132.outbound.protection.outlook.com ([40.107.7.132]:54144
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729499AbfAJPKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5uGpSVwspiZlFxAcd0DqWqrymEEcvx7254O23WdfpE=;
 b=tg7/f3AZlL9V9kqMWECfCPl2EL2pWkeLj5mv2AH4dq83/KRvdHLvSrTypVUCLdmAG7tbGaKINQqAYz1eBQYRldYDi6e0Vwbff5MHgK4ghUhZWk9ZUNy0sfmESFPA2TTCUvOjTjNHd3KR52crJIYI4QdNdocXvPulVaGylmeGSs8=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4037.eurprd02.prod.outlook.com (20.177.112.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 15:10:44 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 15:10:44 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/4] drm/atmel-hlcdc: fix clipping of planes
Thread-Topic: [PATCH 3/4] drm/atmel-hlcdc: fix clipping of planes
Thread-Index: AQHUqPaocSFXgGMYMU6PnOiTgpGAbg==
Date:   Thu, 10 Jan 2019 15:10:44 +0000
Message-ID: <20190110151020.30468-4-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
In-Reply-To: <20190110151020.30468-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0257.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::33) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB4037;6:oirXdou7kvlpoi6F9sLXz3oFqK5xxNU+t3CANdlyoyTy56hKq2iCrF3tbBkAUZselSegOJhB1/reL4V4w5t7McLXDng4HykjCF6EX3mE9WS3j0UhiRNuV3hAj117n4MuHTNt5miW6OMyIFqbBFmz1VJ2rVv8XW/uldjzi+IDfeeGq41zeAKRBOqJdFZc02EwSTzfWy1A3AMkriccKMPtXwXdw6W5LM2UMxx8/9OBT6F4J3cxGHRSzPerLZqfuglA2ZQLv9QqRvORmNdv3BQb1X2MVEitJcvhwHvIF6JJRdtamlRDK+bk3/C49Om2VpPSbg8yuvVPEPEFLmxk8s4zMNEfQQPgtH7UqeTHquYVrhxWoMeUOTQcsJJBMpPeNsGWNQKMJgL2F1L4x2PvbyTzjuoAX9siBhh4Q/uCwX4oHDrhOKkqwphcOq87DHs6s7Sy54+jil8aM8auLlG0z5RyLA==;5:MFJFEupqkPmYr9iGQKhOmnzRO0kKVDYSg6MOA07KM3OZRTdCLQgcCIw777FbsUE9HeSKhUXwhcd9yh5xJche5Kr1GDhviB2TfM1BhGAqxJJOKwDlA32vUIpJHMr4id9yNigN+Ojf3DM1RZFNBGhOPmsMsg4Ma2NW3aBPnQu7Cu9fN5BlKFIxqtK60vh7Et9z9lL2xkMny+29monGXX+Bwg==;7:2udaZEXPxmrQTRIuOxi6elOxPlwNhsWQ+4MF2vFXqrAEWz2bRXFS+ZcsMM4BDocfEwxxd/RVhOq/JMt5C4cbPGe4KKLUHBS5BS//V/eCbtSKuMOUjm6LQ4RvK2vTUE79BQM6B4cmLBc8SMppQIZnWg==
x-ms-office365-filtering-correlation-id: f524e922-b1c8-47e5-13e3-08d6770dcab1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB4037;
x-ms-traffictypediagnostic: AM6PR02MB4037:
x-microsoft-antispam-prvs: <AM6PR02MB40375CF7D8D0C017DE94E747BC840@AM6PR02MB4037.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR02MB4037;BCL:0;PCL:0;RULEID:;SRVR:AM6PR02MB4037;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(53936002)(316002)(36756003)(6512007)(97736004)(50226002)(5660300001)(66066001)(186003)(14444005)(386003)(4326008)(6506007)(446003)(25786009)(26005)(256004)(11346002)(2501003)(476003)(102836004)(2616005)(6916009)(14454004)(71190400001)(71200400001)(106356001)(105586002)(2906002)(68736007)(7736002)(486006)(5640700003)(1076003)(6436002)(6486002)(508600001)(2351001)(81156014)(99286004)(81166006)(3846002)(8936002)(305945005)(6116002)(8676002)(86362001)(54906003)(74482002)(76176011)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4037;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R299qUmThCMJjh3OtLJRggcN5xQM1VKyD5UqJvrvNT1z4MMfTDyRd8u75Q1eD0C0kFfVK+XDySm7xgrB6lZqIiX56g94c0KvMUvwSKRxXYwDMlbh2beViDIcGhyhWlfn3VIscMbS05LxePZ1FGSMBcHgJbLm6AuJSffjoCh5tLcZSxHFj4upFzNNtWKqSP0GaKV5jhYH7WNZE9H9n24Ja2RJISCNZHHzycQ+JsEX18JzwR8ZvIMsjAecYE639Zw4h04iB7IbwxoeKFb1pdloN9/e/jhalvTEd2RfAWQr8LB1tF1JAwPd5les/EsLgagj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f524e922-b1c8-47e5-13e3-08d6770dcab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 15:10:43.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the help from drm_atomic_helper_check_plane_state function, clipping
now handles planes to be partially or totally off-screen. The plane is
disabled if it is not visible.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 162 +++++++++-----------=
----
 1 file changed, 61 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/=
drm/atmel-hlcdc/atmel_hlcdc_plane.c
index d6f93f029020..05519e8c6586 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -548,7 +548,8 @@ atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_sta=
te *c_state)
=20
 		ovl_state =3D drm_plane_state_to_atmel_hlcdc_plane_state(ovl_s);
=20
-		if (!ovl_s->fb ||
+		if (!ovl_s->visible ||
+		    !ovl_s->fb ||
 		    ovl_s->fb->format->has_alpha ||
 		    ovl_s->alpha !=3D DRM_BLEND_ALPHA_OPAQUE)
 			continue;
@@ -600,15 +601,10 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_=
plane *p,
 	struct drm_framebuffer *fb =3D state->base.fb;
 	const struct drm_display_mode *mode;
 	struct drm_crtc_state *crtc_state;
-	unsigned int patched_crtc_w;
-	unsigned int patched_crtc_h;
-	unsigned int patched_src_w;
-	unsigned int patched_src_h;
 	unsigned int tmp;
-	int x_offset =3D 0;
-	int y_offset =3D 0;
 	int hsub =3D 1;
 	int vsub =3D 1;
+	int ret;
 	int i;
=20
 	if (!state->base.crtc || !fb)
@@ -617,14 +613,21 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_=
plane *p,
 	crtc_state =3D drm_atomic_get_existing_crtc_state(s->state, s->crtc);
 	mode =3D &crtc_state->adjusted_mode;
=20
-	state->src_x =3D s->src_x;
-	state->src_y =3D s->src_y;
-	state->src_h =3D s->src_h;
-	state->src_w =3D s->src_w;
-	state->crtc_x =3D s->crtc_x;
-	state->crtc_y =3D s->crtc_y;
-	state->crtc_h =3D s->crtc_h;
-	state->crtc_w =3D s->crtc_w;
+	ret =3D drm_atomic_helper_check_plane_state(s, crtc_state,
+						  (1 << 16) / 2048,
+						  INT_MAX, true, true);
+	if (ret || !s->visible)
+		return ret;
+
+	state->src_x =3D s->src.x1;
+	state->src_y =3D s->src.y1;
+	state->src_w =3D drm_rect_width(&s->src);
+	state->src_h =3D drm_rect_height(&s->src);
+	state->crtc_x =3D s->dst.x1;
+	state->crtc_y =3D s->dst.y1;
+	state->crtc_w =3D drm_rect_width(&s->dst);
+	state->crtc_h =3D drm_rect_height(&s->dst);
+
 	if ((state->src_x | state->src_y | state->src_w | state->src_h) &
 	    SUBPIXEL_MASK)
 		return -EINVAL;
@@ -638,42 +641,6 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_p=
lane *p,
 	if (state->nplanes > ATMEL_HLCDC_LAYER_MAX_PLANES)
 		return -EINVAL;
=20
-	/*
-	 * Swap width and size in case of 90 or 270 degrees rotation
-	 */
-	if (drm_rotation_90_or_270(state->base.rotation)) {
-		tmp =3D state->src_w;
-		state->src_w =3D state->src_h;
-		state->src_h =3D tmp;
-	}
-
-	if (state->crtc_x + state->crtc_w > mode->hdisplay)
-		patched_crtc_w =3D mode->hdisplay - state->crtc_x;
-	else
-		patched_crtc_w =3D state->crtc_w;
-
-	if (state->crtc_x < 0) {
-		patched_crtc_w +=3D state->crtc_x;
-		x_offset =3D -state->crtc_x;
-		state->crtc_x =3D 0;
-	}
-
-	if (state->crtc_y + state->crtc_h > mode->vdisplay)
-		patched_crtc_h =3D mode->vdisplay - state->crtc_y;
-	else
-		patched_crtc_h =3D state->crtc_h;
-
-	if (state->crtc_y < 0) {
-		patched_crtc_h +=3D state->crtc_y;
-		y_offset =3D -state->crtc_y;
-		state->crtc_y =3D 0;
-	}
-
-	patched_src_w =3D DIV_ROUND_CLOSEST(patched_crtc_w * state->src_w,
-					  state->crtc_w);
-	patched_src_h =3D DIV_ROUND_CLOSEST(patched_crtc_h * state->src_h,
-					  state->crtc_h);
-
 	hsub =3D drm_format_horz_chroma_subsampling(fb->format->format);
 	vsub =3D drm_format_vert_chroma_subsampling(fb->format->format);
=20
@@ -688,41 +655,38 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_=
plane *p,
=20
 		switch (state->base.rotation & DRM_MODE_ROTATE_MASK) {
 		case DRM_MODE_ROTATE_90:
-			offset =3D ((y_offset + state->src_y) / ydiv) *
+			offset =3D (state->src_y / ydiv) *
 				 fb->pitches[i];
-			offset +=3D ((x_offset + state->src_x + patched_src_h - 1) /
+			offset +=3D ((state->src_x + state->src_w - 1) /
 				   xdiv) * state->bpp[i];
-			state->xstride[i] =3D -(((patched_src_w - 1) / ydiv) *
+			state->xstride[i] =3D -(((state->src_h - 1) / ydiv) *
 					    fb->pitches[i]) -
 					  (2 * state->bpp[i]);
 			state->pstride[i] =3D fb->pitches[i] - state->bpp[i];
 			break;
 		case DRM_MODE_ROTATE_180:
-			offset =3D ((y_offset + state->src_y + patched_src_h - 1) /
+			offset =3D ((state->src_y + state->src_h - 1) /
 				  ydiv) * fb->pitches[i];
-			offset +=3D ((x_offset + state->src_x + patched_src_w - 1) /
+			offset +=3D ((state->src_x + state->src_w - 1) /
 				   xdiv) * state->bpp[i];
-			state->xstride[i] =3D ((((patched_src_w - 1) / xdiv) - 1) *
+			state->xstride[i] =3D ((((state->src_w - 1) / xdiv) - 1) *
 					   state->bpp[i]) - fb->pitches[i];
 			state->pstride[i] =3D -2 * state->bpp[i];
 			break;
 		case DRM_MODE_ROTATE_270:
-			offset =3D ((y_offset + state->src_y + patched_src_w - 1) /
+			offset =3D ((state->src_y + state->src_h - 1) /
 				  ydiv) * fb->pitches[i];
-			offset +=3D ((x_offset + state->src_x) / xdiv) *
-				  state->bpp[i];
-			state->xstride[i] =3D ((patched_src_w - 1) / ydiv) *
+			offset +=3D (state->src_x / xdiv) * state->bpp[i];
+			state->xstride[i] =3D ((state->src_h - 1) / ydiv) *
 					  fb->pitches[i];
 			state->pstride[i] =3D -fb->pitches[i] - state->bpp[i];
 			break;
 		case DRM_MODE_ROTATE_0:
 		default:
-			offset =3D ((y_offset + state->src_y) / ydiv) *
-				 fb->pitches[i];
-			offset +=3D ((x_offset + state->src_x) / xdiv) *
-				  state->bpp[i];
+			offset =3D (state->src_y / ydiv) * fb->pitches[i];
+			offset +=3D (state->src_x / xdiv) * state->bpp[i];
 			state->xstride[i] =3D fb->pitches[i] -
-					  ((patched_src_w / xdiv) *
+					  ((state->src_w / xdiv) *
 					   state->bpp[i]);
 			state->pstride[i] =3D 0;
 			break;
@@ -731,35 +695,45 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_=
plane *p,
 		state->offsets[i] =3D offset + fb->offsets[i];
 	}
=20
-	state->src_w =3D patched_src_w;
-	state->src_h =3D patched_src_h;
-	state->crtc_w =3D patched_crtc_w;
-	state->crtc_h =3D patched_crtc_h;
+	/*
+	 * Swap width and size in case of 90 or 270 degrees rotation
+	 */
+	if (drm_rotation_90_or_270(state->base.rotation)) {
+		tmp =3D state->src_w;
+		state->src_w =3D state->src_h;
+		state->src_h =3D tmp;
+	}
=20
 	if (!desc->layout.size &&
 	    (mode->hdisplay !=3D state->crtc_w ||
 	     mode->vdisplay !=3D state->crtc_h))
 		return -EINVAL;
=20
-	if (desc->max_height && state->crtc_h > desc->max_height)
-		return -EINVAL;
-
-	if (desc->max_width && state->crtc_w > desc->max_width)
-		return -EINVAL;
-
 	if ((state->crtc_h !=3D state->src_h || state->crtc_w !=3D state->src_w) =
&&
 	    (!desc->layout.memsize ||
 	     state->base.fb->format->has_alpha))
 		return -EINVAL;
=20
-	if (state->crtc_x < 0 || state->crtc_y < 0)
-		return -EINVAL;
+	return 0;
+}
=20
-	if (state->crtc_w + state->crtc_x > mode->hdisplay ||
-	    state->crtc_h + state->crtc_y > mode->vdisplay)
-		return -EINVAL;
+static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
+					     struct drm_plane_state *old_state)
+{
+	struct atmel_hlcdc_plane *plane =3D drm_plane_to_atmel_hlcdc_plane(p);
=20
-	return 0;
+	/* Disable interrupts */
+	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IDR,
+				    0xffffffff);
+
+	/* Disable the layer */
+	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHDR,
+				    ATMEL_HLCDC_LAYER_RST |
+				    ATMEL_HLCDC_LAYER_A2Q |
+				    ATMEL_HLCDC_LAYER_UPDATE);
+
+	/* Clear all pending interrupts */
+	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
 }
=20
 static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
@@ -773,6 +747,11 @@ static void atmel_hlcdc_plane_atomic_update(struct drm=
_plane *p,
 	if (!p->state->crtc || !p->state->fb)
 		return;
=20
+	if (!state->base.visible) {
+		atmel_hlcdc_plane_atomic_disable(p, old_s);
+		return;
+	}
+
 	atmel_hlcdc_plane_update_pos_and_size(plane, state);
 	atmel_hlcdc_plane_update_general_settings(plane, state);
 	atmel_hlcdc_plane_update_format(plane, state);
@@ -794,25 +773,6 @@ static void atmel_hlcdc_plane_atomic_update(struct drm=
_plane *p,
 			 ATMEL_HLCDC_LAYER_A2Q : ATMEL_HLCDC_LAYER_EN));
 }
=20
-static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
-					     struct drm_plane_state *old_state)
-{
-	struct atmel_hlcdc_plane *plane =3D drm_plane_to_atmel_hlcdc_plane(p);
-
-	/* Disable interrupts */
-	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IDR,
-				    0xffffffff);
-
-	/* Disable the layer */
-	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHDR,
-				    ATMEL_HLCDC_LAYER_RST |
-				    ATMEL_HLCDC_LAYER_A2Q |
-				    ATMEL_HLCDC_LAYER_UPDATE);
-
-	/* Clear all pending interrupts */
-	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
-}
-
 static void atmel_hlcdc_plane_destroy(struct drm_plane *p)
 {
 	struct atmel_hlcdc_plane *plane =3D drm_plane_to_atmel_hlcdc_plane(p);
--=20
2.11.0

