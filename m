Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbeENMom (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:44:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33509 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbeENMok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:44:40 -0400
Date: Mon, 14 May 2018 05:43:16 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-3fcd2b2d928904cbf30b01e2c5e4f1dd2f9ab262@git.kernel.org>
Cc: peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        dave.hansen@intel.com, dave.hansen@linux.intel.com, shuah@kernel.org,
        linuxram@us.ibm.com, tglx@linutronix.de
Reply-To: peterz@infradead.org, mingo@kernel.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
        torvalds@linux-foundation.org, linuxram@us.ibm.com, tglx@linutronix.de,
        shuah@kernel.org, dave.hansen@linux.intel.com, dave.hansen@intel.com
In-Reply-To: <20180509171347.C64AB733@viggo.jf.intel.com>
References: <20180509171347.C64AB733@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pkeys/selftests: Factor out "instruction page"
Git-Commit-ID: 3fcd2b2d928904cbf30b01e2c5e4f1dd2f9ab262
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

Commit-ID:  3fcd2b2d928904cbf30b01e2c5e4f1dd2f9ab262
Gitweb:     https://git.kernel.org/tip/3fcd2b2d928904cbf30b01e2c5e4f1dd2f9ab262
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 9 May 2018 10:13:47 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:45 +0200

x86/pkeys/selftests: Factor out "instruction page"

We currently have an execute-only test, but it is for
the explicit mprotect_pkey() interface.  We will soon
add a test for the implicit mprotect(PROT_EXEC)
enterface.  We need this code in both tests.

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
Link: http://lkml.kernel.org/r/20180509171347.C64AB733@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/protection_keys.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index 7d95acd2aec3..083ebd51b44e 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -1253,12 +1253,9 @@ void test_ptrace_of_child(int *ptr, u16 pkey)
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
@@ -1268,7 +1265,23 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
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
