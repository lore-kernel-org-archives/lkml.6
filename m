Return-Path: <daniel.vetter@ffwll.ch>
ARC-Seal: i=1; a=rsa-sha256; t=1521822378; cv=none;
        d=google.com; s=arc-20160816;
        b=I0i6riyCzzR4WKsE2sDZAF8qA9KidMJohtDiKkYcbPodxUNkvp8SrFkHNWCSHmANWE
         oUhjESmV05HrEG1fDTi7CjJQh4I5ypAJkIJ7GpLz9FFmr74sESj9GC5jLHiw4PBYDJ5b
         0/r/7lrP8/yn7lb9kUNulPb6InKr0BGkktxcUrxkFAG1pCBIEOamu58C/rb29wJNbbiV
         DvTfl5WBtsJT0plqihnNYfdWppLAKFjINKw3NczHtqMPexYKXJUSn/nPh3rmWUeDcjon
         YcVrM8QbFWO/PuFv00F8kOiaiZmINz3i04hQI7c9BzG/Ys/yEFTwdxkS/xg7FMtnVxNm
         NVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mu3IM1dpXjw8PIKlPMlVOY/FoR6oOsUlvktwB+kK30c=;
        b=qTMflGsTWKFCmfQe0UbXBgTnIkgxiHWGnPW8vIrPTnV93Qs4cdtw+4ou//Awk5LpsM
         iLMkKuM4Xoloxb4hUbYuBOh0ZcP3otQI84p3WFr2r0U8+90bir8hkAGedF/TyDxT2Rai
         QH6XJvB2UYE1ddHBK8KZwuY9HWEhK95jrDbW0a5quliEv8TkmJT/w2D9SpmAQ49cxOdT
         CLSYBPeoB0RIfVVq+cVD/8EYRaFN/nJ6ujjkNex4A/l2Rnno8amY4qMo1dbR8aJmTPtN
         j8aYuP28DEd0svhsmv0HDxXfIE50AS+iei/vF3Ru3QmD+m4/M4UjsAGHAvB1BBdxOMbn
         bgxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=EOFdwDnk;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of daniel.vetter@ffwll.ch) smtp.mailfrom=daniel.vetter@ffwll.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=EOFdwDnk;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of daniel.vetter@ffwll.ch) smtp.mailfrom=daniel.vetter@ffwll.ch
X-Google-Smtp-Source: AIpwx4+uHGD/iJ+E3QPa0NkyAxK0zFW/XxQgYXpoGqe5RCcE+KSgwWYVK0WOqxa4t11wrnSla/IIz5oSSP71b9tSQgM=
MIME-Version: 1.0
X-Originating-IP: [212.51.149.109]
In-Reply-To: <alpine.DEB.2.21.1803201929340.1714@nanos.tec.linutronix.de>
References: <20180320160258.11381-1-daniel.vetter@ffwll.ch> <alpine.DEB.2.21.1803201929340.1714@nanos.tec.linutronix.de>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 23 Mar 2018 17:26:17 +0100
Message-ID: <CAKMK7uG7tFoCHk=enLh84GGMta_JSqY_mRrEiYqub-BfydyxAA@mail.gmail.com>
Subject: Re: [PATCH] RFC: debugobjects: capture stack traces at _init() time
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>, Waiman Long <longman@redhat.com>,
	Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595473170470511522?=
X-GMAIL-MSGID: =?utf-8?q?1595746422092831325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 8:44 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 20 Mar 2018, Daniel Vetter wrote:
>
>> Sometimes it's really easy to know which object has gone boom and
>> where the offending code is, and sometimes it's really hard. One case
>> we're trying to hunt down is when module unload catches a live debug
>> object, with a module with lots of them.
>>
>> Capture a full stack trace from debug_object_init() and dump it when
>> there's a problem.
>>
>> FIXME: Should we have a separate Kconfig knob for the backtraces,
>> they're quite expensive? Atm I'm just selecting it for the general
>> debug object stuff.
>
> Just make it boot time enabled. We really want to be able to switch it off.
>
>> +#define ODEBUG_STACKDEPTH 32
>
> Do we really need it that deep? I doubt that.

Entirely arbitrary, I just needed this to start hunting a rare crash
we're seeing in CI and stitched something together. I agree we
probably don't need that much.

>> +static noinline depot_stack_handle_t save_stack(struct debug_obj *obj)
>> +{
>> +     unsigned long entries[ODEBUG_STACKDEPTH];
>> +     struct stack_trace trace = {
>> +             .entries = entries,
>> +             .max_entries = ODEBUG_STACKDEPTH,
>> +             .skip = 2
>> +     };
>> +
>> +     save_stack_trace(&trace);
>> +     if (trace.nr_entries != 0 &&
>> +         trace.entries[trace.nr_entries-1] == ULONG_MAX)
>> +             trace.nr_entries--;
>> +
>> +     /* May be called under spinlock, so avoid sleeping */
>> +     return depot_save_stack(&trace, GFP_NOWAIT);
>
> I really don't like the idea of unconditional allocations in that code
> path. We went great length to make it perform halfways sane with the
> pool. Though we should actually have per cpu pools to avoid the lock
> contention, but thats a different problem.
>
> I'd rather make the storage a fixed size allocation which is appended
> to the debug object. Something like this:
>
> struct debug_obj_trace {
>         struct stack_trace      trace;
>         unsigned long           entries[ODEBUG_STACKDEPTH];
> };
>
> struct debug_obj {
>         unsigned int            astate;
>         void                    *object;
>         struct debug_obj_descr  *descr;
>         struct debug_obj_trace  trace[0];
> };
>
> void __init debug_objects_mem_init(void)
> {
>         unsigned long objsize = sizeof (struct debug_obj);
>
>         if (!debug_objects_enabled)
>                 return;
>
>         if (debug_objects_trace_stack)
>                 objsize += sizeof(struct debug_obj_trace);
>
>         obj_cache = kmem_cache_create("debug_objects_cache", objsize, 0,
>                                       SLAB_DEBUG_OBJECTS, NULL);
>
> __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
> {
>         ....
>         case ODEBUG_STATE_NONE:
>         case ODEBUG_STATE_INIT:
>         case ODEBUG_STATE_INACTIVE:
>                 if (debug_object_trace_stack) {
>                         obj->trace[0].trace.entries = obj->trace[0].entries;
>                         save_stack_trace(&trace[0].trace);
>                 }
>
> That means we need to size the static objects which are used during early
> boot with stack under the assumption that stack tracing is enabled, but
> that's simple enough.
>
> Hmm?

Yeah looks reasonable, and gives us an easy Kconfig/boot-time option
to enable/disable it. I'm a bit swamped, but I'll try to respin.
Thanks very much for the look and suggesting a cleaner integration
approach - the allocations and recursion into the stack depot really
did not result in clean code.

Thanks, Daniel

> Thanks,
>
>         tglx



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
