Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A58C65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7186B2084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7186B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeJGQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:46:34 -0400
Received: from mailoutvs36.siol.net ([185.57.226.227]:39815 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728150AbeJGQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:46:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 4E005520C56;
        Sun,  7 Oct 2018 11:39:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3bm5-EKQ5xpF; Sun,  7 Oct 2018 11:39:48 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 03154520C68;
        Sun,  7 Oct 2018 11:39:48 +0200 (CEST)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 8F6D4520C56;
        Sun,  7 Oct 2018 11:39:45 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 12/29] drm/sun4i: Disable unused DE2 sub-engines
Date:   Sun,  7 Oct 2018 11:38:48 +0200
Message-Id: <20181007093905.11253-13-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sub-engines are unused. Disable them explicitly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 8 ++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index 7beb3065a522..2cb24d987005 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -462,6 +462,14 @@ static int sun8i_mixer_bind(struct device *dev, stru=
ct device *master,
 	/* Reset the registers */
 	for (i =3D 0; i < DE2_MIXER_UNIT_SIZE; i +=3D 4)
 		regmap_write(mixer->engine.regs, i, 0);
+	/* Disable unused sub-engines */
+	regmap_write(mixer->engine.regs, DE2_MIXER_FCE_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_BWS_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_LTI_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_PEAK_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_ASE_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_FCC_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_DCSC_EN, 0);
=20
 	/* Enable the mixer */
 	regmap_write(mixer->engine.regs, DE2_MIXER_GLOBAL_CTL,
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index e2aa42e8f715..f26ee6af6cba 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -101,8 +101,8 @@
 #define DE2_MIXER_FBFMT_YUV411		14
=20
 /*
- * These sub-engines are still unknown now, the EN registers are here on=
ly to
- * be used to disable these sub-engines.
+ * Sub-engines listed bellow are unused for now. The EN registers are he=
re only
+ * to be used to disable these sub-engines.
  */
 #define DE2_MIXER_FCE_EN			0xa0000
 #define DE2_MIXER_BWS_EN			0xa2000
--=20
2.19.0

