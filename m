Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04219C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E3320882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762577;
	bh=IYRLQoHEihyEKCY1deYk9sN/WIYTdTGhS5iJabS1bSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oSz00MYhRPtANXE9hq34s9FmvmYLOVZ1JtrtSjjFU+KvlMAzFjZOaDK2Pd8kowaaj
	 98ji1LNJp1K+SGEArmar3p1hhnlHWfplLn5wZlsQb5Q0rGLWDPftWLX0qrisUYCGQU
	 b1iGdy8EXGlmvA2KDk+di5BrTTvov6pJDqO0JKfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbfA2Ltg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731069AbfA2Ltb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:49:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CFE2083B;
        Tue, 29 Jan 2019 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762570;
        bh=IYRLQoHEihyEKCY1deYk9sN/WIYTdTGhS5iJabS1bSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxPcCDXSOuCSWIlRt54p/OBf/kIFQEy2EJR3dVw4olQscVZOp/Qw2qTANjtSFZs0y
         0fQJQ44uGAh8UFTI6MNxEiA3+ncRD3aJcRrPCXiMTwxtULXmdQvMU8h00W9cipZ6MA
         jzwqw/ul3WkL1lMfvDWwdbgU6BQeiDz0PTdASnXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 52/68] Revert "seccomp: add a selftest for get_metadata"
Date:   Tue, 29 Jan 2019 12:36:14 +0100
Message-Id: <20190129113136.472166772@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit e65cd9a20343ea90f576c24c38ee85ab6e7d5fec.

Tommi T. Rrantala notes:

	PTRACE_SECCOMP_GET_METADATA was only added in 4.16
	(26500475ac1b499d8636ff281311d633909f5d20)

	And it's also breaking seccomp_bpf.c compilation for me:

	seccomp_bpf.c: In function ‘get_metadata’:
	seccomp_bpf.c:2878:26: error: storage size of ‘md’ isn’t known
	  struct seccomp_metadata md;

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 61 -------------------
 1 file changed, 61 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index e350cf3d4f90..194759ec9e70 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -145,15 +145,6 @@ struct seccomp_data {
 #define SECCOMP_FILTER_FLAG_SPEC_ALLOW (1UL << 2)
 #endif
 
-#ifndef PTRACE_SECCOMP_GET_METADATA
-#define PTRACE_SECCOMP_GET_METADATA	0x420d
-
-struct seccomp_metadata {
-	__u64 filter_off;       /* Input: which filter */
-	__u64 flags;             /* Output: filter's flags */
-};
-#endif
-
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -2870,58 +2861,6 @@ TEST(get_action_avail)
 	EXPECT_EQ(errno, EOPNOTSUPP);
 }
 
-TEST(get_metadata)
-{
-	pid_t pid;
-	int pipefd[2];
-	char buf;
-	struct seccomp_metadata md;
-
-	ASSERT_EQ(0, pipe(pipefd));
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0) {
-		struct sock_filter filter[] = {
-			BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
-		};
-		struct sock_fprog prog = {
-			.len = (unsigned short)ARRAY_SIZE(filter),
-			.filter = filter,
-		};
-
-		/* one with log, one without */
-		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
-				     SECCOMP_FILTER_FLAG_LOG, &prog));
-		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
-
-		ASSERT_EQ(0, close(pipefd[0]));
-		ASSERT_EQ(1, write(pipefd[1], "1", 1));
-		ASSERT_EQ(0, close(pipefd[1]));
-
-		while (1)
-			sleep(100);
-	}
-
-	ASSERT_EQ(0, close(pipefd[1]));
-	ASSERT_EQ(1, read(pipefd[0], &buf, 1));
-
-	ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid));
-	ASSERT_EQ(pid, waitpid(pid, NULL, 0));
-
-	md.filter_off = 0;
-	ASSERT_EQ(sizeof(md), ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md));
-	EXPECT_EQ(md.flags, SECCOMP_FILTER_FLAG_LOG);
-	EXPECT_EQ(md.filter_off, 0);
-
-	md.filter_off = 1;
-	ASSERT_EQ(sizeof(md), ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md));
-	EXPECT_EQ(md.flags, 0);
-	EXPECT_EQ(md.filter_off, 1);
-
-	ASSERT_EQ(0, kill(pid, SIGKILL));
-}
-
 /*
  * TODO:
  * - add microbenchmarks
-- 
2.19.1



