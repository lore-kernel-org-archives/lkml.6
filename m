Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1646FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF02420880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690402;
	bh=aA0AO3Zl9UIM0F3Fg9Ct9k9JEKpSw1WEte/Qc/6ioy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KI8ii49+/oXzvkudr/7Sks0X3/0SbvJxCqoA07EU+uphvrkUdgi+88g3LG5CiHHXh
	 KPPzCAVXi2dyrqftYSULoeuS0hP1weiga756Oh7YzQLrfTVic6bvEeMedu+ad67Q0q
	 mqfTZ37gU86mnRX+9qy0WGSYf3lMWufTqJx1BjIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfA1Pql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfA1Pqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:46:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5126021741;
        Mon, 28 Jan 2019 15:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690396;
        bh=aA0AO3Zl9UIM0F3Fg9Ct9k9JEKpSw1WEte/Qc/6ioy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WCNgY3Ni8YjzwY9AabeJwZ+dULFOo0ssZ2wZE3z1tcKwVC0CFbEnkZBISA4FX085M
         wY5ES5z7C2nFNVj0wuhggLygnbMTgIjI+RtAL84WDJSaakc2QqLKHsxHdn/7x48IM2
         t20E28HK3U24GvL4bM6vqxWtgw+qSE/e+a7omC4Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 071/304] drm: rcar-du: Fix external clock error checks
Date:   Mon, 28 Jan 2019 10:39:48 -0500
Message-Id: <20190128154341.47195-71-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[ Upstream commit 63a298f22a6183b5b7536a203596c6570dfcfe8e ]

The rcar-du driver supports probe deferral for external clocks, but
implements it badly by checking the wrong pointer due to a bad copy and
paste. Fix it.

While at it, reject invalid clocks outright for DU channels that have a
display PLL, as the external clock is mandatory in that case. This
avoids a WARN_ON() at runtime.

Fixes: 1b30dbde8596 ("drm: rcar-du: Add support for external pixel clock")
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 17741843cf51..40a9afe818a8 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -226,9 +226,6 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 		 * system clock, and have no internal clock divider.
 		 */
 
-		if (WARN_ON(!rcrtc->extclock))
-			return;
-
 		/*
 		 * The H3 ES1.x exhibits dot clock duty cycle stability issues.
 		 * We can work around them by configuring the DPLL to twice the
@@ -1113,9 +1110,16 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int swindex,
 	clk = devm_clk_get(rcdu->dev, clk_name);
 	if (!IS_ERR(clk)) {
 		rcrtc->extclock = clk;
-	} else if (PTR_ERR(rcrtc->clock) == -EPROBE_DEFER) {
-		dev_info(rcdu->dev, "can't get external clock %u\n", hwindex);
+	} else if (PTR_ERR(clk) == -EPROBE_DEFER) {
 		return -EPROBE_DEFER;
+	} else if (rcdu->info->dpll_mask & BIT(hwindex)) {
+		/*
+		 * DU channels that have a display PLL can't use the internal
+		 * system clock and thus require an external clock.
+		 */
+		ret = PTR_ERR(clk);
+		dev_err(rcdu->dev, "can't get dclkin.%u: %d\n", hwindex, ret);
+		return ret;
 	}
 
 	init_waitqueue_head(&rcrtc->flip_wait);
-- 
2.19.1

