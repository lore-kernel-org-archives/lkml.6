Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3B6C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0029321761
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0029321761
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeHMQCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:02:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62417 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbeHMQCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:02:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41pxCr1Hbcz9tvRK;
        Mon, 13 Aug 2018 15:19:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1OxWcrXYM-QL; Mon, 13 Aug 2018 15:19:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41pxCr0qwxz9tvRJ;
        Mon, 13 Aug 2018 15:19:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9CEC8B7A7;
        Mon, 13 Aug 2018 15:19:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UOgeQgf-16L2; Mon, 13 Aug 2018 15:19:52 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B7078B752;
        Mon, 13 Aug 2018 15:19:52 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5523C7125D; Mon, 13 Aug 2018 13:19:52 +0000 (UTC)
Message-Id: <fa22576baa70fd0cdf8b3f5af3767116a1c680e7.1534164087.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Don't report hugepage tables as memory leaks when
 using kmemleak
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 13 Aug 2018 13:19:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a process allocates a hugepage, the following leak is
reported by kmemleak. This is a false positive which is
due to the pointer to the table being stored in the PGD
as physical memory address and not virtual memory pointer.

unreferenced object 0xc30f8200 (size 512):
  comm "mmap", pid 374, jiffies 4872494 (age 627.630s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<e32b68da>] huge_pte_alloc+0xdc/0x1f8
    [<9e0df1e1>] hugetlb_fault+0x560/0x8f8
    [<7938ec6c>] follow_hugetlb_page+0x14c/0x44c
    [<afbdb405>] __get_user_pages+0x1c4/0x3dc
    [<b8fd7cd9>] __mm_populate+0xac/0x140
    [<3215421e>] vm_mmap_pgoff+0xb4/0xb8
    [<c148db69>] ksys_mmap_pgoff+0xcc/0x1fc
    [<4fcd760f>] ret_from_syscall+0x0/0x38

See commit a984506c542e2 ("powerpc/mm: Don't report PUDs as
memory leaks when using kmemleak") for detailed explanation.

To fix that, this patch tells kmemleak to ignore the allocated
hugepage table.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/hugetlbpage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e87f9ef9115b..7296a42eb62e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -19,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/kmemleak.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -112,6 +113,8 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		for (i = i - 1 ; i >= 0; i--, hpdp--)
 			*hpdp = __hugepd(0);
 		kmem_cache_free(cachep, new);
+	} else {
+		kmemleak_ignore(new);
 	}
 	spin_unlock(ptl);
 	return 0;
-- 
2.13.3

