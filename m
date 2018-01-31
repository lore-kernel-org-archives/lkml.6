Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeAaHxL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:53:11 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39066 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeAaHxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:53:08 -0500
X-Google-Smtp-Source: AH8x226wA8lZ87+KvFuTJxSIHGt6ks6R3hUpJgXVsPZKh/Zinx3xInviqxUNMjZ9YuS3mdto+87llg==
MIME-Version: 1.0
In-Reply-To: <20180130170515.3g6wtadqgmehxh5b@rob-hp-laptop>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
 <20180124103516.2571-9-jeffy.chen@rock-chips.com> <20180130170515.3g6wtadqgmehxh5b@rob-hp-laptop>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 31 Jan 2018 16:52:44 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A383Ey3Ntg_hcsvzHj2DsSuW6RMQ+kP=LPAZ1YmqjHOg@mail.gmail.com>
Message-ID: <CAAFQd5A383Ey3Ntg_hcsvzHj2DsSuW6RMQ+kP=LPAZ1YmqjHOg@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
To: Rob Herring <robh@kernel.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        Ricky Liang <jcliang@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>, simon xue <xxm@rock-chips.com>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
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

Hi Rob,

On Wed, Jan 31, 2018 at 2:05 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Jan 24, 2018 at 06:35:11PM +0800, Jeffy Chen wrote:
>> From: Tomasz Figa <tfiga@chromium.org>
>>
>> Current code relies on master driver enabling necessary clocks before
>> IOMMU is accessed, however there are cases when the IOMMU should be
>> accessed while the master is not running yet, for example allocating
>> V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
>> mapping API and doesn't engage the master driver at all.
>>
>> This patch fixes the problem by letting clocks needed for IOMMU
>> operation to be listed in Device Tree and making the driver enable them
>> for the time of accessing the hardware.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>> ---
>>
>> Changes in v5:
>> Use clk_bulk APIs.
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>  .../devicetree/bindings/iommu/rockchip,iommu.txt   |  8 +++
>
> Please split binding patches to a separate patch.
>
>>  drivers/iommu/rockchip-iommu.c                     | 74 ++++++++++++++++++++--
>>  2 files changed, 76 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>> index 2098f7732264..33dd853359fa 100644
>> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>> @@ -14,6 +14,13 @@ Required properties:
>>                      "single-master" device, and needs no additional information
>>                      to associate with its master device.  See:
>>                      Documentation/devicetree/bindings/iommu/iommu.txt
>> +Optional properties:
>> +- clocks : A list of master clocks requires for the IOMMU to be accessible
>> +           by the host CPU. The number of clocks depends on the master
>> +           block and might as well be zero. See [1] for generic clock
>> +           bindings description.
>
> Hardware blocks don't have a variable number of clock connections.

I think you underestimate the imagination of hardware designers. :)

For Rockchip IOMMU, there is a set of clocks, which all need to be
enabled for IOMMU register access to succeed. The clocks are not
directly fed to the IOMMU, but they are needed for the various buses
and intermediate blocks on the way to the IOMMU to work.

And the set varies based on next to which master block the IOMMU block
is located, because the hierarchy of buses and intermediate blocks is
different.

Best regards,
Tomasz
