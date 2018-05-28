Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937909AbeE1MqN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:46:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34993 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937828AbeE1K53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:57:29 -0400
X-Google-Smtp-Source: ADUXVKKPEnzCFXGXOg8qOaNZsO0W3O+6Kr6pGdKZOiHIN2+jCxm29OlEz1qF1DdHoJYjXHb7hNMNbw==
Date: Mon, 28 May 2018 13:57:24 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Song Liu <songliubraving@fb.com>
Cc: linux-mm@kvack.org, kernel-team@fb.com, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, rientjes@google.com, aarcange@redhat.com
Subject: Re: [PATCH v2] mm/THP: use hugepage_vma_check() in
 khugepaged_enter_vma_merge()
Message-ID: <20180528105724.okg6c7i72r3v3jno@kshutemo-mobl1>
References: <20180522194430.426688-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522194430.426688-1-songliubraving@fb.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 12:44:30PM -0700, Song Liu wrote:
> khugepaged_enter_vma_merge() is using a different approach to check
> whether a vma is valid for khugepaged_enter():
> 
>     if (!vma->anon_vma)
>             /*
>              * Not yet faulted in so we will register later in the
>              * page fault if needed.
>              */
>             return 0;
>     if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
>             /* khugepaged not yet working on file or special mappings */
>             return 0;
> 
> This check has some problems. One of the obvious problems is that
> it doesn't check shmem_file(), so that vma backed with shmem files
> will not call khugepaged_enter(). Here is an example of failed madvise():
> 
>    /* mount /dev/shm with huge=advise:
>     *     mount -o remount,huge=advise /dev/shm */
>    /* create file /dev/shm/huge */
>    #define HUGE_FILE "/dev/shm/huge"
> 
>    fd = open(HUGE_FILE, O_RDONLY);
>    ptr = mmap(NULL, FILE_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
>    ret = madvise(ptr, FILE_SIZE, MADV_HUGEPAGE);
> 
> madvise() will return 0, but this memory region is never put in huge
> page (check from /proc/meminfo: ShmemHugePages).
> 
> This patch fixes these problems by reusing hugepage_vma_check() in
> khugepaged_enter_vma_merge().
> 
> vma->vm_flags is not yet updated in khugepaged_enter_vma_merge(),
> so we need to pass the new vm_flags to hugepage_vma_check() through
> a separate argument.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  mm/khugepaged.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d7b2a4b..9f74e51 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -430,18 +430,15 @@ int __khugepaged_enter(struct mm_struct *mm)
>  	return 0;
>  }
>  
> +static bool hugepage_vma_check(struct vm_area_struct *vma,
> +			       unsigned long vm_flags);
> +

The patch looks good to me.

But can we move hugepage_vma_check() here to avoid forward declaration of
the function?

-- 
 Kirill A. Shutemov
