Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5CEC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C3820862
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N08Eu5hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C3820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbeKDXHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730164AbeKDXHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A22320862;
        Sun,  4 Nov 2018 13:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339533;
        bh=I9mqUG3c5wQhAoy2APweC3mft1peGKDwGooMeor2rKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N08Eu5hfFsQ3c1L2aOokOd7+IgaP1tRw8CIalmZwUFGQJCrwnBLvoLhTb6Z283qqt
         F4UNol7FDxVJCvLdEtHx6pdFfvnOZaX+mrn63Tj4i55sLShRa1C+uS2E142Uo9Smgp
         6jkHiPKboGVXfDIFuE+CF7o1lgV51t+5LCazamMg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 27/57] powerpc/mm: Don't report hugepage tables as memory leaks when using kmemleak
Date:   Sun,  4 Nov 2018 08:51:14 -0500
Message-Id: <20181104135144.88324-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
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
2.17.1

