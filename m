Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeDYU1l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 16:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeDYU1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 16:27:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A726217D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AIpwx480Wud3stEJkZ7uUvQ9ngNm9gqP4GUmqkmZ60OtDBSSPsYOpD2jz/jWK4sxhMCnV3EM2f7LzwgzfwzUcifxdz0=
MIME-Version: 1.0
In-Reply-To: <4d1fa5a3-4d41-61a1-cd12-566e6622b90b@web.de>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de> <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
 <a21dbee8-6e4e-9ceb-c798-dda43c2eae2d@web.de> <d7e94a45-5d46-0491-e5dc-2b098a11c5b1@gmail.com>
 <CAL_Jsq+MmUTMrd+jNqUB2=A-q3cCy7+QWOKG0iF6zM0hjCy3PQ@mail.gmail.com>
 <e508f3de-f21b-2510-2c6a-b810073ba1a7@web.de> <e06d1c0f-f60d-fc23-cd74-82f557dbc432@web.de>
 <7bbb9472-9c96-6012-68e6-4ec2773c7732@gmail.com> <4483492d-37d2-63ad-6739-2cb297fa5058@gmail.com>
 <127c3c71-769e-32cf-72c1-6950382b8189@web.de> <cc66a8b3-9f26-166e-427b-b885a9009af7@gmail.com>
 <4d1fa5a3-4d41-61a1-cd12-566e6622b90b@web.de>
