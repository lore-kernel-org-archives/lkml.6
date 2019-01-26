Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C12C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE70F218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsoBzoZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfAZM0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:26:03 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46049 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfAZMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:25:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so8758587lfa.12;
        Sat, 26 Jan 2019 04:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BFaqgSrf9pfRKYLk0qxg5bh43bwOLeJ6IhgTX2pxQ9Y=;
        b=UsoBzoZ6A0WY08b2FrDhcq597W8x1Z4swx18Ilsd+RoZKO+8xDQKaI6O+YcRk1I0A2
         30k5UxPhV0v9hWkMuhlVk6D1ei8l8m6Hb3inagZ9rdI2DWQ4TZ6gMwchGdNDNI2+G5iG
         i0dCj8+L5fqiqTn5bwMdOpifoTo4P6FpsX/Zwo9QmLTjh6vxdXGepXIPRoTVdKihnUCw
         P9PupLPy9IT3jbQqyp8W5mLBo6c17u2aK1whEgJ5/RnDB4lr/aNsN+X/K3lJ6PNrp93U
         xlRho97Cjydc5rXPMarYThOdT6pAL1fzCADJXrUXn2LqWgyL8cr65+eoVvCp+80ykJyw
         aVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=BFaqgSrf9pfRKYLk0qxg5bh43bwOLeJ6IhgTX2pxQ9Y=;
        b=P4Vmj6NOY9Lwotsb0YGd11hDD92WVKombLBJuKpP1JQNC04ysmxIcn+TiizriGF/vU
         iAy8la02RMhOHwLcFM8XyHLrC5pEjGzr6VIeBYecAHHsJlR39i2igBmD8yTRcAz4ZunJ
         VfW3yvVtcJPN4llGmwmogHLdVE5uY6PDTj1Lt9v5lwc8YSHxUTFriE4p7mZaUKxi+soO
         VOgERgMtR35S19t7Tqi+A4pIG2BSfgh2fEaeUMpIINw6rzDqSlB6SdQsYpl4jpHbMg7e
         UzxVLRXSK022NkWYCpyg/WdiuaPAU61g/gtIhBHWUH7Jx7U69KvCGXEjVoIV5DLqiNoa
         p6Zw==
X-Gm-Message-State: AJcUukdg6mMyFJqj4asze6Uni5zEQpulCuTtSvxID4w9NiUxZT7kqNj0
        8jx9EZ9Ca+Pn9g6YZfuKVZ8=
X-Google-Smtp-Source: ALg8bN4F6uCtBEGQ6hs82I0SdG6RtSZbTnLM3p0QPyFJSmJxzIrWud7uSwLYoUej+/71rinOsgwh0g==
X-Received: by 2002:ac2:5382:: with SMTP id g2mr10899286lfh.159.1548505551576;
        Sat, 26 Jan 2019 04:25:51 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id j138sm2070288lfg.64.2019.01.26.04.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 04:25:51 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v6 2/5] drm/i915: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 26 Jan 2019 13:25:24 +0100
Message-Id: <20190126122527.11647-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190126122527.11647-1-sam@ravnborg.org>
References: <20190126122527.11647-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused i915 to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.

In the files touched the lists of include files was grouped
and sorted.

Build tested on x86 and arm allmodconfig / allyesconfig.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/i915_drv.c           |  4 +++-
 drivers/gpu/drm/i915/intel_atomic.c       |  2 ++
 drivers/gpu/drm/i915/intel_atomic_plane.c |  2 ++
 drivers/gpu/drm/i915/intel_display.c      | 29 ++++++++++++++++-------------
 drivers/gpu/drm/i915/intel_pm.c           |  7 +++++--
 5 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 9883921013b1..8c8f36a91e7e 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -41,8 +41,10 @@
 #include <linux/vt.h>
 #include <acpi/video.h>
 
-#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_irq.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/i915_drm.h>
 
 #include "i915_drv.h"
diff --git a/drivers/gpu/drm/i915/intel_atomic.c b/drivers/gpu/drm/i915/intel_atomic.c
index d8dbc9980281..f415ed239184 100644
--- a/drivers/gpu/drm/i915/intel_atomic.c
+++ b/drivers/gpu/drm/i915/intel_atomic.c
@@ -31,7 +31,9 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
+
 #include "intel_drv.h"
 
 /**
diff --git a/drivers/gpu/drm/i915/intel_atomic_plane.c b/drivers/gpu/drm/i915/intel_atomic_plane.c
index 683a75dad4fb..79139d496c78 100644
--- a/drivers/gpu/drm/i915/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/intel_atomic_plane.c
@@ -32,7 +32,9 @@
  */
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
+
 #include "intel_drv.h"
 
 struct intel_plane *intel_plane_alloc(void)
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 15d758cd0c1b..e0f40be07131 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -24,29 +24,32 @@
  *	Eric Anholt <eric@anholt.net>
  */
 
-#include <linux/module.h>
-#include <linux/input.h>
 #include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/intel-iommu.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/reservation.h>
 #include <linux/slab.h>
 #include <linux/vgaarb.h>
-#include <drm/drm_edid.h>
-#include "intel_drv.h"
-#include "intel_frontbuffer.h"
-#include <drm/i915_drm.h>
-#include "i915_drv.h"
-#include "i915_gem_clflush.h"
-#include "intel_dsi.h"
-#include "i915_trace.h"
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_dp_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_rect.h>
-#include <drm/drm_atomic_uapi.h>
-#include <linux/intel-iommu.h>
-#include <linux/reservation.h>
+#include <drm/i915_drm.h>
+
+#include "i915_drv.h"
+#include "i915_gem_clflush.h"
+#include "i915_trace.h"
+#include "intel_drv.h"
+#include "intel_dsi.h"
+#include "intel_frontbuffer.h"
 
 /* Primary plane formats for gen <= 3 */
 static const uint32_t i8xx_primary_formats[] = {
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 83b01cde8113..48c755dc895b 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -26,13 +26,16 @@
  */
 
 #include <linux/cpufreq.h>
+#include <linux/module.h>
 #include <linux/pm_runtime.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
+
 #include "i915_drv.h"
 #include "intel_drv.h"
 #include "../../../platform/x86/intel_ips.h"
-#include <linux/module.h>
-#include <drm/drm_atomic_helper.h>
 
 /**
  * DOC: RC6
-- 
2.12.0

