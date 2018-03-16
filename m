Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeCPPSs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:18:48 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44928 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbeCPPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:18:46 -0400
X-Google-Smtp-Source: AG47ELuQZ8Z1+r+sEIVRURs2bF6pxkDUIXYZJPrK1VCOoUtyyVVn649sA4evhEeE/uZN5C65vphLMM/A/9soyf95mHY=
MIME-Version: 1.0
In-Reply-To: <20170714142900.1c91949c@gandalf.local.home>
References: <1500044315-9508-1-git-send-email-francis.deslauriers@efficios.com>
 <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com> <20170714142900.1c91949c@gandalf.local.home>
From: Francis Deslauriers <francis.deslauriers@efficios.com>
Date: Fri, 16 Mar 2018 11:18:25 -0400
X-Google-Sender-Auth: 9OIzml_Y2Xarfo3p1lbnJnj7Oy0
Message-ID: <CADcCL0i_Rw9dRkrTUXiVK4dXOXD6QsRrBRc_pJ3XB_SyEqPR5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] kprobe: fix: Add ftrace_ops_assist_func to kprobe blacklist
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

I completely forgot about this issue until recently when I encountered it again.
Instrumenting the ftrace_ops_assist_func symbol and some other symbol
seems to be causing problems.

Placing kretprobes like in the following configuration crashes my
kernel (4.16.0-rc5) on a Qemu/KVM virtual machine:

config 1:
echo "r:event_1 __fdget" >> kprobe_events
echo "r:event_2 ftrace_ops_assist_func" >> kprobe_events

config 2:
echo "r:event_1 __fdget_pos" >> kprobe_events
echo "r:event_2 ftrace_ops_assist_func" >> kprobe_events

config 3:
echo 'r:event_1 arch_dup_task_struct' >> kprobe_events
echo 'r:event_2 ftrace_ops_assist_func' >> kprobe_events

config 4:
echo 'r:event_1 sys_open' >> kprobe_events
echo 'r:event_2 ftrace_ops_assist_func' >> kprobe_events

Here is my kernel config [1]:

In a previous email [2], you mentioned that you would like to add the
ftrace-related symbols to a section to un-blacklist them all at once
on demand but wanted to discuss it at Linux Plumbers. Do you still
think that it's the right approach?

I can easily test any patch regarding this issue.

[1] http://paste.ubuntu.com/p/BJWvgMnW8z/
[2] https://lkml.org/lkml/2017/7/14/568

Thank you,

2017-07-14 14:29 GMT-04:00 Steven Rostedt <rostedt@goodmis.org>:
> On Fri, 14 Jul 2017 10:58:35 -0400
> Francis Deslauriers <francis.deslauriers@efficios.com> wrote:
>
>> This function is called when a kprobe is hit. Thus it should be
>> blacklisted to prevent kprobe to be triggered by kprobes.
>>
>> Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
>> ---
>>  kernel/trace/ftrace.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index b308be3..c473d9b 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -36,6 +36,7 @@
>>
>>  #include <trace/events/sched.h>
>>
>> +#include <asm/kprobes.h>
>>  #include <asm/sections.h>
>>  #include <asm/setup.h>
>>
>> @@ -5739,6 +5740,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
>>       preempt_enable_notrace();
>>       trace_clear_recursion(bit);
>>  }
>> +NOKPROBE_SYMBOL(ftrace_ops_assist_func);
>
> Continuing from what I said in the other email, this is fixing a
> symptom and not the problem. The real fix will be much more involved. I
> have a good idea on how to accomplish it too.
>
> -- Steve
>
>
>>
>>  /**
>>   * ftrace_ops_get_func - get the function a trampoline should call
>



-- 
Francis Deslauriers
Software developer
EfficiOS inc.
