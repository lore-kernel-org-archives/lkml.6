Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF32CC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE0F21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE0F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJIWWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:22:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37407 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:22:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99F4mVs1083599
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:04:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99F4m5D1083596;
        Tue, 9 Oct 2018 08:04:48 -0700
Date:   Tue, 9 Oct 2018 08:04:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-02e983b760c0d4183c28d625a3c99016e2cd8a7f@git.kernel.org>
Cc:     peterz@infradead.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, sean.j.christopherson@intel.com,
        jannh@google.com
Reply-To: peterz@infradead.org, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com,
          sean.j.christopherson@intel.com, jannh@google.com
In-Reply-To: <20180928160228.C593509B@viggo.jf.intel.com>
References: <20180928160228.C593509B@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Add vsyscall address helper
Git-Commit-ID: 02e983b760c0d4183c28d625a3c99016e2cd8a7f
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

Commit-ID:  02e983b760c0d4183c28d625a3c99016e2cd8a7f
Gitweb:     https://git.kernel.org/tip/02e983b760c0d4183c28d625a3c99016e2cd8a7f
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 28 Sep 2018 09:02:28 -0700
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:16 +0200

x86/mm: Add vsyscall address helper

We will shortly be using this check in two locations.  Put it in
a helper before we do so.

Let's also insert PAGE_MASK instead of the open-coded ~0xfff.
It is easier to read and also more obviously correct considering
the implicit type conversion that has to happen when it is not
an implicit 'unsigned long'.

Cc: x86@kernel.org
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180928160228.C593509B@viggo.jf.intel.com
---
 arch/x86/mm/fault.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 57b074b02ebb..7a627ac3a0d2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -840,6 +840,15 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
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
@@ -869,7 +878,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		 * emulation.
 		 */
 		if (unlikely((error_code & X86_PF_INSTR) &&
-			     ((address & ~0xfff) == VSYSCALL_ADDR))) {
+			     is_vsyscall_vaddr(address))) {
 			if (emulate_vsyscall(regs, address))
 				return;
 		}
