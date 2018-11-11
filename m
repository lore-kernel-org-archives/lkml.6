Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E364EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF8120869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF8120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbeKLFsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49532 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729978AbeKLFsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000oU-BS; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001aT-VP; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Peter Zijlstra" <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.243625611@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 160/366] x86/spectre_v1: Disable compiler
 optimizations over array_index_mask_nospec()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: babdde2698d4 ("x86: Implement array_index_mask_nospec")
Link: https://lkml.kernel.org/lkml/152838798950.14521.4893346294059739135.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/barrier.h | 2 +-
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

