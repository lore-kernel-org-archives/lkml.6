Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BF1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45022083B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PhArihwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfAYSeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:34:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33843 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYSeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:34:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so5146046pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YSXIhlACBPNanY0z1rRjRgGH8qycYkYP+u6kVh8Za4I=;
        b=PhArihwgFRf5bKIMMCT9pP0EZ4yfnlNpRTVoHLBDT+Dv8Sjvc64xuKwslilL7vFv8w
         +WjnykHQ4dso/7lubq40sGpVJg2YP+M1GKY7SpJNH6ATsHxR4iEUeBTtzdP5xXVzBlZd
         jiQwK5IXIZrGfWjXInuA/poXFgZW6j7EfCVtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YSXIhlACBPNanY0z1rRjRgGH8qycYkYP+u6kVh8Za4I=;
        b=oqLjO0uaAYNQ2TjbqhcscY01evlnUhVAU54GmoM+RN7tQF646nLEBnbAzaC1lWsiUW
         WariP6Ldbv2lV4FzNRqYknKW1+k0MXjm8RUS9eyiRMFQwiRUEuO1UNmgXL7lMdkd5rNR
         5ItIMR73AbhQpJRBdvl0Pek2HfNb6FiNpzJGeIxbJyvYj42MxU/58cH6+lOO4FV6Sr7Q
         AADezqEQ7/UuU1fGe4L5JNWySjd1rar1+AEv/GmZmWLZxXRsBbdCe1y79h1cgooEXWeg
         TFgaQ4dEncmhc0zdXWgQa6ZxnNaeWOQX+/pFIkKKYCIq2Xymck062AKEQ4sd/SqUlolj
         YAQA==
X-Gm-Message-State: AJcUukfho270v7JInKVNbheVn78C+Yf0nJdTiiU8A32AIfySrnx0PC/d
        qA2sTIk+xv0iSO8ll802mI4XqQ==
X-Google-Smtp-Source: ALg8bN4r4ocBpmtwMt2IbnWx1IZkta9SxD6aZWrVnq59kX/xpSqRa/9sgik0WTASIbTN73qDcJU9+w==
X-Received: by 2002:a63:9041:: with SMTP id a62mr10671669pge.163.1548441241970;
        Fri, 25 Jan 2019 10:34:01 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y9sm32454717pfi.74.2019.01.25.10.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 10:34:00 -0800 (PST)
Date:   Fri, 25 Jan 2019 10:33:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Enhance per-arch ptrace syscall skip tests
Message-ID: <20190125183359.GA8524@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing EPERM during syscall skipping was confusing since the test wasn't
actually exercising the errno evaluation -- it was just passing a literal
"1" (EPERM). Instead, expand the tests to check both direct value returns
(positive, 45000 in this case), and errno values (negative, -ESRCH in this
case) to check both fake success and fake failure during syscall skipping.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: a33b2d0359a0 ("selftests/seccomp: Add tests for basic ptrace actions")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Colin, does this end up working on s390? Based on your bug report, I
suspect the positive value tests will fail, but the errno tests will
pass. If that's true, I think something is wrong in the s390 handling.
(And it may just be that the ptrace code to rewrite syscalls on s390
in the test is wrong...) But splitting these tests up should tell us more.
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 72 +++++++++++++++----
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 496a9a8c773a..7e632b465ab4 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1608,7 +1608,16 @@ TEST_F(TRACE_poke, getpid_runs_normally)
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
@@ -1647,7 +1656,7 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 
 /* Architecture-specific syscall changing routine. */
 void change_syscall(struct __test_metadata *_metadata,
-		    pid_t tracee, int syscall)
+		    pid_t tracee, int syscall, int result)
 {
 	int ret;
 	ARCH_REGS regs;
@@ -1706,7 +1715,7 @@ void change_syscall(struct __test_metadata *_metadata,
 #ifdef SYSCALL_NUM_RET_SHARE_REG
 		TH_LOG("Can't modify syscall return on this architecture");
 #else
-		regs.SYSCALL_RET = EPERM;
+		regs.SYSCALL_RET = result;
 #endif
 
 #ifdef HAVE_GETREGS
@@ -1734,14 +1743,19 @@ void tracer_syscall(struct __test_metadata *_metadata, pid_t tracee,
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
@@ -1774,9 +1788,11 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
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
@@ -1793,8 +1809,10 @@ FIXTURE_SETUP(TRACE_syscall)
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
 
@@ -1842,15 +1860,26 @@ TEST_F(TRACE_syscall, ptrace_syscall_redirected)
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
@@ -1883,7 +1912,21 @@ TEST_F(TRACE_syscall, syscall_redirected)
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
 
@@ -1894,8 +1937,7 @@ TEST_F(TRACE_syscall, syscall_dropped)
 	ASSERT_EQ(0, ret);
 
 	/* gettid has been skipped and an altered return value stored. */
-	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_gettid));
-	EXPECT_NE(self->mytid, syscall(__NR_gettid));
+	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
 }
 
 TEST_F(TRACE_syscall, skip_after_RET_TRACE)
-- 
2.17.1


-- 
Kees Cook
