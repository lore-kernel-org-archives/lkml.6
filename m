Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D0CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5B220685
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="nWox12er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfAHMbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:31:43 -0500
Received: from mail-eopbgr140090.outbound.protection.outlook.com ([40.107.14.90]:39433
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728655AbfAHMbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3ZE5h+DRG7Lp89aZpZv0LAB2aDRuRXDrL7SvAg/trQ=;
 b=nWox12erisyDPg3D2P3Fws6O1zLW5oXrUn6QZC62WkdB50RmGAR4qwAVPv+e/vc1ENeqLQcu1go1Tf2Qgm4st+GhdPY0ewn17emOAqklp/heDqezspD3gntvMANrbLf+ZFhqiudXitjhenWR+dRjY1gNw4iAYWJRy4H+DofP48Q=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB3958.eurprd02.prod.outlook.com (20.177.112.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 12:31:36 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 12:31:36 +0000
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
Subject: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Thread-Topic: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Thread-Index: AQHUp04YoDtjtNas+0efeF6OnACb7A==
Date:   Tue, 8 Jan 2019 12:31:36 +0000
Message-ID: <20190108123129.20031-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::16)
 To AM6PR02MB4470.eurprd02.prod.outlook.com (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB3958;6:LexwGOx3soQKLeaFMx5X8TQbgedxUDcJysJPdKYu60/BPpBT0umQxYKPR9dMhk03qcrnitCgRBLSC51LwQMB253+ehbYIuPrvn8dvV0nxvUlRAJjMRK7IzUOotxK6mNEA+tmEoEHRTEwPrkFcaFEVY3bpw/qSaiB+na6yZ6PRh7JpaNgpCAtZj33xNdQdN66xc+oYsarF+UVPWBLuEjl/whxFD/4WObUQcFqmFpByg7x2Bg0HTCUEz/Qa0nYIPAxcKXsS5+b6ubxpIwb9vSS/YzMvzp99yiE14dYf0pqPr693AssIw3GH2bp+/PJtm5z4JQIBU4kLC2uJwi7Pm/v6J4/mrsPqKsGTvygYjH5fNkwxPTf8dD7vamF1jjeCple+bqvWMfNZNQ9J86uYyi8XpiwIcCcvF/P0I5ZdGE/QfkCTYdaWOmcGJ3erbt7ztD75pRey7mbaggMwaj/K2LzUQ==;5:FgI4zt/Hv71q8yC3h6Dn0OaXUztTk+pL3SAf0cYcqkZFlsqKjq2wALZeNmYD2lL1s/A+3ruo432sPDPopBhbTeDMPpK3U09a23TYHbximIPrHejydug6Dzi9WaaZm3uqe34EJF0r9E27Ppe31YtLxDpcGbS56Xs0cLyF0Vp7poW96u3BrKZ5inauLWoXHi9lkN98z9BWZWwVnAbFBFTjeQ==;7:B22BuRAMya10F8Pfaf1nO4m7p1H3OyEqpSSQ4GVphtxKwEHwATS2OX5P33bBmuJrz5HHH4q/i2Y34kKQWZUV9NuZlE6RQyIF0mmNcCxqLyrXI3CsvR6RVnUclnr5r1/N8JiDWx/77+G6yTQwIK2V/g==
x-ms-office365-filtering-correlation-id: edf9deab-c000-4cbe-86f5-08d675653acf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB3958;
x-ms-traffictypediagnostic: AM6PR02MB3958:
x-microsoft-antispam-prvs: <AM6PR02MB39586B83A4727C140D0899BABC8A0@AM6PR02MB3958.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(2016111802025)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR02MB3958;BCL:0;PCL:0;RULEID:;SRVR:AM6PR02MB3958;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(376002)(346002)(366004)(136003)(199004)(189003)(5640700003)(2501003)(186003)(74482002)(2616005)(97736004)(99286004)(6436002)(476003)(2906002)(81156014)(81166006)(54906003)(8936002)(86362001)(71200400001)(71190400001)(102836004)(386003)(6506007)(52116002)(26005)(8676002)(50226002)(316002)(105586002)(3846002)(14444005)(256004)(6116002)(508600001)(7736002)(305945005)(486006)(2351001)(25786009)(106356001)(1076003)(4326008)(66066001)(6916009)(6486002)(36756003)(53936002)(68736007)(5660300001)(6512007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB3958;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oE4K3z2soc4XfwqSBmJO1ZDiIedpSHINnOFZOY1zZ47GjYgRYleDkakoHJdW3As4QoA+UCpagICdR/nyVW9bsKVFisTeqLdJDfqg7IHVBvYc7dOundzgJ6KPYGfkElgE80vCLaSBqTgRby9ZTFvGB2UOznsdCRwC2uM950VDKIrlvEBlNOwXH2fJp0imEAEbBV724ZU5UGpxUrUDpgLezw1KUL0eNCgqmoZ7f+t+E2kTiYCprSyrJ23rqWhxdBn6jsB3Ca0zulKzqzvXfPe/R61coEpVoxB9ke5gwgPYPqSFhGVeKh0xhcqm3+ftEtyS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: edf9deab-c000-4cbe-86f5-08d675653acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 12:31:35.3285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3958
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to temporarily hide a plane, one thing that was attempted
was to call (from libdrm)

	drmModeSetPlane(fd, plane_id, crtc_id, fb_id, 0,
			0, 0, 0, 0, 0, 0, 0, 0);

This call causes a pair of "Division by zero in kernel." messages. Kill
those messages, but preserve the current behaviour that also happen to
make the plane disappear with the above call.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Side note, when comparing with drm_atomic_helper_check_plane_state(), I get
the feeling that the src rect should be clipped together with the crtc rect
if/when clipping is needed. That function calls drm_rect_clip_scaled(), and
the equivalent does not seem to happen here. Should clipping be performed
on the src rect?

Cheers,
Peter

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/=
drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 3cc489b870fe..1bdb30dc218c 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -675,10 +675,16 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_=
plane *p,
 		state->crtc_y =3D 0;
 	}
=20
-	patched_src_w =3D DIV_ROUND_CLOSEST(patched_crtc_w * state->src_w,
-					  state->crtc_w);
-	patched_src_h =3D DIV_ROUND_CLOSEST(patched_crtc_h * state->src_h,
-					  state->crtc_h);
+	if (state->crtc_w)
+		patched_src_w =3D DIV_ROUND_CLOSEST(patched_crtc_w * state->src_w,
+						  state->crtc_w);
+	else
+		patched_src_w =3D 0;
+	if (state->crtc_h)
+		patched_src_h =3D DIV_ROUND_CLOSEST(patched_crtc_h * state->src_h,
+						  state->crtc_h);
+	else
+		patched_src_h =3D 0;
=20
 	hsub =3D drm_format_horz_chroma_subsampling(fb->format->format);
 	vsub =3D drm_format_vert_chroma_subsampling(fb->format->format);
--=20
2.11.0

