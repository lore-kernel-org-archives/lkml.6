Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F7BECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFEC2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFEC2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeKEQtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:49:55 -0500
Received: from shell.v3.sk ([90.176.6.54]:49570 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbeKEQtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:49:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 63DC9C559D;
        Mon,  5 Nov 2018 08:31:34 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id URtJfb3n-9gd; Mon,  5 Nov 2018 08:31:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3CB29C5598;
        Mon,  5 Nov 2018 08:31:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bka1uA2rkli2; Mon,  5 Nov 2018 08:31:05 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9C9E3C5584;
        Mon,  5 Nov 2018 08:31:04 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 06/11] [media] marvell-ccic: drop ctlr_reset()
Date:   Mon,  5 Nov 2018 08:30:49 +0100
Message-Id: <20181105073054.24407-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105073054.24407-1-lkundrak@v3.sk>
References: <20181105073054.24407-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This accesses the clock registers directly and thus is not too
devicetree friendly. If it's actually needed it needs to be done
differently.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../media/platform/marvell-ccic/mcam-core.c   |  6 -----
 .../media/platform/marvell-ccic/mcam-core.h   |  1 -
 .../media/platform/marvell-ccic/mmp-driver.c  | 23 -------------------
 3 files changed, 30 deletions(-)

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
index ad8955f9f0a1..f93f23faf364 100644
--- a/drivers/media/platform/marvell-ccic/mcam-core.h
+++ b/drivers/media/platform/marvell-ccic/mcam-core.h
@@ -137,7 +137,6 @@ struct mcam_camera {
 	int (*plat_power_up) (struct mcam_camera *cam);
 	void (*plat_power_down) (struct mcam_camera *cam);
 	void (*calc_dphy) (struct mcam_camera *cam);
-	void (*ctlr_reset) (struct mcam_camera *cam);
=20
 	/*
 	 * Everything below here is private to the mcam core and
diff --git a/drivers/media/platform/marvell-ccic/mmp-driver.c b/drivers/m=
edia/platform/marvell-ccic/mmp-driver.c
index 70a2833db0d1..92a79ad8a12c 100644
--- a/drivers/media/platform/marvell-ccic/mmp-driver.c
+++ b/drivers/media/platform/marvell-ccic/mmp-driver.c
@@ -183,28 +183,6 @@ static void mmpcam_power_down(struct mcam_camera *mc=
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
@@ -352,7 +330,6 @@ static int mmpcam_probe(struct platform_device *pdev)
 	mcam =3D &cam->mcam;
 	mcam->plat_power_up =3D mmpcam_power_up;
 	mcam->plat_power_down =3D mmpcam_power_down;
-	mcam->ctlr_reset =3D mcam_ctlr_reset;
 	mcam->calc_dphy =3D mmpcam_calc_dphy;
 	mcam->dev =3D &pdev->dev;
 	mcam->use_smbus =3D 0;
--=20
2.19.1

