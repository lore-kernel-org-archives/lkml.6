Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7701CC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374B820868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374B820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeLGQuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:50:20 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:54234 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeLGQuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:50:18 -0500
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 94qD1z00S3XaVaC064qDd9; Fri, 07 Dec 2018 17:50:16 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gVJKP-0007CP-Na; Fri, 07 Dec 2018 17:50:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gVJKP-0008Cr-L5; Fri, 07 Dec 2018 17:50:13 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     Sam Creasey <sammy@sammy.net>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3] m68k: Fix memblock-related crashes
Date:   Fri,  7 Dec 2018 17:50:11 +0100
Message-Id: <20181207165011.31497-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
As all 3 cases involve ignoring memory chunks, thus not requiring real
memory present in the ignored chunks, I managed to test all 3 cases on
my Amiga 4000 by using a memfile describing nonexistent memory in the
Zorro II or 32-bit address space, below system RAM.

Sun-3 must be broken before this fix, as it fills in m68k_memory[0] in
config_sun3(), i.e. after m68k_parse_bootinfo().
Sun-3 is not fixed by this fix, as it uses its own paging_init(), not
the one in motorola.c.
Fixing Sun-3 requires adding memblock_add()/memblock_reserve() calls to
the Sun-3 memory management code.

v3:
  - Move memblock_add() after memory block removal instead of sprinkling
    memblock_remove() all over the place,
  - Remove Suggested-by, Tested-by.

v2:
  - Add missing #include <linux/memblock.h>.
---
 arch/m68k/kernel/setup_mm.c | 2 --
 arch/m68k/mm/motorola.c     | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index a1a3eaeaf58c960d..ad0195cbe04255ea 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -164,8 +164,6 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
 					be32_to_cpu(m->addr);
 				m68k_memory[m68k_num_memory].size =
 					be32_to_cpu(m->size);
-				memblock_add(m68k_memory[m68k_num_memory].addr,
-					     m68k_memory[m68k_num_memory].size);
 				m68k_num_memory++;
 			} else
 				pr_warn("%s: too many memory chunks\n",
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 7497cf30bf1cd41b..3f3d0bf360910c0d 100644
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
2.17.1

