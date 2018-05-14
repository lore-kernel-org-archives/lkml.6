Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeENMkM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:40:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39565 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbeENMkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:40:10 -0400
Date: Mon, 14 May 2018 05:39:46 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-73bb4d6cd192b8629c5125aaada9892d9fc986b6@git.kernel.org>
Cc: hpa@zytor.com, dave.hansen@linux.intel.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180514085908.GA12798@gmail.com>
References: <20180514085908.GA12798@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mpx/selftests: Adjust the self-test to fresh
 distros that export the MPX ABI
Git-Commit-ID: 73bb4d6cd192b8629c5125aaada9892d9fc986b6
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

Commit-ID:  73bb4d6cd192b8629c5125aaada9892d9fc986b6
Gitweb:     https://git.kernel.org/tip/73bb4d6cd192b8629c5125aaada9892d9fc986b6
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Mon, 14 May 2018 10:59:08 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:45 +0200

x86/mpx/selftests: Adjust the self-test to fresh distros that export the MPX ABI

Fix this warning:

  mpx-mini-test.c:422:0: warning: "SEGV_BNDERR" redefined

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Cc: dave.hansen@intel.com
Cc: linux-mm@kvack.org
Cc: linuxram@us.ibm.com
Cc: mpe@ellerman.id.au
Cc: shakeelb@google.com
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180514085908.GA12798@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/mpx-mini-test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/mpx-mini-test.c b/tools/testing/selftests/x86/mpx-mini-test.c
index 9c0325e1ea68..50f7e9272481 100644
--- a/tools/testing/selftests/x86/mpx-mini-test.c
+++ b/tools/testing/selftests/x86/mpx-mini-test.c
@@ -368,6 +368,11 @@ static int expected_bnd_index = -1;
 uint64_t shadow_plb[NR_MPX_BOUNDS_REGISTERS][2]; /* shadow MPX bound registers */
 unsigned long shadow_map[NR_MPX_BOUNDS_REGISTERS];
 
+/* Failed address bound checks: */
+#ifndef SEGV_BNDERR
+# define SEGV_BNDERR	3
+#endif
+
 /*
  * The kernel is supposed to provide some information about the bounds
  * exception in the siginfo.  It should match what we have in the bounds
@@ -419,8 +424,6 @@ void handler(int signum, siginfo_t *si, void *vucontext)
 		br_count++;
 		dprintf1("#BR 0x%jx (total seen: %d)\n", status, br_count);
 
-#define SEGV_BNDERR     3  /* failed address bound checks */
-
 		dprintf2("Saw a #BR! status 0x%jx at %016lx br_reason: %jx\n",
 				status, ip, br_reason);
 		dprintf2("si_signo: %d\n", si->si_signo);
