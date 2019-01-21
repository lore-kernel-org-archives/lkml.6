Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1726FC31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E322C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfAUHSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:18:34 -0500
Received: from shell.v3.sk ([90.176.6.54]:49528 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfAUHSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:18:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 496FCCAE2C;
        Mon, 21 Jan 2019 07:02:14 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qLrcDZpROvNg; Mon, 21 Jan 2019 07:02:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 24ACFCAE2D;
        Mon, 21 Jan 2019 07:02:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Khi04bDCgK_M; Mon, 21 Jan 2019 07:02:08 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A074DCAE2C;
        Mon, 21 Jan 2019 07:02:08 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] drm/armada: replace the simple-framebuffer
Date:   Mon, 21 Jan 2019 07:01:57 +0100
Message-Id: <20190121060157.549544-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there's a simple-framebuffer carried over from boot firmware, it's goi=
ng
to stop working once we setup the LCDC for use via DRM. Kick it off from
the hardware.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/gpu/drm/armada/armada_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada=
/armada_drv.c
index fa31589b4fc0..9fcf88c91758 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -100,6 +100,17 @@ static int armada_drm_bind(struct device *dev)
 		return ret;
 	}
=20
+	/* Remove early framebuffers */
+	ret =3D drm_fb_helper_remove_conflicting_framebuffers(NULL,
+							    "armada-drm-fb",
+							    false);
+	if (ret) {
+		dev_err(dev, "[" DRM_NAME ":%s] can't kick out simple-fb: %d\n",
+			__func__, ret);
+		kfree(priv);
+		return ret;
+	}
+
 	priv->drm.dev_private =3D priv;
=20
 	dev_set_drvdata(dev, &priv->drm);
--=20
2.20.1

