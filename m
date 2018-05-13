Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeEMGT3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 02:19:29 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38633 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbeEMGT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 02:19:27 -0400
X-Google-Smtp-Source: AB8JxZrRvQbn9JT3OblgI7bB3pCq5cj9p0l3NWaS7ukcaBVpWKYZkZJakH+vaMXGE3IMUp71+KgHSw==
Date: Sat, 12 May 2018 23:21:31 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Tianyu Lan <lantianyu1986@gmail.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>,
        syzbot
        <bot+7ad82526b98c64c90062275162dacfa48c20dbd3@syzkaller.appspotmail.com>,
        borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, david@redhat.com,
        Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
        jschoenh@amazon.de, kvm <kvm@vger.kernel.org>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: KASAN: use-after-free Write in irq_bypass_register_consumer
Message-ID: <20180513062131.GB654@sol.localdomain>
References: <001a1143e716efd3a9055cc8696b@google.com>
 <001a1146f1146fe0b505605e42c1@google.com>
 <CAOLK0pxR1qJC3sT2QoHgj-ys7FgFqY8724Xo9CLjWxi439ZrTw@mail.gmail.com>
 <91a32ec1-64e7-8b6b-9464-6599dd6735ad@intel.com>
 <20180126232755.z3gtqrm2oz6sp2t6@gmail.com>
 <d630a4c9-04ba-9e41-1f7b-11c59b2cd8e4@gmail.com>
 <20180406031524.GB21382@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180406031524.GB21382@sol.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 08:15:24PM -0700, Eric Biggers wrote:
