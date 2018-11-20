Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390C6C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D27214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D27214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeKTUck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:32:40 -0500
Received: from shell.v3.sk ([90.176.6.54]:50152 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbeKTUcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:32:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 09D6BC6FB2;
        Tue, 20 Nov 2018 11:04:18 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id raiamuJ0Ijcg; Tue, 20 Nov 2018 11:03:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DB9EEC6FC2;
        Tue, 20 Nov 2018 11:03:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4X2O8zljW1-a; Tue, 20 Nov 2018 11:03:43 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 790CFC6FB9;
        Tue, 20 Nov 2018 11:03:41 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>,
        Libin Yang <lbyang@marvell.com>,
        Albert Wang <twang13@marvell.com>
Subject: [PATCH v3 08/14] Revert "[media] marvell-ccic: reset ccic phy when stop streaming for stability"
Date:   Tue, 20 Nov 2018 11:03:13 +0100
Message-Id: <20181120100318.367987-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120100318.367987-1-lkundrak@v3.sk>
References: <20181120100318.367987-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This accesses the clock registers directly and thus is going to stay in t=
he
way of making the driver devicetree friendly.

No boards seems to actually use this. If it's somehow actually needed it
needs to be done differently.

This reverts commit 7c269f454e7a51b151d94f99344120efa1cd0acb.
---
 .../media/platform/marvell-ccic/mcam-core.c   |  6 -----
 .../media/platform/marvell-ccic/mcam-core.h   |  2 --
 .../media/platform/marvell-ccic/mmp-driver.c  | 25 -------------------
 3 files changed, 33 deletions(-)

diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/me=
dia/platform/marvell-ccic/mcam-core.c
index d24e5b7a3bc5..1b879035948c 100644
--- a/drivers/media/platform/marvell-ccic/mcam-core.c
+++ b/drivers/media/platform/marvell-ccic/mcam-core.c
@@ -1154,12 +1154,6 @@ static void mcam_vb_stop_streaming(struct vb2_queu=
e *vq)
 	if (cam->state !=3D S_STREAMING)
 		return;
 	mcam_ctlr_stop_dma(cam);
-	/*
-	 * Reset the CCIC PHY after stopping streaming,
-	 * otherwise, the CCIC may be unstable.
-	 */
-	if (cam->ctlr_reset)
-		cam->ctlr_reset(cam);
 	/*
 	 * VB2 reclaims the buffers, so we need to forget
 	 * about them.
diff --git a/drivers/media/platform/marvell-ccic/mcam-core.h b/drivers/me=
dia/platform/marvell-ccic/mcam-core.h
index ad8955f9f0a1..a3a097a45e78 100644
--- a/drivers/media/platform/marvell-ccic/mcam-core.h
+++ b/drivers/media/platform/marvell-ccic/mcam-core.h
@@ -116,7 +116,6 @@ struct mcam_camera {
 	int mclk_src;	/* which clock source the mclk derives from */
 	int mclk_div;	/* Clock Divider Value for MCLK */
=20
-	int ccic_id;
 	enum v4l2_mbus_type bus_type;
 	/* MIPI support */
 	/* The dphy config value, allocated in board file
@@ -137,7 +136,6 @@ struct mcam_camera {
 	int (*plat_power_up) (struct mcam_camera *cam);
 	void (*plat_power_down) (struct mcam_camera *cam);
 	void (*calc_dphy) (struct mcam_camera *cam);
-	void (*ctlr_reset) (struct mcam_camera *cam);
=20
 	/*
 	 * Everything below here is private to the mcam core and
diff --git a/drivers/media/platform/marvell-ccic/mmp-driver.c b/drivers/m=
edia/platform/marvell-ccic/mmp-driver.c
index 70a2833db0d1..dbfc597b955d 100644
--- a/drivers/media/platform/marvell-ccic/mmp-driver.c
+++ b/drivers/media/platform/marvell-ccic/mmp-driver.c
@@ -105,7 +105,6 @@ static struct mmp_camera *mmpcam_find_device(struct p=
latform_device *pdev)
 #define CPU_SUBSYS_PMU_BASE	0xd4282800
 #define REG_CCIC_DCGCR		0x28	/* CCIC dyn clock gate ctrl reg */
 #define REG_CCIC_CRCR		0x50	/* CCIC clk reset ctrl reg	*/
-#define REG_CCIC2_CRCR		0xf4	/* CCIC2 clk reset ctrl reg	*/
=20
 static void mcam_clk_enable(struct mcam_camera *mcam)
 {
@@ -183,28 +182,6 @@ static void mmpcam_power_down(struct mcam_camera *mc=
am)
 	mcam_clk_disable(mcam);
 }
=20
-static void mcam_ctlr_reset(struct mcam_camera *mcam)
-{
-	unsigned long val;
-	struct mmp_camera *cam =3D mcam_to_cam(mcam);
-
-	if (mcam->ccic_id) {
-		/*
-		 * Using CCIC2
-		 */
-		val =3D ioread32(cam->power_regs + REG_CCIC2_CRCR);
-		iowrite32(val & ~0x2, cam->power_regs + REG_CCIC2_CRCR);
-		iowrite32(val | 0x2, cam->power_regs + REG_CCIC2_CRCR);
-	} else {
-		/*
-		 * Using CCIC1
-		 */
-		val =3D ioread32(cam->power_regs + REG_CCIC_CRCR);
-		iowrite32(val & ~0x2, cam->power_regs + REG_CCIC_CRCR);
-		iowrite32(val | 0x2, cam->power_regs + REG_CCIC_CRCR);
-	}
-}
-
 /*
  * calc the dphy register values
  * There are three dphy registers being used.
@@ -352,11 +329,9 @@ static int mmpcam_probe(struct platform_device *pdev=
)
 	mcam =3D &cam->mcam;
 	mcam->plat_power_up =3D mmpcam_power_up;
 	mcam->plat_power_down =3D mmpcam_power_down;
-	mcam->ctlr_reset =3D mcam_ctlr_reset;
 	mcam->calc_dphy =3D mmpcam_calc_dphy;
 	mcam->dev =3D &pdev->dev;
 	mcam->use_smbus =3D 0;
-	mcam->ccic_id =3D pdev->id;
 	mcam->mclk_min =3D pdata->mclk_min;
 	mcam->mclk_src =3D pdata->mclk_src;
 	mcam->mclk_div =3D pdata->mclk_div;
--=20
2.19.1

