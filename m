Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeBBDqF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:46:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeBBDp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:45:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49553217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AH8x2244Me1zZ+sPutSwPmHHjl/zvKTruOnCrbXt6kvUsjf2bLhDeTgEG3rVhFeRgCKuZPtd7/ZDwk07U5B57zYwFk0=
MIME-Version: 1.0
In-Reply-To: <4f2b3755-9ef1-4817-7436-9f5aafb38b60@gmail.com>
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
 <5dd35d8f-c430-237e-9863-2e73556f92ec@gmail.com> <CAL_JsqLV_bQ2pQ7hCRDP9_31kmKQjggWFDoCia-KmmO5CR3T5g@mail.gmail.com>
 <4f2b3755-9ef1-4817-7436-9f5aafb38b60@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 1 Feb 2018 21:45:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJv7TcDtyMCn=u9KawF5tTPDxGCH9pog6Sz+PCyWH1y7Q@mail.gmail.com>
Message-ID: <CAL_JsqJv7TcDtyMCn=u9KawF5tTPDxGCH9pog6Sz+PCyWH1y7Q@mail.gmail.com>
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of of_find_node_by_phandle()
To: Frank Rowand <frowand.list@gmail.com>
Cc: Chintan Pandya <cpandya@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 3:09 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 02/01/18 06:24, Rob Herring wrote:
>> On Wed, Jan 31, 2018 at 3:43 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>> On 01/31/18 12:05, frowand.list@gmail.com wrote:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Create a cache of the nodes that contain a phandle property.  Use this
>>>> cache to find the node for a given phandle value instead of scanning
>>>> the devicetree to find the node.  If the phandle value is not found
>>>> in the cache, of_find_node_by_phandle() will fall back to the tree
>>>> scan algorithm.
>>>>
>>>> The cache is initialized in of_core_init().
>>>>
>>>> The cache is freed via a late_initcall_sync().
>>>>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>>
>>>> Some of_find_by_phandle() calls may occur before the cache is
>>>> initialized or after it is freed.  For example, for the qualcomm
>>>> qcom-apq8074-dragonboard, 11 calls occur before the initialization
>>>> and 80 occur after the cache is freed (out of 516 total calls.)
>>>>
>>>>
>>>>  drivers/of/base.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++++---
>>>>  drivers/of/of_private.h |  5 +++
>>>>  drivers/of/resolver.c   | 21 ------------
>>>>  3 files changed, 86 insertions(+), 25 deletions(-)
>>>
>>> Some observations....
>>>
>>> The size of the cache for a normal device tree would be a couple of
>>> words of overhead for the cache, plus one pointer per devicetree node
>>> that contains a phandle property.  This will be less space than
>>> would be used by adding a hash field to each device node.  It is
>>> also less space than was used by the older algorithm (long gone)
>>> that added a linked list through the nodes that contained a
>>> phandle property.
>>>
>>> This is assuming that the values of the phandle properties are
>>> the default ones created by the dtc compiler.  In the case
>>> where a very large phandle property value is hand-coded in
>>> a devicetree source, the size of the cache is capped at one
>>> entry per node.  In this case, a little bit of space will be
>>> wasted -- but this is just a sanity fallback, it should not
>>> be encountered, and can be fixed by fixing the devicetree
>>> source.
>>
>> I don't think we should rely on how dtc allocates phandles. dtc is not
>> the only source of DeviceTrees. If we could do that, then lets make
>
> It seems like a reasonable thing to rely on.  dtc is the in-tree
> compiler to create an FDT.
>
> Are you thinking about the IBM PPC devicetrees as devicetrees created
> in some manner other than dtc?  Are there other examples you are
> aware of?

There's that and any other platform with real OF. There's also the BSD
implementation of dtc.

> If non-dtc tools create phandle property values that are not a
> contiguous range of values starting with one, then the devicetrees
> they create may not benefit from this performance optimization.
> But no user of such a devicetree is complaining about performance
> issues with of_find_node_by_phandle() against their tree.  So until
> there is an issue, no big deal.

All I'm really saying is mask the low bits like I did. Then it works
equally well for any continuous range. Yes, someone could allocate in
multiples of 1024 or something and it wouldn't work well (still works,
but misses). Then we're really only debating dynamically sizing it and
whether to free it.

> If my effort to create a new version of the FDT, I would like to
> include a rule to the effect of "phandle property values created
> by the compiler _should_ be in the range of 1..n, where n is the
> number of phandle properties in the tree".  That would provide
> some assurance of future trees being able to benefit from this
> specific optimization.

Did you think of that before this issue? :)

> Also, this specific implementation to decrease the cost of
> of_find_node_by_phandle() is just an implementation, not an
> architecture.  Other implementations to achieve the same goal
> have existed in the past, and yet other methods could replace
> this one in the future if needed.
>
>
>> them have some known flag in the upper byte so we have some hint for
>> phandle values. 2^24 phandles should be enough for anyone.TM
>
> I don't understand.  What is the definition of the flag?  A flag
> that says the phandle property values are in the range of 1..n,
> where n is the number of phandle properties in the tree?

If we defined that phandles have values of say "0xABxxxxxx", then we
could use that for parsing properties without looking up #*-cells.
Maybe you encode the cell count too. Yes, you'd have to handle
possible collisions, but it would be better than nothing. My point is
that we don't do this because then we'd be making assumptions on
phandle values. We can't make assumptions because the dtbs already
exist and dtc is only one of the things generating phandles I can
change.

>> Your cache size is also going to balloon if the dtb was built with
>> '-@'.
>
> "Balloon" is a bit strong.  Worst case is one entry per node,
> which is comparable to the old method of a linked list of nodes
> with phandle properties but with lower of_find_node_by_phandle()
> cost than the linked list implementation.  And this assumes that
> every node has a label on it.
>
> < snip (retracted) >
>
>
>> Freeing after boot is nice, but if someone has lots of modules or
>> large overlays, this doesn't help them at all.
>
> The cache has to be regenerated anyway after applying an overlay
> that adds phandle properties to the live tree. Modules is something
> I thought about, but did not want to complicate the patch until we
> decided if this was a good direction to follow.  Some ways to deal
> with overlays could be: don't auto-free the cache if modules are
> configured in the kernel, repopulate the cache any time a module
> is loaded, add a boot command line option to specify "do not free
> the cache" (or alternatively, do not automatically free the cache
> but provide an option of "do free the cache").

Or just make the cache small enough to not matter.

> For now this seems like a lot of complexity for a non-problem.
> And we don't even have the performance numbers yet to see if
> this solves the reported problem.  I'd prefer to start simple,
> and add complexity if needed.

I agree. I'm just saying there's a path towards further improvements if need be.

>> There's still more tweaks we could do with a cache based (i.e. can
>> miss) approach. We could have an access count or some most recently
>> used list to avoid evicting frequently accessed phandles (your data
>> tends to indicate that would help). We could have cache sets.
>
> That seems like a lot of complexity for little or no gain.
>
> I actually like the elegance of the patch you created, thinking that
> the cache population and freeing code in my patch added a level of
> complexity.  In the end, I think the reduced overhead of my
> approach supports the slight increase in complexity.

How is your approach less overhead? The fastest so far is an 850ms
improvement with a 1024 entry, pre-populated cache. Next is yours (an
array of all phandles) at 750ms. Then a 64-entry cache is 650ms
improvement.

I'm still of the opinion that the 64 entry cache is good enough in the
trade off of speed and size.

Rob
