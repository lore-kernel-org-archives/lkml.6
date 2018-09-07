Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7FA20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7FA20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeIHAeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:34:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:61683 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbeIHAeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:34:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 12:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="81760045"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2018 12:51:32 -0700
Subject: [RFC][PATCH 6/8] x86/mm: add vsyscall address helper
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 07 Sep 2018 12:49:01 -0700
References: <20180907194852.3C351B82@viggo.jf.intel.com>
In-Reply-To: <20180907194852.3C351B82@viggo.jf.intel.com>
Message-Id: <20180907194901.C54A0101@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

We will shortly be using this check in two locations.  Put it in
a helper before we do so.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/arch/x86/mm/fault.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff -puN arch/x86/mm/fault.c~is-vsyscall-addr arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~is-vsyscall-addr	2018-09-07 11:21:48.208751897 -0700
+++ b/arch/x86/mm/fault.c	2018-09-07 11:21:48.211751897 -0700
@@ -841,6 +841,15 @@ show_signal_msg(struct pt_regs *regs, un
 	show_opcodes((u8 *)regs->ip, loglvl);
 }
 
+/*
+ * The (legacy) vsyscall page is the long page in the kernel portion
+ * of the address space that has user-accessible permissions.
+ */
+static bool is_vsyscall_vaddr(unsigned long vaddr)
+{
+	return (vaddr & ~0xfff) == VSYSCALL_ADDR;
+}
+
 static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address, u32 *pkey, int si_code)
@@ -870,7 +879,7 @@ __bad_area_nosemaphore(struct pt_regs *r
 		 * emulation.
 		 */
 		if (unlikely((error_code & X86_PF_INSTR) &&
-			     ((address & ~0xfff) == VSYSCALL_ADDR))) {
+			     is_vsyscall_vaddr(address))) {
 			if (emulate_vsyscall(regs, address))
 				return;
 		}
_
