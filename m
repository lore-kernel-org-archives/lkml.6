Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeCWSLb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:11:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:19442 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752449AbeCWSLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:11:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="185440504"
Subject: [PATCH 9/9] x86, pkeys, selftests: add PROT_EXEC test
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 23 Mar 2018 11:09:18 -0700
References: <20180323180903.33B17168@viggo.jf.intel.com>
In-Reply-To: <20180323180903.33B17168@viggo.jf.intel.com>
Message-Id: <20180323180918.A4C22A10@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Under the covers, implement executable-only memory with
protection keys when userspace calls mprotect(PROT_EXEC).

But, we did not have a selftest for that.  Now we do.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/protection_keys.c |   51 ++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 4 deletions(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-prot_exec tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-prot_exec	2018-03-23 10:46:03.976813119 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-03-23 10:46:03.980813119 -0700
@@ -930,10 +930,10 @@ void expected_pk_fault(int pkey)
 	dprintf2("%s(%d): last_si_pkey: %d\n", __func__, pkey, last_si_pkey);
 	pkey_assert(last_pkru_faults + 1 == pkru_faults);
 
-       /*
-	* For exec-only memory, we do not know the pkey in
-	* advance, so skip this check.
-	*/
+	/*
+	 * For exec-only memory, we do not know the pkey in
+	 * advance, so skip this check.
+	 */
 	if (pkey != UNKNOWN_PKEY)
 		pkey_assert(last_si_pkey == pkey);
 
@@ -1335,6 +1335,49 @@ void test_executing_on_unreadable_memory
 	expected_pk_fault(pkey);
 }
 
+void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
+{
+	void *p1;
+	int scratch;
+	int ptr_contents;
+	int ret;
+
+	dprintf1("%s() start\n", __func__);
+
+	p1 = get_pointer_to_instructions();
+	lots_o_noops_around_write(&scratch);
+	ptr_contents = read_ptr(p1);
+	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
+
+	/* Use a *normal* mprotect(), not mprotect_pkey(): */
+	ret = mprotect(p1, PAGE_SIZE, PROT_EXEC);
+	pkey_assert(!ret);
+
+	dprintf2("pkru: %x\n", rdpkru());
+
+	/* Make sure this is an *instruction* fault */
+	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
+	lots_o_noops_around_write(&scratch);
+	do_not_expect_pk_fault();
+	ptr_contents = read_ptr(p1);
+	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
+	expected_pk_fault(UNKNOWN_PKEY);
+
+	/*
+	 * Put the memory back to non-PROT_EXEC.  Should clear the
+	 * exec-only pkey off the VMA and allow it to be readable
+	 * again.  Go to PROT_NONE first to check for a kernel bug
+	 * that did not clear the pkey when doing PROT_NONE.
+	 */
+	ret = mprotect(p1, PAGE_SIZE, PROT_NONE);
+	pkey_assert(!ret);
+
+	ret = mprotect(p1, PAGE_SIZE, PROT_READ|PROT_EXEC);
+	pkey_assert(!ret);
+	ptr_contents = read_ptr(p1);
+	do_not_expect_pk_fault();
+}
+
 void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 {
 	int size = PAGE_SIZE;
_
