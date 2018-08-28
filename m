Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D69C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6B520878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6B520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeH1TDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:03:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeH1TDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:03:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CC5C804B9F2;
        Tue, 28 Aug 2018 15:11:24 +0000 (UTC)
Received: from redhat.com (ovpn-121-126.rdu2.redhat.com [10.10.121.126])
        by smtp.corp.redhat.com (Postfix) with SMTP id B27112166B41;
        Tue, 28 Aug 2018 15:11:21 +0000 (UTC)
Date:   Tue, 28 Aug 2018 11:11:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     syzbot <syzbot+d5a0a170c5069658b141@syzkaller.appspotmail.com>
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com
Subject: Re: KASAN: use-after-free Read in vhost_work_queue
Message-ID: <20180828111055-mutt-send-email-mst@kernel.org>
References: <000000000000863e0205747fdfef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000863e0205747fdfef@google.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 28 Aug 2018 15:11:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 28 Aug 2018 15:11:24 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 07:44:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    33e17876ea4e Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d8a20a400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=40e5d6b26b73cd5b
> dashboard link: https://syzkaller.appspot.com/bug?extid=d5a0a170c5069658b141
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d5a0a170c5069658b141@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in vhost_work_queue+0xc3/0xe0
> drivers/vhost/vhost.c:258
> Read of size 8 at addr ffff880193862068 by task syz-executor7/22100
> 
> CPU: 0 PID: 22100 Comm: syz-executor7 Not tainted 4.18.0+ #108
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  vhost_work_queue+0xc3/0xe0 drivers/vhost/vhost.c:258
>  vhost_transport_send_pkt+0x28a/0x380 drivers/vhost/vsock.c:227
>  virtio_transport_send_pkt_info+0x31d/0x460
> net/vmw_vsock/virtio_transport_common.c:190
>  virtio_transport_shutdown+0x1b1/0x270
> net/vmw_vsock/virtio_transport_common.c:604
>  vsock_send_shutdown net/vmw_vsock/af_vsock.c:451 [inline]
>  vsock_shutdown+0x229/0x290 net/vmw_vsock/af_vsock.c:849
>  __sys_shutdown+0x15c/0x2c0 net/socket.c:1964
>  __do_sys_shutdown net/socket.c:1972 [inline]
>  __se_sys_shutdown net/socket.c:1970 [inline]
>  __ia32_sys_shutdown+0x54/0x80 net/socket.c:1970
>  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7fa4ca9
> Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b
> 5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90
> 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000f5f7f0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000175
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> Allocated by task 22094:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  __do_kmalloc_node mm/slab.c:3682 [inline]
>  __kmalloc_node+0x47/0x70 mm/slab.c:3689
>  kmalloc_node include/linux/slab.h:555 [inline]
>  kvmalloc_node+0xb9/0xf0 mm/util.c:423
>  kvmalloc include/linux/mm.h:577 [inline]
>  vhost_vsock_dev_open+0xa2/0x5a0 drivers/vhost/vsock.c:511
>  misc_open+0x3ca/0x560 drivers/char/misc.c:141
>  chrdev_open+0x25a/0x770 fs/char_dev.c:417
>  do_dentry_open+0x49c/0x1140 fs/open.c:771
>  vfs_open+0xa0/0xd0 fs/open.c:880
>  do_last fs/namei.c:3418 [inline]
>  path_openat+0x12fb/0x5300 fs/namei.c:3534
>  do_filp_open+0x255/0x380 fs/namei.c:3564
>  do_sys_open+0x584/0x720 fs/open.c:1063
>  __do_compat_sys_openat fs/open.c:1109 [inline]
>  __se_compat_sys_openat fs/open.c:1107 [inline]
>  __ia32_compat_sys_openat+0x98/0xf0 fs/open.c:1107
>  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> 
> Freed by task 22093:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x210 mm/slab.c:3813
>  kvfree+0x61/0x70 mm/util.c:449
>  vhost_vsock_free drivers/vhost/vsock.c:499 [inline]
>  vhost_vsock_dev_release+0x4fd/0x750 drivers/vhost/vsock.c:604
>  __fput+0x36e/0x8c0 fs/file_table.c:278
>  ____fput+0x15/0x20 fs/file_table.c:309
>  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
>  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_32_irqs_on arch/x86/entry/common.c:341 [inline]
>  do_fast_syscall_32+0xcd5/0xfb2 arch/x86/entry/common.c:397
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> 
> The buggy address belongs to the object at ffff880193861fc0
>  which belongs to the cache kmalloc-65536 of size 65536
> The buggy address is located 168 bytes inside of
>  65536-byte region [ffff880193861fc0, ffff880193871fc0)
> The buggy address belongs to the page:
> page:ffffea00064e1800 count:1 mapcount:0 mapping:ffff8801dac02500 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffffea00064c7008 ffffea00064e5008 ffff8801dac02500
> raw: 0000000000000000 ffff880193861fc0 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff880193861f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff880193861f80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> > ffff880193862000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                           ^
>  ffff880193862080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff880193862100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================

Seems like a duplicate of the bug Stefan's working on now.

> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
