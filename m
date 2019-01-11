Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4785AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ECF2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218303;
	bh=MDifTX+NtM0Qrwzo2OsUecIZGipqjrWgXNdZKrhXZUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ivwFkmWPy5hhSeLQREkEZH9+R6TdGOVtMSx4bNFkfgOFvv5hVTSxWvwj9V09hxXRT
	 Jfl4N76niJwVmq26CpZwGZFcZ9iQ3YdqXYbOgsZB/jcMcaQgtNdM9CI3tfrlPHXHqk
	 KN7DNLUEDEpMFIXHvRsxoYvR3boDMb1vMfo1xZK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391309AbfAKOvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:51:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391011AbfAKOjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37BE02133F;
        Fri, 11 Jan 2019 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217562;
        bh=MDifTX+NtM0Qrwzo2OsUecIZGipqjrWgXNdZKrhXZUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3scNk9Lt0gxSAAxMloc/Qfbd6autv/OxV0zfKface3UicfSUXtEJA227i6EBzdgP
         9FKwBDEjKwno31ctHdGajmSjyLrHIn4owBTVd5hxmnY0AIcBIHaAORMfRvsAudnfoE
         /aSGClTyaMtmMGFjJwFYQeRi8lVzLJWeAGhvfNsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 068/148] m68k: Fix memblock-related crashes
Date:   Fri, 11 Jan 2019 15:14:06 +0100
Message-Id: <20190111131116.963740203@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

[ Upstream commit bed1369f51901b17108a4bb4f7210aab183bea42 ]

When running the kernel in Fast RAM on Atari:

    Ignoring memory chunk at 0x0:0xe00000 before the first chunk
    ...
    Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
    Oops: 00000000
    Modules linked in:
    PC: [<0069dbac>] free_all_bootmem+0x12c/0x186
    SR: 2714  SP: (ptrval)  a2: 005e3314
    d0: 00000000    d1: 0000000a    d2: 00000e00    d3: 00000000
    d4: 005e1fc0    d5: 0000001a    a0: 01000000    a1: 00000000
    Process swapper (pid: 0, task=(ptrval))
    Frame format=7 eff addr=00000736 ssw=0505 faddr=00000736
    wb 1 stat/addr/data: 0000 00000000 00000000
    wb 2 stat/addr/data: 0000 00000000 00000000
    wb 3 stat/addr/data: 0000 00000736 00000000
    push data: 00000000 00000000 00000000 00000000
    Stack from 005e1f84:
            00000000 0000000a 027d3260 006b5006 00000000 00000000 00000000 00000000
            0004f062 0003a220 0069e272 005e1ff8 0000054c 00000000 00e00000 00000000
            00000001 00693cd8 027d3260 0004f062 0003a220 00691be6 00000000 00000000
            00000000 00000000 00000000 00000000 006b5006 00000000 00690872
    Call Trace: [<0004f062>] printk+0x0/0x18
     [<0003a220>] parse_args+0x0/0x2d4
     [<0069e272>] memblock_virt_alloc_try_nid+0x0/0xa4
     [<00693cd8>] mem_init+0xa/0x5c
     [<0004f062>] printk+0x0/0x18
     [<0003a220>] parse_args+0x0/0x2d4
     [<00691be6>] start_kernel+0x1ca/0x462
     [<00690872>] _sinittext+0x872/0x11f8
    Code: 7a1a eaae 2270 6db0 0061 ef14 2f01 2f03 <96a9> 0736 2203 e589 d681 e78b d6a9 0732 2f03 2f40 0034 4eb9 0069 b8d0 260e 4fef
    Disabling lock debugging due to kernel taint
    Kernel panic - not syncing: Attempted to kill the idle task!

As the kernel must run in the memory chunk with the lowest address,
ST-RAM is ignored, and removed from the m68k_memory[] array.
However, it is not removed from memblock, causing a crash later.

More investigation shows that there are 3 places where memory chunks are
ignored, all after the calls to memblock_add() in m68k_parse_bootinfo(),
and thus causing crashes:
  1. On classic m68k CPUs with a MMU, paging_init() ignores all memory
     chunks below the first chunk, cfr. above,
  2. On Amigas equipped with a Zorro III bus, config_amiga() ignores all
     Zorro II memory,
  3. If CONFIG_SINGLE_MEMORY_CHUNK=y, m68k_parse_bootinfo() ignores all
     but the first memory chunk.

Fix this by moving the calls to memblock_add() from
m68k_parse_bootinfo() to paging_init(), after all ignored memory chunks
have been removed from m68k_memory[].

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Fixes: 1008a11590b966b4 ("m68k: switch to MEMBLOCK + NO_BOOTMEM")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/kernel/setup_mm.c | 2 --
 arch/m68k/mm/motorola.c     | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 5d3596c180f9..de44899c0e61 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -165,8 +165,6 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
 					be32_to_cpu(m->addr);
 				m68k_memory[m68k_num_memory].size =
 					be32_to_cpu(m->size);
-				memblock_add(m68k_memory[m68k_num_memory].addr,
-					     m68k_memory[m68k_num_memory].size);
 				m68k_num_memory++;
 			} else
 				pr_warn("%s: too many memory chunks\n",
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 4e17ecb5928a..2eb2b31fb16a 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -228,6 +228,7 @@ void __init paging_init(void)
 
 	min_addr = m68k_memory[0].addr;
 	max_addr = min_addr + m68k_memory[0].size;
+	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
 	for (i = 1; i < m68k_num_memory;) {
 		if (m68k_memory[i].addr < min_addr) {
 			printk("Ignoring memory chunk at 0x%lx:0x%lx before the first chunk\n",
@@ -238,6 +239,7 @@ void __init paging_init(void)
 				(m68k_num_memory - i) * sizeof(struct m68k_mem_info));
 			continue;
 		}
+		memblock_add(m68k_memory[i].addr, m68k_memory[i].size);
 		addr = m68k_memory[i].addr + m68k_memory[i].size;
 		if (addr > max_addr)
 			max_addr = addr;
-- 
2.19.1



