Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeETI0O (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:26:14 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41084 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeETI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:26:04 -0400
X-Google-Smtp-Source: AB8JxZqurrjGst13VettZ4f3gcWs8PY6V8ky0rGS/CA3TRjtxoaxM1P5h32ijYZqybGw0J4v9wbhF1pOKbtnYtO+2U0=
MIME-Version: 1.0
In-Reply-To: <4b65142a-cf3b-05d7-d66b-018ff8da7ccc@gmail.com>
References: <0000000000006d7517056c911740@google.com> <4b65142a-cf3b-05d7-d66b-018ff8da7ccc@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 20 May 2018 16:26:03 +0800
Message-ID: <CADvbK_e7LXc7minSmaPw6iZvjWo215wG-pPAS0gr58+-VxUO7Q@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in is_bpf_text_address
To: Eric Dumazet <eric.dumazet@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: syzbot <syzbot+3dcd59a1f907245f891f@syzkaller.appspotmail.com>,
        ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 11:57 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> SCTP experts, please take a look.
>
> On 05/19/2018 08:55 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    73fcb1a370c7 Merge branch 'akpm' (patches from Andrew)
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1462ec0f800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3dcd59a1f907245f891f
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1079cf8f800000
Thank you.
The Reproducer is more than helpful.

setsockopt$inet_sctp6_SCTP_RTOINFO(r0, 0x84, 0x0,
&(0x7f0000000140)={0x0, 0x6, 0x7, 0x4}, 0x10)

It set rto_min=6 and rto_max=7, these are too small values.
t3_rtx timer works fine with it. But hb_timer will get stuck there, as
in its timer handler it starts this timer again with this value, then
it goes to the timer handler again...

HB has to repeat this and the hb timer's expire may also have to use
'trans->rto >> 1 ...' stuff. But we can limit the RTO's min value, like
HZ/20, which is 'Try again later.' number used when sock lock is
owned by others in all timer handlers.