From: Alan Tull <atull@kernel.org>
Date: Wed, 25 Apr 2018 15:26:54 -0500
X-Gmail-Original-Message-ID: <CANk1AXQivdTt5TZOLxObeuy2EuL9pLUrW2OwPfryGk5r22ea+Q@mail.gmail.com>
Message-ID: <CANk1AXQivdTt5TZOLxObeuy2EuL9pLUrW2OwPfryGk5r22ea+Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jailhouse <jailhouse-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 3:07 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
> On 2018-04-25 20:40, Frank Rowand wrote:
>> On 04/24/18 22:23, Jan Kiszka wrote:
>>> On 2018-04-24 22:56, Frank Rowand wrote:
>>>> Hi Alan,
>>>>
>>>> On 04/23/18 15:38, Frank Rowand wrote:
>>>>> Hi Jan,
>>>>>
>>>>> + Alan Tull for fpga perspective
>>>>>
>>>>> On 04/22/18 03:30, Jan Kiszka wrote:
>>>>>> On 2018-04-11 07:42, Jan Kiszka wrote:
>>>>>>> On 2018-04-05 23:12, Rob Herring wrote:
>>>>>>>> On Thu, Apr 5, 2018 at 2:28 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>>>> On 04/05/18 12:13, Jan Kiszka wrote:
>>>>>>>>>> On 2018-04-05 20:59, Frank Rowand wrote:
>>>>>>>>>>> Hi Jan,
>>>>>>>>>>>
>>>>>>>>>>> On 04/04/18 15:35, Jan Kiszka wrote:
>>>>>>>>>>>> Hi Frank,
>>>>>>>>>>>>
>>>>>>>>>>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>>>>>>>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>>>>>>>>>>> (FDT) into the overlay application code.  To accomplish this,
>>>>>>>>>>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>>>>>>>>>>
>>>>>>>>>>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>>>>>>>>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>>>>>>>>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>>>>>>>>>>> original FDT.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>>>>>>>>>>> thus responsible for freeing the unflattened devicetree.
>>>>>>>>>>>>>
>>>>>>>>>>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>>>>>>>>>>> or the unflattened devicetree, which could result in use after free
>>>>>>>>>>>>> errors.
>>>>>>>>>>>>>
>>>>>>>>>>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>>>>>>>>>>> overlay loader.
>>>>>>>>>>>>
>>>>>>>>>>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>>>>>>>>>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>>>>>>>>>>> device during hypervisor activation with Linux. The DT overlay is
>>>>>>>>>>>> created from a a template but modified prior to application to account
>>>>>>>>>>>> for runtime-specific parameters. See [1] for the current implementation.
>>>>>>>>>>>>
>>>>>>>>>>>> I'm now wondering how to model that scenario best with the new API.
>>>>>>>>>>>> Given that the loader lost ownership of the unflattened tree but the
>>>>>>>>>>>> modification API exist only for the that DT state, I'm not yet seeing a
>>>>>>>>>>>> clear solution. Should we apply the template in disabled form (status =
>>>>>>>>>>>> "disabled"), modify it, and then activate it while it is already applied?
>>>>>>>>>>>
>>>>>>>>>>> Thank you for the pointer to the driver - that makes it much easier to
>>>>>>>>>>> understand the use case and consider solutions.
>>>>>>>>>>>
>>>>>>>>>>> If you can make the changes directly on the FDT instead of on the
>>>>>>>>>>> expanded devicetree, then you could move to the new API.
>>>>>>>>>>
>>>>>>>>>> Are there some examples/references on how to edit FDTs in-place in the
>>>>>>>>>> kernel? I'd like to avoid writing the n-th FDT parser/generator.
>>>>>>>>>
>>>>>>>>> I don't know of any existing in-kernel edits of the FDT (but they might
>>>>>>>>> exist).  The functions to access an FDT are in libfdt, which is in
>>>>>>>>> scripts/dtc/libfdt/.
>>>>>>>>
>>>>>>>> Let's please not go down that route of doing FDT modifications. There
>>>>>>>> is little reason to other than for early boot changes. And it is much
>>>>>>>> easier to work on unflattened trees.
>>>>>>>
>>>>>>> I just briefly looked into libfdt, and it would have meant building it
>>>>>>> into the module as there are no library functions exported by the kernel
>>>>>>> either. Another reason to drop that.
>>>>>>>
>>>>>>> What's apparently working now is the pattern I initially suggested:
>>>>>>> Register template with status = "disabled" as overlay, then prepare and
>>>>>>> apply changeset that contains all needed modifications and sets the
>>>>>>> status to "ok". I might be leaking additional resources, but to find
>>>>>>> that out, I will now finally have to resolve clean unbinding of the
>>>>>>> generic PCI host controller [1] first.
>>>>>>
>>>>>> static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>>>>> {
>>>>>>   [...]
>>>>>>   /*
>>>>>>    * TODO
>>>>>>    *
>>>>>>    * would like to: kfree(ovcs->overlay_tree);
>>>>>>    * but can not since drivers may have pointers into this data
>>>>>>    *
>>>>>>    * would like to: kfree(ovcs->fdt);
>>>>>>    * but can not since drivers may have pointers into this data
>>>>>>    */
>>>>>>
>>>>>>   kfree(ovcs);
>>>>>> }
>>>>>>
>>>>>> What's this? I have kmemleak now jumping at me over this. Who is suppose
>>>>>> to plug these leaks? The caller of of_overlay_fdt_apply has no pointers
>>>>>> to those objects. I would say that's a regression of the new API.
>>>>>
>>>>> The problem already existed but it was hidden.  We have never been able to
>>>>> kfree() these object because we do not know if there are any pointers into
>>>>> these objects.  The new API makes the problem visible to kmemleak.
>>>>>
>>>>> The reason that we do not know if there are any pointers into these objects
>>>>> is that devicetree access APIs return pointers into the devicetree internal
>>>>> data structures (that is, into the overlay unflattened devicetree).  If we
>>>>> want to be able to do the kfree()s, we could change the devicetree access
>>>>> APIs.
>>>>>
>>>>> The reason that pointers into the overlay flattened tree (ovcs->fdt) are
>>>>> also exposed is that the overlay unflattened devicetree property values
>>>>> are pointers into the overlay fdt.
>>>>>
>>>>> ** This paragraph becomes academic (and not needed) if the fix in the next
>>>>> paragraph can be implemented. **
>>>>> I _think_ that the fdt issue __for overlays__ can be fixed somewhat easily.
>>>>> (I would want to read through the code again to make sure I'm not missing
>>>>> any issues.)  If the of_fdt_unflatten_tree() called by of_overlay_fdt_apply()
>>>>> was modified so that property values were copied into newly allocated memory
>>>>> and the live tree property pointers were set to the copy instead of to
>>>>> the value in the fdt, then I _think_ the fdt could be freed in
>>>>> of_overlay_fdt_apply() after calling of_overlay_apply().  The code that
>>>>> frees a devicetree would also have to be aware of this change -- I'm not
>>>>> sure if that leads to ugly complications or if it is easy.  The other
>>>>> question to consider is whether to make the same change to
>>>>> of_fdt_unflatten_tree() when it is called in early boot to unflatten
>>>>> the base devicetree.  Doing so would increase the memory usage of the
>>>>> live tree (we would not be able to free the base fdt after unflattening
>>>>> it because we make the fdt visible in /sys/firmware/fdt -- though
>>>>> _maybe_ that could be conditioned on CONFIG_KEXEC).
>>>>
>>>> Question added below this paragraph.
>>>>
>>>>
>>>>> But all of the complexity of that fix is _only_ because of_overlay_apply()
>>>>> and of_overlay_remove() call overlay_notify(), passing in the overlay
>>>>> unflattened devicetree (which has pointers into the overlay fdt). Pointers
>>>>> into the overlay unflattened devicetree are then passed to the notifiers.
>>>>> (Again, I may be missing some other place that the overlay unflattened
>>>>> devicetree is made visible to other code -- a more thorough reading of
>>>>> the code is needed.) If the notifiers could be modified to accept the
>>>>> changeset list instead of of pointers to the fragments in the overlay
>>>>> unflattened devicetree then there would be no possibility of the notifiers
>>>>> keeping a pointer into the overlay fdt. I do not know if this is a
>>>>> practical change for the notifiers -- there are no callers of
>>>>> of_overlay_notifier_register() in the mainline kernel source. My
>>>>> recollection is that the overlay notifiers were added for the fpga
>>>>> subsystem.
>>>>
>>>> Can the fpga notifiers be changed to have the changeset as an input
>>>> instead of having the overlay devicetree fragment and target as an
>>>> input?
>>>>
>>>> The changeset lists nodes and properties to be added, but does not
>>>> expose any pointers to the overlay fdt or the overlay unflattened
>>>> devicetree.  This guarantees no leakage of pointers into the overlay
>>>> fdt or the overlay unflattened devicetree.  The changeset contains
>>>> pointers to copies of data, but those copies are never freed (and
>>>> thus they are yet another existing memory leak).
>>>
>>> Also they are freed, of course: When the last reference to the node they
>>> point to reaches 0 (e.g. triggered by of_changeset_destroy), that node
>>> goes away and takes down remaining dead properties. I've ran through
>>> this already. And I also made sure that my code is not triggering such
>>> kind of leaks as well.
>>
>> mea culpa.  I go around in circles while trying to remember all the
>> overlay related issues.  I needed to go back and read the code to
>> refresh my memory.  Thanks for the prod to re-read the code.
>>
>> Yes, of_changeset_destroy() will lead to the kfree() of the node and
>> it's properties _if_ the node reference count is correct.  So what I
>> said about a memory leak was incorrect in a perfect world (and my
>> memory was wrong).  However, this is not a perfect world and we know
>> that the reference count on devicetree nodes is often incorrect due
>> to bugs in common infrastructure and drivers.  This issue will not
>> be resolved until we pull all reference count manipulation into the
>> devicetree core.
>
> I don't get this yet. When I want some value from life tree, I do a node
> search, get a pointer and the core incremented its reference, can query
> the node and its properties, and when I'm done, I call of_node_put and
> forget about all pointers I got. What would you do differently?
>
>>  The net result is that we should not expect
>> overlay removal to correctly free all memory that was allocated
>> when applying the overlay.
>
> Depends on the overlay. If you do not modify existing nodes but only add
> new ones, it is fair to expect complete removal.
>
>>
>> I _think_ (but did not spend the time to verify) that there is a small
>> corner case memory leak even if the reference count on devicetree
>> nodes is correct.  If an overlay adds a property to an existing node
>> then removing the overlay will not kfree() the property, and it
>> will remain on the deadprops list.  There are some places that
>> properties are removed from deadprops, but I don't think they fully
>> resolve the issue.  Again, this is a corner case, and I am willing
>> to document it as a limitation until it gets fixed.

