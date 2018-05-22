Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeEVUuY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:50:24 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44536 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752969AbeEVUuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:50:19 -0400
X-Google-Smtp-Source: AB8JxZqEVRH9NxqMDPCycsEf1dXMOkzdfBT5uZ2LKpedEoPqlF5waB4t5wKr7tb8mOv1QqACtn/+NVDsJavg6cNXPVQ=
MIME-Version: 1.0
In-Reply-To: <161a0513-1029-a76c-f967-1e606081599d@embeddedor.com>
References: <20180515030038.GA11822@embeddedor.com> <20180515150859.1bccbd8d4543848b30fea859@linux-foundation.org>
 <alpine.DEB.2.21.1805160027260.1605@nanos.tec.linutronix.de>
 <CAPcyv4iksLzZ=eMjWw6Wi87F2OSXHd16gKRLExgGhx=Mdr+AwQ@mail.gmail.com>
 <50481b83-4c03-f354-bd11-cef7aecdd85f@embeddedor.com> <b5e5e160-6ac7-87c8-af1a-4eb88f1f020d@embeddedor.com>
 <CAPcyv4iO67AG5ytc7gRBTnu6V8bdTOMb9eBwjGJtkGpMLKkpwg@mail.gmail.com>
 <3d2e5771-c2c9-6e45-3e85-21c0bc86876e@embeddedor.com> <58df7ae3-8ef0-4f42-9ab2-b551d2ffff00@embeddedor.com>
 <161a0513-1029-a76c-f967-1e606081599d@embeddedor.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 22 May 2018 13:50:18 -0700
Message-ID: <CAPcyv4i6zOJZakNVW=y8NyUFB1EzOxBtoOGVhWCwysuTi6grvg@mail.gmail.com>
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

On Sun, May 20, 2018 at 7:00 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
> On 05/20/2018 07:50 PM, Gustavo A. R. Silva wrote:
>>
>>
>>
>> On 05/18/2018 03:44 PM, Gustavo A. R. Silva wrote:
>>>>>
>>>>>
>>>>> #ifndef sanitize_index_nospec
>>>>> inline bool sanitize_index_nospec(unsigned long *index,
>>>>>                                    unsigned long size)
>>>>> {
>>>>>          if (*index >= size)
>>>>>                  return false;
>>>>>          *index = array_index_nospec(*index, size);
>>>>>
>>>>>          return true;
>>>>> }
>>>>> #endif
>>>>
>>>>
>>>> I think this is fine in concept, we already do something similar in
>>>> mpls_label_ok(). Perhaps call it validate_index_nospec() since
>>>> validation is something that can fail, but sanitization in theory is
>>>> something that can always succeed.
>>>>
>>>
>>> OK. I got it.
>>>
>>>> However, the problem is the data type of the index. I expect you would
>>>> need to do this in a macro and use typeof() if you wanted this to be
>>>> generally useful, and also watch out for multiple usage of a macro
>>>> argument. Is it still worth it at that point?
>>>>
>>>
>>> Yeah. I think it is worth it. I'll work on this during the weekend and
>>> send a proper patch for review.
>>>
>>
>> Dan,
>>
>> What do you think about this first draft:
>>
>> diff --git a/include/linux/nospec.h b/include/linux/nospec.h
>> index e791ebc..6154183 100644
>> --- a/include/linux/nospec.h
>> +++ b/include/linux/nospec.h
>> @@ -55,4 +55,16 @@ static inline unsigned long
>> array_index_mask_nospec(unsigned long index,
>>                                                                         \
>>          (typeof(_i)) (_i & _mask);                                     \
>>   })
>> +
>> +#define validate_index_nospec(index, size)                            \
>> +({                                                                    \
>> +       typeof(index) *ptr = &(index);                                 \
>> +       typeof(size) _s = (size);                                      \
>> +                                                                      \
>> +       BUILD_BUG_ON(sizeof(*ptr) > sizeof(long));                     \
>> +       BUILD_BUG_ON(sizeof(_s) > sizeof(long));                       \
>> +                                                                      \
>> +       *ptr >= _s ? false :                                           \
>> +       (*ptr = array_index_nospec(*ptr, _s) ? true : true);           \
>
>
> This actually should be:
>
> ((*ptr = array_index_nospec(*ptr, _s)) ? true : true);
>

Let's not use ternary conditionals at all to make this more readable.
