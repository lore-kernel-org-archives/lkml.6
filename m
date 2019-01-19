Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A559EC636A1
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A3F2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arjsBqa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfASIky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:40:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33962 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfASIkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:40:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so12215318lfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 00:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t4gO5DVMANH5E+Sbju7OOPAWMqUw7l2Z+75E0VcRtJI=;
        b=arjsBqa6Q78ZmdAXceEdbPfSv2t5cuV7Ll5grTVWjIGE2AqDMMEtzst0hEyu30FOgt
         ixfyaJFadolrsfsm9Z2WT00lXApQ1lX/OtWsAAVC64ATvsKQqcDLzPhJsuepaG2I9u1h
         a/Ex9sW9l83sPtamWY3D/vkUBFNKkzCKx8QGKLVXV6S2ttrr1M+0C2j9TaZ5l86+1t0j
         cu5PpSVrm2ApLzgm+HBRQf8VAtMHCMwBs81Wmgel4CA7yDDOUGnXnN/F6gekdn+0coI4
         7OUd49jb1yYt4vxM9WIOW5ygDhiGl/0sXy7v+FCXqlVQIrh4un2K6ryP6DHQ52GAxVd0
         AaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=t4gO5DVMANH5E+Sbju7OOPAWMqUw7l2Z+75E0VcRtJI=;
        b=qABHyJ4/hUC1Uskil3/wAXyFGsTti+pDqu0w13J6fM/E5pIGpxg9v3rikf8aW9NADd
         Vn37f0CHX9khV5qEXa8zZt/UX/cGOI3SHRDO6Y9+nJWxTE9mhYxs8fcXK3V49XV2OwTe
         XhSThnr+5KPIxgwLuxlwp98Y25sdp3W9lYLNi2T0CmulAd99z1vDPMuR9AX1zxZv8+Hu
         vQTiWFUk+ES0mqc+c5eISpQ/Bj3xiSLPc+Y1YKPQE7gFAq5n07mi/8HDtbVDOmjYDR0/
         LZhV70GJJpbK4yfHNDKmMyZCsZSPuYgQsbuUlWwy+DE3szOfFb4oCflrHrkerok4CBGQ
         Z9vQ==
X-Gm-Message-State: AJcUukdfpGoaQKXBXGRY1mvmbadFfwgrJYnNXDUfdTOAWUGjEIoMvRUA
        fq6FhHvTeKr2/rcXPVkZaJQ=
X-Google-Smtp-Source: ALg8bN55DDUoBJT1Ua154+F3PXzBhZBxCKFDwdswvrLSVYZE4HO68tLVg1hWoa/VqQfALGg/vnRPWA==
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr14056081lfa.49.1547887246008;
        Sat, 19 Jan 2019 00:40:46 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id p23sm1187109lfh.47.2019.01.19.00.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 00:40:45 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] drm: remove drmP.h from drm_modeset_helper.h
Date:   Sat, 19 Jan 2019 09:40:14 +0100
Message-Id: <20190119084014.5355-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190119084014.5355-1-sam@ravnborg.org>
References: <20190119084014.5355-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the removal of drmP.h from drm_modeset_helper.h
the drmP.h are no longer included by any include files
in include/drm.
The drmP.h file is thus only included explicit
either in .c files or in local .h files.
This makes the process of deleting the drmP.h includes easier
as we have a more local dependency chain.

Include build failure fixes in drm files after the drmP.h removal.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_damage_helper.c  | 1 +
 drivers/gpu/drm/drm_modeset_helper.c | 2 ++
 include/drm/drm_modeset_helper.h     | 6 +++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index e16aa5ae00b4..ee67c96841fa 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -32,6 +32,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_damage_helper.h>
+#include <drm/drm_device.h>
 
 /**
  * DOC: overview
diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index 9150fa385bba..9bc1ef788c77 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -23,8 +23,10 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_print.h>
 
 /**
  * DOC: aux kms helpers
diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
index efa337f03129..995fd981cab0 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -23,7 +23,11 @@
 #ifndef __DRM_KMS_HELPER_H__
 #define __DRM_KMS_HELPER_H__
 
-#include <drm/drmP.h>
+struct drm_crtc;
+struct drm_crtc_funcs;
+struct drm_device;
+struct drm_framebuffer;
+struct drm_mode_fb_cmd2;
 
 void drm_helper_move_panel_connectors_to_head(struct drm_device *);
 
-- 
2.12.0

