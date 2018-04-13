Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeDMIcA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:32:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41788 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbeDMIby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:31:54 -0400
X-Google-Smtp-Source: AIpwx483Hn3lZZKQ2v9Ua8KYnCjS4KS4av4+0f3/bSGcLNrwlXl2nl+HKE6IaUQUO5WK4jW4eExmZy3iw4d2sGnc+sk=
MIME-Version: 1.0
In-Reply-To: <be9e24ac-c9b8-6972-f560-c9daea817d28@lab.ntt.co.jp>
References: <94eb2c059ce01f643c0569a228ee@google.com> <CACT4Y+Y+fco9rusF0ZYStBKkbyhZDOvkx50kp1-Lynu3UmgsLA@mail.gmail.com>
 <be9e24ac-c9b8-6972-f560-c9daea817d28@lab.ntt.co.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 13 Apr 2018 10:31:33 +0200
Message-ID: <CACT4Y+aK8xeSaghrkKJUCGgnk7kOD6OZGGxME_g1zowcD9Metg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in __netif_receive_skb_core
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: syzbot <syzbot+b202b7208664142954fa@syzkaller.appspotmail.com>,
        bpoirier@suse.com, David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        Mike Maloney <maloney@google.com>, netdev <netdev@vger.kernel.org>,
        rami.rosen@intel.com, syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 10:20 AM, Toshiaki Makita
<makita.toshiaki@lab.ntt.co.jp> wrote:
> On 2018/04/12 17:03, Dmitry Vyukov wrote:
>> On Thu, Apr 12, 2018 at 10:01 AM, syzbot
>> <syzbot+b202b7208664142954fa@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot hit the following crash on https://github.com/google/kmsan.git/master
>>> commit
>>> e2ab7e8abba47a2f2698216258e5d8727ae58717 (Fri Apr 6 16:24:31 2018 +0000)
>>> kmsan: temporarily disable visitAsmInstruction() to help syzbot
>>> syzbot dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=b202b7208664142954fa
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>> Raw console output:
>>> https://syzkaller.appspot.com/x/log.txt?id=5356516437655552
>>> Kernel config:
>>> https://syzkaller.appspot.com/x/.config?id=6627248707860932248
>>> compiler: clang version 7.0.0 (trunk 329391)
>>
>> +Toshiaki as this seems to be related to the recent vlan tagging changes.
>
> seems not...
> "Uninit was stored to memory at:" shows uninitialized memory was stored
> before where I modified the code (skb_reorder_vlan_header).
>
> I'm not sure what this uninit memory means.
> To me it looks like the memory is initialized by user provided data.
>
> (iov in packet sock -> skb->data -> skb->protocol)
>
> The reproducer provides 4 bytes after ethernet header, so it should be
> sufficient for a vlan tag. This will set skb->len to 4 and fill the
> 4-byte contents in packet_snd(). skb_vlan_untag() is reading the user
> provided 4-byte skb->data. It is ensured that skb_vlan_untag() does not
> read beyond skb->len since it calls pskb_may_pull(). At this point I am
> failing to find what I am missing.

Eric,

You mentioned something about assumption that the
__vlan_insert_inner_tag() helper would only be called from
__netif_receive_skb_core(). Can you elaborate?



