Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD06C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802E020657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gFcktjtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392590AbfAPLs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:48:57 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:57311
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392534AbfAPLsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIAgtPcw4qoKkYC5cej7gfsu8/PGd4RhIe75ka5riu0=;
 b=gFcktjtqWn7IsPiT+S4teFG+KNtVW134DMlRkneVTVbW1PvOFcBx2lzERmsmh6yJXdfyvlNf8cY3ISwaDAFZ9rh2MOLuH88NbIq/SXC9if9mExNXI+guN2k8pHD+4uDqiLo0Vrwp/DZtiPZAYgvsWSCS8cims5dp1oDseNiHEYg=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6101.eurprd04.prod.outlook.com (20.179.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:43 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:43 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
CC:     Robert Chiras <robert.chiras@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Anson Huang <anson.huang@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] drm/mxsfb: Fix the vblank events
Thread-Topic: [PATCH 05/11] drm/mxsfb: Fix the vblank events
Thread-Index: AQHUrZFufQ1GssoiqkOzBRY15FPrhw==
Date:   Wed, 16 Jan 2019 11:48:43 +0000
Message-ID: <1547639306-19151-6-git-send-email-robert.chiras@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6101;6:rx8Qe/jshJyRR5gEbQYyke15kZ33k+Tlk2x/6RqbnSgWCClBSJfa70TqWCE4/JTtSnafD2y4HAecpPB+nUA+pKHhz6Zora8BaPhBVrsGjNfIZ3xoOZTG7eSMb83Q9SsSF5JoqRta9kKauRpYwBeq74M8QzuCubMv99HWMAp1p0qXjjLba5iEJ2r+W/TNS8RtSL+SWoAvs9FPx7aSw2YPcGtYiafak7RDiSYy0p8sTLv7Odo90QzhgmI2xFmBkM3/GuCWYh5A9OwOw33lMLUPOi7TTySfE80eEBje+QdMY3OxVF+808Ta6++pWcnnwCYX8DyUVa2yPhcvjauoampWj25vzmJa0Cl+yWpszOWwVcwrYocbGrOrEaFQFHMqlTRqxEvlr3IvQvxCH0u31rdMqPr43LWdZsMtlWyAxLJlLqBBNGLhiZaLwBbISEe6cC6SF6dFOmSpdloLRCnn0CO+IA==;5:zST3xh2DBEL05AF2M2Nv46CMkVxZ7wtjih+5RZ6PYNBqdYlntvnEAERxK38il/cX0+l7U3uAdHk1dzdKwVRNkH5RtlFIvHEItbAfvcJUZmqoWysFt4RDH1qhNrx0u6nmGab9c8AkF/2+eIwf0slWChFh/qhnGjVGHoocgZSxnsiU6HNxt4k+Gi5ty/Bg8GdMJiFLsWJPKc+aIVmyOjcHPw==;7:rrpJPTFBzevlFJ9Selfpr4WTJZSPeG3jHAYR7C+wto4JU72h4uQE3zbwhKiv3F3Lz7TfQ12uAMpIaowPY6NsWqDvQNfWOcXKirNt8/g+rTBwAziDu8k9u01VlPgfRcZwabsr8kRSa0yRV4LgFPZCyQ==
x-ms-office365-filtering-correlation-id: cacc08c7-f34d-41e8-f488-08d67ba89071
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6101;
x-ms-traffictypediagnostic: AM6PR04MB6101:
x-microsoft-antispam-prvs: <AM6PR04MB610138AD398200BCC9D6C890E3820@AM6PR04MB6101.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(316002)(81156014)(110136005)(102836004)(81166006)(476003)(26005)(2616005)(186003)(8676002)(7736002)(66066001)(3846002)(50226002)(105586002)(305945005)(6486002)(8936002)(99286004)(54906003)(6436002)(106356001)(6116002)(86362001)(2906002)(44832011)(14454004)(478600001)(486006)(71200400001)(68736007)(97736004)(5660300001)(53936002)(76176011)(36756003)(5024004)(256004)(446003)(14444005)(11346002)(25786009)(386003)(6506007)(6512007)(52116002)(4326008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6101;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v+vvfHNgngbCALxAp8yDek+sU8xGiWCLD0it7vD4vA+WagsaUbn3RD21P7GORFaurHOZDrSVT+CE/T4zqlASWbPF0BCOe/nz5rRoCl5DCyenxLmczYOWOk2Da00kB5x8c0MP0Z4/jqYmoP0yPjMETJC00lpY+4SGsnuglv8dlgdoeCqVJ6rhmPVHeNtOAwtyoc2em0i/lixhNVd8wpdpqKAFf9E6gNgAObgqa3iuFzHEzEscLuQLhunMa5J6HwMpAvJesl6GjIW1ypD/HwzhU29SQoobyrEbSx1aHBp+HdstHkIQElbbKVhKAl9uYDQLF6CxE7yhTBukKbLM10tNemSb0JhAoVBv+nC6ZY4xIjBjCKSb84SubODlhK0vjkAg1gZW/7VORe7CvBPozPRIgXLz79F4u5XcyfxepeiNGK4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacc08c7-f34d-41e8-f488-08d67ba89071
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:42.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the vblank support is not correctly implemented in MXSFB_DRM
driver. The call to drm_vblank_init is made with mode_config.num_crtc
which at that time is 0. Because of this, vblank is not activated, so
there won't be any vblank event submitted.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.c
index bc1b750..d292192 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -43,6 +43,9 @@
 #include "mxsfb_drv.h"
 #include "mxsfb_regs.h"
=20
+/* The eLCDIF max possible CRTCs */
+#define MAX_CRTCS 1
+
 enum mxsfb_devtype {
 	MXSFB_V3,
 	MXSFB_V4,
@@ -138,6 +141,8 @@ static void mxsfb_pipe_enable(struct drm_simple_display=
_pipe *pipe,
 		mxsfb->connector =3D &mxsfb->panel_connector;
 	}
=20
+	drm_crtc_vblank_on(&mxsfb->pipe.crtc);
+
 	pm_runtime_get_sync(drm->dev);
 	drm_panel_prepare(mxsfb->panel);
 	mxsfb_crtc_enable(mxsfb);
@@ -247,7 +252,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
=20
 	pm_runtime_enable(drm->dev);
=20
-	ret =3D drm_vblank_init(drm, drm->mode_config.num_crtc);
+	ret =3D drm_vblank_init(drm, MAX_CRTCS);
 	if (ret < 0) {
 		dev_err(drm->dev, "Failed to initialise vblank\n");
 		goto err_vblank;
@@ -270,6 +275,8 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
 		goto err_vblank;
 	}
=20
+	drm_crtc_vblank_off(&mxsfb->pipe.crtc);
+
 	/*
 	 * Attach panel only if there is one.
 	 * If there is no panel attach, it must be a bridge. In this case, we
--=20
2.7.4

