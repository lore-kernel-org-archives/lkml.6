Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E79C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6297620C07
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yc778qXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6297620C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeHWUrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeHWUrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:47:17 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F7020A8B;
        Thu, 23 Aug 2018 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535044595;
        bh=rTs8O1xoW5SfoMf7NAtlxY57wUJVokIZBlOtfISk77E=;
        h=From:To:Cc:Subject:Date:From;
        b=yc778qXNQISqjgfutOeC8Dj7SodbOCZhsv1y454nAIwTzk0uQHydZISsCNmjQYX1b
         kzhmWtFMFT1g47dpgo/Q138jEBmKyNTZwzd4MhDTsaUImwl2mK7toNMkNq/7attQiK
         /jNMbt9xwVvNb7vHzlurC9JjdMYoe6N93RvDWlHI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Michael Rodin <michael@rodin.online>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH -tip] kprobes/x86: Fix to copy RIP relative instruction correctly
Date:   Fri, 24 Aug 2018 02:16:12 +0900
Message-Id: <153504457253.22602.1314289671019919596.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since copy_optimized_instructions() misses to update real RIP
address while copying several instructions to working buffer,
it adjusts RIP-relative instruction with wrong RIP address for
the 2nd and subsequent instructions.

This may break the kernel (like kernel freeze) because
probed instruction can refer a wrong data. For example,
putting kprobes on cpumask_next hit this bug.

cpumask_next is normally like below if CONFIG_CPUMASK_OFFSTACK=y
(in this case nr_cpumask_bits is an alias of nr_cpu_ids)

 <cpumask_next>:
       48 89 f0                mov    %rsi,%rax
       8b 35 7b fb e2 00       mov    0xe2fb7b(%rip),%esi
        # ffffffff82db9e64 <nr_cpu_ids>
       55                      push   %rbp
...

If we put a kprobe on it and optimized with jump, it becomes
like this.

	e9 95 7d 07 1e	jmpq   0xffffffffa000207a
	7b fb	jnp    0xffffffff81f8a2e2 <cpumask_next+2>
	e2 00	loop   0xffffffff81f8a2e9 <cpumask_next+9>
	55	push   %rbp

This shows first 2 "mov" instructions are copied to trampoline
buffer at 0xffffffffa000207a. Here is the disassembled result.
(skipped optprobe template instructions)

Dump of assembler code from 0xffffffffa000207a to 0xffffffffa00020ea:
	54	push   %rsp
...
	48 83 c4 08	add    $0x8,%rsp
	9d	popfq
	48 89 f0	mov    %rsi,%rax
	8b 35 82 7d db e2	mov    -0x1d24827e(%rip),%esi
        # 0xffffffff82db9e67 <nr_cpu_ids+3>

As it shows, the 2nd mov accesses *(nr_cpu_ids+3) instead of
*nr_cpu_ids. This leads a kernel freeze because cpumask_next()
always returns 0 and for_each_cpu() never ended.

Fixing this by adding len correctly to real RIP address while
copying.

Fixes: 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()")
Reported-by: Michael Rodin <michael@rodin.online>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/kprobes/opt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index eaf02f2e7300..e92672b8b490 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -189,7 +189,8 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
 	int len = 0, ret;
 
 	while (len < RELATIVEJUMP_SIZE) {
-		ret = __copy_instruction(dest + len, src + len, real, &insn);
+		ret = __copy_instruction(dest + len, src + len, real + len,
+			&insn);
 		if (!ret || !can_boost(&insn, src + len))
 			return -EINVAL;
 		len += ret;

