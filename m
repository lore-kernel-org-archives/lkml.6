Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F43C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38BE20684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38BE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbeI1Wam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:30:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:27245 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729025AbeI1Wak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:30:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 09:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="92955394"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2018 09:06:14 -0700
Subject: [PATCH 8/8] x86/mm: remove spurious fault pkey check
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org,
        jannh@google.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 28 Sep 2018 09:02:31 -0700
References: <20180928160219.3402F0AA@viggo.jf.intel.com>
In-Reply-To: <20180928160219.3402F0AA@viggo.jf.intel.com>
Message-Id: <20180928160231.243A0D6A@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Spurious faults only ever occur in the kernel's address space.  They
are also constrained specifically to faults with one of these error codes:

	X86_PF_WRITE | X86_PF_PROT
	X86_PF_INSTR | X86_PF_PROT

So, it's never even possible to reach spurious_kernel_fault_check() with
X86_PF_PK set.

In addition, the kernel's address space never has pages with user-mode
protections.  Protection Keys are only enforced on pages with user-mode
protection.

This gives us lots of reasons to not check for protection keys in our
sprurious kernel fault handling.

But, let's also add some warnings to ensure that these assumptions about
protection keys hold true.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---

 b/arch/x86/mm/fault.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/x86/mm/fault.c~pkeys-fault-warnings arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~pkeys-fault-warnings	2018-09-27 10:17:24.992343563 -0700
+++ b/arch/x86/mm/fault.c	2018-09-27 10:17:24.995343563 -0700
@@ -1039,12 +1039,6 @@ static int spurious_kernel_fault_check(u
 
 	if ((error_code & X86_PF_INSTR) && !pte_exec(*pte))
 		return 0;
-	/*
-	 * Note: We do not do lazy flushing on protection key
-	 * changes, so no spurious fault will ever set X86_PF_PK.
-	 */
-	if ((error_code & X86_PF_PK))
-		return 1;
 
 	return 1;
 }
@@ -1220,6 +1214,13 @@ do_kern_addr_fault(struct pt_regs *regs,
 		   unsigned long address)
 {
 	/*
+	 * Protection keys exceptions only happen on user pages.  We
+	 * have no user pages in the kernel portion of the address
+	 * space, so do not expect them here.
+	 */
+	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+
+	/*
 	 * We can fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
 	 *
_
