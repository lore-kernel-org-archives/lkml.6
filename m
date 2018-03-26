Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeCZRbH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:31:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:1189 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752628AbeCZR3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:29:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="211442201"
Subject: [PATCH 3/9] x86, pkeys, selftests: add a test for pkey 0
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 26 Mar 2018 10:27:25 -0700
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
In-Reply-To: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
Message-Id: <20180326172725.619C683B@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Protection key 0 is the default key for all memory and will
not normally come back from pkey_alloc().  But, you might
still want pass it to mprotect_pkey().

This check ensures that you can use pkey 0.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/protection_keys.c |   30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff -puN tools/testing/selftests/x86/protection_keys.c~pkeys-update-selftests-with-pkey-0-test tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-update-selftests-with-pkey-0-test	2018-03-26 10:22:34.841170194 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-03-26 10:22:34.844170194 -0700
@@ -1169,6 +1169,35 @@ void test_pkey_alloc_exhaust(int *ptr, u
 	}
 }
 
+/*
+ * pkey 0 is special.  It is allocated by default, so you do not
+ * have to call pkey_alloc() to use it first.  Make sure that it
+ * is usable.
+ */
+void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
+{
+	long size;
+	int prot;
+
+	assert(pkey_last_malloc_record);
+	size = pkey_last_malloc_record->size;
+	/*
+	 * This is a bit of a hack.  But mprotect() requires
+	 * huge-page-aligned sizes when operating on hugetlbfs.
+	 * So, make sure that we use something that's a multiple
+	 * of a huge page when we can.
+	 */
+	if (size >= HPAGE_SIZE)
+		size = HPAGE_SIZE;
+	prot = pkey_last_malloc_record->prot;
+
+	/* Use pkey 0 */
+	mprotect_pkey(ptr, size, prot, 0);
+
+	/* Make sure that we can set it back to the original pkey. */
+	mprotect_pkey(ptr, size, prot, pkey);
+}
+
 void test_ptrace_of_child(int *ptr, u16 pkey)
 {
 	__attribute__((__unused__)) int peek_result;
@@ -1306,6 +1335,7 @@ void (*pkey_tests[])(int *ptr, u16 pkey)
 	test_kernel_gup_of_access_disabled_region,
 	test_kernel_gup_write_to_write_disabled_region,
 	test_executing_on_unreadable_memory,
+	test_mprotect_with_pkey_0,
 	test_ptrace_of_child,
 	test_pkey_syscalls_on_non_allocated_pkey,
 	test_pkey_syscalls_bad_args,
_
