Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeAaBnQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:43:16 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:41400 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeAaBnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:43:14 -0500
X-Google-Smtp-Source: AH8x227CFIP7T3UOciug0JuAWqVLaPHgkCaNamco4+F0mHM782puQ+vMKNErI2u+gQ8dh2M0TnEO2hG7dxAq8242rJQ=
MIME-Version: 1.0
In-Reply-To: <20180131011643.slqdqtfl25svbpue@gmail.com>
References: <001a1145e85edcbf2d0561d3075c@google.com> <f54f53e7-593e-853d-9b52-fd296898c49c@gmail.com>
 <CAEA6p_Bfd4odvQ2bdObYpy8wNi2YcW70d5bMLMdnLK3+YnYjMg@mail.gmail.com> <20180131011643.slqdqtfl25svbpue@gmail.com>
From: Wei Wang <weiwan@google.com>
Date: Tue, 30 Jan 2018 17:43:12 -0800
Message-ID: <CAEA6p_APT17czXFbjiM9gTmd94xAw-mz0yKjif9iN_VyXXS4xQ@mail.gmail.com>
Subject: Re: general protection fault in fib6_add (2)
To: Eric Biggers <ebiggers3@gmail.com>
Cc: David Ahern <dsahern@gmail.com>,
        syzbot <syzbot+0693adff3f83403dc5da@syzkaller.appspotmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 5:16 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Wed, Jan 03, 2018 at 10:53:02AM -0800, 'Wei Wang' via syzkaller-bugs wrote:
>> On Wed, Jan 3, 2018 at 8:16 AM, David Ahern <dsahern@gmail.com> wrote:
>> > [ +weiwan@google.com ]
>> >
>> > On 1/2/18 3:58 PM, syzbot wrote:
>> >> Hello,
>> >>
>> >> syzkaller hit the following crash on
>> >> 61233580f1f33c50e159c50e24d80ffd2ba2e06b
>> >> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> >> compiler: gcc (GCC) 7.1.1 20170620
>> >> .config is attached
>> >> Raw console output is attached.
>> >> C reproducer is attached
>> >> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>> >> for information about syzkaller reproducers
>> >>
>> >>
>> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> >> Reported-by: syzbot+0693adff3f83403dc5da@syzkaller.appspotmail.com
>> >> It will help syzbot understand when the bug is fixed. See footer for
>> >> details.
>> >> If you forward the report, please keep this part and the footer.
>
> This crash seemed to stop occurring around Jan 8.  Wei, next time can you please
> use the suggested Reported-by line so that syzbot knows which commit is meant to
> fix the bug?  I assume it was this one:
Noted. Will do.

>
> #syz fix: ipv6: fix general protection fault in fib6_add()
>
Yes. Correct.

