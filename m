Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932690AbeD0RuC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:50:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:20114 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932576AbeD0Rt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:49:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,336,1520924400";
   d="scan'208";a="35165146"
Subject: [PATCH 7/9] x86, pkeys, selftests: factor out "instruction page"
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 27 Apr 2018 10:45:38 -0700
References: <20180427174527.0031016C@viggo.jf.intel.com>
In-Reply-To: <20180427174527.0031016C@viggo.jf.intel.com>
Message-Id: <20180427174538.5F0CEA27@viggo.jf.intel.com>
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
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-get_pointer_to_instructions	2018-03-26 10:22:37.012170189 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-03-26 10:22:37.015170189 -0700
@@ -1277,12 +1277,9 @@ void test_ptrace_of_child(int *ptr, u16
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
@@ -1292,7 +1289,23 @@ void test_executing_on_unreadable_memory
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
