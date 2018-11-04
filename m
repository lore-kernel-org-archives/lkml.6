Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042B3C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD36A2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcAkby9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD36A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbeKDXP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:15:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731246AbeKDXIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:08:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D33C520862;
        Sun,  4 Nov 2018 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339618;
        bh=TuI6gclktS8m6x9eTqcREjculI0oeYOv/ENqsMLXD+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcAkby9BD9irrpVNcV8HqBDKcV5Qp3PfwBkFkfr7ewqOA5+N7/N9EGDj1CKQ/ZcD7
         xdNUPJhuZnSn2EjTMviETMmCg1ma4ZLmimjLPCriRwjl6XdjjC02xBeovP03lNdTUg
         zX65hX5FEVSdeCUq+kL6QsNgJFwT2/IUJlSMgIPU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 12/30] powerpc/mm: Don't report hugepage tables as memory leaks when using kmemleak
Date:   Sun,  4 Nov 2018 08:53:07 -0500
Message-Id: <20181104135325.88524-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135325.88524-1-sashal@kernel.org>
References: <20181104135325.88524-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 803d690e68f0c5230183f1a42c7d50a41d16e380 ]

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/hugetlbpage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 4c9e5f9c7a44..e2d929ddad7f 100644
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
@@ -110,6 +111,8 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		for (i = i - 1 ; i >= 0; i--, hpdp--)
 			*hpdp = __hugepd(0);
 		kmem_cache_free(cachep, new);
+	} else {
+		kmemleak_ignore(new);
 	}
 	spin_unlock(&mm->page_table_lock);
 	return 0;
-- 
2.17.1

