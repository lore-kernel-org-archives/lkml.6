Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E509C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFA521480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFA521480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeIXUYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:24:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:36103 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbeIXUYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:24:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Rkk-0004AS-NI; Mon, 24 Sep 2018 08:22:22 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Rkj-000588-4F; Mon, 24 Sep 2018 08:22:22 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 16:21:41 +0200
Message-Id: <20180924142143.21356-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87pnx32j2p.fsf@xmission.com>
References: <87pnx32j2p.fsf@xmission.com>
X-XM-SPF: eid=1g4Rkj-000588-4F;;;mid=<20180924142143.21356-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18LK7dpIxzrAH58b8ME4Ikxvd8xPLARVFc=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 1/3] signal/ia64: Use the generic force_sigsegv in setup_frame
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ia64 handling of failure to setup a signal frame has been trying
to set overlapping fields in struct siginfo since 2.3.43.  The si_pid
and si_uid fields are stomped when the si_addr field is set.  The
si_code of SI_KERNEL indicates that si_pid and si_uid should be valid,
and that si_addr does not exist.

Being at odds with the definition of SI_KERNEL and with nothing to
indicate that this was a signal frame setup failure there is no way
for userspace to know that si_addr was filled out instead.

In practice failure to setup a signal frame is rare, and si_pid and
si_uid are always set to 0 when si_code is SI_KERNEL so I expect no
one has looked closely enough before to see this weirdness.  Further
the only difference between force_sigsegv_info and the generic
force_sigsegv other than the return code is that force_sigsegv_info
stomps the si_uid and si_pid fields.

Remove the bug and simplify the code by using force_sigsegv in this
case just like other architectures.

Fixes: 2.3.43
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/kernel/signal.c | 50 ++++++++++-----------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
index d1234a5ba4c5..01fc133b2e4c 100644
--- a/arch/ia64/kernel/signal.c
+++ b/arch/ia64/kernel/signal.c
@@ -231,37 +231,6 @@ rbs_on_sig_stack (unsigned long bsp)
 	return (bsp - current->sas_ss_sp < current->sas_ss_size);
 }
 
-static long
-force_sigsegv_info (int sig, void __user *addr)
-{
-	unsigned long flags;
-	struct siginfo si;
-
-	clear_siginfo(&si);
-	if (sig == SIGSEGV) {
-		/*
-		 * Acquiring siglock around the sa_handler-update is almost
-		 * certainly overkill, but this isn't a
-		 * performance-critical path and I'd rather play it safe
-		 * here than having to debug a nasty race if and when
-		 * something changes in kernel/signal.c that would make it
-		 * no longer safe to modify sa_handler without holding the
-		 * lock.
-		 */
-		spin_lock_irqsave(&current->sighand->siglock, flags);
-		current->sighand->action[sig - 1].sa.sa_handler = SIG_DFL;
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
-	}
-	si.si_signo = SIGSEGV;
-	si.si_errno = 0;
-	si.si_code = SI_KERNEL;
-	si.si_pid = task_pid_vnr(current);
-	si.si_uid = from_kuid_munged(current_user_ns(), current_uid());
-	si.si_addr = addr;
-	force_sig_info(SIGSEGV, &si, current);
-	return 1;
-}
-
 static long
 setup_frame(struct ksignal *ksig, sigset_t *set, struct sigscratch *scr)
 {
@@ -295,15 +264,18 @@ setup_frame(struct ksignal *ksig, sigset_t *set, struct sigscratch *scr)
 			 * instead so we will die with SIGSEGV.
 			 */
 			check_sp = (new_sp - sizeof(*frame)) & -STACK_ALIGN;
-			if (!likely(on_sig_stack(check_sp)))
-				return force_sigsegv_info(ksig->sig, (void __user *)
-							  check_sp);
+			if (!likely(on_sig_stack(check_sp))) {
+				force_sigsegv(ksig->sig, current);
+				return 1;
+			}
 		}
 	}
 	frame = (void __user *) ((new_sp - sizeof(*frame)) & -STACK_ALIGN);
 
-	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		return force_sigsegv_info(ksig->sig, frame);
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame))) {
+		force_sigsegv(ksig->sig, current);
+		return 1;
+	}
 
 	err  = __put_user(ksig->sig, &frame->arg0);
 	err |= __put_user(&frame->info, &frame->arg1);
@@ -317,8 +289,10 @@ setup_frame(struct ksignal *ksig, sigset_t *set, struct sigscratch *scr)
 	err |= __save_altstack(&frame->sc.sc_stack, scr->pt.r12);
 	err |= setup_sigcontext(&frame->sc, set, scr);
 
-	if (unlikely(err))
-		return force_sigsegv_info(ksig->sig, frame);
+	if (unlikely(err)) {
+		force_sigsegv(ksig->sig, current);
+		return 1;
+	}
 
 	scr->pt.r12 = (unsigned long) frame - 16;	/* new stack pointer */
 	scr->pt.ar_fpsr = FPSR_DEFAULT;			/* reset fpsr for signal handler */
-- 
2.17.1

