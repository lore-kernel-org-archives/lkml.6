Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeERUjD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:39:03 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39008 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeERUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:39:00 -0400
X-Google-Smtp-Source: AB8JxZod+ylQ3UVmiFQDKB7Fy0twW2vEZhrWv0hnFL/SFbh4PIl8bXnPSIDPFBc7+VdD0B3+Gcz0uAQS6ssa468/BCM=
MIME-Version: 1.0
In-Reply-To: <b5e5e160-6ac7-87c8-af1a-4eb88f1f020d@embeddedor.com>
References: <20180515030038.GA11822@embeddedor.com> <20180515150859.1bccbd8d4543848b30fea859@linux-foundation.org>
 <alpine.DEB.2.21.1805160027260.1605@nanos.tec.linutronix.de>
 <CAPcyv4iksLzZ=eMjWw6Wi87F2OSXHd16gKRLExgGhx=Mdr+AwQ@mail.gmail.com>
 <50481b83-4c03-f354-bd11-cef7aecdd85f@embeddedor.com> <b5e5e160-6ac7-87c8-af1a-4eb88f1f020d@embeddedor.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 May 2018 13:38:58 -0700
Message-ID: <CAPcyv4iO67AG5ytc7gRBTnu6V8bdTOMb9eBwjGJtkGpMLKkpwg@mail.gmail.com>
Subject: Re: [PATCH] kernel: sys: fix potential Spectre v1
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 12:21 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
> On 05/18/2018 02:04 PM, Gustavo A. R. Silva wrote:
>>
>>
>>
>> On 05/15/2018 05:57 PM, Dan Williams wrote:
>>>
>>> On Tue, May 15, 2018 at 3:29 PM, Thomas Gleixner <tglx@linutronix.de>
>>> wrote:
>>>>
>>>> On Tue, 15 May 2018, Andrew Morton wrote:
>>>>>
>>>>> On Mon, 14 May 2018 22:00:38 -0500 "Gustavo A. R. Silva"
>>>>> <gustavo@embeddedor.com> wrote:
>>>>>
>>>>>> resource can be controlled by user-space, hence leading to a
>>>>>> potential exploitation of the Spectre variant 1 vulnerability.
>>>>>>
>>>>>> This issue was detected with the help of Smatch:
>>>>>>
>>>>>> kernel/sys.c:1474 __do_compat_sys_old_getrlimit() warn: potential
>>>>>> spectre issue 'get_current()->signal->rlim' (local cap)
>>>>>> kernel/sys.c:1455 __do_sys_old_getrlimit() warn: potential spectre
>>>>>> issue
>>>>>> 'get_current()->signal->rlim' (local cap)
>>>>>>
>>>>>> Fix this by sanitizing *resource* before using it to index
>>>>>> current->signal->rlim
>>>>>>
>>>>>> Notice that given that speculation windows are large, the policy is
>>>>>> to kill the speculation on the first load and not worry if it can be
>>>>>> completed with a dependent load/store [1].
>>>>>
>>>>>
>>>>> hm.  Not my area, but I'm always willing to learn ;)
>>>>>
>>>>>> --- a/kernel/sys.c
>>>>>> +++ b/kernel/sys.c
>>>>>> @@ -69,6 +69,9 @@
>>>>>>   #include <asm/io.h>
>>>>>>   #include <asm/unistd.h>
>>>>>>
>>>>>> +/* Hardening for Spectre-v1 */
>>>>>> +#include <linux/nospec.h>
>>>>>> +
>>>>>>   #include "uid16.h"
>>>>>>
>>>>>>   #ifndef SET_UNALIGN_CTL
>>>>>> @@ -1451,6 +1454,7 @@ SYSCALL_DEFINE2(old_getrlimit, unsigned int,
>>>>>> resource,
>>>>>>      if (resource >= RLIM_NLIMITS)
>>>>>>              return -EINVAL;
>>>>>>
>>>>>> +   resource = array_index_nospec(resource, RLIM_NLIMITS);
>>>>>>      task_lock(current->group_leader);
>>>>>>      x = current->signal->rlim[resource];
>>>>>
>>>>>
>>>>> Can the speculation proceed past the task_lock()?  Or is the policy to
>>>>> ignore such happy happenstances even if they are available?
>>>>
>>>>
>>>> Locks are not in the way of speculation. Speculation has almost no
>>>> limits
>>>> except serializing instructions. At least they respect the magic AND
>>>> limitation in array_index_nospec().
>>>
>>>
>>> I'd say it another way, because they don't respect the magic AND, we
>>> just make the result in the speculation path safe. So, it's controlled
>>> speculation.
>>>
>>
>> Dan,
>>
>> What do you think about adding the following function to the nospec API:
>>
>> diff --git a/include/linux/nospec.h b/include/linux/nospec.h
>> index e791ebc..81e9a77 100644
>> --- a/include/linux/nospec.h
>> +++ b/include/linux/nospec.h
>> @@ -55,4 +55,17 @@ static inline unsigned long
>> array_index_mask_nospec(unsigned long index,
>>                                                                          \
>>          (typeof(_i)) (_i & _mask);                                      \
>>   })
>> +
>> +
>> +#ifndef sanitize_index_nospec
>> +inline bool sanitize_index_nospec(unsigned long index,
>> +                                 unsigned long size)
>> +{
>> +       if (index >= size)
>> +               return false;
>> +       index = array_index_nospec(index, size);
>> +
>> +       return true;
>> +}
>> +#endif
>>   #endif /* _LINUX_NOSPEC_H */
>>
>
> Oops, it seems I sent the wrong patch. The function would look like this:
>
> #ifndef sanitize_index_nospec
> inline bool sanitize_index_nospec(unsigned long *index,
>                                   unsigned long size)
> {
>         if (*index >= size)
>                 return false;
>         *index = array_index_nospec(*index, size);
>
>         return true;
> }
> #endif

I think this is fine in concept, we already do something similar in
mpls_label_ok(). Perhaps call it validate_index_nospec() since
validation is something that can fail, but sanitization in theory is
something that can always succeed.

However, the problem is the data type of the index. I expect you would
need to do this in a macro and use typeof() if you wanted this to be
generally useful, and also watch out for multiple usage of a macro
argument. Is it still worth it at that point?
