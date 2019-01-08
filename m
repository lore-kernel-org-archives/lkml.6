Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB48C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A662D20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b50pBJjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfAHTaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:30:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38023 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfAHT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so4416152lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10cHjW1LdR9XR6PMLJGqRMqK0MKdEg2mGiU47GHXUlA=;
        b=b50pBJjTdJujlgOWiYCRa/O4UrRdrpMvbBxczudRuuHxXBDuon0GIBu5c7+57fO9Nj
         8+wpkUdodflf35VJDfRRJKfo65y/yAPkbVV2mvaoseAkGpT211PfzdhAVBXBQRVDg3Ip
         Gvz7WeqFC45T4BVH1Wm/AdJD6J/3c0QVD1+aGwrShkeihif7BKR8Wc+Bn3k7E/tN1oic
         AMVZ+a1BRujBMZ/NtmwtE7ODvfMmA8QbH5FJG2p2dqn8VyF7Pg/gN/dksAHgnJXqQL1F
         cj3FgpOSdkQGFTaLvo6rOxrBkP1sqHPa4VSE/4KGLjpgstAnnGcAuotQiWNUT7m4z2Jg
         /Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=10cHjW1LdR9XR6PMLJGqRMqK0MKdEg2mGiU47GHXUlA=;
        b=JAriD5dP5dDBoAAID5etXupvF8KpSb0T9IvXAnt8f3iOi2tJLFO0Zx15gmZyBeMh6D
         +YmmJHcR8LqxfBEZ78vI5nYXZIxKU22mvfj1l5FQ56paLXnRABU6EWO2ATaWGXgT9G6a
         KkFUFXVvB9TcxJMlkZ2liIPFOA961Y8GGFpagikcH2MFJtAQnXQBsXJKuiscnSlg1sRM
         4oSVmsr90oq6zFN+Z/UxDRD+nm86SmkHtTzzE4OVR/SbrRQ8Zs0UzPojgfpx/uME8UTO
         146sd8gzvq8Xkxrzhj2pf9qI3uMOUPbtWoX0XKUSV/9qoXOsr6lvGuNfmwXL7afyBznT
         /xsg==
X-Gm-Message-State: AJcUukd1JrPUotGdGKGwhaddmwRKDzyHRV1Pr6l4WVbCVfk8nmC2poSX
        LCvHKF0Ndv52pS6Lsz1METY=
X-Google-Smtp-Source: ALg8bN7QEOmjgqjrV9FK109xyU/XVO2cQ07iTh2pETTjz5WzfFML5GSQ3uIFI5iKV0GOetB5VirTGA==
X-Received: by 2002:a2e:9017:: with SMTP id h23-v6mr1559349ljg.71.1546975795016;
        Tue, 08 Jan 2019 11:29:55 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:29:54 -0800 (PST)
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
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v3 04/12] drm: move drm_can_sleep() to drm_util.h
Date:   Tue,  8 Jan 2019 20:29:31 +0100
Message-Id: <20190108192939.15255-5-sam@ravnborg.org>
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

Move drm_can_sleep() out of drmP.h to allow users
to get rid of the drmP.h include.

There was no header file that was a good match for this helper function.
So add this to drm_util with the relevant includes.

Update comments to use kernel-doc style.
Add FIXME to drm_can_sleep and add note
that this function should not be used in new code

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
 drivers/gpu/drm/ast/ast_fb.c                    |  2 ++
 drivers/gpu/drm/cirrus/cirrus_fbdev.c           |  1 +
 drivers/gpu/drm/drm_flip_work.c                 |  1 +
 drivers/gpu/drm/mgag200/mgag200_fb.c            |  1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c        |  1 +
 drivers/gpu/drm/omapdrm/omap_fbdev.c            |  1 +
 drivers/gpu/drm/qxl/qxl_cmd.c                   |  2 ++
 drivers/gpu/drm/radeon/atom.c                   |  2 ++
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c |  1 +
 drivers/gpu/drm/vc4/vc4_drv.h                   |  1 +
 include/drm/drmP.h                              |  8 -----
 include/drm/drm_util.h                          | 42 ++++++++++++++++++++++++-
 13 files changed, 56 insertions(+), 9 deletions(-)

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
index a80bca1a857f..eb66bf7d3e63 100644
--- a/drivers/gpu/drm/ast/ast_fb.c
+++ b/drivers/gpu/drm/ast/ast_fb.c
@@ -39,7 +39,9 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_util.h>
 #include <drm/drm_crtc_helper.h>
+
 #include "ast_drv.h"
 
 static void ast_dirty_update(struct ast_fbdev *afbdev,
diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index 4dd499c7d1ba..79fea1b8bc14 100644
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
index dffc5093ff16..2e100f644236 100644
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
index c24b078f0593..2c635f001c71 100644
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
index 9e47c8dc6b87..bc4cb3732407 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -94,14 +94,6 @@ struct dma_buf_attachment;
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
 #if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
 #define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
 #else
diff --git a/include/drm/drm_util.h b/include/drm/drm_util.h
index 88abdca89baa..8fda5777471c 100644
--- a/include/drm/drm_util.h
+++ b/include/drm/drm_util.h
@@ -26,7 +26,47 @@
 #ifndef _DRM_UTIL_H_
 #define _DRM_UTIL_H_
 
-/* helper for handling conditionals in various for_each macros */
+/**
+ * DOC: drm utils
+ *
+ * Macros and inline functions that does not naturally belong in other places
+ */
+
+#include <linux/irqflags.h>
+#include <linux/preempt.h>
+#include <linux/kgdb.h>
+#include <linux/smp.h>
+
+/**
+ * for_each_if - helper for handling conditionals in various for_each macros
+ * @condition The condition to check
+ *
+ * Typical use:
+ * #define for_each_foo_bar(x, y) \
+ *	list_for_each_entry(x, y->list, head) \
+ *		for_each_if(x->something == SOMETHING)
+ *
+ * The for_each_if() macro makes the use of for_each_foo_bar() less error
+ * prone.
+ */
 #define for_each_if(condition) if (!(condition)) {} else
 
+/**
+ * drm_can_sleep - returns true if currently okay to sleep
+ *
+ * This function shall not be used in new code.
+ * The check for running in atomic context may not work - see linux/preempt.h.
+ *
+ * FIXME: All users of drm_can_sleep should be removed (see todo.rst)
+ *
+ * Returns:
+ * True if kgdb is active or we are in an atomic context or irqs are disabled
+ */
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

