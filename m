Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeDZAU4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 20:20:56 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:40906 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeDZAUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 20:20:52 -0400
X-Google-Smtp-Source: AIpwx4/Qwpw8Iu7rI6QWnLi85JQax+cCOBomk5/z9f44wT381+stw1ntAO6l+hHDco4YEL5zZBQTeg==
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
 <4483492d-37d2-63ad-6739-2cb297fa5058@gmail.com>
 <127c3c71-769e-32cf-72c1-6950382b8189@web.de>
 <cc66a8b3-9f26-166e-427b-b885a9009af7@gmail.com>
 <4d1fa5a3-4d41-61a1-cd12-566e6622b90b@web.de>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <4909967a-0e29-ebba-e082-08d076106fcf@gmail.com>
Date: Wed, 25 Apr 2018 17:20:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4d1fa5a3-4d41-61a1-cd12-566e6622b90b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan, Alan,

On 04/25/18 13:07, Jan Kiszka wrote:
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
>>>>>> 	[...]
>>>>>> 	/*
>>>>>> 	 * TODO
>>>>>> 	 *
>>>>>> 	 * would like to: kfree(ovcs->overlay_tree);
>>>>>> 	 * but can not since drivers may have pointers into this data
>>>>>> 	 *
>>>>>> 	 * would like to: kfree(ovcs->fdt);
>>>>>> 	 * but can not since drivers may have pointers into this data
>>>>>> 	 */
>>>>>>
>>>>>> 	kfree(ovcs);
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

I don't know what causes the refcount errors.  I started looking at the
issue a couple of years ago, but did not finish and the issue did not
remain high enough of my todo list.

I added a printk() to of_node_get() and of_node_put(), then post
processed the console log to see where the reference count was being
modified.  I also had a version of the patch that also printed the call
stack so I could better investigate where the gets and puts were invoked
from.

Here is an example from a random 4.11-rc1 boot (the columns are
address of the device_node, minimum reference count seen, maximum
reference count seen, final reference count after the system
was booted, and full path of the node):

