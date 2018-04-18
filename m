Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeDRNyk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:54:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbeDRNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:54:39 -0400
Date: Wed, 18 Apr 2018 06:54:38 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: ORC unwinder bad backtrace
Message-ID: <20180418135438.GC27475@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[there's no entry in MAINTAINERS for the ORC unwinder.  I'm guessing
at the mailing lists that might be interested in this]

I've done something stupid and fallen off the end of the stack.  ORC
appears not to handle this very well (see backtrace at the bottom).

Look at this loop:

[   60.750032]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.750750]  ? do_page_fault+0x85/0xf0
[   60.751327]  ? async_page_fault+0x1e/0x30
[   60.751970]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.752607]  ? perf_trace_x86_exceptions+0x44/0x100

The instruction at pte_clear.constprop.18+0x2e/0x2e is a nop (as you might
expect for the last byte of a function), so that can't be right:

ffffffff81061192 <pte_clear.constprop.18>:
...
ffffffff810611bf:       90                      nop
ffffffff810611c0 <perf_trace_x86_exceptions>:

I suspect an off-by-one error; you don't really mean to point to the
byte before perf_trace_x86_exception, you mean to point to byte 0 of
perf_trace_x86_exception.

I'm going to archive up this compilation in case there's anything useful
I can extract for you from it later.

