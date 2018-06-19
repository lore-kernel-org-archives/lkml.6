Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FB6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992132075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="feZXq5j2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992132075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967181AbeFSQPn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966516AbeFSQPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:15:41 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C176F20652;
        Tue, 19 Jun 2018 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424940;
        bh=bd2cluXv+hyCFQ+NJwo5m4hwGGgkA4vyiSMYY5jvTHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feZXq5j2I53urvZShiVD1urbBNAZ/R+W9GZeOMU/y87l1vCOgaTH17sv2pGmX7G8B
         oZzooRm6jnLa7ko7rQV314Xcv02Y5Fy4EenzdafOXcjBPzc4OnK0lXsDGtvB+4J/OO
         3/T7q7Tqgxx5Qh2J5Gv0h2hbwe8+Z5SbsVPQreIc=
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
Subject: [PATCH -tip v6 23/27] sparc64: kprobes: Don't call the ->break_handler() in sparc64 kprobes code
Date:   Wed, 20 Jun 2018 01:15:17 +0900
Message-Id: <152942491684.15209.8114703769135529984.stgit@devbox>
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

Don't call the ->break_handler() from the sparc64 kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/kprobes.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index f555711da8f1..c684c96ef2e9 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -147,18 +147,12 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 			kcb->kprobe_status = KPROBE_REENTER;
 			prepare_singlestep(p, regs, kcb);
 			return 1;
-		} else {
-			if (*(u32 *)addr != BREAKPOINT_INSTRUCTION) {
+		} else if (*(u32 *)addr != BREAKPOINT_INSTRUCTION) {
 			/* The breakpoint instruction was removed by
 			 * another cpu right after we hit, no further
 			 * handling of this interrupt is appropriate
 			 */
-				ret = 1;
-				goto no_kprobe;
-			}
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs))
-				goto ss_probe;
+			ret = 1;
 		}
 		goto no_kprobe;
 	}
@@ -184,7 +178,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 	if (p->pre_handler && p->pre_handler(p, regs))
 		return 1;
 
-ss_probe:
 	prepare_singlestep(p, regs, kcb);
 	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;

