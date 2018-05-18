Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeERIHg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:07:36 -0400
Received: from foss.arm.com ([217.140.101.70]:44590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeERIHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:07:32 -0400
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
To: Florian Fainelli <f.fainelli@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
 <alpine.DEB.2.21.1805171233500.7984@macbook-air>
 <307323036.63872.1526576126537@email.1und1.de>
 <20180517180758.GK12198@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1805171422450.8529@macbook-air>
 <alpine.DEB.2.21.1805171530080.8529@macbook-air>
 <0a643984-1586-8c56-6627-430f0c2a4ba8@gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <d6b6f632-2051-a239-3e44-4750f2ac89d5@arm.com>
Date: Fri, 18 May 2018 09:07:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0a643984-1586-8c56-6627-430f0c2a4ba8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/18 20:59, Florian Fainelli wrote:
> On 05/17/2018 12:31 PM, Vince Weaver wrote:
>> On Thu, 17 May 2018, Vince Weaver wrote:
>>
>>> On Thu, 17 May 2018, Peter Zijlstra wrote:
>>> with cortex-a7 now, would it be possible to later drop that if proper 
>>> cortex-a53 support is added to the armv7 pmu driver?  Or would that lead 
>>> to all kinds of back-compatability mess?
>>
>> For what it's worth, the pi-foundation kernel bcm2710 device tree file 
>> does:
>>
>> 		arm-pmu {
>> #ifdef RPI364
>> 			compatible = "arm,armv8-pmuv3", "arm,cortex-a7-pmu";

Hahaha. Funny that. Not. That's really silly. The DT *must* describe the
HW, and having contradictory information is not helping. This is going
to lead to all kind of miscounted events (to take the above example) A7
and A53 are significantly different, and thus will count events
differently....


>> #else
>> 			compatible = "arm,cortex-a7-pmu";
>> #endif
>> 			interrupt-parent = <&local_intc>;
>> 			interrupts = <9>;
>> 		};
>>
>>
>> Which is probably where I was getting the arm,armv8-pmuv3 from in my 
>> original patch.
> 
> I thought somehow that Marc Z. had unified
> arch/arm/kernel/perf_event_v7.c and arch/arm64/kernel/perf_event.c into
> a common driver entry point under drivers/perf/arm_pmu.c but I don't see
> it and after about 15 minutes looking at it, it does not look as trivial
> as I though to separate out those files so the ARMv8 PMU description can
> be moved into a generic location for instance.

I have a pretty simple series[1] which I used to profile 32bit guests on
an arm64 KVM host. Nobody really cared about it because running a 32bit
kernel on 64bit HW is a bit odd, to say the least, and I'm probably the
only one actually running 32bit VMs.

> FWIW, Broadcom STB chips, even when 64-bit capable or often used with an
> 32-bit ARM kernel, so having the ARMv8 PMUs work under a 32-bit ARM
> kernel would be great. The downstream solution we have sued thus far is
> to find the closest compatible string to represent those, which is not
> great...
Ah, so you're *really* doing that? I'm not going to ask why, I'm scared
of the answer... ;-)

Anyway, I can repost that series if that will prevent people from having
that kind of silly hacks.

Thanks,

	M.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm/pmuv3-32bit
-- 
Jazz is not dead. It just smells funny...
