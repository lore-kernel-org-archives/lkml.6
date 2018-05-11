Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeEKJRn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:17:43 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:44719 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeEKJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:17:41 -0400
X-Google-Smtp-Source: AB8JxZpZq3r7eDV16Cwc21j7r3nbhosP6wOrauQn5UCYzzoQun4CRawXDc+nQ+BMmlpUqailnZAqeSsFQm07FgAiZ1A=
MIME-Version: 1.0
In-Reply-To: <20180511062151.GA18160@jagdpanzerIV>
References: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
 <20180511014515.GA895@jagdpanzerIV> <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 11 May 2018 11:17:20 +0200
Message-ID: <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
Subject: Re: printk feature for syzbot?
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 8:21 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (05/11/18 11:38), Tetsuo Handa wrote:
>> >
>> > So you basically want to have one more con_msg_format_flags? Do
>> > you want to track a context which prints out a messages or the
>> > context which "generated" the message? A CPU/task that stores
>> > a logbuf entry - vprintk_emit() - is not always the same as the
>> > CPU/task that prints it to consoles - console_unlock().
>> >
>>
>> Well, below is the (partial) patch.
>
> Hi,
>
> Tetsuo, I will take a look a bit later, but at glance, there are several
> ways to achieve what you are trying to do. The first one is the way you
> did it - add additional buffer and make that context tracking info part of
> the message body. Another one would be to extend struct printk_log and add
> pid/cpu/flag there, which you then can convert into text in msg_print_text().
> So far we talked about extending printk_log. Yet another one could be - add
> vsprintf specifiers that would add pid/cpu/flag to the vsprintf-ed message.
> You then can re-define pr_fmt, for instance, in the code you want to track
> pr_fmt "%zZ" fmt, or somehow force printk to add that "%zZ" to every
> message.


For syzbot perspective, yes, we can set any necessary additional
configs, add cmdline arguments, etc.

Manually changing format strings won't work -- bugs are all over the place.

>From what I see, it seems that interrupts can be nested:

https://syzkaller.appspot.com/bug?id=72eddef9cedcf81486adb9dd3e789f0d77505ba5
https://syzkaller.appspot.com/bug?id=66fcf61c65f8aa50bbb862eb2fde27c08909a4ff

Will this in_nmi()/in_irq()/in_serving_softirq()/else be enough to
untangle output printed by such nested interrupts? For the first link
it seems that they both are the same type of interrupt --
apic_timer_interrupt.
