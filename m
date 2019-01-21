Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4CBC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EC120861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfAUOVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:21:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35354 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbfAUOVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:21:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDB38EBD;
        Mon, 21 Jan 2019 06:21:31 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3363F5C1;
        Mon, 21 Jan 2019 06:21:30 -0800 (PST)
Date:   Mon, 21 Jan 2019 14:21:28 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     chenwandun <chenwandun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wangkefeng (Kevin)" <wangkefeng.wang@huawei.com>,
        anshuman.khandual@arm.com
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Message-ID: <20190121142127.GD29504@arrakis.emea.arm.com>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119235825.GG26876@brain-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:58:27PM +0000, Will Deacon wrote:
> On Thu, Jan 17, 2019 at 07:42:44AM +0000, chenwandun wrote:
> > Recently, I do some tests on linux-4.19 and hit a softlockup issue.
> > 
> > I find some CPUs get the spinlock in the __split_huge_pmd function and
> > then send IPI to other CPUs, waiting the response, while several CPUs
> > enter the __split_huge_pmd function, want to get the spinlock, but always
> > in queued_spin_lock_slowpath,
> > 
> > Because long time no response to the IPI, that results in a softlockup.
> > 
> > As to sending IPI, it was in the patch
> > 3b8c9f1cdfc506e94e992ae66b68bbe416f89610.  The patch is mean to send IPI
> > to each CPU after invalidating the I-cache for kernel mappings.  In this
> > case, after modify pmd, it sends IPI to other CPUS to sync memory
> > mappings.
> > 
> > No stable test case to repeat the result, it is hard to repeat the test procedure.
> > 
> > The environment is arm64, 64 CPUs. Except for idle CPU, there are 6 kind
> > of callstacks in total.
> 
> This looks like another lockup that would be solved if we deferred our
> I-cache invalidation when mapping user-executable pages, and instead
> performed the invalidation off the back of a UXN permission fault, where we
> could avoid holding any locks.

Looking back at commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after
invalidating the I-cache for kernel mappings"), the text implies that it
should only do this for kernel mappings. I don't think we need this for
user mappings. We have a few scenarios where we invoke set_pte_at() with
exec permission:

1. Page faulted in - the pte was not previously accessible and the CPU
   should not have stale decoded instructions (my interpretation of the
   ARM ARM).

2. huge pmd splitting - there is no change to the underlying data. I
   have a suspicion here that we shouldn't even call
   sync_icache_aliases() but probably the PG_arch_1 isn't carried over
   from the head compound page to the small pages (needs checking).

3. page migration - there is no change to the underlying data and
   instructions, so I don't think we need the all CPUs sync.

4. mprotect() setting exec permission - that's normally the
   responsibility of the user to ensure cache maintenance

(I can add more text to the patch below but need to get to the bottom of
this first)

---------8<-------------------------------------------------
arm64: Do not issue IPIs for user executable ptes

From: Catalin Marinas <catalin.marinas@arm.com>

Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
for kernel mappings") was aimed at fixing the I-cache invalidation for
kernel mappings. However, it inadvertently caused all cache maintenance
for user mappings via set_pte_at() -> __sync_icache_dcache() to call
kick_all_cpus_sync().

Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
Cc: <stable@vger.kernel.org> # 4.19.x-
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cacheflush.h |    2 +-
 arch/arm64/kernel/probes/uprobes.c  |    2 +-
 arch/arm64/mm/flush.c               |   14 ++++++++++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 19844211a4e6..18e92d9dacd4 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -80,7 +80,7 @@ extern void __clean_dcache_area_poc(void *addr, size_t len);
 extern void __clean_dcache_area_pop(void *addr, size_t len);
 extern void __clean_dcache_area_pou(void *addr, size_t len);
 extern long __flush_cache_user_range(unsigned long start, unsigned long end);
-extern void sync_icache_aliases(void *kaddr, unsigned long len);
+extern void sync_icache_aliases(void *kaddr, unsigned long len, bool sync);
 
 static inline void flush_icache_range(unsigned long start, unsigned long end)
 {
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 636ca0119c0e..595e8c8f41cd 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -24,7 +24,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	memcpy(dst, src, len);
 
 	/* flush caches (dcache/icache) */
-	sync_icache_aliases(dst, len);
+	sync_icache_aliases(dst, len, true);
 
 	kunmap_atomic(xol_page_kaddr);
 }
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 30695a868107..5c2f23a92d14 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -25,15 +25,17 @@
 #include <asm/cache.h>
 #include <asm/tlbflush.h>
 
-void sync_icache_aliases(void *kaddr, unsigned long len)
+void sync_icache_aliases(void *kaddr, unsigned long len, bool sync)
 {
 	unsigned long addr = (unsigned long)kaddr;
 
 	if (icache_is_aliasing()) {
 		__clean_dcache_area_pou(kaddr, len);
 		__flush_icache_all();
-	} else {
+	} else if (sync) {
 		flush_icache_range(addr, addr + len);
+	} else {
+		__flush_icache_range(addr, addr + len);
 	}
 }
 
@@ -42,7 +44,7 @@ static void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 				unsigned long len)
 {
 	if (vma->vm_flags & VM_EXEC)
-		sync_icache_aliases(kaddr, len);
+		sync_icache_aliases(kaddr, len, true);
 }
 
 /*
@@ -63,8 +65,12 @@ void __sync_icache_dcache(pte_t pte)
 	struct page *page = pte_page(pte);
 
 	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+		/*
+		 * Don't issue kick_all_cpus_sync() after I-cache invalidation
+		 * when setting a user executable pte.
+		 */
 		sync_icache_aliases(page_address(page),
-				    PAGE_SIZE << compound_order(page));
+				    PAGE_SIZE << compound_order(page), false);
 }
 EXPORT_SYMBOL_GPL(__sync_icache_dcache);
 
