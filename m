Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB1BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B251520657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P2AgmejP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392616AbfAPLtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:49:07 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:57311
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392592AbfAPLtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FO8jpD9HamqqppHoASdPuPHKCBVdRmqs0gCgBEH3wQ=;
 b=P2AgmejPOWNe4LQMnKh/Ot5Gz13XBfH5rKvNJgNKz5D6lP5OLZ47r8WRx4dijwYKf97XlCAsHPHUsQBdg6ePOqnNOfk0aQTN/gZq7ykltTAp0EGMb1yzgvObkN7AoNvf5uaHZpOIRxt8yWRbVEoEGA720w1L/Xr4k9ghpkxa6NU=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6101.eurprd04.prod.outlook.com (20.179.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:47 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:47 +0000
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
Subject: [PATCH 10/11] drm/mxsfb: Improve the axi clock usage
Thread-Topic: [PATCH 10/11] drm/mxsfb: Improve the axi clock usage
Thread-Index: AQHUrZFwh71/bvKDMU6drnSd3zNJaw==
Date:   Wed, 16 Jan 2019 11:48:47 +0000
Message-ID: <1547639306-19151-11-git-send-email-robert.chiras@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6101;6:fzNsCCpIKkSZPrjgj81C6IhfBEiZWNxJQKzKyl3ZC+hE4oZMdpMRdRjKn5qoFs1zs8MK1kRDPmrD6UAECud2hw4OUMcsMbcvWJRQYxCMWiYIqh8dM6LJqTRJan0CoOfJX37dH5/nIrgL8y3dad54qznJbqTGtgRFpasLmk3krmJvFEvcJAGzaPkXO5oBb2G9uDreEkViYOK3YPXCoevJTvleDHvNQCvegYOVsgahOhtL8PKSZfw8ZdSbvOAxyz32dPZnmXMdwDnxfN9lnAiwKXZCDYxS6XAOl6gD3gOUtuV3R+u/N/BCZKFjhR2eOBptfHzhwnrtncFvuUyFqKcS5KX7Q3rU5wW9FDSl546bC6BiRAtcDHiBBMxe4OAjgQrLgwo1LNPXA7Wla+HoMePIoBZvyFk1Kl2cHT0I41Raltc2r+YaTkUuorlqZ3OQ63dfQ+m4G5C19DnF+4WxaXxsXA==;5:EYOarqA7gQTO8pCoIQFJlbn5GB8/FpbldRXQVSxdztSBcYQvtkY+58CVGfw/8HaXV0MSUq3LUP9EWkyUagPvkCmMELu9EeKlJSCnajl15Qdp4A3q7GsHe9xn7J3Y2fmSMby/pIAS3UkNtUTxt6sPb+n8OgVYC6B12ou+I6yeWaCXhemcMvlSFWND9EVA6XEW+dTnjTbkPem0nUE9J6UXMA==;7:RR3JwymNUxf6HpSRUunkUhpYoYNZ6ndfC11ermHf3yqPaAkoval+2aPJVv/enC7HqmEqL10BZOa1jcwWZda6ZhlSDrShPIvidMQRwru7hUJ1jtm0L5bq/twLJT/pVjric4AhEXBAp5EerND/UVHqPw==
x-ms-office365-filtering-correlation-id: 16ecbc19-fc21-46d1-28bf-08d67ba89355
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6101;
x-ms-traffictypediagnostic: AM6PR04MB6101:
x-microsoft-antispam-prvs: <AM6PR04MB6101100C255AE3735693E6A4E3820@AM6PR04MB6101.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(316002)(81156014)(110136005)(102836004)(81166006)(476003)(26005)(2616005)(186003)(8676002)(7736002)(66066001)(3846002)(50226002)(105586002)(305945005)(6486002)(8936002)(99286004)(54906003)(6436002)(106356001)(6116002)(86362001)(2906002)(44832011)(14454004)(478600001)(486006)(71200400001)(68736007)(97736004)(5660300001)(53936002)(76176011)(36756003)(256004)(446003)(14444005)(11346002)(25786009)(386003)(6506007)(6512007)(52116002)(4326008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6101;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t+E/+eLPDrsPH1ZzIDRixVXm35bZ7L3NdnhbvjK6O27ovedC1JrCSuiuBX6nxmCrRA+L+cX+sb6v30OvdAEsbwrOYa8gSvZe0XoT9Ei27LBmrWZfoXYwCHt6Ud+jtlBdPRrEO6CwKXf9WNds9Fgc27A2ykqSAmKqGLyymyTmpaxMpay/GDzxdwqs1bvNcWGzH7vV5WOTiiV8tb33HPOrPAZ9xqtJTf3QmWhwvxRFa8Dhxpv6VuRLGUD89SQ9kjBNw1XN5oETxnP3wR3C8PPVtIDc9e7BaucwTcqnGSae2jy0tjYzngWwPRuV+wMCWlYMhlRXFO4pxDJnXCIFsv+/xWV9ApE4LGKATEpAu4wvvZo/YDWepUTQTIrnTYGhHefgl7KsNLtXqeJJTjlTf5K9CJA892npBcHOumX6IgMSYME=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ecbc19-fc21-46d1-28bf-08d67ba89355
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:47.0023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the enable of the axi clock return status is ignored, causing
issues when the enable fails then we try to disable it. Therefore, it is
better to check the return status and disable it only when enable
succeeded.
Also, remove the helper functions around clk_axi, since we can directly
use the clk API function for enable/disable the clock. Those functions
are already checking for NULL clk and returning 0 if that's the case.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Acked-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c |  8 ++++----
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 32 +++++++++++++-------------------
 drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  3 ---
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxs=
fb_crtc.c
index 35d6f10..cbdbd47 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -411,7 +411,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
 	dma_addr_t paddr;
=20
-	mxsfb_enable_axi_clk(mxsfb);
+	clk_prepare_enable(mxsfb->clk_axi);
 	writel(0, mxsfb->base + LCDC_CTRL);
 	mxsfb_crtc_mode_set_nofb(mxsfb);
=20
@@ -428,7 +428,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 {
 	mxsfb_disable_controller(mxsfb);
-	mxsfb_disable_axi_clk(mxsfb);
+	clk_disable_unprepare(mxsfb->clk_axi);
 }
=20
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
@@ -456,9 +456,9 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private=
 *mxsfb,
=20
 	paddr =3D mxsfb_get_fb_paddr(mxsfb);
 	if (paddr) {
-		mxsfb_enable_axi_clk(mxsfb);
+		clk_prepare_enable(mxsfb->clk_axi);
 		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
-		mxsfb_disable_axi_clk(mxsfb);
+		clk_disable_unprepare(mxsfb->clk_axi);
 	}
=20
 	if (!fb || !old_fb)
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.c
index 9247c76..34f3de1 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -101,18 +101,6 @@ drm_pipe_to_mxsfb_drm_private(struct drm_simple_displa=
y_pipe *pipe)
 	return container_of(pipe, struct mxsfb_drm_private, pipe);
 }
=20
-void mxsfb_enable_axi_clk(struct mxsfb_drm_private *mxsfb)
-{
-	if (mxsfb->clk_axi)
-		clk_prepare_enable(mxsfb->clk_axi);
-}
-
-void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb)
-{
-	if (mxsfb->clk_axi)
-		clk_disable_unprepare(mxsfb->clk_axi);
-}
-
 /**
  * mxsfb_atomic_helper_check - validate state object
  * @dev: DRM device
@@ -235,25 +223,31 @@ static void mxsfb_pipe_update(struct drm_simple_displ=
ay_pipe *pipe,
 static int mxsfb_pipe_enable_vblank(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb =3D drm_pipe_to_mxsfb_drm_private(pipe);
+	int ret =3D 0;
+
+	ret =3D clk_prepare_enable(mxsfb->clk_axi);
+	if (ret)
+		return ret;
=20
 	/* Clear and enable VBLANK IRQ */
