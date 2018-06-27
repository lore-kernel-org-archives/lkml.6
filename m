Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C84C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2370926612
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2370926612
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933970AbeF0JIP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:08:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41907 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932187AbeF0JIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:08:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5R97bOL2025705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Jun 2018 02:07:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5R97bTp2025702;
        Wed, 27 Jun 2018 02:07:37 -0700
Date:   Wed, 27 Jun 2018 02:07:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-ec348020566009d3da9b99f07c05814d13969c78@git.kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        bp@alien8.de, tglx@linutronix.de, luto@kernel.org
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, luto@kernel.org,
          tglx@linutronix.de, peterz@infradead.org, bp@alien8.de
In-Reply-To: <86e7fd3564497f657de30a36da4505799eebef01.1530076529.git.luto@kernel.org>
References: <86e7fd3564497f657de30a36da4505799eebef01.1530076529.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] selftests/x86/sigreturn/64: Fix spurious failures
 on AMD CPUs
Git-Commit-ID: ec348020566009d3da9b99f07c05814d13969c78
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

Commit-ID:  ec348020566009d3da9b99f07c05814d13969c78
Gitweb:     https://git.kernel.org/tip/ec348020566009d3da9b99f07c05814d13969c78
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 26 Jun 2018 22:17:17 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 27 Jun 2018 09:36:56 +0200

selftests/x86/sigreturn/64: Fix spurious failures on AMD CPUs

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
---
 tools/testing/selftests/x86/sigreturn.c | 46 +++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 246145b84a12..2559e2c01793 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -612,19 +612,38 @@ static int test_valid_sigreturn(int cs_bits, bool use_16bit_ss, int force_ss)
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
@@ -663,13 +682,6 @@ static int test_valid_sigreturn(int cs_bits, bool use_16bit_ss, int force_ss)
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
