Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750836AbeBPDhv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 22:37:51 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42723 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeBPDht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 22:37:49 -0500
X-Google-Smtp-Source: AH8x226nQT8yMIsxwgdiyt0CeAN6ZIfTy/rkp7CXIB2Njq1HikHayZl7ZpMcTKIfcRAi7E9dlXPEuw==
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 3/3] taint: Add taint for randstruct
Date: Thu, 15 Feb 2018 19:37:44 -0800
Message-Id: <1518752264-47238-4-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518752264-47238-1-git-send-email-keescook@chromium.org>
References: <1518752264-47238-1-git-send-email-keescook@chromium.org>
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
 include/linux/kernel.h          | 1 +
 kernel/panic.c                  | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

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
index 0d2a2dd507b7..9e93ab8358d0 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -551,6 +551,7 @@ enum taint_enum {
 	TAINT_SOFTLOCKUP,
 	TAINT_LIVEPATCH,
 	TAINT_AUX,
+	TAINT_RANDSTRUCT,
 
 	/* End of taint bits */
 	TAINT_FLAGS_COUNT
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
