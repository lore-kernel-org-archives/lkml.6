Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9u4FLi1bGVu/HQAAmS7hNA
	; Thu, 07 Jun 2018 16:23:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D7A716089E; Thu,  7 Jun 2018 16:23:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4CAC06074D;
	Thu,  7 Jun 2018 16:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4CAC06074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934338AbeFGQXr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:23:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:63091 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932611AbeFGQXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:23:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 09:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="47568687"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2018 09:23:45 -0700
Subject: [PATCH v2] x86/spectre_v1: Disable compiler optimizations over
 array_index_mask_nospec()
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Date: Thu, 07 Jun 2018 09:13:48 -0700
Message-ID: <152838798950.14521.4893346294059739135.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <alpine.DEB.2.21.1806061223560.1579@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1806061223560.1579@nanos.tec.linutronix.de>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark notes that gcc optimization passes have the potential to elide
necessary invocations of this instruction sequence, so mark the asm
volaltile.

---
>From Mark:

The volatile will inhibit *some* cases where the compiler could lift the
array_index_nospec() call out of a branch, e.g. where there are multiple
invocations of array_index_nospec() with the same arguments:

        if (idx < foo) {
                idx1 = array_idx_nospec(idx, foo)
                do_something(idx1);
        }

        < some other code >

        if (idx < foo) {
                idx2 = array_idx_nospec(idx, foo);
                do_something_else(idx2);
        }

... since the compiler can determine that the two invocations yield the same
result, and reuse the first result (likely the same register as idx was in
originally) for the second branch, effectively re-writing the above as:


        if (idx < foo) {
                idx = array_idx_nospec(idx, foo);
                do_something(idx);
        }

        < some other code >

        if (idx < foo) {
                do_something_else(idx);
        }

... if we don't take the first branch, then speculatively take the second, we
lose the nospec protection.

There's more info on volatile asm in the GCC docs:

https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile

Cc: <stable@vger.kernel.org>
Fixes: babdde2698d4 ("x86: Implement array_index_mask_nospec")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes in v2:
* drop the barrier() call (Mark)
* update the example (Mark)

 arch/x86/include/asm/barrier.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 042b5e892ed1..14de0432d288 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -38,7 +38,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 {
 	unsigned long mask;
 
-	asm ("cmp %1,%2; sbb %0,%0;"
+	asm volatile ("cmp %1,%2; sbb %0,%0;"
 			:"=r" (mask)
 			:"g"(size),"r" (index)
 			:"cc");
