Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsjevytmC30XE7mJ0EY3rx5YGzYmO7o1k+oGK6inzP63ZiLG1hxplitJN7rLYQ7Ic698f01
ARC-Seal: i=1; a=rsa-sha256; t=1521484139; cv=none;
        d=google.com; s=arc-20160816;
        b=bw5XXk5b0GNqzH07ebek8QaNu75CISI4hAGrD3QemsqPq+hrM1COnAXNvQAt3bqY90
         92hyPizTa6yioqjcqlX/gX880s0KkfdIQ08YZYNe3iPHJOjHlhJ6oAQXWbDB6aElBjvF
         /96Xi3M/harE2E4j5g7NpG+1WfReYxdLKG3mxmD7q8U+15ioM6hptrm1bMtFA8Gr8p6+
         rFYQMXTrsjxZc4pYr8YkGBhLMUY3pkwYIoLYKIRWXHkio/gk4Ba+B/RXkQ8JfAfLwRgO
         isi1IOJYAtAKI50FnY8O+JouiRISUfvOkRTdjdsCQZeGsMw5BztqR8TejLA0Wq9Pt1M5
         1KJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=olCDKFlka5Tn2JVfj9t9wvq9Q2RhiZHyX29yxPS56Y0=;
        b=bcG0bzNdRuDqjPv90fYxVjrncZ6TZEz8qM3jVeMZ2TUwxb1gJUGsH7/ovNGHC6mW+6
         G8a2KzbpLL/qwMaM66ChW+XZ710mtPqoAlYtU7eZZFq+qsT1t9RDLO+snUxi+29Q3q2A
         nBkex3EiD2ed8BnYDYmbMuBDAzD1b7Ww+eLZDpTvulYCkys0lVdgvOW4E0dALQPO2Su6
         6kKwiGHDsZsYgc8vbxIeSkfj7w4ea+HlUfaewb6EkuxTuflBhFn5scTU8xWOtI/4Wzup
         u49Bx0oG9+Vq3TrPLigsmWdSKpAtDzRRLWTakdQZj16aQVso+njqMxnNRpmAr/Pp0GA/
         kT3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John David Anglin <dave.anglin@bell.net>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.9 221/241] parisc: Handle case where flush_cache_range is called with no context
Date: Mon, 19 Mar 2018 19:08:06 +0100
Message-Id: <20180319180800.319874116@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391753021441659?=
X-GMAIL-MSGID: =?utf-8?q?1595391753021441659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John David Anglin <dave.anglin@bell.net>

commit 9ef0f88fe5466c2ca1d2975549ba6be502c464c1 upstream.

Just when I had decided that flush_cache_range() was always called with
a valid context, Helge reported two cases where the
"BUG_ON(!vma->vm_mm->context);" was hit on the phantom buildd:

 kernel BUG at /mnt/sdb6/linux/linux-4.15.4/arch/parisc/kernel/cache.c:587!
 CPU: 1 PID: 3254 Comm: kworker/1:2 Tainted: G D 4.15.0-1-parisc64-smp #1 Debian 4.15.4-1+b1
 Workqueue: events free_ioctx
  IAOQ[0]: flush_cache_range+0x164/0x168
  IAOQ[1]: flush_cache_page+0x0/0x1c8
  RP(r2): unmap_page_range+0xae8/0xb88
 Backtrace:
  [<00000000404a6980>] unmap_page_range+0xae8/0xb88
  [<00000000404a6ae0>] unmap_single_vma+0xc0/0x188
  [<00000000404a6cdc>] zap_page_range_single+0x134/0x1f8
  [<00000000404a702c>] unmap_mapping_range+0x1cc/0x208
  [<0000000040461518>] truncate_pagecache+0x98/0x108
  [<0000000040461624>] truncate_setsize+0x9c/0xb8
  [<00000000405d7f30>] put_aio_ring_file+0x80/0x100
  [<00000000405d803c>] aio_free_ring+0x8c/0x290
  [<00000000405d82c0>] free_ioctx+0x80/0x180
  [<0000000040284e6c>] process_one_work+0x21c/0x668
  [<00000000402854c4>] worker_thread+0x20c/0x778
  [<0000000040291d44>] kthread+0x2d4/0x2e0
  [<0000000040204020>] end_fault_vector+0x20/0xc0

This indicates that we need to handle the no context case in
flush_cache_range() as we do in flush_cache_mm().

In thinking about this, I realized that we don't need to flush the TLB
when there is no context.  So, I added context checks to the large flush
cases in flush_cache_mm() and flush_cache_range().  The large flush case
occurs frequently in flush_cache_mm() and the change should improve fork
performance.

The v2 version of this change removes the BUG_ON from flush_cache_page()
by skipping the TLB flush when there is no context.  I also added code
to flush the TLB in flush_cache_mm() and flush_cache_range() when we
have a context that's not current.  Now all three routines handle TLB
flushes in a similar manner.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Cc: stable@vger.kernel.org # 4.9+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/cache.c |   41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -542,7 +542,8 @@ void flush_cache_mm(struct mm_struct *mm
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
 	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
 	    mm_total_size(mm) >= parisc_cache_flush_threshold) {
-		flush_tlb_all();
+		if (mm->context)
+			flush_tlb_all();
 		flush_cache_all();
 		return;
 	}
@@ -570,6 +571,8 @@ void flush_cache_mm(struct mm_struct *mm
 			pfn = pte_pfn(*ptep);
 			if (!pfn_valid(pfn))
 				continue;
+			if (unlikely(mm->context))
+				flush_tlb_page(vma, addr);
 			__flush_cache_page(vma, addr, PFN_PHYS(pfn));
 		}
 	}
@@ -596,26 +599,46 @@ flush_user_icache_range(unsigned long st
 void flush_cache_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end)
 {
+	pgd_t *pgd;
+	unsigned long addr;
+
 	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
 	    end - start >= parisc_cache_flush_threshold) {
-		flush_tlb_range(vma, start, end);
+		if (vma->vm_mm->context)
+			flush_tlb_range(vma, start, end);
 		flush_cache_all();
 		return;
 	}
 
-	flush_user_dcache_range_asm(start, end);
-	if (vma->vm_flags & VM_EXEC)
-		flush_user_icache_range_asm(start, end);
-	flush_tlb_range(vma, start, end);
+	if (vma->vm_mm->context == mfsp(3)) {
+		flush_user_dcache_range_asm(start, end);
+		if (vma->vm_flags & VM_EXEC)
+			flush_user_icache_range_asm(start, end);
+		flush_tlb_range(vma, start, end);
+		return;
+	}
+
+	pgd = vma->vm_mm->pgd;
+	for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
+		unsigned long pfn;
+		pte_t *ptep = get_ptep(pgd, addr);
+		if (!ptep)
+			continue;
+		pfn = pte_pfn(*ptep);
+		if (pfn_valid(pfn)) {
+			if (unlikely(vma->vm_mm->context))
+				flush_tlb_page(vma, addr);
+			__flush_cache_page(vma, addr, PFN_PHYS(pfn));
+		}
+	}
 }
 
 void
 flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr, unsigned long pfn)
 {
-	BUG_ON(!vma->vm_mm->context);
-
 	if (pfn_valid(pfn)) {
-		flush_tlb_page(vma, vmaddr);
+		if (likely(vma->vm_mm->context))
+			flush_tlb_page(vma, vmaddr);
 		__flush_cache_page(vma, vmaddr, PFN_PHYS(pfn));
 	}
 }
