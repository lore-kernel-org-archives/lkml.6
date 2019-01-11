Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C777C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB1320878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547222954;
	bh=YHyF8g71Qi4NVNMhmCLc3E+MIekNiLMLzpdE4G7qD3w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Jo4lQTF9XGulXDH1ScxRDh0dzop3A5GUql9GlTWKUrYMjeosP8uhe/4WYIfVUTR5d
	 XzyMtgBKidPDbeUob2tWVkVr/jL8RY63h5TR5+YLQGgNARAGSmdMK0iUcffy6J2KDl
	 nuIUHc3jbmeKgo+8wbzIGo16aoqxjECx7k9M7eS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbfAKQJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfAKQJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:09:13 -0500
Received: from localhost.localdomain (unknown [218.0.237.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B2020657;
        Fri, 11 Jan 2019 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547222952;
        bh=YHyF8g71Qi4NVNMhmCLc3E+MIekNiLMLzpdE4G7qD3w=;
        h=From:To:Cc:Subject:Date:From;
        b=FrEaAYKH5syJPj/guGXvfg6SCv/WQ+ngREzfqj6MiH6hikUARRYQXuxyhsZqKL30e
         L17T3h6WXb7kQwSsNA6K4xlEWTgaV68TVCvANH19syJr4K0KoE5j9sffDxLERcX4Wq
         9nuaAGR86mvcocV+fHd0yBKhjK6L9x3wO0CAdgF0=
From:   guoren@kernel.org
To:     arnd@arndb.de, ren_guo@c-sky.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] csky: fixup _PAGE_GLOBAL bit for 610 tlb entry
Date:   Sat, 12 Jan 2019 00:09:04 +0800
Message-Id: <1547222944-5808-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

C-SKY CPU 8xx's _PAGE_GLOBAL is BIT(0), but 610's _PAGE_GLOBAL is
BIT(6). Use _PAGE_GLOBAL macro instead of bad magic number.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index edfcbb2..af7a7fa 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -45,8 +45,8 @@
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset_t(address))
 #define pmd_page(pmd)	(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pte_clear(mm, addr, ptep)	set_pte((ptep), \
-			(((unsigned int)addr&0x80000000)?__pte(1):__pte(0)))
-#define pte_none(pte)	(!(pte_val(pte)&0xfffffffe))
+	(((unsigned int) addr & PAGE_OFFSET) ? __pte(_PAGE_GLOBAL) : __pte(0)))
+#define pte_none(pte)		(!(pte_val(pte) & ~_PAGE_GLOBAL))
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
 #define pte_pfn(x)	((unsigned long)((x).pte_low >> PAGE_SHIFT))
 #define pfn_pte(pfn, prot) __pte(((unsigned long long)(pfn) << PAGE_SHIFT) \
-- 
2.7.4

