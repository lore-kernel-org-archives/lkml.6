Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeCZR3h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:29:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:25566 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752628AbeCZR3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:29:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="45427179"
Subject: [PATCH 1/9] x86, pkeys: do not special case protection key 0
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        stable@kernel.org, linuxram@us.ibm.com, tglx@linutronix.de,
        dave.hansen@intel.com, mpe@ellerman.id.au, mingo@kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 26 Mar 2018 10:27:22 -0700
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
In-Reply-To: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
Message-Id: <20180326172722.8CC08307@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

mm_pkey_is_allocated() treats pkey 0 as unallocated.  That is
inconsistent with the manpages, and also inconsistent with
mm->context.pkey_allocation_map.  Stop special casing it and only
disallow values that are actually bad (< 0).

The end-user visible effect of this is that you can now use
mprotect_pkey() to set pkey=0.

This is a bit nicer than what Ram proposed because it is simpler
and removes special-casing for pkey 0.  On the other hand, it does
allow applciations to pkey_free() pkey-0, but that's just a silly
thing to do, so we are not going to protect against it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 58ab9a088dda ("x86/pkeys: Check against max pkey to avoid overflows")
Cc: stable@kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>p
Cc: Shuah Khan <shuah@kernel.org>
---

 b/arch/x86/include/asm/mmu_context.h |    2 +-
 b/arch/x86/include/asm/pkeys.h       |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/x86/include/asm/mmu_context.h~x86-pkey-0-default-allocated arch/x86/include/asm/mmu_context.h
--- a/arch/x86/include/asm/mmu_context.h~x86-pkey-0-default-allocated	2018-03-26 10:22:33.742170197 -0700
+++ b/arch/x86/include/asm/mmu_context.h	2018-03-26 10:22:33.747170197 -0700
@@ -192,7 +192,7 @@ static inline int init_new_context(struc
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
-		/* pkey 0 is the default and always allocated */
+		/* pkey 0 is the default and allocated implicitly */
 		mm->context.pkey_allocation_map = 0x1;
 		/* -1 means unallocated or invalid */
 		mm->context.execute_only_pkey = -1;
diff -puN arch/x86/include/asm/pkeys.h~x86-pkey-0-default-allocated arch/x86/include/asm/pkeys.h
--- a/arch/x86/include/asm/pkeys.h~x86-pkey-0-default-allocated	2018-03-26 10:22:33.744170197 -0700
+++ b/arch/x86/include/asm/pkeys.h	2018-03-26 10:22:33.747170197 -0700
@@ -49,10 +49,10 @@ bool mm_pkey_is_allocated(struct mm_stru
 {
 	/*
 	 * "Allocated" pkeys are those that have been returned
-	 * from pkey_alloc().  pkey 0 is special, and never
-	 * returned from pkey_alloc().
+	 * from pkey_alloc() or pkey 0 which is allocated
+	 * implicitly when the mm is created.
 	 */
-	if (pkey <= 0)
+	if (pkey < 0)
 		return false;
 	if (pkey >= arch_max_pkey())
 		return false;
_
