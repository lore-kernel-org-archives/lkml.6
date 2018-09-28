Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A37C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096F7206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096F7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbeI1Wao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:30:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:30614 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729025AbeI1Wan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:30:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 09:06:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="74666756"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2018 09:06:11 -0700
Subject: [PATCH 6/8] x86/mm: add vsyscall address helper
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org,
        jannh@google.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 28 Sep 2018 09:02:28 -0700
References: <20180928160219.3402F0AA@viggo.jf.intel.com>
In-Reply-To: <20180928160219.3402F0AA@viggo.jf.intel.com>
Message-Id: <20180928160228.C593509B@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

We will shortly be using this check in two locations.  Put it in
a helper before we do so.

Let's also insert PAGE_MASK instead of the open-coded ~0xfff.
It is easier to read and also more obviously correct considering
the implicit type conversion that has to happen when it is not
an implicit 'unsigned long'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---

 b/arch/x86/mm/fault.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff -puN arch/x86/mm/fault.c~is-vsyscall-addr arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~is-vsyscall-addr	2018-09-27 10:17:23.988343565 -0700
+++ b/arch/x86/mm/fault.c	2018-09-27 10:17:23.992343565 -0700
@@ -842,6 +842,15 @@ show_signal_msg(struct pt_regs *regs, un
 	show_opcodes(regs, loglvl);
 }
 
+/*
+ * The (legacy) vsyscall page is the long page in the kernel portion
+ * of the address space that has user-accessible permissions.
+ */
+static bool is_vsyscall_vaddr(unsigned long vaddr)
+{
+	return (vaddr & PAGE_MASK) == VSYSCALL_ADDR;
+}
+
 static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address, u32 *pkey, int si_code)
@@ -871,7 +880,7 @@ __bad_area_nosemaphore(struct pt_regs *r
 		 * emulation.
 		 */
 		if (unlikely((error_code & X86_PF_INSTR) &&
-			     ((address & ~0xfff) == VSYSCALL_ADDR))) {
+			     is_vsyscall_vaddr(address))) {
 			if (emulate_vsyscall(regs, address))
 				return;
 		}
_
