Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeERVpb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:45:31 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44495 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbeERVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:45:28 -0400
X-Google-Smtp-Source: AB8JxZoPo3Y6qk85JHuL3ICx0L+QOtEXY5zpKpnuhZK+9V2L0WfyjpVWKZc4KkeWNz1oeEoFmakrCtMPqYyUkohtqCA=
MIME-Version: 1.0
In-Reply-To: <f6be31b7-a6f8-3d7f-f621-09490a1b0489@embeddedor.com>
References: <20180515030038.GA11822@embeddedor.com> <20180515150859.1bccbd8d4543848b30fea859@linux-foundation.org>
 <alpine.DEB.2.21.1805160027260.1605@nanos.tec.linutronix.de>
 <CAPcyv4iksLzZ=eMjWw6Wi87F2OSXHd16gKRLExgGhx=Mdr+AwQ@mail.gmail.com>
 <50481b83-4c03-f354-bd11-cef7aecdd85f@embeddedor.com> <b5e5e160-6ac7-87c8-af1a-4eb88f1f020d@embeddedor.com>
 <CAPcyv4iO67AG5ytc7gRBTnu6V8bdTOMb9eBwjGJtkGpMLKkpwg@mail.gmail.com>
 <3d2e5771-c2c9-6e45-3e85-21c0bc86876e@embeddedor.com> <f6be31b7-a6f8-3d7f-f621-09490a1b0489@embeddedor.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 May 2018 14:45:27 -0700
Message-ID: <CAPcyv4husQPy601-JKpud7C3YZFcxk4BAJJhcztu_yOeC=7U-w@mail.gmail.com>
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

On Fri, May 18, 2018 at 2:27 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
> On 05/18/2018 03:44 PM, Gustavo A. R. Silva wrote:
>>>>>
>>>>>
>>>>
>>>> Oops, it seems I sent the wrong patch. The function would look like
>>>> this:
>>>>
>>>> #ifndef sanitize_index_nospec
>>>> inline bool sanitize_index_nospec(unsigned long *index,
>>>>                                    unsigned long size)
>>>> {
>>>>          if (*index >= size)
>>>>                  return false;
>>>>          *index = array_index_nospec(*index, size);
>>>>
>>>>          return true;
>>>> }
>>>> #endif
>>>
>>>
>>> I think this is fine in concept, we already do something similar in
>>> mpls_label_ok(). Perhaps call it validate_index_nospec() since
>>> validation is something that can fail, but sanitization in theory is
>>> something that can always succeed.
>>>
>>
>> OK. I got it.
>>
>>> However, the problem is the data type of the index. I expect you would
>>> need to do this in a macro and use typeof() if you wanted this to be
>>> generally useful, and also watch out for multiple usage of a macro
>>> argument. Is it still worth it at that point?
>>>
>>
>> Yeah. I think it is worth it. I'll work on this during the weekend and
>> send a proper patch for review.
>>
>> Thanks for the feedback.
>
>
> BTW, I'm analyzing other cases, like the following:
>
> bool foo(int x)
> {
>          if(!validate_index_nospec(&x))
>                  return false;
>
>          [...]
>
>          return true;
> }
>
> int vulnerable(int x)
> {
>          if (!foo(x))
>                  return -1;
>
>          temp = array[x];
>
>          [...]
>
> }
>
> Basically my doubt is how deep this barrier can be placed into the call
> chain in order to continue working.

This is broken you would need to pass the address of x into foo()
otherwise there may be speculation on the return value of foo.
