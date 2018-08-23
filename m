Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B1FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8552147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8552147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeHWL6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:58:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeHWL6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:58:20 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 036BA8B1;
        Thu, 23 Aug 2018 08:29:47 +0000 (UTC)
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
Subject: [PATCH 4.14 102/217] selftests/x86/sigreturn: Do minor cleanups
Date:   Thu, 23 Aug 2018 09:53:35 +0200
Message-Id: <20180823075510.087218384@linuxfoundation.org>
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

[ Upstream commit e8a445dea219c32727016af14f847d2e8f7ebec8 ]

We have short names for the requested and resulting register values.
Use them instead of spelling out the whole register entry for each
case.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/bb3bc1f923a2f6fe7912d22a1068fe29d6033d38.1530076529.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/x86/sigreturn.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -610,6 +610,7 @@ static int test_valid_sigreturn(int cs_b
 	 */
 	for (int i = 0; i < NGREG; i++) {
 		greg_t req = requested_regs[i], res = resulting_regs[i];
+
 		if (i == REG_TRAPNO || i == REG_IP)
 			continue;	/* don't care */
 
@@ -673,18 +674,18 @@ static int test_valid_sigreturn(int cs_b
 #endif
 
 		/* Sanity check on the kernel */
-		if (i == REG_CX && requested_regs[i] != resulting_regs[i]) {
+		if (i == REG_CX && req != res) {
 			printf("[FAIL]\tCX (saved SP) mismatch: requested 0x%llx; got 0x%llx\n",
-			       (unsigned long long)requested_regs[i],
-			       (unsigned long long)resulting_regs[i]);
+			       (unsigned long long)req,
+			       (unsigned long long)res);
 			nerrs++;
 			continue;
 		}
 
-		if (requested_regs[i] != resulting_regs[i] && !ignore_reg) {
+		if (req != res && !ignore_reg) {
 			printf("[FAIL]\tReg %d mismatch: requested 0x%llx; got 0x%llx\n",
-			       i, (unsigned long long)requested_regs[i],
-			       (unsigned long long)resulting_regs[i]);
+			       i, (unsigned long long)req,
+			       (unsigned long long)res);
 			nerrs++;
 		}
 	}


