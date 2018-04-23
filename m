Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeDWCCG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:02:06 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:34606 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753647AbeDWCCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:02:04 -0400
X-Google-Smtp-Source: AIpwx4893dEqfNDS3qrl/9ra+hHJAAKgS4+X4udz/Q9L2wp0nX3rtjx7H+Aq96XzMbysXPaNB2qnCDKmTAB1lraeTcmQG55Ckm21
MIME-Version: 1.0
Date: Sun, 22 Apr 2018 19:02:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bce26056a7a6c23@google.com>
Subject: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
From: syzbot <syzbot+e1670f554caa60fb147b@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
285848b0f4074f04ab606f1e5dca296482033d54 (Sun Apr 22 04:20:48 2018 +0000)
Merge tag 'random_for_linus_stable' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=e1670f554caa60fb147b

So far this crash happened 398 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6457007586410496
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5576436211515392
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6327380104708096
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e1670f554caa60fb147b@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.


=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
4.17.0-rc1+ #12 Not tainted
-----------------------------------------------------
syzkaller880831/4534 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
         (ptrval) (fs_reclaim){+.+.}, at:  
fs_reclaim_acquire.part.82+0x0/0x30 mm/page_alloc.c:463

and this task is already holding:
         (ptrval) (&(&dev->event_lock)->rlock){-.-.}, at:  
input_inject_event+0xe0/0x3ed drivers/input/input.c:461
which would create a new lock dependency:
  (&(&dev->event_lock)->rlock){-.-.} -> (fs_reclaim){+.+.}

but this new dependency connects a HARDIRQ-irq-safe lock:
  (&(&dev->event_lock)->rlock){-.-.}

... which became HARDIRQ-irq-safe at:
   lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
   input_event+0x67/0xa0 drivers/input/input.c:435
   input_report_key include/linux/input.h:393 [inline]
   psmouse_report_standard_buttons+0x31/0x90  
drivers/input/mouse/psmouse-base.c:127
   psmouse_report_standard_packet drivers/input/mouse/psmouse-base.c:145  
