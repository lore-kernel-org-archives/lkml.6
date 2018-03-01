Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966628AbeCAIvq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:51:46 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39054 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965940AbeCAIvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:51:44 -0500
X-Google-Smtp-Source: AG47ELuBk8vGg8rGtnoY88n1rCQWwlZba9H00SyxvcJiM5yrj5zTSe1vKPmpVrW82yofOjuc1Nisoy6sOX/ClwUJnwc=
MIME-Version: 1.0
In-Reply-To: <20180301013722.GA6763@tigerII.localdomain>
References: <20180224053405.ksymb5yurtpwmfs6@shao2-debian> <20180228102334.65iqne6lu5faan52@pathway.suse.cz>
 <20180228155941.34z45rjz3bjqde7w@pathway.suse.cz> <20180301013722.GA6763@tigerII.localdomain>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 1 Mar 2018 09:51:22 +0100
Message-ID: <CACT4Y+ZUDu588gwgCbqru5D1RD5C+s3+E5ydhP7h9RoCjwQWJw@mail.gmail.com>
Subject: Re: [lkp-robot] [printk] c162d5b433: BUG:KASAN:use-after-scope_in_c
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, kernel test robot <shun.hao@intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 2:37 AM, Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
> Hello,
>
> Cc-ing Dmitry Vyukov and kasan-dev on this.
>
> On (02/28/18 16:59), Petr Mladek wrote:
> [..]
>> > >
>> > > [    0.003333] BUG: KASAN: use-after-scope in console_unlock+0x185/0x960
>> > > [    0.003333] BUG: KASAN: use-after-scope in console_unlock+0x185/0x960
>> >
>> > Is there any change to get disassembly of console_unlock() from the
>> > problematic build?
>> >
>> > I have troubles to reproduce this myself. Also I was not able to find any
>> > bug just by looking into the code yet. The disassembly might help
>> > a lot here.
>> >
>> >
>> > Interesting symptoms (for myself and other debuggers):
>> >
>> > The lines are duplicated. Therefore it happened when real
>> > console was registered and before the early console was unregistered.
>> > See also the full dmesg for these actions. The related printk messages
>> > are right after the KASAN report.
>> >
>> > I wonder if it is unsafe to pass the console_lock via
>> > console_trylock_spinnning() from console_unlock() called
>> > in register_console(). I do not see any problem but I might
>> > be blind.
>
> I'm not sure it we actually have concurrent printks at that state yet,
> might be too early for any printk offloading. The backtrace still
> makes no sense to me at all, tho. We had this report twice, probably,
> already (even before the offloading patchset, if I'm not mistaken).
>
> https://marc.info/?l=linux-kernel&m=151200883525299
>
> [..]
>> I feel lost a bit.
>
> Yeah... can't understand what's going on there.
>
> The last time kasan didn't like this part
>
> [    0.003333]  ? console_unlock+0x605/0xcc0:
>                               atomic_read at arch/x86/include/asm/atomic.h:27
>                                (inlined by) static_key_count at include/linux/jump_label.h:191
>                                (inlined by) static_key_false at include/linux/jump_label.h:201
>                                (inlined by) trace_console_rcuidle at include/trace/events/printk.h:10
>                                (inlined by) call_console_drivers at kernel/printk/printk.c:1556
>                                (inlined by) console_unlock at kernel/printk/printk.c:2233
>
> complaining that there was a write of size 4... at atomic_read().

Hi Sergey,

Where is that report?
I doubt that KASAN has instrumented a read as a write (at least there
are no such known cases), so perhaps it's pointing to some other
memory access.


> Now it's reporting that the write of size 1 was out of scope.
>
>> I am really curious what code is proceed on the line
>> console_unlock+0x185/0x960.
>
> Agreed.
>
> On my system 0x185/0x960 is somewhere around
>
>
>      191e:       89 d7                   mov    %edx,%edi
>      1920:       e8 06 e7 ff ff          callq  2b <log_next>
>      1925:       48 89 2d 00 00 00 00    mov    %rbp,0x0(%rip)        # 192c <console_unlock+0x17f>
>      192c:       89 05 00 00 00 00       mov    %eax,0x0(%rip)        # 1932 <console_unlock+0x185>
>>>   1932:       eb a9                   jmp    18dd <console_unlock+0x130>
>      1934:       8b 35 00 00 00 00       mov    0x0(%rip),%esi        # 193a <console_unlock+0x18d>
>      193a:       b9 00 04 00 00          mov    $0x400,%ecx
>      193f:       4c 89 ef                mov    %r13,%rdi
>      1942:       31 ed                   xor    %ebp,%ebp

For a KASAN report IP must point to one of __asan_[report_]load/store function.

> That jmp 18dd after log_next() is a `goto skip' in
> suppress_message_printing() branch
>
> skip:
>                 if (console_seq == log_next_seq)
>                         break;
>
>                 msg = log_from_idx(console_idx);
>                 if (suppress_message_printing(msg->level)) {
>                         /*
>                          * Skip record we have buffered and already printed
>                          * directly to the console when we received it, and
>                          * record that has level above the console loglevel.
>                          */
>                         console_idx = log_next(console_idx);
>                         console_seq++;
>>>                      goto skip;
>                 }
>
>
> As far as I can tell.
>
>         -ss
