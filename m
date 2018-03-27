Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeC0N17 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:27:59 -0400
Received: from mail.efficios.com ([167.114.142.138]:43596 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbeC0N16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:27:58 -0400
Date: Tue, 27 Mar 2018 09:27:56 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: joel opensrc <joel.opensrc@gmail.com>
Cc: rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Message-ID: <213641788.1071.1522157276112.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAEi0qN=zSWqH0U0pTg-c31vk+xXFbddzSniJG6sudjuaMk9kVQ@mail.gmail.com>
References: <20180326191031.14939-1-mathieu.desnoyers@efficios.com> <CAEi0qN=zSWqH0U0pTg-c31vk+xXFbddzSniJG6sudjuaMk9kVQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tracepoint: Provide tracepoint_kernel_find_by_name
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: tracepoint: Provide tracepoint_kernel_find_by_name
Thread-Index: 78HM63lIG9uPPNkA19YHCcJKCELHUw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 26, 2018, at 9:35 PM, joel opensrc joel.opensrc@gmail.com wrote:

> Hi Mathieu,

Hi Joel,

> 
> On Mon, Mar 26, 2018 at 12:10 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> Provide an API allowing eBPF to lookup core kernel tracepoints by name.
>>
>> Given that a lookup by name explicitly requires tracepoint definitions
>> to be unique for a given name (no duplicate keys), include a
>> WARN_ON_ONCE() check that only a single match is encountered at runtime.
>> This should always be the case, given that a DEFINE_TRACE emits a
>> __tracepoint_##name symbol, which would cause a link-time error if more
>> than one instance is found. Nevertheless, check this at runtime with
>> WARN_ON_ONCE() to stay on the safe side.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Steven Rostedt <rostedt@goodmis.org>
>> CC: Alexei Starovoitov <ast@kernel.org>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Ingo Molnar <mingo@kernel.org>
>> ---
>>  include/linux/tracepoint.h |  1 +
>>  kernel/tracepoint.c        | 35 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>> index c94f466d57ef..1b4ae64b7c6a 100644
>> --- a/include/linux/tracepoint.h
>> +++ b/include/linux/tracepoint.h
>> @@ -43,6 +43,7 @@ tracepoint_probe_unregister(struct tracepoint *tp, void
>> *probe, void *data);
>>  extern void
>>  for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
>>                 void *priv);
>> +extern struct tracepoint *tracepoint_kernel_find_by_name(const char *name);
>>
>>  #ifdef CONFIG_MODULES
>>  struct tp_module {
>> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
>> index 671b13457387..0a59f988055a 100644
>> --- a/kernel/tracepoint.c
>> +++ b/kernel/tracepoint.c
>> @@ -60,6 +60,11 @@ struct tp_probes {
>>         struct tracepoint_func probes[0];
>>  };
>>
>> +struct tp_find_args {
>> +       const char *name;
>> +       struct tracepoint *tp;
>> +};
>> +
>>  static inline void *allocate_probes(int count)
>>  {
>>         struct tp_probes *p  = kmalloc(count * sizeof(struct tracepoint_func)
>> @@ -528,6 +533,36 @@ void for_each_kernel_tracepoint(void (*fct)(struct
>> tracepoint *tp, void *priv),
>>  }
>>  EXPORT_SYMBOL_GPL(for_each_kernel_tracepoint);
>>
>> +static void find_tp(struct tracepoint *tp, void *priv)
>> +{
>> +       struct tp_find_args *args = priv;
>> +
>> +       if (!strcmp(tp->name, args->name)) {
>> +               WARN_ON_ONCE(args->tp);
>> +               args->tp = tp;
> 
> I think this runtime check is not needed if it really can't happen
> (linker verifies that already as you mentioned) although I'm not
> opposed if you still want to keep it, because there's no way to break
> out of the outer loop anyway so I guess your call..

We can change the outer loop and break from it if needed, that's not
an issue.

> I would just do:
> 
> if (args->tp)
>    return;
> 
> if find_tp already found the tracepoint.
> 
> Tried to also create a duplicate tracepoint and I get:
>  CC      init/version.o
>  AR      init/built-in.o
>  AR      built-in.o
>  LD      vmlinux.o
> block/blk-core.o:(__tracepoints+0x440): multiple definition of
> `__tracepoint_sched_switch'
> kernel/sched/core.o:(__tracepoints+0x440): first defined here
> Makefile:1032: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1

Yeah, as I state in my changelog, I'm very well aware that the linker
is able to catch those. This was the purpose of emitting a
__tracepoint_##name symbol in the tracepoint definition macro. This
WARN_ON_ONCE() is a redundant check for an invariant that we expect
is provided by the linker. Given that it's not a fast path, I would
prefer to keep this redundant check in place, given that an average
factor 2 speedup on a slow path should really not be something we
need to optimize for. IMHO, for slow paths, robustness is more important
than speed (unless the slow path becomes so slow that it really affects
the user).

I envision that a way to break this invariant would be to compile a
kernel object with gcc -fvisibility=hidden or such. I admit this is
particular scenario is really far fetched, but it illustrates why I
prefer to keep an extra safety net at runtime for linker-based
validations when possible.

If a faster tracepoint lookup function is needed, we should consider
perfect hashing algorithms done post-build, but so far nobody has
complained about speed of this lookup operation. Anyhow a factor 2 in
the speed of this lookup should really not matter, right ?

Thanks,

Mathieu

> 
> For this senseless diff:
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 81b43f5bdf23..2b855c05197d 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -49,6 +49,13 @@ DEFINE_EVENT(block_buffer, block_touch_buffer,
>        TP_ARGS(bh)
> );
> 
> +DEFINE_EVENT(block_buffer, sched_switch,
> +
> +       TP_PROTO(struct buffer_head *bh),
> +
> +       TP_ARGS(bh)
> +);
> +
> /**
>  * block_dirty_buffer - mark a buffer dirty
>  * @bh: buffer_head being dirtied
> 
> 
> thanks,
> 
> - Joel

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
