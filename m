Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBBAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CECB21A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CECB21A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeHFRSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:18:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24845 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbeHFRSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:18:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41kgz3360Hz9ttmh;
        Mon,  6 Aug 2018 17:09:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JiHk6CUBId6o; Mon,  6 Aug 2018 17:09:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41kgz32djSz9ttm4;
        Mon,  6 Aug 2018 17:09:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 49ED18B7E2;
        Mon,  6 Aug 2018 17:09:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OugcvoYIm72R; Mon,  6 Aug 2018 17:09:12 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1BE738B7DD;
        Mon,  6 Aug 2018 17:09:12 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C65317121C; Mon,  6 Aug 2018 15:09:11 +0000 (UTC)
Message-Id: <975595591e096f4ad3253b5a11713beaf62912c4.1533561636.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/cpm1: fix compilation error with
 CONFIG_PPC_EARLY_DEBUG_CPM
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  6 Aug 2018 15:09:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e8cb7a55eb8dc ("powerpc: remove superflous inclusions of
asm/fixmap.h") removed inclusion of asm/fixmap.h from files not
including objects from that file.

However, asm/mmu-8xx.h includes  call to __fix_to_virt(). The proper
way would be to include asm/fixmap.h in asm/mmu-8xx.h but it creates
an inclusion loop.

So we have to leave asm/fixmap.h in sysdep/cpm_common.c for
CONFIG_PPC_EARLY_DEBUG_CPM

  CC      arch/powerpc/sysdev/cpm_common.o
In file included from ./arch/powerpc/include/asm/mmu.h:340:0,
                 from ./arch/powerpc/include/asm/reg_8xx.h:8,
                 from ./arch/powerpc/include/asm/reg.h:29,
                 from ./arch/powerpc/include/asm/processor.h:13,
                 from ./arch/powerpc/include/asm/thread_info.h:28,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/powerpc/include/asm/ptrace.h:159,
                 from ./arch/powerpc/include/asm/hw_irq.h:12,
                 from ./arch/powerpc/include/asm/irqflags.h:12,
                 from ./include/linux/irqflags.h:16,
                 from ./include/asm-generic/cmpxchg-local.h:6,
                 from ./arch/powerpc/include/asm/cmpxchg.h:537,
                 from ./arch/powerpc/include/asm/atomic.h:11,
                 from ./include/linux/atomic.h:5,
                 from ./include/linux/mutex.h:18,
                 from ./include/linux/kernfs.h:13,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/device.h:16,
                 from ./include/linux/node.h:18,
                 from ./include/linux/cpu.h:17,
                 from ./include/linux/of_device.h:5,
                 from arch/powerpc/sysdev/cpm_common.c:21:
arch/powerpc/sysdev/cpm_common.c: In function ‘udbg_init_cpm’:
./arch/powerpc/include/asm/mmu-8xx.h:218:25: error: implicit declaration of function ‘__fix_to_virt’ [-Werror=implicit-function-declaration]
 #define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
                         ^
arch/powerpc/sysdev/cpm_common.c:75:7: note: in expansion of macro ‘VIRT_IMMR_BASE’
       VIRT_IMMR_BASE);
       ^
./arch/powerpc/include/asm/mmu-8xx.h:218:39: error: ‘FIX_IMMR_BASE’ undeclared (first use in this function)
 #define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
                                       ^
arch/powerpc/sysdev/cpm_common.c:75:7: note: in expansion of macro ‘VIRT_IMMR_BASE’
       VIRT_IMMR_BASE);
       ^
./arch/powerpc/include/asm/mmu-8xx.h:218:39: note: each undeclared identifier is reported only once for each function it appears in
 #define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
                                       ^
arch/powerpc/sysdev/cpm_common.c:75:7: note: in expansion of macro ‘VIRT_IMMR_BASE’
       VIRT_IMMR_BASE);
       ^
cc1: all warnings being treated as errors
make[1]: *** [arch/powerpc/sysdev/cpm_common.o] Error 1

Fixes: e8cb7a55eb8dc ("powerpc: remove superflous inclusions of asm/fixmap.h")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/fixmap.h | 1 +
 arch/powerpc/sysdev/cpm_common.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 40efdf1d2d6e..41cc15c14eee 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -16,6 +16,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/page.h>
+#include <asm/pgtable.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 010975c3422f..b74508175b67 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -28,6 +28,7 @@
 #include <asm/udbg.h>
 #include <asm/io.h>
 #include <asm/cpm.h>
+#include <asm/fixmap.h>
 #include <soc/fsl/qe/qe.h>
 
 #include <mm/mmu_decl.h>
-- 
2.13.3

