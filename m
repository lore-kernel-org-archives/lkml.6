Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47582C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037B5218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNuvsPnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeLZVFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:05:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41035 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeLZVEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:04:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so11513451lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXs58+S54CGTkV9v4MfzMQtZsLa5ZbnTK3QPc1SiXps=;
        b=gNuvsPnwajqsYoi2CjkEa4ZXx1U+AC2yda6FkdGCFE52/9RBrfAqFm2MGnZLMLDMJE
         YlhATs76sxIs+8fy28QbMpDz9vWCX3xOc/SQnYvVHMRNcFOvblsMb+KS+dOUjGWi33z+
         AHU4IhBbpf2sXecEp3bva+GpCxdEomxZrXgVuOMxK9Y+sdRye4S6OpPtlC6qc3ZfgyqJ
         qYgRIWv6hJqq3fKU7ap5Wy1LB6zhamcG+P7EUViJNlcPUR1f9MRalRL4l0RilymUH9cY
         owiPtP3pJmy3xbdx/VepnXpP+K7qgB/eLaWR6MuNRoBOXwvVOuvFfRMIqQmLWLjrdByB
         rfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lXs58+S54CGTkV9v4MfzMQtZsLa5ZbnTK3QPc1SiXps=;
        b=sxwlr7r/1gsfGxR32zs2MOxCvM+oqBf77JetDsgyK4qzyGU27O+xlp3xmxbC/9Nk0t
         vLnrG5eGLLDhvSRaUeLetRTDtAX/34FqWva+wq/MGivTvmtKmyuo9PzLjGH6Xmk7aOq6
         pWiE0xg7ll20g4f/FOXiIPJGZRON3rAp1lnxVsmL8jDi+C101gNUxhtCTSmp65/q6njo
         rA41yW3RRt6zGqXdSZYHUjUSIgD7aARTxl92vVLe12IHlKBjH80XQbZ8J9xbykNnNn74
         SAAHlQmAI773BHHUAbscExAl7xSXwIkwL/Ls00ibqFGMn+8OYymJMxBgLQJK28P89GT+
         mXiA==
X-Gm-Message-State: AA+aEWauoeIvTRIMjGAxEkvTIYJ+rUW/gWTfN/FPaGwXewpdQ/lCOgi4
        CdjV/kvgDBW1qWbkCuJvjs8ABN56UXY=
X-Google-Smtp-Source: AFSGD/V1kWBrltfOYiwGjQxUZagiSvFlxIjI1wHazOnTbGd9s8Iiq/Ubmavsk0wehwB5WrYH7Zs9/w==
X-Received: by 2002:a19:9653:: with SMTP id y80mr10596276lfd.66.1545858278165;
        Wed, 26 Dec 2018 13:04:38 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id g70-v6sm7768124ljg.92.2018.12.26.13.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 13:04:37 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v1 3/7] drm: move drm_can_sleep() to drm_util.h
Date:   Wed, 26 Dec 2018 22:03:49 +0100
Message-Id: <20181226210353.13993-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20181226210215.GA27610@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move drm_can_sleep() out of drmP.h to allow users
to get rid of the drmP.h include.

There was no header file that was a good match for this helper function.
So add this to drm_util with the relevant includes.

Add include of drm_util.h to all users.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/amd/amdgpu/atom.c               |  2 ++
 drivers/gpu/drm/ast/ast_fb.c                    |  1 +
 drivers/gpu/drm/cirrus/cirrus_fbdev.c           |  1 +
 drivers/gpu/drm/drm_flip_work.c                 |  1 +
 drivers/gpu/drm/mgag200/mgag200_fb.c            |  1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c        |  1 +
 drivers/gpu/drm/omapdrm/omap_fbdev.c            |  1 +
 drivers/gpu/drm/qxl/qxl_cmd.c                   |  2 ++
 drivers/gpu/drm/radeon/atom.c                   |  2 ++
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c |  1 +
 drivers/gpu/drm/vc4/vc4_drv.h                   |  1 +
 include/drm/drmP.h                              |  8 --------
 include/drm/drm_util.h                          | 13 +++++++++++++
 13 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e9934de1b9cf..dd30f4e61a8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -27,6 +27,8 @@
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 
+#include <drm/drm_util.h>
+
 #define ATOM_DEBUG
 
 #include "atom.h"
diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
index de26df0c6044..fb56fe848e81 100644
--- a/drivers/gpu/drm/ast/ast_fb.c
+++ b/drivers/gpu/drm/ast/ast_fb.c
@@ -38,6 +38,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_util.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include "ast_drv.h"
diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index 68ab1821e15b..1544fa55d1ff 100644
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
@@ -10,6 +10,7 @@
  */
 #include <linux/module.h>
 #include <drm/drmP.h>
+#include <drm/drm_util.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 
diff --git a/drivers/gpu/drm/drm_flip_work.c b/drivers/gpu/drm/drm_flip_work.c
index 12dea16f22a8..3da3bf5af405 100644
--- a/drivers/gpu/drm/drm_flip_work.c
+++ b/drivers/gpu/drm/drm_flip_work.c
@@ -22,6 +22,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_util.h>
 #include <drm/drm_flip_work.h>
 
 /**
diff --git a/drivers/gpu/drm/mgag200/mgag200_fb.c b/drivers/gpu/drm/mgag200/mgag200_fb.c
index 30726c9fe28c..6893934b26c0 100644
--- a/drivers/gpu/drm/mgag200/mgag200_fb.c
+++ b/drivers/gpu/drm/mgag200/mgag200_fb.c
@@ -12,6 +12,7 @@
  */
 #include <linux/module.h>
 #include <drm/drmP.h>
+#include <drm/drm_util.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
index 96c2b828dba4..fa2d1d8995ee 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
@@ -16,6 +16,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <drm/drm_util.h>
 
 #include "mdp5_kms.h"
 #include "mdp5_smp.h"
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index aee99194499f..851c59f07eb1 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -16,6 +16,7 @@
  */
 
 #include <drm/drm_crtc.h>
+#include <drm/drm_util.h>
 #include <drm/drm_fb_helper.h>
 
 #include "omap_drv.h"
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 208af9f37914..d17676824377 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -25,6 +25,8 @@
 
 /* QXL cmd/ring handling */
 
+#include <drm/drm_util.h>
+
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/atom.c
index e55cbeee7a53..ac98ad561870 100644
--- a/drivers/gpu/drm/radeon/atom.c
+++ b/drivers/gpu/drm/radeon/atom.c
@@ -27,6 +27,8 @@
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 
+#include <drm/drm_util.h>
+
 #define ATOM_DEBUG
 
 #include "atom.h"
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
index 222a1fa41d7c..7e3257e8fd56 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
@@ -24,6 +24,7 @@
  *          Alex Deucher
  */
 #include <drm/drmP.h>
+#include <drm/drm_util.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/radeon_drm.h>
 #include "radeon.h"
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index bd6ef1f31822..79c6bcc4f509 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -9,6 +9,7 @@
 #include <linux/mm_types.h>
 #include <linux/reservation.h>
 #include <drm/drmP.h>
+#include <drm/drm_util.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_atomic.h>
diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index 2ba786820052..a77c9ee43b68 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -95,12 +95,4 @@ struct dma_buf_attachment;
 struct pci_dev;
 struct pci_controller;
 
-/* returns true if currently okay to sleep */
-static inline bool drm_can_sleep(void)
-{
-	if (in_atomic() || in_dbg_master() || irqs_disabled())
-		return false;
-	return true;
-}
-
 #endif
diff --git a/include/drm/drm_util.h b/include/drm/drm_util.h
index 88abdca89baa..e3200980d3f3 100644
--- a/include/drm/drm_util.h
+++ b/include/drm/drm_util.h
@@ -26,7 +26,20 @@
 #ifndef _DRM_UTIL_H_
 #define _DRM_UTIL_H_
 
+#include <linux/irqflags.h>
+#include <linux/preempt.h>
+#include <linux/kgdb.h>
+#include <linux/smp.h>
+
 /* helper for handling conditionals in various for_each macros */
 #define for_each_if(condition) if (!(condition)) {} else
 
+/* returns true if currently okay to sleep */
+static inline bool drm_can_sleep(void)
+{
+	if (in_atomic() || in_dbg_master() || irqs_disabled())
+		return false;
+	return true;
+}
+
 #endif
-- 
2.12.0

