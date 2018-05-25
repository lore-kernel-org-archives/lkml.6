Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967493AbeEYRbG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:31:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:30082 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967351AbeEYRbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:31:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="44757187"
Subject: [PATCH] x86/spectre_v1: Disable compiler optimizations over
 array_index_mask_nospec()
From: Dan Williams <dan.j.williams@intel.com>
To: mingo@kernel.org, tglx@linutronix.de
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Date: Fri, 25 May 2018 10:21:08 -0700
Message-ID: <152726886796.10827.14538693708255560877.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark notes that gcc optimization passes have the potential to elide
necessary invocations of this instruction sequence, so include an
optimization barrier.

    > I think that either way, we have a potential problem if the compiler
    > generates a branch dependent on the result of validate_index_nospec().
    >
    > In that case, we could end up with codegen approximating:
    >
    >       bool safe = false;
    >
    >       if (idx < bound) {
    >               idx = array_index_nospec(idx, bound);
    >               safe = true;
    >       }
    >
    >       // this branch can be mispredicted
    >       if (safe) {
    >               foo = array[idx];
    >       }
    >
    > ... and thus we lose the nospec protection.

    I see GCC do this at -O0, but so far I haven't tricked it into doing
    this at -O1 or above.

    Regardless, I worry this is fragile -- GCC *can* generate code as per
    the above, even if it's unlikely to.

Cc: <stable@vger.kernel.org>
Fixes: babdde2698d4 ("x86: Implement array_index_mask_nospec")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/barrier.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 042b5e892ed1..41f7435c84a7 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -38,10 +38,11 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 {
 	unsigned long mask;
 
-	asm ("cmp %1,%2; sbb %0,%0;"
+	asm volatile ("cmp %1,%2; sbb %0,%0;"
 			:"=r" (mask)
 			:"g"(size),"r" (index)
 			:"cc");
+	barrier();
 	return mask;
 }
 
