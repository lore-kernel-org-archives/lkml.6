Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDTT31 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751136AbeDTT30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:29:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1292D217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 20 Apr 2018 15:29:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mhocko@suse.com, linux-mm@kvack.org,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        fengguang.wu@intel.com, dennisszhou@gmail.com
Subject: Re: [v1] mm: access to uninitialized struct page
Message-ID: <20180420152922.21f43e52@gandalf.local.home>
In-Reply-To: <20180420191042.23452-1-pasha.tatashin@oracle.com>
References: <20180420191042.23452-1-pasha.tatashin@oracle.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The patch diff itself looks fine, just some comments on the submission
of this.

#1, the subject should be: [PATCH] init: Call mm_init() before trap_init()

Need "PATCH" and not "v1". The versions start with the second update of
a patch, and then it would be "[PATCH v2]"


On Fri, 20 Apr 2018 15:10:42 -0400
Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> The following two bugs were reported by Fengguang Wu:
> 
> kernel reboot-without-warning in early-boot stage, last printk:
> early console in setup code
> 
> https://lkml.org/lkml/2018/4/18/797

#2, Do not use "lkml.org" it is a very unreliable source.

When referencing, use http://lkml.kernel.org/r/<message-id>

For the above, that would be:

  http://lkml.kernel.org/r/20180418135300.inazvpxjxowogyge@wfg-t540p.sh.intel.com
> 
> And, also:
> [per_cpu_ptr_to_phys] PANIC: early exception 0x0d
> IP 10:ffffffffa892f15f error 0 cr2 0xffff88001fbff000
> 
> https://lkml.org/lkml/2018/4/18/387

Same here.

> 
> Both of the problems are due to accessing uninitialized struct page from
> trap_init(). We must first do mm_init() in order to initialize allocated
> struct pages, and than we can access fields of any struct page that belongs
> to memory that's been allocated.
> 
> Below is explanation of the root cause.
> 
> The issue arises in this stack:
> 
> start_kernel()
>  trap_init()
>   setup_cpu_entry_areas()
>    setup_cpu_entry_area(cpu)
>     get_cpu_gdt_paddr(cpu)
>      per_cpu_ptr_to_phys(addr)
>       pcpu_addr_to_page(addr)
>        virt_to_page(addr)
>         pfn_to_page(__pa(addr) >> PAGE_SHIFT)
> The returned "struct page" is sometimes uninitialized, and thus
> failing later when used. It turns out sometimes is because it depends
> on KASLR.
> 
> When boot is failing we have this when  pfn_to_page() is called:
> kasrl: 0x000000000d600000
>  addr: ffffffff83e0d000
>     pa: 1040d000
>    pfn: 1040d
> page: ffff88001f113340
> page->flags ffffffffffffffff <- Uninitialized!
> 
> When boot is successful:
> kaslr: 0x000000000a800000
>  addr: ffffffff83e0d000
>      pa: d60d000
>     pfn: d60d
>  page: ffff88001f05b340
> page->flags 280000000000 <- Initialized!
> 
> Here are physical addresses that BIOS provided to us:
> e820: BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> BIOS-e820: [mem 0x0000000000100000-0x000000001ffdffff] usable
> BIOS-e820: [mem 0x000000001ffe0000-0x000000001fffffff] reserved
> BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> 
> In both cases, working and non-working the real physical address is
> the same:
> 
> pa - kasrl = 0x2E0D000
> 
> The only thing that is different is PFN.
> 
> We initialize struct pages in four places:
> 
> 1. Early in boot a small set of struct pages is initialized to fill
> the first section, and lower zones.
> 2. During mm_init() we initialize "struct pages" for all the memory
> that is allocated, i.e reserved in memblock.
> 3. Using on-demand logic when pages are allocated after mm_init call
> 4. After smp_init() when the rest free deferred pages are initialized.
> 
> The above path happens before deferred memory is initialized, and thus
> it must be covered either by 1, 2 or 3.
> 
> So, lets check what PFNs are initialized after (1).
> 
> memmap_init_zone() is called for pfn ranges:
> 1 - 1000, and 1000 - 1ffe0, but it quits after reaching pfn 0x10000,
> as it leaves the rest to be initialized as deferred pages.
> 
> In the working scenario pfn ended up being below 1000, but in the
> failing scenario it is above. Hence, we must initialize this page in
> (2). But trap_init() is called before mm_init().
> 
> The bug was introduced by "mm: initialize pages on demand during boot"
> because we lowered amount of pages that is initialized in the step
> (1). But, it still could happen, because the number of initialized
> pages was a guessing.
> 
> The current fix moves trap_init() to be called after mm_init, but as
> alternative, we could increase pgdat->static_init_pgcnt:
> In free_area_init_node we can increase:
>        pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
>                                         pgdat->node_spanned_pages);
> Instead of one PAGES_PER_SECTION, set several, so the text is
> covered for all KASLR offsets. But, this would still be guessing.
> Therefore, I prefer the current fix.
> 
> Fixes: c9e97a1997fb ("mm: initialize pages on demand during boot")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index b795aa341a3a..870f75581cea 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -585,8 +585,8 @@ asmlinkage __visible void __init start_kernel(void)
>  	setup_log_buf(0);
>  	vfs_caches_init_early();
>  	sort_main_extable();
> -	trap_init();
>  	mm_init();
> +	trap_init();

I'm fine with this change, but what happens if mm_init() traps?

But that is probably not a case we really care about, as it is in the
very early boot stage.

>  
>  	ftrace_init();
>  

One thing I could add is to move ftrace_init() before trap_init(). But
that may require some work, because it may still depend on trap_init()
as well. But making ftrace_init() not depend on trap_init() is easier
than making it not depend on ftrace_init(). Although it may require
more arch updates.

I'm not saying that you should move it, it's something that can be
added later after this change is implemented.

Other than my two comments above.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


-- Steve
