Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163077AbeE1KqS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162857AbeE1KqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:46:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 115/496] seccomp: add a selftest for get_metadata
Date: Mon, 28 May 2018 11:58:20 +0200
Message-Id: <20180528100324.761976897@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tycho Andersen <tycho@tycho.ws>

[ Upstream commit d057dc4e35e16050befa3dda943876dab39cbf80 ]

Let's test that we get the flags correctly, and that we preserve the filter
index across the ptrace(PTRACE_SECCOMP_GET_METADATA) correctly.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c |   61 ++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -145,6 +145,15 @@ struct seccomp_data {
 #define SECCOMP_FILTER_FLAG_SPEC_ALLOW (1UL << 2)
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
@@ -2861,6 +2870,58 @@ TEST(get_action_avail)
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
