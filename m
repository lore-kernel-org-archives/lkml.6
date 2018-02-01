Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeBAVKG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:10:06 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35779 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeBAVJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:09:59 -0500
X-Google-Smtp-Source: AH8x224q0Dmxch88xQlg8zUY5EUpcURJOlmKOZKwd8HUatHcRWFq+b4DGyO34ACH0LFTqCDWHlcOOA==
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
To: Rob Herring <robh+dt@kernel.org>
Cc: Chintan Pandya <cpandya@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
 <5dd35d8f-c430-237e-9863-2e73556f92ec@gmail.com>
 <CAL_JsqLV_bQ2pQ7hCRDP9_31kmKQjggWFDoCia-KmmO5CR3T5g@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <4f2b3755-9ef1-4817-7436-9f5aafb38b60@gmail.com>
Date: Thu, 1 Feb 2018 13:09:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLV_bQ2pQ7hCRDP9_31kmKQjggWFDoCia-KmmO5CR3T5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/18 06:24, Rob Herring wrote:
> On Wed, Jan 31, 2018 at 3:43 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> On 01/31/18 12:05, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> Create a cache of the nodes that contain a phandle property.  Use this
>>> cache to find the node for a given phandle value instead of scanning
>>> the devicetree to find the node.  If the phandle value is not found
>>> in the cache, of_find_node_by_phandle() will fall back to the tree
>>> scan algorithm.
>>>
>>> The cache is initialized in of_core_init().
>>>
>>> The cache is freed via a late_initcall_sync().
>>>
>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>> ---
>>>
>>> Some of_find_by_phandle() calls may occur before the cache is
>>> initialized or after it is freed.  For example, for the qualcomm
>>> qcom-apq8074-dragonboard, 11 calls occur before the initialization
>>> and 80 occur after the cache is freed (out of 516 total calls.)
>>>
>>>
>>>  drivers/of/base.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++++---
>>>  drivers/of/of_private.h |  5 +++
>>>  drivers/of/resolver.c   | 21 ------------
>>>  3 files changed, 86 insertions(+), 25 deletions(-)
>>
>> Some observations....
>>
>> The size of the cache for a normal device tree would be a couple of
>> words of overhead for the cache, plus one pointer per devicetree node
>> that contains a phandle property.  This will be less space than
>> would be used by adding a hash field to each device node.  It is
>> also less space than was used by the older algorithm (long gone)
>> that added a linked list through the nodes that contained a
>> phandle property.
>>
>> This is assuming that the values of the phandle properties are
>> the default ones created by the dtc compiler.  In the case
>> where a very large phandle property value is hand-coded in
>> a devicetree source, the size of the cache is capped at one
>> entry per node.  In this case, a little bit of space will be
>> wasted -- but this is just a sanity fallback, it should not
>> be encountered, and can be fixed by fixing the devicetree
>> source.
> 
> I don't think we should rely on how dtc allocates phandles. dtc is not
> the only source of DeviceTrees. If we could do that, then lets make

It seems like a reasonable thing to rely on.  dtc is the in-tree
compiler to create an FDT.

Are you thinking about the IBM PPC devicetrees as devicetrees created
in some manner other than dtc?  Are there other examples you are
aware of?

If non-dtc tools create phandle property values that are not a
contiguous range of values starting with one, then the devicetrees
they create may not benefit from this performance optimization.
But no user of such a devicetree is complaining about performance
issues with of_find_node_by_phandle() against their tree.  So until
there is an issue, no big deal.

If my effort to create a new version of the FDT, I would like to
include a rule to the effect of "phandle property values created
by the compiler _should_ be in the range of 1..n, where n is the
number of phandle properties in the tree".  That would provide
some assurance of future trees being able to benefit from this
specific optimization.

Also, this specific implementation to decrease the cost of
of_find_node_by_phandle() is just an implementation, not an
architecture.  Other implementations to achieve the same goal
have existed in the past, and yet other methods could replace
this one in the future if needed.


> them have some known flag in the upper byte so we have some hint for
> phandle values. 2^24 phandles should be enough for anyone.TM

I don't understand.  What is the definition of the flag?  A flag
that says the phandle property values are in the range of 1..n,
where n is the number of phandle properties in the tree?


> Your cache size is also going to balloon if the dtb was built with
> '-@'.

"Balloon" is a bit strong.  Worst case is one entry per node,
which is comparable to the old method of a linked list of nodes
with phandle properties but with lower of_find_node_by_phandle()
cost than the linked list implementation.  And this assumes that
every node has a label on it.

< snip (retracted) >


> Freeing after boot is nice, but if someone has lots of modules or
> large overlays, this doesn't help them at all.

The cache has to be regenerated anyway after applying an overlay
that adds phandle properties to the live tree.  Modules is something
I thought about, but did not want to complicate the patch until we
decided if this was a good direction to follow.  Some ways to deal
with overlays could be: don't auto-free the cache if modules are
configured in the kernel, repopulate the cache any time a module
is loaded, add a boot command line option to specify "do not free
the cache" (or alternatively, do not automatically free the cache
but provide an option of "do free the cache").

For now this seems like a lot of complexity for a non-problem.
And we don't even have the performance numbers yet to see if
this solves the reported problem.  I'd prefer to start simple,
and add complexity if needed.


> There's still more tweaks we could do with a cache based (i.e. can
> miss) approach. We could have an access count or some most recently
> used list to avoid evicting frequently accessed phandles (your data
> tends to indicate that would help). We could have cache sets. 

That seems like a lot of complexity for little or no gain.

I actually like the elegance of the patch you created, thinking that
the cache population and freeing code in my patch added a level of
complexity.  In the end, I think the reduced overhead of my
approach supports the slight increase in complexity.


> And so
> far, no one has explained why a bigger cache got slower.

Yes, I still find that surprising.



> Or we could do something decentralized and make the frequent callers
> cache their phandles.

That could be a good solution if we have just one or two uses of
of_find_node_by_phandle() that are the cause of the long boot time.

That is why I was trying to get Chintan to examine and understand the
use(s) of of_find_by_phandle() that were causing the slow boot, or if
the problem is dispersed to a wide variety of callers.

> 
> Rob
> 
