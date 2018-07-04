Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D68C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8712023D8D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku3LSpSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8712023D8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbeGDFyo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:54:44 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33051 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932643AbeGDFwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:52:36 -0400
Received: by mail-pg0-f65.google.com with SMTP id e11-v6so2015368pgq.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 22:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BXOqITXyjXMUd8nX7tgw7dUzycTRww6JMPkIHTCu7k0=;
        b=ku3LSpSEG8mu8jl+j2VobLs4ECdAxg6sA1KpD2qC66SyNG4/VaFQJa4/OfaQv6Uz0q
         JRDsmaMZARUSPxX3bSjPPx/2fOimSU5QzDjCBhgG/QNvpXTJvLNe9QrYlbHQOBFbghl4
         EoLlh6mKOIb9BUn16i4quS5kv/HRH/rvGPaf0KD1K0jEF24kiBuOZGmxqoZCPKOkz+AT
         HaLV7pLcZvwE6pYWdT25UogzOspk5YZo+Y1HxDHmJTjVLLFVkoJ/bbXk/Gzr4bwrXijl
         TDXmhRMQ6lNiaTu39xLMyqVWiCuVnrbP0WWUaeNG8RVzyj9OQUYfUQhCBKZsgnNtjemI
         +0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BXOqITXyjXMUd8nX7tgw7dUzycTRww6JMPkIHTCu7k0=;
        b=LWLMZtEFjkeEKNwOM7ELOUmXxjXkPwYpIXD1ZMXUB7dXQcfc+wEaukPI/4WXivBJD4
         G9cu1LqChHm0RLxg9bfK0QG//NgiUNT4g4CxMfOzGqIVp4RzgRfmG0fTvT5LX66HjHgW
         Hl/wOmu7WTZxs80G+SHA2PV1MvitzKCoOzehYFg5aKzM64a3mzHp8G18kvJcjddquz9L
         y2E/gYI9qcbORutZoJ162zBXULZAfbZzm80vh0+UMjQjoIccIVt3AtnD3iQkh+o6DtbV
         huWF7m0XpINSgrF7ec7V+bWVdF88vkvulT7+3orjvTob0nk7xC1ksdZxajrQgVOf4vKr
         lUcQ==
X-Gm-Message-State: APt69E3WwXhb2/OTXFvxLZaaJAFHh5updVeWce/ea/ejpv7q6aHyCAxC
        G49Qolol/nL9Y4XWIJEsERA=
X-Google-Smtp-Source: AAOMgpeim1PohFFD+cYOwKn1qmWZFbvi2UnUAyMOFXkhQDFANYc4HiWLVsr+G5rhPeLvL+LJihF91w==
X-Received: by 2002:a63:5421:: with SMTP id i33-v6mr619292pgb.417.1530683555919;
        Tue, 03 Jul 2018 22:52:35 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id b22-v6sm4257226pfi.144.2018.07.03.22.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 22:52:35 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        ren_guo@c-sky.com
Cc:     green.hu@gmail.com
Subject: [PATCH v2 1/3] nds32: To implement these icache invalidation APIs since nds32 cores don't snoop data cache. This issue is found by Guo Ren. Based on the Documentation/core-api/cachetlb.rst and it says:
Date:   Wed,  4 Jul 2018 13:52:08 +0800
Message-Id: <f706abf188a82c9d961ed267a18ff5cb5e9aace9.1530683430.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Any necessary cache flushing or other coherency operations
that need to occur should happen here.  If the processor's
instruction cache does not snoop cpu stores, it is very
likely that you will need to flush the instruction cache
for copy_to_user_page()."

"If the icache does not snoop stores then this
routine(flush_icache_range) will need to flush it."

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/cacheflush.h |  9 +++++--
 arch/nds32/mm/cacheflush.c          | 53 ++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 10b48f0d8e85..8b26198d51bb 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -8,6 +8,8 @@
 
 #define PG_dcache_dirty PG_arch_1
 
+void flush_icache_range(unsigned long start, unsigned long end);
+void flush_icache_page(struct vm_area_struct *vma, struct page *page);
 #ifdef CONFIG_CPU_CACHE_ALIASING
 void flush_cache_mm(struct mm_struct *mm);
 void flush_cache_dup_mm(struct mm_struct *mm);
@@ -34,13 +36,16 @@ void flush_anon_page(struct vm_area_struct *vma,
 void flush_kernel_dcache_page(struct page *page);
 void flush_kernel_vmap_range(void *addr, int size);
 void invalidate_kernel_vmap_range(void *addr, int size);
-void flush_icache_range(unsigned long start, unsigned long end);
-void flush_icache_page(struct vm_area_struct *vma, struct page *page);
 #define flush_dcache_mmap_lock(mapping)   xa_lock_irq(&(mapping)->i_pages)
 #define flush_dcache_mmap_unlock(mapping) xa_unlock_irq(&(mapping)->i_pages)
 
 #else
 #include <asm-generic/cacheflush.h>
+#undef flush_icache_range
+#undef flush_icache_page
+#undef flush_icache_user_range
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+	                     unsigned long addr, int len);
 #endif
 
 #endif /* __NDS32_CACHEFLUSH_H__ */
diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index ce8fd34497bf..7fcaa4e6be78 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -13,6 +13,38 @@
 
 extern struct cache_info L1_cache_info[2];
 
+void flush_icache_range(unsigned long start, unsigned long end)
+{
+	unsigned long line_size, flags;
+	line_size = L1_cache_info[DCACHE].line_size;
+	start = start & ~(line_size - 1);
+	end = (end + line_size - 1) & ~(line_size - 1);
+	local_irq_save(flags);
+	cpu_cache_wbinval_range(start, end, 1);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(flush_icache_range);
+
+void flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	unsigned long flags;
+	unsigned long kaddr;
+	local_irq_save(flags);
+	kaddr = (unsigned long)kmap_atomic(page);
+	cpu_cache_wbinval_page(kaddr, vma->vm_flags & VM_EXEC);
+	kunmap_atomic((void *)kaddr);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(flush_icache_page);
+
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+	                     unsigned long addr, int len)
+{
+	unsigned long kaddr;
+	kaddr = (unsigned long)kmap_atomic(page) + (addr & ~PAGE_MASK);
+	flush_icache_range(kaddr, kaddr + len);
+	kunmap_atomic((void *)kaddr);
+}
 #ifndef CONFIG_CPU_CACHE_ALIASING
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 		      pte_t * pte)
@@ -318,27 +350,6 @@ void invalidate_kernel_vmap_range(void *addr, int size)
 }
 EXPORT_SYMBOL(invalidate_kernel_vmap_range);
 
-void flush_icache_range(unsigned long start, unsigned long end)
-{
-	unsigned long line_size, flags;
-	line_size = L1_cache_info[DCACHE].line_size;
-	start = start & ~(line_size - 1);
-	end = (end + line_size - 1) & ~(line_size - 1);
-	local_irq_save(flags);
-	cpu_cache_wbinval_range(start, end, 1);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(flush_icache_range);
-
-void flush_icache_page(struct vm_area_struct *vma, struct page *page)
-{
-	unsigned long flags;
-	local_irq_save(flags);
-	cpu_cache_wbinval_page((unsigned long)page_address(page),
-			       vma->vm_flags & VM_EXEC);
-	local_irq_restore(flags);
-}
-
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 		      pte_t * pte)
 {
-- 
2.16.2

