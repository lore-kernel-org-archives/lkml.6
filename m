Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeCMUXR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:23:17 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40475 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeCMUXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:23:16 -0400
X-Google-Smtp-Source: AG47ELs9xi1/LRqwgdz5Sf9tiDX0GV+55GlhLbiexFyhQqZAyDvEIJBJBBS/yrpIlLLT5BgjTgZWKUL0j0LwrOQ6qqo=
MIME-Version: 1.0
In-Reply-To: <30bd9559-0e44-bd18-6b9a-ec35bc8276f3@amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
 <152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
 <CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com> <30bd9559-0e44-bd18-6b9a-ec35bc8276f3@amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 22:23:15 +0200
Message-ID: <CAHp75VeySPBEeJKRXzmqfPey56J3rwr2-dPRzSYx+7a7TAC5rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iommu/amd - Add debugfs support
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 8:54 PM, Gary R Hook <gary.hook@amd.com> wrote:
> On 03/13/2018 12:16 PM, Andy Shevchenko wrote:
>> On Fri, Mar 9, 2018 at 2:50 AM, Gary R Hook <gary.hook@amd.com> wrote:

>>> +#include <linux/pci.h>
>>> +#include <linux/iommu.h>
>>> +#include <linux/debugfs.h>
>>
>>
>> Keep in order?

> What order would that be? These few needed files are listed in the same
> order as which they appear in amd_iommu.c. I'm gonna need a preference
> spelled out, please (and a rationale, so I may better understand).

To increase readability and avoid potential header duplication (here
is can bus protocol implementation where the problem exists for real,
even in new code!)

>>> +/* DebugFS helpers */
>>> +#define        OBUFP           (obuf + oboff)
>>> +#define        OBUFLEN         obuflen
>>> +#define        OBUFSPC         (OBUFLEN - oboff)
>>> +#define        OSCNPRINTF(fmt, ...) \
>>> +               scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
>>
>>
>> I don't see any advantages of this. Other way around, they will simple
>> makes things hard to read an understand in place.
>
>
> I used this technique in the CCP driver code (where it was accepted), in an
> effort to do the opposite of what you claim: make the code more readable.
> Given the 80 column limit, a large number of arguments, and very long
> statements, IMO something needs to give. I don't find the use of #defines to
> be obfuscating.
>
> I'm not trying to argue, but rather simply state the perspective / reasoning
> I used to create a source file I feel is manageable. I have 17 more iommu
> patches built upon this strategy, and this seems to be advantageous for all
> of them.

It's fine to me as long as it's fine to maintainer, but honestly
speaking I would avoid such code as much as possible. Imagine that
your "advantage" basically becomes disadvantage to everyone else who
is not familiar with the code.

Each time I see macro in the code, I would need to at least step on
it, run cscope, read, and come back. And at this point of time I
already forgot what this code is doing, it does use sNprintf() or
sCNprintf() or whatever wrapper on top of either...

>>> +       for (i = start ; i <= end ; i++)

>> Missed {}

> Wasn't sure about the M.O. given that the body of this loop is a single if
> statement. And I don't see anywhere in
> https://www.kernel.org/doc/html/latest/process/coding-style.html
> in section 3.1 where curly braces are called for in this situation. May I
> ask for clarification on the style rule, please?

You can do nothing, though I'm guided by the end of section 3.0
(though it tells only about 'if' case).

>>> @@ -89,6 +89,7 @@
>>>   #define ACPI_DEVFLAG_ATSDIS             0x10000000
>>>
>>>   #define LOOP_TIMEOUT   100000
>>> +
>>>   /*
>>>    * ACPI table definitions
>>>    *

>> Doesn't belong to the patch.

> I'm sorry, I don't understand. The added blank line doesn't belong to the
> patch?

Correct.

-- 
With Best Regards,
Andy Shevchenko
