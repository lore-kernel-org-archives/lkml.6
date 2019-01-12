Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90C3206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQAWHWFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfALTdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:33:44 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:36263 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfALTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:33:39 -0500
Received: by mail-lf1-f43.google.com with SMTP id a16so13104969lfg.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 11:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DmHCFAUu/pBFAsmLrDnwT7OwyRz5yIYvDacbpvrFIl8=;
        b=dQAWHWFmWhpGVEPVIizwhhW9ve7F5Of8TkPVuLhYB5um/+TS2l/ESINC4dHoueTTPW
         +6PgehZHEIb9VLMnp5SRjz+egIudoqaSMPDYXVjvMl1ljgwbCSStzcsd4HVtZy1ALZKg
         ak/20QQPWm+L17BOpBMkQvCW/M+s//Ktc4NLzHAfDL2Gwk7Ph7+EcgOi089nwUBOY2wm
         v1QV9V7DS6imOFgTjSgYHH3UNBu5w23DAQ/SRYy1ClVpmdO6eHfp1/cMzCqnoB9yGDty
         OE+8/8N7V1XqNHG3I/W9ObRg2Q8eZlllgwylZOfj8v7dnRhXgI5s48WwqWhYrRwGBNrL
         5Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=DmHCFAUu/pBFAsmLrDnwT7OwyRz5yIYvDacbpvrFIl8=;
        b=t8peh595DmfR/wMbL/0MtSWJPpIDsX35B1vD8NJ670XNo0LgK+kBk0uHLZgpZRqqQC
         4Syt25iUpQxU/7iMHrknJ9qUSuWOc8zt89HYm2zzp/cQIYylIqtYszYnxq/NpLnYhcdk
         D7CpSaZM8KT6TZ+HlvSeh1xfiJicxiD2DCRzh2T7TWaW1xQ5SGk8UzQW4thtM+izd9Ez
         SEplh2Y8/VPtUr3HDXhdIuG9oYs2aQTPailoqBHNKeqXJ1Gyl9YogKuMw/3z+qio4tlV
         6TcG8jdT/zN0IZkdZPaBt4O/oFOH5lAZcetnZDGKuj4Yz3fKPQX+OTteIXvASovZ1u5k
         fA2w==
X-Gm-Message-State: AJcUukeLopG3GyGCm6sLCwknaVCj9ptnqfWUv1Ckxo1dx7HKoiBpEp8c
        J5Q9ZLZ2dTM5os9aE3W8f7Q=
X-Google-Smtp-Source: ALg8bN5ezhtzYluOnxpu4vb1sh7GmQsbr7RmPRtoGccLtbfP95Z6Wwd9yL/3ou1LCySvcw11c70fGA==
X-Received: by 2002:a19:d619:: with SMTP id n25mr9929466lfg.91.1547321617485;
        Sat, 12 Jan 2019 11:33:37 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id d82sm15624452lfd.82.2019.01.12.11.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 11:33:37 -0800 (PST)
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
Subject: [PATCH v4 8/8] drm: remove drmP.h from drm_modeset_helper.h
Date:   Sat, 12 Jan 2019 20:32:51 +0100
Message-Id: <20190112193251.20450-9-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190112193251.20450-1-sam@ravnborg.org>
References: <20190112193251.20450-1-sam@ravnborg.org>
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

Include build failures fixes in drm files after the drmP.h removal.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
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
index 31032407254d..b575a768f51c 100644
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

