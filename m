Date: Wed, 28 Mar 2018 07:53:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Martijn Coenen <maco@android.com>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] ANDROID: binder: change down_write to down_read
Message-ID: <20180328055354.GC6212@kroah.com>
References: <20180328024231.239725-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328024231.239725-1-minchan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 11:42:31AM +0900, Minchan Kim wrote:
> binder_update_page_range needs down_write of mmap_sem because
> vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> it is set. However, when I profile binder working, it seems
> every binder buffers should be mapped in advance by binder_mmap.
> It means we could set VM_MIXEDMAP in bider_mmap time which is
> already hold a mmap_sem as down_write so binder_update_page_range
> doesn't need to hold a mmap_sem as down_write.
> 
> Android suffers from mmap_sem contention so let's reduce mmap_sem
> down_write.
> 
> Cc: Martijn Coenen <maco@android.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  drivers/android/binder.c       | 2 +-
>  drivers/android/binder_alloc.c | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 764b63a5aade..9a14c6dd60c4 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4722,7 +4722,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
>  		failure_string = "bad vm_flags";
>  		goto err_bad_arg;
>  	}
> -	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> +	vma->vm_flags |= (VM_DONTCOPY | VM_MIXEDMAP) & ~VM_MAYWRITE;
>  	vma->vm_ops = &binder_vm_ops;
>  	vma->vm_private_data = proc;
>  
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 5a426c877dfb..a184bf12eb15 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
>  		mm = alloc->vma_vm_mm;
>  
>  	if (mm) {
> -		down_write(&mm->mmap_sem);
> +		down_read(&mm->mmap_sem);
>  		vma = alloc->vma;
>  	}
>  
> @@ -229,6 +229,8 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
>  		goto err_no_vma;
>  	}
>  
> +	WARN_ON_ONCE(vma && !(vma->vm_flags & VM_MIXEDMAP));

What can we do with this warning?  What about systems that run in 'panic
on warn' mode?  Is this something we should handle directly instead?

thanks,

greg k-h
