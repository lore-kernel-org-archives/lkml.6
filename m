Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D20FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D5620834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D5620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbeLDXGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:06:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35931 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDXGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:06:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB4N5WR61044136
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Dec 2018 15:05:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB4N5V5w1044132;
        Tue, 4 Dec 2018 15:05:31 -0800
Date:   Tue, 4 Dec 2018 15:05:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-43a1b0cb4cd6dbfd3cd9c10da663368394d299d8@git.kernel.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de,
        ravi.bangoria@linux.ibm.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, acme@kernel.org, mhiramat@kernel.org,
        hpa@zytor.com, peterz@infradead.org, michael@rodin.online,
        mingo@kernel.org
Reply-To: rostedt@goodmis.org, acme@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          michael@rodin.online, hpa@zytor.com, mingo@kernel.org,
          mhiramat@kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, ravi.bangoria@linux.ibm.com
In-Reply-To: <153504457253.22602.1314289671019919596.stgit@devbox>
References: <153504457253.22602.1314289671019919596.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] kprobes/x86: Fix instruction patching corruption
 when copying more than one RIP-relative instruction
Git-Commit-ID: 43a1b0cb4cd6dbfd3cd9c10da663368394d299d8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  43a1b0cb4cd6dbfd3cd9c10da663368394d299d8
Gitweb:     https://git.kernel.org/tip/43a1b0cb4cd6dbfd3cd9c10da663368394d299d8
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Fri, 24 Aug 2018 02:16:12 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 4 Dec 2018 09:35:20 +0100

kprobes/x86: Fix instruction patching corruption when copying more than one RIP-relative instruction

After copy_optimized_instructions() copies several instructions
to the working buffer it tries to fix up the real RIP address, but it
adjusts the RIP-relative instruction with an incorrect RIP address
for the 2nd and subsequent instructions due to a bug in the logic.

This will break the kernel pretty badly (with likely outcomes such as
a kernel freeze, a crash, or worse) because probed instructions can refer
to the wrong data.

For example putting kprobes on cpumask_next() typically hits this bug.

cpumask_next() is normally like below if CONFIG_CPUMASK_OFFSTACK=y
(in this case nr_cpumask_bits is an alias of nr_cpu_ids):

 <cpumask_next>:
	48 89 f0		mov    %rsi,%rax
	8b 35 7b fb e2 00	mov    0xe2fb7b(%rip),%esi # ffffffff82db9e64 <nr_cpu_ids>
	55			push   %rbp
...

If we put a kprobe on it and it gets jump-optimized, it gets
patched by the kprobes code like this:

 <cpumask_next>:
	e9 95 7d 07 1e		jmpq   0xffffffffa000207a
	7b fb			jnp    0xffffffff81f8a2e2 <cpumask_next+2>
	e2 00			loop   0xffffffff81f8a2e9 <cpumask_next+9>
	55			push   %rbp

This shows that the first two MOV instructions were copied to a
trampoline buffer at 0xffffffffa000207a.

Here is the disassembled result of the trampoline, skipping
the optprobe template instructions:

	# Dump of assembly code from 0xffffffffa000207a to 0xffffffffa00020ea:

	54			push   %rsp
	...
	48 83 c4 08		add    $0x8,%rsp
	9d			popfq
	48 89 f0		mov    %rsi,%rax
	8b 35 82 7d db e2	mov    -0x1d24827e(%rip),%esi # 0xffffffff82db9e67 <nr_cpu_ids+3>

This dump shows that the second MOV accesses *(nr_cpu_ids+3) instead of
the original *nr_cpu_ids. This leads to a kernel freeze because
cpumask_next() always returns 0 and for_each_cpu() never ends.

Fix this by adding 'len' correctly to the real RIP address while
copying.

[ mingo: Improved the changelog. ]

Reported-by: Michael Rodin <michael@rodin.online>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org # v4.15+
Fixes: 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()")
Link: http://lkml.kernel.org/r/153504457253.22602.1314289671019919596.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 40b16b270656..6adf6e6c2933 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -189,7 +189,7 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
 	int len = 0, ret;
 
 	while (len < RELATIVEJUMP_SIZE) {
-		ret = __copy_instruction(dest + len, src + len, real, &insn);
+		ret = __copy_instruction(dest + len, src + len, real + len, &insn);
 		if (!ret || !can_boost(&insn, src + len))
 			return -EINVAL;
 		len += ret;
