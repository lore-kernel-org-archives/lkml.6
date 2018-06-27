Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42A6C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5930A253ED
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5930A253ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965372AbeF0Nis (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:38:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934289AbeF0Nir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:38:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0D6BBF572;
        Wed, 27 Jun 2018 13:38:46 +0000 (UTC)
Received: from redhat.com (ovpn-120-46.rdu2.redhat.com [10.10.120.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5F042156888;
        Wed, 27 Jun 2018 13:38:44 +0000 (UTC)
Date:   Wed, 27 Jun 2018 10:38:43 -0300
From:   "Herton R. Krzesinski" <herton@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     mhocko@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miles Chen <miles.chen@mediatek.com>,
        Paul Burton <paul.burton@mips.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-mm@vger.kernel.org, aquini@redhat.com, lwoodman@redhat.com,
        n-horiguchi@ah.jp.nec.com
Subject: Re: Kernel crash after "mm: initialize pages on demand during boot"
Message-ID: <20180627133843.rqzlfrn4sabftkn4@dhcppc10>
References: <20180626204152.fyb5wzdduif2h5sg@dhcppc10>
 <20180627071925.GA32348@dhcp22.suse.cz>
 <CAGM2reaQYYrAP1mAWw4tV9+9z1pmnu5kOJj_g-O-kadqYrkx3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reaQYYrAP1mAWw4tV9+9z1pmnu5kOJj_g-O-kadqYrkx3w@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 13:38:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 13:38:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'herton@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:14:21AM -0400, Pavel Tatashin wrote:
> It does look similar to what Naoya was seeing. Herton, have you tried applying:
> 
> http://ozlabs.org/~akpm/mmots/broken-out/x86-e820-put-e820_type_ram-regions-into-memblockreserved.patch

Thanks, I'll try it. It'll probably work since I tried memory_reserve
but "hacking" it at e820__register_nosave_regions, anyway I'll confirm
it here.

> 
> Thank you,
> Pavel
> On Wed, Jun 27, 2018 at 3:35 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > This smells like an issue Naoya was seeing I guess (Cced)
> >
> > On Tue 26-06-18 17:41:52, Herton R. Krzesinski wrote:
> > > Hi,
> > >
> > > While running proc01 test from ltp, or as I later found out if you just read
> > > kpagecount ("cat /proc/kpagecount  > /dev/null"), I started to get the following
> > > oops on latest kernels (4.17+) in a specific system:
> > >
> > > [  112.926100] general protection fault: 0000 [#1] SMP PTI
> > > [  112.926691] CPU: 1 PID: 1230 Comm: proc01 Not tainted 4.18.0-rc2+ #1
> > > [  112.927780] Hardware name: Dell Inc. PowerEdge C5220/0KXND9, BIOS 1.0.10 08/12/2011
> > > [  112.928680] RIP: 0010:kpagecount_read+0xdd/0x160
> > > [  112.929273] Code: 04 48 01 d7 74 9b f6 07 02 74 96 4c 89 ff 48 c1 e7 06 48 03 3d 14 36 c1 00 74 86 48 8b 4f 08 48 8d 51 ff 83 e1 01 48 0f 44 d7 <48> 8b 12 80 e6 01 0f 85 6b ff ff ff 48 8b 07 f6 c4 80 74 0c e8 4a
> > > [  112.931444] RSP: 0018:ffffa67980bd3e08 EFLAGS: 00010202
> > > [  112.932079] RAX: 0000000000000000 RBX: 00007fffffffeff9 RCX: 0000000000000001
> > > [  112.932871] RDX: 3480e5b7a7da5592 RSI: 000000000063e680 RDI: ffffe03441fcf940
> > > [  112.933630] RBP: 0000000000000400 R08: 0000000000000000 R09: 0000000000000001
> > > [  112.934470] R10: ffffa67980bd3ed8 R11: 0000000000000000 R12: 000000000063e680
> > > [  112.935283] R13: ffffa67980bd3f08 R14: 000000000063e9a8 R15: 000000000007f3e5
> > > [  112.936149] FS:  00007fb682eab580(0000) GS:ffff9af0bf080000(0000) knlGS:0000000000000000
> > > [  112.937094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  112.937791] CR2: 00007ffe550ccff8 CR3: 0000000071de0004 CR4: 00000000000606e0
> > > [  112.938603] Call Trace:
> > > [  112.938866]  proc_reg_read+0x3c/0x60
> > > [  112.939296]  __vfs_read+0x36/0x180
> > > [  112.939778]  vfs_read+0x8a/0x140
> > > [  112.940118]  ksys_read+0x4f/0xb0
> > > [  112.940535]  do_syscall_64+0x5b/0x180
> > > [  112.940965]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [  112.941736] RIP: 0033:0x7fb6829dba49
> > > [  112.942196] Code: 00 48 8b 35 79 f4 2a 00 31 c9 64 83 3e 0b 75 c6 eb b4 e8 ca fb ff ff 66 2e 0f 1f 84 00 00 00 00 00 48 39 ca 77 27 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 41 f4 2a 00
> > > [  112.944237] RSP: 002b:00007ffe550d4018 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > > [  112.945151] RAX: ffffffffffffffda RBX: 0000000000000400 RCX: 00007fb6829dba49
> > > [  112.945978] RDX: 0000000000000400 RSI: 000000000063e680 RDI: 0000000000000004
> > > [  112.946773] RBP: 00007ffe550d5190 R08: 000000000133a81b R09: 00007ffe550d4a60
> > > [  112.947536] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000003f9c00
> > > [  112.948521] R13: 0000000000000004 R14: 0000000000437b22 R15: 0000000000000000
> > > [  112.949341] Modules linked in: binfmt_misc sunrpc intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel iTCO_wdt intel_cstate ipmi_ssif intel_uncore gpio_ich iTCO_vendor_support ipmi_si intel_rapl_perf dcdbas joydev pcspkr ipmi_devintf ipmi_msghandler sg ie31200_edac mei_me i2c_i801 lpc_ich mei xfs libcrc32c sd_mod ast drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm igb ahci libahci libata ptp crc32c_intel pps_core dca i2c_algo_bit dm_mirror dm_region_hash dm_log dm_mod
> > > [  112.954919] ---[ end trace 36aa5a2dececb838 ]---
> > >
> > > In last days, I have been investigating this issue. While looking at the crash
> > > itself, I noticed it crashes on what looked like a non-initialized struct page.
> > > In the oops above, we have R15 = 7f3e5, which is pfn number in the loop at
> > > kpagecount_read():
> > >
> > > /home/rpmbuild/BUILD/kernel-4.18.0_rc2+/fs/proc/page.c: 59
> > > 0xffffffffb7d16494 <kpagecount_read+100>:       callq  0xffffffffb81f3fc0 <_cond_resched>
> > > 0xffffffffb7d16499 <kpagecount_read+105>:       add    $0x8,%r14
> > > 0xffffffffb7d1649d <kpagecount_read+109>:       lea    (%r12,%rbp,1),%rax
> > > 0xffffffffb7d164a1 <kpagecount_read+113>:       add    $0x1,%r15
> > >
> > > At the same time, I started bisecting, since this didn't happen with 4.16 kernel.
> > > I ended up isolating the following commit as the trigger to this issue:
> > >
> > > git bisect bad c9e97a1997fbf3a1d18d4065c2ca381f0704d7e5
> > > # first bad commit: [c9e97a1997fbf3a1d18d4065c2ca381f0704d7e5] mm: initialize pages on demand during boot
> > >
> > > While looking at the commit, I did not see any issue with it, other than
> > > on the system I see the crash, it started to do deferred page initialization
> > > while it didn't before. And that's the key here. If you look at dmesg of the
> > > system:
> > >
> > > ...
> > > [    0.000000] BIOS-provided physical RAM map:
> > > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009a3ff] usable
> > > [    0.000000] BIOS-e820: [mem 0x000000000009a400-0x000000000009ffff] reserved
> > > [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> > > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007f3e4fff] usable
> > > [    0.000000] BIOS-e820: [mem 0x000000007f3e5000-0x000000007f42cfff] ACPI NVS
> > > [    0.000000] BIOS-e820: [mem 0x000000007f42d000-0x000000007f433fff] ACPI data
> > > [    0.000000] BIOS-e820: [mem 0x000000007f434000-0x000000007f504fff] reserved
> > > [    0.000000] BIOS-e820: [mem 0x000000007f505000-0x000000007f50ffff] ACPI NVS
> > > [    0.000000] BIOS-e820: [mem 0x000000007f510000-0x000000007f535fff] reserved
> > > [    0.000000] BIOS-e820: [mem 0x000000007f536000-0x000000007f578fff] ACPI NVS
> > > [    0.000000] BIOS-e820: [mem 0x000000007f579000-0x000000007f7fffff] usable
> > > [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> > > [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed3ffff] reserved
> > > [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> > > [    0.000000] NX (Execute Disable) protection: active
> > > [    0.000000] SMBIOS 2.7 present.
> > > [    0.000000] DMI: Dell Inc. PowerEdge C5220/0KXND9, BIOS 1.0.10 08/12/2011
> > > [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> > > [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> > > [    0.000000] last_pfn = 0x7f800 max_arch_pfn = 0x400000000
> > > ...
> > > [    0.000000] NODE_DATA(0) allocated [mem 0x7f7d6000-0x7f7fffff]
> > > [    0.000000] MEMBLOCK configuration:
> > > [    0.000000]  memory size = 0x000000007f605400 reserved size = 0x0000000005fe2000
> > > [    0.000000]  memory.cnt  = 0x3
> > > [    0.000000]  memory[0x0]     [0x0000000000001000-0x0000000000099fff], 0x0000000000099000 bytes on node 0 flags: 0x0
> > > [    0.000000]  memory[0x1]     [0x0000000000100000-0x000000007f3e4fff], 0x000000007f2e5000 bytes on node 0 flags: 0x0
> > > [    0.000000]  memory[0x2]     [0x000000007f579000-0x000000007f7fffff], 0x0000000000287000 bytes on node 0 flags: 0x0
> > > [    0.000000]  reserved.cnt  = 0x5
> > > [    0.000000]  reserved[0x0]   [0x0000000000000000-0x000000000000ffff], 0x0000000000010000 bytes on node 0 flags: 0x0
> > > [    0.000000]  reserved[0x1]   [0x0000000000094000-0x00000000000fffff], 0x000000000006c000 bytes on node 0 flags: 0x0
> > > [    0.000000]  reserved[0x2]   [0x0000000025000000-0x0000000026aa1fff], 0x0000000001aa2000 bytes on node 0 flags: 0x0
> > > [    0.000000]  reserved[0x3]   [0x000000002f6bc000-0x0000000033b55fff], 0x000000000449a000 bytes on node 0 flags: 0x0
> > > [    0.000000]  reserved[0x4]   [0x000000007f7d6000-0x000000007f7fffff], 0x000000000002a000 bytes flags: 0x0
> > > ...
> > > [    0.000000] Zone ranges:
> > > [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > > [    0.000000]   DMA32    [mem 0x0000000001000000-0x000000007f7fffff]
> > > [    0.000000]   Normal   empty
> > > [    0.000000]   Device   empty
> > > [    0.000000] Movable zone start for each node
> > > [    0.000000] Early memory node ranges
> > > [    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000099fff]
> > > [    0.000000]   node   0: [mem 0x0000000000100000-0x000000007f3e4fff]
> > > [    0.000000]   node   0: [mem 0x000000007f579000-0x000000007f7fffff]
> > > [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007f7fffff]
> > > [    0.000000] On node 0 totalpages: 521733
> > > [    0.000000]   DMA zone: 64 pages used for memmap
> > > [    0.000000]   DMA zone: 21 pages reserved
> > > [    0.000000]   DMA zone: 3993 pages, LIFO batch:0
> > > [    0.000000]   DMA32 zone: 8096 pages used for memmap
> > > [    0.000000]   DMA32 zone: 517740 pages, LIFO batch:31
> > > [    0.000000] Reserved but unavailable: 103 pages
> > > ...
> > >
> > > You you notice something right away: there is a hole in the range
> > > 0x0000000000001000-0x000000007f7fffff, which is between
> > > 0x000000007f3e5000 to 0x000000007f578fff. It's not a coincidence
> > > that the pfn 0x7f3e5 is part of the crash.
> > >
> > > Without deferred init page, the mem section with struct pages were being
> > > initialized in the loop at memmap_init_zone(). That's not the case anymore
> > > if you lower the number of pages you initialized. Later the
> > > for_each_free_mem_range loop at deferred_init_memmap() will only touch
> > > the memory block, the hole above will be kept unitialized. On the system,
> > > there are some ACPI ranges in the hole as you can see on dmesg, and when
> > > something tries to touch pages there unitialized, you can get the oops.
> > >
> > > I played with some approaches to try to avoid this. One would be to somehow guess
> > > a big pgdat->static_init_pgcnt so that we don't use deferred init for this case.
> > >
> > > Other way would be to mark the ACPI areas as reserved, so the reserved pages are
> > > initialized by deferred init code, after this patch the crash did not happen
> > > anymore here:
> > >
> > > --- a/arch/x86/kernel/e820.c
> > > +++ b/arch/x86/kernel/e820.c
> > > @@ -736,8 +736,10 @@ void __init e820__register_nosave_regions(unsigned long limit_pfn)
> > >
> > >                 pfn = PFN_DOWN(entry->addr + entry->size);
> > >
> > > -               if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> > > +               if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN) {
> > >                         register_nosave_region(PFN_UP(entry->addr), pfn);
> > > +                       memblock_reserve(entry->addr, entry->size);
> > > +               }
> > >
> > >                 if (pfn >= limit_pfn)
> > >                         break;
> > >
> > > However, not sure if there isn't anything else we could miss. I tried another
> > > fix, which is to force initialization of the holes:
> > >
> > >
> > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > index ca59883c8364..cad4703136d6 100644
> > > --- a/include/linux/memblock.h
> > > +++ b/include/linux/memblock.h
> > > @@ -95,6 +95,8 @@ ulong choose_memblock_flags(void);
> > >  int memblock_add_range(struct memblock_type *type,
> > >                      phys_addr_t base, phys_addr_t size,
> > >                      int nid, unsigned long flags);
> > > +int memblock_remove_range(struct memblock_type *type,
> > > +                       phys_addr_t base, phys_addr_t size);
> > >
> > >  void __next_mem_range(u64 *idx, int nid, ulong flags,
> > >                     struct memblock_type *type_a,
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 03d48d8835ba..cc99e89d71f0 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -680,7 +680,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
> > >       return 0;
> > >  }
> > >
> > > -static int __init_memblock memblock_remove_range(struct memblock_type *type,
> > > +int __init_memblock memblock_remove_range(struct memblock_type *type,
> > >                                         phys_addr_t base, phys_addr_t size)
> > >  {
> > >       int start_rgn, end_rgn;
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 1521100f1e63..93e8bb0da72d 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -5468,6 +5468,17 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> > >       struct page *page;
> > >  #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
> > >       struct memblock_region *r = NULL, *tmp;
> > > +     static struct memblock_region hole_regions[INIT_MEMBLOCK_REGIONS];
> > > +     struct memblock_type holes = {
> > > +             .regions = hole_regions,
> > > +             .cnt = 1,
> > > +             .max = INIT_MEMBLOCK_REGIONS,
> > > +             .name = "holes",
> > > +     };
> > > +     unsigned long spfn, epfn;
> > > +     phys_addr_t start, end;
> > > +     int i;
> > > +     u64 j;
> > >  #endif
> > >
> > >       if (highest_memmap_pfn < end_pfn - 1)
> > > @@ -5492,10 +5503,22 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> > >                       continue;
> > >               if (!early_pfn_in_nid(pfn, nid))
> > >                       continue;
> > > -             if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
> > > -                     break;
> > >
> > >  #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
> > > +             /* Make sure we initialize pages outside of memory ranges */
> > > +             if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised)) {
> > > +                     memblock_add_range(&holes, PFN_PHYS(pfn), PFN_PHYS(end_pfn - pfn), nid, MEMBLOCK_NONE);
> > > +                     for_each_mem_pfn_range(i, nid, &spfn, &epfn, NULL)
> > > +                             memblock_remove_range(&holes, PFN_PHYS(spfn), PFN_PHYS(epfn - spfn));
> > > +                     for_each_mem_range(j, &holes, NULL, nid, MEMBLOCK_NONE, &start, &end, NULL) {
> > > +                             for (pfn = PFN_UP(start); pfn < PFN_DOWN(end); pfn++) {
> > > +                                     struct page *page = pfn_to_page(pfn);
> > > +                                     __init_single_page(page, pfn, zone, nid);
> > > +                             }
> > > +                     }
> > > +                     break;
> > > +             }
> > > +
> > >               /*
> > >                * Check given memblock attribute by firmware which can affect
> > >                * kernel memory layout.  If zone==ZONE_MOVABLE but memory is
> > > @@ -5515,6 +5538,9 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> > >                               continue;
> > >                       }
> > >               }
> > > +#else
> > > +             if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
> > > +                     break;
> > >  #endif
> > >
> > >  not_early:
> > >
> > >
> > >
> > > This second change fixed the issue for me as well. I just want to report the
> > > issue and can submit a patch if one of approaches above are acceptable, and I
> > > did not miss anything.
> > >
> > > Thanks,
> > > --
> > > []'s
> > > Herton
> >
> > --
> > Michal Hocko
> > SUSE Labs

-- 
[]'s
Herton
