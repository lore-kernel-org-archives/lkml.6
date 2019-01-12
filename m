Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228FFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E884C206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML6l6uDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfALTdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:33:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41819 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfALTdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:33:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so13081281lfj.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 11:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QN6lWunl3v34UryC8Jt0OOMGcLPbeFY0PRXCON6TUk=;
        b=ML6l6uDPLW6kf6w0zuh0324i8W/RhxxHVtZUDahg9chvtMaICmtHGGfnKz8yF32Qie
         gVjdvWHgwA4p2G+Y4AlaprBCuuJLIv0czxPb/hiuwBTIbDQmHV6TXGBqtcWxhhfzbYXH
         UXkBD/lqm1kbvYOcF90xyJ8yqdWuajvMT2JnJL6/1egJBesZngxc64dwGQJgWTAkN0LC
         PWUEelhCuNHx2Q8y16F4KiY7zhd8RgHQS/gEcyN7wgWq8gkxNAAINUGXJGdmZW62wBV/
         0G1ST0EzrqxhAUjW3fIbOBsHJjpy2DRxKe7g5Shp74A7blWVfheuvSBbHv3rqvS3vLN/
         AsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/QN6lWunl3v34UryC8Jt0OOMGcLPbeFY0PRXCON6TUk=;
        b=NKSkKQRWuTjn/MHxxn2sD59QR+28Z0fj3PvZWaSk0jHe2afb71EwLuGEKn/Ng2hD7t
         pq/PnOIft1w9nXuiJBEV0C2HwPOruWS+2tgDQi5QjIYx5C8bVBUNn0zxoc/UyVdE9z2i
         dn2Dae/zsYSRyf4OZMelXXyfwXFj2akcNRnJRhr1g5lkghWY7EpP9XgIXOBKo0Vd/wFd
         ES4Jmv1S7W5lMu3Seuemz+rsTKn/ynIzG101tzCPnKWi4ON+gAGF2kgX3ivB7g8OKt5B
         wu6dmJsf7SSJUpLvn4y6DKWHYdEEzSA22tPEOb3clwd4Sj6Qq/Jb2uNNs154o+De8OsD
         zd3w==
X-Gm-Message-State: AJcUuke0utwMf/9q+fL8n9KskzgaTh8iISsJK066wqHwxA+5HDPGcuXa
        koez/+RXLaCyvuwjFD36Qzo=
X-Google-Smtp-Source: ALg8bN7nPCdbDx+odyQjJvN8utkeGPiOLygWHV/8PL299PyKdfZ4BtfDpuhHWghat8Gn4WGsOCLYSA==
X-Received: by 2002:a19:4849:: with SMTP id v70mr10211119lfa.62.1547321614556;
        Sat, 12 Jan 2019 11:33:34 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id d82sm15624452lfd.82.2019.01.12.11.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 11:33:34 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Christian Konig <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Clark <robdclark@gmail.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 6/8] drm/bridge: cdns: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 12 Jan 2019 20:32:49 +0100
Message-Id: <20190112193251.20450-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190112193251.20450-1-sam@ravnborg.org>
References: <20190112193251.20450-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused cdns to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.

Build tested on arm x86 and arm allmodconfig.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index ce9496d13986..4b73d0969468 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -8,11 +8,13 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 #include <video/mipi_display.h>
 
 #include <linux/clk.h>
+#include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-- 
2.12.0