[inline]
   psmouse_process_byte+0x1ef/0x710 drivers/input/mouse/psmouse-base.c:236
   psmouse_handle_byte+0x4a/0x570 drivers/input/mouse/psmouse-base.c:278
   psmouse_interrupt+0x38a/0x1420 drivers/input/mouse/psmouse-base.c:428
   serio_interrupt+0x98/0x160 drivers/input/serio/serio.c:1018
   i8042_interrupt+0x385/0x5e0 drivers/input/serio/i8042.c:586
   __handle_irq_event_percpu+0x1c0/0xad0 kernel/irq/handle.c:149
   handle_irq_event_percpu+0x98/0x1c0 kernel/irq/handle.c:189
   handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
   handle_edge_irq+0x20f/0x870 kernel/irq/chip.c:791
   generic_handle_irq_desc include/linux/irqdesc.h:159 [inline]
   handle_irq+0x18c/0x2e7 arch/x86/kernel/irq_64.c:77
   do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
   ret_from_intr+0x0/0x1e
   arch_local_irq_enable arch/x86/include/asm/paravirt.h:793 [inline]
   __do_softirq+0x298/0xaf5 kernel/softirq.c:269
   invoke_softirq kernel/softirq.c:365 [inline]
   irq_exit+0x1d1/0x200 kernel/softirq.c:405
   exiting_irq arch/x86/include/asm/apic.h:525 [inline]
   smp_apic_timer_interrupt+0x17e/0x710 arch/x86/kernel/apic/apic.c:1052
   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
   arch_local_irq_restore arch/x86/include/asm/paravirt.h:783 [inline]
   lock_release+0x4d4/0xa10 kernel/locking/lockdep.c:3942
   fs_reclaim_release.part.83+0x1c/0x20 mm/page_alloc.c:3746
   fs_reclaim_release+0x14/0x20 mm/page_alloc.c:3747
   slab_pre_alloc_hook mm/slab.h:419 [inline]
   slab_alloc mm/slab.c:3378 [inline]
   kmem_cache_alloc+0x30/0x760 mm/slab.c:3552
   kmem_cache_zalloc include/linux/slab.h:691 [inline]
   __kernfs_new_node+0xe7/0x580 fs/kernfs/dir.c:633
   kernfs_new_node+0x80/0xf0 fs/kernfs/dir.c:679
   __kernfs_create_file+0x4d/0x330 fs/kernfs/file.c:989
   sysfs_add_file_mode_ns+0x21a/0x560 fs/sysfs/file.c:305
   create_files fs/sysfs/group.c:62 [inline]
   internal_create_group+0x282/0x970 fs/sysfs/group.c:132
   sysfs_create_group fs/sysfs/group.c:154 [inline]
   sysfs_create_groups+0x9b/0x150 fs/sysfs/group.c:181
   device_add_groups drivers/base/core.c:1033 [inline]
   device_add_attrs drivers/base/core.c:1181 [inline]
   device_add+0x84d/0x16d0 drivers/base/core.c:1813
   netdev_register_kobject+0x180/0x380 net/core/net-sysfs.c:1604
   register_netdevice+0x997/0x11c0 net/core/dev.c:7961
   register_netdev+0x30/0x50 net/core/dev.c:8076
   sit_init_net+0x445/0xc50 net/ipv6/sit.c:1857
   ops_init+0xff/0x550 net/core/net_namespace.c:128
   __register_pernet_operations net/core/net_namespace.c:912 [inline]
   register_pernet_operations+0x49a/0x9f0 net/core/net_namespace.c:987
   register_pernet_device+0x2a/0x80 net/core/net_namespace.c:1074
   sit_init+0x22/0x175 net/ipv6/sit.c:1914
   do_one_initcall+0x127/0x913 init/main.c:883
   do_initcall_level init/main.c:951 [inline]
   do_initcalls init/main.c:959 [inline]
   do_basic_setup init/main.c:977 [inline]
   kernel_init_freeable+0x49b/0x58e init/main.c:1127
   kernel_init+0x11/0x1b3 init/main.c:1053
   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

to a HARDIRQ-irq-unsafe lock:
  (fs_reclaim){+.+.}

... which became HARDIRQ-irq-unsafe at:
...
   lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
   fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
   fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
   slab_pre_alloc_hook mm/slab.h:418 [inline]
   slab_alloc_node mm/slab.c:3299 [inline]
   kmem_cache_alloc_node_trace+0x39/0x770 mm/slab.c:3661
   kmalloc_node include/linux/slab.h:550 [inline]
   kzalloc_node include/linux/slab.h:712 [inline]
   alloc_worker+0xbd/0x2e0 kernel/workqueue.c:1704
   init_rescuer.part.25+0x1f/0x190 kernel/workqueue.c:4000
   init_rescuer kernel/workqueue.c:3997 [inline]
   workqueue_init+0x51f/0x7d0 kernel/workqueue.c:5732
   kernel_init_freeable+0x2ad/0x58e init/main.c:1115
   kernel_init+0x11/0x1b3 init/main.c:1053
   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

other info that might help us debug this:

  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(fs_reclaim);
                                local_irq_disable();
                                lock(&(&dev->event_lock)->rlock);
                                lock(fs_reclaim);
   <Interrupt>
     lock(&(&dev->event_lock)->rlock);

  *** DEADLOCK ***

3 locks held by syzkaller880831/4534:
  #0:         (ptrval) (&evdev->mutex){+.+.}, at: evdev_write+0x1cc/0x860  
drivers/input/evdev.c:543
  #1:         (ptrval) (&(&dev->event_lock)->rlock){-.-.}, at:  
