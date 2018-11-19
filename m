Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC79C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888842089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vk7vJrCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888842089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389423AbeKTDMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387988AbeKTDMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:12:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 063662089F;
        Mon, 19 Nov 2018 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646103;
        bh=p0Bus2c2+aUTD5U1K+f3LH5H52m59QMQKGaMOoJNmvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vk7vJrCy+vDJUpIzEL/bgftfPd8om4J9Dx+MCLbj+FJ9id78+imSS/w75zIo72XFd
         xFNnfHjz+tqDTdDm7lZkfbIO2DL+5FqRAftRV3A+Y0mraNE8F/p6x0v/eekuPKkYoI
         7C2aYhZ07xkLIbbIWWPiUwwyh1MoRHYhsmsjgkVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 008/124] powerpc/mm: Dont report hugepage tables as memory leaks when using kmemleak
Date:   Mon, 19 Nov 2018 17:27:42 +0100
Message-Id: <20181119162614.607102173@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/hugetlbpage.c |    3 +++
 1 file changed, 3 insertions(+)

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
@@ -110,6 +111,8 @@ static int __hugepte_alloc(struct mm_str
 		for (i = i - 1 ; i >= 0; i--, hpdp--)
 			*hpdp = __hugepd(0);
 		kmem_cache_free(cachep, new);
+	} else {
+		kmemleak_ignore(new);
 	}
 	spin_unlock(&mm->page_table_lock);
 	return 0;


