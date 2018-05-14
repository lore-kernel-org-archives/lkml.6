Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbeENMpo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:45:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56693 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753018AbeENMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:45:41 -0400
Date: Mon, 14 May 2018 05:44:18 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-f50b4878329ab61d8e05796f655adeb6f5fb57c6@git.kernel.org>
Cc: dave.hansen@intel.com, mpe@ellerman.id.au, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com,
        akpm@linux-foundation.org, mingo@kernel.org, linuxram@us.ibm.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org
Reply-To: tglx@linutronix.de, mpe@ellerman.id.au, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org, linuxram@us.ibm.com,
        mingo@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20180509171350.E1656B95@viggo.jf.intel.com>
References: <20180509171350.E1656B95@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pkeys/selftests: Fix pkey exhaustion test
 off-by-one
Git-Commit-ID: f50b4878329ab61d8e05796f655adeb6f5fb57c6
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

Commit-ID:  f50b4878329ab61d8e05796f655adeb6f5fb57c6
Gitweb:     https://git.kernel.org/tip/f50b4878329ab61d8e05796f655adeb6f5fb57c6
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 9 May 2018 10:13:50 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:45 +0200

x86/pkeys/selftests: Fix pkey exhaustion test off-by-one

In our "exhaust all pkeys" test, we make sure that there
is the expected number available.  Turns out that the
test did not cover the execute-only key, but discussed
it anyway.  It did *not* discuss the test-allocated
key.

Now that we have a test for the mprotect(PROT_EXEC) case,
this off-by-one issue showed itself.  Correct the off-by-
one and add the explanation for the case we missed.

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
Link: http://lkml.kernel.org/r/20180509171350.E1656B95@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/protection_keys.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index 8cb4fe58f381..55a4e349a45e 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -1163,12 +1163,15 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	pkey_assert(i < NR_PKEYS*2);
 
 	/*
-	 * There are 16 pkeys supported in hardware.  One is taken
-	 * up for the default (0) and another can be taken up by
-	 * an execute-only mapping.  Ensure that we can allocate
-	 * at least 14 (16-2).
+	 * There are 16 pkeys supported in hardware.  Three are
+	 * allocated by the time we get here:
+	 *   1. The default key (0)
+	 *   2. One possibly consumed by an execute-only mapping.
+	 *   3. One allocated by the test code and passed in via
+	 *      'pkey' to this function.
+	 * Ensure that we can allocate at least another 13 (16-3).
 	 */
-	pkey_assert(i >= NR_PKEYS-2);
+	pkey_assert(i >= NR_PKEYS-3);
 
 	for (i = 0; i < nr_allocated_pkeys; i++) {
 		err = sys_pkey_free(allocated_pkeys[i]);