input_inject_event+0xe0/0x3ed drivers/input/input.c:461
  #2:         (ptrval) (rcu_read_lock){....}, at: is_event_supported  
drivers/input/input.c:56 [inline]
  #2:         (ptrval) (rcu_read_lock){....}, at:  
input_inject_event+0xc5/0x3ed drivers/input/input.c:460

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&(&dev->event_lock)->rlock){-.-.} ops: 1797 {
    IN-HARDIRQ-W at:
                     lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
                     __raw_spin_lock_irqsave  
include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0x96/0xc0  
kernel/locking/spinlock.c:152
                     input_event+0x67/0xa0 drivers/input/input.c:435
                     input_report_key include/linux/input.h:393 [inline]
                     psmouse_report_standard_buttons+0x31/0x90  
drivers/input/mouse/psmouse-base.c:127
                     psmouse_report_standard_packet  
drivers/input/mouse/psmouse-base.c:145 [inline]
                     psmouse_process_byte+0x1ef/0x710  
drivers/input/mouse/psmouse-base.c:236
                     psmouse_handle_byte+0x4a/0x570  
drivers/input/mouse/psmouse-base.c:278
                     psmouse_interrupt+0x38a/0x1420  
drivers/input/mouse/psmouse-base.c:428
                     serio_interrupt+0x98/0x160  
drivers/input/serio/serio.c:1018
                     i8042_interrupt+0x385/0x5e0  
drivers/input/serio/i8042.c:586
                     __handle_irq_event_percpu+0x1c0/0xad0  
kernel/irq/handle.c:149
                     handle_irq_event_percpu+0x98/0x1c0  
kernel/irq/handle.c:189
                     handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
                     handle_edge_irq+0x20f/0x870 kernel/irq/chip.c:791
                     generic_handle_irq_desc include/linux/irqdesc.h:159  
[inline]
                     handle_irq+0x18c/0x2e7 arch/x86/kernel/irq_64.c:77
                     do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
                     ret_from_intr+0x0/0x1e
                     arch_local_irq_enable  
arch/x86/include/asm/paravirt.h:793 [inline]
                     __do_softirq+0x298/0xaf5 kernel/softirq.c:269
                     invoke_softirq kernel/softirq.c:365 [inline]
                     irq_exit+0x1d1/0x200 kernel/softirq.c:405
                     exiting_irq arch/x86/include/asm/apic.h:525 [inline]
                     smp_apic_timer_interrupt+0x17e/0x710  
arch/x86/kernel/apic/apic.c:1052
                     apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:863
                     arch_local_irq_restore  
arch/x86/include/asm/paravirt.h:783 [inline]
                     lock_release+0x4d4/0xa10 kernel/locking/lockdep.c:3942
                     fs_reclaim_release.part.83+0x1c/0x20  
mm/page_alloc.c:3746
                     fs_reclaim_release+0x14/0x20 mm/page_alloc.c:3747
                     slab_pre_alloc_hook mm/slab.h:419 [inline]
                     slab_alloc mm/slab.c:3378 [inline]
                     kmem_cache_alloc+0x30/0x760 mm/slab.c:3552
                     kmem_cache_zalloc include/linux/slab.h:691 [inline]
                     __kernfs_new_node+0xe7/0x580 fs/kernfs/dir.c:633
                     kernfs_new_node+0x80/0xf0 fs/kernfs/dir.c:679
                     __kernfs_create_file+0x4d/0x330 fs/kernfs/file.c:989
                     sysfs_add_file_mode_ns+0x21a/0x560 fs/sysfs/file.c:305
                     create_files fs/sysfs/group.c:62 [inline]
                     internal_create_group+0x282/0x970 fs/sysfs/group.c:132
                     sysfs_create_group fs/sysfs/group.c:154 [inline]
                     sysfs_create_groups+0x9b/0x150 fs/sysfs/group.c:181
                     device_add_groups drivers/base/core.c:1033 [inline]
                     device_add_attrs drivers/base/core.c:1181 [inline]
                     device_add+0x84d/0x16d0 drivers/base/core.c:1813
                     netdev_register_kobject+0x180/0x380  
net/core/net-sysfs.c:1604
                     register_netdevice+0x997/0x11c0 net/core/dev.c:7961
                     register_netdev+0x30/0x50 net/core/dev.c:8076
                     sit_init_net+0x445/0xc50 net/ipv6/sit.c:1857
                     ops_init+0xff/0x550 net/core/net_namespace.c:128
                     __register_pernet_operations  
net/core/net_namespace.c:912 [inline]
                     register_pernet_operations+0x49a/0x9f0  
net/core/net_namespace.c:987
                     register_pernet_device+0x2a/0x80  
net/core/net_namespace.c:1074
                     sit_init+0x22/0x175 net/ipv6/sit.c:1914
                     do_one_initcall+0x127/0x913 init/main.c:883
                     do_initcall_level init/main.c:951 [inline]
                     do_initcalls init/main.c:959 [inline]
                     do_basic_setup init/main.c:977 [inline]
                     kernel_init_freeable+0x49b/0x58e init/main.c:1127
                     kernel_init+0x11/0x1b3 init/main.c:1053
                     ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
    IN-SOFTIRQ-W at:
                     lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
                     __raw_spin_lock_irqsave  
include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0x96/0xc0  
kernel/locking/spinlock.c:152
                     input_event+0x67/0xa0 drivers/input/input.c:435
                     input_report_key include/linux/input.h:393 [inline]
                     psmouse_report_standard_buttons+0x31/0x90  
drivers/input/mouse/psmouse-base.c:127
                     psmouse_report_standard_packet  
drivers/input/mouse/psmouse-base.c:145 [inline]
                     psmouse_process_byte+0x1ef/0x710  
drivers/input/mouse/psmouse-base.c:236
                     psmouse_handle_byte+0x4a/0x570  
drivers/input/mouse/psmouse-base.c:278
                     psmouse_interrupt+0x38a/0x1420  
drivers/input/mouse/psmouse-base.c:428
                     serio_interrupt+0x98/0x160  
drivers/input/serio/serio.c:1018
                     i8042_interrupt+0x385/0x5e0  
drivers/input/serio/i8042.c:586
                     __handle_irq_event_percpu+0x1c0/0xad0  
kernel/irq/handle.c:149
                     handle_irq_event_percpu+0x98/0x1c0  
kernel/irq/handle.c:189
                     handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
                     handle_edge_irq+0x20f/0x870 kernel/irq/chip.c:791
                     generic_handle_irq_desc include/linux/irqdesc.h:159  
[inline]
                     handle_irq+0x18c/0x2e7 arch/x86/kernel/irq_64.c:77
                     do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
                     ret_from_intr+0x0/0x1e
                     arch_local_irq_enable  
arch/x86/include/asm/paravirt.h:793 [inline]
                     __do_softirq+0x298/0xaf5 kernel/softirq.c:269
                     invoke_softirq kernel/softirq.c:365 [inline]
                     irq_exit+0x1d1/0x200 kernel/softirq.c:405
                     exiting_irq arch/x86/include/asm/apic.h:525 [inline]
                     smp_apic_timer_interrupt+0x17e/0x710  
arch/x86/kernel/apic/apic.c:1052
                     apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:863
                     arch_local_irq_restore  
arch/x86/include/asm/paravirt.h:783 [inline]
                     lock_release+0x4d4/0xa10 kernel/locking/lockdep.c:3942
                     fs_reclaim_release.part.83+0x1c/0x20  
mm/page_alloc.c:3746
                     fs_reclaim_release+0x14/0x20 mm/page_alloc.c:3747
                     slab_pre_alloc_hook mm/slab.h:419 [inline]
                     slab_alloc mm/slab.c:3378 [inline]
                     kmem_cache_alloc+0x30/0x760 mm/slab.c:3552
                     kmem_cache_zalloc include/linux/slab.h:691 [inline]
                     __kernfs_new_node+0xe7/0x580 fs/kernfs/dir.c:633
                     kernfs_new_node+0x80/0xf0 fs/kernfs/dir.c:679
                     __kernfs_create_file+0x4d/0x330 fs/kernfs/file.c:989
                     sysfs_add_file_mode_ns+0x21a/0x560 fs/sysfs/file.c:305
                     create_files fs/sysfs/group.c:62 [inline]
                     internal_create_group+0x282/0x970 fs/sysfs/group.c:132
                     sysfs_create_group fs/sysfs/group.c:154 [inline]
                     sysfs_create_groups+0x9b/0x150 fs/sysfs/group.c:181
                     device_add_groups drivers/base/core.c:1033 [inline]
                     device_add_attrs drivers/base/core.c:1181 [inline]
                     device_add+0x84d/0x16d0 drivers/base/core.c:1813
                     netdev_register_kobject+0x180/0x380  
net/core/net-sysfs.c:1604
                     register_netdevice+0x997/0x11c0 net/core/dev.c:7961
                     register_netdev+0x30/0x50 net/core/dev.c:8076
                     sit_init_net+0x445/0xc50 net/ipv6/sit.c:1857
                     ops_init+0xff/0x550 net/core/net_namespace.c:128
                     __register_pernet_operations  
net/core/net_namespace.c:912 [inline]
                     register_pernet_operations+0x49a/0x9f0  
net/core/net_namespace.c:987
                     register_pernet_device+0x2a/0x80  
net/core/net_namespace.c:1074
                     sit_init+0x22/0x175 net/ipv6/sit.c:1914
                     do_one_initcall+0x127/0x913 init/main.c:883
                     do_initcall_level init/main.c:951 [inline]
                     do_initcalls init/main.c:959 [inline]
                     do_basic_setup init/main.c:977 [inline]
                     kernel_init_freeable+0x49b/0x58e init/main.c:1127
                     kernel_init+0x11/0x1b3 init/main.c:1053
                     ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
    INITIAL USE at:
                    lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
                    __raw_spin_lock_irqsave  
include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x96/0xc0  
kernel/locking/spinlock.c:152
                    input_inject_event+0xe0/0x3ed drivers/input/input.c:461
                    input_leds_brightness_set+0x81/0xb0  
drivers/input/input-leds.c:66
                    __led_set_brightness drivers/leds/led-core.c:34 [inline]
                    led_set_brightness_nopm+0x4c/0xe0  
drivers/leds/led-core.c:261
                    led_set_brightness_nosleep drivers/leds/led-core.c:278  
[inline]
                    led_set_brightness+0x113/0x220  
drivers/leds/led-core.c:253
                    led_trigger_event+0x77/0xd0  
drivers/leds/led-triggers.c:292
                    kbd_led_trigger_activate+0xed/0x120  
drivers/tty/vt/keyboard.c:969
                    led_trigger_set+0x668/0x930  
drivers/leds/led-triggers.c:138
                    led_trigger_set_default+0x10a/0x180  
drivers/leds/led-triggers.c:171
                    of_led_classdev_register+0x485/0x640  
drivers/leds/led-class.c:302
                    input_leds_connect+0x410/0x7c0  
drivers/input/input-leds.c:143
                    input_attach_handler+0x1b1/0x210  
drivers/input/input.c:996
                    input_register_device.cold.22+0xe8/0x297  
drivers/input/input.c:2152
                    atkbd_connect+0x6fe/0x930  
drivers/input/keyboard/atkbd.c:1200
                    serio_connect_driver+0x4f/0x70  
drivers/input/serio/serio.c:63
                    serio_driver_probe+0x47/0x60  
drivers/input/serio/serio.c:794
                    really_probe drivers/base/dd.c:448 [inline]
                    driver_probe_device+0x69b/0x960 drivers/base/dd.c:590
                    __driver_attach+0x1b2/0x1f0 drivers/base/dd.c:824
                    bus_for_each_dev+0x151/0x1d0 drivers/base/bus.c:311
                    driver_attach+0x3d/0x50 drivers/base/dd.c:843
                    serio_attach_driver drivers/input/serio/serio.c:824  
[inline]
                    serio_handle_event+0x70a/0xb20  
drivers/input/serio/serio.c:243
                    process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
                    worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
                    kthread+0x345/0x410 kernel/kthread.c:238
                    ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
  }
  ... key      at: [<ffffffff8b147da0>] __key.33448+0x0/0x40
  ... acquired at:
    lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
    fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
    fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
    slab_pre_alloc_hook mm/slab.h:418 [inline]
    slab_alloc mm/slab.c:3378 [inline]
    __do_kmalloc mm/slab.c:3716 [inline]
    __kmalloc+0x45/0x760 mm/slab.c:3727
    kmalloc_array include/linux/slab.h:631 [inline]
    kcalloc include/linux/slab.h:642 [inline]
    numa_crng_init drivers/char/random.c:798 [inline]
    crng_reseed+0x427/0x920 drivers/char/random.c:923
    credit_entropy_bits+0x98d/0xa30 drivers/char/random.c:708
    add_timer_randomness+0x26b/0x320 drivers/char/random.c:1133
    add_input_randomness+0xce/0x3e0 drivers/char/random.c:1148
    input_handle_event+0xb3/0x1210 drivers/input/input.c:375
    input_inject_event+0x367/0x3ed drivers/input/input.c:466
    evdev_write+0x4d1/0x860 drivers/input/evdev.c:560
    __vfs_write+0x10b/0x960 fs/read_write.c:485
    vfs_write+0x1f8/0x560 fs/read_write.c:549
    ksys_write+0xf9/0x250 fs/read_write.c:598
    __do_sys_write fs/read_write.c:610 [inline]
    __se_sys_write fs/read_write.c:607 [inline]
    __x64_sys_write+0x73/0xb0 fs/read_write.c:607
    do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
    entry_SYSCALL_64_after_hwframe+0x49/0xbe


