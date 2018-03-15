Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeCOUAe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:00:34 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51160 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeCOUAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:00:33 -0400
Date: Thu, 15 Mar 2018 16:00:30 -0400 (EDT)
Message-Id: <20180315.160030.601332550949971028.davem@davemloft.net>
To: nitin.m.gupta@oracle.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: sparc64 MM regression...
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180315.152815.1012910593389921933.davem@davemloft.net>
References: <20180315.152815.1012910593389921933.davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 15 Mar 2018 15:28:15 -0400 (EDT)

> 
> So I bisected a userspace corruption regression down to commit:
> 
> commit a8e654f01cb725d0bfd741ebca1bf4c9337969cc                                                                                    
> Author: Nitin Gupta <nitin.m.gupta@oracle.com>                                                                                     
> Date:   Wed Jan 31 16:18:09 2018 -0800                                                                                             
>                                                                                                                                    
>     sparc64: update pmdp_invalidate() to return old pmd value                                                                      
> 
> The transformation is basically from a set_pte_at() call into
> an atomic cmpxchg64() loop to set the pmd.
> 
> The problem is that set_pmd_at() does more than just assign
> the pmd entry.
> 
> It also does some accounting and also queues up a batch TLB
> flush entry.
> 
> So the side effect of this change is that the TLB is never
> flushed for these changed PMDs, and thus the userland memory
> corruption I was seeing.

This seems to do the trick:

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 847ddff..b5cfab7 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -163,13 +163,10 @@ static void tlb_batch_pmd_scan(struct mm_struct *mm, unsigned long vaddr,
 	pte_unmap(pte);
 }
 
-void set_pmd_at(struct mm_struct *mm, unsigned long addr,
-		pmd_t *pmdp, pmd_t pmd)
-{
-	pmd_t orig = *pmdp;
-
-	*pmdp = pmd;
 
+static void __set_pmd_acct(struct mm_struct *mm, unsigned long addr,
+			   pmd_t orig, pmd_t pmd)
+{
 	if (mm == &init_mm)
 		return;
 
@@ -219,6 +216,15 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t orig = *pmdp;
+
+	*pmdp = pmd;
+	__set_pmd_acct(mm, addr, orig, pmd);
+}
+
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
@@ -227,6 +233,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 	do {
 		old = *pmdp;
 	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);
+	__set_pmd_acct(vma->vm_mm, address, old, pmd);
 
 	return old;
 }
