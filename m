Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE52C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 09:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5522A21523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 09:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xpWP8pPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5522A21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJTR6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 13:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbeJTR6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 13:58:09 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA97A21521;
        Sat, 20 Oct 2018 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540028898;
        bh=8P5+7Uw8egUr/TPahnp3yRc5sRGYzJAh/z0nry+VH7g=;
        h=From:To:Cc:Subject:Date:From;
        b=xpWP8pPqbiHDEEUN9PLXWEO2ErGJ4SSyiAbn88vXvF6CCRLayWFJ3K8nJEvtDhGrR
         TZCdGXbKoZYj67oAGSHMrA8CNA0SSU3iNMT+WmtHDlxOsKvHO3qfTxAkxWzI1vi3Iv
         /oNFM2bPaMsvhGCznOXWHPMIsxlplmlqS6M9y284=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, dwmw@amazon.co.uk,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip] kprobes/x86: Use preempt_enable() in optimized_callback()
Date:   Sat, 20 Oct 2018 18:47:53 +0900
Message-Id: <154002887331.7627.10194920925792947001.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a19b2e3d7839 ("kprobes/x86: Remove IRQ disabling from
ftrace-based/optimized kprobes”) removes local_irq_save/restore()
from optimized_callback(), the handler does not protected against
reschedule interrupt. If it is able to be preempted (rescheduled)
by such interrupt, we don't need to use _no_resched macro.
Let's use preempt_enable() instead.

Fixes: a19b2e3d7839 ("kprobes/x86: Remove IRQ disabling from ftrace-based/optimized kprobes”)
Link: https://lkml.kernel.org/r/37CB98C2-AF9B-475B-8B2D-7B414DC491F3@vmware.com
Reported-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index eaf02f2e7300..40b16b270656 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -179,7 +179,7 @@ optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 		opt_pre_handler(&op->kp, regs);
 		__this_cpu_write(current_kprobe, NULL);
 	}
-	preempt_enable_no_resched();
+	preempt_enable();
 }
 NOKPROBE_SYMBOL(optimized_callback);
 

