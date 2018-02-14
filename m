Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030656AbeBNOAx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:00:53 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:40184 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030624AbeBNOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:00:28 -0500
X-Google-Smtp-Source: AH8x2278qq9LZ+US3L/EkXG2TTInmoxGwE8dWwWF5ifCWTAh3oWMPUCDzn0m64IWxM6JAMlpy6fqbNwjTY8ibzsEBCY=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YNSZQXy_V4QzjmOK+UJSihdQw8_yRu3A8GBMsCUSs_vQ@mail.gmail.com>
References: <001a11448f6c0346ec055c831a71@google.com> <20171027151137.GC3165@worktop.lehotels.local>
 <20171027153336.GC3857@worktop> <CACT4Y+YNSZQXy_V4QzjmOK+UJSihdQw8_yRu3A8GBMsCUSs_vQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 15:00:06 +0100
Message-ID: <CACT4Y+Ye-zXsWXN5rFB-LP-BWH6dd3c4wLVYWX5w7+0TndRe-w@mail.gmail.com>
Subject: Re: possible deadlock in perf_event_ctx_lock_nested
To: Peter Zijlstra <peterz@infradead.org>
Cc: syzbot
        <bot+f67ad450a4bd1e42a7bd09f592904b15be39db7a@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 4:04 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> > ======================================================
>>> > WARNING: possible circular locking dependency detected
>>> > 4.13.0-next-20170911+ #19 Not tainted
>>> > ------------------------------------------------------
>>> > syz-executor2/12380 is trying to acquire lock:
>>> >  (&ctx->mutex){+.+.}, at: [<ffffffff8180923c>]
>>> > perf_event_ctx_lock_nested+0x1dc/0x3c0 kernel/events/core.c:1210
>>> >
>>> > but task is already holding lock:
>>> >  (&pipe->mutex/1){+.+.}, at: [<ffffffff81ac0fa6>] pipe_lock_nested
>>> > fs/pipe.c:66 [inline]
>>> >  (&pipe->mutex/1){+.+.}, at: [<ffffffff81ac0fa6>] pipe_lock+0x56/0x70
>>> > fs/pipe.c:74
>>> >
>>> > which lock already depends on the new lock.
>>>
>>>
>>> ARRGH!!
>>>
>>> that translates like the below, which is an absolute maze and requires
>>> at least 5 concurrent callstacks, possibly more.
>>>
>>> We already had a lot of fun with hotplug-perf-ftrace, but the below
>>> contains more. Let me try and page that previous crap back.
>>>
>>>
>>>
>>>       perf_ioctl()
>>> #0      perf_event_ctx_lock()         [ctx->mutex]
>>>         perf_event_set_filter
>>> #1        ftrace_profile_set_filter   [event_mutex]
>>>
>>>
>>>
>>>
>>>       sys_perf_event_open
>>>         ...
>>>         perf_trace_init
>>> #1        mutex_lock [event_mutex]
>>>           trace_event_reg
>>>             tracepoint_probe_register
>>> #2            mutex_lock() [tracepoints_mutex]
>>>               tracepoint_add_func()
>>> #3              static_key_slow_inc() [cpuhotplug_lock]
>>>
>>>
>>>
>>>
>>>
>>>       cpuhp_setup_state_nocalls
>>> #3      cpus_read_lock        [cpuhotplug_lock]
>>>           __cpuhp_setup_state_cpuslocked
>>> #4          mutex_lock        [cpuhp_state_mutex]
>>>             cpuhp_issue_call
>>> #5            cpuhp_invoke_ap_callback()      [cpuhp_state]
>>>
>>>
>>> #5    cpuhp_invoke_callback [cpuhp_state]
>>>         ...
>>>           devtmpfs_create_node
>>> #6          wait_for_completion()     [&req.done]
>>>
>>>                                               devtmpfsd
>>>                                                 handle_create
>>> #7                                                filename_create [sb_writers]
>>> #6                                              complete [&req.done]
>>>
>>>
>>>
>>>
>>>
>>>
>>>       do_splice
>>> #7      file_start_write() [sb_writers]
>>>         do_splice_from
>>>           iter_file_splice_write
>>> #8          pipe_lock [pipe->mutex]
>>>
>>>
>>>
>>>
>>>
>>>       do_splice
>>> #8      pipe_lock     [pipe->mutex]
>>>         do_splice_to
>>>           ...
>>> #0          perf_read() [ctx->mutex]
>>>
>>
>> So arguably that last op, splice_read from a perf fd is fairly
>> pointless and we could dis-allow that. How about something like the
>> below?
>>
>> ---
>>  kernel/events/core.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 04989fb769f0..fd03f3082ee3 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -5468,6 +5468,13 @@ static int perf_fasync(int fd, struct file *filp, int on)
>>         return 0;
>>  }
>>
>> +static ssize_t perf_splice_read(struct file *file, loff_t *ppos,
>> +                               struct pipe_inode_info *pope, size_t len,
>> +                               unsigned int flags)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>> +
>>  static const struct file_operations perf_fops = {
>>         .llseek                 = no_llseek,
>>         .release                = perf_release,
>> @@ -5477,6 +5484,7 @@ static int perf_fasync(int fd, struct file *filp, int on)
>>         .compat_ioctl           = perf_compat_ioctl,
>>         .mmap                   = perf_mmap,
>>         .fasync                 = perf_fasync,
>> +       .splice_read            = perf_splice_read,
>>  };
>
>
> Another perf deadlock that involves splice:
> https://groups.google.com/d/msg/syzkaller-bugs/vVy6Zj3wPxo/6oj5U6WiAwAJ


Peter,

What's the status of this? Is your patch still relevant?
