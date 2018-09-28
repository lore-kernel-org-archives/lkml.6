Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E45C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467F820684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467F820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeI1Waj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:30:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:3595 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729025AbeI1Waj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:30:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 09:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="73865719"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga007.fm.intel.com with ESMTP; 28 Sep 2018 09:06:10 -0700
Subject: [PATCH 5/8] x86/mm: fix exception table comments
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org,
        jannh@google.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 28 Sep 2018 09:02:27 -0700
References: <20180928160219.3402F0AA@viggo.jf.intel.com>
In-Reply-To: <20180928160219.3402F0AA@viggo.jf.intel.com>
Message-Id: <20180928160227.077DDD7A@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The comments here are wrong.  They are too absolute about where
faults can occur when running in the kernel.  The comments are
also a bit hard to match up with the code.

Trim down the comments, and make them more precise.

Also add a comment explaining why we are doing the
bad_area_nosemaphore() path here.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---

 b/arch/x86/mm/fault.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff -puN arch/x86/mm/fault.c~pkeys-fault-warnings-03 arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~pkeys-fault-warnings-03	2018-09-27 10:17:23.489343567 -0700
+++ b/arch/x86/mm/fault.c	2018-09-27 10:17:23.493343567 -0700
@@ -1353,24 +1353,26 @@ void do_user_addr_fault(struct pt_regs *
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 	/*
-	 * When running in the kernel we expect faults to occur only to
-	 * addresses in user space.  All other faults represent errors in
-	 * the kernel and should generate an OOPS.  Unfortunately, in the
-	 * case of an erroneous fault occurring in a code path which already
-	 * holds mmap_sem we will deadlock attempting to validate the fault
-	 * against the address space.  Luckily the kernel only validly
-	 * references user space from well defined areas of code, which are
-	 * listed in the exceptions table.
+	 * Kernel-mode access to the user address space should only occur
+	 * on well-defined single instructions listed in the exception
+	 * tables.  But, an erroneous kernel fault occurring outside one of
+	 * those areas which also holds mmap_sem might deadlock attempting
+	 * to validate the fault against the address space.
 	 *
-	 * As the vast majority of faults will be valid we will only perform
-	 * the source reference check when there is a possibility of a
-	 * deadlock. Attempt to lock the address space, if we cannot we then
-	 * validate the source. If this is invalid we can skip the address
-	 * space check, thus avoiding the deadlock:
+	 * Only do the expensive exception table search when we might be at
+	 * risk of a deadlock.  This happens if we
+	 * 1. Failed to acquire mmap_sem, and
+	 * 2. The access did not originate in userspace.  Note: either the
+	 *    hardware or earlier page fault code may set X86_PF_USER
+	 *    in sw_error_code.
 	 */
 	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
 		if (!(sw_error_code & X86_PF_USER) &&
 		    !search_exception_tables(regs->ip)) {
+			/*
+			 * Fault from code in kernel from
+			 * which we do not expect faults.
+			 */
 			bad_area_nosemaphore(regs, sw_error_code, address, NULL);
 			return;
 		}
_
