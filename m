Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48659C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FB72147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBTVDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:03:48 -0500
Received: from anholt.net ([50.246.234.109]:51828 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBTVDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:03:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4F0F210A2D26;
        Wed, 20 Feb 2019 13:03:47 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 5a4DkhjWXFMG; Wed, 20 Feb 2019 13:03:45 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D2A1E10A2D1E;
        Wed, 20 Feb 2019 13:03:44 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 9542E2FE464C; Wed, 20 Feb 2019 13:03:43 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/7] drm: Add a helper function for printing a debugfs_regset32.
Date:   Wed, 20 Feb 2019 13:03:37 -0800
Message-Id: <20190220210343.28157-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_regset32 is nice to use for reducing boilerplate in
dumping a bunch of regs in debugfs, but we also want to be able to
print to dmesg them at runtime for driver debugging.  drm_printer lets
us format debugfs and the printk the same way.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/drm_print.c | 16 ++++++++++++++++
 include/drm/drm_print.h     |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 0e7fc3e7dfb4..5ecc0f04cd0c 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -253,3 +253,19 @@ void drm_err(const char *format, ...)
 	va_end(args);
 }
 EXPORT_SYMBOL(drm_err);
+
+void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset)
+{
+	int namelen = 0;
+	int i;
+
+	for (i = 0; i < regset->nregs; i++)
+		namelen = max(namelen, (int)strlen(regset->regs[i].name));
+
+	for (i = 0; i < regset->nregs; i++) {
+		drm_printf(p, "%*s = 0x%08x\n",
+			   namelen, regset->regs[i].name,
+			   readl(regset->base + regset->regs[i].offset));
+	}
+}
+EXPORT_SYMBOL(drm_print_regset32);
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index afbc3beef089..3a4247319e63 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -30,6 +30,7 @@
 #include <linux/printk.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
+#include <linux/debugfs.h>
 
 /**
  * DOC: print
@@ -84,6 +85,7 @@ void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf);
 __printf(2, 3)
 void drm_printf(struct drm_printer *p, const char *f, ...);
 void drm_puts(struct drm_printer *p, const char *str);
+void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset);
 
 __printf(2, 0)
 /**
-- 
2.20.1

