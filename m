Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BD6C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC50218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfAYOz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:55:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52921 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYOz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:55:29 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gn2tD-00012w-4S; Fri, 25 Jan 2019 14:55:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] selftests/seccomp: fix test failure on s390x because of
Date:   Fri, 25 Jan 2019 14:55:26 +0000
Message-Id: <20190125145526.7106-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The error return being placed in regs.SYSCALL_RET is currently positive and
this is causing test failures on s390x. The return value should be -EPERM
rather than EPERM otherwise a failure is not detected and errno is not set
accordingly on s390x.

Fixes: a33b2d0359a0 ("selftests/seccomp: Add tests for basic ptrace actions")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: remove misplaced Content-Type and Content-Transfer-Encoding fields

---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 496a9a8c773a..957344884360 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1706,7 +1706,7 @@ void change_syscall(struct __test_metadata *_metadata,
 #ifdef SYSCALL_NUM_RET_SHARE_REG
 		TH_LOG("Can't modify syscall return on this architecture");
 #else
-		regs.SYSCALL_RET = EPERM;
+		regs.SYSCALL_RET = -EPERM;
 #endif
 
 #ifdef HAVE_GETREGS
@@ -1850,7 +1850,7 @@ TEST_F(TRACE_syscall, ptrace_syscall_dropped)
 					   true);
 
 	/* Tracer should skip the open syscall, resulting in EPERM. */
-	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_openat));
+	EXPECT_SYSCALL_RETURN(-EPERM, syscall(__NR_openat));
 }
 
 TEST_F(TRACE_syscall, syscall_allowed)
@@ -1894,7 +1894,7 @@ TEST_F(TRACE_syscall, syscall_dropped)
 	ASSERT_EQ(0, ret);
 
 	/* gettid has been skipped and an altered return value stored. */
-	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_gettid));
+	EXPECT_SYSCALL_RETURN(-EPERM, syscall(__NR_gettid));
 	EXPECT_NE(self->mytid, syscall(__NR_gettid));
 }
 
-- 
2.19.1

