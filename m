Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeCEPIQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:08:16 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:46739 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCEPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:08:14 -0500
X-Google-Smtp-Source: AG47ELv4WWjyVu1vyruInngr5bxT57eW+xpdY1+BN9Tdfga53D2ZehwQb+eFcsSCpizpe8/qEAx7HQ==
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
From: Corey Minyard <cminyard@mvista.com>
Subject: Warning from swake_up_all in 4.14.15-rt13 non-RT
Message-ID: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
Date: Mon, 5 Mar 2018 09:08:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with the change

8a64547a07980f9d25e962a78c2e10ee82bdb742 fs/dcache: use swait_queue 
instead of
waitqueue

we are getting the following warning when running with PREEMPT__LL when 
inserting
a USB drive.  This is on x86_64, 4.14.15-rt13.  It works fine with 
PREEMPT_RT.

# [  155.604042] usb 1-2: new high-speed USB device number 7 using xhci_hcd
[  155.736588] usb 1-2: New USB device found, idVendor=0781, idProduct=5567
[  155.743291] usb 1-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[  155.750423] usb 1-2: Product: Cruzer Blade
[  155.754517] usb 1-2: Manufacturer: SanDisk
[  155.758616] usb 1-2: SerialNumber: 4C530302900731101541
[  155.764207] usb-storage 1-2:1.0: USB Mass Storage device detected
[  155.770457] scsi host7: usb-storage 1-2:1.0
[  156.831919] scsi 7:0:0:0: Direct-Access     SanDisk  Cruzer Blade     
1.26 PQ: 0 ANSI: 6
[  156.840160] sd 7:0:0:0: Attached scsi generic sg1 type 0
[  156.845766] ------------[ cut here ]------------
[  156.850387] WARNING: CPU: 0 PID: 36 at kernel/sched/swait.c:72 
swake_up_all+0xb4/0xc0
[  156.858208] Modules linked in:
[  156.861259] CPU: 0 PID: 36 Comm: kworker/0:1 Not tainted 4.14.15-rt13 #1
[  156.867950] Hardware name: Supermicro Super Server/To be filled by 
O.E.M., BIOS T20170302175436 03/02/2017
[  156.877590] Workqueue: events_freezable usb_stor_scan_dwork
[  156.883159] task: ffff8c7ead6c6a00 task.stack: ffffb19dc19d0000
[  156.889072] RIP: 0010:swake_up_all+0xb4/0xc0
[  156.893334] RSP: 0000:ffffb19dc19d3be0 EFLAGS: 00010046
[  156.898550] RAX: 0000000000000046 RBX: ffff8c7eab451788 RCX: 
0000000000000000
[  156.905673] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
ffff8c7eab451770
[  156.912798] RBP: ffff8c7eab451770 R08: 0000000000023ca0 R09: 
ffffffff8bb7663e
[  156.919920] R10: ffffd80dd1a7dfc0 R11: 0000000000000000 R12: 
ffffb19dc19d3be0
[  156.927045] R13: 0000000000000003 R14: ffff8c7ea9e0e800 R15: 
ffff8c7ea69e5000
[  156.934171] FS:  0000000000000000(0000) GS:ffff8c7ebfc00000(0000) 
knlGS:0000000000000000
[  156.942246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  156.947983] CR2: 00000000fffd5000 CR3: 000000046bb4e000 CR4: 
00000000003406f0
[  156.955108] Call Trace:
[  156.957556]  percpu_ref_kill_and_confirm+0x93/0xa0
[  156.962345]  blk_freeze_queue_start+0x25/0x30
[  156.966696]  blk_set_queue_dying+0x2b/0x90
[  156.970786]  blk_cleanup_queue+0x28/0x110
[  156.974793]  __scsi_remove_device+0x66/0x130
[  156.979063]  scsi_probe_and_add_lun+0x878/0xbd0
[  156.983587]  ? scsi_probe_and_add_lun+0x9df/0xbd0
[  156.988285]  __scsi_scan_target+0x1e8/0x550
[  156.992462]  ? __wake_up_common_lock+0x79/0x90
[  156.996899]  scsi_scan_channel+0x5b/0x80
[  157.000815]  scsi_scan_host_selected+0xbe/0xf0
[  157.005252]  scsi_scan_host+0x15e/0x1a0
[  157.009083]  usb_stor_scan_dwork+0x1d/0x80
[  157.013177]  process_one_work+0x1dd/0x3e0
[  157.017189]  worker_thread+0x26/0x400
[  157.020844]  ? cancel_delayed_work+0x10/0x10
[  157.025107]  kthread+0x116/0x130
[  157.028333]  ? kthread_create_on_node+0x40/0x40
[  157.032858]  ret_from_fork+0x35/0x40
[  157.036435] Code: 49 39 c4 74 17 c6 45 00 00 fb 48 8d 7d 00 e8 c4 8a 
97 00 48 8b 04 24 49 39 c4 75 b9 c6 45 00 00 fb 48 8d 64 24 10 5b 5d 41 
5c c3
[  157.055292] ---[ end trace 86c20fd8d6c01794 ]---
[  157.060040] sd 7:0:0:0: [sdb] 15633408 512-byte logical blocks: (8.00 
GB/7.45 GiB)
[  157.070089] sd 7:0:0:0: [sdb] Write Protect is off
[  157.075183] sd 7:0:0:0: [sdb] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[  157.100295]  sdb: sdb1
[  157.103778] sd 7:0:0:0: [sdb] Attached SCSI disk
[  157.379921] FAT-fs (sdb1): Volume was not properly unmounted. Some 
data may be corrupt. Please run fsck.


The following change is the obvious reason:

--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -69,6 +69,7 @@ void swake_up_all(struct swait_queue_head *q)
         struct swait_queue *curr;
         LIST_HEAD(tmp);

+       WARN_ON(irqs_disabled());
         raw_spin_lock_irq(&q->lock);
         list_splice_init(&q->task_list, &tmp);
         while (!list_empty(&tmp)) {

I've done a little bit of analysis here, percpu_ref_kill_and_confirm()
does spin_lock_irqsave() and then does a percpu_ref_put().  If the
refcount reaches zero, the release function of the refcount is
called.  In this case, the block code has set this to
blk_queue_usage_counter_release(), which calls swake_up_all().

It seems like a bad idea to call percpu_ref_put() with interrupts
disabled.  This problem actually doesn't appear to be RT-related,
there's just no warning call if the RT tree isn't used.

I'm not sure if it's best to just do the put outside the lock, or
have modified put function that returns a bool to know if a release
is required, then the release function can be called outside the
lock.  I can do patches and test, but I'm hoping for a little
guidance here.

I'm also wondering why we don't have a warning like this in the
*_spin_lock_irq() macros, perhaps turned on with a debug
option.  That would catch things like this sooner.

Thanks,

-corey
