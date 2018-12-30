Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD4DC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D33420866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWAhZQhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeL3RtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41706 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbeL3RtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so22332227ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=0kVbErTVxLQ/iwOaPUKS8AqQHff1RBfk92A+KhzaWwA=;
        b=vWAhZQhlXp089zaoIc7JlFRnZlf0klLjC7wae0o47HrhVQHMI/7ZoQ8eG/syFYQHun
         wbRXMap2QocgSL1Ajd9Obt6NldNCogv71edJ5mlTPwqa81o1pgI4iEDf3xdNGBIKpe+6
         gN+D499K7G6P31KIuxzMY4ic9Ak5oT6CIE5PGVRD0CCLMEm3NUijhKyuYbLAPpYrm+5z
         fuxAsc8AJ/AeR6NZxozbmIFKD9UHpyWyk/peDHOCvc943HrY1wl2UGWGWo4vpnvfQEKH
         Q+qiIxjvWAQCoL82DGMwkc5dvAHwVVN2yu+sHOQ0rPu45YjszcpOkqUEg2OOHUN4ufvV
         7MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=0kVbErTVxLQ/iwOaPUKS8AqQHff1RBfk92A+KhzaWwA=;
        b=kjhu/0d3dOgtHpBHNcdNi1R2aOzjaaNbwKT0c+GdcROTAnnZxsYHaQBlVHTPHwjijd
         CgpcrTrVTiPEPLvLXZBNUk1qkPB7X8ZF/vSZ3S5HgdfV2rNHyt00tfYKDIoWPHwm5NtL
         VQ4jXFoVMQuh8nF4bZYV89jmKc21A6W7YxXJNLhWWcu54U9hgeQxz7Tpov5O5AjLJ6St
         nDvBSCGSEooVIBYg63S3ca0jymFvNYrb7tjMT/mdbRpMWGgNRL5rf5WXe8gBJdVV3zI3
         tFK7Ued1ICyaleJ5jqcjqx14GhOlf0vxXYvDJ5l/FKeRXn/JCuDdVnRsO6rgSuRS5HNh
         i4Qw==
X-Gm-Message-State: AJcUukexI1HXT447qO8QHS5RNAbsrGZ8sedFar0AhrH5uNUTauxhwPAG
        9xnss6Kor4rdBUj8RU2oh5Y=
X-Google-Smtp-Source: ALg8bN7MchSEfKjnkwcfwzIWrT8RM58DVFIrivVvLfGs6BuynWZvfQSawhhBq/rKse7LTaDLfx19qg==
X-Received: by 2002:a2e:3803:: with SMTP id f3-v6mr19888571lja.169.1546192144105;
        Sun, 30 Dec 2018 09:49:04 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:49:03 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 07/14] drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h
Date:   Sun, 30 Dec 2018 18:48:31 +0100
Message-Id: <20181230174838.32330-8-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to get rid of drmP.h move the newly
added EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h.
Fix the single user.

Add a note to drmP.h to avoid further use of it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_framebuffer.c |  1 +
 include/drm/drmP.h                | 11 ++++++-----
 include/drm/drm_util.h            | 10 ++++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index fcaea8f50513..7abcb265a108 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -27,6 +27,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_print.h>
+#include <drm/drm_util.h>
 
 #include "drm_internal.h"
 #include "drm_crtc_internal.h"
diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index bc4cb3732407..3f5c577c9dbd 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -94,10 +94,11 @@ struct dma_buf_attachment;
 struct pci_dev;
 struct pci_controller;
 
-#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
-#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
-#else
-#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
-#endif
+/*
+ * NOTE: drmP.h is obsolete - do NOT add anything to this file
+ *
+ * Do not include drmP.h in new files.
+ * Work is ongoing to remove drmP.h includes from existing files
+ */
 
 #endif
diff --git a/include/drm/drm_util.h b/include/drm/drm_util.h
index 8fda5777471c..cd1e4be1dfb3 100644
--- a/include/drm/drm_util.h
+++ b/include/drm/drm_util.h
@@ -37,6 +37,16 @@
 #include <linux/kgdb.h>
 #include <linux/smp.h>
 
+/*
+ * Use EXPORT_SYMBOL_FOR_TESTS_ONLY() for functions that shall
+ * only be visible for drmselftests.
+ */
+#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
+#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
+#else
+#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
+#endif
+
 /**
  * for_each_if - helper for handling conditionals in various for_each macros
  * @condition The condition to check
-- 
2.12.0

