Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeBLPwS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:52:18 -0500
Received: from mail-pl0-f52.google.com ([209.85.160.52]:34061 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbeBLPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:52:16 -0500
X-Google-Smtp-Source: AH8x224Y/6OBz+xfDxEUfcluFr36fvcM+ZzTtK8o20/ZINz8GA5QeV4m/scKYZm2e/Tp/hnGcV9QXcBEUlPURTUcpSg=
MIME-Version: 1.0
In-Reply-To: <001a113f5334709ce405620ea77d@google.com>
References: <001a113f5334709ce405620ea77d@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Feb 2018 16:51:54 +0100
Message-ID: <CACT4Y+br0cPnzhfneGFu1Eks-RknWY9LAAjXCezqmk0kT8gPdQ@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in memcmp
To: syzbot <syzbot+1dfda02bdf25a814ceb7@syzkaller.appspotmail.com>
Cc: David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 5, 2018 at 11:06 PM, syzbot
<syzbot+1dfda02bdf25a814ceb7@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzkaller hit the following crash on
> bcecb4bbf88aa03171c30652bca761cf27755a6b
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> Unfortunately, I don't have any reproducer for this bug yet.
>
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1dfda02bdf25a814ceb7@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.


#syz fix:
xfrm: Fix stack-out-of-bounds with misconfigured transport mode policies.


> ==================================================================
> BUG: KASAN: stack-out-of-bounds in memcmp+0xe3/0x160 lib/string.c:861
> Read of size 1 at addr ffff8801c19175d0 by task syz-executor6/18562
>
> CPU: 0 PID: 18562 Comm: syz-executor6 Not tainted 4.15.0-rc5+ #172
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:427
>  memcmp+0xe3/0x160 lib/string.c:861
>  memcmp include/linux/string.h:385 [inline]
>  addr_match include/net/xfrm.h:873 [inline]
>  __xfrm6_selector_match net/xfrm/xfrm_policy.c:90 [inline]
>  xfrm_selector_match+0x1bc/0xe00 net/xfrm/xfrm_policy.c:104
>  xfrm_state_look_at.constprop.30+0x113/0x360 net/xfrm/xfrm_state.c:909
>  xfrm_state_find+0x1595/0x3210 net/xfrm/xfrm_state.c:977
>  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:1394 [inline]
>  xfrm_tmpl_resolve+0x2ee/0xc40 net/xfrm/xfrm_policy.c:1438
>  xfrm_resolve_and_create_bundle+0x184/0x28d0 net/xfrm/xfrm_policy.c:1829
>  xfrm_lookup+0x15b2/0x24f0 net/xfrm/xfrm_policy.c:2155
>  xfrm_lookup_route+0x39/0x1a0 net/xfrm/xfrm_policy.c:2273
>  ip_route_output_flow+0x7c/0xa0 net/ipv4/route.c:2559
>  udp_sendmsg+0x19d3/0x2ce0 net/ipv4/udp.c:999
>  udpv6_sendmsg+0x757/0x3400 net/ipv6/udp.c:1156
>  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:764
>  sock_sendmsg_nosec net/socket.c:628 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:638
>  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2018
>  __sys_sendmsg+0xe5/0x210 net/socket.c:2052
>  SYSC_sendmsg net/socket.c:2063 [inline]
>  SyS_sendmsg+0x2d/0x50 net/socket.c:2059
>  entry_SYSCALL_64_fastpath+0x23/0x9a
> RIP: 0033:0x452ac9
> RSP: 002b:00007f6372138c58 EFLAGS: 00000212 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000452ac9
> RDX: 0000000000000000 RSI: 00000000201f1000 RDI: 0000000000000013
> RBP: 00000000000004a8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f5060
> R13: 00000000ffffffff R14: 00007f63721396d4 R15: 0000000000000000
>
> The buggy address belongs to the page:
> page:00000000f9ea28ea count:0 mapcount:0 mapping:          (null) index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 0000000000000000 0000000000000000 00000000ffffffff
> raw: 0000000000000000 dead000000000200 0000000000000000 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801c1917480: f1 f1 f1 04 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2
>  ffff8801c1917500: f2 f2 f2 f8 f2 f2 f2 f2 f2 f2 f2 00 00 00 00 f2
>>
>> ffff8801c1917580: f2 f2 f2 00 00 00 00 00 00 00 f2 f2 f2 f2 f2 00
>
>                                                  ^
>  ffff8801c1917600: 00 00 00 00 00 00 00 00 f2 f2 f2 00 00 00 00 00
>  ffff8801c1917680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a113f5334709ce405620ea77d%40google.com.
> For more options, visit https://groups.google.com/d/optout.
