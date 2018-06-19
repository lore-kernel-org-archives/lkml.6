Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2341FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D379D20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="isZngdXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D379D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967203AbeFSQNy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966985AbeFSQNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:13:44 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 747D620652;
        Tue, 19 Jun 2018 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424824;
        bh=nY3Er1ZJa+y6dcYWwtt3kl8FwaUKbQKDaps+V5TkIdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isZngdXIuTEDtn8JWzZlUbCtfR3sd+zDoM9PR+H4NrgTH5YKPE0thlW/R2pHjA5to
         r8BSpmqRSfKLvWAaEyc2qj4q9SRJptehykIcmlnsS7shlj5HqOmq7iTCpn6EBgGGQO
         VqKwFvQ5Vb0Gxist4iJ8N2Y63J1D3UNyxa5XiJsI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH -tip v6 19/27] ia64: kprobes: Don't call the ->break_handler() in ia64 kprobes code
Date:   Wed, 20 Jun 2018 01:13:20 +0900
Message-Id: <152942480045.15209.10715901482832337704.stgit@devbox>
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

Don't call the ->break_handler() from the ia64 kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/include/uapi/asm/break.h |    1 -
 arch/ia64/kernel/kprobes.c         |   10 ----------
 2 files changed, 11 deletions(-)

diff --git a/arch/ia64/include/uapi/asm/break.h b/arch/ia64/include/uapi/asm/break.h
index 5d742bcb0018..4ca110f0a94b 100644
--- a/arch/ia64/include/uapi/asm/break.h
+++ b/arch/ia64/include/uapi/asm/break.h
@@ -14,7 +14,6 @@
  */
 #define __IA64_BREAK_KDB		0x80100
 #define __IA64_BREAK_KPROBE		0x81000 /* .. 0x81fff */
-#define __IA64_BREAK_JPROBE		0x82000
 
 /*
  * OS-specific break numbers:
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 823e4bd03a18..74c8524e6309 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -817,14 +817,6 @@ static int __kprobes pre_kprobes_handler(struct die_args *args)
 			prepare_ss(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
-		} else if (args->err == __IA64_BREAK_JPROBE) {
-			/*
-			 * jprobe instrumented function just completed
-			 */
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs)) {
-				goto ss_probe;
-			}
 		} else if (!is_ia64_break_inst(regs)) {
 			/* The breakpoint instruction was removed by
 			 * another cpu right after we hit, no further
@@ -867,7 +859,6 @@ static int __kprobes pre_kprobes_handler(struct die_args *args)
 		 */
 		return 1;
 
-ss_probe:
 #if !defined(CONFIG_PREEMPT)
 	if (p->ainsn.inst_flag == INST_FLAG_BOOSTABLE && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
@@ -990,7 +981,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	case DIE_BREAK:
 		/* err is break number from ia64_bad_break() */
 		if ((args->err >> 12) == (__IA64_BREAK_KPROBE >> 12)
-			|| args->err == __IA64_BREAK_JPROBE
 			|| args->err == 0)
 			if (pre_kprobes_handler(args))
 				ret = NOTIFY_STOP;