the dependencies between the lock to be acquired
  and HARDIRQ-irq-unsafe lock:
-> (fs_reclaim){+.+.} ops: 1058989 {
    HARDIRQ-ON-W at:
                     lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
                     fs_reclaim_acquire.part.82+0x24/0x30  
mm/page_alloc.c:3739
                     fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
                     slab_pre_alloc_hook mm/slab.h:418 [inline]
                     slab_alloc_node mm/slab.c:3299 [inline]
                     kmem_cache_alloc_node_trace+0x39/0x770 mm/slab.c:3661
                     kmalloc_node include/linux/slab.h:550 [inline]
                     kzalloc_node include/linux/slab.h:712 [inline]
                     alloc_worker+0xbd/0x2e0 kernel/workqueue.c:1704
                     init_rescuer.part.25+0x1f/0x190 kernel/workqueue.c:4000
                     init_rescuer kernel/workqueue.c:3997 [inline]
                     workqueue_init+0x51f/0x7d0 kernel/workqueue.c:5732
                     kernel_init_freeable+0x2ad/0x58e init/main.c:1115
                     kernel_init+0x11/0x1b3 init/main.c:1053
                     ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
    SOFTIRQ-ON-W at:
                     lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
                     fs_reclaim_acquire.part.82+0x24/0x30  
mm/page_alloc.c:3739
                     fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
                     slab_pre_alloc_hook mm/slab.h:418 [inline]
                     slab_alloc_node mm/slab.c:3299 [inline]
                     kmem_cache_alloc_node_trace+0x39/0x770 mm/slab.c:3661
                     kmalloc_node include/linux/slab.h:550 [inline]
                     kzalloc_node include/linux/slab.h:712 [inline]
                     alloc_worker+0xbd/0x2e0 kernel/workqueue.c:1704
                     init_rescuer.part.25+0x1f/0x190 kernel/workqueue.c:4000
                     init_rescuer kernel/workqueue.c:3997 [inline]
                     workqueue_init+0x51f/0x7d0 kernel/workqueue.c:5732
                     kernel_init_freeable+0x2ad/0x58e init/main.c:1115
                     kernel_init+0x11/0x1b3 init/main.c:1053
                     ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
    INITIAL USE at:
                    lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
                    fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
                    fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
                    slab_pre_alloc_hook mm/slab.h:418 [inline]
                    slab_alloc_node mm/slab.c:3299 [inline]
                    kmem_cache_alloc_node_trace+0x39/0x770 mm/slab.c:3661
                    kmalloc_node include/linux/slab.h:550 [inline]
                    kzalloc_node include/linux/slab.h:712 [inline]
                    alloc_worker+0xbd/0x2e0 kernel/workqueue.c:1704
                    init_rescuer.part.25+0x1f/0x190 kernel/workqueue.c:4000
                    init_rescuer kernel/workqueue.c:3997 [inline]
                    workqueue_init+0x51f/0x7d0 kernel/workqueue.c:5732
                    kernel_init_freeable+0x2ad/0x58e init/main.c:1115
                    kernel_init+0x11/0x1b3 init/main.c:1053
                    ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
  }
  ... key      at: [<ffffffff88df4620>] __fs_reclaim_map+0x0/0x40
  ... acquired at:
    lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
    fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
    fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
    slab_pre_alloc_hook mm/slab.h:418 [inline]
    slab_alloc mm/slab.c:3378 [inline]
    __do_kmalloc mm/slab.c:3716 [inline]
    __kmalloc+0x45/0x760 mm/slab.c:3727
    kmalloc_array include/linux/slab.h:631 [inline]
    kcalloc include/linux/slab.h:642 [inline]
    numa_crng_init drivers/char/random.c:798 [inline]
    crng_reseed+0x427/0x920 drivers/char/random.c:923
    credit_entropy_bits+0x98d/0xa30 drivers/char/random.c:708
    add_timer_randomness+0x26b/0x320 drivers/char/random.c:1133
    add_input_randomness+0xce/0x3e0 drivers/char/random.c:1148
    input_handle_event+0xb3/0x1210 drivers/input/input.c:375
    input_inject_event+0x367/0x3ed drivers/input/input.c:466
    evdev_write+0x4d1/0x860 drivers/input/evdev.c:560
    __vfs_write+0x10b/0x960 fs/read_write.c:485
    vfs_write+0x1f8/0x560 fs/read_write.c:549
    ksys_write+0xf9/0x250 fs/read_write.c:598
    __do_sys_write fs/read_write.c:610 [inline]
    __se_sys_write fs/read_write.c:607 [inline]
    __x64_sys_write+0x73/0xb0 fs/read_write.c:607
    do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
    entry_SYSCALL_64_after_hwframe+0x49/0xbe


