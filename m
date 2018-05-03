Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeECVm0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:42:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57282 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeECVmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:42:24 -0400
Date: Thu, 3 May 2018 14:42:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: vbabka@suse.cz, labbott@redhat.com, catalin.marinas@arm.com,
        hannes@cmpxchg.org, f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, khandual@linux.vnet.ibm.com,
        mhocko@kernel.org
Subject: Re: [PATCH v2 2/2] mm: vmalloc: Pass proper vm_start into
 debugobjects
Message-Id: <20180503144222.bcb5c63bb96309bc3b37fb6f@linux-foundation.org>
In-Reply-To: <1523961828-9485-3-git-send-email-cpandya@codeaurora.org>
References: <1523961828-9485-1-git-send-email-cpandya@codeaurora.org>
        <1523961828-9485-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 16:13:48 +0530 Chintan Pandya <cpandya@codeaurora.org> wrote:

> Client can call vunmap with some intermediate 'addr'
> which may not be the start of the VM area. Entire
> unmap code works with vm->vm_start which is proper
> but debug object API is called with 'addr'. This
> could be a problem within debug objects.
> 
> Pass proper start address into debug object API.
> 
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1124,15 +1124,15 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  	BUG_ON(addr > VMALLOC_END);
>  	BUG_ON(!PAGE_ALIGNED(addr));
>  
> -	debug_check_no_locks_freed(mem, size);
> -
>  	if (likely(count <= VMAP_MAX_ALLOC)) {
> +		debug_check_no_locks_freed(mem, size);
>  		vb_free(mem, size);
>  		return;
>  	}
>  
>  	va = find_vmap_area(addr);
>  	BUG_ON(!va);
> +	debug_check_no_locks_freed(va->va_start, (va->va_end - va->va_start));
>  	free_unmap_vmap_area(va);
>  }
>  EXPORT_SYMBOL(vm_unmap_ram);

hm, how did this sneak through?

mm/vmalloc.c:1139:29: warning: passing argument 1 of debug_check_no_locks_freed makes pointer from integer without a cast [-Wint-conversion]
  debug_check_no_locks_freed(va->va_start, (va->va_end - va->va_start));

--- a/mm/vmalloc.c~mm-vmalloc-pass-proper-vm_start-into-debugobjects-fix
+++ a/mm/vmalloc.c
@@ -1136,7 +1136,8 @@ void vm_unmap_ram(const void *mem, unsig
 
 	va = find_vmap_area(addr);
 	BUG_ON(!va);
-	debug_check_no_locks_freed(va->va_start, (va->va_end - va->va_start));
+	debug_check_no_locks_freed((void *)va->va_start,
+				    (va->va_end - va->va_start));
 	free_unmap_vmap_area(va);
 }
 EXPORT_SYMBOL(vm_unmap_ram);