0xeefe759c    2   23   23  /
0xeefeaec8    2    4    3  /adsp-pil
0xeefe78a0    2    3    3  /aliases
0xeefe7734    2    3    3  /chosen
0xeefea9fc    2    4    4  /clocks
0xeefeac48    2    3    3  /clocks/sleep_clk
0xeefeaa98    2    3    3  /clocks/xo_board
0xeefea8f4    2    4    3  /cpu-pmu
0xeefe86f8    2   10   10  /cpus
0xeefe8830    2    4    4  /cpus/cpu@0
0xeefe8a6c    2    4    4  /cpus/cpu@1
0xeefe8ca8    2    4    4  /cpus/cpu@2
0xeefe8ee4    2    4    4  /cpus/cpu@3
0xeefe92cc    2    2    2  /cpus/idle-states
0xeefe9378    2    6    6  /cpus/idle-states/spc
0xeefe9120    2    2    2  /cpus/l2-cache
0xeefec7e4    2    4    2  /firmware
0xeefec888    2    4    3  /firmware/scm
0xeefe79dc    2    2    2  /memory
0xeefe7ae0    2   11   11  /reserved-memory
0xeefe8224    2    3    2  /reserved-memory/smem@fa00000
0xeeff5010    5    7    6  /smd
0xeeff50dc    2    4    3  /smd/adsp
0xeeff5218    2    4    3  /smd/modem
0xeeff5354    3    5    4  /smd/rpm
0xeeff548c    4    6    5  /smd/rpm/rpm_requests
0xeeff55a8    3   12    3  /smd/rpm/rpm_requests/pm8841-regulators
0xeeff56a4    2    4    4  /smd/rpm/rpm_requests/pm8841-regulators/s1
0xeeff57c8    2    4    4  /smd/rpm/rpm_requests/pm8841-regulators/s2
0xeeff5954    2    4    4  /smd/rpm/rpm_requests/pm8841-regulators/s3
0xeeff5a78    2    4    4  /smd/rpm/rpm_requests/pm8841-regulators/s4
0xeeff5b9c    2    4    4  /smd/rpm/rpm_requests/pm8841-regulators/s5
0xeeff5c58    2    4    4  /smd/rpm/rpm_requests/pm8841-regulators/s6
0xeeff5d14    2    4    4  /smd/rpm/rpm_requests/pm8841-regulators/s7
0xeeff5dd0    2    3    3  /smd/rpm/rpm_requests/pm8841-regulators/s8
0xeeff5e8c    3   37    3  /smd/rpm/rpm_requests/pm8941-regulators
0xeeff8a18    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/5vs1
0xeeff8adc    2    3    3  /smd/rpm/rpm_requests/pm8941-regulators/5vs2
0xeeff678c    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l1
0xeeff7308    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l10
0xeeff7460    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l11
0xeeff7584    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l12
0xeeff7710    2    7    7  /smd/rpm/rpm_requests/pm8941-regulators/l13
0xeeff78d0    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l14
0xeeff79f4    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l15
0xeeff7b18    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l16
0xeeff7c3c    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l17
0xeeff7d60    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l18
0xeeff7e84    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l19
0xeeff6918    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l2
0xeeff7fdc    2    7    7  /smd/rpm/rpm_requests/pm8941-regulators/l20
0xeeff8204    2    7    7  /smd/rpm/rpm_requests/pm8941-regulators/l21
0xeeff83c4    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l22
0xeeff84e8    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l23
0xeeff860c    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l24
0xeeff6a3c    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l3
0xeeff6b60    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l4
0xeeff6c84    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l5
0xeeff6da8    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l6
0xeeff6f68    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l7
0xeeff70c0    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l8
0xeeff71e4    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/l9
0xeeff87cc    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/lvs1
0xeeff8890    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/lvs2
0xeeff8954    2    4    4  /smd/rpm/rpm_requests/pm8941-regulators/lvs3
0xeeff60c0    2    8    8  /smd/rpm/rpm_requests/pm8941-regulators/s1
0xeeff62b4    2   10   10  /smd/rpm/rpm_requests/pm8941-regulators/s2
0xeeff6474    2   11   11  /smd/rpm/rpm_requests/pm8941-regulators/s3
0xeeff6668    2    5    5  /smd/rpm/rpm_requests/pm8941-regulators/s4
0xeefeb0d8    2    4    3  /smem
0xeefeb244    2    6    5  /smp2p-adsp
0xeefeb5dc    2   12   12  /smp2p-adsp/slave-kernel
0xeefeb798    2    6    5  /smp2p-modem
0xeefebc20    2    6    5  /smp2p-wcnss
0xeefec0a8    2    8    7  /smsm
0xeefec9c4    2   37   36  /soc
0xeefee954    2    4    3  /soc/clock-controller@f9088000
0xeefeeae4    2    4    3  /soc/clock-controller@f9098000
0xeefeec74    2    4    3  /soc/clock-controller@f90a8000
0xeefeee04    2    4    3  /soc/clock-controller@f90b8000
0xeefef0a8    2    5    5  /soc/clock-controller@fc400000
0xeefef450    2    4    4  /soc/clock-controller@fd8c0000
0xeeff471c    2    4    3  /soc/dma-controller@f9944000
0xeeff194c    2    2    2  /soc/i2c@f9924000
0xeeff1b90    2    2    2  /soc/i2c@f9964000
0xeeff1dd4    2    5    5  /soc/i2c@f9967000
0xeeff211c    2    3    3  /soc/i2c@f9967000/eeprom@52
0xeefecb2c    2   75   74  /soc/interrupt-controller@f9000000
0xeefef7c0    2    4    3  /soc/memory@fc428000
0xeeff0578    2   10   10  /soc/pinctrl@fd510000
0xeeff07f8    3    4    3  /soc/pinctrl@fd510000/i2c11
0xeeff0910    2    2    2  /soc/pinctrl@fd510000/i2c11/mux
0xeeff0f70    4    5    4  /soc/pinctrl@fd510000/sdhc1-pin-active
0xeeff10a0    2    2    2  /soc/pinctrl@fd510000/sdhc1-pin-active/clk
0xeeff11f8    2    2    2  /soc/pinctrl@fd510000/sdhc1-pin-active/cmd-data
0xeeff135c    2    3    2  /soc/pinctrl@fd510000/sdhc2-cd-pin-active
0xeeff1560    4    5    4  /soc/pinctrl@fd510000/sdhc2-pin-active
0xeeff1690    2    2    2  /soc/pinctrl@fd510000/sdhc2-pin-active/clk
0xeeff17e8    2    2    2  /soc/pinctrl@fd510000/sdhc2-pin-active/cmd-data
0xeeff0a28    6    6    6  /soc/pinctrl@fd510000/spi8_default
0xeefee790    2    4    3  /soc/power-controller@f9012000
0xeefee150    2    4    3  /soc/power-controller@f9089000
0xeefee2e0    2    4    3  /soc/power-controller@f9099000
0xeefee470    2    4    3  /soc/power-controller@f90a9000
0xeefee600    2    4    3  /soc/power-controller@f90b9000
0xeefecea8    2    7    7  /soc/qfprom@fc4bc000
0xeefed174    2    2    2  /soc/qfprom@fc4bc000/backup@440
0xeefed024    2    2    2  /soc/qfprom@fc4bc000/calib@d0
0xeefeef94    2    4    3  /soc/restart@fc4ab000
0xeeff0404    2    4    3  /soc/rng@f9bff000
0xeefefd04    2    4    4  /soc/sdhci@f9824900
0xeeff0084    2    4    4  /soc/sdhci@f98a4900
0xeefef93c    2    2    2  /soc/serial@f991d000
0xeefefb20    2    6    5  /soc/serial@f991e000
0xeeff229c    2  238  237  /soc/spmi@fc4cf000
0xeeff25e8    2    7    5  /soc/spmi@fc4cf000/pm8841@4
0xeeff2768    2    4    4  /soc/spmi@fc4cf000/pm8841@4/mpps@a000
0xeeff2928    2    4    3  /soc/spmi@fc4cf000/pm8841@4/temp-alarm@2400
0xeeff2a88    2    3    2  /soc/spmi@fc4cf000/pm8841@5
0xeeff2c08    2   14   12  /soc/spmi@fc4cf000/pm8941@0
0xeeff30d0    2    4    2  /soc/spmi@fc4cf000/pm8941@0/charger@1000
0xeeff42b0    2    2    2  /soc/spmi@fc4cf000/pm8941@0/coincell@2800
0xeeff3260    3    5    5  /soc/spmi@fc4cf000/pm8941@0/gpios@c000
0xeeff3488    2    3    2  /soc/spmi@fc4cf000/pm8941@0/gpios@c000/boost-bypass
0xeeff4124    2    4    3  /soc/spmi@fc4cf000/pm8941@0/iadc@3600
0xeeff3628    2    4    4  /soc/spmi@fc4cf000/pm8941@0/mpps@a000
0xeeff2f10    2    4    3  /soc/spmi@fc4cf000/pm8941@0/pwrkey@800
0xeeff2d88    2    4    3  /soc/spmi@fc4cf000/pm8941@0/rtc@6000
0xeeff37e8    2    4    3  /soc/spmi@fc4cf000/pm8941@0/temp-alarm@2400
0xeeff39e4    7    9    8  /soc/spmi@fc4cf000/pm8941@0/vadc@3100
0xeeff4410    3    4    3  /soc/spmi@fc4cf000/pm8941@1
0xeeff4590    2    2    2  /soc/spmi@fc4cf000/pm8941@1/wled@d800
0xeefecd2c    2    5    5  /soc/syscon@f9011000
0xeefef2d4    2    4    3  /soc/syscon@fd484000
0xeefef614    2    4    3  /soc/tcsr-mutex
0xeefed2c4    2    4    3  /soc/thermal-sensor@fc4a8000
0xeefed4ec    2   11   10  /soc/timer@f9020000
0xeefed6cc    2    3    3  /soc/timer@f9020000/frame@f9021000
0xeeff49ac    2    2    2  /soc/usb-phy@f9a55000
0xeeff4e00    2    2    2  /soc/usb@f9a55000
0xeefe9558    2    6    6  /thermal-zones
0xeefe9604    3    3    3  /thermal-zones/cpu-thermal0
0xeefe9758    4    4    4  /thermal-zones/cpu-thermal0/trips
0xeefe9810    2    3    3  /thermal-zones/cpu-thermal0/trips/trip0
0xeefe9968    2    3    3  /thermal-zones/cpu-thermal0/trips/trip1
0xeefe9ac0    3    3    3  /thermal-zones/cpu-thermal1
0xeefe9c14    4    4    4  /thermal-zones/cpu-thermal1/trips
0xeefe9ccc    2    3    3  /thermal-zones/cpu-thermal1/trips/trip0
0xeefe9e24    2    3    3  /thermal-zones/cpu-thermal1/trips/trip1
0xeefe9f7c    3    3    3  /thermal-zones/cpu-thermal2
0xeefea0d0    4    4    4  /thermal-zones/cpu-thermal2/trips
0xeefea188    2    3    3  /thermal-zones/cpu-thermal2/trips/trip0
0xeefea2e0    2    3    3  /thermal-zones/cpu-thermal2/trips/trip1
0xeefea438    3    3    3  /thermal-zones/cpu-thermal3
0xeefea58c    4    4    4  /thermal-zones/cpu-thermal3/trips
0xeefea644    2    3    3  /thermal-zones/cpu-thermal3/trips/trip0
0xeefea79c    2    3    3  /thermal-zones/cpu-thermal3/trips/trip1
0xeefead90    2    4    3  /timer
0xeeff8ba0    2    4    4  /vreg-boost
0xeeff8e4c    2    4    3  /vreg-vph-pwr