stack backtrace:
CPU: 0 PID: 4534 Comm: syzkaller880831 Not tainted 4.17.0-rc1+ #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_bad_irq_dependency kernel/locking/lockdep.c:1570 [inline]
  check_usage.cold.58+0x6d5/0xac7 kernel/locking/lockdep.c:1602
  check_irq_usage kernel/locking/lockdep.c:1658 [inline]
  check_prev_add_irq kernel/locking/lockdep_states.h:7 [inline]
  check_prev_add kernel/locking/lockdep.c:1868 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2417 [inline]
  __lock_acquire+0x2417/0x5140 kernel/locking/lockdep.c:3431
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
  fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
  fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
  slab_pre_alloc_hook mm/slab.h:418 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x45/0x760 mm/slab.c:3727
  kmalloc_array include/linux/slab.h:631 [inline]
  kcalloc include/linux/slab.h:642 [inline]
  numa_crng_init drivers/char/random.c:798 [inline]
  crng_reseed+0x427/0x920 drivers/char/random.c:923
  credit_entropy_bits+0x98d/0xa30 drivers/char/random.c:708
  add_timer_randomness+0x26b/0x320 drivers/char/random.c:1133
  add_input_randomness+0xce/0x3e0 drivers/char/random.c:1148
  input_handle_event+0xb3/0x1210 drivers/input/input.c:375
  input_inject_event+0x367/0x3ed drivers/input/input.c:466
  evdev_write+0x4d1/0x860 drivers/input/evdev.c:560
  __vfs_write+0x10b/0x960 fs/read_write.c:485
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0xf9/0x250 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443db9
RSP: 002b:00007ffd62c88e88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0008000040000002 RCX: 0000000000443db9
RDX: 0000000000000030 RSI: 00000000200000c0 RDI: 00000000000003ff
RBP: 746e6576652f7475 R08: 00000000004002e0 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 706e692f7665642f
R13: 0000000000401af0 R14: 0000000000000000 R15: 0000000000000000
BUG: sleeping function called from invalid context at mm/slab.h:421
in_atomic(): 1, irqs_disabled(): 1, pid: 4534, name: syzkaller880831
INFO: lockdep is turned off.
irq event stamp: 74430
hardirqs last  enabled at (74429): [<ffffffff8100c172>]  
do_syscall_64+0x92/0x800 arch/x86/entry/common.c:274
hardirqs last disabled at (74430): [<ffffffff876eada4>]  
__raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (74430): [<ffffffff876eada4>]  
_raw_spin_lock_irqsave+0x74/0xc0 kernel/locking/spinlock.c:152
softirqs last  enabled at (74408): [<ffffffff87a00778>]  
__do_softirq+0x778/0xaf5 kernel/softirq.c:311
softirqs last disabled at (74401): [<ffffffff81475041>] invoke_softirq  
kernel/softirq.c:365 [inline]
softirqs last disabled at (74401): [<ffffffff81475041>]  
irq_exit+0x1d1/0x200 kernel/softirq.c:405
CPU: 0 PID: 4534 Comm: syzkaller880831 Not tainted 4.17.0-rc1+ #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  ___might_sleep.cold.87+0x11f/0x13a kernel/sched/core.c:6188
  __might_sleep+0x95/0x190 kernel/sched/core.c:6141
  slab_pre_alloc_hook mm/slab.h:421 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x2b9/0x760 mm/slab.c:3727
  kmalloc_array include/linux/slab.h:631 [inline]
  kcalloc include/linux/slab.h:642 [inline]
  numa_crng_init drivers/char/random.c:798 [inline]
  crng_reseed+0x427/0x920 drivers/char/random.c:923
  credit_entropy_bits+0x98d/0xa30 drivers/char/random.c:708
  add_timer_randomness+0x26b/0x320 drivers/char/random.c:1133
  add_input_randomness+0xce/0x3e0 drivers/char/random.c:1148
  input_handle_event+0xb3/0x1210 drivers/input/input.c:375
  input_inject_event+0x367/0x3ed drivers/input/input.c:466
  evdev_write+0x4d1/0x860 drivers/input/evdev.c:560
  __vfs_write+0x10b/0x960 fs/read_write.c:485
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0xf9/0x250 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443db9
RSP: 002b:00007ffd62c88e88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0008000040000002 RCX: 0000000000443db9
RDX: 0000000000000030 RSI: 00000000200000c0 RDI: 00000000000003ff
RBP: 746e6576652f7475 R08: 00000000004002e0 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 706e692f7665642f
R13: 0000000000401af0 R14: 0000000000000000 R15: 0000000000000000
random: crng init done


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
