Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757938AbeD0Ruz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:50:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:55914 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932540AbeD0Rtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:49:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,336,1520924400";
   d="scan'208";a="50519314"
Subject: [PATCH 5/9] x86, pkeys, selftests: fix pointer math
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 27 Apr 2018 10:45:35 -0700
References: <20180427174527.0031016C@viggo.jf.intel.com>
In-Reply-To: <20180427174527.0031016C@viggo.jf.intel.com>
Message-Id: <20180427174535.38E7D016@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

We dump out the entire area of the siginfo where the si_pkey_ptr is
supposed to be.  But, we do some math on the poitner, which is a u32.
We intended to do byte math, not u32 math on the pointer.

Cast it over to a u8* so it works.

Also, move this block of code to below th si_code check.  It doesn't
hurt anything, but the si_pkey field is gibberish for other signal
types.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/protection_keys.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-fix-pointer-math tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-fix-pointer-math	2018-04-26 11:23:51.588481155 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-04-26 11:23:51.592481155 -0700
@@ -289,13 +289,6 @@ void signal_handler(int signum, siginfo_
 		dump_mem(pkru_ptr - 128, 256);
 	pkey_assert(*pkru_ptr);
 
-	si_pkey_ptr = (u32 *)(((u8 *)si) + si_pkey_offset);
-	dprintf1("si_pkey_ptr: %p\n", si_pkey_ptr);
-	dump_mem(si_pkey_ptr - 8, 24);
-	siginfo_pkey = *si_pkey_ptr;
-	pkey_assert(siginfo_pkey < NR_PKEYS);
-	last_si_pkey = siginfo_pkey;
-
 	if ((si->si_code == SEGV_MAPERR) ||
 	    (si->si_code == SEGV_ACCERR) ||
 	    (si->si_code == SEGV_BNDERR)) {
@@ -303,6 +296,13 @@ void signal_handler(int signum, siginfo_
 		exit(4);
 	}
 
+	si_pkey_ptr = (u32 *)(((u8 *)si) + si_pkey_offset);
+	dprintf1("si_pkey_ptr: %p\n", si_pkey_ptr);
+	dump_mem((u8 *)si_pkey_ptr - 8, 24);
+	siginfo_pkey = *si_pkey_ptr;
+	pkey_assert(siginfo_pkey < NR_PKEYS);
+	last_si_pkey = siginfo_pkey;
+
 	dprintf1("signal pkru from xsave: %08x\n", *pkru_ptr);
 	/* need __rdpkru() version so we do not do shadow_pkru checking */
 	dprintf1("signal pkru from  pkru: %08x\n", __rdpkru());
_