-	mxsfb_enable_axi_clk(mxsfb);
 	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
 	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_SET);
-	mxsfb_disable_axi_clk(mxsfb);
+	clk_disable_unprepare(mxsfb->clk_axi);
=20
-	return 0;
+	return ret;
 }
=20
 static void mxsfb_pipe_disable_vblank(struct drm_simple_display_pipe *pipe=
)
 {
 	struct mxsfb_drm_private *mxsfb =3D drm_pipe_to_mxsfb_drm_private(pipe);
=20
+	if (clk_prepare_enable(mxsfb->clk_axi))
+		return;
+
 	/* Disable and clear VBLANK IRQ */
-	mxsfb_enable_axi_clk(mxsfb);
 	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_CLR);
 	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
-	mxsfb_disable_axi_clk(mxsfb);
+	clk_disable_unprepare(mxsfb->clk_axi);
 }
=20
 static struct drm_simple_display_pipe_funcs mxsfb_funcs =3D {
@@ -438,7 +432,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *dat=
a)
 	struct mxsfb_drm_private *mxsfb =3D drm->dev_private;
 	u32 reg;
=20
-	mxsfb_enable_axi_clk(mxsfb);
+	clk_prepare_enable(mxsfb->clk_axi);
=20
 	reg =3D readl(mxsfb->base + LCDC_CTRL1);
=20
@@ -447,7 +441,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *dat=
a)
=20
 	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
=20
-	mxsfb_disable_axi_clk(mxsfb);
+	clk_disable_unprepare(mxsfb->clk_axi);
=20
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.h
index 8b6f332..e75f319 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -46,9 +46,6 @@ struct mxsfb_drm_private {
 int mxsfb_setup_crtc(struct drm_device *dev);
 int mxsfb_create_output(struct drm_device *dev);
=20
-void mxsfb_enable_axi_clk(struct mxsfb_drm_private *mxsfb);
-void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb);
-
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb);
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb);
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
--=20
2.7.4

