Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8721C222AA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895028;
	bh=vIYTZCBig+8yM6lOo+OnZedXR6Qqy1Xkr0UvNKEdttg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kon5HQ3GI0Ypq4Kuo/qQTyrN1jCFa9gxWYrU+vCF+zAemJXV+vyHHNF/3hOANRx8C
	 6f47X2yxFVETPqawvgzshI+iy6WJhCzV+UW1Hg1/QWdZixS+XogtAlBiaBk4iIwIHW
	 eYnjOq2TyCNMKjf58IZOKGlP/Sl/Z+lXYN/ZWobU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfBKOXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:23:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbfBKOXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:23:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 192B220838;
        Mon, 11 Feb 2019 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895023;
        bh=vIYTZCBig+8yM6lOo+OnZedXR6Qqy1Xkr0UvNKEdttg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gm8sfLPrGusZlUCwzQFL6zRklKj61EyL/Jj0iDdFPexiwlF2eByKQD8ogfYPVmnJF
         rE6aAlbBJdbCB/ALqAzJmJFhck1hTZdNxhZYpWq/s67lZh8yeAaA7UwVz34TlHLHHy
         U34pBgh/Ptebr8w+P+v1Tsn7AeCDwCc2btSo5/lQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 065/352] drm: rcar-du: Fix external clock error checks
Date:   Mon, 11 Feb 2019 15:14:52 +0100
Message-Id: <20190211141850.264969115@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



