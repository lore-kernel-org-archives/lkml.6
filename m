Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeEQANW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 20:13:22 -0400
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:58666 "EHLO
        outprodmail01.cc.columbia.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751259AbeEQANV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 20:13:21 -0400
X-Google-Smtp-Source: AB8JxZoz9AWdB+XDYPDJmbzo2NF57SQrE0ahM2l8jH7jlLfs6WRfwrLv6/gbqr9PPjRmcDni7+dy9OrI14yH5wbgxd0=
MIME-Version: 1.0
From: Shankara Pailoor <sp3485@columbia.edu>
Date: Wed, 16 May 2018 17:13:18 -0700
Message-ID: <CAASgV=v-ccec-7aXK-FGB=xHvZcKcfibp9Dy67O3RpTdMsPrKA@mail.gmail.com>
Subject: general protection fault in klist_iter_exit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, kaber@trash.net
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-No-Spam-Score: Local
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am fuzzing Linux 4.17-rc4 with Syzkaller and found the below crash.
I don't have a reproducer but this crash happened twice.

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 36 Comm: kworker/0:1 Not tainted 4.17.0-rc4+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
Workqueue: events netlink_sock_destruct_work
RIP: 0010:klist_iter_exit+0x26/0x90 lib/klist.c:314
RSP: 0018:ffff880103f57c30 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8490f6d5
RDX: 0000000000000001 RSI: 0000000000000008 RDI: 0000000000000000
RBP: ffff880103f57c48 R08: fffffbfff0c133d9 R09: 0000000000000001
R10: ffff880103f57c78 R11: ffffffff86099ec7 R12: 0000000000000008
R13: ffffffff854a2ba0 R14: 0000000000000000 R15: ffff880103ec9400
FS:  0000000000000000(0000) GS:ffff880104e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002031d000 CR3: 0000000005a22003 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 class_dev_iter_exit+0x15/0x20 drivers/base/class.c:323
 nfc_device_iter_exit net/nfc/nfc.h:133 [inline]
 nfc_genl_dump_devices_done+0x34/0x50 net/nfc/netlink.c:666
 genl_lock_done+0x89/0xd0 net/netlink/genetlink.c:493
 netlink_sock_destruct+0x98/0x2a0 net/netlink/af_netlink.c:397
 __sk_destruct+0x53/0x5e0 net/core/sock.c:1566
 sk_destruct+0x47/0x80 net/core/sock.c:1601
 __sk_free+0xf1/0x2b0 net/core/sock.c:1612
 sk_free+0x2a/0x40 net/core/sock.c:1623
 netlink_sock_destruct_work+0x19/0x20 net/netlink/af_netlink.c:419
 process_one_work+0x827/0x1550 kernel/workqueue.c:2145
 worker_thread+0xd2/0xcc0 kernel/workqueue.c:2279
 kthread+0x33c/0x400 kernel/kthread.c:238
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Code: 5d c3 0f 1f 00 55 48 89 e5 41 55 41 54 53 48 89 fb 4c 8d 63 08
e8 4b 62 cf fc 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80>
3c 02 00 75 43 4c 8b 6b 08 4d 85 ed 74 2e e8 26 62 cf fc 31
RIP: klist_iter_exit+0x26/0x90 lib/klist.c:314 RSP: ffff880103f57c30
---[ end trace 69831a3bb9e34eca ]---
Kernel panic - not syncing: Fatal exception
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

Regards,
Shankara
