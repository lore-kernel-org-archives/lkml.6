Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbeBBWfB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:35:01 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41472 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeBBWez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:34:55 -0500
X-Google-Smtp-Source: AH8x227JMXyAp22uvY2wZpGC2nY9pdHaVQBJe+QZWhcMrr5AkxfCtZ1J4souwWv1HvFc/4f+ydHgHw==
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
 <4f2b3755-9ef1-4817-7436-9f5aafb38b60@gmail.com>
 <CAL_JsqJv7TcDtyMCn=u9KawF5tTPDxGCH9pog6Sz+PCyWH1y7Q@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <8ff27d9b-bdb9-cf7a-8b04-1af606513ea7@gmail.com>
Date: Fri, 2 Feb 2018 14:34:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJv7TcDtyMCn=u9KawF5tTPDxGCH9pog6Sz+PCyWH1y7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/18 19:45, Rob Herring wrote:
> On Thu, Feb 1, 2018 at 3:09 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> On 02/01/18 06:24, Rob Herring wrote:
>>> On Wed, Jan 31, 2018 at 3:43 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>>> On 01/31/18 12:05, frowand.list@gmail.com wrote:
>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>
>>>>> Create a cache of the nodes that contain a phandle property.  Use this
>>>>> cache to find the node for a given phandle value instead of scanning
>>>>> the devicetree to find the node.  If the phandle value is not found
>>>>> in the cache, of_find_node_by_phandle() will fall back to the tree
>>>>> scan algorithm.
>>>>>
>>>>> The cache is initialized in of_core_init().
>>>>>
>>>>> The cache is freed via a late_initcall_sync().
>>>>>
>>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>>> ---
>>>>>
>>>>> Some of_find_by_phandle() calls may occur before the cache is
>>>>> initialized or after it is freed.  For example, for the qualcomm
>>>>> qcom-apq8074-dragonboard, 11 calls occur before the initialization
>>>>> and 80 occur after the cache is freed (out of 516 total calls.)
>>>>>
>>>>>
>>>>>  drivers/of/base.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++++---
>>>>>  drivers/of/of_private.h |  5 +++
>>>>>  drivers/of/resolver.c   | 21 ------------
>>>>>  3 files changed, 86 insertions(+), 25 deletions(-)
>>>>
>>>> Some observations....
>>>>
>>>> The size of the cache for a normal device tree would be a couple of
>>>> words of overhead for the cache, plus one pointer per devicetree node
>>>> that contains a phandle property.  This will be less space than
>>>> would be used by adding a hash field to each device node.  It is
>>>> also less space than was used by the older algorithm (long gone)
>>>> that added a linked list through the nodes that contained a
>>>> phandle property.
>>>>
>>>> This is assuming that the values of the phandle properties are
>>>> the default ones created by the dtc compiler.  In the case
>>>> where a very large phandle property value is hand-coded in
>>>> a devicetree source, the size of the cache is capped at one
>>>> entry per node.  In this case, a little bit of space will be
>>>> wasted -- but this is just a sanity fallback, it should not
>>>> be encountered, and can be fixed by fixing the devicetree
>>>> source.
>>>
>>> I don't think we should rely on how dtc allocates phandles. dtc is not
>>> the only source of DeviceTrees. If we could do that, then lets make
>>
>> It seems like a reasonable thing to rely on.  dtc is the in-tree
>> compiler to create an FDT.
>>
>> Are you thinking about the IBM PPC devicetrees as devicetrees created
>> in some manner other than dtc?  Are there other examples you are
>> aware of?
> 
> There's that and any other platform with real OF. There's also the BSD
> implementation of dtc.
> 
>> If non-dtc tools create phandle property values that are not a
>> contiguous range of values starting with one, then the devicetrees
>> they create may not benefit from this performance optimization.
>> But no user of such a devicetree is complaining about performance
>> issues with of_find_node_by_phandle() against their tree.  So until
>> there is an issue, no big deal.
> 
> All I'm really saying is mask the low bits like I did. Then it works
> equally well for any continuous range. Yes, someone could allocate in
> multiples of 1024 or something and it wouldn't work well (still works,
> but misses). Then we're really only debating dynamically sizing it and
> whether to free it.

I see what you are saying.

Are you aware of any compiler that creates phandle property values
in this manner?  If so, then there is a complexity vs benefit
analysis to be done.  If not, there is no need to code for a
what-if scenario that would not have any negative consequences
(other than not being able to take advantage of a performance
enhancement).


>> If my effort to create a new version of the FDT, I would like to
>> include a rule to the effect of "phandle property values created
>> by the compiler _should_ be in the range of 1..n, where n is the
>> number of phandle properties in the tree".  That would provide
>> some assurance of future trees being able to benefit from this
>> specific optimization.
> 
> Did you think of that before this issue? :)

I don't remember, but I doubt it.  Not that it has any bearing
on this.  :-)


>> Also, this specific implementation to decrease the cost of
>> of_find_node_by_phandle() is just an implementation, not an
>> architecture.  Other implementations to achieve the same goal
>> have existed in the past, and yet other methods could replace
>> this one in the future if needed.
>>
>>
>>> them have some known flag in the upper byte so we have some hint for
>>> phandle values. 2^24 phandles should be enough for anyone.TM
>>
>> I don't understand.  What is the definition of the flag?  A flag
>> that says the phandle property values are in the range of 1..n,
>> where n is the number of phandle properties in the tree?
> 
> If we defined that phandles have values of say "0xABxxxxxx", then we
> could use that for parsing properties without looking up #*-cells.

For those at home reading along, this would reduce the number of
of_find_node_by_phandle() calls.


