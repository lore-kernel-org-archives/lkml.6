Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7FDC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA08721527
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA08721527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390271AbeHGTpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:45:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:52649 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388865AbeHGTpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:45:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 10:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="64258384"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.132])
  by orsmga006.jf.intel.com with ESMTP; 07 Aug 2018 10:29:44 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     sean.j.christopherson@intel.com,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86/pkeys: Explicitly treat PK #PF on kernel address as a bad area
Date:   Tue,  7 Aug 2018 10:29:20 -0700
Message-Id: <20180807172920.8766-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel addresses are always mapped with _PAGE_USER=0, i.e. PKRU
isn't enforced, and so we should never see X86_PF_PK set on a
kernel address fault.  WARN once to capture the issue in case we
somehow don't die, e.g. the access originated in userspace.

Remove a similar check and its comment from spurious_fault_check().
The intent of the comment (and later code[1]) was simply to document
that spurious faults due to protection keys should be impossible, but
that's irrelevant and a bit of a red herring since we should never
get a protection keys fault on a kernel address regardless of the
kernel's TLB flushing behavior.

[1] http://lists-archives.com/linux-kernel/28407455-x86-pkeys-new-page-fault-error-code-bit-pf_pk.html

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
---
There's no indication that this condition has ever been encountered.
I came across the code in spurious_fault_check() and was confused as
to why we would unconditionally treat a protection keys fault as
spurious when the comment explicitly stated that such a case should
be impossible.

Dave Hansen suggested adding a WARN_ON_ONCE in spurious_fault_check(),
but it seemed more appropriate to freak out on any protection keys
fault on a kernel address since that would imply a hardware issue or
kernel bug.  I omitted a Suggested-by since this isn't necessarily
what Dave had in mind.

 arch/x86/mm/fault.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2aafa6ab6103..f19a55972136 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1040,12 +1040,6 @@ static int spurious_fault_check(unsigned long error_code, pte_t *pte)
 
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
@@ -1241,6 +1235,14 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	 * protection error (error_code & 9) == 0.
 	 */
 	if (unlikely(fault_in_kernel_space(address))) {
+		/*
+		 * We should never encounter a protection keys fault on a
+		 * kernel address as kernel address are always mapped with
+		 * _PAGE_USER=0, i.e. PKRU isn't enforced.
+		 */
+		if (WARN_ON_ONCE(error_code & X86_PF_PK))
+			goto bad_kernel_address;
+
 		if (!(error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
 			if (vmalloc_fault(address) >= 0)
 				return;
@@ -1253,6 +1255,8 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		/* kprobes don't want to hook the spurious faults: */
 		if (kprobes_fault(regs))
 			return;
+
+bad_kernel_address:
 		/*
 		 * Don't take the mm semaphore here. If we fixup a prefetch
 		 * fault we could otherwise deadlock:
-- 
2.18.0

