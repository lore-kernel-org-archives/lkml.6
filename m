Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeDPMFs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:05:48 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:42628 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeDPMFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:05:47 -0400
X-Google-Smtp-Source: AIpwx4/+73/V9h7KuC253EUsTXxc3XPsVJ3fC5lD9YwgR9iyQYNbKpJP0K1d3g/vNC1JvoPoaMJZW0ti00VtnRtHQzU=
MIME-Version: 1.0
In-Reply-To: <201804150026.CFD57853.tHJOFLOSFOMVFQ@I-love.SAKURA.ne.jp>
References: <87bdec75-3c59-6587-2436-1470263ab11f@kernel.dk>
 <59a08949-7e2f-42ff-edda-f24a6c624551@I-love.SAKURA.ne.jp>
 <CACT4Y+a-_Z69xmLypVi=vrtCEEBGp=zy0Wp8SuLJzYtZ_ShBgw@mail.gmail.com>
 <201804102204.BDF48937.LMHJVFOFFOOSQt@I-love.SAKURA.ne.jp>
 <CACT4Y+Z0+r+JknT3uYWbjQ36XrSWfYnVkGYcj6FZ0RvgiCF0Yg@mail.gmail.com> <201804150026.CFD57853.tHJOFLOSFOMVFQ@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Apr 2018 14:05:25 +0200
Message-ID: <CACT4Y+Y7EXgKz4yaz-n9c3mbHQ4G1Q6cm2EoKwi3cwXsf5SPAw@mail.gmail.com>
Subject: Re: INFO: task hung in __blkdev_get
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        syzbot
        <bot+48594378e9851eab70bcd6f99327c7db58c5a28a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 5:26 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> OK. The patch was sent to linux.git as commit 1e047eaab3bb5564.
>
> #syz fix: block/loop: fix deadlock after loop_set_status
>
> Dmitry Vyukov <dvyukov@google.com>" wrote:
>> On Tue, Apr 10, 2018 at 3:04 PM, Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> > Dmitry Vyukov wrote:
>> >> On Tue, Apr 10, 2018 at 12:55 PM, Tetsuo Handa
>> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> >> > Hello.
>> >> >
>> >> > Since syzbot is reporting so many hung up bug which involves /dev/loopX ,
>> >> > is it possible to "temporarily" apply below patch for testing under syzbot
>> >>
>> >> Unfortunately it's not possible, for full explanation please see:
>> >> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches
>> >>
>> >
>> > I mean, sending custom patch to linux.git for -rc and revert the custom patch
>> > before -final is released. It won't take so much period until we get the result.
>>
>> Ah, I see, then I guess it wasn't a question to me.
>>
> I noticed that there already is the lockdep report at
>
>   possible deadlock in blkdev_reread_part
>   https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
>
> entry, and no patch is proposed yet:
>
>   https://groups.google.com/forum/#!msg/syzkaller-bugs/2Rw8-OM6IbM/SI4DyK-1AQAJ

If it's lock inversion, I wonder why there were no lockdep report
before "task hung" report...
Various assorted "task hung" reports seems to be plague for syzbot at
the moment. Lockdep reports should be way more actionable based solely
on the inversion report.
