Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeAaNvX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 08:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbeAaNvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 08:51:21 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E085721798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x227DyCei/MDFQdjIA+QNsqDp+ggVbZ6zQuKyid2D4KRNxC9wb5gs1uK7eN5dzqku80WypVlGFKEG8Q78A/ymOUM=
MIME-Version: 1.0
In-Reply-To: <CAAFQd5A383Ey3Ntg_hcsvzHj2DsSuW6RMQ+kP=LPAZ1YmqjHOg@mail.gmail.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
 <20180124103516.2571-9-jeffy.chen@rock-chips.com> <20180130170515.3g6wtadqgmehxh5b@rob-hp-laptop>
 <CAAFQd5A383Ey3Ntg_hcsvzHj2DsSuW6RMQ+kP=LPAZ1YmqjHOg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 31 Jan 2018 07:50:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKFW0USD_TgGCO-s4wMBw9O2psToMObjeSEwCNReq-3=w@mail.gmail.com>
Message-ID: <CAL_JsqKFW0USD_TgGCO-s4wMBw9O2psToMObjeSEwCNReq-3=w@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
To: Tomasz Figa <tfiga@chromium.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>, simon xue <xxm@rock-chips.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 1:52 AM, Tomasz Figa <tfiga@chromium.org> wrote:
> Hi Rob,
>
> On Wed, Jan 31, 2018 at 2:05 AM, Rob Herring <robh@kernel.org> wrote:
>> On Wed, Jan 24, 2018 at 06:35:11PM +0800, Jeffy Chen wrote:
>>> From: Tomasz Figa <tfiga@chromium.org>
>>>
>>> Current code relies on master driver enabling necessary clocks before
>>> IOMMU is accessed, however there are cases when the IOMMU should be
>>> accessed while the master is not running yet, for example allocating
>>> V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
>>> mapping API and doesn't engage the master driver at all.
>>>
>>> This patch fixes the problem by letting clocks needed for IOMMU
>>> operation to be listed in Device Tree and making the driver enable them
>>> for the time of accessing the hardware.
>>>
>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>>> ---
>>>
>>> Changes in v5:
>>> Use clk_bulk APIs.
>>>
>>> Changes in v4: None
>>> Changes in v3: None
>>> Changes in v2: None
>>>
>>>  .../devicetree/bindings/iommu/rockchip,iommu.txt   |  8 +++
>>
>> Please split binding patches to a separate patch.
>>
>>>  drivers/iommu/rockchip-iommu.c                     | 74 ++++++++++++++++++++--
>>>  2 files changed, 76 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>> index 2098f7732264..33dd853359fa 100644
>>> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>> @@ -14,6 +14,13 @@ Required properties:
>>>                      "single-master" device, and needs no additional information
>>>                      to associate with its master device.  See:
>>>                      Documentation/devicetree/bindings/iommu/iommu.txt
>>> +Optional properties:
>>> +- clocks : A list of master clocks requires for the IOMMU to be accessible
>>> +           by the host CPU. The number of clocks depends on the master
>>> +           block and might as well be zero. See [1] for generic clock
>>> +           bindings description.
>>
>> Hardware blocks don't have a variable number of clock connections.
>
> I think you underestimate the imagination of hardware designers. :)

Learned long ago to never do that. If there are 2 ways to do
something, they will find a 3rd way.

> For Rockchip IOMMU, there is a set of clocks, which all need to be
> enabled for IOMMU register access to succeed. The clocks are not
> directly fed to the IOMMU, but they are needed for the various buses
> and intermediate blocks on the way to the IOMMU to work.

The binding should describe the clock connections, not what clocks a
driver needs (currently). It sounds like a lack of managing bus clocks
to me.

In any case, the binding must be written so it can be verified. If you
can have any number of clocks with any names, there's no point in
documenting.

Rob
