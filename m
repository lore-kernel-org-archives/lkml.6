Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeC0Pkr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:40:47 -0400
Received: from mail.efficios.com ([167.114.142.138]:49952 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeC0Pkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:40:46 -0400
Date: Tue, 27 Mar 2018 11:40:43 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: joel opensrc <joel.opensrc@gmail.com>
Cc: rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Message-ID: <1309108266.1183.1522165243976.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAEi0qNmn9p_PjAA49yZ_0AybN_3sbAPpbb1ngyiacAxLM79=6A@mail.gmail.com>
References: <20180326191031.14939-1-mathieu.desnoyers@efficios.com> <CAEi0qN=zSWqH0U0pTg-c31vk+xXFbddzSniJG6sudjuaMk9kVQ@mail.gmail.com> <213641788.1071.1522157276112.JavaMail.zimbra@efficios.com> <CAEi0qNmn9p_PjAA49yZ_0AybN_3sbAPpbb1ngyiacAxLM79=6A@mail.gmail.com>
Subject: Re: [RFC PATCH] tracepoint: Provide tracepoint_kernel_find_by_name
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: tracepoint: Provide tracepoint_kernel_find_by_name
Thread-Index: cLOX0hYWb0azVXH0x9HUA1oaFN1JHw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 27, 2018, at 11:28 AM, joel opensrc joel.opensrc@gmail.com wrote:

> On Tue, Mar 27, 2018 at 6:27 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> <snip>
>>>> +static void find_tp(struct tracepoint *tp, void *priv)
>>>> +{
>>>> +       struct tp_find_args *args = priv;
>>>> +
>>>> +       if (!strcmp(tp->name, args->name)) {
>>>> +               WARN_ON_ONCE(args->tp);
>>>> +               args->tp = tp;
>>>
>>> I think this runtime check is not needed if it really can't happen
>>> (linker verifies that already as you mentioned) although I'm not
>>> opposed if you still want to keep it, because there's no way to break
>>> out of the outer loop anyway so I guess your call..
>>
>> We can change the outer loop and break from it if needed, that's not
>> an issue.
>>
>>> I would just do:
>>>
>>> if (args->tp)
>>>    return;
>>>
>>> if find_tp already found the tracepoint.
>>>
>>> Tried to also create a duplicate tracepoint and I get:
>>>  CC      init/version.o
>>>  AR      init/built-in.o
>>>  AR      built-in.o
>>>  LD      vmlinux.o
>>> block/blk-core.o:(__tracepoints+0x440): multiple definition of
>>> `__tracepoint_sched_switch'
>>> kernel/sched/core.o:(__tracepoints+0x440): first defined here
>>> Makefile:1032: recipe for target 'vmlinux' failed
>>> make: *** [vmlinux] Error 1
>>
>> Yeah, as I state in my changelog, I'm very well aware that the linker
>> is able to catch those. This was the purpose of emitting a
>> __tracepoint_##name symbol in the tracepoint definition macro. This
>> WARN_ON_ONCE() is a redundant check for an invariant that we expect
>> is provided by the linker. Given that it's not a fast path, I would
>> prefer to keep this redundant check in place, given that an average
>> factor 2 speedup on a slow path should really not be something we
>> need to optimize for. IMHO, for slow paths, robustness is more important
>> than speed (unless the slow path becomes so slow that it really affects
>> the user).
>>
>> I envision that a way to break this invariant would be to compile a
>> kernel object with gcc -fvisibility=hidden or such. I admit this is
>> particular scenario is really far fetched, but it illustrates why I
>> prefer to keep an extra safety net at runtime for linker-based
>> validations when possible.
>>
>> If a faster tracepoint lookup function is needed, we should consider
>> perfect hashing algorithms done post-build, but so far nobody has
>> complained about speed of this lookup operation. Anyhow a factor 2 in
>> the speed of this lookup should really not matter, right ?
> 
> Yes, I agree with all the great reasons. So lets do it your way then.

Alexei proposed an alternative patch. I don't strongly mind one approach
or the other.

Thanks,

Mathieu

> 
> thanks,
> 
> - Joel

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
