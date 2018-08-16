Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F53EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C791A21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C791A21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390699AbeHPRIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:08:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36766 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbeHPRIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:08:23 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fqIxs-0000DE-5c; Thu, 16 Aug 2018 16:09:28 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org, briannorris@chromium.org, hl@rock-chips.com,
        nickey.yang@rock-chips.com, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] drm/panel: p079zca: unconditionally remove the panel on removal
Date:   Thu, 16 Aug 2018 16:09:20 +0200
Message-Id: <20180816140920.5009-1-heiko@sntech.de>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to check innolux->base.dev when trying to remove
the panel, as that variable is always set directly before the panel
gets added and will still be available on panel_remove.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 72edb334d997..ca4ae45dd307 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -506,8 +506,7 @@ static int innolux_panel_add(struct mipi_dsi_device *dsi,
 
 static void innolux_panel_del(struct innolux_panel *innolux)
 {
-	if (innolux->base.dev)
-		drm_panel_remove(&innolux->base);
+	drm_panel_remove(&innolux->base);
 }
 
 static int innolux_panel_probe(struct mipi_dsi_device *dsi)
-- 
2.17.0

