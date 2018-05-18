Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeERWIL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:08:11 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37380 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeERWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:08:10 -0400
X-Google-Smtp-Source: AB8JxZonLeEvO8jvbB3SMcy8I0Y3xtPMHKveZzbLl1vTgX0BEFaeotzR3jpVK+VxhUVdXv0Fp0ABfeu3VhqwUcbVxPg=
MIME-Version: 1.0
In-Reply-To: <c22b86a0-5d35-72af-679d-0d237d386a32@embeddedor.com>
References: <20180515030038.GA11822@embeddedor.com> <20180515150859.1bccbd8d4543848b30fea859@linux-foundation.org>
 <alpine.DEB.2.21.1805160027260.1605@nanos.tec.linutronix.de>
 <CAPcyv4iksLzZ=eMjWw6Wi87F2OSXHd16gKRLExgGhx=Mdr+AwQ@mail.gmail.com>
 <50481b83-4c03-f354-bd11-cef7aecdd85f@embeddedor.com> <b5e5e160-6ac7-87c8-af1a-4eb88f1f020d@embeddedor.com>
 <CAPcyv4iO67AG5ytc7gRBTnu6V8bdTOMb9eBwjGJtkGpMLKkpwg@mail.gmail.com>
 <3d2e5771-c2c9-6e45-3e85-21c0bc86876e@embeddedor.com> <f6be31b7-a6f8-3d7f-f621-09490a1b0489@embeddedor.com>
 <CAPcyv4husQPy601-JKpud7C3YZFcxk4BAJJhcztu_yOeC=7U-w@mail.gmail.com> <c22b86a0-5d35-72af-679d-0d237d386a32@embeddedor.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 May 2018 15:08:09 -0700
Message-ID: <CAPcyv4hG_ue7WPWZHzQmKXpZD-ZCovXOUHurVa59-Zs6bdBe=w@mail.gmail.com>
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

On Fri, May 18, 2018 at 3:01 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
> On 05/18/2018 04:45 PM, Dan Williams wrote:
>>
>> On Fri, May 18, 2018 at 2:27 PM, Gustavo A. R. Silva
>> <gustavo@embeddedor.com> wrote:
>>>
>>>
>>>
>>> On 05/18/2018 03:44 PM, Gustavo A. R. Silva wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Oops, it seems I sent the wrong patch. The function would look like
>>>>>> this:
>>>>>>
>>>>>> #ifndef sanitize_index_nospec
>>>>>> inline bool sanitize_index_nospec(unsigned long *index,
>>>>>>                                     unsigned long size)
>>>>>> {
>>>>>>           if (*index >= size)
>>>>>>                   return false;
>>>>>>           *index = array_index_nospec(*index, size);
>>>>>>
>>>>>>           return true;
>>>>>> }
>>>>>> #endif
>>>>>
>>>>>
>>>>>
>>>>> I think this is fine in concept, we already do something similar in
>>>>> mpls_label_ok(). Perhaps call it validate_index_nospec() since
>>>>> validation is something that can fail, but sanitization in theory is
>>>>> something that can always succeed.
>>>>>
>>>>
>>>> OK. I got it.
>>>>
>>>>> However, the problem is the data type of the index. I expect you would
>>>>> need to do this in a macro and use typeof() if you wanted this to be
>>>>> generally useful, and also watch out for multiple usage of a macro
>>>>> argument. Is it still worth it at that point?
>>>>>
>>>>
>>>> Yeah. I think it is worth it. I'll work on this during the weekend and
>>>> send a proper patch for review.
>>>>
>>>> Thanks for the feedback.
>>>
>>>
>>>
>>> BTW, I'm analyzing other cases, like the following:
>>>
>>> bool foo(int x)
>>> {
>>>           if(!validate_index_nospec(&x))
>>>                   return false;
>>>
>>>           [...]
>>>
>>>           return true;
>>> }
>>>
>>> int vulnerable(int x)
>>> {
>>>           if (!foo(x))
>>>                   return -1;
>>>
>>>           temp = array[x];
>>>
>>>           [...]
>>>
>>> };
>>>
>>> Basically my doubt is how deep this barrier can be placed into the call
>>> chain in order to continue working.
>>
>>
>> This is broken you would need to pass the address of x into foo()
>> otherwise there may be speculation on the return value of foo.
>>
>
> Oh I see now. Just to double check, then something like the following would
> be broken too, because is basically the same as the code above, and well, it
> doesn't make much sense to store the value returned by macro
> array_index_nospec into x, correct?:

Correct, broken:

>
> bool foo(int x)
> {
>         if(x >= MAX)
>                 return false;

Under speculation we may not return here when x is greater than max.

>         x = array_index_nospec(x, MAX);

x is now sanitized under speculation to zero, but the compiler would
likely just throw this away because nothing consumes it.

>         return true;
> }
>
> int vulnerable(int x)
> {
>         if(!foo(x))
>                 return -1;

cpu might speculate that this branch is not taken...

>
>         temp = array[x];

...so x had better be bounded here, otherwise Spectre.
