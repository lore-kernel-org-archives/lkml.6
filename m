Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeDJSf2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:35:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752677AbeDJSev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:34:51 -0400
Subject: Re: [PATCH] irqchip/gic-v3: Support v2m frame backwards compatibility
 mode
To: Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-arm-msm@vger.kernel.org,
        Hanna Hawa <hannah@marvell.com>, Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20170320223614.1351-1-sboyd@codeaurora.org>
 <bac1e827-3860-d92c-7bb4-eaf9840c608f@arm.com>
 <20180410170155.6e07113d@windsurf>
 <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
 <152338426182.180276.1835672071236851795@swboyd.mtv.corp.google.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <05b943f7-b3f0-ebdf-06e7-140000442a77@arm.com>
Date: Tue, 10 Apr 2018 19:34:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152338426182.180276.1835672071236851795@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 10/04/18 19:17, Stephen Boyd wrote:
> Quoting Marc Zyngier (2018-04-10 08:23:00)
>> On 10/04/18 16:01, Thomas Petazzoni wrote:
>>
>>> In the upcoming Armada 8KP, we have a GICv3, which has built-in support
>>> for memory-triggered SPIs, thanks to the GICD_SETSPI_NSR and
>>> GICD_CLRSPI_NSR, and the ICU will directly use this GICv3
>>> functionality. We would therefore very much like to have this GICv3
>>> feature provided as a MSI controller, which as Marc said would require
>>> supporting level-triggered MSIs.
>>>
>>> Marc, let me know how we can collaborate on this topic. I'm able to
>>> either test some preliminary patches, or work on such patches if
>>> necessary (preferably with some initial directions).
>>
>> I have a vague idea how to support this. Given that level-triggered MSIs
>> have to be platform MSIs (because it is just madness otherwise), we can
>> probably store an extra message in the struct platform_msi_desc for the
>> "lower the line" write. On activation, you'd get two callbacks, probably
>> with a flag of some sort to indicate whether this is for the rising or
>> falling edge. The thing I'm unclear about so far is how to let the
>> generic MSI layer know that we're dealing with such an interrupt without
>> make a total mess of everything. It is probably done by marking the
>> interrupt level triggered, but there are some corner cases.
>>
>> And if that works, the PCI stuff will come for free (it is just a matter
>> of implementing a new irqdomain on top of the base GICv3 one).
>>
>> I'll try to spend some time on it in the coming couple of weeks, but
>> will have to rely on you for the testing (as I don't have much in the
>> way of HW).
> 
> I resent these patches late last year[1]. On the HW I had at the time we
> were trying to support PCIe devices and we didn't need level interrupts.
> I thought Marc had agreed to accept the patches without the level
> interrupt support as long as we described the range of interrupts that
> were supported but that doesn't seem to be the case anymore.

My suggestion was to add the same level of functionality to the GICv3
driver, and not to reuse the GICv2m driver. This would have allowed us
to enable level interrupts at a later time. Obviously, I wasn't clear
enough about what I wanted to see.

So this time, we'll do it the other way around: plug in level
interrupts, and PCI/MSI will (mostly) appear for free.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
