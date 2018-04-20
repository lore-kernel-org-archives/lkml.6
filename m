Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755758AbeDTPnd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:43:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54024 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbeDTPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:43:31 -0400
X-Google-Smtp-Source: AIpwx48d+ZgDvrWyUO3WpwBgeYu9i9k/CYWjn0TBwLo7pWM+jeLh1cgG0FKEzUNAjE/2/d24kr2ivhPtQdeb0/+aTrg=
MIME-Version: 1.0
In-Reply-To: <CAGM2reZvZZy6b+SEtpz_a_JTGBEB2nhBdfZJSZ89F99szv9peA@mail.gmail.com>
References: <20180418233825.GA33106@big-sky.local> <20180419013128.iurzouiqxvcnpbvz@wfg-t540p.sh.intel.com>
 <CAGM2reZvZZy6b+SEtpz_a_JTGBEB2nhBdfZJSZ89F99szv9peA@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 20 Apr 2018 11:42:48 -0400
X-Gmail-Original-Message-ID: <CAGM2rebm1nU4=SAVQAObxsYEa9JpKZbYgeh+dcfb_pfEW6rxfA@mail.gmail.com>
Message-ID: <CAGM2rebm1nU4=SAVQAObxsYEa9JpKZbYgeh+dcfb_pfEW6rxfA@mail.gmail.com>
Subject: Re: c9e97a1997 BUG: kernel reboot-without-warning in early-boot
 stage, last printk: early console in setup code
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Dennis Zhou <dennisszhou@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <jbacik@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have root caused the issue, and will submit a fix shortly. The fix
also fixes the per_cpu_ptr_to_phys bug that is sent in a separate
thread.

The issue arises in this stack:

start_kernel()
 trap_init()
  setup_cpu_entry_areas()
   setup_cpu_entry_area(cpu)
    get_cpu_gdt_paddr(cpu)
     per_cpu_ptr_to_phys(addr)
      pcpu_addr_to_page(addr)
       virt_to_page(addr)
        pfn_to_page(__pa(addr) >> PAGE_SHIFT)
The returned "struct page" is sometimes uninitialized, and thus
failing later when used. It turns out sometimes is because it depends
on KASLR.

When boot is failing we have this when  pfn_to_page() is called:
kasrl: 0x000000000d600000
 addr: ffffffff83e0d000
    pa: 1040d000
   pfn: 1040d
page: ffff88001f113340
page->flags ffffffffffffffff <- Uninitialized!

When boot is successful:
kaslr: 0x000000000a800000
 addr: ffffffff83e0d000
     pa: d60d000
    pfn: d60d
 page: ffff88001f05b340
page->flags 280000000000 <- Initialized!

Here are physical addresses that BIOS provided to us:
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000001ffe0000-0x000000001fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved

In both cases, working and non-working the real physical address is the same:
pa - kasrl = 0x2E0D000

The only thing that is different is PFN.

We initialize struct pages in four places:

1. Early in boot a small set of struct pages is initialized to fill
the first section, and lower zones.
2. During mm_init() we initialize "struct pages" for all the memory
that is allocated, i.e reserved in memblock.
3. Using on-demand logic when pages are allocated after mm_init call
4. After smp_init() when the rest free deferred pages are initialized.

The above path happens before deferred memory is initialized, and thus
it must be covered either by 1, 2 or 3.

So, lets check what PFNs are initialized after (1).

memmap_init_zone() is called for pfn ranges:
1 - 1000, and 1000 - 1ffe0, but it quits after reaching pfn 0x10000,
as it leaves the rest to be initialized as deferred pages.

In the working scenario pfn ended up being below 1000, but in the
failing scenario it is above. Hence, we must initialize this page in
(2). But trap_init() is called before mm_init().

The bug was introduced by "mm: initialize pages on demand during boot"
because we lowered amount of pages that is initialized in the step
(1). But, it still could happen, because the number of initialized
pages was a guessing.

The proposed fix is this:

diff --git a/init/main.c b/init/main.c
index b795aa341a3a..870f75581cea 100644
--- a/init/main.c
+++ b/init/main.c
@@ -585,8 +585,8 @@ asmlinkage __visible void __init start_kernel(void)
        setup_log_buf(0);
        vfs_caches_init_early();
        sort_main_extable();
-       trap_init();
        mm_init();
+       trap_init();

        ftrace_init();
