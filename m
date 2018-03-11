Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeCKWfW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:35:22 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36285 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932347AbeCKWfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:35:20 -0400
X-Google-Smtp-Source: AG47ELsktfrPCxAirqhsIa1pEeeQ6WaXepQnsDNj5plJJsNHSzxjsxiUyTiqAezorIDAt8T0ekomoYpVT0FUGGDXtao=
MIME-Version: 1.0
In-Reply-To: <20180311213402.GA2267@zzz.localdomain>
References: <089e0825d42484310b055c75c3f6@google.com> <20171026175847.GH59538@devbig577.frc2.facebook.com>
 <CACT4Y+Y9cEkLwg54qXvDtgp2rbEcw-MUiLik8THtL3yWWH0-Ow@mail.gmail.com>
 <CAM_iQpU0XFuj_Qc_Usug5=ymRWGU0nhQyPso6O=VbhPKAMa91Q@mail.gmail.com>
 <CACT4Y+ab1RyHGJrD_KQQrh7bTbFTDx71RZ9H_QSNtAagtB1V8A@mail.gmail.com>
 <CACT4Y+Z0hLxC1GeSSpWm1YzUZYuDOG7+d407RJ=ffZ=8d5_vbw@mail.gmail.com> <20180311213402.GA2267@zzz.localdomain>
From: Tom Herbert <tom@quantonium.net>
Date: Sun, 11 Mar 2018 15:35:19 -0700
Message-ID: <CAPDqMerg+4VJaEnOUJyiYks_hS6BN3AuS_O3XJcdXvJau56bVw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in get_work_pool
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Tejun Heo <tj@kernel.org>,
        syzbot
        <bot+ea75c0ffcd353d32515f064aaebefc5279e6161e@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, syzkaller-bugs@googlegroups.com,
        David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Eric Biggers <ebiggers@google.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 2:34 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Wed, Feb 14, 2018 at 02:45:05PM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
