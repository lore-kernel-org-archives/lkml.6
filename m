Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeA3XWx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:22:53 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:44308 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeA3XWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:22:51 -0500
X-Google-Smtp-Source: AH8x227zDEp0ty3HBEIOt6UwNuvTiv7pBel9o6x+/vvBuAdGiCvv2yL5cHP8g420NXEx1cChBpJKtw==
Date: Tue, 30 Jan 2018 15:22:48 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+dcda61eb1d7c3c2e1afe0116cbbcd373f606d495@syzkaller.appspotmail.com>
Cc: keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in insert_header
Message-ID: <20180130232248.kmaplralwkwib2jo@gmail.com>
References: <001a113f861e475a900560cbc1be@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113f861e475a900560cbc1be@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2017 at 12:52:00PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 6084b576dca2e898f5c101baef151f7bfdbb606d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> Unfortunately, I don't have any reproducer for this bug yet.
> 
> 
> general protection fault: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 26264 Comm: syz-executor4 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:insert_entry fs/proc/proc_sysctl.c:154 [inline]
> RIP: 0010:insert_header+0x147/0x550 fs/proc/proc_sysctl.c:232
> RSP: 0018:ffffc90000d7baa0 EFLAGS: 00010282
> RAX: ffff10041e891880 RBX: ffff8801fde24250 RCX: ffffffff814c0610
> RDX: ffff88020f448c00 RSI: ffff8802164a35f4 RDI: 000000000000000d
> RBP: ffffc90000d7bb08 R08: 0000000000000034 R09: 0000000000000004
> R10: ffffc90000d7ba88 R11: 0000000000000004 R12: ffff88020f448c50
> R13: ffffffff82e49909 R14: 000000000000000d R15: 0000000000000000
> FS:  0000000001f24940(0000) GS:ffff88021fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b9bc20000 CR3: 00000001fc5a9001 CR4: 00000000001606f0
> DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000020001008
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  __register_sysctl_table+0x31e/0x7c0 fs/proc/proc_sysctl.c:1333
>  register_net_sysctl+0x29/0x30 net/sysctl_net.c:120
>  neigh_sysctl_register+0x150/0x220 net/core/neighbour.c:3235
>  devinet_sysctl_register+0x66/0xc0 net/ipv4/devinet.c:2351
>  inetdev_init+0xd5/0x1c0 net/ipv4/devinet.c:263
>  inetdev_event+0x517/0x5c0 net/ipv4/devinet.c:1461
>  notifier_call_chain+0x41/0xc0 kernel/notifier.c:93
>  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
>  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
>  call_netdevice_notifiers_info+0x32/0x60 net/core/dev.c:1679
>  call_netdevice_notifiers net/core/dev.c:1697 [inline]
>  register_netdevice+0x639/0x710 net/core/dev.c:7772
>  tun_set_iff drivers/net/tun.c:2390 [inline]
>  __tun_chr_ioctl+0xb62/0x1660 drivers/net/tun.c:2614
>  tun_chr_ioctl+0x2a/0x40 drivers/net/tun.c:2867
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0xaf/0x840 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x452897
> RSP: 002b:00007ffc216d39d8 EFLAGS: 00000203 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000071c00c RCX: 0000000000452897
> RDX: 00007ffc216d39e0 RSI: 00000000400454ca RDI: 0000000000000012
> RBP: 00000000006ed018 R08: 000000000000000b R09: 0000000000000004
> R10: 0000000000000064 R11: 0000000000000203 R12: 0000000080086301
> R13: 000000000071cad4 R14: 0000000000000000 R15: 0000000000000000
> Code: 89 e7 e8 3d 9d df ff 4c 8b 23 4d 85 e4 74 4c e8 30 9d df ff 49 8b 54
> 24 18 4c 89 e0 48 2b 42 40 48 c1 f8 05 48 c1 e0 06 48 03 02 <4c> 8b 38 4c 89
> ff e8 ce 93 0f 01 4c 89 fa 89 c1 44 89 f6 4c 89
> RIP: insert_entry fs/proc/proc_sysctl.c:154 [inline] RSP: ffffc90000d7baa0
> RIP: insert_header+0x147/0x550 fs/proc/proc_sysctl.c:232 RSP:
> ffffc90000d7baa0
> ---[ end trace 76ddaafb5776e82d ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
