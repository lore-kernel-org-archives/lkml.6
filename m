Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1968C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952112075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p1Q2ou3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfAIOOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:14:03 -0500
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:4544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731430AbfAIOOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ubKCDVJkCp22LY0xgHVG6+x2SldyuorXwOGRCUwNTU=;
 b=p1Q2ou3YcIvzKcU66NdX29WZwmP5UZ9bENoz41kdMLUq+zu1Ip04cDIDic6RKKs7wyBNZV0el8yYDBUr3DbrF6X0EbGDsBecBIglSuaFwhrXNkNGlgnDlzlz+xrQDtRCOrwZ8YcHSXYL4Y+wMJK10AeyDScmupMS0pV2R4W3Wew=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB5157.eurprd04.prod.outlook.com (20.177.34.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 14:13:49 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:13:49 +0000
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
Subject: [PATCH 09/10] drm/mxsfb: Improve the axi clock usage
Thread-Topic: [PATCH 09/10] drm/mxsfb: Improve the axi clock usage
Thread-Index: AQHUqCWKOBAOhsJtI0yu/u26pU+g8A==
Date:   Wed, 9 Jan 2019 14:13:49 +0000
Message-ID: <1547043209-8283-10-git-send-email-robert.chiras@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5157;6:2tBswA1qSvkZ5r+yVGQmL8k4CgGt0aEErU0Q+BU5QQ7KLk4DMSgHb/SOqnimJov5zoxDsLqjuEK/QU1OIoYpga4qWLL54XfJUbHTw7A386JqqrwQT59qRSxShYg0KUseSYIPH69vvUjwhc4FtFP8uH/AgEzKNgrXPidLeGfss9tVBb5NVEj+h2TROsDz0De1xj1JFOfcOYywehIfpiuE5NIM1FR075h6TGQBycZ2pWS+EAWrS+uYMYQZjl/oMVRGsvsoKT/TrjtUGytCu4YZHn0xP9vkTVHgKUN2LBjkV+CiGYypspzdrbg83vKXsClrfRQLLmz4VJ7kmw6GXVEY4cQ9I+Q7+qVmHAQX3wDKkwx2+LF6uIuyKwhopJd1a7vyMWs13/RJ4giATeTB2rAcr9iStRGw0NuafdLBdfPi5QQzNjEFwemSmJUichlmBeIdzWeStWjVqaWAml/55NxIag==;5:PzFTaI5LjduxXUAPU+kgx7jdKsg/jktL0wwAz8I8Vl75egSZ8lxAlga53KITfk8jAMTqCm1SHir6SfobUk5F8IJClWUgpTyDRK8KpknXLvE6EwuxzeIhnR8LzaN8gVcFL9mtfVmqIZMHJwh6YGE3UX1TIufVEBOeyiOcON2+H3r3qJH3KkxNECeRn8s/1sdogPNH0iHlkLV1e/ynnuGD3A==;7:GPgWWrGy0V9RF67SWKlJR8rt2LQl7uBKF5MWGyItNJYbnfPxPkesSiKX6StJG/ikgsiFZyuX/wPlX834SLkZXNt/N39M0Z2sr65m49bHJDG4baDGNifA8Lg8gjr59VhdobkXpY/JCfuKN+jqe+gwIw==
x-ms-office365-filtering-correlation-id: e88f0aa7-1246-4599-2d1a-08d6763cacbf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5157;
x-ms-traffictypediagnostic: AM6PR04MB5157:
x-microsoft-antispam-prvs: <AM6PR04MB5157C7BE6011EA6FCFB0C566E38B0@AM6PR04MB5157.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5157;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5157;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(50226002)(99286004)(11346002)(110136005)(2616005)(256004)(316002)(86362001)(14444005)(54906003)(305945005)(7736002)(8676002)(71190400001)(6486002)(71200400001)(446003)(8936002)(105586002)(97736004)(81166006)(81156014)(36756003)(106356001)(476003)(25786009)(486006)(6436002)(186003)(3846002)(6116002)(478600001)(68736007)(53936002)(102836004)(6512007)(14454004)(5660300001)(44832011)(76176011)(52116002)(386003)(26005)(6506007)(2906002)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5157;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9viRynvkIj2xInge3VLavbRvU2YuvMrpg1KR5djW7eV3A6GGoVQJkinQqMUxdDaGvc0sColR2WsBtv2YRaBcMUvYSLsURS9POGlK0KV7lg2khwETgqju+X0wsYRN7BCCCrQt4frDKeRB175OBGaI+P6G7SbZl2bkrMpArMI3Idl1LuOYtPYRML2v0laKEQ6fBzg4E2HZhLdCAXuiyPpbU1Ly9+NgFY7jQToVSYB3rZqsyDVwUtIm4Rn2jHK38bQuVoco8HVwIx8v8iNnGY2fb8gDda8r5DKjT5MolWEbD0d7mDIFfsKvYm1q4rr86Q8S
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88f0aa7-1246-4599-2d1a-08d6763cacbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:13:48.1834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5157
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
index 8d1b6a6..b9437c7 100644
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
index 135b8e1..5e18353 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -103,18 +103,6 @@ drm_pipe_to_mxsfb_drm_private(struct drm_simple_displa=
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
@@ -237,25 +225,31 @@ static void mxsfb_pipe_update(struct drm_simple_displ=
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
@@ -440,7 +434,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *dat=
a)
 	struct mxsfb_drm_private *mxsfb =3D drm->dev_private;
 	u32 reg;
=20
-	mxsfb_enable_axi_clk(mxsfb);
+	clk_prepare_enable(mxsfb->clk_axi);
=20
 	reg =3D readl(mxsfb->base + LCDC_CTRL1);
=20
@@ -449,7 +443,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *dat=
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
index c15b4f9..ce98411 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -47,9 +47,6 @@ struct mxsfb_drm_private {
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

