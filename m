Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeC0V5e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:57:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39504 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeC0V5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:57:33 -0400
X-Google-Smtp-Source: AIpwx4/j8jaobsE7aAx/Ycci1NGAhsJ44On/EJSun47WEqpO0NIWoL8lxqcpkd/6BisbPzbkFhMQ3A==
Date: Tue, 27 Mar 2018 14:57:31 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, kirill@shutemov.name,
        ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: Re: [PATCH v9 08/24] mm: Protect VMA modifications using VMA sequence
 count
In-Reply-To: <1520963994-28477-9-git-send-email-ldufour@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1803271454390.41987@chino.kir.corp.google.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com> <1520963994-28477-9-git-send-email-ldufour@linux.vnet.ibm.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018, Laurent Dufour wrote:

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5898255d0aeb..d6533cb85213 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -847,17 +847,18 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  	}
>  
>  	if (start != vma->vm_start) {
> -		vma->vm_start = start;
> +		WRITE_ONCE(vma->vm_start, start);
>  		start_changed = true;
>  	}
>  	if (end != vma->vm_end) {
> -		vma->vm_end = end;
> +		WRITE_ONCE(vma->vm_end, end);
>  		end_changed = true;
>  	}
> -	vma->vm_pgoff = pgoff;
> +	WRITE_ONCE(vma->vm_pgoff, pgoff);
>  	if (adjust_next) {
> -		next->vm_start += adjust_next << PAGE_SHIFT;
> -		next->vm_pgoff += adjust_next;
> +		WRITE_ONCE(next->vm_start,
> +			   next->vm_start + (adjust_next << PAGE_SHIFT));
> +		WRITE_ONCE(next->vm_pgoff, next->vm_pgoff + adjust_next);
>  	}
>  
>  	if (root) {
> @@ -1781,6 +1782,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  out:
>  	perf_event_mmap(vma);
>  
> +	vm_write_begin(vma);
>  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
>  	if (vm_flags & VM_LOCKED) {
>  		if (!((vm_flags & VM_SPECIAL) || is_vm_hugetlb_page(vma) ||
> @@ -1803,6 +1805,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vma->vm_flags |= VM_SOFTDIRTY;
>  
>  	vma_set_page_prot(vma);
> +	vm_write_end(vma);
>  
>  	return addr;
>  

Shouldn't this also protect vma->vm_flags?

diff --git a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1796,7 +1796,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 					vma == get_gate_vma(current->mm)))
 			mm->locked_vm += (len >> PAGE_SHIFT);
 		else
-			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+			WRITE_ONCE(vma->vm_flags,
+				   vma->vm_flags & VM_LOCKED_CLEAR_MASK);
 	}
 
 	if (file)
@@ -1809,7 +1810,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * then new mapped in-place (which must be aimed as
 	 * a completely new data area).
 	 */
-	vma->vm_flags |= VM_SOFTDIRTY;
+	WRITE_ONCE(vma->vm_flags, vma->vm_flags | VM_SOFTDIRTY);
 
 	vma_set_page_prot(vma);
 	vm_write_end(vma);
