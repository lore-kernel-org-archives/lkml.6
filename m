Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7275920657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="x2fCsLrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392628AbfAPLtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:49:08 -0500
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:27264
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392534AbfAPLtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiDWC4QVf/ivpXJVFdoQTXI5VmYNSCbnRYKnu77U/yw=;
 b=x2fCsLrPvFWmM9mf7C8Lt4nYllz+7TuCEXsJhjnfR6xqNTtzPD0rNcOJs1G0rRtGRqj5pLasD7y/JjvxAeZaAU2XBKRfy72jGQOfKa/InFn1DOCzwC8RQjDe+xGhaCk6XqbDIyJX8u+PPMsclTcCuUBQf6MprevhH/JVMvvs4I4=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6101.eurprd04.prod.outlook.com (20.179.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:46 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:46 +0000
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
Subject: [PATCH 09/11] drm/mxsfb: Move pm_runtime_enable at the end of probe
Thread-Topic: [PATCH 09/11] drm/mxsfb: Move pm_runtime_enable at the end of
 probe
Thread-Index: AQHUrZFwDWaLp30y80KyD0bavPpg1A==
Date:   Wed, 16 Jan 2019 11:48:46 +0000
Message-ID: <1547639306-19151-10-git-send-email-robert.chiras@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6101;6:BUvTocEot2vELhLhGXzEZr6mLf5IJtH7YLXk8mBmFY/gCr1qYpOr2ryRIFD4SLS2VmECXgGSZgaKjLOe2Ezw1vkryD0u8fcLvHyjdQsED/dklbVnmlDyaj/A6o2duTk1c3JvleEFRFbD/g/Bd/zJQFKUrb7x7Skh88bx+LpTElIAHRPuhwHqP42sg5o3/JJ/JOE5rebVQNLTHQcr2nn9JTWTB2NiZJFkAI9gduj4kgCQOVpgabUF1pczyOz+UwGA1ADwYZGyZyO6PeF1XZ1pohfMnJgpFELRzmGZ8eco/ivLPp/ScOAPZkJpQjx/ulaMqAfKRMWRZDscZi3UJA80DbxPnNDwMFCC8AHwAJ6wJmVqwNdidUZfDpzsM9fKDuwU79IGRt5MbXXlpEwHcadBddzWJMRC8w84gcQCid7tiiT0yNNufWPHVU13LcC0n+8zRkrr11M7zgfTWJl1n08IMg==;5:YaZUWoADgq+yeucoMmALSq5q5DntA9kMh1UlPCplvRr8rsOfYcuZXBl5kt8Tvd/RYoJxI/TYhItXXGpsone38fJ9g8y8E605Jqd02DJLmSxfNNA8BuR7u8qvObyMM6MQdkOOVsTvYCpJN+5y/FgRkQiFHBWaUi1U4T9M8Ceze5cHFe9vdjRBaT6pgBLDErkID5thZt4Q/bQMDOtmaTq44w==;7:v+XNF+N90qUaUVjpF/iwv1uNlGqQADjpsjInNEcgtL20Yb/kSmOlXH49P1MEBN9dTiFWtpkkcvTHYEKmvsU4KGVYeRAB58+Kqd28U4plAw1Z3qlw/cPJlgIotutIg7EFOSDx/JhfP7pDPoKoWcw2RA==
x-ms-office365-filtering-correlation-id: d636452e-4330-4256-9461-08d67ba892cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6101;
x-ms-traffictypediagnostic: AM6PR04MB6101:
x-microsoft-antispam-prvs: <AM6PR04MB61012D67D1E99B7996B67AEBE3820@AM6PR04MB6101.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(316002)(81156014)(110136005)(102836004)(81166006)(476003)(26005)(2616005)(186003)(8676002)(7736002)(66066001)(3846002)(50226002)(105586002)(305945005)(6486002)(8936002)(99286004)(54906003)(6436002)(106356001)(6116002)(86362001)(2906002)(44832011)(14454004)(478600001)(486006)(71200400001)(68736007)(97736004)(5660300001)(53936002)(76176011)(36756003)(5024004)(256004)(446003)(11346002)(25786009)(386003)(6506007)(6512007)(52116002)(4326008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6101;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mo0Gk3SNJ1vtUe2/77RgCb9e6nahVK4G7g1LZvLTV+/WiLJGj26WRIFUABucPhWz7m4IvPPmjXIPYOrBKED7AXFCKdRYU8iESS8OOG7ko7ovfvkXHJihizLdIqi9Vu/l77YxyrboaHdzs5fVdYkgjUII6WqugVdj5HaXPDU43NbH6BmsNMfE591edwdqbWDsjEfJ96yBv4Vzg/VBNZ8nC6Sag0B3xKBxkB6YC38JsbOB5KqRD1A5+HWW5BmVOH2UJVeKzDq+re15Hn4Q9kv0/hUGsg6GmdD/wk+H2o3mowwQfLHcUDL6ROOMceQ/1xNUoao+h7KfaDnXY4EjIdgNYOT4GFr+K8aBaVTY6sqdEJQmpyKC8xFGLSNTwIgRNTOnrwFPwkxggp/501oxZoLPtG39Fj7HQGsAbo6vQB1cu8o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d636452e-4330-4256-9461-08d67ba892cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:46.1027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the pm_runtime_enable call at the end of probbe, since it was made too
early, causing issues to DRM enable routines.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.c
index 3032007..9247c76 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -301,12 +301,10 @@ static int mxsfb_load(struct drm_device *drm, unsigne=
d long flags)
 	if (ret)
 		return ret;
=20
-	pm_runtime_enable(drm->dev);
-
 	ret =3D drm_vblank_init(drm, MAX_CRTCS);
 	if (ret < 0) {
 		dev_err(drm->dev, "Failed to initialise vblank\n");
-		goto err_vblank;
+		return ret;
 	}
=20
 	/* Modeset init */
@@ -315,7 +313,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
 	ret =3D mxsfb_create_output(drm);
 	if (ret < 0) {
 		dev_err(drm->dev, "Failed to create outputs\n");
-		goto err_vblank;
+		return ret;
 	}
=20
 	ret =3D drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
@@ -323,7 +321,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
 			mxsfb->connector);
 	if (ret < 0) {
 		dev_err(drm->dev, "Cannot setup simple display pipe\n");
-		goto err_vblank;
+		return ret;
 	}
=20
 	drm_crtc_vblank_off(&mxsfb->pipe.crtc);
@@ -340,14 +338,14 @@ static int mxsfb_load(struct drm_device *drm, unsigne=
d long flags)
 		ret =3D drm_panel_attach(mxsfb->panel, mxsfb->connector);
 		if (ret) {
 			dev_err(drm->dev, "Cannot connect panel\n");
-			goto err_vblank;
+			return ret;
 		}
 	} else if (mxsfb->bridge) {
 		ret =3D drm_simple_display_pipe_attach_bridge(&mxsfb->pipe,
 				mxsfb->bridge);
 		if (ret) {
 			dev_err(drm->dev, "Cannot connect bridge\n");
-			goto err_vblank;
+			return ret;
 		}
 	}
=20
@@ -367,9 +365,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
=20
 	drm_mode_config_reset(drm);
=20
-	pm_runtime_get_sync(drm->dev);
 	ret =3D drm_irq_install(drm, platform_get_irq(pdev, 0));
-	pm_runtime_put_sync(drm->dev);
=20
 	if (ret < 0) {
 		dev_err(drm->dev, "Failed to install IRQ handler\n");
@@ -391,14 +387,14 @@ static int mxsfb_load(struct drm_device *drm, unsigne=
d long flags)
=20
 	drm_helper_hpd_irq_event(drm);
=20
+	pm_runtime_enable(drm->dev);
+
 	return 0;
=20
 err_cma:
 	drm_irq_uninstall(drm);
 err_irq:
 	drm_panel_detach(mxsfb->panel);
-err_vblank:
-	pm_runtime_disable(drm->dev);
=20
 	return ret;
 }
--=20
2.7.4