This doesn't solve all of your concern, but it gets me wondering
whether overlay_notify should add a of_node_get(fragment->overlay)
before doing the  blocking_notifier_call_chain and a of_node_put
afterwards.

>
> I ran into this the other day: If you modify an existing property, the
> old value will be put into deadprops and only be freed when the node is
> freed. It may come back from deadprops if a changeset comes around with
> the very same property object for another modification.
>
> But that means: if your overlay just adds nodes, all of them, including
> their deadprops from potential changes on top, will go away on overlay
> removal.
>
> BTW, here is my new code that exploits this to be leak-free:
> https://github.com/siemens/jailhouse/blob/156a93fcc02585d78d4418d3e6761cd72a65b359/driver/pci.c#L296
>
>>
>> Then returning to me going around in circles... This thread led me to
>> think that since since the overlay apply code copied data into never
>> freed memory (false premise, as you pointed out) that we did not
>> have to worry about drivers retaining pointers into overlay data
>> after the overlay had been freed (with the one remaining exposure
>> being via the overlay notifiers, which _might_ be easily resolved,
>> pending Alan's analysis) -- this would have been great news for
>> removing an issue for general use of overlays.
>>
>> But now we are back to the long-standing problem that we have no way
>> of knowing whether there are any live pointers to the memory that is
>> freed by of_changeset_destroy().  And I am not aware of any solution
>> to this problem other than changing the devicetree access API so that
>> it never returns any pointer into the live devicetree.
>
> I don't agree yet with this drastic measure until you can point me to
> code that pulls and stores pointers to arbitrary devicetree content
> without that node reference counting. The pattern we otherwise see all
> around it you get a pointer (or a set of them) along with the duty to
> explicitly drop it again by some put() operation.
>
>>
>> The practical impact of all of this, is if we can change the overlay
>> notifier parameters to include the overlay changeset instead of
>> the overlay devicetree, then I think that of_overlay_apply() will
>> be able to kfree() the overlay fdt and overlay devicetree.  And
>> if not of_overlay_apply(), then free_overlay_changeset().
>
> Isn't that just s/node/changeset/ without any other semantic changes? If
> the receiver of the changeset reference does not take care of lifecycle
> management for that object either, we are back at square #1. A changeset
> is just a gate to the nodes and properties that are currently passed
> directly.
>
> Jan
