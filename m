Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8404ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD07214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD07214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeIRFhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:37:39 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33552 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeIRFhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:37:39 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23YX-0007OI-5f; Mon, 17 Sep 2018 18:07:53 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23YH-0002Qk-4P; Mon, 17 Sep 2018 18:07:52 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:35 +0200
Message-Id: <20180918000546.12552-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23YH-0002Qk-4P;;;mid=<20180918000546.12552-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18MheS9FfMOJExkxZRZpE3rp0J02dgSLKc=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 09/20] signal/x86/traps: Use force_sig_bnderr
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of generating the siginfo in x86 specific code use the new
helper function force_sig_bnderr to separate the concerns of
collecting the information and generating a proper siginfo.

Making the code easier to understand and maintain.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/traps.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f31c0ddee278..9f7b3831fb7e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -499,8 +499,8 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 		break; /* Success, it was handled */
 	case 1: /* Bound violation. */
 	{
+		struct task_struct *tsk = current;
 		struct mpx_fault_info mpx;
-		struct siginfo info;
 
 		if (mpx_fault_info(&mpx, regs)) {
 			/*
@@ -511,19 +511,18 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 		}
 		/*
 		 * Success, we decoded the instruction and retrieved
-		 * an 'info' containing the address being accessed
+		 * an 'mpx' containing the address being accessed
 		 * which caused the exception.  This information
 		 * allows and application to possibly handle the
 		 * #BR exception itself.
 		 */
-		clear_siginfo(&info);
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		info.si_code  = SEGV_BNDERR;
-		info.si_addr  = mpx.addr;
-		info.si_lower = mpx.lower;
-		info.si_upper = mpx.upper;
-		do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, &info);
+		if (!do_trap_no_signal(tsk, X86_TRAP_BR, "bounds", regs,
+				       error_code))
+			break;
+
+		show_signal(tsk, SIGSEGV, "trap ", "bounds", regs, error_code);
+
+		force_sig_bnderr(mpx.addr, mpx.lower, mpx.upper);
 		break;
 	}
 	case 0: /* No exception caused by Intel MPX operations. */
-- 
2.17.1

