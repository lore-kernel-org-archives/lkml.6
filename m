Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeEGXaJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 19:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752938AbeEGXaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 19:30:07 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: viro@zeniv.linux.org.uk
Cc: ast@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH] coredump: rename umh_pipe_setup() to coredump_pipe_setup()
Date: Mon,  7 May 2018 16:30:02 -0700
Message-Id: <20180507233002.5571-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it clearer this code is part of the coredump code, and
is not an exported generic helper from kernel/umh.c.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 fs/coredump.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1e2c87acac9b..566504781683 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -508,7 +508,7 @@ static void wait_for_dump_helpers(struct file *file)
 }
 
 /*
- * umh_pipe_setup
+ * coredump_pipe_setup
  * helper function to customize the process used
  * to collect the core in userspace.  Specifically
  * it sets up a pipe and installs it as fd 0 (stdin)
@@ -518,7 +518,7 @@ static void wait_for_dump_helpers(struct file *file)
  * is a special value that we use to trap recursive
  * core dumps
  */
-static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
+static int coredump_pipe_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct file *files[2];
 	struct coredump_params *cp = (struct coredump_params *)info->data;
@@ -606,7 +606,7 @@ void do_coredump(const siginfo_t *siginfo)
 		}
 
 		if (cprm.limit == 1) {
-			/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.
+			/* See coredump_pipe_setup() which sets RLIMIT_CORE = 1.
 			 *
 			 * Normally core limits are irrelevant to pipes, since
 			 * we're not writing to the file system, but we use
@@ -647,7 +647,8 @@ void do_coredump(const siginfo_t *siginfo)
 		retval = -ENOMEM;
 		sub_info = call_usermodehelper_setup(helper_argv[0],
 						helper_argv, NULL, GFP_KERNEL,
-						umh_pipe_setup, NULL, &cprm);
+						coredump_pipe_setup, NULL,
+						&cprm);
 		if (sub_info)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
-- 
2.17.0
