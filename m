Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932305AbeBSXxZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:53:25 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38138 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932273AbeBSXxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:53:22 -0500
X-Google-Smtp-Source: AH8x226oEgRk9bAimZJef9YwdmnxgXySfVqNCm1Y4I+iRvs4qSM7S+Nh4N11Hr7f7fyBaI7RqSyqig==
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 3/3] taint: Add taint for randstruct
Date: Mon, 19 Feb 2018 15:53:10 -0800
Message-Id: <1519084390-43867-4-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519084390-43867-1-git-send-email-keescook@chromium.org>
References: <1519084390-43867-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the randstruct plugin can intentionally produce extremely unusual
kernel structure layouts (even performance pathological ones), some
maintainers want to be able to trivially determine if an Oops is coming
from a randstruct-built kernel, so as to keep their sanity when debugging.
This adds the new flag and initializes taint_mask immediately when built
with randstruct.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/sysctl/kernel.txt | 1 +
 include/linux/kernel.h          | 3 ++-
 kernel/panic.c                  | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 4a890c7fb6c3..eded671d55eb 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -991,6 +991,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
  16384 (L): A soft lockup has previously occurred on the system.
  32768 (K): The kernel has been live patched.
  65536 (X): Auxiliary taint, defined and used by for distros.
+131072 (T): The kernel was built with the struct randomization plugin.
 
 ==============================================================
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 62fa060a6e1a..ce1e43bf5f49 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -551,7 +551,8 @@ extern enum system_states {
 #define TAINT_SOFTLOCKUP		14
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
-#define TAINT_FLAGS_COUNT		17
+#define TAINT_RANDSTRUCT		17
+#define TAINT_FLAGS_COUNT		18
 
 struct taint_flag {
 	char c_true;	/* character printed when tainted */
diff --git a/kernel/panic.c b/kernel/panic.c
index 15d333a54ece..0153cae0d330 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -34,7 +34,8 @@
 #define PANIC_BLINK_SPD 18
 
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
-static unsigned long tainted_mask;
+static unsigned long tainted_mask =
+	IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -325,6 +326,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_SOFTLOCKUP ]		= { 'L', ' ', false },
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
+	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
 };
 
 /**
-- 
2.7.4
