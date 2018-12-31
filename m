Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10952C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AAF218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270422;
	bh=khvb7vmTj/HrRAid0nNTHSewSqPnTBjKhFPOLYiAMUY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Bsb/Dz8OS3o0DTkSknILuFHMedE9JtKDnc4YfzOGvOKgmSVQkEqZ5lcs1XrCNoapt
	 tulxWjo+2sdVc5A2bkd9BThx8GqQRB7x6r3htjRf98Ov72Jp6e221sdgese48bk1Rt
	 XbXrwnXcH3h+RhDdjR4qUJmiJr2mwZubYTG5fUhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeLaPdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:33:41 -0500
Received: from localhost.localdomain (unknown [183.128.55.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C382133F;
        Mon, 31 Dec 2018 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270421;
        bh=khvb7vmTj/HrRAid0nNTHSewSqPnTBjKhFPOLYiAMUY=;
        h=From:To:Cc:Subject:Date:From;
        b=VeNb2OJJeSiAaZfseBHMcu6Q2wT4bBB3k6Tt/53zm5oVU9OuNZ+ggViWHELVwuw/H
         Su7nVYLndK/CiWr18QvVX1ZM2/yHPLoke23gwBBPLrYAIj1pM4uGLy4h6xAwJGW3Ok
         IHzSEDNsAsHBVrYkW6GT8DlvwljWRenUyDtXnkt8=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 01/14] csky: fixup abiv2 mmap(... O_SYNC) failed.
Date:   Mon, 31 Dec 2018 23:32:53 +0800
Message-Id: <1546270384-4590-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Glibc function mmap(... O_SYNC) will make page to _PAGE_UNCACHE +
_PAGE_SO and strong-order page couldn't support unalignment access.
So remove _PAGE_SO from _PAGE_UNCACHE, also sync abiv1 with the macro
of _PAGE_SO.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Liu Renwei <Renwei.Liu@verisilicon.com>
Tested-by: Yuan Qiyun <qiyun_yuan@c-sky.com>
---
 arch/csky/abiv1/inc/abi/pgtable-bits.h | 1 +
 arch/csky/abiv2/inc/abi/pgtable-bits.h | 2 +-
 arch/csky/mm/ioremap.c                 | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/pgtable-bits.h b/arch/csky/abiv1/inc/abi/pgtable-bits.h
index 455075b..d605445 100644
--- a/arch/csky/abiv1/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv1/inc/abi/pgtable-bits.h
@@ -26,6 +26,7 @@
 
 #define _PAGE_CACHE		(3<<9)
 #define _PAGE_UNCACHE		(2<<9)
+#define _PAGE_SO		_PAGE_UNCACHE
 
 #define _CACHE_MASK		(7<<9)
 
diff --git a/arch/csky/abiv2/inc/abi/pgtable-bits.h b/arch/csky/abiv2/inc/abi/pgtable-bits.h
index b20ae19..137f793 100644
--- a/arch/csky/abiv2/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv2/inc/abi/pgtable-bits.h
@@ -32,6 +32,6 @@
 #define _CACHE_MASK		_PAGE_CACHE
 
 #define _CACHE_CACHED		(_PAGE_VALID | _PAGE_CACHE | _PAGE_BUF)
-#define _CACHE_UNCACHED		(_PAGE_VALID | _PAGE_SO)
+#define _CACHE_UNCACHED		(_PAGE_VALID)
 
 #endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
index 7ad3ff1..cb7c03e 100644
--- a/arch/csky/mm/ioremap.c
+++ b/arch/csky/mm/ioremap.c
@@ -30,7 +30,7 @@ void __iomem *ioremap(phys_addr_t addr, size_t size)
 	vaddr = (unsigned long)area->addr;
 
 	prot = __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE |
-			_PAGE_GLOBAL | _CACHE_UNCACHED);
+			_PAGE_GLOBAL | _CACHE_UNCACHED | _PAGE_SO);
 
 	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
 		free_vm_area(area);
-- 
2.7.4

