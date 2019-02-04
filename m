Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978BAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7F32073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278083;
	bh=WZKqLDcEQ0MWN1/Jsq19PdIfoH2BZxDcxPFsbC+cQJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O+EfCgLI47um96R42OiQ2PHw8f75swYDKJbat4H1rH7QFR7tx03NYkZ6vX1m7rLU5
	 SZyvUMRRKK+GeKtYiTBenKJpLZTQpfroZxzLrSsSGnHCtp4f7lGwW5h04V5l9tGf3P
	 sl3I3bA83eke3kWGVnd+FABkZ6T9FCDsy2y8YA4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfBDKsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731764AbfBDKsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3649F217D6;
        Mon,  4 Feb 2019 10:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277289;
        bh=WZKqLDcEQ0MWN1/Jsq19PdIfoH2BZxDcxPFsbC+cQJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TaM4idJnC1MmS5SLi+2D+k/sV4tqUxhnbnKkH3enLfHYv8MOzAq/CbUOqQ1b6JxqZ
         ca8FIQbq5OOz51t+GdTKttCFKWH9MWjFYm9ZUkwvTi4eHOtFR9Y+EpFDPaqvUuTSHT
         qC2WaXQEgLHNqwCci3UeDYUT8zXCWAi3UZ9Hxi90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH 4.19 38/74] selftests/seccomp: Enhance per-arch ptrace syscall skip tests
Date:   Mon,  4 Feb 2019 11:36:51 +0100
Message-Id: <20190204103624.403294757@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit ed5f13261cb65b02c611ae9971677f33581d4286 upstream.

Passing EPERM during syscall skipping was confusing since the test wasn't
actually exercising the errno evaluation -- it was just passing a literal
"1" (EPERM). Instead, expand the tests to check both direct value returns
(positive, 45000 in this case), and errno values (negative, -ESRCH in this
case) to check both fake success and fake failure during syscall skipping.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: a33b2d0359a0 ("selftests/seccomp: Add tests for basic ptrace actions")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/seccomp/seccomp_bpf.c |   72 ++++++++++++++++++++------
 1 file changed, 57 insertions(+), 15 deletions(-)

--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1563,7 +1563,16 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 #ifdef SYSCALL_NUM_RET_SHARE_REG
 # define EXPECT_SYSCALL_RETURN(val, action)	EXPECT_EQ(-1, action)
 #else
-# define EXPECT_SYSCALL_RETURN(val, action)	EXPECT_EQ(val, action)
+# define EXPECT_SYSCALL_RETURN(val, action)		\
+	do {						\
+		errno = 0;				\
+		if (val < 0) {				\
+			EXPECT_EQ(-1, action);		\
+			EXPECT_EQ(-(val), errno);	\
+		} else {				\
+			EXPECT_EQ(val, action);		\
+		}					\
+	} while (0)
 #endif
 
 /* Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
@@ -1602,7 +1611,7 @@ int get_syscall(struct __test_metadata *
 
 /* Architecture-specific syscall changing routine. */
 void change_syscall(struct __test_metadata *_metadata,
-		    pid_t tracee, int syscall)
+		    pid_t tracee, int syscall, int result)
 {
 	int ret;
 	ARCH_REGS regs;
@@ -1661,7 +1670,7 @@ void change_syscall(struct __test_metada
 #ifdef SYSCALL_NUM_RET_SHARE_REG
 		TH_LOG("Can't modify syscall return on this architecture");
 #else
-		regs.SYSCALL_RET = EPERM;
+		regs.SYSCALL_RET = result;
 #endif
 
 #ifdef HAVE_GETREGS
@@ -1689,14 +1698,19 @@ void tracer_syscall(struct __test_metada
 	case 0x1002:
 		/* change getpid to getppid. */
 		EXPECT_EQ(__NR_getpid, get_syscall(_metadata, tracee));
-		change_syscall(_metadata, tracee, __NR_getppid);
+		change_syscall(_metadata, tracee, __NR_getppid, 0);
 		break;
 	case 0x1003:
-		/* skip gettid. */
+		/* skip gettid with valid return code. */
 		EXPECT_EQ(__NR_gettid, get_syscall(_metadata, tracee));
-		change_syscall(_metadata, tracee, -1);
+		change_syscall(_metadata, tracee, -1, 45000);
 		break;
 	case 0x1004:
+		/* skip openat with error. */
+		EXPECT_EQ(__NR_openat, get_syscall(_metadata, tracee));
+		change_syscall(_metadata, tracee, -1, -ESRCH);
+		break;
+	case 0x1005:
 		/* do nothing (allow getppid) */
 		EXPECT_EQ(__NR_getppid, get_syscall(_metadata, tracee));
 		break;
@@ -1729,9 +1743,11 @@ void tracer_ptrace(struct __test_metadat
 	nr = get_syscall(_metadata, tracee);
 
 	if (nr == __NR_getpid)
-		change_syscall(_metadata, tracee, __NR_getppid);
+		change_syscall(_metadata, tracee, __NR_getppid, 0);
+	if (nr == __NR_gettid)
+		change_syscall(_metadata, tracee, -1, 45000);
 	if (nr == __NR_openat)
-		change_syscall(_metadata, tracee, -1);
+		change_syscall(_metadata, tracee, -1, -ESRCH);
 }
 
 FIXTURE_DATA(TRACE_syscall) {
@@ -1748,8 +1764,10 @@ FIXTURE_SETUP(TRACE_syscall)
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1002),
 		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_gettid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1003),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_openat, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1004),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1005),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
 
@@ -1797,15 +1815,26 @@ TEST_F(TRACE_syscall, ptrace_syscall_red
 	EXPECT_NE(self->mypid, syscall(__NR_getpid));
 }
 
-TEST_F(TRACE_syscall, ptrace_syscall_dropped)
+TEST_F(TRACE_syscall, ptrace_syscall_errno)
+{
+	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
+	teardown_trace_fixture(_metadata, self->tracer);
+	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
+					   true);
+
+	/* Tracer should skip the open syscall, resulting in ESRCH. */
+	EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
+}
+
+TEST_F(TRACE_syscall, ptrace_syscall_faked)
 {
 	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
 	teardown_trace_fixture(_metadata, self->tracer);
 	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
 					   true);
 
-	/* Tracer should skip the open syscall, resulting in EPERM. */
-	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_openat));
+	/* Tracer should skip the gettid syscall, resulting fake pid. */
+	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
 }
 
 TEST_F(TRACE_syscall, syscall_allowed)
@@ -1838,7 +1867,21 @@ TEST_F(TRACE_syscall, syscall_redirected
 	EXPECT_NE(self->mypid, syscall(__NR_getpid));
 }
 
-TEST_F(TRACE_syscall, syscall_dropped)
+TEST_F(TRACE_syscall, syscall_errno)
+{
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* openat has been skipped and an errno return. */
+	EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
+}
+
+TEST_F(TRACE_syscall, syscall_faked)
 {
 	long ret;
 
@@ -1849,8 +1892,7 @@ TEST_F(TRACE_syscall, syscall_dropped)
 	ASSERT_EQ(0, ret);
 
 	/* gettid has been skipped and an altered return value stored. */
-	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_gettid));
-	EXPECT_NE(self->mytid, syscall(__NR_gettid));
+	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
 }
 
 TEST_F(TRACE_syscall, skip_after_RET_TRACE)


