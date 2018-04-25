Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeDYS46 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:56:58 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34971 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755986AbeDYS4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:56:32 -0400
X-Google-Smtp-Source: AIpwx49fPlYyhvsgobHCbCF1PEr60ehtMLI3PMjNG4ml76A6vhHc6tlqsCxHJmb6np1bjmba79nJkw==
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Jan Kiszka <jan.kiszka@web.de>, Rob Herring <robh+dt@kernel.org>,
        Alan Tull <atull@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
 <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
 <a21dbee8-6e4e-9ceb-c798-dda43c2eae2d@web.de>
 <d7e94a45-5d46-0491-e5dc-2b098a11c5b1@gmail.com>
 <CAL_Jsq+MmUTMrd+jNqUB2=A-q3cCy7+QWOKG0iF6zM0hjCy3PQ@mail.gmail.com>
 <e508f3de-f21b-2510-2c6a-b810073ba1a7@web.de>
 <e06d1c0f-f60d-fc23-cd74-82f557dbc432@web.de>
 <7bbb9472-9c96-6012-68e6-4ec2773c7732@gmail.com>
 <4422f58a-ca7c-16e6-e0df-63faea50f553@web.de>
 <3d7cb4d3-5070-e878-51d3-59f9772f756b@gmail.com>
 <53ee2d0b-1867-5cad-667c-7f70085c645d@web.de>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <e2eb2c23-d580-8c46-5bdb-a142b3791301@gmail.com>
Date: Wed, 25 Apr 2018 11:56:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <53ee2d0b-1867-5cad-667c-7f70085c645d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/18 22:22, Jan Kiszka wrote:
> On 2018-04-24 23:15, Frank Rowand wrote:
>> On 04/23/18 22:29, Jan Kiszka wrote:
>>> On 2018-04-24 00:38, Frank Rowand wrote:
>>>> Hi Jan,
>>>>
>>>> + Alan Tull for fpga perspective
>>>>
>>>> On 04/22/18 03:30, Jan Kiszka wrote:
>>>>> On 2018-04-11 07:42, Jan Kiszka wrote:
>>>>>> On 2018-04-05 23:12, Rob Herring wrote:
>>>>>>> On Thu, Apr 5, 2018 at 2:28 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>>> On 04/05/18 12:13, Jan Kiszka wrote:
>>>>>>>>> On 2018-04-05 20:59, Frank Rowand wrote:
>>>>>>>>>> Hi Jan,
>>>>>>>>>>
>>>>>>>>>> On 04/04/18 15:35, Jan Kiszka wrote:
>>>>>>>>>>> Hi Frank,
>>>>>>>>>>>
>>>>>>>>>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>>>>>>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>>>>>>>>
>>>>>>>>>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>>>>>>>>>> (FDT) into the overlay application code.  To accomplish this,
>>>>>>>>>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>>>>>>>>>
>>>>>>>>>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>>>>>>>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>>>>>>>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>>>>>>>>>> original FDT.
>>>>>>>>>>>>
>>>>>>>>>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>>>>>>>>>> thus responsible for freeing the unflattened devicetree.
>>>>>>>>>>>>
>>>>>>>>>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>>>>>>>>>> or the unflattened devicetree, which could result in use after free
>>>>>>>>>>>> errors.
>>>>>>>>>>>>
>>>>>>>>>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>>>>>>>>>> overlay loader.
>>>>>>>>>>>
>>>>>>>>>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>>>>>>>>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>>>>>>>>>> device during hypervisor activation with Linux. The DT overlay is
>>>>>>>>>>> created from a a template but modified prior to application to account
>>>>>>>>>>> for runtime-specific parameters. See [1] for the current implementation.
>>>>>>>>>>>
>>>>>>>>>>> I'm now wondering how to model that scenario best with the new API.
>>>>>>>>>>> Given that the loader lost ownership of the unflattened tree but the
>>>>>>>>>>> modification API exist only for the that DT state, I'm not yet seeing a
>>>>>>>>>>> clear solution. Should we apply the template in disabled form (status =
>>>>>>>>>>> "disabled"), modify it, and then activate it while it is already applied?
>>>>>>>>>>
>>>>>>>>>> Thank you for the pointer to the driver - that makes it much easier to
>>>>>>>>>> understand the use case and consider solutions.
>>>>>>>>>>
>>>>>>>>>> If you can make the changes directly on the FDT instead of on the
>>>>>>>>>> expanded devicetree, then you could move to the new API.
>>>>>>>>>
>>>>>>>>> Are there some examples/references on how to edit FDTs in-place in the
>>>>>>>>> kernel? I'd like to avoid writing the n-th FDT parser/generator.
>>>>>>>>
>>>>>>>> I don't know of any existing in-kernel edits of the FDT (but they might
>>>>>>>> exist).  The functions to access an FDT are in libfdt, which is in
>>>>>>>> scripts/dtc/libfdt/.
>>>>>>>
>>>>>>> Let's please not go down that route of doing FDT modifications. There
>>>>>>> is little reason to other than for early boot changes. And it is much
>>>>>>> easier to work on unflattened trees.
>>>>>>
>>>>>> I just briefly looked into libfdt, and it would have meant building it
>>>>>> into the module as there are no library functions exported by the kernel
>>>>>> either. Another reason to drop that.
>>>>>>
>>>>>> What's apparently working now is the pattern I initially suggested:
>>>>>> Register template with status = "disabled" as overlay, then prepare and
>>>>>> apply changeset that contains all needed modifications and sets the
>>>>>> status to "ok". I might be leaking additional resources, but to find
>>>>>> that out, I will now finally have to resolve clean unbinding of the
>>>>>> generic PCI host controller [1] first.
>>>>>
>>>>> static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>>>> {
>>>>> 	[...]
>>>>> 	/*
>>>>> 	 * TODO
>>>>> 	 *
>>>>> 	 * would like to: kfree(ovcs->overlay_tree);
>>>>> 	 * but can not since drivers may have pointers into this data
>>>>> 	 *
>>>>> 	 * would like to: kfree(ovcs->fdt);
>>>>> 	 * but can not since drivers may have pointers into this data
>>>>> 	 */
>>>>>
>>>>> 	kfree(ovcs);
>>>>> }
>>>>>
>>>>> What's this? I have kmemleak now jumping at me over this. Who is suppose
>>>>> to plug these leaks? The caller of of_overlay_fdt_apply has no pointers
>>>>> to those objects. I would say that's a regression of the new API.
>>>>
>>>> The problem already existed but it was hidden.  We have never been able to
>>>> kfree() these object because we do not know if there are any pointers into
>>>> these objects.  The new API makes the problem visible to kmemleak.
>>>
>>> My old code didn't have the problem because there was no one steeling
>>> pointers to my overlay, and I was able to safely release all the
>>> resources that I or the core on my behalf allocated. In fact, I recently
>>> even dropped the duplication the fdt prior to unflattening it because I
>>> got its lifecycle under control (and both kmemleak as well as kasan
>>> confirmed this). I still consider this intentional leak a regression of
>>> the new API.
>>
>> The API has to work for any user, not just your clean code.
>>
> 
> Please point us to code that does have a real problem. Is there any nice
> vendor tree, in addition to the known users? Or are we only speculating
> about how people might be (mis)using the API?

