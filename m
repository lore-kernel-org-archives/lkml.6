Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965917AbeEIRUY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:20:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:26867 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935505AbeEIRSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:18:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="57270839"
Subject: [PATCH 06/13] x86/pkeys/selftests: Factor out "instruction page"
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 09 May 2018 10:13:47 -0700
References: <20180509171336.76636D88@viggo.jf.intel.com>
In-Reply-To: <20180509171336.76636D88@viggo.jf.intel.com>
Message-Id: <20180509171347.C64AB733@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

We currently have an execute-only test, but it is for
the explicit mprotect_pkey() interface.  We will soon
add a test for the implicit mprotect(PROT_EXEC)
enterface.  We need this code in both tests.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/protection_keys.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-get_pointer_to_instructions tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-get_pointer_to_instructions	2018-05-09 09:20:20.764698402 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-05-09 09:20:20.767698402 -0700
@@ -1238,12 +1238,9 @@ void test_ptrace_of_child(int *ptr, u16
 	free(plain_ptr_unaligned);
 }
 
-void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
+void *get_pointer_to_instructions(void)
 {
 	void *p1;
-	int scratch;
-	int ptr_contents;
-	int ret;
 
 	p1 = ALIGN_PTR_UP(&lots_o_noops_around_write, PAGE_SIZE);
 	dprintf3("&lots_o_noops: %p\n", &lots_o_noops_around_write);
@@ -1253,7 +1250,23 @@ void test_executing_on_unreadable_memory
 	/* Point 'p1' at the *second* page of the function: */
 	p1 += PAGE_SIZE;
 
+	/*
+	 * Try to ensure we fault this in on next touch to ensure
+	 * we get an instruction fault as opposed to a data one
+	 */
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
+
+	return p1;
+}
+
+void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
+{
+	void *p1;
+	int scratch;
+	int ptr_contents;
+	int ret;
+
+	p1 = get_pointer_to_instructions();
 	lots_o_noops_around_write(&scratch);
 	ptr_contents = read_ptr(p1);
 	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
_
