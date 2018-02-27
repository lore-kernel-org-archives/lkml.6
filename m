Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeB0Q7T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:59:19 -0500
Received: from foss.arm.com ([217.140.101.70]:38614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeB0Q7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:59:18 -0500
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
To: JeffyChen <jeffy.chen@rock-chips.com>, Rob Herring <robh@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>, simon xue <xxm@rock-chips.com>,
        open@263.net,
        "263.netOPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS devicetree"@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
 <20180124103516.2571-9-jeffy.chen@rock-chips.com>
 <20180130170515.3g6wtadqgmehxh5b@rob-hp-laptop>
 <CAAFQd5A383Ey3Ntg_hcsvzHj2DsSuW6RMQ+kP=LPAZ1YmqjHOg@mail.gmail.com>
 <CAL_JsqKFW0USD_TgGCO-s4wMBw9O2psToMObjeSEwCNReq-3=w@mail.gmail.com>
 <5A72F7D2.1050201@rock-chips.com> <5A8FEBC6.4000408@rock-chips.com>
Message-ID: <33d1d6bd-3455-5cad-6990-a9ca94063f3a@arm.com>
Date: Tue, 27 Feb 2018 16:59:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A8FEBC6.4000408@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/18 10:24, JeffyChen wrote:
> Hi guys,
> 
> On 02/01/2018 07:19 PM, JeffyChen wrote:
>>>>>>
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>>>> b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>>>> index 2098f7732264..33dd853359fa 100644
>>>>>> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>>>> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>>>> @@ -14,6 +14,13 @@ Required properties:
>>>>>>                       "single-master" device, and needs no
>>>>>> additional information
>>>>>>                       to associate with its master device.  See:
>>>>>>
>>>>>> Documentation/devicetree/bindings/iommu/iommu.txt
>>>>>> +Optional properties:
>>>>>> +- clocks : A list of master clocks requires for the IOMMU to be
>>>>>> accessible
>>>>>> +           by the host CPU. The number of clocks depends on the
>>>>>> master
>>>>>> +           block and might as well be zero. See [1] for generic 
>>>>>> clock
>>>>>> +           bindings description.
>>>>>
>>>>> Hardware blocks don't have a variable number of clock connections.
>>>>
>>>> I think you underestimate the imagination of hardware designers. :)
>>>
>>> Learned long ago to never do that. If there are 2 ways to do
>>> something, they will find a 3rd way.
>>>
>>>> For Rockchip IOMMU, there is a set of clocks, which all need to be
>>>> enabled for IOMMU register access to succeed. The clocks are not
>>>> directly fed to the IOMMU, but they are needed for the various buses
>>>> and intermediate blocks on the way to the IOMMU to work.
>>>
>>> The binding should describe the clock connections, not what clocks a
>>> driver needs (currently). It sounds like a lack of managing bus clocks
>>> to me.
>>>
>>> In any case, the binding must be written so it can be verified. If you
>>> can have any number of clocks with any names, there's no point in
>>> documenting.
>>
>> the rockchip IOMMU is part of the master block in hardware, so it needs
>> to control the master's power domain and some of the master's clocks
>> when access it's registers.
>>
>> and the number of clocks needed here, might be different between each
>> IOMMUs(according to which master block it belongs), it's a little like
>> our power domain:
>> https://elixir.free-electrons.com/linux/latest/source/arch/arm64/boot/dts/rockchip/rk3399.dtsi#L935 
>>
>>
>>
>> i'm not sure how to describe this correctly, is it ok use something like
>> "the same as it's master block"?
> 
> would it make sense to add a property to specify the master who owns the 
> iommu, and we can get all clocks(only some of those clocks are actually 
> needed) from it in the of_xlate()? and we can also reuse the clock-names 
> of that master to build clk_bulk_data and log errors in clk_bulk_get.

I'm inclined to agree with Rob here - if we're to add anything to the 
binding, it should only be whatever clock inputs are defined for the 
IOMMU IP block itself. If Linux doesn't properly handle the interconnect 
clock hierarchy external to a particular integration, that's a separate 
issue and it's not the binding's problem.

I actually quite like the hack of "borrowing" the clocks from 
dev->of_node in of_xlate() - you shouldn't need any DT changes for that, 
because you already know that each IOMMU instance only has the one 
master device anyway.

Robin.
