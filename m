Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeDVXJy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 19:09:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:39565 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753489AbeDVXJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 19:09:53 -0400
Date: Mon, 23 Apr 2018 01:09:48 +0200
From: Jan Kara <jack@suse.cz>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: viro@zeniv.linux.org.uk, mawilcox@microsoft.com,
        ross.zwisler@linux.intel.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, mhocko@suse.com, jack@suse.cz,
        kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: dax: Adding new return type vm_fault_t
Message-ID: <20180422230948.2mvimlf3zspry4ji@quack2.suse.cz>
References: <20180421210529.GA27238@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421210529.GA27238@jordon-HP-15-Notebook-PC>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 22-04-18 02:35:29, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> There was an existing bug inside dax_load_hole()
> if vm_insert_mixed had failed to allocate a page table,
> we'd return VM_FAULT_NOPAGE instead of VM_FAULT_OOM.
> With new vmf_insert_mixed() this issue is addressed.
> 
> vm_insert_mixed_mkwrite has inefficiency when it returns
> an error value, driver has to convert it to vm_fault_t
> type. With new vmf_insert_mixed_mkwrite() this limitation
> will be addressed.
> 
> As new function vmf_insert_mixed_mkwrite() only called
> from fs/dax.c, so keeping both the changes in a single
> patch.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

The patch looks good to me. Just one question:

> diff --git a/mm/memory.c b/mm/memory.c
> index 01f5464..721cfd5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1955,12 +1955,19 @@ int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
>  }
>  EXPORT_SYMBOL(vm_insert_mixed);
>  
> -int vm_insert_mixed_mkwrite(struct vm_area_struct *vma, unsigned long addr,
> -			pfn_t pfn)
> +vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
> +		unsigned long addr, pfn_t pfn)
>  {
> -	return __vm_insert_mixed(vma, addr, pfn, true);
> +	int err;
> +
> +	err =  __vm_insert_mixed(vma, addr, pfn, true);
> +	if (err == -ENOMEM)
> +		return VM_FAULT_OOM;
> +	if (err < 0 && err != -EBUSY)
> +		return VM_FAULT_SIGBUS;
> +	return VM_FAULT_NOPAGE;
>  }
> -EXPORT_SYMBOL(vm_insert_mixed_mkwrite);
> +EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);

So are we sure that all the callers of this function (and also of
vmf_insert_mixed()) are OK with EBUSY? Because especially in the
vmf_insert_mixed() case other page than the caller provided is in page
tables and thus possibly the caller needs to do some error recovery (such
as drop page refcount) in such case...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
