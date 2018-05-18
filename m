Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeERM0Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:26:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44029 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeERM0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:26:19 -0400
X-Google-Smtp-Source: AB8JxZoBdSt2J8HzH9TZvdPy/O8hUSuqJFHAxOCal82HP+jFZJmGm35wGbCaP4uPZk9af/8VXuLCe13V+5DJpr2CSrI=
MIME-Version: 1.0
In-Reply-To: <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
References: <20180511014515.GA895@jagdpanzerIV> <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV> <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV> <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV> <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 18 May 2018 14:25:57 +0200
Message-ID: <CACT4Y+Zuiq3Ubmbq+ON9bLaxUy-tMdge1g=Tfvnjcru6oySvZg@mail.gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of message
To: Petr Mladek <pmladek@suse.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 2:15 PM, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2018-05-17 20:21:35, Sergey Senozhatsky wrote:
>> On (05/11/18 20:58), Tetsuo Handa wrote:
>> > @@ -1820,6 +1860,9 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
>> >                     return text_len;
>> >     }
>> >
>> > +   /* Inject caller info. */
>> > +   text = printk_inject_caller_info(text, &text_len);
>> > +
>> >     /* Store it in the record log */
>> >     return log_store(facility, level, lflags, 0, dict, dictlen, text, text_len);
>> >  }
>>
>> [..]
>>
>> I think this is slightly intrusive. I understand that you want to avoid
>> struct printk_log modification, let's try to see if we have any other
>> options.
>
> I agree with Sergey that it is intrusive. We should keep the
> information separate from the original string and format it
> according to the selected output format (syslog, /dev/kmsg,
> console) like we do it with the other metadata, e.g. timestamp,
> loglevel, dict).
>
>
>> Dunno...
>> For instance, can we store context tracking info as a extended record
>> data? We have that dict/dict_len thing. So may we can store tracking
>> info there? Extended records will appear on the serial console /* if
>> console supports extended data */ or can be read in via devkmsg_read().

What consoles do support it?
We are interested at least in qemu console, GCE console and Android
phone consoles. But it would be pity if this can't be used on various
development boards too.


>> Any other options?
>
> This sounds interesting. Well, we would need to handle different dict
> items different ways. I still wonder if we really need these "hacks".
>
> Another option would be to store the metadata into a separate table
> indexed by log_seq number. But it still look unnecessarily complicated.
>
> IMHO, we could change struct printk_log if we provide related
> patches for crashdump and crash utilities.
>
>
> Important:
>
> First, we should ask what we expect from this feature. Different
> information might be needed in different situations. In general,
> people might want to know:
>
>   + CPUid even in task context
>   + exact interrupt context (soft, hard, NMI)
>   + whether preemption or interrupts are enabled
>
> It still looks bearable. But what if people want more,
> e.g. context switch counts, task state, pending signals,
> mem usage, cgroup stuff.
>
> Is this information useful for all messages or only
> selected ones?
>
> Is it acceptable when message prefix is longer than, let's
> say 40 characters?
>
> Is the extended output worth having even on slow consoles?
>
>
> By other words, I wonder if you wanted similar feature in many
> situations in the past and could provide more use cases.
>
>
> Note:
>
> The proposed patch enabled the extra info with a config option
> => you need to rebuild the kernel => you could just modify
> the problematic message. We could just add some printk_ helpers
> to make it easier.
>
> Alternatively, I wonder if it might be enough to add a tracepoint
> into printk() and get the extra info via
> /sys/kernel/debug/tracing/events/. We would need to prevent
> recursion when trace buffer is flushed by printk() but...
>
> Best Regards,
> Petr
