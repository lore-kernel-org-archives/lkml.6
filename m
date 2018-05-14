Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeENMl1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:41:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34737 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbeENMlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:41:12 -0400
Date: Mon, 14 May 2018 05:40:50 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-55556b0b2016806b2e16a20b62d143383983a34a@git.kernel.org>
Cc: dave.hansen@intel.com, mpe@ellerman.id.au, peterz@infradead.org,
        shuah@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com,
        akpm@linux-foundation.org, linuxram@us.ibm.com
Reply-To: dave.hansen@intel.com, mpe@ellerman.id.au, shuah@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        linuxram@us.ibm.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20180509171338.55D13B64@viggo.jf.intel.com>
References: <20180509171338.55D13B64@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pkeys/selftests: Give better unexpected fault
 error messages
Git-Commit-ID: 55556b0b2016806b2e16a20b62d143383983a34a
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

Commit-ID:  55556b0b2016806b2e16a20b62d143383983a34a
Gitweb:     https://git.kernel.org/tip/55556b0b2016806b2e16a20b62d143383983a34a
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 9 May 2018 10:13:38 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:45 +0200

x86/pkeys/selftests: Give better unexpected fault error messages

do_not_expect_pk_fault() is a helper that we call when we do not expect
a PK fault to have occurred.  But, it is a function, which means that
it obscures the line numbers from pkey_assert().  It also gives no
details.

Replace it with an implementation that gives nice line numbers and
also lets callers pass in a more descriptive message about what
happened that caused the unexpected fault.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180509171338.55D13B64@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/protection_keys.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index bbe80a5c31c7..a0f0a732784b 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -954,10 +954,11 @@ void expected_pk_fault(int pkey)
 	last_si_pkey = -1;
 }
 
-void do_not_expect_pk_fault(void)
-{
-	pkey_assert(last_pkru_faults == pkru_faults);
-}
+#define do_not_expect_pk_fault(msg)	do {			\
+	if (last_pkru_faults != pkru_faults)			\
+		dprintf0("unexpected PK fault: %s\n", msg);	\
+	pkey_assert(last_pkru_faults == pkru_faults);		\
+} while (0)
 
 int test_fds[10] = { -1 };
 int nr_test_fds;
@@ -1243,7 +1244,7 @@ void test_ptrace_of_child(int *ptr, u16 pkey)
 	pkey_assert(ret != -1);
 	/* Now access from the current task, and expect NO exception: */
 	peek_result = read_ptr(plain_ptr);
-	do_not_expect_pk_fault();
+	do_not_expect_pk_fault("read plain pointer after ptrace");
 
 	ret = ptrace(PTRACE_DETACH, child_pid, ignored, 0);
 	pkey_assert(ret != -1);
@@ -1287,7 +1288,7 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	 */
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
 	lots_o_noops_around_write(&scratch);
-	do_not_expect_pk_fault();
+	do_not_expect_pk_fault("executing on PROT_EXEC memory");
 	ptr_contents = read_ptr(p1);
 	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
 	expected_pk_fault(pkey);
