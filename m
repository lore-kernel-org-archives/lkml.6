Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeCOJ0K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:26:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35870 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeCOJ0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:26:07 -0400
Subject: Re: [PATCH v7 1/3] irqchip/gic-v3-its: add ability to save/restore
 ITS state
To: "dbasehore ." <dbasehore@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soby Mathew <Soby.Mathew@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Norris <briannorris@chromium.org>
References: <20180301054820.42847-1-dbasehore@chromium.org>
 <20180301054820.42847-2-dbasehore@chromium.org>
 <20180301114144.nmwu4qtslvj7ogj5@lakrids.cambridge.arm.com>
 <0a74f87a-027a-df7d-ca2d-fc164ec9cdf7@arm.com>
 <CAGAzgsqLgujex--HCo3dRGvOPXG0zu-RwkbuGhgNhBTc3sURJA@mail.gmail.com>
 <6a5b5723-85bb-e46f-f621-eab17a01f1f0@arm.com>
 <CAGAzgspNsybYfxwKOERJCU9oFvEjxOA41KT+4L5f6Zr=+WXO9w@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <de16cf45-544c-b534-62c6-f8a2b64535e7@arm.com>
Date: Thu, 15 Mar 2018 09:26:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGAzgspNsybYfxwKOERJCU9oFvEjxOA41KT+4L5f6Zr=+WXO9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/18 21:44, dbasehore . wrote:
> On Wed, Mar 14, 2018 at 3:22 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 02/03/18 02:08, dbasehore . wrote:
>>> On Thu, Mar 1, 2018 at 4:29 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> Hi Mark,
>>>>
>>>> On 01/03/18 11:41, Mark Rutland wrote:
>>>>> On Wed, Feb 28, 2018 at 09:48:18PM -0800, Derek Basehore wrote:
>>>>>> Some platforms power off GIC logic in suspend, so we need to
>>>>>> save/restore state. The distributor and redistributor registers need
>>>>>> to be handled in platform code due to access permissions on those
>>>>>> registers, but the ITS registers can be restored in the kernel.
>>>>>>
>>>>>> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
>>>>>
>>>>> How much state do we have to save/restore?
>>>>>
>>>>> Given we can apparently read all this state, couldn't we *always* save
>>>>> the state, then upon resume detect if the state has been lost, restoring
>>>>> it if so?
>>>>>
>>>>> That way, we don't need a property in FW tables for DT or ACPI.
>>>>
>>>> That's a good point. I guess that we could just compare the saved
>>>> GITS_CTLR register and restore the full state only if the ITS comes back
>>>> as disabled.
>>>>
>>>> I'm just a bit worried that it makes it an implicit convention between
>>>> kernel an FW, which could change in funny ways. Importantly, the PSCI
>>>> spec says states FW should restore *the whole state*. Obviously, it
>>>> cannot to that on HW that doesn't allow you to read out the state, hence
>>>> the DT flag that outlines the departure from the expected behaviour.
>>>>
>>>> I'm happy to go either way, but then I have the feeling that we should
>>>> go back to quirking it on the actual implementation (GIC500 in this
>>>> case) if we're to from the property.
>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>> @@ -3261,6 +3363,9 @@ static int __init its_probe_one(struct resource *res,
>>>>>>              ctlr |= GITS_CTLR_ImDe;
>>>>>>      writel_relaxed(ctlr, its->base + GITS_CTLR);
>>>>>>
>>>>>> +    if (fwnode_property_present(handle, "reset-on-suspend"))
>>>>>> +            its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
>>>>>
>>>>> Does this allow this property on an ACPI system?
>>>>>
>>>>> If we need this on ACPI, we need a spec update to handle this properly,
>>>>> and shouldn't use device properties like this.
>>>>
>>>> Well spotted. I guess that dropping the property would fix that
>>>> altogether, assuming we feel that the above is safe enough.
>>>>
>>>> Thoughts?
>>>
>>> I'm fine changing it to get rid of the devicetree property.
>>>
>>> What's the reason for quirking the behavior though? It's not that much
>>> code + data and nothing else relies on the state of the ITS getting
>>> disabled across suspend/resume. Even if something did, we'd have to
>>> resolve it with this feature anyways.
>>
>> The reason we do this is to cope with GIC500 having the collection state
>> in registers instead of memory. If we didn't have this extraordinary
>> misfeature, FW could do a full save/restore of the ITS, and we wouldn't
>> have to do anything (which is what the driver currently expects).
>>
>> A middle ground approach is to limit the feature to systems where
>> GITS_TYPER.HCC is non-zero instead of limiting it to GIC500. Pretty easy
>> to fix. This should have the same effect, as GIC500 is the only
>> implementation I'm aware of with HCC!=0.
>>
>> Given that we're already at -rc5 and that I'd like to queue things for
>> 4.17, I've made this change myself and queued patches 1 and 3 here[1].
>>
>> Can you please have a look at let me know if that works for you?
>>
> 
> Assuming that your fine with only having the GIC500 implementations
> that have HCC as non-zero getting ITS registers restored in the
> kernel. As far as I can tell, this can happen in firmware for all
> implementations. It's only the code to resend that MAPC on resume that
> needs to be in the kernel.

We really do not want to be in the business of doing partial
save/restore, with "à la carte" implementations. That be unmaintainable.

If a FW implementation doesn't fully save/restore the ITS when HCC==0,
then it is buggy, and it should be fixed.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
