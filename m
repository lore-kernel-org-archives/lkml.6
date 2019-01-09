Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68450C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC5820883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VDC918Ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfAION5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:13:57 -0500
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:4544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731399AbfAIONz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUUqdm3g6xJECMwQ8omDiPRJDoUCFcbhcSFb2Fyu3y8=;
 b=VDC918Ow3xSqZfzQiAuXZj++RgYpq/PUWSP95nVCCgjhCOFbaB74UbQ6USGbF0kSUSj/B/0Oh1AvuVR9M2swEHx6d4TQAfkiOdC2OdQQdr81yppgM21kbWlhqYAm9FMfPK6IejLhj/k+Qus7mWNX2z05n2qQzUukd8V+uUTgS0w=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB5157.eurprd04.prod.outlook.com (20.177.34.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 14:13:45 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:13:45 +0000
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
Subject: [PATCH 05/10] drm/mxsfb: Fix the vblank events
Thread-Topic: [PATCH 05/10] drm/mxsfb: Fix the vblank events
Thread-Index: AQHUqCWIRJis7kUU80mskY1k6nTQLg==
Date:   Wed, 9 Jan 2019 14:13:45 +0000
Message-ID: <1547043209-8283-6-git-send-email-robert.chiras@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5157;6:3pCjNqJ6A5QkNV9kj6PafDneCSDiJP9DidH4DFmNE2lP3ildCXxcCIe+t1Q3AZ/Y0Upn8FJBxMNex84Mj4fBkldvV4D3ASWa0RBLuTeEK7dyvI7znSMlw4iM7p6bsSWm6z2AZtUaoArC7JETN7X26KjJO+mqYLpRcM5mZCknprR1iEsmeA90d/O2oGO8orIRVUSuo4GgWOwc+nzIxpJtm8fEAyPMnL11bpiU8m+Z3PlaDCv8TACwuCOaq8jE8000KWd6rEu0M0cdSKACzINvbGx6fUNQWq2SCWeM3UvEWY8z9WZekKCn9Yx4TSyLQNfKeT3EzJzEnwHDqh1gqgyAguZMVbgywwgV16PeFsazDmeEbCjhaA9itB3Vt4f6Te89QbWIRfSDE/5AlIA20lqUqLQ4d24TGUSTsoAK7vbkwlyr9IkPcxOhOzuMDbPWFrxVtpNBFqIhqYqsHbevEBlP6Q==;5:7Neo4lSiFswBfojCtCxXWDL9RRz/U6D6Jr7kF/2Z9IARgWyty5xYIfgxEhqzDgkpkVBogJqlvie+UCuvX9rbKemPAoKary7pg0RNJ/ycqbQHswhnOq19pCLLoa6GBa3BCKPdzi1i9HQGMjLh5OCeruQlXiSMmDEKiq9R9mDvwMkgxXgB/qrceFsAIeEcNN+e+HQBahUqXfLxERzxHqnqyg==;7:EDlg+fRMG7a79vI8z7D8vsuAUXqgWG3cwu/UFQ8VYFuehUti3ooRBXHnq7fq0NCgfvwWNs9MebS/XJTyTOiMlZlkhTbw6bcAtWZOcFIFcWqwimBQi+HATNC3g9aQhx+1TadJTZV7wA2ZbE/OjEx5Yw==
x-ms-office365-filtering-correlation-id: 59566f84-b35d-40f0-49c5-08d6763caa4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5157;
x-ms-traffictypediagnostic: AM6PR04MB5157:
x-microsoft-antispam-prvs: <AM6PR04MB5157D5663634D9F05558DEC4E38B0@AM6PR04MB5157.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5157;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5157;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(50226002)(99286004)(11346002)(110136005)(2616005)(256004)(316002)(86362001)(5024004)(14444005)(54906003)(305945005)(7736002)(8676002)(71190400001)(6486002)(71200400001)(446003)(8936002)(105586002)(97736004)(81166006)(81156014)(36756003)(106356001)(476003)(25786009)(486006)(6436002)(186003)(3846002)(6116002)(478600001)(68736007)(53936002)(102836004)(6512007)(14454004)(5660300001)(44832011)(76176011)(52116002)(386003)(26005)(6506007)(2906002)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5157;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 67hjGJXcpGyoz/OWL3HK4okaTmdMESpDNrasf4N04oDdrHZgvfqY6sbJ+YG3YNnEuywvDVW2MkppRE9UX0d+nQsiPILwj1MpsdYSIFOu+bpROeOaIi5CAZ3zqYAfeM8xITHqcEBxsby86P7Xh3zyEO2Rg1Pg10mqdPZmwsZAfpEeZPnSXuSBNDnfp45/ZkDEFFY8X1ihmF51hmTlIjNgPP7hI/z22DFvxDVSwzk/OcTB3+0/FFV+IHthqohdjY6gM/5CJZPIsK3OzJO/76eXCfuA9Akn4iznaWcEc4nduWvJMoq0UG9v7XvwJTZpPYX9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59566f84-b35d-40f0-49c5-08d6763caa4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:13:43.7373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5157
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
index 76230d7..aa35c43 100644
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
@@ -140,6 +143,8 @@ static void mxsfb_pipe_enable(struct drm_simple_display=
_pipe *pipe,
 		mxsfb->connector =3D &mxsfb->panel_connector;
 	}
=20
+	drm_crtc_vblank_on(&mxsfb->pipe.crtc);
+
 	pm_runtime_get_sync(drm->dev);
 	drm_panel_prepare(mxsfb->panel);
 	mxsfb_crtc_enable(mxsfb);
@@ -249,7 +254,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
=20
 	pm_runtime_enable(drm->dev);
=20
-	ret =3D drm_vblank_init(drm, drm->mode_config.num_crtc);
+	ret =3D drm_vblank_init(drm, MAX_CRTCS);
 	if (ret < 0) {
 		dev_err(drm->dev, "Failed to initialise vblank\n");
 		goto err_vblank;
@@ -272,6 +277,8 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
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

