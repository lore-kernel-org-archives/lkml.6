Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtKa1E43xzVyPYDNWYMpw3JECAEsTQtFL5ch0owWwbGez+854Os50CtEi/M44aSs1hcIsGB
ARC-Seal: i=1; a=rsa-sha256; t=1520641264; cv=none;
        d=google.com; s=arc-20160816;
        b=uw6/32RfHNMuT5k3hC41xSzx0ClrNSm7nlhCnjwJataytT65gbz13FXPXR6bNowymS
         a33HTMqivQfuoYdr+4iT5vU7JtIGTctd4yGk2wXV+yOpMFLdF5PfBA6B58yWKF2mp/GZ
         zY0atGAAJHNpCF9aRS3AqeJGdAbM7HND/G/PpWoTa2NRfWSBib4lnks5vOACLk/WB6iD
         DXDxO0+5SvgEvr0uGfMrotFyWMqzOizuyI63wawjkgmkuLVd5yEu+tModis4V1AQJZ8G
         1DH5ghWg63hiAT4TPRkwk9ucUN4V5/mdpClSOfpkdTsj5wgeJ4iUMGemvZb1yjTh6bSW
         CEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MPmef3S+CcP4RPTinRaaeHC9LK2vR2D5bYPcTXlerfA=;
        b=pNYzEHZIMw+X/6RIM5UPNZwv0Xe6OvH1SxCUV10/ecKIBQkF6x0qO52zUiTYZuVyaR
         +G0FxFh7Ic8H9IaLQm5jZU0gUwg74PkVHgpxvIjtoZEJQhA4rSrAOR5bXIIfztBsMTfx
         03/fkiVU/1ZDNhT2iSbcemjBw1bEAJfD3rorgrodHZOYBoo9yvzsh1477M0dp5tA4UAA
         g39QOjCGAMXV4pOvrsdTJTPGrxbVpjwE5l+BRCfqsQChcb1Ynl6dn8njE6LRSY2vrOei
         wDLV4sR8KrITDAk8pPK2PjmayTfNF+eE8Qu4ElWaoy80y6yWNyeXeCzXuYWMEJ9YhUt+
         ShnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?John=20David=20Anglin=C2=A0?= <dave.anglin@bell.net>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.9 12/65] parisc: Fix ordering of cache and TLB flushes
Date: Fri,  9 Mar 2018 16:18:12 -0800
Message-Id: <20180310001825.894672685@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507934529910157?=
X-GMAIL-MSGID: =?utf-8?q?1594507934529910157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John David Anglin <dave.anglin@bell.net>

commit 0adb24e03a124b79130c9499731936b11ce2677d upstream.

The change to flush_kernel_vmap_range() wasn't sufficient to avoid the
SMP stalls.  The problem is some drivers call these routines with
interrupts disabled.  Interrupts need to be enabled for flush_tlb_all()
and flush_cache_all() to work.  This version adds checks to ensure
interrupts are not disabled before calling routines that need IPI
interrupts.  When interrupts are disabled, we now drop into slower code.

The attached change fixes the ordering of cache and TLB flushes in
several cases.  When we flush the cache using the existing PTE/TLB
entries, we need to flush the TLB after doing the cache flush.  We don't
need to do this when we flush the entire instruction and data caches as
these flushes don't use the existing TLB entries.  The same is true for
tmpalias region flushes.

The flush_kernel_vmap_range() and invalidate_kernel_vmap_range()
routines have been updated.

Secondly, we added a new purge_kernel_dcache_range_asm() routine to
pacache.S and use it in invalidate_kernel_vmap_range().  Nominally,
purges are faster than flushes as the cache lines don't have to be
written back to memory.

Hopefully, this is sufficient to resolve the remaining problems due to
cache speculation.  So far, testing indicates that this is the case.  I
did work up a patch using tmpalias flushes, but there is a performance
hit because we need the physical address for each page, and we also need
to sequence access to the tmpalias flush code.  This increases the
probability of stalls.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Cc: stable@vger.kernel.org # 4.9+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/include/asm/cacheflush.h |    1 
 arch/parisc/kernel/cache.c           |   57 +++++++++++++++++++----------------
 arch/parisc/kernel/pacache.S         |   22 +++++++++++++
 3 files changed, 54 insertions(+), 26 deletions(-)

