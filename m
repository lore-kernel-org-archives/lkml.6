Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeENMmR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:42:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752930AbeENMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:42:13 -0400
Date: Mon, 14 May 2018 05:41:50 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-a50093d60464dd51d1ae0c2267b0abe9e1de77f3@git.kernel.org>
Cc: hpa@zytor.com, mpe@ellerman.id.au, dave.hansen@linux.intel.com,
        peterz@infradead.org, dave.hansen@intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        linuxram@us.ibm.com, tglx@linutronix.de
Reply-To: akpm@linux-foundation.org, linuxram@us.ibm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, mingo@kernel.org,
        shuah@kernel.org, dave.hansen@linux.intel.com, mpe@ellerman.id.au,
        hpa@zytor.com
In-Reply-To: <20180509171342.846B9B2E@viggo.jf.intel.com>
References: <20180509171342.846B9B2E@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pkeys/selftests: Remove dead debugging code,
 fix dprint_in_signal
Git-Commit-ID: a50093d60464dd51d1ae0c2267b0abe9e1de77f3
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

Commit-ID:  a50093d60464dd51d1ae0c2267b0abe9e1de77f3
Gitweb:     https://git.kernel.org/tip/a50093d60464dd51d1ae0c2267b0abe9e1de77f3
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 9 May 2018 10:13:42 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:45 +0200

x86/pkeys/selftests: Remove dead debugging code, fix dprint_in_signal

There is some noisy debug code at the end of the signal handler.  It was
disabled by an early, unconditional "return".  However, that return also
hid a dprint_in_signal=0, which kept dprint_in_signal=1 and effectively
locked us into permanent dprint_in_signal=1 behavior.

Remove the return and the dead code, fixing dprint_in_signal.

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
Link: http://lkml.kernel.org/r/20180509171342.846B9B2E@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/protection_keys.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index 8537a7cfe1cc..5f5aedb80e7b 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -325,22 +325,6 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
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
 
