Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BEAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A62720874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A62720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935914AbeFRIXj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:23:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932870AbeFRIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:34 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9AC14C74;
        Mon, 18 Jun 2018 08:23:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 180/279] drm/exynos/mixer: fix synchronization check in interlaced mode
Date:   Mon, 18 Jun 2018 10:12:45 +0200
Message-Id: <20180618080616.388468631@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit 2eced8e917b060587fc8ed46df41c364957a5050 ]

In case of interlace mode video processor registers and mixer config
register must be check to ensure internal state is in sync with shadow
registers.
This patch fixes page-faults in interlaced mode.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos_mixer.c |   10 ++++++++++
 drivers/gpu/drm/exynos/regs-mixer.h   |    1 +
 2 files changed, 11 insertions(+)

--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -494,6 +494,7 @@ static void vp_video_buffer(struct mixer
 
 	spin_lock_irqsave(&ctx->reg_slock, flags);
 
+	vp_reg_write(ctx, VP_SHADOW_UPDATE, 1);
 	/* interlace or progressive scan mode */
 	val = (test_bit(MXR_BIT_INTERLACE, &ctx->flags) ? ~0 : 0);
 	vp_reg_writemask(ctx, VP_MODE, val, VP_MODE_LINE_SKIP);
@@ -711,6 +712,15 @@ static irqreturn_t mixer_irq_handler(int
 
 		/* interlace scan need to check shadow register */
 		if (test_bit(MXR_BIT_INTERLACE, &ctx->flags)) {
+			if (test_bit(MXR_BIT_VP_ENABLED, &ctx->flags) &&
+			    vp_reg_read(ctx, VP_SHADOW_UPDATE))
+				goto out;
+
+			base = mixer_reg_read(ctx, MXR_CFG);
+			shadow = mixer_reg_read(ctx, MXR_CFG_S);
+			if (base != shadow)
+				goto out;
+
 			base = mixer_reg_read(ctx, MXR_GRAPHIC_BASE(0));
 			shadow = mixer_reg_read(ctx, MXR_GRAPHIC_BASE_S(0));
 			if (base != shadow)
--- a/drivers/gpu/drm/exynos/regs-mixer.h
+++ b/drivers/gpu/drm/exynos/regs-mixer.h
@@ -47,6 +47,7 @@
 #define MXR_MO				0x0304
 #define MXR_RESOLUTION			0x0310
 
+#define MXR_CFG_S			0x2004
 #define MXR_GRAPHIC0_BASE_S		0x2024
 #define MXR_GRAPHIC1_BASE_S		0x2044
 