>> On Wed, Dec 6, 2017 at 1:50 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> > On Fri, Oct 27, 2017 at 11:18 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>> >> On Thu, Oct 26, 2017 at 11:00 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> >>> On Thu, Oct 26, 2017 at 7:58 PM, Tejun Heo <tj@kernel.org> wrote:
>> >>>> Hello,
>> >>>>
>> >>>> On Thu, Oct 26, 2017 at 09:35:44AM -0700, syzbot wrote:
>> >>>>> BUG: KASAN: use-after-free in __read_once_size
>> >>>>> include/linux/compiler.h:276 [inline]
>> >>>>> BUG: KASAN: use-after-free in atomic64_read
>> >>>>> arch/x86/include/asm/atomic64_64.h:21 [inline]
>> >>>>> BUG: KASAN: use-after-free in atomic_long_read
>> >>>>> include/asm-generic/atomic-long.h:44 [inline]
>> >>>>> BUG: KASAN: use-after-free in get_work_pool+0x1c2/0x1e0
>> >>>>> kernel/workqueue.c:709
>> >>>>> Read of size 8 at addr ffff8801cc58c378 by task syz-executor5/21326
>> >>>>>
>> >>>>> CPU: 1 PID: 21326 Comm: syz-executor5 Not tainted 4.13.0+ #43
>> >>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>> >>>>> BIOS Google 01/01/2011
>> >>>>> Call Trace:
>> >>>>>  __dump_stack lib/dump_stack.c:16 [inline]
>> >>>>>  dump_stack+0x194/0x257 lib/dump_stack.c:52
>> >>>>>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>> >>>>>  kasan_report_error mm/kasan/report.c:351 [inline]
>> >>>>>  kasan_report+0x24e/0x340 mm/kasan/report.c:409
>> >>>>>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
>> >>>>>  __read_once_size include/linux/compiler.h:276 [inline]
>> >>>>>  atomic64_read arch/x86/include/asm/atomic64_64.h:21 [inline]
>> >>>>>  atomic_long_read include/asm-generic/atomic-long.h:44 [inline]
>> >>>>>  get_work_pool+0x1c2/0x1e0 kernel/workqueue.c:709
>> >>>>>  __queue_work+0x235/0x1150 kernel/workqueue.c:1401
>> >>>>>  queue_work_on+0x16a/0x1c0 kernel/workqueue.c:1486
>> >>>>>  queue_work include/linux/workqueue.h:489 [inline]
>> >>>>>  strp_check_rcv+0x25/0x30 net/strparser/strparser.c:553
>> >>>>>  kcm_attach net/kcm/kcmsock.c:1439 [inline]
>> >>>>>  kcm_attach_ioctl net/kcm/kcmsock.c:1460 [inline]
>> >>>>>  kcm_ioctl+0x826/0x1610 net/kcm/kcmsock.c:1695
>> >>>>>  sock_do_ioctl+0x65/0xb0 net/socket.c:961
>> >>>>>  sock_ioctl+0x2c2/0x440 net/socket.c:1058
>> >>>>>  vfs_ioctl fs/ioctl.c:45 [inline]
>> >>>>>  do_vfs_ioctl+0x1b1/0x1530 fs/ioctl.c:685
>> >>>>>  SYSC_ioctl fs/ioctl.c:700 [inline]
>> >>>>>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
>> >>>>>  entry_SYSCALL_64_fastpath+0x1f/0xbe
>> >>>>
>> >>>> Looks like kcm is trying to reuse a work item whose last workqueue has
>> >>>> been destroyed without re-initing it.  A work item needs to be
>> >>>> reinit'd.
>> >>>
>> >>> +kcm maintainers
>> >>
>> >> Can you try the fix below? There is no C reproducer so I can't verify it.
>> >
>> >
>> > Hi Cong,
>> >
>> > syzbot can now test proposed patches, see
>> > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communication-with-syzbot
>> > for details. Please give it a try.
>> >
>> >> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
>> >> index af4e76ac88ff..7816f44c576a 100644
>> >> --- a/net/kcm/kcmsock.c
>> >> +++ b/net/kcm/kcmsock.c
>> >> @@ -1433,11 +1433,12 @@ static int kcm_attach(struct socket *sock,
>> >> struct socket *csock,
>> >>         KCM_STATS_INCR(mux->stats.psock_attach);
>> >>         mux->psocks_cnt++;
>> >>         psock_now_avail(psock);
>> >> -       spin_unlock_bh(&mux->lock);
>> >>
>> >>         /* Schedule RX work in case there are already bytes queued */
>> >>         strp_check_rcv(&psock->strp);
>> >>
>> >> +       spin_unlock_bh(&mux->lock);
>> >> +
>> >>         return 0;
>> >>  }
>>
>>
>> Hi Cong,
>>
>> Was this ever merged? Is it still necessary?
>>
>
> syzbot is no longer hitting this bug for some reason but it's still there.  Tom,
> it looks like you wrote the buggy code (it's yet another KCM bug, apparently);
> can you please look into it?
>
Yes. Thank you for the simple reproducer.

Tom

> I've put together a C reproducer that works on latest linux-next (next-20180309,
> commit 61530b14b059d).  It works as an unprivileged user provided that KCM is
> enabled, and that KASAN is enabled so you see the use-after-free report:
>
> #include <linux/bpf.h>
> #include <linux/in.h>
> #include <linux/kcm.h>
> #include <sys/ioctl.h>
> #include <sys/socket.h>
> #include <sys/syscall.h>
> #include <unistd.h>
>
> int main()
> {
>         union bpf_attr prog = {
>                 .prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
>                 .insn_cnt = 2,
>                 .insns = (__u64)(__u64[]){ 0xb7, 0x95 },
>                 .license = (__u64)"",
>         };
>         int tcp_fd, bpf_fd, kcm_fd;
>         struct sockaddr_in addr = {
>                 .sin_family = AF_INET,
>                 .sin_port = __constant_htons(3270),
>                 .sin_addr = { __constant_htonl(0x7f000001) }
>         };
>
>         tcp_fd = socket(AF_INET, SOCK_STREAM, 0);
>         bind(tcp_fd, (void *)&addr, sizeof(addr));
>         listen(tcp_fd, 1);
>         tcp_fd = socket(AF_INET, SOCK_STREAM, 0);
>         connect(tcp_fd, (void *)&addr, sizeof(addr));
>         bpf_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &prog, 48);
>         kcm_fd = socket(AF_KCM, SOCK_SEQPACKET, 0);
>         if (fork() == 0) {
>                 struct kcm_attach attach = { tcp_fd, bpf_fd };
>
>                 for (;;)
>                         ioctl(kcm_fd, SIOCKCMATTACH, &attach);
>         } else {
>                 struct kcm_unattach unattach = { tcp_fd };
>
>                 for (;;)
>                         ioctl(kcm_fd, SIOCKCMUNATTACH, &unattach);
>         }
> }
