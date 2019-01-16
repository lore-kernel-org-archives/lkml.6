Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE589C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A8D20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393962AbfAPPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:15:19 -0500
Received: from shell.v3.sk ([90.176.6.54]:57038 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733300AbfAPPPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:15:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 98CF3533E2;
        Wed, 16 Jan 2019 16:15:16 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1OS2ED2SC6VB; Wed, 16 Jan 2019 16:15:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3F98C53FB6;
        Wed, 16 Jan 2019 16:15:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZKZU0XusbVbL; Wed, 16 Jan 2019 16:15:11 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6F571533E2;
        Wed, 16 Jan 2019 16:15:11 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] video: fbdev: geode: remove ifdef OLPC noise
Date:   Wed, 16 Jan 2019 16:14:54 +0100
Message-Id: <20190116151453.1971999-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<asm/olpc.h> provides olpc_has_dcon() stub for CONFIG_OLPC=3Dn, compiler
should just optimize the unneeded bits away.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/video/fbdev/geode/gxfb_core.c | 13 ++-----------
 drivers/video/fbdev/geode/lxfb_core.c | 13 ++-----------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/=
geode/gxfb_core.c
index f4f76373b2a8..b1906cf5a8f0 100644
--- a/drivers/video/fbdev/geode/gxfb_core.c
+++ b/drivers/video/fbdev/geode/gxfb_core.c
@@ -33,6 +33,8 @@
 #include <linux/pci.h>
 #include <linux/cs5535.h>
=20
+#include <asm/olpc.h>
+
 #include "gxfb.h"
=20
 static char *mode_option;
@@ -107,9 +109,6 @@ static struct fb_videomode gx_modedb[] =3D {
 	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 };
=20
-#ifdef CONFIG_OLPC
-#include <asm/olpc.h>
-
 static struct fb_videomode gx_dcon_modedb[] =3D {
 	/* The only mode the DCON has is 1200x900 */
 	{ NULL, 50, 1200, 900, 17460, 24, 8, 4, 5, 8, 3,
@@ -128,14 +127,6 @@ static void get_modedb(struct fb_videomode **modedb,=
 unsigned int *size)
 	}
 }
=20
-#else
-static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
-{
-	*modedb =3D (struct fb_videomode *) gx_modedb;
-	*size =3D ARRAY_SIZE(gx_modedb);
-}
-#endif
-
 static int gxfb_check_var(struct fb_var_screeninfo *var, struct fb_info =
*info)
 {
 	if (var->xres > 1600 || var->yres > 1200)
diff --git a/drivers/video/fbdev/geode/lxfb_core.c b/drivers/video/fbdev/=
geode/lxfb_core.c
index 138da6cb6cbc..17ab905811b1 100644
--- a/drivers/video/fbdev/geode/lxfb_core.c
+++ b/drivers/video/fbdev/geode/lxfb_core.c
@@ -23,6 +23,8 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
=20
+#include <asm/olpc.h>
+
 #include "lxfb.h"
=20
 static char *mode_option;
@@ -216,9 +218,6 @@ static struct fb_videomode geode_modedb[] =3D {
 	  0, FB_VMODE_NONINTERLACED, 0 },
 };
=20
-#ifdef CONFIG_OLPC
-#include <asm/olpc.h>
-
 static struct fb_videomode olpc_dcon_modedb[] =3D {
 	/* The only mode the DCON has is 1200x900 */
 	{ NULL, 50, 1200, 900, 17460, 24, 8, 4, 5, 8, 3,
@@ -237,14 +236,6 @@ static void get_modedb(struct fb_videomode **modedb,=
 unsigned int *size)
 	}
 }
=20
-#else
-static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
-{
-	*modedb =3D (struct fb_videomode *) geode_modedb;
-	*size =3D ARRAY_SIZE(geode_modedb);
-}
-#endif
-
 static int lxfb_check_var(struct fb_var_screeninfo *var, struct fb_info =
*info)
 {
 	if (var->xres > 1920 || var->yres > 1440)
--=20
2.20.1