> On Mon, Jan 29, 2018 at 01:29:48PM +0800, Tianyu Lan wrote:
> > 
> > 
> > On 1/27/2018 7:27 AM, Eric Biggers wrote:
> > > On Sat, Dec 16, 2017 at 04:37:02PM +0800, Lan, Tianyu wrote:
> > > > The root cause is that kvm_irqfd_assign() and kvm_irqfd_deassign() can't
> > > > be run in parallel. Some data structure(e.g, irqfd->consumer) will be
> > > > crashed because irqfd may be freed in deassign path before they are used
> > > > in assign path. The other data maybe used in deassign path before
> > > > initialization. Syzbot test hit such case. Add mutx between
> > > > kvm_irqfd_assign() and kvm_irqfd_deassign() can fix such issue. Will
> > > > send patch to fix it.
> > > > 
> > > > On 12/16/2017 12:53 PM, Tianyu Lan wrote:
> > > > > I reproduced the issue. Will have a look.
> > > > > 
> > > > > -- Best regards Tianyu Lan 2017-12-15 18:14 GMT+08:00 syzbot
> > > > > <bot+7ad82526b98c64c90062275162dacfa48c20dbd3@syzkaller.appspotmail.com>:
> > > > > > syzkaller has found reproducer for the following crash on
> > > > > > 82bcf1def3b5f1251177ad47c44f7e17af039b4b
> > > > > > git://git.cmpxchg.org/linux-mmots.git/master
> > > > > > compiler: gcc (GCC) 7.1.1 20170620
> > > > > > .config is attached
> > > > > > Raw console output is attached.
> > > > > > C reproducer is attached
> > > > > > syzkaller reproducer is attached. Seehttps://goo.gl/kgGztJ
> > > > > > for information about syzkaller reproducers
> > > > > > 
> > > > > > 
> > > > > > ==================================================================
> > > > > > BUG: KASAN: use-after-free in __list_add include/linux/list.h:64 [inline]
> > > > > > BUG: KASAN: use-after-free in list_add include/linux/list.h:79 [inline]
> > > > > > BUG: KASAN: use-after-free in irq_bypass_register_consumer+0x4b4/0x500
> > > > > > virt/lib/irqbypass.c:217
> > > > > > Write of size 8 at addr ffff8801cdf51180 by task syzkaller436086/15031
> > > > > > 
> > > > > > CPU: 1 PID: 15031 Comm: syzkaller436086 Not tainted 4.15.0-rc2-mm1+ #39
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > > Google 01/01/2011
> > > > > > Call Trace:
> > > > > >    __dump_stack lib/dump_stack.c:17 [inline]
> > > > > >    dump_stack+0x194/0x257 lib/dump_stack.c:53
> > > > > >    print_address_description+0x73/0x250 mm/kasan/report.c:252
> > > > > >    kasan_report_error mm/kasan/report.c:351 [inline]
> > > > > >    kasan_report+0x25b/0x340 mm/kasan/report.c:409
> > > > > >    __asan_report_store8_noabort+0x17/0x20 mm/kasan/report.c:435
> > > > > >    __list_add include/linux/list.h:64 [inline]
> > > > > >    list_add include/linux/list.h:79 [inline]
> > > > > >    irq_bypass_register_consumer+0x4b4/0x500 virt/lib/irqbypass.c:217
> > > > > >    kvm_irqfd_assign arch/x86/kvm/../../../virt/kvm/eventfd.c:417 [inline]
> > > > > >    kvm_irqfd+0x137f/0x1d50 arch/x86/kvm/../../../virt/kvm/eventfd.c:572
> > > > > >    kvm_vm_ioctl+0x1079/0x1c40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2992
> > > > > >    vfs_ioctl fs/ioctl.c:46 [inline]
> > > > > >    do_vfs_ioctl+0x1b1/0x1530 fs/ioctl.c:686
> > > > > >    SYSC_ioctl fs/ioctl.c:701 [inline]
> > > > > >    SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
> > > > > >    entry_SYSCALL_64_fastpath+0x1f/0x96
> > > > > > RIP: 0033:0x44d379
> > > > > > RSP: 002b:00007fc5ff9a9d08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > > > > > RAX: ffffffffffffffda RBX: 00007fc5ff9aa700 RCX: 000000000044d379
> > > > > > RDX: 0000000020080fe0 RSI: 000000004020ae76 RDI: 0000000000000005
> > > > > > RBP: 00000000007ff900 R08: 00007fc5ff9aa700 R09: 00007fc5ff9aa700
> > > > > > R10: 00007fc5ff9aa700 R11: 0000000000000246 R12: 0000000000000000
> > > > > > R13: 00000000007ff8ff R14: 00007fc5ff9aa9c0 R15: 0000000000000000
> > > > > > 
> > > > > > Allocated by task 15031:
> > > > > >    save_stack+0x43/0xd0 mm/kasan/kasan.c:447
> > > > > >    set_track mm/kasan/kasan.c:459 [inline]
> > > > > >    kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
> > > > > >    kmem_cache_alloc_trace+0x136/0x750 mm/slab.c:3614
> > > > > >    kmalloc include/linux/slab.h:516 [inline]
> > > > > >    kzalloc include/linux/slab.h:705 [inline]
> > > > > >    kvm_irqfd_assign arch/x86/kvm/../../../virt/kvm/eventfd.c:296 [inline]
> > > > > >    kvm_irqfd+0x16c/0x1d50 arch/x86/kvm/../../../virt/kvm/eventfd.c:572
> > > > > >    kvm_vm_ioctl+0x1079/0x1c40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2992
> > > > > >    vfs_ioctl fs/ioctl.c:46 [inline]
> > > > > >    do_vfs_ioctl+0x1b1/0x1530 fs/ioctl.c:686
> > > > > >    SYSC_ioctl fs/ioctl.c:701 [inline]
> > > > > >    SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
> > > > > >    entry_SYSCALL_64_fastpath+0x1f/0x96
> > > > > > 
> > > > > > Freed by task 1402:
> > > > > >    save_stack+0x43/0xd0 mm/kasan/kasan.c:447
> > > > > >    set_track mm/kasan/kasan.c:459 [inline]
> > > > > >    kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
> > > > > >    __cache_free mm/slab.c:3492 [inline]
> > > > > >    kfree+0xca/0x250 mm/slab.c:3807
> > > > > >    irqfd_shutdown+0x13c/0x1a0 arch/x86/kvm/../../../virt/kvm/eventfd.c:148
> > > > > >    process_one_work+0xbfd/0x1bc0 kernel/workqueue.c:2113
> > > > > >    worker_thread+0x223/0x1990 kernel/workqueue.c:2247
> > > > > >    kthread+0x37a/0x440 kernel/kthread.c:238
> > > > > >    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
> > > > > > 
> > > > > > The buggy address belongs to the object at ffff8801cdf51000
> > > > > >    which belongs to the cache kmalloc-512 of size 512
> > > > > > The buggy address is located 384 bytes inside of
> > > > > >    512-byte region [ffff8801cdf51000, ffff8801cdf51200)
> > > > > > The buggy address belongs to the page:
> > > > > > page:00000000d08a0d63 count:1 mapcount:0 mapping:00000000d54c7be6 index:0x0
> > > > > > flags: 0x2fffc0000000100(slab)
> > > > > > raw: 02fffc0000000100 ffff8801cdf51000 0000000000000000 0000000100000006
> > > > > > raw: ffffea00073a7660 ffffea000737f3a0 ffff8801dac00940 0000000000000000
> > > > > > page dumped because: kasan: bad access detected
> > > > > > 
> > > > > > Memory state around the buggy address:
> > > > > >    ffff8801cdf51080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > >    ffff8801cdf51100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > > > ffff8801cdf51180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > >                      ^
> > > > > >    ffff8801cdf51200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > > >    ffff8801cdf51280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > > ==================================================================
> > > > > > 
> > > Tianyu, are you still planning to send a patch for this?  This is still
> > > happening.
> > > 
> > > - Eric
> > Yes, I sent out fix patch and wait for review.
> >  https://patchwork.kernel.org/patch/10128925/
> > 
> 
> This is still happening.  Can you please resend your patch?
> 

Still happening; it's pretty easily reproducible, using the program below.
(Sometimes it crashes in different ways too.  It also spams the log, ignore
that.)  Tianyu's patch at https://patchwork.kernel.org/patch/10128925/ fixes it,
though the locking is difficult to understand so I'm not sure it's correct yet.
Probably the comment that says "do not drop the file until the irqfd is fully
initialized, otherwise we might race against the EPOLLHUP" would be obsoleted
and should be removed?  Can the KVM maintainers please review the patch too?

#include <fcntl.h>
#include <linux/kvm.h>
#include <pthread.h>
#include <sys/eventfd.h>
#include <sys/ioctl.h>

static int dev, vm, event;

static void *irqfd_thrproc(void *_flags)
{
        struct kvm_irqfd irqfd = { .fd = event, .flags = (long)_flags };

        for (;;)
                ioctl(vm, KVM_IRQFD, &irqfd);
}

int main()
{
        pthread_t t;

        event = eventfd(0, 0);
        dev = open("/dev/kvm", 0);
        vm = ioctl(dev, KVM_CREATE_VM, 0);
        ioctl(vm, KVM_CREATE_IRQCHIP, 0);
        pthread_create(&t, NULL, irqfd_thrproc, (void *)(long)0);
        irqfd_thrproc((void *)(long)KVM_IRQFD_FLAG_DEASSIGN);
}
