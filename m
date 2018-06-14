Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5CE9EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A3E205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A3E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965217AbeFNXxy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:53:54 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:53754 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965144AbeFNXxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:53:50 -0400
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 14 Jun 2018 23:53:28 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 14
 Jun 2018 16:53:08 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Thu, 14 Jun 2018 16:53:07 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 1/4] MIPS: Add support for restartable sequences
Date:   Thu, 14 Jun 2018 16:52:07 -0700
Message-ID: <20180614235211.31357-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614235211.31357-1-paul.burton@mips.com>
References: <20180614235211.31357-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529020407-321459-9504-17803-1
X-BESS-VER: 2018.7-r1806112253
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194071
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,peterz@infradead.org,jhogan@kernel.org,linux-kernel@vger.kernel.org,mathieu.desnoyers@efficios.com,boqun.feng@gmail.com,paulmck@linux.vnet.ibm.com,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for restartable sequences on MIPS, which requires 3
simple things:

  - Call rseq_handle_notify_resume() on return to userspace if
    TIF_NOTIFY_RESUME is set.

  - Call rseq_signal_deliver() to fixup the pre-signal stack frame when
    a signal is delivered whilst executing a restartable sequence
    critical section.

  - Select CONFIG_HAVE_RSEQ.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---

 arch/mips/Kconfig         | 1 +
 arch/mips/kernel/signal.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fe98e459a416..afe2b0c867ac 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -66,6 +66,7 @@ config MIPS
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 9e224469c788..00f2535d2226 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -801,6 +801,8 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		regs->regs[0] = 0;		/* Don't deal with this again.	*/
 	}
 
+	rseq_signal_deliver(regs);
+
 	if (sig_uses_siginfo(&ksig->ka, abi))
 		ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
 					  ksig, regs, oldset);
@@ -868,6 +870,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(regs);
 	}
 
 	user_enter();
-- 
2.17.1

