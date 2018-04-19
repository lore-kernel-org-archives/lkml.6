Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeDSNUN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:20:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37010 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbeDSNUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:20:09 -0400
X-Google-Smtp-Source: AIpwx4+4AQuy5HU2mwiAPw4VRKoDgYU7Nc9vcWqq5ePgcTYVij8oyH/vJY/gXpF3MtlMKTM7Nkb6Sg==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net
Subject: [PATCH 5/9] nds32: Fix xfs_buf built failed by export invalidate_kernel_vmap_range and flush_kernel_vmap_range
Date: Thu, 19 Apr 2018 21:18:11 +0800
Message-Id: <d92ae87097f83ed90196accd4b03ed6993919f0a.1524143428.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
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
