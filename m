Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbeBPDh4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 22:37:56 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40415 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeBPDhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 22:37:52 -0500
X-Google-Smtp-Source: AH8x224f4DU62Q2EZk/gGhWwU800VEUy1/wGiG0/MADI7afIgOhTM16xyi8I+BjGCADfgkRS2rJ2kA==
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/3] taint: Convert to enum and indexed initialization
Date: Thu, 15 Feb 2018 19:37:42 -0800
Message-Id: <1518752264-47238-2-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518752264-47238-1-git-send-email-keescook@chromium.org>
References: <1518752264-47238-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the taint bit defines to an enum, uses indexed initializers
instead of comments, and make sure that no one forgets to update the
taint_flags when adding new bits.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kernel.h | 40 ++++++++++++++++++++++------------------
 kernel/panic.c         | 36 +++++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index ce51455e2adf..0d2a2dd507b7 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -533,24 +533,28 @@ extern enum system_states {
 	SYSTEM_RESTART,
 } system_state;
 
-#define TAINT_PROPRIETARY_MODULE	0
-#define TAINT_FORCED_MODULE		1
-#define TAINT_CPU_OUT_OF_SPEC		2
-#define TAINT_FORCED_RMMOD		3
-#define TAINT_MACHINE_CHECK		4
-#define TAINT_BAD_PAGE			5
-#define TAINT_USER			6
-#define TAINT_DIE			7
-#define TAINT_OVERRIDDEN_ACPI_TABLE	8
-#define TAINT_WARN			9
-#define TAINT_CRAP			10
-#define TAINT_FIRMWARE_WORKAROUND	11
-#define TAINT_OOT_MODULE		12
-#define TAINT_UNSIGNED_MODULE		13
-#define TAINT_SOFTLOCKUP		14
-#define TAINT_LIVEPATCH			15
-#define TAINT_AUX			16
-#define TAINT_FLAGS_COUNT		17
+enum taint_enum {
+	TAINT_PROPRIETARY_MODULE = 0,
+	TAINT_FORCED_MODULE,
+	TAINT_CPU_OUT_OF_SPEC,
+	TAINT_FORCED_RMMOD,
+	TAINT_MACHINE_CHECK,
+	TAINT_BAD_PAGE,
+	TAINT_USER,
+	TAINT_DIE,
+	TAINT_OVERRIDDEN_ACPI_TABLE,
+	TAINT_WARN,
+	TAINT_CRAP,
+	TAINT_FIRMWARE_WORKAROUND,
+	TAINT_OOT_MODULE,
+	TAINT_UNSIGNED_MODULE,
+	TAINT_SOFTLOCKUP,
+	TAINT_LIVEPATCH,
+	TAINT_AUX,
+
+	/* End of taint bits */
+	TAINT_FLAGS_COUNT
+};
 
 struct taint_flag {
 	char c_true;	/* character printed when tainted */
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
