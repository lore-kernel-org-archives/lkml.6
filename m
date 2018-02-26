Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeBZLiD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:38:03 -0500
Received: from foss.arm.com ([217.140.101.70]:48940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbeBZLiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:38:00 -0500
Subject: Re: [RFC PATCH] irqchip/gic-v3-its: apply ACPI device based quirks
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180213141118.3092-1-ard.biesheuvel@linaro.org>
 <f0a6a635-0b0f-01d1-bc64-3d3d95b5de0b@arm.com>
 <CAKv+Gu_Em_QFpGeRWra0uBxOm7rbhc12waxhCRd5tmRyqt1yrg@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <2d038761-66f2-026e-6255-964bbad6c20e@arm.com>
Date: Mon, 26 Feb 2018 11:37:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_Em_QFpGeRWra0uBxOm7rbhc12waxhCRd5tmRyqt1yrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/18 11:09, Ard Biesheuvel wrote:
> On 26 February 2018 at 10:18, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Hi Ard,
>>
>> On 13/02/18 14:11, Ard Biesheuvel wrote:
>>> Reapply the SynQuacer quirk for ITS frames that are matched by 'SCX0005'
>>> based ACPI devices, replacing the dummy fwnode with the one populated by
>>> the ACPI device core.
>>>
>>> This allows the SynQuacer ACPI tables to publish a device node such
>>> as
>>>
>>>     Device (ITS0) {
>>>       Name (_HID, "SCX0005")
>>>       Name (_ADR, 0x30020000)
>>>       Name (_DSD, Package ()  // _DSD: Device-Specific Data
>>>       {
>>>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>>         Package () {
>>>           Package (2) {
>>>             "socionext,synquacer-pre-its",
>>>             Package () { 0x58000000, 0x200000 }
>>>           },
>>>         }
>>>       })
>>>     }
>>>
>>> which will trigger the existing quirk that replaces the doorbell
>>> address with the appropriate address in the pre-ITS frame.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>> Marc, Lorenzo,
>>>
>>> I am aware that this patch may be seen as controversial, but I would like to
>>> propose it nonetheless. The reason is that this is the only thing standing in
>>> the way of full ACPI support in Socionext SynQuacer based platforms.
>>>
>>> The pre-ITS is a monstrosity, but as it turns out, Socionext had help from
>>> ARM designing it, and the reason we need DT/ACPI based quirks in the first
>>> place is that the IIDR of this GICv3 implementation is simply the ARM Ltd.
>>> one (as they designed the IP)
>>
>> That's odd. A bit of archaeology shows that ARM indeed designed a
>> pre-ITS, but that one doesn't break isolation at all (it still has a
>> single doorbell). So whatever creative changes Socionext applied to that
>> piece of IP (assuming this is the same IP), they didn't really
>> understand the far reaching impact it has.
>>
> 
> OK, thanks for digging that up. All the information I have on this
> topic is second hand, and I had no reason to assume their account of
> the history was inaccurate.

No worries. There is a short description of the PITS in the integration
guide, but I don't think that's available to the mere mortal, unfortunately.

> 
>>>
>>> Please take this into consideration when reviewing this patch,
>>>
>>> Thanks,
>>> Ard.
>>>
>>>  drivers/irqchip/irq-gic-v3-its.c | 39 ++++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>> index 06f025fd5726..a63973baf08a 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -3517,3 +3517,42 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>>>
>>>       return 0;
>>>  }
>>> +
>>> +#if defined(CONFIG_SOCIONEXT_SYNQUACER_PREITS) && defined(CONFIG_ACPI)
>>> +static acpi_status __init acpi_its_device_probe (acpi_handle handle,
>>> +                                              u32 depth, void *context,
>>> +                                              void **ret)
>>> +{
>>> +     struct acpi_device *adev;
>>> +     unsigned long long phys_base;
>>> +     struct its_node *its;
>>> +     acpi_status status;
>>> +     int err;
>>> +
>>> +     err = acpi_bus_get_device(handle, &adev);
>>> +     if (err)
>>> +             return AE_CTRL_TERMINATE;
>>> +
>>> +     status = acpi_evaluate_integer(handle, "_ADR", NULL, &phys_base);
>>> +     if (ACPI_FAILURE(status))
>>> +             return status;
>>> +
>>> +     list_for_each_entry(its, &its_nodes, entry)
>>> +             if (its->phys_base == phys_base) {
>>> +                     irq_domain_free_fwnode(its->fwnode_handle);
>>
>> That line scares me. What about irq domains that are hold a pointer to
>> this handle? its_init_domain() uses it to construct the LPI domain, and
>> it is now pointing to some free memory.
>>
>> You'd need to reassign all the domains that match this fwnode before
>> freeing it.
>>
> 
> OK, I can iterate over the domains using irq_find_matching_fwspec()
> and update the handles one by one. Not pretty, but that is a lost
> cause anyway for this patch.

Yeah, that should do the trick.

> 
>>> +                     its->fwnode_handle = &adev->fwnode;
>>> +                     its_enable_quirk_socionext_synquacer(its);
>>> +                     break;
>>> +             }
>>> +
>>> +     return AE_CTRL_TERMINATE;
>>> +}
>>> +
>>> +static int __init acpi_its_device_probe_init(void)
>>> +{
>>> +     if (!acpi_disabled)
>>> +             acpi_get_devices("SCX0005", acpi_its_device_probe, NULL, NULL);
>>> +     return 0;
>>> +}
>>> +subsys_initcall_sync(acpi_its_device_probe_init);
>>> +#endif
>>>
>>
>> Is there any chance that MSIs could be allocated before this kicks in?
>> If that happens, we're in trouble...
> 
> This SoC does not have any MSI capable platform devices, so the only
> consumers are PCI devices, and PCI drivers are registered as a
> device_initcal().

Ideally, we'd only do the reasignment if domain->mapcount is zero.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
