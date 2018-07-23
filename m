Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69E1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F9D20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F9D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbeGWNqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:46:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbeGWNqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:46:10 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51B16BCF;
        Mon, 23 Jul 2018 12:44:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 048/107] x86/nospec: Simplify alternative_msr_write()
Date:   Mon, 23 Jul 2018 14:41:42 +0200
Message-Id: <20180723122415.293766993@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 1aa7a5735a41418d8e01fa7c9565eb2657e2ea3f upstream

The macro is not type safe and I did look for why that "g" constraint for
the asm doesn't work: it's because the asm is more fundamentally wrong.

It does

        movl %[val], %%eax

but "val" isn't a 32-bit value, so then gcc will pass it in a register,
and generate code like

        movl %rsi, %eax

and gas will complain about a nonsensical 'mov' instruction (it's moving a
64-bit register to a 32-bit one).

Passing it through memory will just hide the real bug - gcc still thinks
the memory location is 64-bit, but the "movl" will only load the first 32
bits and it all happens to work because x86 is little-endian.

Convert it to a type safe inline function with a little trick which hands
the feature into the ALTERNATIVE macro.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/nospec-branch.h |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -195,15 +195,16 @@ static inline void vmexit_fill_RSB(void)
 #endif
 }
 
-#define alternative_msr_write(_msr, _val, _feature)		\
-	asm volatile(ALTERNATIVE("",				\
-				 "movl %[msr], %%ecx\n\t"	\
-				 "movl %[val], %%eax\n\t"	\
-				 "movl $0, %%edx\n\t"		\
-				 "wrmsr",			\
-				 _feature)			\
-		     : : [msr] "i" (_msr), [val] "i" (_val)	\
-		     : "eax", "ecx", "edx", "memory")
+static __always_inline
+void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
+{
+	asm volatile(ALTERNATIVE("", "wrmsr", %c[feature])
+		: : "c" (msr),
+		    "a" (val),
+		    "d" (val >> 32),
+		    [feature] "i" (feature)
+		: "memory");
+}
 
 static inline void indirect_branch_prediction_barrier(void)
 {


