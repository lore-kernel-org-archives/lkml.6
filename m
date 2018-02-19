Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbeBSXxw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:53:52 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40451 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932278AbeBSXxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:53:24 -0500
X-Google-Smtp-Source: AH8x2240/NfaSL4J2pGuqCK69LhUpKv/opA2y3hAcPWfTouM/1y6g4D2x9Hoq+4yJFMbLhzL4vDCSg==
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 1/3] taint: Convert to indexed initialization
Date: Mon, 19 Feb 2018 15:53:08 -0800
Message-Id: <1519084390-43867-2-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519084390-43867-1-git-send-email-keescook@chromium.org>
References: <1519084390-43867-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts to using indexed initializers instead of comments, adds a
comment on why the taint flags can't be an enum, and make sure that no one
forgets to update the taint_flags when adding new bits.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kernel.h |  1 +
 kernel/panic.c         | 36 +++++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index ce51455e2adf..62fa060a6e1a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -533,6 +533,7 @@ extern enum system_states {
 	SYSTEM_RESTART,
 } system_state;
 
+/* This cannot be an enum because some may be used in assembly source. */
 #define TAINT_PROPRIETARY_MODULE	0
 #define TAINT_FORCED_MODULE		1
 #define TAINT_CPU_OUT_OF_SPEC		2
diff --git a/kernel/panic.c b/kernel/panic.c
index 2cfef408fec9..c5e0fd5a188e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -308,23 +308,23 @@ EXPORT_SYMBOL(panic);
  * is being removed anyway.
  */
 const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
-	{ 'P', 'G', true },	/* TAINT_PROPRIETARY_MODULE */
-	{ 'F', ' ', true },	/* TAINT_FORCED_MODULE */
-	{ 'S', ' ', false },	/* TAINT_CPU_OUT_OF_SPEC */
-	{ 'R', ' ', false },	/* TAINT_FORCED_RMMOD */
-	{ 'M', ' ', false },	/* TAINT_MACHINE_CHECK */
-	{ 'B', ' ', false },	/* TAINT_BAD_PAGE */
-	{ 'U', ' ', false },	/* TAINT_USER */
-	{ 'D', ' ', false },	/* TAINT_DIE */
-	{ 'A', ' ', false },	/* TAINT_OVERRIDDEN_ACPI_TABLE */
-	{ 'W', ' ', false },	/* TAINT_WARN */
-	{ 'C', ' ', true },	/* TAINT_CRAP */
-	{ 'I', ' ', false },	/* TAINT_FIRMWARE_WORKAROUND */
-	{ 'O', ' ', true },	/* TAINT_OOT_MODULE */
-	{ 'E', ' ', true },	/* TAINT_UNSIGNED_MODULE */
-	{ 'L', ' ', false },	/* TAINT_SOFTLOCKUP */
-	{ 'K', ' ', true },	/* TAINT_LIVEPATCH */
-	{ 'X', ' ', true },	/* TAINT_AUX */
+	[ TAINT_PROPRIETARY_MODULE ]	= { 'P', 'G', true },
+	[ TAINT_FORCED_MODULE ]		= { 'F', ' ', true },
+	[ TAINT_CPU_OUT_OF_SPEC ]	= { 'S', ' ', false },
+	[ TAINT_FORCED_RMMOD ]		= { 'R', ' ', false },
+	[ TAINT_MACHINE_CHECK ]		= { 'M', ' ', false },
+	[ TAINT_BAD_PAGE ]		= { 'B', ' ', false },
+	[ TAINT_USER ]			= { 'U', ' ', false },
+	[ TAINT_DIE ]			= { 'D', ' ', false },
+	[ TAINT_OVERRIDDEN_ACPI_TABLE ]	= { 'A', ' ', false },
+	[ TAINT_WARN ]			= { 'W', ' ', false },
+	[ TAINT_CRAP ]			= { 'C', ' ', true },
+	[ TAINT_FIRMWARE_WORKAROUND ]	= { 'I', ' ', false },
+	[ TAINT_OOT_MODULE ]		= { 'O', ' ', true },
+	[ TAINT_UNSIGNED_MODULE ]	= { 'E', ' ', true },
+	[ TAINT_SOFTLOCKUP ]		= { 'L', ' ', false },
+	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
+	[ TAINT_AUX ]			= { 'X', ' ', true },
 };
 
 /**
@@ -354,6 +354,8 @@ const char *print_tainted(void)
 {
 	static char buf[TAINT_FLAGS_COUNT + sizeof("Tainted: ")];
 
+	BUILD_BUG_ON(ARRAY_SIZE(taint_flags) != TAINT_FLAGS_COUNT);
+
 	if (tainted_mask) {
 		char *s;
 		int i;
-- 
2.7.4