> Maybe you encode the cell count too. Yes, you'd have to handle
> possible collisions, but it would be better than nothing. My point is
> that we don't do this because then we'd be making assumptions on

Yes, that would be really fragile.


> phandle values. We can't make assumptions because the dtbs already
> exist and dtc is only one of the things generating phandles I can
> change.

That is a different argument.  It is arguing that making assumptions
about phandle values could lead to incorrect results.  My argument
is that making assumptions about phandle values means that a dtb
that does not meet these assumptions will still be interpretted
correctly, but will not be able to benefit from a performance
enhancement.

The performance enhancement becomes available to that devicetree
simply by recompiling with a compiler that matches the phandle
property value assumption.


>>> Your cache size is also going to balloon if the dtb was built with
>>> '-@'.
>>
>> "Balloon" is a bit strong.  Worst case is one entry per node,
>> which is comparable to the old method of a linked list of nodes
>> with phandle properties but with lower of_find_node_by_phandle()
>> cost than the linked list implementation.  And this assumes that
>> every node has a label on it.
>>
>> < snip (retracted) >
>>
>>
>>> Freeing after boot is nice, but if someone has lots of modules or
>>> large overlays, this doesn't help them at all.
>>
>> The cache has to be regenerated anyway after applying an overlay
>> that adds phandle properties to the live tree. Modules is something
>> I thought about, but did not want to complicate the patch until we
>> decided if this was a good direction to follow.  Some ways to deal
>> with overlays could be: don't auto-free the cache if modules are
>> configured in the kernel, repopulate the cache any time a module
>> is loaded, add a boot command line option to specify "do not free
>> the cache" (or alternatively, do not automatically free the cache
>> but provide an option of "do free the cache").
> 
> Or just make the cache small enough to not matter.

I would argue that the cache is small enough to not matter because
it is dynamically sized, based on the complexity of the devicetree.
A devicetree with few phandle properties is unlikely to have a
noticable boot time reduction, but also has a very small cache.
A devicetree with a large number of phandle properties is likely
to have a noticable boot time reduction (if the current test
reports bear out), but such a system is also likely to have more
memory and not be sensitive to the memory used by the cache (which
is still quite small).

For the system which started this discussion, the memory size is 6 GB.

The alternate approaches for choosing whether to free the cache
or not are available _if_ we decide the memory usage is an
issue.


>> For now this seems like a lot of complexity for a non-problem.
>> And we don't even have the performance numbers yet to see if
>> this solves the reported problem.  I'd prefer to start simple,
>> and add complexity if needed.
> 
> I agree. I'm just saying there's a path towards further improvements if need be.

Yes.  And I expect some to be pursued in the future, when it makes
sense to (eg small additions to make this more useful for overlays).

And it is an interesting discussion looking at the alternatives.


>>> There's still more tweaks we could do with a cache based (i.e. can
>>> miss) approach. We could have an access count or some most recently
>>> used list to avoid evicting frequently accessed phandles (your data
>>> tends to indicate that would help). We could have cache sets.
>>
>> That seems like a lot of complexity for little or no gain.
>>
>> I actually like the elegance of the patch you created, thinking that
>> the cache population and freeing code in my patch added a level of
>> complexity.  In the end, I think the reduced overhead of my
>> approach supports the slight increase in complexity.
> 
> How is your approach less overhead? The fastest so far is an 850ms
> improvement with a 1024 entry, pre-populated cache. Next is yours (an
> array of all phandles) at 750ms. Then a 64-entry cache is 650ms
> improvement.

Those values are not comparable.  The 850ms improvement was against a
base boot time of 15.04, 15.24, and 15.26 seconds.  The 750ms was against a
base boot time of 14.78, 14.84, and 14.84 seconds.  Different base boot
times says something was different that _could_ affect the measured
improvement for the different approaches.

Being really simplistic (eg ignoring L1 cache size, which is reported to
be 32KB per CPU, and L2 cache size, reported to be 128KB per cpu, and thus
_could_ be a factor given my approach has a phandle cache size of
814 * 4 = 3256 bytes if 32 bit pointers or 6512 bytes if 64 bit pointers)...

My algorithm...

   - two scans of the devicetree nodes to populate the cache
     O(2 * number of nodes)

   - an O(1) cache access time.

   - memory overhead: one pointer per node that contains a phandle
     property, plus a couple overhead head words: ~3256 bytes
     or ~6512 bytes for this specific devicetree

Your algorithm, if the cache is large enough to hold all phandle
values without any collision...

   - one scan of the devicetree per phandle property accessed,
     each scan is of half of the devicetree nodes (assumes nodes with
     a phandle property are evenly distributed throughout the devicetree)
     to populate the cache
     O(number of nodes with phandle properties) * (1/2 * number of nodes)

   - each time a phandle cache entry has a collision and a new value has
     to be determined repeats an O(1/2 * number of nodes) scan

   - an O(1) cache access time

   - memory overhead: depends on the implementation chosen, but could
     be as small as 64 * 4 = 256 bytes (or 64 * 8 = 512 bytes)

My algorithm: fewer memory accesses, more memory used

Your algorithm: more memory accesses, less memory used

But for small devicetrees (less than 64 nodes with phandle properties)
my algorithm uses less memory for the phandle cache.


> I'm still of the opinion that the 64 entry cache is good enough in the
> trade off of speed and size.

That is an arbitrary size that may or may not scale with the number of
phandle properties in a devicetree.  That is most likely dependent upon
the access pattern of each phandle value.  Chintan sent some data that
allows us to look at that for his specific system.  There are some time
ranges in the boot that show a lot of temporal locality and there are
some ranges that do not.  I'll reply to that email separately.


> 
> Rob
> 