--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -25,6 +25,7 @@ void flush_user_icache_range_asm(unsigne
 void flush_kernel_icache_range_asm(unsigned long, unsigned long);
 void flush_user_dcache_range_asm(unsigned long, unsigned long);
 void flush_kernel_dcache_range_asm(unsigned long, unsigned long);
+void purge_kernel_dcache_range_asm(unsigned long, unsigned long);
 void flush_kernel_dcache_page_asm(void *);
 void flush_kernel_icache_page(void *);
 void flush_user_dcache_range(unsigned long, unsigned long);
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -464,10 +464,10 @@ EXPORT_SYMBOL(copy_user_page);
 int __flush_tlb_range(unsigned long sid, unsigned long start,
 		      unsigned long end)
 {
-	unsigned long flags, size;
+	unsigned long flags;
 
-	size = (end - start);
-	if (size >= parisc_tlb_flush_threshold) {
+	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
+	    end - start >= parisc_tlb_flush_threshold) {
 		flush_tlb_all();
 		return 1;
 	}
@@ -538,13 +538,11 @@ void flush_cache_mm(struct mm_struct *mm
 	struct vm_area_struct *vma;
 	pgd_t *pgd;
 
-	/* Flush the TLB to avoid speculation if coherency is required. */
-	if (parisc_requires_coherency())
-		flush_tlb_all();
-
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
-	if (mm_total_size(mm) >= parisc_cache_flush_threshold) {
+	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
+	    mm_total_size(mm) >= parisc_cache_flush_threshold) {
+		flush_tlb_all();
 		flush_cache_all();
 		return;
 	}
@@ -552,9 +550,9 @@ void flush_cache_mm(struct mm_struct *mm
 	if (mm->context == mfsp(3)) {
 		for (vma = mm->mmap; vma; vma = vma->vm_next) {
 			flush_user_dcache_range_asm(vma->vm_start, vma->vm_end);
-			if ((vma->vm_flags & VM_EXEC) == 0)
-				continue;
-			flush_user_icache_range_asm(vma->vm_start, vma->vm_end);
+			if (vma->vm_flags & VM_EXEC)
+				flush_user_icache_range_asm(vma->vm_start, vma->vm_end);
+			flush_tlb_range(vma, vma->vm_start, vma->vm_end);
 		}
 		return;
 	}
@@ -598,14 +596,9 @@ flush_user_icache_range(unsigned long st
 void flush_cache_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end)
 {
-	BUG_ON(!vma->vm_mm->context);
-
-	/* Flush the TLB to avoid speculation if coherency is required. */
-	if (parisc_requires_coherency())
+	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
+	    end - start >= parisc_cache_flush_threshold) {
 		flush_tlb_range(vma, start, end);
-
-	if ((end - start) >= parisc_cache_flush_threshold
-	    || vma->vm_mm->context != mfsp(3)) {
 		flush_cache_all();
 		return;
 	}
@@ -613,6 +606,7 @@ void flush_cache_range(struct vm_area_st
 	flush_user_dcache_range_asm(start, end);
 	if (vma->vm_flags & VM_EXEC)
 		flush_user_icache_range_asm(start, end);
+	flush_tlb_range(vma, start, end);
 }
 
 void
@@ -621,8 +615,7 @@ flush_cache_page(struct vm_area_struct *
 	BUG_ON(!vma->vm_mm->context);
 
 	if (pfn_valid(pfn)) {
-		if (parisc_requires_coherency())
-			flush_tlb_page(vma, vmaddr);
+		flush_tlb_page(vma, vmaddr);
 		__flush_cache_page(vma, vmaddr, PFN_PHYS(pfn));
 	}
 }
@@ -630,21 +623,33 @@ flush_cache_page(struct vm_area_struct *
 void flush_kernel_vmap_range(void *vaddr, int size)
 {
 	unsigned long start = (unsigned long)vaddr;
+	unsigned long end = start + size;
 
-	if ((unsigned long)size > parisc_cache_flush_threshold)
+	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
+	    (unsigned long)size >= parisc_cache_flush_threshold) {
+		flush_tlb_kernel_range(start, end);
 		flush_data_cache();
-	else
-		flush_kernel_dcache_range_asm(start, start + size);
+		return;
+	}
+
+	flush_kernel_dcache_range_asm(start, end);
+	flush_tlb_kernel_range(start, end);
 }
 EXPORT_SYMBOL(flush_kernel_vmap_range);
 
 void invalidate_kernel_vmap_range(void *vaddr, int size)
 {
 	unsigned long start = (unsigned long)vaddr;
+	unsigned long end = start + size;
 
-	if ((unsigned long)size > parisc_cache_flush_threshold)
+	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
+	    (unsigned long)size >= parisc_cache_flush_threshold) {
+		flush_tlb_kernel_range(start, end);
 		flush_data_cache();
-	else
-		flush_kernel_dcache_range_asm(start, start + size);
+		return;
+	}
+
+	purge_kernel_dcache_range_asm(start, end);
+	flush_tlb_kernel_range(start, end);
 }
 EXPORT_SYMBOL(invalidate_kernel_vmap_range);
--- a/arch/parisc/kernel/pacache.S
+++ b/arch/parisc/kernel/pacache.S
@@ -1110,6 +1110,28 @@ ENTRY_CFI(flush_kernel_dcache_range_asm)
 	.procend
 ENDPROC_CFI(flush_kernel_dcache_range_asm)
 
+ENTRY_CFI(purge_kernel_dcache_range_asm)
+	.proc
+	.callinfo NO_CALLS
+	.entry
+
+	ldil		L%dcache_stride, %r1
+	ldw		R%dcache_stride(%r1), %r23
+	ldo		-1(%r23), %r21
+	ANDCM		%r26, %r21, %r26
+
+1:      cmpb,COND(<<),n	%r26, %r25,1b
+	pdc,m		%r23(%r26)
+
+	sync
+	syncdma
+	bv		%r0(%r2)
+	nop
+	.exit
+
+	.procend
+ENDPROC_CFI(purge_kernel_dcache_range_asm)
+
 ENTRY_CFI(flush_user_icache_range_asm)
 	.proc
 	.callinfo NO_CALLS
