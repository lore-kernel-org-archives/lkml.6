Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755086AbeDTNeS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:34:18 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36934 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755187AbeDTNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:33:11 -0400
X-Google-Smtp-Source: AIpwx49HqfNlOEZvGWpBFJ1RS3AJez+OQxBp0RB8pbkPcqfOqC6N/1CuxTH5Bb8/XlIUNA+8vKDrrQ==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net, hch@infradead.org,
        vincentc@andestech.com, nickhu@andestech.com
Subject: [PATCH v2 5/9] nds32: Fix xfs_buf built failed by export invalidate_kernel_vmap_range and flush_kernel_vmap_range
Date: Fri, 20 Apr 2018 21:31:11 +0800
Message-Id: <536bfa225eeb4d3ea9b1e866e900d657045a0b84.1524229039.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It broke the 'allmodconfig' build.
fs/xfs/xfs_buf.c: In function 'xfs_buf_bio_end_io':
fs/xfs/xfs_buf.c:1242:3: error: implicit declaration of function 'invalidate_kernel_vmap_range' [-Werror=implicit-function-declaration]
   invalidate_kernel_vmap_range(bp->b_addr, xfs_buf_vmap_len(bp));
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/xfs/xfs_buf.c: In function 'xfs_buf_ioapply_map':
fs/xfs/xfs_buf.c:1312:4: error: implicit declaration of function 'flush_kernel_vmap_range' [-Werror=implicit-function-declaration]
    flush_kernel_vmap_range(bp->b_addr,
    ^~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/cacheflush.h |  2 ++
 arch/nds32/mm/cacheflush.c          | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 1240f148ec0f..10b48f0d8e85 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -32,6 +32,8 @@ void flush_anon_page(struct vm_area_struct *vma,
 
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 void flush_kernel_dcache_page(struct page *page);
+void flush_kernel_vmap_range(void *addr, int size);
+void invalidate_kernel_vmap_range(void *addr, int size);
 void flush_icache_range(unsigned long start, unsigned long end);
 void flush_icache_page(struct vm_area_struct *vma, struct page *page);
 #define flush_dcache_mmap_lock(mapping)   xa_lock_irq(&(mapping)->i_pages)
diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index 6eb786a399a2..bd52918d5923 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -273,6 +273,24 @@ void flush_kernel_dcache_page(struct page *page)
 	local_irq_restore(flags);
 }
 
+void flush_kernel_vmap_range(void *addr, int size)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	cpu_dcache_wb_range((unsigned long)addr, (unsigned long)addr +  size);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(flush_kernel_vmap_range);
+
+void invalidate_kernel_vmap_range(void *addr, int size)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	cpu_dcache_inval_range((unsigned long)addr, (unsigned long)addr + size);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(invalidate_kernel_vmap_range);
+
 void flush_icache_range(unsigned long start, unsigned long end)
 {
 	unsigned long line_size, flags;
-- 
1.9.5
