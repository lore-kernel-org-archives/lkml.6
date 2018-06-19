Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69CFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02A220661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpkA1gFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02A220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967092AbeFSQKY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966649AbeFSQKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:10:22 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E047720652;
        Tue, 19 Jun 2018 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424621;
        bh=xrMUwXsbqe2tYKGRqCLTW5tN1nhbViiwWRxkTGr7/ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpkA1gFykiwYWPumwnFmGBDvtUm7Gw3tvey4Uv0zayCs+SnoNAyTfv/1Mq42sCHQx
         ZwZ2VRRH/EjTo+G1xy0dB0D8lBvNoBDNgLxPHvS6kxItEtyVGxEH+nxJ2LWt1CAP6a
         oQjcWNdRywB5JusSiydQ/8x81fFdcQxxT0eFZdwU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH -tip v6 12/27] sparc64: kprobes: Remove jprobe implementation
Date:   Wed, 20 Jun 2018 01:09:58 +0900
Message-Id: <152942459795.15209.9736720668494241853.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/sparc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/kprobes.h |    1 -
 arch/sparc/kernel/kprobes.c      |   47 --------------------------------------
 2 files changed, 48 deletions(-)

diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
index 3704490b4488..bfcaa6326c20 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -44,7 +44,6 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_status;
 	unsigned long kprobe_orig_tnpc;
 	unsigned long kprobe_orig_tstate_pil;
-	struct pt_regs jprobe_saved_regs;
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index ab4ba4347941..f555711da8f1 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -441,53 +441,6 @@ asmlinkage void __kprobes kprobe_trap(unsigned long trap_level,
 	exception_exit(prev_state);
 }
 
-/* Jprobes support.  */
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	memcpy(&(kcb->jprobe_saved_regs), regs, sizeof(*regs));
-
-	regs->tpc  = (unsigned long) jp->entry;
-	regs->tnpc = ((unsigned long) jp->entry) + 0x4UL;
-	regs->tstate |= TSTATE_PIL;
-
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	register unsigned long orig_fp asm("g1");
-
-	orig_fp = kcb->jprobe_saved_regs.u_regs[UREG_FP];
-	__asm__ __volatile__("\n"
-"1:	cmp		%%sp, %0\n\t"
-	"blu,a,pt	%%xcc, 1b\n\t"
-	" restore\n\t"
-	".globl		jprobe_return_trap_instruction\n"
-"jprobe_return_trap_instruction:\n\t"
-	"ta		0x70"
-	: /* no outputs */
-	: "r" (orig_fp));
-}
-
-extern void jprobe_return_trap_instruction(void);
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	u32 *addr = (u32 *) regs->tpc;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (addr == (u32 *) jprobe_return_trap_instruction) {
-		memcpy(regs, &(kcb->jprobe_saved_regs), sizeof(*regs));
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-
 /* The value stored in the return address register is actually 2
  * instructions before where the callee will return to.
  * Sequences usually look something like this

