Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755345AbeD3XEi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:04:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeD3XEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:04:37 -0400
Date: Mon, 30 Apr 2018 16:04:36 -0700
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
Message-Id: <20180430160436.45f92ec5b3c78c84e4425ec4@linux-foundation.org>
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

As far as I can tell this is indeed the case, but it's a pretty weird
thing for us to do.  I wonder if there is any code in the kernel which
is passing such an offset address into vunmap().  If so, perhaps we
should check for it and do a WARN_ONCE so it gets fixed.

> Pass proper start address into debug object API.
>
> ...
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

But this still has the problem you described, no?  Shouldn't we be
doing yet another find_vmap_area()?

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
> @@ -1507,8 +1507,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  		return;
>  	}
>  
> -	debug_check_no_locks_freed(addr, get_vm_area_size(area));
> -	debug_check_no_obj_freed(addr, get_vm_area_size(area));
> +	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
> +	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
>  

Offtopic: it's a bit sad that __vunmap() does the find_vmap_area() then
calls remove_vm_area() which runs find_vmap_area() yet again...
