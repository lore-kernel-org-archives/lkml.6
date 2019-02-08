Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489D2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A79920821
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBHKDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:03:00 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:52022 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfBHKDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:03:00 -0500
Received: from localhost.localdomain (85-76-102-43-nat.elisa-mobile.fi [85.76.102.43])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 85657B0005;
        Fri,  8 Feb 2019 12:02:56 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH v2] panic/reboot: allow specifying reboot_mode for panic only
Date:   Fri,  8 Feb 2019 12:02:49 +0200
Message-Id: <20190208100249.15237-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

Allow specifying reboot_mode for panic only. This is needed on systems
where ramoops is used to store panic logs, and user wants to use warm
reset to preserve those, while still having cold reset on normal reboots.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---

	v2: Use REBOOT_UNDEFINED instead of -1

	v1: https://marc.info/?t=154957416600005&r=1&w=2

 .../admin-guide/kernel-parameters.txt         |  4 +++-
 include/linux/reboot.h                        |  2 ++
 kernel/panic.c                                |  2 ++
 kernel/reboot.c                               | 20 ++++++++++++++-----
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf67d7b..033c93048a95 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3950,7 +3950,9 @@
 				[[,]s[mp]#### \
 				[[,]b[ios] | a[cpi] | k[bd] | t[riple] | e[fi] | p[ci]] \
 				[[,]f[orce]
-			Where reboot_mode is one of warm (soft) or cold (hard) or gpio,
+			Where reboot_mode is one of warm (soft) or cold (hard) or gpio
+					(prefix with 'panic_' to set mode for panic
+					reboot only),
 			      reboot_type is one of bios, acpi, kbd, triple, efi, or pci,
 			      reboot_force is either force or not specified,
 			      reboot_cpu is s[mp]#### with #### being the processor
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index e63799a6e895..1c4c8a47e2de 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -19,8 +19,10 @@ enum reboot_mode {
 	REBOOT_HARD,
 	REBOOT_SOFT,
 	REBOOT_GPIO,
+	REBOOT_UNDEFINED = -1,
 };
 extern enum reboot_mode reboot_mode;
+extern enum reboot_mode panic_reboot_mode;
 
 enum reboot_type {
 	BOOT_TRIPLE	= 't',
diff --git a/kernel/panic.c b/kernel/panic.c
index f121e6ba7e11..a0d839f883b7 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -306,6 +306,8 @@ void panic(const char *fmt, ...)
 		 * shutting down.  But if there is a chance of
 		 * rebooting the system it will be rebooted.
 		 */
+		if (panic_reboot_mode != REBOOT_UNDEFINED)
+			reboot_mode = panic_reboot_mode;
 		emergency_restart();
 	}
 #ifdef __sparc__
diff --git a/kernel/reboot.c b/kernel/reboot.c
index e1b79b6a2735..b9e79e8c7226 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -31,6 +31,7 @@ EXPORT_SYMBOL(cad_pid);
 #define DEFAULT_REBOOT_MODE
 #endif
 enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
+enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
 
 /*
  * This variable is used privately to keep track of whether or not
@@ -519,6 +520,8 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
 static int __init reboot_setup(char *str)
 {
 	for (;;) {
+		enum reboot_mode *mode;
+
 		/*
 		 * Having anything passed on the command line via
 		 * reboot= will cause us to disable DMI checking
@@ -526,17 +529,24 @@ static int __init reboot_setup(char *str)
 		 */
 		reboot_default = 0;
 
+		if (!strncmp(str, "panic_", 6)) {
+			mode = &panic_reboot_mode;
+			str += 6;
+		} else {
+			mode = &reboot_mode;
+		}
+
 		switch (*str) {
 		case 'w':
-			reboot_mode = REBOOT_WARM;
+			*mode = REBOOT_WARM;
 			break;
 
 		case 'c':
-			reboot_mode = REBOOT_COLD;
+			*mode = REBOOT_COLD;
 			break;
 
 		case 'h':
-			reboot_mode = REBOOT_HARD;
+			*mode = REBOOT_HARD;
 			break;
 
 		case 's':
@@ -553,11 +563,11 @@ static int __init reboot_setup(char *str)
 				if (rc)
 					return rc;
 			} else
-				reboot_mode = REBOOT_SOFT;
+				*mode = REBOOT_SOFT;
 			break;
 		}
 		case 'g':
-			reboot_mode = REBOOT_GPIO;
+			*mode = REBOOT_GPIO;
 			break;
 
 		case 'b':
-- 
2.17.0

