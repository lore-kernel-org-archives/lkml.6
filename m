Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3134C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E5B20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DN+FjV2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfAIOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:14:12 -0500
Received: from mail-eopbgr00047.outbound.protection.outlook.com ([40.107.0.47]:52304
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731424AbfAION5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qGhHLUm/tfVv/HSmC6qBBIajsqjecZ8ucRbKdqd4NU=;
 b=DN+FjV2oGzS+aVHP1JhKf+WHANoN7miIsWXnFoeEVxQL9OcKcz4s4JMVvv/8UIU2Of4ITpwYMgXlKFM3gWLWs1PFlfo78Aacsn69rUQhguHDZ/+kwbREanWAlFi6sg3FGDaBJVfMe0++EV0hjWzPYHbUkkc4pZB0Z0NiVtrrbHI=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB5157.eurprd04.prod.outlook.com (20.177.34.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 14:13:48 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:13:48 +0000
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
Subject: [PATCH 08/10] drm/mxsfb: Update mxsfb to support LCD reset
Thread-Topic: [PATCH 08/10] drm/mxsfb: Update mxsfb to support LCD reset
Thread-Index: AQHUqCWJHvBlr2g5GUKA+eX8qEqITg==
Date:   Wed, 9 Jan 2019 14:13:48 +0000
Message-ID: <1547043209-8283-9-git-send-email-robert.chiras@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5157;6:MU8DVI6YWuRfTs5awNVBVgpQYqoiX8k4oK+6VXQGzPt2r6UIfA3uat4H/9YjE4pICpTFNRw5U7o20dHx4fgKnoUIGUnabEXVgRf91J+SzwwhBXJGWqko6RTcBZF1Ug2FSSv+bzPuUDYpyUr5X1m4qefpQakhsT84DG3nayz0zhbDK9kooQTAP+e3Ock+eWVnMVcJ5smrAm8YzR+Q7mggDNOmBV9TDlyok4/r3cse0fDzMAjL9TiEAhXSApUDrK9GtzECT0PrYAQ4IJhNELLXT5R7fGkM5PvZzCOA4WSZmxaPDxrETWdtLMmeJL1OMDnbGbVUlE9ipo4PxogIb/DR9KczMcI23uK6taDz4y3+qH5sEJt+qMkMGA9D5HGHXUQRFz7jaxMWotEMiYI0YsxUsRTEG3Q0QeqdIOkPGsQg0+tEKKhc59wBfABHz7BTNenDjfY/KnddgdzvSwZAQZzmxQ==;5:MupuWKK2W/GDHbbDOcBJjrjQBKaFuf7IeV28L0Lkky9ovF0ScN+c5yqPjrbfehPRu9k9QomGVTS46sNllA5loIRYXjdq4zWfucYiwzIESuWhZskPk6ls7ucyrjRexi8RNOxKkyYlToecKFodVYCG6bItrsBnPM0XVCUTHsSHroSRG42y3xYxItk4yQ8aV8KZgnN1+QewArd3t8fUMVYbwA==;7:1QHkXWGuKudk7YR3T62tt++tyaluLmVIQEqTuV14yib6vte2x+MGRXiLB5gj6LnWCWTOb+q/0X5Fu61IaMoPp3amZINSROwRrv/KtqdZAp3n6V8SVP1RiM8bZqcQc4c1TSUxGPU/g8NqJX+RU0HxHQ==
x-ms-office365-filtering-correlation-id: bb9c8cab-734c-43b4-eaa3-08d6763cac33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5157;
x-ms-traffictypediagnostic: AM6PR04MB5157:
x-microsoft-antispam-prvs: <AM6PR04MB515709F654638BBE56E52CF3E38B0@AM6PR04MB5157.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5157;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5157;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(50226002)(99286004)(11346002)(110136005)(2616005)(256004)(316002)(86362001)(5024004)(14444005)(54906003)(305945005)(7736002)(8676002)(71190400001)(6486002)(71200400001)(446003)(8936002)(105586002)(97736004)(81166006)(81156014)(36756003)(106356001)(476003)(25786009)(486006)(6436002)(186003)(3846002)(6116002)(478600001)(68736007)(53936002)(102836004)(6512007)(14454004)(5660300001)(44832011)(76176011)(52116002)(386003)(26005)(6506007)(2906002)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5157;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5ivm+lXrugly4E4XRqI/79L//nTds2JefWpUZ1fI9QeDs097YjK+YgUJEcxrSM+dLlEbo152b/TSMbDsS3EKlE5eqXhJBWGe6jwsGVtbJVFi5r3LHshNrKnkaEQuDjTiIxgydL+lZ9a9bmYdLkbB7UmryKsBYsnAAaG4sUWNIEhr4VDZPA4+CDn0yis8a5k7QabQoPeXsysqFn2+WgPS3prGh/oY73T//ZWGcvL1qKqVb2+zEnkmqsOwb6S4s44Q8bGhCavZPu50Bhh0SrLunSIWjCkKPhnr3ba8A7I824+uTC0RAGjsQZRuFWs7rAH4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9c8cab-734c-43b4-eaa3-08d6763cac33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:13:47.2598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eLCDIF controller has control pin for the external LCD reset pin.
Add support for it and assert this pin in enable and de-assert it in
disable.
Also, correct the pm_runtime_enable call, since it was made too early in
the probe, causing issues to DRM enable routines.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 12 ++++++++++--
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 20 ++++++++------------
 drivers/gpu/drm/mxsfb/mxsfb_regs.h |  1 +
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxs=
fb_crtc.c
index b62b607..8d1b6a6 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -230,9 +230,12 @@ static void mxsfb_enable_controller(struct mxsfb_drm_p=
rivate *mxsfb)
 		clk_prepare_enable(mxsfb->clk_disp_axi);
 	clk_prepare_enable(mxsfb->clk);
=20
-	if (mxsfb->devdata->ipversion >=3D 4)
+	if (mxsfb->devdata->ipversion >=3D 4) {
 		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
 			mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+		/* Assert LCD Reset bit */
+		writel(CTRL2_LCD_RESET, mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+	}
=20
 	/* If it was disabled, re-enable the mode again */
 	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
@@ -250,9 +253,12 @@ static void mxsfb_disable_controller(struct mxsfb_drm_=
private *mxsfb)
 {
 	u32 reg;
=20
-	if (mxsfb->devdata->ipversion >=3D 4)
+	if (mxsfb->devdata->ipversion >=3D 4) {
 		writel(CTRL2_OUTSTANDING_REQS(0x7),
 			mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
+		/* De-assert LCD Reset bit */
+		writel(CTRL2_LCD_RESET, mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
+	}
=20
 	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
=20
@@ -346,6 +352,8 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_p=
rivate *mxsfb)
 		return;
=20
 	clk_set_rate(mxsfb->clk, m->crtc_clock * 1000);
+	DRM_DEV_DEBUG_DRIVER(drm->dev, "Pixel clock: %dkHz (actual: %dkHz)\n",
+		m->crtc_clock, (int)(clk_get_rate(mxsfb->clk) / 1000));
=20
 	DRM_DEV_DEBUG_DRIVER(drm->dev,
 		"Connector bus_flags: 0x%08X\n", bus_flags);
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.c
index f528a37..135b8e1 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -287,7 +287,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
 	if (IS_ERR(mxsfb->base))
 		return PTR_ERR(mxsfb->base);
=20
-	mxsfb->clk =3D devm_clk_get(drm->dev, NULL);
+	mxsfb->clk =3D devm_clk_get(drm->dev, "pix");
 	if (IS_ERR(mxsfb->clk))
 		return PTR_ERR(mxsfb->clk);
=20
@@ -303,12 +303,10 @@ static int mxsfb_load(struct drm_device *drm, unsigne=
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
@@ -317,7 +315,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
 	ret =3D mxsfb_create_output(drm);
 	if (ret < 0) {
 		dev_err(drm->dev, "Failed to create outputs\n");
-		goto err_vblank;
+		return ret;
 	}
=20
 	ret =3D drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
@@ -325,7 +323,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
 			mxsfb->connector);
 	if (ret < 0) {
 		dev_err(drm->dev, "Cannot setup simple display pipe\n");
-		goto err_vblank;
+		return ret;
 	}
=20
 	drm_crtc_vblank_off(&mxsfb->pipe.crtc);
@@ -342,14 +340,14 @@ static int mxsfb_load(struct drm_device *drm, unsigne=
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
@@ -369,9 +367,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
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
@@ -393,14 +389,14 @@ static int mxsfb_load(struct drm_device *drm, unsigne=
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
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_regs.h b/drivers/gpu/drm/mxsfb/mxs=
fb_regs.h
index 4904fdd..1d85750 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_regs.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
@@ -95,6 +95,7 @@
 #define CTRL2_OUTSTANDING_REQS(x)	REG_PUT((x), 23, 21)
 #define CTRL2_ODD_LINE_PATTERN(x)	REG_PUT((x), 18, 16)
 #define CTRL2_EVEN_LINE_PATTERN(x)	REG_PUT((x), 14, 12)
+#define CTRL2_LCD_RESET			BIT(0)
=20
 #define TRANSFER_COUNT_SET_VCOUNT(x)	(((x) & 0xffff) << 16)
 #define TRANSFER_COUNT_GET_VCOUNT(x)	(((x) >> 16) & 0xffff)
--=20
2.7.4

