Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF90C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A57C214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A57C214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJIWXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:23:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59127 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeJIWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:23:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99F5tGP1083804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:05:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99F5sGt1083801;
        Tue, 9 Oct 2018 08:05:54 -0700
Date:   Tue, 9 Oct 2018 08:05:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-367e3f1d3fc9bbf1e626da7aea527f40babf8079@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, jannh@google.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, luto@kernel.org,
        sean.j.christopherson@intel.com
Reply-To: tglx@linutronix.de, dave.hansen@linux.intel.com,
          sean.j.christopherson@intel.com, jannh@google.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, luto@kernel.org,
          peterz@infradead.org, mingo@kernel.org
In-Reply-To: <20180928160231.243A0D6A@viggo.jf.intel.com>
References: <20180928160231.243A0D6A@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Remove spurious fault pkey check
Git-Commit-ID: 367e3f1d3fc9bbf1e626da7aea527f40babf8079
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  367e3f1d3fc9bbf1e626da7aea527f40babf8079
Gitweb:     https://git.kernel.org/tip/367e3f1d3fc9bbf1e626da7aea527f40babf8079
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 28 Sep 2018 09:02:31 -0700
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:16 +0200

x86/mm: Remove spurious fault pkey check

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

Cc: x86@kernel.org
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180928160231.243A0D6A@viggo.jf.intel.com
---
 arch/x86/mm/fault.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7e0fa7e24168..a16652982f98 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1037,12 +1037,6 @@ static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
 
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
@@ -1217,6 +1211,13 @@ static void
 do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		   unsigned long address)
 {
+	/*
+	 * Protection keys exceptions only happen on user pages.  We
+	 * have no user pages in the kernel portion of the address
+	 * space, so do not expect them here.
+	 */
+	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+
 	/*
 	 * We can fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
