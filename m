Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755340AbeCSILw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:11:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51877 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbeCSILs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:11:48 -0400
Date: Mon, 19 Mar 2018 01:10:47 -0700
From: tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-4b0b37d4cc54b21a6ecad7271cbc850555869c62@git.kernel.org>
Cc: luto@kernel.org, torvalds@linux-foundation.org, bp@alien8.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        torvalds@linux-foundation.org, luto@kernel.org, peterz@infradead.org,
        mingo@kernel.org, hpa@zytor.com
In-Reply-To: <bc80338b453afa187bc5f895bd8e2c8d6e264da2.1521300271.git.luto@kernel.org>
References: <bc80338b453afa187bc5f895bd8e2c8d6e264da2.1521300271.git.luto@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] selftests/x86/ptrace_syscall: Fix for yet more glibc
 interference
Git-Commit-ID: 4b0b37d4cc54b21a6ecad7271cbc850555869c62
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4b0b37d4cc54b21a6ecad7271cbc850555869c62
Gitweb:     https://git.kernel.org/tip/4b0b37d4cc54b21a6ecad7271cbc850555869c62
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sat, 17 Mar 2018 08:25:07 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 19 Mar 2018 09:06:15 +0100

selftests/x86/ptrace_syscall: Fix for yet more glibc interference

glibc keeps getting cleverer, and my version now turns raise() into
more than one syscall.  Since the test relies on ptrace seeing an
exact set of syscalls, this breaks the test.  Replace raise(SIGSTOP)
with syscall(SYS_tgkill, ...) to force glibc to get out of our way.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/bc80338b453afa187bc5f895bd8e2c8d6e264da2.1521300271.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/ptrace_syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 1ae1c5a7392e..6f22238f3217 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -183,8 +183,10 @@ static void test_ptrace_syscall_restart(void)
 		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
 			err(1, "PTRACE_TRACEME");
 
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
 		printf("\tChild will make one syscall\n");
-		raise(SIGSTOP);
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
 		syscall(SYS_gettid, 10, 11, 12, 13, 14, 15);
 		_exit(0);
@@ -301,9 +303,11 @@ static void test_restart_under_ptrace(void)
 		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
 			err(1, "PTRACE_TRACEME");
 
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
 		printf("\tChild will take a nap until signaled\n");
 		setsigign(SIGUSR1, SA_RESTART);
-		raise(SIGSTOP);
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
 		syscall(SYS_pause, 0, 0, 0, 0, 0, 0);
 		_exit(0);
