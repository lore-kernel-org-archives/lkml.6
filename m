Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeEWP6C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:58:02 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34759 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753723AbeEWP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:58:00 -0400
X-Google-Smtp-Source: AB8JxZrsQ3dJ/L5gUvcYWjaES4qXxFySp7IgSv0qulvUKIEhgeRrvyXyW46yro1+ZdfxIBsumilhD6AXBj8A7qpXzwE=
MIME-Version: 1.0
In-Reply-To: <20180523150737.ycuulapggtu3hpc3@lakrids.cambridge.arm.com>
References: <CAPcyv4iksLzZ=eMjWw6Wi87F2OSXHd16gKRLExgGhx=Mdr+AwQ@mail.gmail.com>
 <50481b83-4c03-f354-bd11-cef7aecdd85f@embeddedor.com> <b5e5e160-6ac7-87c8-af1a-4eb88f1f020d@embeddedor.com>
 <CAPcyv4iO67AG5ytc7gRBTnu6V8bdTOMb9eBwjGJtkGpMLKkpwg@mail.gmail.com>
 <3d2e5771-c2c9-6e45-3e85-21c0bc86876e@embeddedor.com> <58df7ae3-8ef0-4f42-9ab2-b551d2ffff00@embeddedor.com>
 <161a0513-1029-a76c-f967-1e606081599d@embeddedor.com> <CAPcyv4i6zOJZakNVW=y8NyUFB1EzOxBtoOGVhWCwysuTi6grvg@mail.gmail.com>
 <112349fb-837c-7b91-e256-a1c443710150@embeddedor.com> <20180523090840.GU12217@hirez.programming.kicks-ass.net>
 <20180523150737.ycuulapggtu3hpc3@lakrids.cambridge.arm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 23 May 2018 08:57:59 -0700
Message-ID: <CAPcyv4j=czCMfs12-SgvOrPeObf5Qg9cCDDFq_=WUNpDdS_+mw@mail.gmail.com>
Subject: Re: [PATCH] kernel: sys: fix potential Spectre v1
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 8:07 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, May 23, 2018 at 11:08:40AM +0200, Peter Zijlstra wrote:
>>
>> Sorry for being late to the party..
>
> Likewise!
>
>> On Wed, May 23, 2018 at 12:03:57AM -0500, Gustavo A. R. Silva wrote:
>> > +#define validate_index_nospec(index, size)                            \
>> > +({                                                                    \
>> > +       bool ret = true;                                               \
>> > +       typeof(index) *ptr = &(index);                                 \
>> > +       typeof(size) _s = (size);                                      \
>> > +                                                                      \
>> > +       BUILD_BUG_ON(sizeof(*ptr) > sizeof(long));                     \
>> > +       BUILD_BUG_ON(sizeof(_s) > sizeof(long));                       \
>> > +                                                                      \
>> > +       if (*ptr >= size)                                              \
>> > +               ret = false;                                           \
>> > +                                                                      \
>> > +       *ptr = array_index_nospec(*ptr, _s);                           \
>> > +                                                                      \
>> > +       ret;                                                           \
>> > +})
>>
>> Would not something like:
>>
>>       bool ret = false;
>>
>>       ....
>>
>>       if (*ptr < _s) {
>>               *ptr = array_index_nospec(*ptr, _s);
>>               ret = true;
>>       }
>>
>>       ret;
>>
>> be more obvious?
>
> I think that either way, we have a potential problem if the compiler
> generates a branch dependent on the result of validate_index_nospec().
>
> In that case, we could end up with codegen approximating:
>
>         bool safe = false;
>
>         if (idx < bound) {
>                 idx = array_index_nospec(idx, bound);
>                 safe = true;
>         }
>
>         // this branch can be mispredicted
>         if (safe) {
>                 foo = array[idx];
>         }
>
> ... and thus we lose the nospec protection.
>
> I also suspect that compiler transformations mean that this might
> already be the case for patterns like:
>
>         if (idx < bound)  {
>                 safe_idx = array_index_nospec(idx, bound)];
>                 ...
>                 foo = array[safe_idx];
>         }
>
> ... if the compiler can transform that to something like:
>
>         if (idx < bound) {
>                 idx = array_index_nospec(idx, bound);
>         }
>
>         // can be mispredicted
>         if (idx < bound) {
>                 foo = array[idx];
>         }
>
> ... which I think a compiler might be capable of, depending on the rest
> of the function body (e.g. if there's a common portion shared with the
> else case).
>
> I'll see if I can trigger that in a test case. :/

This would be interesting, because my operating assumption is that the
compiler will not play these games over inline asm, i.e. the index
will always be modified before use in all cases.
