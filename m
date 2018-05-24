Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935549AbeEXCPA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 22:15:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37414 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935126AbeEXCO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 22:14:56 -0400
X-Google-Smtp-Source: AB8JxZqT2K1jyuzjpfO5l32ZUMWHAo3OQqxx3xPL1nCgE2TN2fpnkSw2hkZik/WQzLFQzuTImdAtZQ==
Date: Thu, 24 May 2018 11:14:51 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        dvyukov@google.com, sergey.senozhatsky@gmail.com,
        syzkaller@googlegroups.com, rostedt@goodmis.org,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180524021451.GA23443@jagdpanzerIV>
References: <20180511014515.GA895@jagdpanzerIV>
 <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
 <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV>
 <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV>
 <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/18/18 14:15), Petr Mladek wrote:
> > Dunno...
> > For instance, can we store context tracking info as a extended record
> > data? We have that dict/dict_len thing. So may we can store tracking
> > info there? Extended records will appear on the serial console /* if
> > console supports extended data */ or can be read in via devkmsg_read().
> > Any other options?
> 
> This sounds interesting. Well, we would need to handle different dict
> items different ways. I still wonder if we really need these "hacks".

Well, it doesn't look like a complete hack. Extended records are there
exactly for the "this printk line came from context (device, subsystem) ABC"
type of thing. Those entries are multi-key/value already, we just can
add one more key/value pair. E.g. appending CONTEXT to already existing
SUBSYSTEM/DEVICE lines:

6,575,3130042,-;snd_hda_codec_generic hdaudioC1D0:    dig-out=0x4/0x5
 CONTEXT=4/99 PREEMPT=0/0/0/0
 SUBSYSTEM=hdaudio
 DEVICE=+hdaudio:hdaudioC1D

But I'm not pushing for this particular solution. It just looked
reasonable and very "cheap", as we don't break anything.

> 
> IMHO, we could change struct printk_log if we provide related
> patches for crashdump and crash utilities.

Yep.

> First, we should ask what we expect from this feature.

Yeah. Can't really comment on this, it's up to Tetsuo and Dmitry to
decide. So far I've seen slightly different requirements/expectations.

> Different information might be needed in different situations.
> In general, people might want to know:
> 
>   + CPUid even in task context
>   + exact interrupt context (soft, hard, NMI)

Agreed.

>   + whether preemption or interrupts are enabled

preemption and irqs are already disabled this far in printk() internals.

> It still looks bearable. But what if people want more,
> e.g. context switch counts, task state, pending signals,
> mem usage, cgroup stuff.

Right. Extended records [dicts] can be up to 8k each, so I'd say
that we can have as many key/value pairs as we want to.

> Is this information useful for all messages or only
> selected ones?

No idea :)

> Is it acceptable when message prefix is longer than, let's
> say 40 characters?

If we talk about embedding this info into normal message payload
then, yes, we better keep it as small as possible. Because we are
limited by LOG_LINE_MAX + PREFIX_MAX chars [~1024 bytes, if I recall
correctly], the more we steal for context info the less we have for
the message.

> Is the extended output worth having even on slow consoles?

My expectation was that syzkaller is mostly executed in qemu environment.
But if someone would want to run it on a device with a slow console, then
it might be painful.

> By other words, I wonder if you wanted similar feature in many
> situations in the past and could provide more use cases.

Sorry, can you explain a bit more?

> Note:
> 
> The proposed patch enabled the extra info with a config option
> => you need to rebuild the kernel => you could just modify
> the problematic message. We could just add some printk_ helpers
> to make it easier.

Yes. As far as I know syzkaller folks are completely fine with
the .config based solution and can rebuild the kernel as many times
as needed, modifying the kernel code, at the same time, is not an
option.

> Alternatively, I wonder if it might be enough to add a tracepoint
> into printk() and get the extra info via
> /sys/kernel/debug/tracing/events/.

Sounds good to me.

> We would need to prevent recursion when trace buffer is flushed by
> printk() but...

Agreed.

	-ss
