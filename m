Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965819AbeEIRSq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:18:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:22733 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965240AbeEIRSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:18:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="53786702"
Subject: [PATCH 01/13] x86/pkeys/selftests: Give better unexpected fault error messages
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 09 May 2018 10:13:38 -0700
References: <20180509171336.76636D88@viggo.jf.intel.com>
In-Reply-To: <20180509171336.76636D88@viggo.jf.intel.com>
Message-Id: <20180509171338.55D13B64@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

do_not_expect_pk_fault() is a helper that we call when we do not expect
a PK fault to have occurred.  But, it is a function, which means that
it obscures the line numbers from pkey_assert().  It also gives no
details.

Replace it with an implementation that gives nice line numbers and
also lets callers pass in a more descriptive message about what
happened that caused the unexpected fault.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/protection_keys.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-give-better-pkey-fault-errors tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-give-better-pkey-fault-errors	2018-05-09 09:20:18.202698408 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-05-09 09:20:18.205698408 -0700
@@ -939,10 +939,11 @@ void expected_pk_fault(int pkey)
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
@@ -1228,7 +1229,7 @@ void test_ptrace_of_child(int *ptr, u16
 	pkey_assert(ret != -1);
 	/* Now access from the current task, and expect NO exception: */
 	peek_result = read_ptr(plain_ptr);
-	do_not_expect_pk_fault();
+	do_not_expect_pk_fault("read plain pointer after ptrace");
 
 	ret = ptrace(PTRACE_DETACH, child_pid, ignored, 0);
 	pkey_assert(ret != -1);
@@ -1272,7 +1273,7 @@ void test_executing_on_unreadable_memory
 	 */
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
 	lots_o_noops_around_write(&scratch);
-	do_not_expect_pk_fault();
+	do_not_expect_pk_fault("executing on PROT_EXEC memory");
 	ptr_contents = read_ptr(p1);
 	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
 	expected_pk_fault(pkey);
_
