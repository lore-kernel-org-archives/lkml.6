Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253F7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9B6208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543897;
	bh=TLZNYALW5mviJQ/Cf/6y9bW21uJxXnfDmtk05Hhtg0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZgVxgs1xyG+6BE8GcBCNtPCCzLvXSsioyc889Wo/30s78tHRMs/suFacNDdg0hXgK
	 oudFdlq9mkO//LVEjgQMMiAJENdY9iBvt7U9XKEH07k39bVm0GSD2P7daX1ZVcTSYJ
	 MTSEVZKckav9qnN7w0LZayLQOSYRnIETowtPi7Oo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9B6208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeLKP6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbeLKP6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7805A205C9;
        Tue, 11 Dec 2018 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543892;
        bh=TLZNYALW5mviJQ/Cf/6y9bW21uJxXnfDmtk05Hhtg0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRLW82WjueGUs3AVaG1iGXJOUVL4RDY+Z/JkE1YjDNIvc13PD7YIgM8+FysIa2aTF
         FgfEH6xCiwdmElXGrqOFDQWMd1P5+5N4XcSFqpEw2aYM5rbNwBTO/p+xKbQj1aA7eN
         HJMO4L5NtXnwVvI4yPrkfCn3U+djd4fQIoh5F4a0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Rodin <michael@rodin.online>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 103/118] kprobes/x86: Fix instruction patching corruption when copying more than one RIP-relative instruction
Date:   Tue, 11 Dec 2018 16:42:02 +0100
Message-Id: <20181211151648.426536452@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 43a1b0cb4cd6dbfd3cd9c10da663368394d299d8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kprobes/opt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -189,7 +189,7 @@ static int copy_optimized_instructions(u
 	int len = 0, ret;
 
 	while (len < RELATIVEJUMP_SIZE) {
-		ret = __copy_instruction(dest + len, src + len, real, &insn);
+		ret = __copy_instruction(dest + len, src + len, real + len, &insn);
 		if (!ret || !can_boost(&insn, src + len))
 			return -EINVAL;
 		len += ret;


