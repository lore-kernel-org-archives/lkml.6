Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F4C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2458323FCF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2458323FCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeGASD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:03:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965629AbeGAQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:29:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5D4192B;
        Sun,  1 Jul 2018 16:29:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 001/157] x86/spectre_v1: Disable compiler optimizations over array_index_mask_nospec()
Date:   Sun,  1 Jul 2018 18:21:13 +0200
Message-Id: <20180701160852.362158251@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit eab6870fee877258122a042bfd99ee7908c40280 upstream.

Mark Rutland noticed that GCC optimization passes have the potential to elide
necessary invocations of the array_index_mask_nospec() instruction sequence,
so mark the asm() volatile.

Mark explains:

"The volatile will inhibit *some* cases where the compiler could lift the
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
 "

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <stable@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: babdde2698d4 ("x86: Implement array_index_mask_nospec")
Link: https://lkml.kernel.org/lkml/152838798950.14521.4893346294059739135.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/barrier.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -38,7 +38,7 @@ static inline unsigned long array_index_
 {
 	unsigned long mask;
 
-	asm ("cmp %1,%2; sbb %0,%0;"
+	asm volatile ("cmp %1,%2; sbb %0,%0;"
 			:"=r" (mask)
 			:"g"(size),"r" (index)
 			:"cc");


