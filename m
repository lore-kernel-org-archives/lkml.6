Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB40C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6873320661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yLxIVAIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6873320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967207AbeFSQOS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966784AbeFSQON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:14:13 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C6B20652;
        Tue, 19 Jun 2018 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424853;
        bh=8jXNP8vnwcF+TR6+0YdF5rciKwGAeWP5OJuYS69gA/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLxIVAImP7C9sG/k0Jqp/P6CLR6mllstKtjPhO6efPWYgAtpyoj4WneJ+WwLTRu/Q
         Y6/nsdEK04jfSf7WSV3mJznGvvNv6uYfKuAUJ51vzV79ZiGxOCZdyQAy7fAO4XZ7UT
         NLBAV3SUxLRQAIg1zNIk83pBMo0z37/gxDmH82F8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH -tip v6 20/27] MIPS: kprobes: Don't call the ->break_handler() in MIPS kprobes code
Date:   Wed, 20 Jun 2018 01:13:49 +0900
Message-Id: <152942482953.15209.843924518200700137.stgit@devbox>
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

Don't call the ->break_handler() from the MIPS kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/kprobes.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index efdcd0b1ce12..7fd277bc59b9 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -326,19 +326,13 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 				preempt_enable_no_resched();
 			}
 			return 1;
-		} else {
-			if (addr->word != breakpoint_insn.word) {
-				/*
-				 * The breakpoint instruction was removed by
-				 * another cpu right after we hit, no further
-				 * handling of this interrupt is appropriate
-				 */
-				ret = 1;
-				goto no_kprobe;
-			}
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs))
-				goto ss_probe;
+		} else if (addr->word != breakpoint_insn.word) {
+			/*
+			 * The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+			ret = 1;
 		}
 		goto no_kprobe;
 	}
@@ -367,7 +361,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 		return 1;
 	}
 
-ss_probe:
 	prepare_singlestep(p, regs, kcb);
 	if (kcb->flags & SKIP_DELAYSLOT) {
 		kcb->kprobe_status = KPROBE_HIT_SSDONE;

