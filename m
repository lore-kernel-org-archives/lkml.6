Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BDDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3838C206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMWGAik5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbfAHT4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:56:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39671 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbfAHTaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so4422197ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V1w5p8At+8zTrdz8NfvIJEZQzQMgB7370NwuSThERRY=;
        b=vMWGAik5jkaKIAZv2GLrim8dLbIZ+n70hC8qdvuSlF2zN7N8kwM2Xl1p/9JnYXw67O
         cn8bN4z8pQ3Q37ti8NzfU15TAzgK1j/UxWg/n1v/TurzprBdGJEvE7zuud4iXl9gah1O
         88UWpfhQqeteu2YlgExDcdwa0QlJPgO+Dv5Jm4Duu8PrcVTMZiYT9+JT9lMJxJOXFpEH
         nXRdr7Xp2OrnXlAWutqHPMv8xk5OzhrbLd9t/ZesIWK4FbXPTENHXZhbzNciolly3Buq
         YEoOzbWxbBmYGb4kdd4GYsFs+nVqc0iJHUbQXnhza0RU5liqjZ5xk2JdppNw4Lo7K1uj
         TSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=V1w5p8At+8zTrdz8NfvIJEZQzQMgB7370NwuSThERRY=;
        b=tzlMMptPNqf/L/01SzEClzXOqgL/oIWZ7v4gJfRr3gCaE2HxJNs4Yi8fu9R3ohyAt2
         sSibTb+Qmatq036h/2lYimcDlKZEYE/xJYHluLLh4fAjGg++jXXUyX85I//zUUKR9uxj
         GvBkksiwY9MG40Rdlgl8O4eN7XNnPIFXjT3lnbJGSR5h7/RtHCBGK4/P2y9nA5oitBH8
         6v8aCz4hxcuJG1IZCDi3Jc3pUHXw7nVqkyzP8uKGFy1NZl52b6pu4+WtMKr5sQmPtP0b
         AODfkxOymLP3+38OLttCo0m8vQrWNzO/nSE1YjtDWTBLbiWSwlmlZC1euP1iycGrItYq
         4jgw==
X-Gm-Message-State: AJcUukdQnFMpNr8eqak0U2/ZzzRDHGSxU2kpyTcj9qv0R+5wBqh1A/ay
        KjqzHVdk0NCL1AUUGCYXxVQ=
X-Google-Smtp-Source: ALg8bN75TWSWAXhGEpr8jtVs3OBQGhvhJfmBAD6OwMNIByZqN5tdOSi2blRG12xZBJSBK/8O46NCPg==
X-Received: by 2002:a2e:9a84:: with SMTP id p4-v6mr1780085lji.73.1546975801459;
        Tue, 08 Jan 2019 11:30:01 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:30:01 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Vincent Abriou <vincent.abriou@st.com>
Subject: [PATCH v3 10/12] drm/stm: do not reply on drmP.h from drm_gem_cma_helper.h
Date:   Tue,  8 Jan 2019 20:29:37 +0100
Message-Id: <20190108192939.15255-11-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108192939.15255-1-sam@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drmP.h was the only header file in the past and a lot
of files rely on that drmP.h defines everything.
The goal is to one day to delete drmP.h and
as a step towards this it will no longer be included in the
headers files in include/drm/

To prepare stm/ for this add dependencies that
othwewise was pulled in by drmP.h from drm_gem_cma_helper.h

Sort the include list when we anyway modify it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Yannick Fertre <yannick.fertre@st.com>
Cc: Philippe Cornu <philippe.cornu@st.com>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/stm/drv.c  | 6 +++++-
 drivers/gpu/drm/stm/ltdc.c | 9 ++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 8dec001b9d37..9cd6228a18ad 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -9,15 +9,19 @@
  */
 
 #include <linux/component.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
 #include <linux/of_platform.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_vblank.h>
 
 #include "ltdc.h"
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 61dd661aa0ac..5cce6c7f35d4 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -10,17 +10,24 @@
 
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
-#include <drm/drm_bridge.h>
+#include <drm/drm_vblank.h>
 #include <drm/drm_plane_helper.h>
 
 #include <video/videomode.h>
-- 
2.12.0

