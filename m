Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE07BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6242920989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6242920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeIXPMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:12:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37233 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeIXPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:12:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Mtj-0002tO-HU; Mon, 24 Sep 2018 03:11:19 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Mti-0002zU-BO; Mon, 24 Sep 2018 03:11:19 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 11:10:02 +0200
Message-Id: <20180924091015.4458-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
X-XM-SPF: eid=1g4Mti-0002zU-BO;;;mid=<20180924091015.4458-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Kjlqe2DPFdpnQjU3W7JnXyaapczknfxA=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 02/15] signal/arm64: Remove unneeded tsk parameter from arm64_force_sig_info
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every caller passes in current for tsk so there is no need to pass
tsk.  Instead make tsk a local variable initialized to current.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/include/asm/traps.h     | 3 +--
 arch/arm64/kernel/debug-monitors.c | 2 +-
 arch/arm64/kernel/ptrace.c         | 2 +-
 arch/arm64/kernel/traps.c          | 8 ++++----
 arch/arm64/mm/fault.c              | 2 +-
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index c320f3bf6c57..cd3a2ca9c179 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -37,8 +37,7 @@ void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 void force_signal_inject(int signal, int code, unsigned long address);
 void arm64_notify_segfault(unsigned long addr);
-void arm64_force_sig_info(struct siginfo *info, const char *str,
-			  struct task_struct *tsk);
+void arm64_force_sig_info(struct siginfo *info, const char *str);
 
 /*
  * Move regs->pc to next instruction and do necessary setup before it
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 06ca574495af..e0d9502be5bf 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -224,7 +224,7 @@ static void send_user_sigtrap(int si_code)
 	if (interrupts_enabled(regs))
 		local_irq_enable();
 
-	arm64_force_sig_info(&info, "User debug trap", current);
+	arm64_force_sig_info(&info, "User debug trap");
 }
 
 static int single_step_handler(unsigned long addr, unsigned int esr,
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6219486fa25f..20b68cb31ecb 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -211,7 +211,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 		force_sig_ptrace_errno_trap(si_errno, (void __user *)bkpt->trigger);
 	}
 #endif
-	arm64_force_sig_info(&info, "Hardware breakpoint trap (ptrace)", current);
+	arm64_force_sig_info(&info, "Hardware breakpoint trap (ptrace)");
 }
 
 /*
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 459eb6fb7158..24035d124608 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -231,9 +231,9 @@ static bool show_unhandled_signals_ratelimited(void)
 	return show_unhandled_signals && __ratelimit(&rs);
 }
 
-void arm64_force_sig_info(struct siginfo *info, const char *str,
-			  struct task_struct *tsk)
+void arm64_force_sig_info(struct siginfo *info, const char *str)
 {
+	struct task_struct *tsk = current;
 	unsigned int esr = tsk->thread.fault_code;
 	struct pt_regs *regs = task_pt_regs(tsk);
 
@@ -273,7 +273,7 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 		info.si_code  = sicode;
 		info.si_addr  = addr;
 
-		arm64_force_sig_info(&info, str, current);
+		arm64_force_sig_info(&info, str);
 	} else {
 		die(str, regs, err);
 	}
@@ -630,7 +630,7 @@ asmlinkage void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr)
 	current->thread.fault_address = 0;
 	current->thread.fault_code = esr;
 
-	arm64_force_sig_info(&info, "Bad EL0 synchronous exception", current);
+	arm64_force_sig_info(&info, "Bad EL0 synchronous exception");
 }
 
 #ifdef CONFIG_VMAP_STACK
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 86fe70d8722f..f42aff0e90ad 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -352,7 +352,7 @@ static void __do_user_fault(struct siginfo *info, unsigned int esr)
 	}
 
 	current->thread.fault_code = esr;
-	arm64_force_sig_info(info, esr_to_fault_info(esr)->name, current);
+	arm64_force_sig_info(info, esr_to_fault_info(esr)->name);
 }
 
 static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *regs)
-- 
2.17.1

