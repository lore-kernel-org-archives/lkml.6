Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A7CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC4220834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC4220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeLDTuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:50:01 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:48814 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeLDTuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:50:01 -0500
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 7vpy1z00D3XaVaC01vpyrn; Tue, 04 Dec 2018 20:49:58 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUGhi-0001tS-9c; Tue, 04 Dec 2018 20:49:58 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUGhi-0005Zx-7c; Tue, 04 Dec 2018 20:49:58 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: Fix crash in free_all_bootmem()
Date:   Tue,  4 Dec 2018 20:49:56 +0100
Message-Id: <20181204194957.21403-1-geert@linux-m68k.org>
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

Fix this by removing ignored memory chunks from memblock.

Amigas with both Zorro II and Zorro III RAM have a similar issue, as on
such systems, Zorro II RAM is ignored, and removed from the
m68k_memory[] array.  Fix this as well.

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Fixes: 1008a11590b966b4 ("m68k: switch to MEMBLOCK + NO_BOOTMEM")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
The Amiga part is untested.
---
 arch/m68k/amiga/config.c | 2 ++
 arch/m68k/mm/motorola.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 65f63a4571300085..73e2bdf0f5ac8f2b 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -427,6 +427,8 @@ void __init config_amiga(void)
 					continue;
 				}
 				disabled_z2mem += m68k_memory[i].size;
+				memblock_remove(m68k_memory[i].addr,
+						m68k_memory[i].size);
 				m68k_num_memory--;
 				for (j = i; j < m68k_num_memory; j++)
 					m68k_memory[j] = m68k_memory[j+1];
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 4e17ecb5928aae85..98706bfe10a9ac5e 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -233,6 +233,8 @@ void __init paging_init(void)
 			printk("Ignoring memory chunk at 0x%lx:0x%lx before the first chunk\n",
 				m68k_memory[i].addr, m68k_memory[i].size);
 			printk("Fix your bootloader or use a memfile to make use of this area!\n");
+			memblock_remove(m68k_memory[i].addr,
+					m68k_memory[i].size);
 			m68k_num_memory--;
 			memmove(m68k_memory + i, m68k_memory + i + 1,
 				(m68k_num_memory - i) * sizeof(struct m68k_mem_info));
-- 
2.17.1