No, I will not even attempt to find such code.

The underlying problem is that the devicetree access API returns pointers
into the devicetree.  And we have no way of knowing whether any driver or
subsystem has a live pointer into the overlay data in the devicetree when
we remove an overlay.  The devicetree access API did not anticipate and
account for overlays.  As overlay related code has been added, this is an
issue that has not yet been fixed.


>>
>>>> The reason that we do not know if there are any pointers into these objects
>>>> is that devicetree access APIs return pointers into the devicetree internal
>>>> data structures (that is, into the overlay unflattened devicetree).  If we
>>>> want to be able to do the kfree()s, we could change the devicetree access
>>>> APIs.
>>>>
>>>> The reason that pointers into the overlay flattened tree (ovcs->fdt) are
>>>> also exposed is that the overlay unflattened devicetree property values
>>>> are pointers into the overlay fdt.
>>>>
>>>> ** This paragraph becomes academic (and not needed) if the fix in the next
>>>> paragraph can be implemented. **
>>>> I _think_ that the fdt issue __for overlays__ can be fixed somewhat easily.
>>>> (I would want to read through the code again to make sure I'm not missing
>>>> any issues.)  If the of_fdt_unflatten_tree() called by of_overlay_fdt_apply()
>>>> was modified so that property values were copied into newly allocated memory
>>>> and the live tree property pointers were set to the copy instead of to
>>>> the value in the fdt, then I _think_ the fdt could be freed in
>>>> of_overlay_fdt_apply() after calling of_overlay_apply().  The code that
>>>
>>> I don't see yet how more duplicating of objects would help. Then we
>>> would not leak the fdt or the unflattened tree on overlay destruction
>>> but that duplicates, no?
>>
>> Yes, we would leak the duplicates.  That is exactly what the existing
>> overlay remove code does.  My long term goal is to remove that leakage.
>> But that leakage can not be resolved until we can guarantee that there
>> are no pointers held to those duplicates.
>>
>> I don't like adding this additional copy - I would much prefer to change
>> the overlay notify code as proposed below.
>>
> 
> Replacing one leak with another is no solution.

