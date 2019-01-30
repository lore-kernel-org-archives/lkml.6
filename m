Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A5C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF45121473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548851640;
	bh=MdJiXY8ibrN6WYl5P0Xf6iI38JFQ6fe6kQM8fKQPZR4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iSAyrOv9jMMZTnEtsU9uhfRf5lDCcpBmJkDFUa2WqLG8OJuVGjUmBFH5xb7isRjDy
	 Rhk7RnuDWJijuXz13U7eoTcJUaLRLocfSmPNG5gXw7RPYk2YSZ5gOdMfkhlXU0JDh3
	 s6mFpyIWb4nfhBz04lJaN5hLKBXmsb2Ce4Crmuzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfA3Md7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3Md7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:33:59 -0500
Received: from localhost.localdomain (unknown [60.186.218.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCE2D20882;
        Wed, 30 Jan 2019 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548851638;
        bh=MdJiXY8ibrN6WYl5P0Xf6iI38JFQ6fe6kQM8fKQPZR4=;
        h=From:To:Cc:Subject:Date:From;
        b=bTN5nd716RvRDK2zGHg6sYW9f6w2eTufUR+LClyng4pql1dm3953YBd/z5PpW789/
         lXW66EuAK21YIjSTbBjMKYBC9//4ik6hP8IyDHamBPzmyEU2Q+v6vRV1RFZq3SslNj
         sq2LCBLwisQxB0176/4Bb12j8InWHKcAytrHVxIU=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, xiaodong.fan@boyahualu.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: Fixup io-range page attribute for mmap("/dev/mem")
Date:   Wed, 30 Jan 2019 20:33:49 +0800
Message-Id: <1548851629-9408-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Some user space drivers need accessing IO address and IO remap need
SO(strong order) page-attribute to make IO operation correct. So we
need add SO-page-attr for all non-memory address.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Fan Xiaodong <xiaodong.fan@boyahualu.com>
---
 arch/csky/include/asm/pgtable.h |  5 +++++
 arch/csky/mm/ioremap.c          | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index af7a7fa..dcea277 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -241,6 +241,11 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
 #define pgd_index(address)	((address) >> PGDIR_SHIFT)
 
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+struct file;
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+				     unsigned long size, pgprot_t vma_prot);
+
 /*
  * Macro to make mark a page protection value as "uncacheable".  Note
  * that "protection" is really a misnomer here as the protection value
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
index cb7c03e..8473b6b 100644
--- a/arch/csky/mm/ioremap.c
+++ b/arch/csky/mm/ioremap.c
@@ -46,3 +46,17 @@ void iounmap(void __iomem *addr)
 	vunmap((void *)((unsigned long)addr & PAGE_MASK));
 }
 EXPORT_SYMBOL(iounmap);
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+			      unsigned long size, pgprot_t vma_prot)
+{
+	if (!pfn_valid(pfn)) {
+		vma_prot.pgprot |= _PAGE_SO;
+		return pgprot_noncached(vma_prot);
+	} else if (file->f_flags & O_SYNC) {
+		return pgprot_noncached(vma_prot);
+	}
+
+	return vma_prot;
+}
+EXPORT_SYMBOL(phys_mem_access_prot);
-- 
2.7.4

