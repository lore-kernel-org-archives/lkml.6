Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932100AbeDYRlj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:41:39 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39081 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756042AbeDYRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:41:33 -0400
X-Google-Smtp-Source: AB8JxZoKotiMZFHPTdkIToi22K8QStZSzW851n/dP8rp3gwLD6lHAZe6WWPCByv/zRysCY7OaCo2jw==
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Alan Tull <atull@kernel.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
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
 <4483492d-37d2-63ad-6739-2cb297fa5058@gmail.com>
 <CANk1AXQbZ=DjDYfeOTdc6bq2oSN91Uc2coa_R3xD1wrafhcf+w@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <2e36bae1-b83d-2955-0f45-90b7944b552d@gmail.com>
Date: Wed, 25 Apr 2018 10:41:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANk1AXQbZ=DjDYfeOTdc6bq2oSN91Uc2coa_R3xD1wrafhcf+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/18 07:59, Alan Tull wrote:
> On Tue, Apr 24, 2018 at 3:56 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> Hi Alan,
>>
>> On 04/23/18 15:38, Frank Rowand wrote:
>>> Hi Jan,
>>>
>>> + Alan Tull for fpga perspective
>>>
>>> On 04/22/18 03:30, Jan Kiszka wrote:
>>>> On 2018-04-11 07:42, Jan Kiszka wrote:
>>>>> On 2018-04-05 23:12, Rob Herring wrote:
>>>>>> On Thu, Apr 5, 2018 at 2:28 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>> On 04/05/18 12:13, Jan Kiszka wrote:
>>>>>>>> On 2018-04-05 20:59, Frank Rowand wrote:
>>>>>>>>> Hi Jan,
>>>>>>>>>
>>>>>>>>> On 04/04/18 15:35, Jan Kiszka wrote:
>>>>>>>>>> Hi Frank,
>>>>>>>>>>
>>>>>>>>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>>>>>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>>>>>>>
>>>>>>>>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>>>>>>>>> (FDT) into the overlay application code.  To accomplish this,
>>>>>>>>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>>>>>>>>
>>>>>>>>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>>>>>>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>>>>>>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>>>>>>>>> original FDT.
>>>>>>>>>>>
>>>>>>>>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>>>>>>>>> thus responsible for freeing the unflattened devicetree.
>>>>>>>>>>>
>>>>>>>>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>>>>>>>>> or the unflattened devicetree, which could result in use after free
>>>>>>>>>>> errors.
>>>>>>>>>>>
>>>>>>>>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>>>>>>>>> overlay loader.
>>>>>>>>>>
>>>>>>>>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>>>>>>>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>>>>>>>>> device during hypervisor activation with Linux. The DT overlay is
>>>>>>>>>> created from a a template but modified prior to application to account
>>>>>>>>>> for runtime-specific parameters. See [1] for the current implementation.
>>>>>>>>>>
>>>>>>>>>> I'm now wondering how to model that scenario best with the new API.
>>>>>>>>>> Given that the loader lost ownership of the unflattened tree but the
>>>>>>>>>> modification API exist only for the that DT state, I'm not yet seeing a
>>>>>>>>>> clear solution. Should we apply the template in disabled form (status =
>>>>>>>>>> "disabled"), modify it, and then activate it while it is already applied?
>>>>>>>>>
>>>>>>>>> Thank you for the pointer to the driver - that makes it much easier to
>>>>>>>>> understand the use case and consider solutions.
>>>>>>>>>
>>>>>>>>> If you can make the changes directly on the FDT instead of on the
>>>>>>>>> expanded devicetree, then you could move to the new API.
>>>>>>>>
>>>>>>>> Are there some examples/references on how to edit FDTs in-place in the
>>>>>>>> kernel? I'd like to avoid writing the n-th FDT parser/generator.
>>>>>>>
>>>>>>> I don't know of any existing in-kernel edits of the FDT (but they might
>>>>>>> exist).  The functions to access an FDT are in libfdt, which is in
>>>>>>> scripts/dtc/libfdt/.
>>>>>>
>>>>>> Let's please not go down that route of doing FDT modifications. There
>>>>>> is little reason to other than for early boot changes. And it is much
>>>>>> easier to work on unflattened trees.
>>>>>
>>>>> I just briefly looked into libfdt, and it would have meant building it
>>>>> into the module as there are no library functions exported by the kernel
>>>>> either. Another reason to drop that.
>>>>>
>>>>> What's apparently working now is the pattern I initially suggested:
>>>>> Register template with status = "disabled" as overlay, then prepare and
>>>>> apply changeset that contains all needed modifications and sets the
>>>>> status to "ok". I might be leaking additional resources, but to find
>>>>> that out, I will now finally have to resolve clean unbinding of the
>>>>> generic PCI host controller [1] first.
>>>>
>>>> static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>>> {
>>>>      [...]
>>>>      /*
>>>>       * TODO
>>>>       *
>>>>       * would like to: kfree(ovcs->overlay_tree);
>>>>       * but can not since drivers may have pointers into this data
>>>>       *
>>>>       * would like to: kfree(ovcs->fdt);
>>>>       * but can not since drivers may have pointers into this data
>>>>       */
>>>>
>>>>      kfree(ovcs);
>>>> }
>>>>
>>>> What's this? I have kmemleak now jumping at me over this. Who is suppose
>>>> to plug these leaks? The caller of of_overlay_fdt_apply has no pointers
>>>> to those objects. I would say that's a regression of the new API.
>>>
>>> The problem already existed but it was hidden.  We have never been able to
>>> kfree() these object because we do not know if there are any pointers into
>>> these objects.  The new API makes the problem visible to kmemleak.
>>>
>>> The reason that we do not know if there are any pointers into these objects
>>> is that devicetree access APIs return pointers into the devicetree internal
>>> data structures (that is, into the overlay unflattened devicetree).  If we
>>> want to be able to do the kfree()s, we could change the devicetree access
>>> APIs.
>>>
>>> The reason that pointers into the overlay flattened tree (ovcs->fdt) are
>>> also exposed is that the overlay unflattened devicetree property values
>>> are pointers into the overlay fdt.
>>>
>>> ** This paragraph becomes academic (and not needed) if the fix in the next
>>> paragraph can be implemented. **
>>> I _think_ that the fdt issue __for overlays__ can be fixed somewhat easily.
>>> (I would want to read through the code again to make sure I'm not missing
>>> any issues.)  If the of_fdt_unflatten_tree() called by of_overlay_fdt_apply()
>>> was modified so that property values were copied into newly allocated memory
>>> and the live tree property pointers were set to the copy instead of to
>>> the value in the fdt, then I _think_ the fdt could be freed in
>>> of_overlay_fdt_apply() after calling of_overlay_apply().  The code that
>>> frees a devicetree would also have to be aware of this change -- I'm not
>>> sure if that leads to ugly complications or if it is easy.  The other
>>> question to consider is whether to make the same change to
>>> of_fdt_unflatten_tree() when it is called in early boot to unflatten
>>> the base devicetree.  Doing so would increase the memory usage of the
>>> live tree (we would not be able to free the base fdt after unflattening
>>> it because we make the fdt visible in /sys/firmware/fdt -- though
>>> _maybe_ that could be conditioned on CONFIG_KEXEC).
>>
>> Question added below this paragraph.
>>
>>
>>> But all of the complexity of that fix is _only_ because of_overlay_apply()
>>> and of_overlay_remove() call overlay_notify(), passing in the overlay
>>> unflattened devicetree (which has pointers into the overlay fdt). Pointers
>>> into the overlay unflattened devicetree are then passed to the notifiers.
>>> (Again, I may be missing some other place that the overlay unflattened
>>> devicetree is made visible to other code -- a more thorough reading of
>>> the code is needed.) If the notifiers could be modified to accept the
>>> changeset list instead of of pointers to the fragments in the overlay
>>> unflattened devicetree then there would be no possibility of the notifiers
>>> keeping a pointer into the overlay fdt. I do not know if this is a
>>> practical change for the notifiers -- there are no callers of
>>> of_overlay_notifier_register() in the mainline kernel source. My
>>> recollection is that the overlay notifiers were added for the fpga
>>> subsystem.
>>
>> Can the fpga notifiers be changed to have the changeset as an input
>> instead of having the overlay devicetree fragment and target as an
>> input?
> 
> I'll look into it.  Just to be clear, are you suggesting passing
> struct overlay_changeset instead in the notifier?

