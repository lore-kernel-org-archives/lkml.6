Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755664AbeE1Rzy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:55:54 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35115 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755643AbeE1Rzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:55:51 -0400
X-Google-Smtp-Source: ADUXVKJvQZk7dbB6n8Kh2gWig7xK/rfmnKNIdM9xX0axYxvbJom2nZpq+t8li4YH6PL9dt57rEBxtQ==
Date: Mon, 28 May 2018 14:55:46 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3dcd59a1f907245f891f@syzkaller.appspotmail.com>,
        ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: rcu detected stall in is_bpf_text_address
Message-ID: <20180528175546.GD3787@localhost.localdomain>
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

Considering
struct sctp_rtoinfo {
        sctp_assoc_t    srto_assoc_id;
        __u32           srto_initial;
        __u32           srto_max;
        __u32           srto_min;
};

Isn't this actually equivalent to:
struct sctp_rtoinfo foo = {
	.srto_assoc_id = 0,
	.srto_initial = 6,
	.srto_max = 7,
	.srto_min = 4     /* instead of 6 */
};

?

This doesn't change a thing in the analysis, it's just to be sure
which one is right.