I agree.  I do not see it as a viable solution.


> And if it's additionally
> enforcing an API change, I would call it counterproductive.
> 
>>
>>>> frees a devicetree would also have to be aware of this change -- I'm not
>>>> sure if that leads to ugly complications or if it is easy.  The other
>>>> question to consider is whether to make the same change to
>>>> of_fdt_unflatten_tree() when it is called in early boot to unflatten
>>>> the base devicetree.  Doing so would increase the memory usage of the
>>>> live tree (we would not be able to free the base fdt after unflattening
>>>> it because we make the fdt visible in /sys/firmware/fdt -- though
>>>> _maybe_ that could be conditioned on CONFIG_KEXEC).
>>>>
>>>> But all of the complexity of that fix is _only_ because of_overlay_apply()
>>>> and of_overlay_remove() call overlay_notify(), passing in the overlay
>>>> unflattened devicetree (which has pointers into the overlay fdt). Pointers
>>>> into the overlay unflattened devicetree are then passed to the notifiers.
>>>> (Again, I may be missing some other place that the overlay unflattened
>>>> devicetree is made visible to other code -- a more thorough reading of
>>>> the code is needed.) If the notifiers could be modified to accept the
>>>> changeset list instead of of pointers to the fragments in the overlay
>>>> unflattened devicetree then there would be no possibility of the notifiers
>>>> keeping a pointer into the overlay fdt. I do not know if this is a
>>>
>>> But then again the convention has to be that those changeset pointers
>>> must not be kept - because the changeset is history after of_overlay_remove.
>>
>> I don't trust convention.  The result is fragile code.
>>
> 
> Look, we are all programming in C here. There is no implicit reference
> counting, no garbage collecting, not strong typing, you-name-it. That
> doesn't leave you with many sharper weapons than well documented
> conventions.

Nope.  We can (hopefully) modify the devicetree access API so that it
does not return pointers into the devicetree.  For property values,
this is "easy", though at a cost.  Where the API currently returns
a pointer to a property (or property value), copy that data into
newly allocated memory and return a pointer to that newly allocated
memory -- the caller is now responsible for the new memory and there
is no stray pointer into the devicetree.  One other place that pointers
into the devicetree are exposed are the tree traversal APIs.  In theory
it should be possible to create an API that uses opaque "iterators"
(I'm probably mis-using that word) so that location in the tree while
traversing is not exposed in the form of a pointer into the devicetree.

-Frank

> I'm rather concerned that you are over-designing an API that, due to its
> nature, cannot be made foolproof.
> 
>>
>>>> practical change for the notifiers -- there are no callers of
>>>> of_overlay_notifier_register() in the mainline kernel source. My
>>>> recollection is that the overlay notifiers were added for the fpga
>>>> subsystem.
>>>
>>> We have drivers/fpga/of-fpga-region.c in-tree, and that does not seem to
>>
>> Thanks for finding that.  For some reason my 'git grep' did not find
>> that.  (I'll blame fat fingers or something...)
>>
>>
>>> store any pointers to objects, rather consumes them in-place. And I
>>> would consider it fair to impose such a limitation on the notifier
>>> interface.
>>
>> How do you enforce that limitation?
>>
> 
> Primarily, code review. Of course, we can't help out-of-tree adventurers
> this way but, well, they prefer to travel alone anyway.
> 
> And then there are also tools like kasan that can be very helpful
> revealing object lifecycle issues early.
> 
> Jan
> 
>>
>>>> Why is overlay_notify() the only issue related to unknown users having
>>>> pointers into the overlay fdt?  The answer is that the overlay code
>>>> does not directly expose the overlay unflattened devicetree (and thus
>>>> indirectly the overlay fdt) to the live devicetree -- when the
>>>> overlay code creates the overlay changeset, it copies from the
>>>> overlay unflattened devicetree and overlay fdt and only exposes
>>>> pointers to the copies.
>>>>
>>>> And hopefully the issues with the overlay unflattened devicetree can
>>>> be resolved in the same way as for the overlay fdt.
>>>
>>> As noted above, I don't see there is a technical solution to this issue
>>> but it's rather a matter of convention: no overlay notifier callback is
>>> allowed to keep references to the passed tree content (unless it
>>> reference-counts some tree nodes) beyond the execution of the callback.
>>> With that in place, we can safely drop the backing memory IMHO.
>>>
>>> Jan
>>> .
>>>
>>
> 
> 
