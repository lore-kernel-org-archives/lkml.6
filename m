Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5576AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8AF2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DozVEofH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbfAIOOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:14:01 -0500
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:4544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731381AbfAION4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fsp6QAscGzJSOibuvf04tzvxHdU60vhCvsbkOHPAx8c=;
 b=DozVEofHj/xAOYExiZ7ujM+5pHIe5C7x3gQCot8OvjJxrFsQl63PKMQnHgnrVV1MQf231aQUjE2OyEFXdwqCb3hFWNF3YLJY77q/H4tYvSXOA/euaAatpE4yBcYwUWENdnHUXpgi+fQIOQlYT2d5b630OGt0u1fgMkGTeU8qams=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB5157.eurprd04.prod.outlook.com (20.177.34.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 14:13:47 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:13:47 +0000
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
Subject: [PATCH 07/10] drm/mxsfb: Signal mode changed when bpp changed
Thread-Topic: [PATCH 07/10] drm/mxsfb: Signal mode changed when bpp changed
Thread-Index: AQHUqCWJ4uj56Q/gNkWvh9BrpjbmJw==
Date:   Wed, 9 Jan 2019 14:13:47 +0000
Message-ID: <1547043209-8283-8-git-send-email-robert.chiras@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5157;6:nNBa1FSkVOOnEKmTW9aRUuiEJ9EJigx+TzKupU5zbFzK0RSMkns0A9pWcI28y+obvwTiMmJEYkeORwIxYxFbXaf4xmWb24AoxQdZZI2QNmoKu2UcKl05rn5qWjOqdzsDQsdecadmQxCVdbwBNJmdQ3UzxDpwtOJePWRSVbR11EnduHw7wd4D8ngmRD6KW8UOilbqeSfQngL5juE+O/+L51SdXDuRX1WX+o3yhkiDozNDQ7VG9fAWg3yszFawOST8ntcTGhdT/Jypj81EKIrlFM5Rd1sBIi8o0sv1dUvcCc4wcqJNGCIA9kPUqTNJlY//hSHm/KsBmoMCQWvbp5ARhWDlbOw/ZleOEw74NhGF70VcWua8tq8bnEPF7H44HVJ7goGWz+4cxXizwJszUnZS4tmlkCdKaSuprq/7ahJTzLT5NXLnJttggLlZ9Q6d9LgQVooCitXepqfA36ZprQhCDA==;5:1DrgdnxqAQWQfIVuTrJNu2gTT+leO/h9/aD/6nNOiTOo0+l5dNtDIQwyX7WhH2zb2L0cGz/LHsCeoMhbnvG++OyBZBMsIEyCHzC2tMlTy7UzjDMVB+P64LyWKlhcEkF0SO33HDLkSFE/vrIZuCJgCZbwF7ioc3SnfGyiuJWrbZX9cVpZc5H3E5dOnLDrvl9KzOSGPNCrxGawKyZsVTz8qQ==;7:TokVQg+wSodN0mbsNtewnRT8YR5mbWzUAnUslPc3jaq+QswHmKCSgI5QaztYL4d8IKLwg4DjQPuieTDXdGPtQv1iJBLIyljEvsTl1cMxnoMdyg41pna4XSvXnUIfbNeXcga1kum2131M8RcezvW+Wg==
x-ms-office365-filtering-correlation-id: d3383ad8-5c02-46f3-7370-08d6763caba5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5157;
x-ms-traffictypediagnostic: AM6PR04MB5157:
x-microsoft-antispam-prvs: <AM6PR04MB5157046A7CA3BEB2D21E3A1DE38B0@AM6PR04MB5157.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5157;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5157;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(50226002)(99286004)(11346002)(110136005)(2616005)(256004)(316002)(86362001)(14444005)(54906003)(305945005)(7736002)(8676002)(71190400001)(6486002)(71200400001)(446003)(8936002)(105586002)(97736004)(81166006)(81156014)(36756003)(106356001)(476003)(25786009)(486006)(6436002)(186003)(3846002)(6116002)(478600001)(68736007)(53936002)(102836004)(6512007)(14454004)(5660300001)(44832011)(76176011)(52116002)(386003)(26005)(6506007)(2906002)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5157;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xJPgTeNaylcO0vPi+XN2M9lthjoAL04wjnxA8Jos2KIbkW3Npo0iBuRcchSqiUd5nte9d258n7bFQmyfCr0crLZ4SGrDH+9/2q94rJEa/hS/F8FB1mtMX3ffpHh9Hbh8twmUcnn4/EN8EVtVLLvZwyoxr5jyPMhRvjchohC+q2Z0xGLL2QAqNOBlc+yUFa58Rw1JnwLIMbJKaz6Cl57dPmrYAk4Y2AlZdzd+rsXpXoonOKNeDL+RrUdLy5cYjaQqgbx52QkjAitwYj5HQwFzVBluCuyPpNWxa57baDHYI3nMszfORiyIJtYhmALFis4p
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3383ad8-5c02-46f3-7370-08d6763caba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:13:46.3271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mirela Rabulea <mirela.rabulea@nxp.com>

Add mxsfb_atomic_helper_check to signal mode changed when bpp changed.
This will trigger the execution of disable/enable on
a modeset with different bpp than the current one.

Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 48 +++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.c
index d3fb3a8..f528a37 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -115,9 +115,55 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *m=
xsfb)
 		clk_disable_unprepare(mxsfb->clk_axi);
 }
=20
+/**
+ * mxsfb_atomic_helper_check - validate state object
+ * @dev: DRM device
+ * @state: the driver state object
+ *
+ * On top of the drm imlementation drm_atomic_helper_check,
+ * check if the bpp is changed, if so, signal mode_changed,
+ * this will trigger disable/enable
+ *
+ * RETURNS:
+ * Zero for success or -errno
+ */
+static int mxsfb_atomic_helper_check(struct drm_device *dev,
+			    struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	int i, ret;
+
+	ret =3D drm_atomic_helper_check(dev, state);
+	if (ret)
+		return ret;
+
+	for_each_crtc_in_state(state, crtc, crtc_state, i) {
+		struct drm_plane_state *primary_state;
+		int old_bpp =3D 0;
+		int new_bpp =3D 0;
+
+		if (!crtc->primary || !crtc->primary->old_fb)
+			continue;
+		primary_state =3D
+			drm_atomic_get_plane_state(state, crtc->primary);
+		if (!primary_state || !primary_state->fb)
+			continue;
+		old_bpp =3D crtc->primary->old_fb->format->depth;
+		new_bpp =3D primary_state->fb->format->depth;
+		if (old_bpp !=3D new_bpp) {
+			crtc_state->mode_changed =3D true;
+			DRM_DEBUG_ATOMIC(
+				"[CRTC:%d:%s] mode changed, bpp %d->%d\n",
+				crtc->base.id, crtc->name, old_bpp, new_bpp);
+		}
+	}
+	return ret;
+}
+
 static const struct drm_mode_config_funcs mxsfb_mode_config_funcs =3D {
 	.fb_create		=3D drm_gem_fb_create,
-	.atomic_check		=3D drm_atomic_helper_check,
+	.atomic_check		=3D mxsfb_atomic_helper_check,
 	.atomic_commit		=3D drm_atomic_helper_commit,
 };
=20
--=20
2.7.4

