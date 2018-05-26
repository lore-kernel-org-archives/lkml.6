Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031183AbeEZGg7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 02:36:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35700 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932664AbeEZGg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 02:36:57 -0400
X-Google-Smtp-Source: AB8JxZpPcQwwv9W42yPLvD7GLd7v8h/tk2h+uSS+vLFxpJdHgKP6aqZdZGXBb1W0hXuIkRwKoSqTQEbyF9SQGhzn8jQ=
MIME-Version: 1.0
In-Reply-To: <20180524021451.GA23443@jagdpanzerIV>
References: <20180511014515.GA895@jagdpanzerIV> <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV> <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV> <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV> <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 26 May 2018 08:36:36 +0200
Message-ID: <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of message
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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

On Thu, May 24, 2018 at 4:14 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>> First, we should ask what we expect from this feature.
>
> Yeah. Can't really comment on this, it's up to Tetsuo and Dmitry to
> decide. So far I've seen slightly different requirements/expectations.

The root problem is that it's not possible to make sense out of kernel
output if message takes more than 1 line (or output non-atomically
with several printk's) because of intermixed output from several
tasks/interrupts/etc. For example, it's not generally possible to
recover crash stack trace, because one gets random mix of frames.
Humans usually, but not always, can restore most of the sense. So the
goal is to make this ought-to-be-simple task actually simple and not
requiring human intelligence and time each time.

Prefixing each line with task/cpu/interrupt context should do the
trick as it will be possible to split kernel output into multiple
independent streams and analyze them independently.

In our context (syzbot testing) we can enable an additional config,
and adopt parser to understand additional line prefix. But I don't
know how prefixing lines fits into a larger picture. Does it make
sense to thought out a potential extension story for this format? E.g.
user specifies set of extension records that are dumped before each
line, and then can unambiguously parse them? I guess some
consoles/interfaces will never be extended to provide access to the
extension records, so it can make sense to make them accessible in
text format too (optionally).
