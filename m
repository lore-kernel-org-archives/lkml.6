Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeBUCsO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 21:48:14 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33299 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeBUCsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 21:48:10 -0500
X-Google-Smtp-Source: AH8x2274p6Lcpu18ZPpHcvVtGTlXOQUp99ysYJsyPQFeqDArluAHgx6mIYLpmqsyOv05B8i6tOp3DQ==
From: Tycho Andersen <tycho@tycho.ws>
To: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc: Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 3/3] seccomp: add a selftest for get_metadata
Date: Tue, 20 Feb 2018 19:47:47 -0700
Message-Id: <20180221024747.9659-4-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180221024747.9659-1-tycho@tycho.ws>
References: <20180221024747.9659-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's test that we get the flags correctly, and that we preserve the filter
index across the ptrace(PTRACE_SECCOMP_GET_METADATA) correctly.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 61 +++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 0b457e8e0f0c..5df609950a66 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -141,6 +141,15 @@ struct seccomp_data {
 #define SECCOMP_FILTER_FLAG_LOG 2
 #endif
 
+#ifndef PTRACE_SECCOMP_GET_METADATA
+#define PTRACE_SECCOMP_GET_METADATA	0x420d
+
+struct seccomp_metadata {
+	__u64 filter_off;       /* Input: which filter */
+	__u64 flags;             /* Output: filter's flags */
+};
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -2845,6 +2854,58 @@ TEST(get_action_avail)
 	EXPECT_EQ(errno, EOPNOTSUPP);
 }
 
+TEST(get_metadata)
+{
+	pid_t pid;
+	int pipefd[2];
+	char buf;
+	struct seccomp_metadata md;
+
+	ASSERT_EQ(0, pipe(pipefd));
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		struct sock_filter filter[] = {
+			BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+		};
+		struct sock_fprog prog = {
+			.len = (unsigned short)ARRAY_SIZE(filter),
+			.filter = filter,
+		};
+
+		/* one with log, one without */
+		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
+				     SECCOMP_FILTER_FLAG_LOG, &prog));
+		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
+
+		ASSERT_EQ(0, close(pipefd[0]));
+		ASSERT_EQ(1, write(pipefd[1], "1", 1));
+		ASSERT_EQ(0, close(pipefd[1]));
+
+		while (1)
+			sleep(100);
+	}
+
+	ASSERT_EQ(0, close(pipefd[1]));
+	ASSERT_EQ(1, read(pipefd[0], &buf, 1));
+
+	ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid));
+	ASSERT_EQ(pid, waitpid(pid, NULL, 0));
+
+	md.filter_off = 0;
+	ASSERT_EQ(sizeof(md), ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md));
+	EXPECT_EQ(md.flags, SECCOMP_FILTER_FLAG_LOG);
+	EXPECT_EQ(md.filter_off, 0);
+
+	md.filter_off = 1;
+	ASSERT_EQ(sizeof(md), ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md));
+	EXPECT_EQ(md.flags, 0);
+	EXPECT_EQ(md.filter_off, 1);
+
+	ASSERT_EQ(0, kill(pid, SIGKILL));
+}
+
 /*
  * TODO:
  * - add microbenchmarks
-- 
2.14.1
