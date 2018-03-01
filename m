Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965483AbeCABiR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 20:38:17 -0500
Received: from regular1.263xmail.com ([211.150.99.137]:52191 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965468AbeCABiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 20:38:15 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: robin.murphy@arm.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <60774072825e8474a6f6814601882a8b>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A975967.6020301@rock-chips.com>
Date: Thu, 01 Mar 2018 09:37:43 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>, simon xue <xxm@rock-chips.com>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com> <20180124103516.2571-9-jeffy.chen@rock-chips.com> <20180130170515.3g6wtadqgmehxh5b@rob-hp-laptop> <CAAFQd5A383Ey3Ntg_hcsvzHj2DsSuW6RMQ+kP=LPAZ1YmqjHOg@mail.gmail.com> <CAL_JsqKFW0USD_TgGCO-s4wMBw9O2psToMObjeSEwCNReq-3=w@mail.gmail.com> <5A72F7D2.1050201@rock-chips.com> <5A8FEBC6.4000408@rock-chips.com> <33d1d6bd-3455-5cad-6990-a9ca94063f3a@arm.com> <5A96A809.2020509@rock-chips.com> <34a60ab2-a3af-3302-6612-740cba5460db@arm.com>
In-Reply-To: <34a60ab2-a3af-3302-6612-740cba5460db@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks for your reply.

On 02/28/2018 11:06 PM, Robin Murphy wrote:
> On 28/02/18 13:00, JeffyChen wrote:
>> Hi Robin,
>>
>> Thanks for your reply.
>>
>> On 02/28/2018 12:59 AM, Robin Murphy wrote:
>>>>> the rockchip IOMMU is part of the master block in hardware, so it
>>>>> needs
>>>>> to control the master's power domain and some of the master's clocks
>>>>> when access it's registers.
>>>>>
>>>>> and the number of clocks needed here, might be different between each
>>>>> IOMMUs(according to which master block it belongs), it's a little like
>>>>> our power domain:
>>>>> https://elixir.free-electrons.com/linux/latest/source/arch/arm64/boot/dts/rockchip/rk3399.dtsi#L935
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> i'm not sure how to describe this correctly, is it ok use something
>>>>> like
>>>>> "the same as it's master block"?
>>>>
>>>> would it make sense to add a property to specify the master who owns
>>>> the iommu, and we can get all clocks(only some of those clocks are
>>>> actually needed) from it in the of_xlate()? and we can also reuse the
>>>> clock-names of that master to build clk_bulk_data and log errors in
>>>> clk_bulk_get.
>>>
>>> I'm inclined to agree with Rob here - if we're to add anything to the
>>> binding, it should only be whatever clock inputs are defined for the
>>> IOMMU IP block itself. If Linux doesn't properly handle the interconnect
>>> clock hierarchy external to a particular integration, that's a separate
>>> issue and it's not the binding's problem.
>>>
>>> I actually quite like the hack of "borrowing" the clocks from
>>> dev->of_node in of_xlate() - you shouldn't need any DT changes for that,
>>> because you already know that each IOMMU instance only has the one
>>> master device anyway.
>>
>> Thanks:) but actually we are going to support sharing IOMMU between
>> multiple masters(one of them is the main master i think) in the newer
>> chips(not yet supported on upstream kernel)...
>
> Ha! OK, fair enough, back to the first point then...
>
>> So we might have to get all clocks from all masters, or find a way to
>> specify the main master...and for the multiple masters case, do it in
>> of_xlate() turns out to be a little racy...maybe we can add a property
>> to specify main master, and get it's clocks in probe()?
>
> I notice that the 4.4 BSP kernel consistently specifies "aclk" and
> "hclk" for the IOMMU instances - it feels unusual to say "why don't we
> follow the downstream binding?", but it does look a lot like what I
> would expect (I'd guess at one for the register slave interface and one
> for the master interface/general operation?)
huh, right.
i did noticed that, but there's a hevc_mmu with ("aclk", "hclk", 
"clk_core", "clk_cabac") confused me.

so confirmed with Simon, that hevc_mmu is wrong. currently all IOMMUs 
should only have 2 clks, either aclk+hclk or aclk+pclk (depends on the 
clk tree)

so it seems to be a good idea to do so, will send patches soon, thanks :)
>
> If we can implement conceptually-correct clock handling based on an
> accurate binding, which should cover most cases, and *then* look at
> hacking around those where it doesn't quite work in practice due to
> shortcomings elsewhere, that would be ideal, and of course a lot nicer
> than just jumping straight into piles of hacks.
>
> Robin.
>
>
>
