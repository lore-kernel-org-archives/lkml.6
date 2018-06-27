Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E24C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE55214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2M8J1Jck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE55214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeF0FRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeF0FRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:17:21 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD1D241B9;
        Wed, 27 Jun 2018 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530076641;
        bh=6luoUBPnW/LEAw4V6dgVuQSTSWEb77C+BCjlSb1LlVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=2M8J1Jcku/3KoYVO/MG0ZQg3HxlYhhK+1orv/iNh3kGIb4ee/lm1QY7+Ctw9x1pQP
         N2Gib28UysDaZ6VmJxBMlzW5hsMit5DWWvAlbajBn0rDC+Kbt12AOdX1sZnhOIO9DI
         UOvmWUIkYnlcMPp2t9tBYPt27r6JI674MaP/KkVc=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/2] selftests/x86/sigreturn/64: Fix spurious failures on AMD CPUs
Date:   Tue, 26 Jun 2018 22:17:17 -0700
Message-Id: <86e7fd3564497f657de30a36da4505799eebef01.1530076529.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1530076529.git.luto@kernel.org>
References: <cover.1530076529.git.luto@kernel.org>
In-Reply-To: <cover.1530076529.git.luto@kernel.org>
References: <cover.1530076529.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I wrote the sigreturn test, I didn't realize that AMD's busted
IRET behavior was different from Intel's busted IRET behavior.  On
AMD CPUs, the CPU leaks the high 32 bits of the kernel stack pointer
to certain userspace contexts.  Gee, thanks.  There's very little
the kernel can do about it.  Modify the test so it passes.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/sigreturn.c | 46 ++++++++++++++++---------
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
-- 
2.17.1

