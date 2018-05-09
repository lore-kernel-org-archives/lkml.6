Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965936AbeEIRVR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:21:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:6995 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965823AbeEIRSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:18:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="38654728"
Subject: [PATCH 03/13] x86/pkeys/selftests: Remove dead debugging code, fix dprint_in_signal
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 09 May 2018 10:13:42 -0700
References: <20180509171336.76636D88@viggo.jf.intel.com>
In-Reply-To: <20180509171336.76636D88@viggo.jf.intel.com>
Message-Id: <20180509171342.846B9B2E@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

There is some noisy debug code at the end of the signal handler.  It was
disabled by an early, unconditional "return".  However, that return also
hid a dprint_in_signal=0, which kept dprint_in_signal=1 and effectively
locked us into permanent dprint_in_signal=1 behavior.

Remove the return and the dead code, fixing dprint_in_signal.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/protection_keys.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-remove-dead-code-after-return tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-remove-dead-code-after-return	2018-05-09 09:20:19.228698406 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-05-09 09:20:19.232698406 -0700
@@ -315,22 +315,6 @@ void signal_handler(int signum, siginfo_
 	dprintf1("WARNING: set PRKU=0 to allow faulting instruction to continue\n");
 	pkru_faults++;
 	dprintf1("<<<<==================================================\n");
-	return;
-	if (trapno == 14) {
-		fprintf(stderr,
-			"ERROR: In signal handler, page fault, trapno = %d, ip = %016lx\n",
-			trapno, ip);
-		fprintf(stderr, "si_addr %p\n", si->si_addr);
-		fprintf(stderr, "REG_ERR: %lx\n",
-				(unsigned long)uctxt->uc_mcontext.gregs[REG_ERR]);
-		exit(1);
-	} else {
-		fprintf(stderr, "unexpected trap %d! at 0x%lx\n", trapno, ip);
-		fprintf(stderr, "si_addr %p\n", si->si_addr);
-		fprintf(stderr, "REG_ERR: %lx\n",
-				(unsigned long)uctxt->uc_mcontext.gregs[REG_ERR]);
-		exit(2);
-	}
 	dprint_in_signal = 0;
 }
 
_
