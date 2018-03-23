Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeCWSLS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:11:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:9991 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbeCWSLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:11:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="28292571"
Subject: [PATCH 6/9] x86, pkeys, selftests: fix pkey exhaustion test off-by-one
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 23 Mar 2018 11:09:14 -0700
References: <20180323180903.33B17168@viggo.jf.intel.com>
In-Reply-To: <20180323180903.33B17168@viggo.jf.intel.com>
Message-Id: <20180323180914.58B68408@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

In our "exhaust all pkeys" test, we make sure that there
is the expected number available.  Turns out that the
test did not cover the execute-only key, but discussed
it anyway.  It did *not* discuss the test-allocated
key.

Now that we have a test for the mprotect(PROT_EXEC) case,
this off-by-one issue showed itself.  Correct the off-by-
one and add the explanation for the case we missed.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/protection_keys.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-exhaust-off-by-one tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-exhaust-off-by-one	2018-03-21 15:47:50.910198920 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-03-21 15:47:50.914198920 -0700
@@ -1155,12 +1155,15 @@ void test_pkey_alloc_exhaust(int *ptr, u
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
_
