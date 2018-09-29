Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CBBC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B095E206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B095E206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeI3ESV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51518 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725738AbeI3ESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:20 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000Gt-BS; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006ou-52; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.450164870@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 001/131] x86/nospec: Simplify alternative_msr_write()
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 1aa7a5735a41418d8e01fa7c9565eb2657e2ea3f upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 19 ++++++++++---------
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

