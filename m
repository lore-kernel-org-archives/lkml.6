Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0xmEDjxaGVucDgAAmS7hNA
	; Thu, 07 Jun 2018 16:15:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 292AC608BF; Thu,  7 Jun 2018 16:15:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 895B660590;
	Thu,  7 Jun 2018 16:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 895B660590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936127AbeFGQPk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:15:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39110 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932886AbeFGOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:58 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zi-FI; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaw-0002g7-VA; Thu, 07 Jun 2018 15:08:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Date: Thu, 07 Jun 2018 15:05:20 +0100
Message-ID: <lsq.1528380320.295279124@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 001/410] MIPS: Normalise code flow in the CpU
 exception handler
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit 27e28e8ec47a5ce335ebf25d34ca356c80635908 upstream.

Changes applied to `do_cpu' over time reduced the use of the SIGILL
issued with `force_sig' at the end to a single CU3 case only in the
switch statement there.  Move that `force_sig' call over to right where
required then and toss out the pile of gotos now not needed to skip over
the call, replacing them with regular breaks out of the switch.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9683/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/traps.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1247,7 +1247,7 @@ asmlinkage void do_cpu(struct pt_regs *r
 		status = -1;
 
 		if (unlikely(compute_return_epc(regs) < 0))
-			goto out;
+			break;
 
 		if (get_isa16_mode(regs->cp0_epc)) {
 			unsigned short mmop[2] = { 0 };
@@ -1280,7 +1280,7 @@ asmlinkage void do_cpu(struct pt_regs *r
 			force_sig(status, current);
 		}
 
-		goto out;
+		break;
 
 	case 3:
 		/*
@@ -1296,8 +1296,10 @@ asmlinkage void do_cpu(struct pt_regs *r
 		 * erroneously too, so they are covered by this choice
 		 * as well.
 		 */
-		if (raw_cpu_has_fpu)
+		if (raw_cpu_has_fpu) {
+			force_sig(SIGILL, current);
 			break;
+		}
 		/* Fall through.  */
 
 	case 1:
@@ -1320,16 +1322,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 		if (!process_fpemu_return(sig, fault_addr, fcr31) && !err)
 			mt_ase_fp_affinity();
 
-		goto out;
+		break;
 
 	case 2:
 		raw_notifier_call_chain(&cu2_chain, CU2_EXCEPTION, regs);
-		goto out;
+		break;
 	}
 
-	force_sig(SIGILL, current);
-
-out:
 	exception_exit(prev_state);
 }
 