> 
>>  The net result is that we should not expect
>> overlay removal to correctly free all memory that was allocated
>> when applying the overlay.
> 
> Depends on the overlay. If you do not modify existing nodes but only add
> new ones, it is fair to expect complete removal.

Only if reference counts are correct.  I assert that reference counts are
often not correct.


>>
>> I _think_ (but did not spend the time to verify) that there is a small
>> corner case memory leak even if the reference count on devicetree
>> nodes is correct.  If an overlay adds a property to an existing node
>> then removing the overlay will not kfree() the property, and it
>> will remain on the deadprops list.  There are some places that
>> properties are removed from deadprops, but I don't think they fully
>> resolve the issue.  Again, this is a corner case, and I am willing
>> to document it as a limitation until it gets fixed.
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

And we have long history of these rules not being followed.  Evidence
is the patches we get to correct incorrect of_node_get() / of_node_put()
usage and the random node reference count report I included above.

That is also conflating the issue of reference counts being correct
and whether pointers are held after a reference count is decremented.
I am not going to audit the kernel and future patches to ensure that.


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

Sigh.  Yes.  Thanks for pointing that out.

So my thought of changing the arguments of the overlay notifier was wrong
and we should just stick with the current calling convention for the
overlay notifiers.  But we need to document the "no retaining pointers
into the overlay devicetree" for the overlay notifiers.

Thank you Alan for looking into the alternative approach.

OK, being pragmatic about not letting failure to achieve perfection stand
in the way of achieving good enough -- I am willing to accept the review
burden of overlay notifiers and that review will be an acceptable defense
against errors for the overlay notifiers.  Although my long-term goal is
to change to devicetree access APIs to not return pointers into the
devicetree (in this case, the overlay devicetree, not the live devicetree)
to preclude the possibility of pointer leakage.

I will repeat this conditional acceptance in reply to the proposed patch
that you sent.

-Frank

> 
> Jan
> .
> 
