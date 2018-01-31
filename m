Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeAaCCq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:02:46 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:37298 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeAaCCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:02:15 -0500
X-Google-Smtp-Source: AH8x226m0/GMEGlRbdgBlRXi/n/yawLDtjaE+lKjZSs18z7Fle2nU+CMi0sVm9fm5LNIqr5mrtAjoQ==
Date: Tue, 30 Jan 2018 18:02:12 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+c028095236fcb6f4348811565b75084c754dc729@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: slab-out-of-bounds Read in xfrm_hash_rebuild
Message-ID: <20180131020212.setj66yw7nxgymwa@gmail.com>
References: <089e0825eec8a9d078055d6a6961@google.com>
 <001a1140f578d314ec0560d9f29a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a1140f578d314ec0560d9f29a@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2017 at 05:48:01AM -0800, syzbot wrote:
> syzkaller has found reproducer for the following crash on
> 8f36e00065436412a02d1f50ad77375bdb506300
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in xfrm_hash_rebuild+0xdbe/0xf00
> net/xfrm/xfrm_policy.c:618
> Read of size 2 at addr ffff8801c8e92fe4 by task kworker/1:1/23
> 
> CPU: 1 PID: 23 Comm: kworker/1:1 Not tainted 4.15.0-rc3+ #161
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events xfrm_hash_rebuild
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:428
>  xfrm_hash_rebuild+0xdbe/0xf00 net/xfrm/xfrm_policy.c:618
>  process_one_work+0xbbf/0x1b10 kernel/workqueue.c:2112
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2246
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:441
> 
> Allocated by task 3152:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  __do_kmalloc mm/slab.c:3708 [inline]
>  __kmalloc+0x162/0x760 mm/slab.c:3717
>  kmalloc include/linux/slab.h:504 [inline]
>  sk_prot_alloc+0x101/0x2a0 net/core/sock.c:1471
>  sk_alloc+0x8c/0x730 net/core/sock.c:1525
>  pfkey_create+0x2b2/0xae0 net/key/af_key.c:158
>  __sock_create+0x4d4/0x850 net/socket.c:1257
>  sock_create net/socket.c:1297 [inline]
>  SYSC_socket net/socket.c:1327 [inline]
>  SyS_socket+0xeb/0x1d0 net/socket.c:1307
>  entry_SYSCALL_64_fastpath+0x1f/0x96

#syz fix: xfrm: skip policies marked as dead while rehashing
