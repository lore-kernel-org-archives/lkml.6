Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B28DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BF120818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFeMMETB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BF120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbeKLJea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeKLITN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:13 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6652F21508;
        Sun, 11 Nov 2018 22:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975357;
        bh=IH1d2KfKDxiFo1HhZj7IK4gIknAAcIbvQ7+/fclOn6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFeMMETBdat1mezo8aPh9EFiQhmMsT58RaUh80hzCuw+ysNHTqDr0A0vOb+QD1/1S
         AtiyVJWzKivNRJ+G7xAWFpDGe4Rmnn+Hh/XRphhqKFlwBpHRJxCAZlRi1VXdvIZwSB
         iDRPl/zLaiAh8iV4qA1dJ2RqA4bCP+q0LbWOYzkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, dwmw@amazon.co.uk,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.18 023/350] kprobes/x86: Use preempt_enable() in optimized_callback()
Date:   Sun, 11 Nov 2018 14:18:07 -0800
Message-Id: <20181111221708.139574483@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 2e62024c265aa69315ed02835623740030435380 upstream.

The following commit:

  a19b2e3d7839 ("kprobes/x86: Remove IRQ disabling from ftrace-based/optimized kprobes”)

removed local_irq_save/restore() from optimized_callback(), the handler
might be interrupted by the rescheduling interrupt and might be
rescheduled - so we must not use the preempt_enable_no_resched() macro.

Use preempt_enable() instead, to not lose preemption events.

[ mingo: Improved the changelog. ]

Reported-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dwmw@amazon.co.uk
Fixes: a19b2e3d7839 ("kprobes/x86: Remove IRQ disabling from ftrace-based/optimized kprobes”)
Link: http://lkml.kernel.org/r/154002887331.7627.10194920925792947001.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kprobes/opt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -179,7 +179,7 @@ optimized_callback(struct optimized_kpro
 		opt_pre_handler(&op->kp, regs);
 		__this_cpu_write(current_kprobe, NULL);
 	}
-	preempt_enable_no_resched();
+	preempt_enable();
 }
 NOKPROBE_SYMBOL(optimized_callback);
 