Ah, poor phrasing on my part.  I meant a "struct of_changeset", as is
passed into __of_changeset_apply_entries(), which is called from
of_overlay_apply().  This means that the call to overlay_notify()
would have to move down a few lines to just after calling
build_changeset().


> struct overlay_changeset and struct fragment would have to be moved to a header.
> 
>>
>> The changeset lists nodes and properties to be added, but does not
>> expose any pointers to the overlay fdt or the overlay unflattened
>> devicetree.  This guarantees no leakage of pointers into the overlay
>> fdt or the overlay unflattened devicetree.  The changeset contains
>> pointers to copies of data, but those copies are never freed (and
>> thus they are yet another existing memory leak).
>>
>> -Frank
>>
>>> Why is overlay_notify() the only issue related to unknown users having
>>> pointers into the overlay fdt?  The answer is that the overlay code
>>> does not directly expose the overlay unflattened devicetree (and thus
>>> indirectly the overlay fdt) to the live devicetree -- when the
>>> overlay code creates the overlay changeset, it copies from the
>>> overlay unflattened devicetree and overlay fdt and only exposes
>>> pointers to the copies.
>>>
>>> And hopefully the issues with the overlay unflattened devicetree can
>>> be resolved in the same way as for the overlay fdt.
>>>
>>> -Frank
>>>
>>>
>>>
>>
> 
