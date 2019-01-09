Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B938C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3614220821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JMCP8xPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfAIG73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:59:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40512 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbfAIG72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:59:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so3209877pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 22:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6AjmQoj4vZga1M05cboJY5gLkKlpnzB8nWkEfzeU72s=;
        b=JMCP8xPS+PH7DDjyTHv5NqjPaycfCstVNiYHZypDuTK0FROS+pR+a9BswBrk9KpsDH
         h9xteNBGEFTEmRAbNffAPozpdop93eV6WBziycD/fNBpELv6lp4QXXIwNdMtcLbKQXdI
         rqPmEUFOzvSNN1xLbcsuwrDUxiDM+yTzxIKs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6AjmQoj4vZga1M05cboJY5gLkKlpnzB8nWkEfzeU72s=;
        b=H7o53O5yBTGRAk3UU6Cd+0qzQ1+cKYTspzvNvi+gwl+JJEoaOHVYoiZiyyN2Ktwv+M
         BiYR8v0Iukz05Zm8dnGmxLVRKS326cHiQ0aMkbQdSydQshEvKSmXPmkiDwOuoj1P3j6q
         TH3js1p4CD6X9JnnwG+78rneNMw+rRX9jL7hvLxhGoV43DdqGJaTeGO8pGGrGN1pUZWF
         bYkPpVKS7gCGIvgwu+IvJBSaC9YU6ld0RDwaTI+cYCBAxvbpYyr3xq2PNgoX6I5clBx7
         dlsn5LfTi/6vLedHXujySEH3kuWUGi3SXWXEWLbrJcuvpGnbkGO1PYgtaT7rCciKuuIx
         64kA==
X-Gm-Message-State: AJcUuke+zWJp4Y7QeB7zdzlvfUniDLA8YQhiwm9YFGCHuBkIp/Kos/uA
        jXkfBEF76JpMUbVxdpdltc6AvQ==
X-Google-Smtp-Source: ALg8bN4tfm8j6CoknFNirnHygNkSos3VA+xBsXL4cGYlnScOGW1mNK6VuEuM5CelRcqIkbU34vpxbw==
X-Received: by 2002:a63:ac1a:: with SMTP id v26mr4398523pge.293.1547017167532;
        Tue, 08 Jan 2019 22:59:27 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id r80sm119773259pfa.111.2019.01.08.22.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Jan 2019 22:59:27 -0800 (PST)
From:   "Hsin-Yi, Wang" <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend] drm/panel: panel-innolux: set display off in innolux_panel_unprepare
Date:   Wed,  9 Jan 2019 14:59:22 +0800
Message-Id: <20190109065922.231753-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mipi_dsi_dcs_set_display_off() from innolux_panel_disable()
to innolux_panel_unprepare(), so they are consistent with
innolux_panel_enable() and innolux_panel_prepare().

This also fixes some mode check and irq timeout issue in MTK dsi code.

Since some dsi code (e.g. mtk_dsi) have following call trace:
1. drm_panel_disable(), which calls innolux_panel_disable()
2. switch to cmd mode
3. drm_panel_unprepare(), which calls innolux_panel_unprepare()

However, mtk_dsi needs to be in cmd mode to be able to send commands
(e.g. mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode()),
so we need these functions to be called after the switch to cmd mode happens,
i.e. in innolux_panel_unprepare.


Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
---
Resend for review.
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index ca4ae45dd307..8e5724b63f1f 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -70,18 +70,12 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
 static int innolux_panel_disable(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
-	int err;
 
 	if (!innolux->enabled)
 		return 0;
 
 	backlight_disable(innolux->backlight);
 
-	err = mipi_dsi_dcs_set_display_off(innolux->link);
-	if (err < 0)
-		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
-			      err);
-
 	innolux->enabled = false;
 
 	return 0;
@@ -95,6 +89,11 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 	if (!innolux->prepared)
 		return 0;
 
+	err = mipi_dsi_dcs_set_display_off(innolux->link);
+	if (err < 0)
+		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
+			      err);
+
 	err = mipi_dsi_dcs_enter_sleep_mode(innolux->link);
 	if (err < 0) {
 		DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
-- 
2.18.1

