Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeEEBRX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:17:23 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50602 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbeEEBRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:17:21 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/24] selftests: media_tests: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:23 -0600
Message-Id: <20180505011328.32078-19-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When media_tests test is skipped because of unmet dependencies and/or
unsupported configuration, it exits with error which is treated as a
fail by the Kselftest framework. This leads to false negative result
even when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Change it to use ksft_exit_skip() when the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/media_tests/Makefile            | 3 ++-
 tools/testing/selftests/media_tests/media_device_open.c | 8 ++++----
 tools/testing/selftests/media_tests/media_device_test.c | 8 ++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/media_tests/Makefile b/tools/testing/selftests/media_tests/Makefile
index c82cec2497de..60826d7d37d4 100644
--- a/tools/testing/selftests/media_tests/Makefile
+++ b/tools/testing/selftests/media_tests/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+#
+CFLAGS += -I../ -I../../../../usr/include/
 TEST_GEN_PROGS := media_device_test media_device_open video_device_test
-all: $(TEST_GEN_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/media_tests/media_device_open.c b/tools/testing/selftests/media_tests/media_device_open.c
index a5ce5434bafd..93183a37b133 100644
--- a/tools/testing/selftests/media_tests/media_device_open.c
+++ b/tools/testing/selftests/media_tests/media_device_open.c
@@ -34,6 +34,8 @@
 #include <sys/stat.h>
 #include <linux/media.h>
 
+#include "../kselftest.h"
+
 int main(int argc, char **argv)
 {
 	int opt;
@@ -61,10 +63,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (getuid() != 0) {
-		printf("Please run the test as root - Exiting.\n");
-		exit(-1);
-	}
+	if (getuid() != 0)
+		ksft_exit_skip("Please run the test as root - Exiting.\n");
 
 	/* Open Media device and keep it open */
 	fd = open(media_device, O_RDWR);
diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/tools/testing/selftests/media_tests/media_device_test.c
index 421a367e4bb3..a4c6ad18cb5c 100644
--- a/tools/testing/selftests/media_tests/media_device_test.c
+++ b/tools/testing/selftests/media_tests/media_device_test.c
@@ -39,6 +39,8 @@
 #include <time.h>
 #include <linux/media.h>
 
+#include "../kselftest.h"
+
 int main(int argc, char **argv)
 {
 	int opt;
@@ -66,10 +68,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (getuid() != 0) {
-		printf("Please run the test as root - Exiting.\n");
-		exit(-1);
-	}
+	if (getuid() != 0)
+		ksft_exit_skip("Please run the test as root - Exiting.\n");
 
 	/* Generate random number of interations */
 	srand((unsigned int) time(NULL));
-- 
2.14.1
