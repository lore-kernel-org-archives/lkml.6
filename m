Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216CEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53ED20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVeccttX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53ED20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeKZPAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 10:00:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34670 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeKZPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 10:00:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so13218386plo.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 20:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcYxqSLEBxrtZEfSqHikCvgwNVEYCzsR6Neext4Petc=;
        b=dVeccttXPOe83UTvldqsO0tINFcU9nwZGHJL2cfuqxJOPjVd86Dlbgj0ndSc1dT/Mk
         YZW3FyiITIXq3gkUBvpgpsHWTAxN/Al3pMp83rZZZ6EV6h0FiOapn0G+VqwPOzZ8ITLr
         sxkty9Y1YkU+61p23PufbvKPZB2ffffQjHwww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcYxqSLEBxrtZEfSqHikCvgwNVEYCzsR6Neext4Petc=;
        b=VnPCTyUKbJ8nxNcfCapx+E8L26WvfGbjpVcFN1pwL3EX/QHbi1MUYQKzIVBGTZUutv
         2H5o4xUt9aWZU2RqlMvWUw7uwbKRUjUlAm1oHGAgsjjAKoeiisK0g6gySlucrbRjpQkF
         JenQ8Cqie38h8wzmnwCnpuEZo66tGY92IYi1mxW6/4IAuyie7NzgIhHD9yPXD8MqoO2g
         sc9aorZkCBpGVjCHrkb7XA8fmsw+TmKXO7YAy76vY+cHUq1v6KV7+d7hWo9RvpCjjTrr
         4ZI41MfayAqheY3x4FhWuOdJr39W/TTZ+KnxeUbLYiERBOZPXjKgseZHXJeHzwW0S6aj
         N3Vw==
X-Gm-Message-State: AA+aEWb2E92Gj2zm5e01k6DFzoGexFU+46rWZ61zISTTg/Jq2jO0M7dJ
        yqln1MyJ5j+H17xClOHadl1gEg==
X-Google-Smtp-Source: AFSGD/XYJeDqVnbpbn90RhEzYvePjSInjbew6UjZgBGUNcoJizDG2SfV3Hw4WdEiCa93JpAvDGswWA==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr25988753pls.90.1543205263235;
        Sun, 25 Nov 2018 20:07:43 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id w136sm55833132pfd.169.2018.11.25.20.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 20:07:42 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: Only try to attach bridge if there is one
Date:   Mon, 26 Nov 2018 12:07:37 +0800
Message-Id: <20181126040737.138682-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if dsi->bridge is NULL, we still try to call drm_bridge_attach,
and print out an error message, before creating the connector.

When no bridge is provided, let's skip these 2 steps and directly
create the connector.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 66df1b17795921..27b507eb4a997d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -818,10 +818,13 @@ static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi)
 	dsi->encoder.possible_crtcs = 1;
 
 	/* If there's a bridge, attach to it and let it create the connector */
-	ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL);
-	if (ret) {
-		DRM_ERROR("Failed to attach bridge to drm\n");
-
+	if (dsi->bridge) {
+		ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL);
+		if (ret) {
+			DRM_ERROR("Failed to attach bridge to drm\n");
+			goto err_encoder_cleanup;
+		}
+	} else {
 		/* Otherwise create our own connector and attach to a panel */
 		ret = mtk_dsi_create_connector(drm, dsi);
 		if (ret)
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

