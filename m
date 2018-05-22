Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeEVAn1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:43:27 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41733 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeEVAnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:43:25 -0400
X-Google-Smtp-Source: AB8JxZpQzLaNkDnNb+5CrbuCyIaJCU0HQTYh0oP8gR5vlfMqsikaTS+p2chgl/XYb/43KqkRtYMLZQ==
Date: Mon, 21 May 2018 21:43:20 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3dcd59a1f907245f891f@syzkaller.appspotmail.com>,
        ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-sctp@vger.kernel.org
Subject: Re: INFO: rcu detected stall in is_bpf_text_address
Message-ID: <20180522004320.GI26212@localhost.localdomain>
References: <0000000000006d7517056c911740@google.com>
 <4b65142a-cf3b-05d7-d66b-018ff8da7ccc@gmail.com>
 <CADvbK_e7LXc7minSmaPw6iZvjWo215wG-pPAS0gr58+-VxUO7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_e7LXc7minSmaPw6iZvjWo215wG-pPAS0gr58+-VxUO7Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 04:26:03PM +0800, Xin Long wrote:
> On Sat, May 19, 2018 at 11:57 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > SCTP experts, please take a look.
> >
> > On 05/19/2018 08:55 AM, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    73fcb1a370c7 Merge branch 'akpm' (patches from Andrew)
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1462ec0f800000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3dcd59a1f907245f891f
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1079cf8f800000
> Thank you.
> The Reproducer is more than helpful.
> 
> setsockopt$inet_sctp6_SCTP_RTOINFO(r0, 0x84, 0x0,
> &(0x7f0000000140)={0x0, 0x6, 0x7, 0x4}, 0x10)
> 
> It set rto_min=6 and rto_max=7, these are too small values.
> t3_rtx timer works fine with it. But hb_timer will get stuck there, as
> in its timer handler it starts this timer again with this value, then
> it goes to the timer handler again...

Nice, thanks Xin.

> 
> HB has to repeat this and the hb timer's expire may also have to use
> 'trans->rto >> 1 ...' stuff. But we can limit the RTO's min value, like
> HZ/20, which is 'Try again later.' number used when sock lock is
> owned by others in all timer handlers.

I think a good fix for this is to not allow the application to go
below net.sctp.rto_min, and neither above net.sctp.rto_max.

Then they can even be close to each other, won't be an issue, as long
as rto_min is something sensible. Which then brings it to the second
step of a fix: to restrict rto_min to be >= HZ/5 (copying from TCP
here).
