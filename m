Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeEEBOi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:14:38 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50389 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeEEBOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:14:36 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, smuckle.linux@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/24] selftests: exec: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:10 -0600
Message-Id: <20180505011328.32078-6-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When execveat test is skipped because of unmet dependencies and/or
unsupported configuration, it exits with error which is treated as
a fail by the Kselftest framework. This leads to false negative
result even when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Change it to use ksft_exit_skip() when kernel doesn't support execveat.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/exec/execveat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index 67cd4597db2b..47cbf54d0801 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -20,6 +20,8 @@
 #include <string.h>
 #include <unistd.h>
 
+#include "../kselftest.h"
+
 static char longpath[2 * PATH_MAX] = "";
 static char *envp[] = { "IN_TEST=yes", NULL, NULL };
 static char *argv[] = { "execveat", "99", NULL };
@@ -249,8 +251,8 @@ static int run_tests(void)
 	errno = 0;
 	execveat_(-1, NULL, NULL, NULL, 0);
 	if (errno == ENOSYS) {
-		printf("[FAIL] ENOSYS calling execveat - no kernel support?\n");
-		return 1;
+		ksft_exit_skip(
+			"ENOSYS calling execveat - no kernel support?\n");
 	}
 
 	/* Change file position to confirm it doesn't affect anything */
-- 
2.14.1