[   60.734865] BUG: stack guard page was hit at 0000000020ffe8f7 (stack is 00000000d090cc16..00000000cd7d843a)
[   60.736511] kernel stack overflow (double-fault): 0000 [#1] SMP PTI
[   60.737468] Modules linked in:
[   60.737979] CPU: 0 PID: 1 Comm: init Not tainted 4.17.0-rc1+ #30
[   60.738884] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[   60.740143] RIP: 0010:error_entry+0x12/0x100
[   60.740882] RSP: 0018:ffffb050000d0000 EFLAGS: 00010046
[   60.741701] RAX: 0000000000000000 RBX: ffffd04fffc042f8 RCX: 0000000000000000
[   60.742707] RDX: 0000000000000000 RSI: ffffffffb5c010a8 RDI: ffffffffb6425d20
[   60.743694] RBP: ffffb050000d0090 R08: ffffffffb54611c0 R09: 0000000000000000
[   60.744687] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffb6425d20
[   60.745673] R13: ffffd04fffc042f8 R14: 0000000000000000 R15: ffffb050000d00c8
[   60.746640] FS:  00007fec2d341700(0000) GS:ffff9d42df800000(0000) knlGS:0000000000000000
[   60.747804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.748620] CR2: ffffb050000cfff8 CR3: 000000001c974003 CR4: 00000000003606f0
[   60.749607] Call Trace:
[   60.750032]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.750750]  ? do_page_fault+0x85/0xf0
[   60.751327]  ? async_page_fault+0x1e/0x30
[   60.751970]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.752607]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.753250]  ? do_page_fault+0x85/0xf0
[   60.753771]  ? async_page_fault+0x1e/0x30
[   60.754317]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.754920]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.755562]  ? do_page_fault+0x85/0xf0
[   60.756083]  ? async_page_fault+0x1e/0x30
[   60.756688]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.757622]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.758515]  ? do_page_fault+0x85/0xf0
[   60.759174]  ? async_page_fault+0x1e/0x30
[   60.759862]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.760633]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.761450]  ? do_page_fault+0x85/0xf0
[   60.762105]  ? async_page_fault+0x1e/0x30
[   60.762797]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.763562]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.764383]  ? do_page_fault+0x85/0xf0
[   60.765040]  ? async_page_fault+0x1e/0x30
[   60.765730]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.766495]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.767311]  ? do_page_fault+0x85/0xf0
[   60.767967]  ? async_page_fault+0x1e/0x30
[   60.768671]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.769449]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.770271]  ? do_page_fault+0x85/0xf0
[   60.770936]  ? async_page_fault+0x1e/0x30
[   60.771627]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.772398]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.773254]  ? do_page_fault+0x85/0xf0
[   60.773922]  ? async_page_fault+0x1e/0x30
[   60.774711]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.775537]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.776451]  ? do_page_fault+0x85/0xf0
[   60.777140]  ? async_page_fault+0x1e/0x30
[   60.777860]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.778628]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.779444]  ? do_page_fault+0x85/0xf0
[   60.780097]  ? async_page_fault+0x1e/0x30
[   60.780792]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.781571]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.782524]  ? do_page_fault+0x85/0xf0
[   60.783201]  ? async_page_fault+0x1e/0x30
[   60.783919]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.784698]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.785520]  ? do_page_fault+0x85/0xf0
[   60.786176]  ? async_page_fault+0x1e/0x30
[   60.786870]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.787641]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.788462]  ? do_page_fault+0x85/0xf0
[   60.789116]  ? async_page_fault+0x1e/0x30
[   60.789829]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.790652]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.791495]  ? do_page_fault+0x85/0xf0
[   60.792155]  ? async_page_fault+0x1e/0x30
[   60.792849]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.793630]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.794445]  ? do_page_fault+0x85/0xf0
[   60.795101]  ? async_page_fault+0x1e/0x30
[   60.795806]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.796576]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.797413]  ? do_page_fault+0x85/0xf0
[   60.798078]  ? async_page_fault+0x1e/0x30
[   60.798768]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.799550]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.800370]  ? do_page_fault+0x85/0xf0
[   60.801023]  ? async_page_fault+0x1e/0x30
[   60.801745]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.802529]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.803349]  ? do_page_fault+0x85/0xf0
[   60.804015]  ? async_page_fault+0x1e/0x30
[   60.804724]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.805495]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.806313]  ? do_page_fault+0x85/0xf0
[   60.806981]  ? async_page_fault+0x1e/0x30
[   60.807673]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.816987]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.817816]  ? do_page_fault+0x85/0xf0
[   60.818476]  ? async_page_fault+0x1e/0x30
[   60.819173]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.819950]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.820782]  ? do_page_fault+0x85/0xf0
[   60.821442]  ? async_page_fault+0x1e/0x30
[   60.822137]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.822905]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.823721]  ? do_page_fault+0x85/0xf0
[   60.824383]  ? async_page_fault+0x1e/0x30
[   60.825072]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.825832]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.826688]  ? do_page_fault+0x85/0xf0
[   60.827342]  ? async_page_fault+0x1e/0x30
[   60.828033]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.828805]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.829619]  ? do_page_fault+0x85/0xf0
[   60.830286]  ? async_page_fault+0x1e/0x30
[   60.830985]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.831762]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.832582]  ? do_page_fault+0x85/0xf0
[   60.833249]  ? async_page_fault+0x1e/0x30
[   60.833945]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.834723]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.835538]  ? do_page_fault+0x85/0xf0
[   60.836199]  ? async_page_fault+0x1e/0x30
[   60.836895]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.837663]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.838482]  ? do_page_fault+0x85/0xf0
[   60.839126]  ? async_page_fault+0x1e/0x30
[   60.839819]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.840591]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.841408]  ? do_page_fault+0x85/0xf0
[   60.842074]  ? async_page_fault+0x1e/0x30
[   60.842763]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.843550]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.844547]  ? do_page_fault+0x85/0xf0
[   60.845251]  ? async_page_fault+0x1e/0x30
[   60.845959]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.846793]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.847625]  ? do_page_fault+0x85/0xf0
[   60.848291]  ? async_page_fault+0x1e/0x30
[   60.848993]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.849759]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.850576]  ? do_page_fault+0x85/0xf0
[   60.851231]  ? async_page_fault+0x1e/0x30
[   60.851918]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.852698]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.853526]  ? do_page_fault+0x85/0xf0
[   60.854184]  ? async_page_fault+0x1e/0x30
[   60.854886]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.855655]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.856483]  ? do_page_fault+0x85/0xf0
[   60.857069]  ? async_page_fault+0x1e/0x30
[   60.857789]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.858554]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.859376]  ? do_page_fault+0x85/0xf0
[   60.860031]  ? async_page_fault+0x1e/0x30
[   60.860734]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.861512]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.862335]  ? do_page_fault+0x85/0xf0
[   60.863006]  ? async_page_fault+0x1e/0x30
[   60.863698]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.864483]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.865319]  ? do_page_fault+0x85/0xf0
[   60.865980]  ? async_page_fault+0x1e/0x30
[   60.866684]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.867453]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.868277]  ? do_page_fault+0x85/0xf0
[   60.868936]  ? async_page_fault+0x1e/0x30
[   60.869637]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.870404]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.871237]  ? do_page_fault+0x85/0xf0
[   60.871894]  ? async_page_fault+0x1e/0x30
[   60.872588]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.873368]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.874240]  ? do_page_fault+0x85/0xf0
[   60.875060]  ? async_page_fault+0x1e/0x30
[   60.875767]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.876571]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.877295]  ? do_page_fault+0x85/0xf0
[   60.877888]  ? async_page_fault+0x1e/0x30
[   60.878501]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.879177]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.879894]  ? do_page_fault+0x85/0xf0
[   60.880481]  ? async_page_fault+0x1e/0x30
[   60.881090]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.881774]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.882495]  ? do_page_fault+0x85/0xf0
[   60.883074]  ? async_page_fault+0x1e/0x30
[   60.883684]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.884376]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.885091]  ? do_page_fault+0x85/0xf0
[   60.885665]  ? async_page_fault+0x1e/0x30
[   60.886271]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.886944]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.887694]  ? do_page_fault+0x85/0xf0
[   60.888275]  ? async_page_fault+0x1e/0x30
[   60.888883]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.889557]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.890274]  ? do_page_fault+0x85/0xf0
[   60.890849]  ? async_page_fault+0x1e/0x30
[   60.891456]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.892144]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.892890]  ? do_page_fault+0x85/0xf0
[   60.893466]  ? async_page_fault+0x1e/0x30
[   60.894040]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.894646]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.895288]  ? acpi_ns_lookup+0x294/0x3b2
[   60.895834]  ? do_page_fault+0x85/0xf0
[   60.896355]  ? async_page_fault+0x1e/0x30
[   60.896940]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.897615]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.898332]  ? __update_load_avg_se.isra.39+0x1cf/0x1e0
[   60.899088]  ? do_page_fault+0x85/0xf0
[   60.899668]  ? async_page_fault+0x1e/0x30
[   60.900282]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.900958]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.901673]  ? do_page_fault+0x85/0xf0
[   60.902255]  ? async_page_fault+0x1e/0x30
[   60.902867]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.903539]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.904255]  ? do_page_fault+0x85/0xf0
[   60.904839]  ? async_page_fault+0x1e/0x30
[   60.905466]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.906212]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.906932]  ? do_select+0x6a6/0x7b0
[   60.907492]  ? do_page_fault+0x85/0xf0
[   60.908076]  ? async_page_fault+0x1e/0x30
[   60.908706]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.909452]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.910213]  ? do_page_fault+0x85/0xf0
[   60.910794]  ? async_page_fault+0x1e/0x30
[   60.911404]  ? pte_clear.constprop.18+0x2e/0x2e
[   60.912081]  ? perf_trace_x86_exceptions+0x44/0x100
[   60.912797]  ? do_page_fault+0x85/0xf0
[   60.913371]  ? async_page_fault+0x1e/0x30
[   60.913970]  ? copy_user_enhanced_fast_string+0xe/0x20
[   60.914709]  ? find_get_entry+0x19/0xc0
[   60.915291]  ? copyout+0x22/0x30
[   60.915794]  ? copy_page_to_iter+0x10c/0x2f0
[   60.916432]  ? generic_file_read_iter+0x44a/0x9c0
[   60.917132]  ? do_mmap+0x3c9/0x5e0
[   60.917670]  ? __vfs_read+0x100/0x170
[   60.918234]  ? vfs_read+0x89/0x130
[   60.918770]  ? ksys_read+0x52/0xc0
[   60.919308]  ? do_syscall_64+0x55/0xf0
[   60.919885]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   60.920673] Code: 48 0f b3 1c 25 da 10 02 00 eb 05 49 0f ba ee 3f 41 0f 22 de e9 eb f7 ff ff fc 56 48 8b 74 24 08 48 89 7c 24 08 52 31 d2 51 31 c9 <50> 41 50 45 31 c0 41 51 45 31 c9 41 52 45 31 d2 41 53 45 31 db 
[   60.923194] RIP: error_entry+0x12/0x100 RSP: ffffb050000d0000
[   60.924008] ---[ end trace 8a1ab620615a934d ]---
[   60.924693] Kernel panic - not syncing: Fatal exception
[   60.925556] Kernel Offset: 0x34400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
