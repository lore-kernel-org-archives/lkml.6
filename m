Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeECNq0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:46:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35016 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeECNqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:46:24 -0400
X-Google-Smtp-Source: AB8JxZrh5uAV0XSUVvXYQcXEKJneXqRgExWWB/p13IyiiU9Itma0i5IF5RHXKCKuxHVEQ3Rv2ZF+2ba5TUO3PS/EGGk=
MIME-Version: 1.0
References: <20180418135300.inazvpxjxowogyge@wfg-t540p.sh.intel.com>
 <20180418135553.zvw3loh52gbr7e2b@wfg-t540p.sh.intel.com> <20180418233825.GA33106@big-sky.local>
 <20180502124417.du2ytsnrulevihp4@wfg-t540p.sh.intel.com>
In-Reply-To: <20180502124417.du2ytsnrulevihp4@wfg-t540p.sh.intel.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 03 May 2018 13:45:43 +0000
X-Gmail-Original-Message-ID: <CAGM2reY7QvAdnGFhHAGR-TxOhWhW2vvjPvLJUXxoAJmLiSipVA@mail.gmail.com>
Message-ID: <CAGM2reY7QvAdnGFhHAGR-TxOhWhW2vvjPvLJUXxoAJmLiSipVA@mail.gmail.com>
Subject: Re: [per_cpu_ptr_to_phys] PANIC: early exception 0x0d IP
 10:ffffffffa892f15f error 0 cr2 0xffff88001fbff000
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Dennis Zhou <dennisszhou@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <jbacik@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030122
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fengguang,

My root cause for the problem was correct. You are now finding either a
different problem that has the same signature, or what is more likely the
same issue but simply was not introduced by my change: my change reduced
number of pre-initialized pages because we init them on demand with my
work, but we could run out of them even before my change, and because of
KASLR we never know how much is needed to be pre-initialized.

Could you please test if my patch fixes the issue?

http://ozlabs.org/~akpm/mmots/broken-out/mm-access-to-uninitialized-struct-page.patch

Thank you,
Pavel
On Wed, May 2, 2018 at 8:44 AM Fengguang Wu <fengguang.wu@intel.com> wrote:

> Hi all,

> On Wed, Apr 18, 2018 at 06:38:25PM -0500, Dennis Zhou wrote:
> >Hi,
> >
> >On Wed, Apr 18, 2018 at 09:55:53PM +0800, Fengguang Wu wrote:
> >>
> >> Hello,
> >>
> >> FYI here is a slightly different boot error in mainline kernel
4.17.0-rc1.
> >> It also dates back to v4.16 .

> Now I find 2 more occurrances in v4.15 kernel.

> Here are the statistics:

>          kernel      count     error-id
>          v4.15:          2     RIP:per_cpu_ptr_to_phys
>          v4.16:         12     RIP:per_cpu_ptr_to_phys
>          v4.16:          1
BUG:KASAN:null-ptr-deref-in-per_cpu_ptr_to_phys
>          v4.16-rc7:      2     RIP:per_cpu_ptr_to_phys
>          v4.17-rc1:    217     RIP:per_cpu_ptr_to_phys
>          v4.17-rc1:      5
BUG:KASAN:null-ptr-deref-in-per_cpu_ptr_to_phys
>          v4.17-rc2:     46     RIP:per_cpu_ptr_to_phys
>          v4.17-rc2:     15
BUG:KASAN:null-ptr-deref-in-per_cpu_ptr_to_phys
>          v4.17-rc3:     12     RIP:per_cpu_ptr_to_phys