>> This also seems to be related to
>> https://groups.google.com/d/msg/syzkaller-bugs/VRH9NnUi2k0/90GYsAeRBgAJ
>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
>>> It will help syzbot understand when the bug is fixed. See footer for
>>> details.
>>> If you forward the report, please keep this part and the footer.
>>>
>>> ==================================================================
>>> BUG: KMSAN: uninit-value in __read_once_size include/linux/compiler.h:197
>>> [inline]
>>> BUG: KMSAN: uninit-value in deliver_ptype_list_skb net/core/dev.c:1908
>>> [inline]
>>> BUG: KMSAN: uninit-value in __netif_receive_skb_core+0x4630/0x4a80
>>> net/core/dev.c:4545
>>> CPU: 0 PID: 5999 Comm: syz-executor3 Not tainted 4.16.0+ #82
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> Call Trace:
>>>  <IRQ>
>>>  __dump_stack lib/dump_stack.c:17 [inline]
>>>  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>>>  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>>>  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
>>>  __read_once_size include/linux/compiler.h:197 [inline]
>>>  deliver_ptype_list_skb net/core/dev.c:1908 [inline]
>>>  __netif_receive_skb_core+0x4630/0x4a80 net/core/dev.c:4545
>>>  __netif_receive_skb net/core/dev.c:4627 [inline]
>>>  process_backlog+0x62d/0xe20 net/core/dev.c:5307
>>>  napi_poll net/core/dev.c:5705 [inline]
>>>  net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
>>>  __do_softirq+0x56d/0x93d kernel/softirq.c:285
>>>  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1040
>>>  </IRQ>
>>>  do_softirq kernel/softirq.c:329 [inline]
>>>  __local_bh_enable_ip+0x114/0x140 kernel/softirq.c:182
>>>  local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
>>>  rcu_read_unlock_bh include/linux/rcupdate.h:726 [inline]
>>>  __dev_queue_xmit+0x2a31/0x2b60 net/core/dev.c:3584
>>>  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3590
>>>  packet_snd net/packet/af_packet.c:2944 [inline]
>>>  packet_sendmsg+0x7c57/0x8a10 net/packet/af_packet.c:2969
>>>  sock_sendmsg_nosec net/socket.c:630 [inline]
>>>  sock_sendmsg net/socket.c:640 [inline]
>>>  sock_write_iter+0x3b9/0x470 net/socket.c:909
>>>  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
>>>  do_iter_write+0x30d/0xd40 fs/read_write.c:932
>>>  vfs_writev fs/read_write.c:977 [inline]
>>>  do_writev+0x3c9/0x830 fs/read_write.c:1012
>>>  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
>>>  SyS_writev+0x56/0x80 fs/read_write.c:1082
>>>  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>>>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>>> RIP: 0033:0x455259
>>> RSP: 002b:00007fb53ede8c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
>>> RAX: ffffffffffffffda RBX: 00007fb53ede96d4 RCX: 0000000000455259
>>> RDX: 0000000000000001 RSI: 00000000200010c0 RDI: 0000000000000013
>>> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
>>> R13: 00000000000006cd R14: 00000000006fd3d8 R15: 0000000000000000
>>>
>>> Uninit was stored to memory at:
>>>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
>>>  kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
>>>  kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
>>>  __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:521
>>>  skb_vlan_untag+0x950/0xee0 include/linux/if_vlan.h:597
>>>  __netif_receive_skb_core+0x70a/0x4a80 net/core/dev.c:4460
>>>  __netif_receive_skb net/core/dev.c:4627 [inline]
>>>  process_backlog+0x62d/0xe20 net/core/dev.c:5307
>>>  napi_poll net/core/dev.c:5705 [inline]
>>>  net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
>>>  __do_softirq+0x56d/0x93d kernel/softirq.c:285
>>> Uninit was created at:
>>>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
>>>  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
>>>  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
>>>  kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
>>>  slab_post_alloc_hook mm/slab.h:445 [inline]
>>>  slab_alloc_node mm/slub.c:2737 [inline]
>>>  __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
>>>  __kmalloc_reserve net/core/skbuff.c:138 [inline]
>>>  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
>>>  alloc_skb include/linux/skbuff.h:984 [inline]
>>>  alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
>>>  sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
>>>  packet_alloc_skb net/packet/af_packet.c:2803 [inline]
>>>  packet_snd net/packet/af_packet.c:2894 [inline]
>>>  packet_sendmsg+0x6444/0x8a10 net/packet/af_packet.c:2969
>>>  sock_sendmsg_nosec net/socket.c:630 [inline]
>>>  sock_sendmsg net/socket.c:640 [inline]
>>>  sock_write_iter+0x3b9/0x470 net/socket.c:909
>>>  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
>>>  do_iter_write+0x30d/0xd40 fs/read_write.c:932
>>>  vfs_writev fs/read_write.c:977 [inline]
>>>  do_writev+0x3c9/0x830 fs/read_write.c:1012
>>>  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
>>>  SyS_writev+0x56/0x80 fs/read_write.c:1082
>>>  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>>>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>>> ==================================================================
>>>
>>>
>>> ---
>>> This bug is generated by a dumb bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for details.
>>> Direct all questions to syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this bug report.
>>> If you forgot to add the Reported-by tag, once the fix for this bug is
>>> merged
>>> into any tree, please reply to this email with:
>>> #syz fix: exact-commit-title
>>> To mark this as a duplicate of another syzbot report, please reply with:
>>> #syz dup: exact-subject-of-another-report
>>> If it's a one-off invalid bug report, please reply with:
>>> #syz invalid
>>> Note: if the crash happens again, it will cause creation of a new bug
>>> report.
>>> Note: all commands must start from beginning of the line in the email body.
>>>
>>> --
>>> You received this message because you are subscribed to the Google Groups
>>> "syzkaller-bugs" group.
>>> To unsubscribe from this group and stop receiving emails from it, send an
>>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>>> To view this discussion on the web visit
>>> https://groups.google.com/d/msgid/syzkaller-bugs/94eb2c059ce01f643c0569a228ee%40google.com.
>>> For more options, visit https://groups.google.com/d/optout.
>>
>>
>
> --
> Toshiaki Makita
>
