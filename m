Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65608C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E9E25293
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ahGIENnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E9E25293
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeFXQZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:25:48 -0400
Received: from mail.efficios.com ([167.114.142.138]:47662 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeFXQZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 12:25:46 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 20C1E1B7117;
        Sun, 24 Jun 2018 12:25:46 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LxGS8qu6xnlA; Sun, 24 Jun 2018 12:25:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 11E4D1B7113;
        Sun, 24 Jun 2018 12:25:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 11E4D1B7113
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529857545;
        bh=bY3KjjMyn8THvQFNRJ8yz4vvDOS6w3d/cZTLK5O8RGg=;
        h=From:To:Date:Message-Id;
        b=ahGIENnBye8Pl6ITcmSOTlBGItJk6sgCT6Fb9U6ADpSk3cHBBa0X2vphgZQCI83k7
         I2OYdROWV2e/l7u78fBToTOLZtVsQPL+gmwB4En8d/mn4zwsPTvO7KpEA2u6dI7E94
         UxFeEWn+0ufupBNmGg7zm/tb2S7MWIg/v4+qmMtD8L32HUAql7b7TFoKMb4bNO7zl9
         vshLHc4awxT1HqtbLALYyNSk6pozUSVqTRiAplWIBOpGBgYnSrXcDfwoZPg89rcPkl
         9eTH6l7QuSMi82sICpRiuBwGvge6BTerJlYN/k4/FQ3JrzriYdaEh/fUCyd0XbAdJG
         frvKpy0k0AsfQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 6rfPsNUApRl2; Sun, 24 Jun 2018 12:25:45 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id CD9D41B710C;
        Sun, 24 Jun 2018 12:25:44 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH for 4.18] MIPS: adapt to rseq API changes
Date:   Sun, 24 Jun 2018 12:25:13 -0400
Message-Id: <20180624162513.28264-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prototype of rseq_handle_notify_resume() and rseq_signal_deliver()
had to be changed to fix handling of traps occuring on signal delivery.
The API change was merged at the same time as the rseq MIPS port.

Adapt the MIPS port to this API change.

Fixes: 784e0300fe ("rseq: Avoid infinite recursion when delivering SIGSEGV")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org
Cc: paulmck@linux.vnet.ibm.com
Cc: boqun.feng@gmail.com
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
---
 arch/mips/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 00f2535d2226..0a9cfe7a0372 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -801,7 +801,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		regs->regs[0] = 0;		/* Don't deal with this again.	*/
 	}
 
-	rseq_signal_deliver(regs);
+	rseq_signal_deliver(ksig, regs);
 
 	if (sig_uses_siginfo(&ksig->ka, abi))
 		ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
@@ -870,7 +870,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
-		rseq_handle_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
 	}
 
 	user_enter();
-- 
2.11.0

