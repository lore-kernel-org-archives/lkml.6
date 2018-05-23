Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeEWKT7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:19:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:47331 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbeEWKT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:19:57 -0400
To: pmladek@suse.com
Cc: sergey.senozhatsky.work@gmail.com, dvyukov@google.com,
        sergey.senozhatsky@gmail.com, syzkaller@googlegroups.com,
        rostedt@goodmis.org, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] printk: inject caller information into the body of message
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
        <20180511095004.GA6575@jagdpanzerIV>
        <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
        <20180517112135.GB20796@jagdpanzerIV>
        <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
In-Reply-To: <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
Message-Id: <201805231919.HID26586.VOHFQLFOFSJtOM@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Wed, 23 May 2018 19:19:55 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky wrote:
> On (05/17/18 20:21), Sergey Senozhatsky wrote:
> > Dunno...
> > For instance, can we store context tracking info as a extended record
> > data? We have that dict/dict_len thing. So may we can store tracking
> > info there? Extended records will appear on the serial console /* if
> > console supports extended data */ or can be read in via devkmsg_read().
> 
> Those extended records are already there for exactly the same
> reason - people want to attach a special context to printk() entries.
> See dev_vprintk_emit() and create_syslog_header(). So we can add more
> key/value data to that context. Sounds kinda-sorta reasonable.

Well, the context which I want is not special. It is common context (like
timestamp which is controlled via /sys/module/printk/parameters/time ) for
distinguishing/correlating concurrently printed messages.



Petr Mladek wrote:
> First, we should ask what we expect from this feature. Different
> information might be needed in different situations. In general,
> people might want to know:
> 
>   + CPUid even in task context

I don't think CPU id in task context is common context. Task context will
sleep and switch to different CPUs. It is special context which would help
for only specific cases.

>   + exact interrupt context (soft, hard, NMI)

I don't know whether it is worth printing. But if it is useful, printing
type of interrupt context using %c would be sufficient for the context
which I want.

>   + whether preemption or interrupts are enabled

I don't think preemption state is common context. It is special context
which would be explicitly printed by e.g. stall detection messages.

> 
> It still looks bearable. But what if people want more,
> e.g. context switch counts, task state, pending signals,
> mem usage, cgroup stuff.
> 

I don't think context switch counts, task state, pending signals are
common context. It is special context which would be explicitly printed
by e.g. thread dump messages.

But if people want special context like listed above, we can consider
specifying by bitmask (e.g. /proc/sys/kernel/sysrq ) or by string (e.g.
/proc/sys/kernel/core_pattern ).

> Is this information useful for all messages or only
> selected ones?

I think the context which I want is useful for all messages. Thus,
my patch controls it via /sys/module/printk/parameters/caller_info
as with /sys/module/printk/parameters/time .

> 
> Is it acceptable when message prefix is longer than, let's
> say 40 characters?

The context which I want won't become so long.

> 
> Is the extended output worth having even on slow consoles?

Netconsole is unique that amount of characters to transmit and delay
are not proportional. As long as a message fits within ethernet packet
size (nearly 1500 bytes, which is longer than LOG_LINE_MAX for printk()
operation), the delay for printing one character and printing multiple
characters would be almost same. Therefore, reducing frequency of
printk() operation by having an API for buffered printk() (e.g.
https://groups.google.com/forum/#!topic/linux.kernel/OnoXED88nQM
and https://patchwork.kernel.org/patch/9927385/ ) would help.

But for other consoles, always printing all extended records might
become a pain. Thus, I prefer that the context which I want and
contexts which people might want are treated separately.
By the way, having an API for buffered printk() will help avoiding

  pr_info("printk: continuation disabled due to ext consoles, expect more fragments in /dev/kmsg\n");

case anyway...
