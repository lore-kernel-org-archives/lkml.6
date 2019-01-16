Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C59C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE9620859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vK102SQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392649AbfAPLtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:49:22 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:57311
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392566AbfAPLs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4JswUuYhlP+X8vMpMocXLb6N4SbUp3/AwRXIGXD40c=;
 b=vK102SQSmU1bo4+707+ndLmf7hrwJUKz2wFZZpmNbbJVQ0/npreveYal8f4U/37gZusZF+0oW5HDqNjjwPo3LYf043juGcGjS6sh9alworeqiV0u1V3CZlo9h50SXseboPZY/lHaJFtOlThEAOaW23SCRznkFJxSX/taBfgSBdE=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6101.eurprd04.prod.outlook.com (20.179.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:45 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:45 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
CC:     Mirela Rabulea <mirela.rabulea@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Anson Huang <anson.huang@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/11] drm/mxsfb: Signal mode changed when bpp changed
Thread-Topic: [PATCH 07/11] drm/mxsfb: Signal mode changed when bpp changed
Thread-Index: AQHUrZFv/VodV8Ndf0i7+PLoen2nTg==
Date:   Wed, 16 Jan 2019 11:48:45 +0000
Message-ID: <1547639306-19151-8-git-send-email-robert.chiras@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6101;6:GmmeVjFRBtr8jewU63S4f2EzPB+AcT1fzRf7IN6DO4WsvkXWTymDwGiQ0xpUpjZpIprLYJlgMHV5xlwUjaWBlvoP+Rgm39i113DhWEmznnN6QiTTES/jp2SpjGyoCTTOHQ5vVW3S3RITRhsfwlsxMrmtSlsUzzoJYxuawB4bT4TFqc68ggqWw3yp3upnYKIfhiLYdWFxxvPrdAUfnzd06UF1xrmKx7d32Bxe08J7nQZ+nqOTYzHh9sjLhGBazBaQa0HylVhOETEohbM5yMOZVUF037fpGq/hq1ALJno2BhW6mjcPo6hgFK2CWCx95truT2Kqdk0W/hjhwTv8yS+D+oIs4eiaDPNfAPD5JFO2WA+t9YThj+x5iVqM6Ql+zTl6A8ftDMzcxfbbKNNtSG8WISwx+qNcDQwMnQUIDe/kRgLWJmGQ3xV8k17Ux7yNL3yAAJj2Tc1Nw1gAGAlIdegRVw==;5:+G123ZRYLfBzK3uDdF3PZHOwn+mX01O3Mrnv/R5MsouwsKvfcoUCks63q8gLSrSeqoSpOyo/fFa6bpngOqNMnYAwo3fl//pOEtmDv+Ehv7/Tjya+knC8dFsf+KEFTo53Enu2AtaFn0AsbSNg+3d9OwPWhcCGUfEEf3O0nKWy+VkfswsL9ugsBLCjdFMBojy6NMsvNg/2a+2BLcSyE+98aA==;7:bD8R6ntha3nzEkabMMk4SXvaZ53DeIptDg0bFwfO8uvIBXew3VHTNq5eaCG/W8pqL5hJ5a0EbRVVuM1u/zOunDXBezH82qhDpiWGPY0oQvpnGCFJwVmtuC0rlTtCe0yn94kQHJ3VMflOzoujkOv9Xg==
x-ms-office365-filtering-correlation-id: 46263016-4da7-46b1-ad7e-08d67ba891aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6101;
x-ms-traffictypediagnostic: AM6PR04MB6101:
x-microsoft-antispam-prvs: <AM6PR04MB610168EFF83280ECB75EB0BEE3820@AM6PR04MB6101.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(316002)(81156014)(110136005)(102836004)(81166006)(476003)(26005)(2616005)(186003)(8676002)(7736002)(66066001)(3846002)(50226002)(105586002)(305945005)(6486002)(8936002)(99286004)(54906003)(6436002)(106356001)(6116002)(86362001)(2906002)(44832011)(14454004)(478600001)(486006)(71200400001)(68736007)(97736004)(5660300001)(53936002)(76176011)(36756003)(256004)(446003)(14444005)(11346002)(25786009)(386003)(6506007)(6512007)(52116002)(4326008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6101;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UZtLdVc0Eqqs6fjWKguL2YE5SSKqEkRmLgbEn07UBTvSVux8sqRu9DgJh8l/GvTVLvnQCyh/gp4WMwNxzM5OP8QJHmrQdP45UJqfKr4fQGMcLaNnugQAi7ZA8XhIW+lWiaARFJH1irTBj5PFiR+bOjmuhzfyxpPPjSFsP7+44clgzTGMgse6UoEGEGB5TK45t667pNcpMMI7F6B7AQHSx7wwt8BYEANH3igAIjIr2Hj37AmJXP16adOwJl1FDFY//WtEp9QcgPa27QbuvpJshPO1/FNPE0N6bUdjuMnBxE4vHtshWziMTxJJZrdrgcuuFO2iEHp5X8Q718mZuEJRQmR7DqxGjX6Sh+MvxJ0up81IEUP3GQl544/z5za4jmS8BNbECbGV9vXJjbQXayhlQPMLZvZ+1rdSxmUAzHVy944=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46263016-4da7-46b1-ad7e-08d67ba891aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:44.1343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mirela Rabulea <mirela.rabulea@nxp.com>

Add mxsfb_atomic_helper_check to signal mode changed when bpp changed.
This will trigger the execution of disable/enable on
a modeset with different bpp than the current one.

Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 48 +++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.c
index eb01484..3032007 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -113,9 +113,55 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *m=
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
+	struct drm_crtc_state *new_state;
+	int i, ret;
+
+	ret =3D drm_atomic_helper_check(dev, state);
+	if (ret)
+		return ret;
+
+	for_each_new_crtc_in_state(state, crtc, new_state, i) {
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
+			new_state->mode_changed =3D true;
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