> Thanks!
>
> - Eric
>
>> >>
>> >> audit: type=1400 audit(1514594846.496:7): avc:  denied  { map } for
>> >> pid=3201 comm="syzkaller001778" path="/root/syzkaller001778299"
>> >> dev="sda1" ino=16481
>> >> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
>> >> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
>> >> IPv6: Can't replace route, no match found
>> >> kasan: CONFIG_KASAN_INLINE enabled
>> >> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> >> general protection fault: 0000 [#1] SMP KASAN
>> >> Dumping ftrace buffer:
>> >>    (ftrace buffer empty)
>> >> Modules linked in:
>> >> CPU: 0 PID: 3201 Comm: syzkaller001778 Not tainted 4.15.0-rc5+ #151
>> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> >> Google 01/01/2011
>> >> RIP: 0010:fib6_add+0x736/0x15a0 net/ipv6/ip6_fib.c:1244
>>
>> pn could be NULL if fib6_add_1() failed. Will submit a fix for this.
>>
>> >> RSP: 0018:ffff8801c7626a70 EFLAGS: 00010202
>> >> RAX: dffffc0000000000 RBX: 0000000000000020 RCX: ffffffff84794465
>> >> RDX: 0000000000000004 RSI: ffff8801d38935f0 RDI: 0000000000000282
>> >> RBP: ffff8801c7626da0 R08: 1ffff10038ec4c35 R09: 0000000000000000
>> >> R10: ffff8801c7626c68 R11: 0000000000000000 R12: 00000000fffffffe
>> >> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000009
>> >> FS:  0000000000000000(0000) GS:ffff8801db200000(0063)
>> >> knlGS:0000000009b70840
>> >> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>> >> CR2: 0000000020be1000 CR3: 00000001d585a006 CR4: 00000000001606f0
>> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> >> Call Trace:
>> >>  __ip6_ins_rt+0x6c/0x90 net/ipv6/route.c:1006
>> >>  ip6_route_multipath_add+0xd14/0x16c0 net/ipv6/route.c:3833
>> >>  inet6_rtm_newroute+0xdc/0x160 net/ipv6/route.c:3957
>> >>  rtnetlink_rcv_msg+0x733/0x1020 net/core/rtnetlink.c:4411
>> >>  netlink_rcv_skb+0x21e/0x460 net/netlink/af_netlink.c:2408
>> >>  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4423
>> >>  netlink_unicast_kernel net/netlink/af_netlink.c:1275 [inline]
>> >>  netlink_unicast+0x4e8/0x6f0 net/netlink/af_netlink.c:1301
>> >>  netlink_sendmsg+0xa4a/0xe60 net/netlink/af_netlink.c:1864
>> >>  sock_sendmsg_nosec net/socket.c:636 [inline]
>> >>  sock_sendmsg+0xca/0x110 net/socket.c:646
>> >>  sock_write_iter+0x31a/0x5d0 net/socket.c:915
>> >>  call_write_iter include/linux/fs.h:1772 [inline]
>> >>  do_iter_readv_writev+0x525/0x7f0 fs/read_write.c:653
>> >>  do_iter_write+0x154/0x540 fs/read_write.c:932
>> >>  compat_writev+0x225/0x420 fs/read_write.c:1246
>> >>  do_compat_writev+0x115/0x220 fs/read_write.c:1267
>> >>  C_SYSC_writev fs/read_write.c:1278 [inline]
>> >>  compat_SyS_writev+0x26/0x30 fs/read_write.c:1274
>> >>  do_syscall_32_irqs_on arch/x86/entry/common.c:327 [inline]
>> >>  do_fast_syscall_32+0x3ee/0xf9d arch/x86/entry/common.c:389
>> >>  entry_SYSENTER_compat+0x54/0x63 arch/x86/entry/entry_64_compat.S:125
>> >> RIP: 0023:0xf7f1fc79
>> >> RSP: 002b:00000000ffb61bfc EFLAGS: 00000203 ORIG_RAX: 0000000000000092
>> >> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000204aaff0
>> >> RDX: 0000000000000001 RSI: 0000000000000167 RDI: 0000000000000010
>> >> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
>> >> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>> >> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> >> Code: f1 a9 f6 fc e8 2c f2 e2 fc 85 c0 0f 85 d5 03 00 00 49 8d 5e 20 e8
>> >> db a9 f6 fc 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
>> >> 02 00 0f 85 5a 0c 00 00 4d 39 ee 4d 8b 7e 20 0f 95 c0 4c
>> >> RIP: fib6_add+0x736/0x15a0 net/ipv6/ip6_fib.c:1244 RSP: ffff8801c7626a70
>> >> ---[ end trace 956c65133fcfff88 ]---
>> >>
>> >>
>> >> ---
>> >> This bug is generated by a dumb bot. It may contain errors.
>> >> See https://goo.gl/tpsmEJ for details.
>> >> Direct all questions to syzkaller@googlegroups.com.
>> >>
>> >> syzbot will keep track of this bug report.
>> >> If you forgot to add the Reported-by tag, once the fix for this bug is
>> >> merged
>> >> into any tree, please reply to this email with:
>> >> #syz fix: exact-commit-title
>> >> If you want to test a patch for this bug, please reply with:
>> >> #syz test: git://repo/address.git branch
>> >> and provide the patch inline or as an attachment.
>> >> To mark this as a duplicate of another syzbot report, please reply with:
>> >> #syz dup: exact-subject-of-another-report
>> >> If it's a one-off invalid bug report, please reply with:
>> >> #syz invalid
>> >> Note: if the crash happens again, it will cause creation of a new bug
>> >> report.
>> >> Note: all commands must start from beginning of the line in the email body.
>> >
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAEA6p_Bfd4odvQ2bdObYpy8wNi2YcW70d5bMLMdnLK3%2BYnYjMg%40mail.gmail.com.
>> For more options, visit https://groups.google.com/d/optout.
