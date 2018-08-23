Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228A5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9590208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9590208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbeHWMlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:41:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbeHWMl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:41:29 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33799AF3;
        Thu, 23 Aug 2018 09:12:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 101/217] selftests/x86/sigreturn/64: Fix spurious failures on AMD CPUs
Date:   Thu, 23 Aug 2018 09:53:34 +0200
Message-Id: <20180823075510.046538704@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

[ Upstream commit ec348020566009d3da9b99f07c05814d13969c78 ]

When I wrote the sigreturn test, I didn't realize that AMD's busted
IRET behavior was different from Intel's busted IRET behavior:

On AMD CPUs, the CPU leaks the high 32 bits of the kernel stack pointer
to certain userspace contexts.  Gee, thanks.  There's very little
the kernel can do about it.  Modify the test so it passes.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/86e7fd3564497f657de30a36da4505799eebef01.1530076529.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/x86/sigreturn.c |   46 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 17 deletions(-)

--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -612,19 +612,38 @@ static int test_valid_sigreturn(int cs_b
 		greg_t req = requested_regs[i], res = resulting_regs[i];
 		if (i == REG_TRAPNO || i == REG_IP)
 			continue;	/* don't care */
-		if (i == REG_SP) {
-			printf("\tSP: %llx -> %llx\n", (unsigned long long)req,
-			       (unsigned long long)res);
 
+		if (i == REG_SP) {
 			/*
-			 * In many circumstances, the high 32 bits of rsp
-			 * are zeroed.  For example, we could be a real
-			 * 32-bit program, or we could hit any of a number
-			 * of poorly-documented IRET or segmented ESP
-			 * oddities.  If this happens, it's okay.
+			 * If we were using a 16-bit stack segment, then
+			 * the kernel is a bit stuck: IRET only restores
+			 * the low 16 bits of ESP/RSP if SS is 16-bit.
+			 * The kernel uses a hack to restore bits 31:16,
+			 * but that hack doesn't help with bits 63:32.
+			 * On Intel CPUs, bits 63:32 end up zeroed, and, on
+			 * AMD CPUs, they leak the high bits of the kernel
+			 * espfix64 stack pointer.  There's very little that
+			 * the kernel can do about it.
+			 *
+			 * Similarly, if we are returning to a 32-bit context,
+			 * the CPU will often lose the high 32 bits of RSP.
 			 */
-			if (res == (req & 0xFFFFFFFF))
-				continue;  /* OK; not expected to work */
+
+			if (res == req)
+				continue;
+
+			if (cs_bits != 64 && ((res ^ req) & 0xFFFFFFFF) == 0) {
+				printf("[NOTE]\tSP: %llx -> %llx\n",
+				       (unsigned long long)req,
+				       (unsigned long long)res);
+				continue;
+			}
+
+			printf("[FAIL]\tSP mismatch: requested 0x%llx; got 0x%llx\n",
+			       (unsigned long long)requested_regs[i],
+			       (unsigned long long)resulting_regs[i]);
+			nerrs++;
+			continue;
 		}
 
 		bool ignore_reg = false;
@@ -663,13 +682,6 @@ static int test_valid_sigreturn(int cs_b
 		}
 
 		if (requested_regs[i] != resulting_regs[i] && !ignore_reg) {
-			/*
-			 * SP is particularly interesting here.  The
-			 * usual cause of failures is that we hit the
-			 * nasty IRET case of returning to a 16-bit SS,
-			 * in which case bits 16:31 of the *kernel*
-			 * stack pointer persist in ESP.
-			 */
 			printf("[FAIL]\tReg %d mismatch: requested 0x%llx; got 0x%llx\n",
 			       i, (unsigned long long)requested_regs[i],
 			       (unsigned long long)resulting_regs[i]);


