Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeDAKST (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 06:18:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37417 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeDAKSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 06:18:17 -0400
X-Google-Smtp-Source: AIpwx49yrU0RJBpyzrk0dbRCxTuX9gJXPs44yvUQPuXPAZkCoshfUAFieY/qVFQCzzUsBFO+/F30zQ==
Date: Sun, 1 Apr 2018 10:18:14 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, casey@schaufler-ca.com, jmorris@namei.org
Subject: [PATCH 4/4] security: generated security hook initialization based
 on lsm_hook_types.h
Message-ID: <113007a6b9333ec02a08301405db6a59b294f1d6.1522577650.git.sargun@sargun.me>
References: <cover.1522577650.git.sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522577650.git.sargun@sargun.me>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces the old logic of casting the security hook heads struct to
an array, and then traversing it in order to initialize it. Instead,
it generates the code to set the security hook heads to null at start
time.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 scripts/gcc-plugins/randomize_layout_plugin.c |  2 --
 security/security.c                           | 17 ++++++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 6d5bbd31db7f..d94138999427 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -52,8 +52,6 @@ static const struct whitelist_entry whitelist[] = {
 	{ "net/unix/af_unix.c", "unix_skb_parms", "char" },
 	/* big_key payload.data struct splashing */
 	{ "security/keys/big_key.c", "path", "void *" },
-	/* walk struct security_hook_heads as an array of struct hlist_head */
-	{ "security/security.c", "hlist_head", "security_hook_heads" },
 	{ }
 };
 
diff --git a/security/security.c b/security/security.c
index dd246a38b3f0..c849cfa03b92 100644
--- a/security/security.c
+++ b/security/security.c
@@ -32,6 +32,9 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
+#define INIT_SEC_HEAD(_hook_name)	\
+	INIT_HLIST_HEAD(&security_hook_heads._hook_name)
+
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
@@ -60,12 +63,16 @@ static void __init do_security_initcalls(void)
  */
 int __init security_init(void)
 {
-	int i;
-	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
+	/*
+	 * This generates an unrolled version of the security head
+	 * initialization.
+	 */
+#define INT_HOOK(_hook_name, ...)	INIT_SEC_HEAD(_hook_name)
+#define VOID_HOOK(_hook_name, ...)	INIT_SEC_HEAD(_hook_name)
+#include <linux/lsm_hook_types.h>
+#undef INT_HOOK
+#undef VOID_HOOK
 
-	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
-	     i++)
-		INIT_HLIST_HEAD(&list[i]);
 	pr_info("Security Framework initialized\n");
 
 	/*
-- 
2.14.1
