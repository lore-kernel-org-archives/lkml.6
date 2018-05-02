Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeEBVTt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:19:49 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:53286 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeEBVTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:19:44 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: mqueue: delete RUN_TESTS and EMIT_TESTS overrides
Date: Wed,  2 May 2018 15:18:48 -0600
Message-Id: <20180502211848.22404-5-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502211848.22404-1-shuah@kernel.org>
References: <20180502211848.22404-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete RUN_TESTS and EMIT_TESTS overrides and use common defines in lib.mk.
The overrides are in place to call mq_open_tests with queue name argument.
The change to delete overrides is coupled with a change to mq_open_tests
to use default queue name when it is called without one.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/mqueue/Makefile        | 12 +----------
 tools/testing/selftests/mqueue/mq_open_tests.c | 29 +++++++++++++-------------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/mqueue/Makefile b/tools/testing/selftests/mqueue/Makefile
index 743d3f9e5918..8a58055fc1f5 100644
--- a/tools/testing/selftests/mqueue/Makefile
+++ b/tools/testing/selftests/mqueue/Makefile
@@ -1,17 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -O2
 LDLIBS = -lrt -lpthread -lpopt
+
 TEST_GEN_PROGS := mq_open_tests mq_perf_tests
 
 include ../lib.mk
-
-override define RUN_TESTS
-	@$(OUTPUT)/mq_open_tests /test1 || echo "selftests: mq_open_tests [FAIL]"
-	@$(OUTPUT)/mq_perf_tests || echo "selftests: mq_perf_tests [FAIL]"
-endef
-
-override define EMIT_TESTS
-	echo "./mq_open_tests /test1 || echo \"selftests: mq_open_tests [FAIL]\""
-	echo "./mq_perf_tests || echo \"selftests: mq_perf_tests [FAIL]\""
-endef
-
diff --git a/tools/testing/selftests/mqueue/mq_open_tests.c b/tools/testing/selftests/mqueue/mq_open_tests.c
index e0a74bd207a5..677140aa25fd 100644
--- a/tools/testing/selftests/mqueue/mq_open_tests.c
+++ b/tools/testing/selftests/mqueue/mq_open_tests.c
@@ -53,6 +53,7 @@ int saved_def_msgs, saved_def_msgsize, saved_max_msgs, saved_max_msgsize;
 int cur_def_msgs, cur_def_msgsize, cur_max_msgs, cur_max_msgsize;
 FILE *def_msgs, *def_msgsize, *max_msgs, *max_msgsize;
 char *queue_path;
+char *default_queue_path = "/test1";
 mqd_t queue = -1;
 
 static inline void __set(FILE *stream, int value, char *err_msg);
@@ -238,27 +239,27 @@ int main(int argc, char *argv[])
 	struct mq_attr attr, result;
 
 	if (argc != 2) {
-		fprintf(stderr, "Must pass a valid queue name\n\n");
-		fprintf(stderr, usage, argv[0]);
-		exit(1);
-	}
+		printf("Using Default queue path - %s\n", default_queue_path);
+		queue_path = default_queue_path;
+	} else {
 
 	/*
 	 * Although we can create a msg queue with a non-absolute path name,
 	 * unlink will fail.  So, if the name doesn't start with a /, add one
 	 * when we save it.
 	 */
-	if (*argv[1] == '/')
-		queue_path = strdup(argv[1]);
-	else {
-		queue_path = malloc(strlen(argv[1]) + 2);
-		if (!queue_path) {
-			perror("malloc()");
-			exit(1);
+		if (*argv[1] == '/')
+			queue_path = strdup(argv[1]);
+		else {
+			queue_path = malloc(strlen(argv[1]) + 2);
+			if (!queue_path) {
+				perror("malloc()");
+				exit(1);
+			}
+			queue_path[0] = '/';
+			queue_path[1] = 0;
+			strcat(queue_path, argv[1]);
 		}
-		queue_path[0] = '/';
-		queue_path[1] = 0;
-		strcat(queue_path, argv[1]);
 	}
 
 	if (getuid() != 0) {
-- 
2.14.1
