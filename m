Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030265AbeBNNRf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:17:35 -0500
Received: from foss.arm.com ([217.140.101.70]:41902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030218AbeBNNRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:17:33 -0500
Subject: Re: [PATCH] irqchip/gic-v3: Support MSIs via aliases and distributor
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        sboyd@kernel.org
References: <20171127102408.6631-1-sboyd@codeaurora.org>
 <bf71552e-6ea0-55f3-6b42-f4a1a3f65cb9@linaro.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <f6cf3672-1723-a10c-6d8d-5f4cb3cf412a@arm.com>
Date: Wed, 14 Feb 2018 13:17:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bf71552e-6ea0-55f3-6b42-f4a1a3f65cb9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/18 12:08, Srinivas Kandagatla wrote:
> 
> On 27/11/17 10:24, Stephen Boyd wrote:
>> Some GIC configurations don't have an accessible ITS, but they
>> want to support MSIs through the distributor's SETSPI registers
>> or through the IMPLEMENTATION DEFINED message-based interrupt
>> request register region. This mode of operation is similar to the
>> v2m support on gic-400, but we don't necessarily know what
>> particular SPIs are supported as MSIs so we need some help from
>> firmware to know what to do.
>>
>> Introduce an "arm,spi-ranges" property for this, similar to the
>> "marvell,spi-ranges" property, that indicates the base and size
>> of each MSI range. This property applies equally to the
>> distributor and alias registers. In either case, we detect this
>> mode of operation by looking for a node with the "msi-controller"
>> property and then probe the v2m frame code on top of it. Assume
>> these nodes will have the "arm,spi-ranges" property in them so
>> that the v2m code works mostly unmodified.
>>
>> Cc: <devicetree@vger.kernel.org>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>   .../bindings/interrupt-controller/arm,gic-v3.txt   |  48 +++++++++-
>>   drivers/irqchip/irq-gic-v2m.c                      | 102 ++++++++++++++++-----
>>   drivers/irqchip/irq-gic-v3.c                       |   4 +
>>   include/linux/irqchip/arm-gic-common.h             |   3 +
>>   4 files changed, 129 insertions(+), 28 deletions(-)
> 
> What's the plan on this?
> I have not seen this patch in rc1 or in next.

Because I haven't had a chance to review it just yet. It will certainly
not be merged before 4.17. Looking at it, it isn't anywhere near getting
there.

Stacking the v2m driver on top of GICv3 is at best wrong. This is not
the same HW, and I've NACKed that approach in the past. You're ignoring
the level interrupt for which the HW has support for.

I've mentioned reusing the GICP driver in the past, as it already caters
for some of that, even if we're missing some infrastructure. How about
having a common approach instead of reinventing the wheel?

> We have a dependency on this to get WLAN working on DragonBoard820c.

Even more of a reason to do the right thing then. If you want to have
this supported, it needs to be a first class citizen, not a mix of two
unrelated architectures.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
