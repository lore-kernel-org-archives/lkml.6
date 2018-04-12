Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbeDLIDi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 04:03:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45012 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDLIDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 04:03:37 -0400
X-Google-Smtp-Source: AIpwx4/7hq5OeOpiVip9i72h5fv7I/mRfSor7Qz6n/Fc3jyyTe0vBrKXE7+KF8s3dA60xo6aXigjknKxGl5KnUR+UnA=
MIME-Version: 1.0
In-Reply-To: <089e082d0cb81b67d10569a2283f@google.com>
References: <089e082d0cb81b67d10569a2283f@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 12 Apr 2018 10:03:15 +0200
Message-ID: <CACT4Y+YfWyEx_amzVYkyaNzB2st6zcuDoVmJsE+=gAq2iJVLjg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in netif_skb_features
To: syzbot <syzbot+0bbe42c764feafa82c5a@syzkaller.appspotmail.com>
Cc: bpoirier@suse.com, David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        Mike Maloney <maloney@google.com>, netdev <netdev@vger.kernel.org>,
        rami.rosen@intel.com, syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>, makita.toshiaki@lab.ntt.co.jp
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 10:01 AM, syzbot
<syzbot+0bbe42c764feafa82c5a@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on https://github.com/google/kmsan.git/master
> commit
> e2ab7e8abba47a2f2698216258e5d8727ae58717 (Fri Apr 6 16:24:31 2018 +0000)
> kmsan: temporarily disable visitAsmInstruction() to help syzbot
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=0bbe42c764feafa82c5a
>
> So far this crash happened 30 times on
> https://github.com/google/kmsan.git/master.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4850744041668608
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=6289386287136768
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=4577411249209344
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=6627248707860932248
> compiler: clang version 7.0.0 (trunk 329391)

+Toshiaki as this seems to be related to the recent vlan tagging changes.
This also seems to be related to
https://groups.google.com/d/msg/syzkaller-bugs/FNEavkB4QaM/efXl2AeRBgAJ



> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0bbe42c764feafa82c5a@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> ==================================================================
> BUG: KMSAN: uninit-value in eth_type_vlan include/linux/if_vlan.h:283
> [inline]
> BUG: KMSAN: uninit-value in skb_vlan_tagged_multi
> include/linux/if_vlan.h:656 [inline]
> BUG: KMSAN: uninit-value in vlan_features_check include/linux/if_vlan.h:672
> [inline]
> BUG: KMSAN: uninit-value in dflt_features_check net/core/dev.c:2949 [inline]
> BUG: KMSAN: uninit-value in netif_skb_features+0xd1b/0xdc0
> net/core/dev.c:3009
> CPU: 1 PID: 3582 Comm: syzkaller435149 Not tainted 4.16.0+ #82
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
>  eth_type_vlan include/linux/if_vlan.h:283 [inline]
>  skb_vlan_tagged_multi include/linux/if_vlan.h:656 [inline]
>  vlan_features_check include/linux/if_vlan.h:672 [inline]
>  dflt_features_check net/core/dev.c:2949 [inline]
>  netif_skb_features+0xd1b/0xdc0 net/core/dev.c:3009
>  validate_xmit_skb+0x89/0x1320 net/core/dev.c:3084
>  __dev_queue_xmit+0x1cb2/0x2b60 net/core/dev.c:3549
>  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3590
>  packet_snd net/packet/af_packet.c:2944 [inline]
>  packet_sendmsg+0x7c57/0x8a10 net/packet/af_packet.c:2969
>  sock_sendmsg_nosec net/socket.c:630 [inline]
>  sock_sendmsg net/socket.c:640 [inline]
>  sock_write_iter+0x3b9/0x470 net/socket.c:909
>  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
>  do_iter_write+0x30d/0xd40 fs/read_write.c:932
>  vfs_writev fs/read_write.c:977 [inline]
>  do_writev+0x3c9/0x830 fs/read_write.c:1012
>  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
>  SyS_writev+0x56/0x80 fs/read_write.c:1082
>  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> RIP: 0033:0x43ffa9
> RSP: 002b:00007fff2cff3948 EFLAGS: 00000217 ORIG_RAX: 0000000000000014
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043ffa9
> RDX: 0000000000000001 RSI: 0000000020000080 RDI: 0000000000000003
> RBP: 00000000006cb018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004018d0
> R13: 0000000000401960 R14: 0000000000000000 R15: 0000000000000000
>
> Uninit was created at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
>  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
>  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
>  kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
>  slab_post_alloc_hook mm/slab.h:445 [inline]
>  slab_alloc_node mm/slub.c:2737 [inline]
>  __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
>  __kmalloc_reserve net/core/skbuff.c:138 [inline]
>  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
>  alloc_skb include/linux/skbuff.h:984 [inline]
>  alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
>  sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
>  packet_alloc_skb net/packet/af_packet.c:2803 [inline]
>  packet_snd net/packet/af_packet.c:2894 [inline]
>  packet_sendmsg+0x6444/0x8a10 net/packet/af_packet.c:2969
>  sock_sendmsg_nosec net/socket.c:630 [inline]
>  sock_sendmsg net/socket.c:640 [inline]
>  sock_write_iter+0x3b9/0x470 net/socket.c:909
>  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
>  do_iter_write+0x30d/0xd40 fs/read_write.c:932
>  vfs_writev fs/read_write.c:977 [inline]
>  do_writev+0x3c9/0x830 fs/read_write.c:1012
>  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
>  SyS_writev+0x56/0x80 fs/read_write.c:1082
>  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> ==================================================================
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/089e082d0cb81b67d10569a2283f%40google.com.
> For more options, visit https://groups.google.com/d/optout.
