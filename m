Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966272AbeBUQLj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932757AbeBUQLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:11:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EAF217A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELtnkVFyHNkgZDPJHjmSOW2YZiczrhNg7EcMpyqJ5/w4A+cwGvYBexLS75lTP7HOqIUd8aXnhBBSfSfYoJPSN68=
MIME-Version: 1.0
In-Reply-To: <20180221154214.GA4167@bombadil.infradead.org>
References: <151670492223.658225.4605377710524021456.stgit@buzz>
 <151670493255.658225.2881484505285363395.stgit@buzz> <20180221154214.GA4167@bombadil.infradead.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 21 Feb 2018 16:11:16 +0000
X-Gmail-Original-Message-ID: <CALCETrU5jaennr5ziS9NzNA6KpK204acdroJpuc6yYy3PGvpHQ@mail.gmail.com>
Message-ID: <CALCETrU5jaennr5ziS9NzNA6KpK204acdroJpuc6yYy3PGvpHQ@mail.gmail.com>
Subject: Re: Use higher-order pages in vmalloc
To: Matthew Wilcox <willy@infradead.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Linux-MM <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 3:42 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Jan 23, 2018 at 01:55:32PM +0300, Konstantin Khlebnikov wrote:
>> Virtually mapped stack have two bonuses: it eats order-0 pages and
>> adds guard page at the end. But it slightly slower if system have
>> plenty free high-order pages.
>>
>> This patch adds option to use virtually bapped stack as fallback for
>> atomic allocation of traditional high-order page.
>
> This prompted me to write a patch I've been meaning to do for a while,
> allocating large pages if they're available to satisfy vmalloc.  I thought
> it would save on touching multiple struct pages, but it turns out that
> the checking code we currently have in the free_pages path requires you
> to have initialised all of the tail pages (maybe we can make that code
> conditional ...)
>
> It does save the buddy allocator the trouble of breaking down higher-order
> pages into order-0 pages, only to allocate them again immediately.
>
> (um, i seem to have broken the patch while cleaning it up for submission.
> since it probably won't be accepted anyway, I'm not going to try to debug it)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index be8aa5b98666..2bc01071b6ae 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -319,12 +319,12 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>         if (vm) {
>                 int i;
>
> -               BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
> -
> -               for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> -                       mod_zone_page_state(page_zone(vm->pages[i]),
> +               for (i = 0; i < vm->nr_pages; i++) {
> +                       struct page *page = vm->pages[i];
> +                       unsigned int size = PAGE_SIZE << compound_order(page);
> +                       mod_zone_page_state(page_zone(page),
>                                             NR_KERNEL_STACK_KB,
> -                                           PAGE_SIZE / 1024 * account);
> +                                           size / 1024 * account);
>                 }
>
>                 /* All stack pages belong to the same memcg. */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b728c98f49cd..4bfc29b21bc1 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -134,6 +134,7 @@ static void vunmap_page_range(unsigned long addr, unsigned long end)
>  static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
>                 unsigned long end, pgprot_t prot, struct page **pages, int *nr)
>  {
> +       unsigned int i;
>         pte_t *pte;
>
>         /*
> @@ -151,9 +152,13 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
>                         return -EBUSY;
>                 if (WARN_ON(!page))
>                         return -ENOMEM;
> -               set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
> +               for (i = 0; i < (1UL << compound_order(page)); i++) {
> +                       set_pte_at(&init_mm, addr, pte++,
> +                                       mk_pte(page + i, prot));
> +                       addr += PAGE_SIZE;
> +               }
>                 (*nr)++;
> -       } while (pte++, addr += PAGE_SIZE, addr != end);
> +       } while (addr != end);
>         return 0;
>  }
>
> @@ -1530,14 +1535,14 @@ static void __vunmap(const void *addr, int deallocate_pages)
>         debug_check_no_obj_freed(addr, get_vm_area_size(area));
>
>         if (deallocate_pages) {
> -               int i;
> +               unsigned int i;
>
>                 for (i = 0; i < area->nr_pages; i++) {
>                         struct page *page = area->pages[i];
>
>                         BUG_ON(!page);
>                         __ClearPageVmalloc(page);
> -                       __free_pages(page, 0);
> +                       __free_pages(page, compound_order(page));
>                 }
>
>                 kvfree(area->pages);
> @@ -1696,11 +1701,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>
>         for (i = 0; i < area->nr_pages; i++) {
>                 struct page *page;
> -
> -               if (node == NUMA_NO_NODE)
> -                       page = alloc_page(alloc_mask);
> -               else
> -                       page = alloc_pages_node(node, alloc_mask, 0);
> +               unsigned int j = ilog2(area->nr_pages - i) + 1;
> +
> +               do {
> +                       j--;
> +                       if (node == NUMA_NO_NODE)
> +                               page = alloc_pages(alloc_mask, j);
> +                       else
> +                               page = alloc_pages_node(node, alloc_mask, j);
> +               } while (!page && j);
> +
> +               if (j) {
> +                       area->nr_pages -= (1UL << j) - 1;

Is there any code that expects area->nr_pages to be the size of the
area in pages?  I don't know of any such code.

> +                       prep_compound_page(page, j);
> +               }
>
>                 if (unlikely(!page)) {
>                         /* Successfully allocated i pages, free them in __vunmap() */
> @@ -1719,8 +1733,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>
>  fail:
>         warn_alloc(gfp_mask, NULL,
> -                         "vmalloc: allocation failure, allocated %ld of %ld bytes",
> -                         (area->nr_pages*PAGE_SIZE), area->size);
> +                  "vmalloc: allocation failure, allocated %ld of %ld bytes",
> +                  (nr_pages * PAGE_SIZE), get_vm_area_size(area));
>         vfree(area->addr);
>         return NULL;
>  }
