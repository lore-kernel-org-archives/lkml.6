Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeDFNMJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:12:09 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41447 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752685AbeDFNMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:12:08 -0400
X-Google-Smtp-Source: AIpwx4/M69lb/XD/0qFfnUmS4fhdZD1jW++20AKdLHZwmkS0bpof3jE8KmxCbKfg7272mQTZYRze4Q==
Subject: Re: [PATCH v4 8/9] vsprintf: Prevent crash when dereferencing invalid
 pointers
To: Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-9-pmladek@suse.com>
 <f5fd81ea-99ab-29ac-a176-87ca8c4a754d@rasmusvillemoes.dk>
 <20180406122635.7ow2e2dgo6lqjopp@pathway.suse.cz>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0a4f396f-1963-c723-7e4a-618b456210b6@rasmusvillemoes.dk>
Date: Fri, 6 Apr 2018 15:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406122635.7ow2e2dgo6lqjopp@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-06 14:26, Petr Mladek wrote:
> On Thu 2018-04-05 16:46:23, Rasmus Villemoes wrote:
>> On 2018-04-04 10:58, Petr Mladek wrote:
>>
>>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>>> index 3551b7957d9e..1a080a75a825 100644
>>> --- a/lib/vsprintf.c
>>> +++ b/lib/vsprintf.c
>>> @@ -599,12 +599,46 @@ char *__string(char *buf, char *end, const char *s, struct printf_spec spec)
>>>  	return widen_string(buf, len, end, spec);
>>>  }
>>>  
>>> + /*
>>> +  * This is not a fool-proof test. 99% of the time that this will fault is
>>> +  * due to a bad pointer, not one that crosses into bad memory. Just test
>>> +  * the address to make sure it doesn't fault due to a poorly added printk
>>> +  * during debugging.
>>> +  */
>>> +static const char *check_pointer_access(const void *ptr)
>>> +{
>>> +	char byte;
>>> +
>>> +	if (!ptr)
>>> +		return "(null)";
>>> +
>>> +	if (probe_kernel_address(ptr, byte))
>>> +		return "(efault)";
>>> +
>>> +	return NULL;
>>> +}
>>
>> So while I think the WARNings are mostly pointless for the bad format
>> specifiers, I'm wondering why an averted crash is not worth a
>> WARN_ONCE?
> 
> It is used to match the error with the code. It was more explained in
> the other mail.

Yes, I agree that _if_ we want to trigger some action rather than just
gracefully handling a bogus %pXYZ by printing nothing, it must include a
backtrace to be useful, and not just some pr_warn. I'm just doubting
whether it is worth the code size increase - especially if we'd want to
be _consistent_ and then also warn about %phq and %pISaa and %pbm and
all the other cases where we do not check the trailing letters for
making sense. So maybe a WARN for a 'toplevel' %p* makes sense, but I'd
rather rely on static analysis for the rest and remove WARN_ONCE in
flags_string than introducing a myriad new WARN_ONCEs.

> 
>> This means there's an actual bug somewhere, probably even exploitable,
>> but we're just silently producing some innocent string...
> 
> Good point! It would make sense in many situations, especially when
> we "silently" crashed so far.
> 
> I just wonder if some code already relies on the fact that passing
> NULL is rather innocent, for example, in some timer- or networking-
> related debug output. This change might make it hard to read.

Yeah, I would also just WARN in the case where we get to
probe_kernel_address and fails that. That's why it should be in
check_pointer_access where we can distinguish, and not in its caller.

But I think string() still needs to allow not just NULL but the full
first page (mapping that to "(null)" as it used to), so that doesn't
change the need for string to special-case that before calling
valid_pointer_access.

>> Also, I'd still prefer to insist on ptr being a kernel pointer. Sure,
>> for %ph userspace gets to print their own memory, but for a lot of the
>> others, we're chasing pointers another level, so if an attacker can feed
>> a user pointer to one of those, there's a trivial arbitrary read gadget.
>> We have lots of printks in untested error paths, and I find it quite
>> likely that one of those uses a garbage pointer.
>>
>> I know you're mostly phrasing this in terms of preventing a crash, but
>> it seems silly not to close that when it only costs a pointer comparison.
> 
> I thought that it was good idea but Steven was against, see
> https://lkml.kernel.org/r/20180315130612.4b4cd091@vmware.local.home

I know. If he has veto power, so be it.

>> You're also missing the %pD (struct file*) case, which is one of those
>> double-pointer chasing cases.
> 
> I wanted to keep the initial code simple. Well, %pD is pretty
> straightforward, I could move the check to the cycle in v5.
> 
> I just want to avoid a monster patchset that would add the check
> for every read byte. I am not persuaded that it is worth it.

No, we most definitely do not want to read every byte with
probe_kernel_read, vsnprintf() is used far too widely for that. I think
checking that the initial pointer points to valid memory is a fine
heuristic. I'm just saying that that is then precisely what we should
do, and %pD does a dereference before we get to dentry_name. (And ok, if
we then end up doing another check due to reuse of the %pd code, fine).

Rasmus
