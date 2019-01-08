Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B34C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB84620827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnUZhqHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfAHTaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:30:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40645 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbfAHT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so4415672lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0kVbErTVxLQ/iwOaPUKS8AqQHff1RBfk92A+KhzaWwA=;
        b=fnUZhqHUta3we1lQ6wLXCAheExq4QFGDVWBuZBll8UUkBTxFMER9FffWbw9kbyU58R
         oA4jYVANdbDVgisYMxBUsX37Nsib+jP/5SUg3m3ipW19CJqo1AwrIMxxRSR9a4ljQ6O+
         kC+lacRfMbVUJRY6w9nyhbqzgqNgjh9Y1FwYm6QCZxkLx2iGDoxYbj7Szuovon/TrLzR
         TJmWNCtXNg3U44TSCGqS8jCelZxia13s6XDrIHFYK6rNiFRpJpOkFMytg7sHHH3yn8T8
         moG4A3Ii8TFdiridCpV77KsEk8YcPQ0pauJogRZAA896/KRqHiflfQOLAmHPCG6YVcK+
         GyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=0kVbErTVxLQ/iwOaPUKS8AqQHff1RBfk92A+KhzaWwA=;
        b=cWckPEN4J0bd1CJcHvk2uBwwzt97w6eCczQYx12Nfu43vqssJotQV1BrKEVrhalujw
         GGjjubUefkYVK4/UU19na+4CpfAfC8TpSONhRh/A5rzAWxxKrQM3Xv8Eddnrz355LWWM
         f2NyHFAGF7Pljoq8yowbhy1w0GVT2V8dHSgVKmoo86gAY+IAtpEaL+yAmvvLcuky64TC
         Ks96QyQOFHvJs6OURMJtTfAJzCPA+C5skqA0LFtDI/FEwZF5lhbieZY4sHebUzJA1AaZ
         jyp9MNBzBp94cmk0zaWDL+SyqeqsShaT5EJbiSO/Q0KLGppcKKBq0bmbxRWYhgGgSyXp
         iVaA==
X-Gm-Message-State: AJcUukewIEFaNCgWUhxzY4t/5UJ2gPBJgBFNjsWM1wpNXgGv3W0Mhx24
        fuulqt5griae0Vq4menSsc4=
X-Google-Smtp-Source: ALg8bN5TRm02o0HUoxFfZ66gENM1ecngBvAvaap1geQMbBMLVFkfKSY++B2bmaUhmrrJzyg3wboEJw==
X-Received: by 2002:a2e:6f11:: with SMTP id k17-v6mr1760443ljc.94.1546975796048;
        Tue, 08 Jan 2019 11:29:56 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:29:55 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 05/12] drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h
Date:   Tue,  8 Jan 2019 20:29:32 +0100
Message-Id: <20190108192939.15255-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108192939.15255-1-sam@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
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

