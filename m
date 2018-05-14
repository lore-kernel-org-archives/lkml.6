Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeENMqq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:46:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbeENMqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:46:44 -0400
Date: Mon, 14 May 2018 05:46:20 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-3488a600d90bcaf061b104dbcfbdc8d99b398312@git.kernel.org>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org,
        dave.hansen@intel.com, peterz@infradead.org,
        dave.hansen@linux.intel.com, mingo@kernel.org, shuah@kernel.org,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org, linuxram@us.ibm.com
Reply-To: peterz@infradead.org, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au, shuah@kernel.org,
        linuxram@us.ibm.com, akpm@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20180509171356.9E40B254@viggo.jf.intel.com>
References: <20180509171356.9E40B254@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pkeys/selftests: Add a test for pkey 0
Git-Commit-ID: 3488a600d90bcaf061b104dbcfbdc8d99b398312
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

Commit-ID:  3488a600d90bcaf061b104dbcfbdc8d99b398312
Gitweb:     https://git.kernel.org/tip/3488a600d90bcaf061b104dbcfbdc8d99b398312
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 9 May 2018 10:13:56 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:45 +0200

x86/pkeys/selftests: Add a test for pkey 0

Protection key 0 is the default key for all memory and will
not normally come back from pkey_alloc().  But, you might
still want pass it to mprotect_pkey().

This check ensures that you can use pkey 0.

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
Link: http://lkml.kernel.org/r/20180509171356.9E40B254@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/protection_keys.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index 986ed38a2b25..460b4bdf4c1e 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -1184,6 +1184,35 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
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
@@ -1378,6 +1407,7 @@ void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_kernel_gup_write_to_write_disabled_region,
 	test_executing_on_unreadable_memory,
 	test_implicit_mprotect_exec_only_memory,
+	test_mprotect_with_pkey_0,
 	test_ptrace_of_child,
 	test_pkey_syscalls_on_non_allocated_pkey,
 	test_pkey_syscalls_bad_args,