> >> It occurs in 4 out of 4 boots.
> >>
> >> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
128873
> >> [    0.000000] Kernel command line: root=/dev/ram0 hung_task_panic=1
debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1
nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0
drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0
earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw
link=/kbuild-tests/run-queue/kvm/x86_64-randconfig-a0-04172313/linux-devel:devel-hourly-2018041714:60cc43fc888428bb2f18f08997432d426a243338/.vmlinuz-60cc43fc888428bb2f18f08997432d426a243338-20180418000325-19:yocto-lkp-nhm-dp2-4
branch=linux-devel/devel-hourly-2018041714
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a0-04172313/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.17.0-rc1
drbd.minor_count=8 rcuperf.shutdown=0
> >> [    0.000000] sysrq: sysrq always enabled.
> >> [    0.000000] Dentry cache hash table entries: 65536 (order: 7,
524288 bytes)
> >> [    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144
bytes)
> >> PANIC: early exception 0x0d IP 10:ffffffffa892f15f error 0 cr2
0xffff88001fbff000
> >> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G                T
4.17.0-rc1 #238
> >> [    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
> >> [    0.000000] RIP: 0010:per_cpu_ptr_to_phys+0x16a/0x298:
> >>                                              __section_mem_map_addr at
include/linux/mmzone.h:1188
> >>                                               (inlined by)
per_cpu_ptr_to_phys at mm/percpu.c:1849
> >> [    0.000000] RSP: 0000:ffffffffab407e50 EFLAGS: 00010046 ORIG_RAX:
0000000000000000
> >> [    0.000000] RAX: dffffc0000000000 RBX: ffff88001f17c340 RCX:
000000000000000f
> >> [    0.000000] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffffffffacfbf580
> >> [    0.000000] RBP: ffffffffab40d000 R08: fffffbfff57c4eca R09:
0000000000000000
> >> [    0.000000] R10: ffff880015421000 R11: fffffbfff57c4ec9 R12:
0000000000000000
> >> [    0.000000] R13: ffff88001fb03ff8 R14: ffff88001fc051c0 R15:
0000000000000000
> >> [    0.000000] FS:  0000000000000000(0000) GS:ffffffffab4c5000(0000)
knlGS:0000000000000000
> >> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [    0.000000] CR2: ffff88001fbff000 CR3: 000000001a06c000 CR4:
00000000000006b0
> >> [    0.000000] Call Trace:
> >> [    0.000000]  setup_cpu_entry_areas+0x7b/0x27b:
> >>                                              setup_cpu_entry_area at
arch/x86/mm/cpu_entry_area.c:104
> >>                                               (inlined by)
setup_cpu_entry_areas at arch/x86/mm/cpu_entry_area.c:177
> >> [    0.000000]  trap_init+0xb/0x13d:
> >>                                              trap_init at
arch/x86/kernel/traps.c:949
> >> [    0.000000]  start_kernel+0x2a5/0x91d:
> >>                                              mm_init at init/main.c:519
> >>                                               (inlined by)
start_kernel at init/main.c:589
> >> [    0.000000]  ? thread_stack_cache_init+0x6/0x6
> >> [    0.000000]  ? memcpy_orig+0x16/0x110:
> >>                                              memcpy_orig at
arch/x86/lib/memcpy_64.S:77
> >> [    0.000000]  ? x86_family+0x5/0x1d:
> >>                                              x86_family at
arch/x86/lib/cpu.c:8
> >> [    0.000000]  ? load_ucode_bsp+0x42/0x13e:
> >>                                              load_ucode_bsp at
arch/x86/kernel/cpu/microcode/core.c:183
> >> [    0.000000]  secondary_startup_64+0xa5/0xb0:
> >>                                              secondary_startup_64 at
arch/x86/kernel/head_64.S:242
> >> [    0.000000] Code: 78 06 00 49 8b 45 00 48 85 c0 74 a5 49 c1 ec 28
41 81 e4 e0 0f 00 00 49 01 c4 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1
ea 03 <80> 3c 02 00 74 08 4c 89 e7 e8 63 78 06 00 49 8b 04 24 81 e5 ff
> >> BUG: kernel hang in boot stage
> >>
> >
> >I spent some time bisecting this one and it seemse to be an intermittent
> >issue starting with this commit for me:
> >c9e97a1997, mm: initialize pages on demand during boot. The prior
> >commit, 3a2d7fa8a3, did not run into this issue after 10+ boots.

> That commit is post-4.16, so probably not the root cause.

> >I don't have that much time right now, nor the expertise with this code.
> >Pavel could you take a look at this?

> Thanks,
> Fengguang
