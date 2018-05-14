Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932073AbeENMpq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:45:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeENMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:45:44 -0400
Date: Mon, 14 May 2018 05:45:20 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-3d64f4ed15c3c53dba4c514bf59c334464dee373@git.kernel.org>
Cc: linuxram@us.ibm.com, mpe@ellerman.id.au, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, peterz@infradead.org, mingo@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, shuah@kernel.org
Reply-To: linuxram@us.ibm.com, akpm@linux-foundation.org, mpe@ellerman.id.au,
        mingo@kernel.org, torvalds@linux-foundation.org, peterz@infradead.org,
        hpa@zytor.com, dave.hansen@intel.com, dave.hansen@linux.intel.com,
        tglx@linutronix.de, shuah@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180509171352.9BE09819@viggo.jf.intel.com>
References: <20180509171352.9BE09819@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pkeys/selftests: Fix pointer math
Git-Commit-ID: 3d64f4ed15c3c53dba4c514bf59c334464dee373
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

Commit-ID:  3d64f4ed15c3c53dba4c514bf59c334464dee373
Gitweb:     https://git.kernel.org/tip/3d64f4ed15c3c53dba4c514bf59c334464dee373
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 9 May 2018 10:13:52 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:45 +0200

x86/pkeys/selftests: Fix pointer math

We dump out the entire area of the siginfo where the si_pkey_ptr is
supposed to be.  But, we do some math on the poitner, which is a u32.
We intended to do byte math, not u32 math on the pointer.

Cast it over to a u8* so it works.

Also, move this block of code to below th si_code check.  It doesn't
hurt anything, but the si_pkey field is gibberish for other signal
types.

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
Link: http://lkml.kernel.org/r/20180509171352.9BE09819@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/protection_keys.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index 55a4e349a45e..ee8176358d12 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -303,13 +303,6 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
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
@@ -317,6 +310,13 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
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
