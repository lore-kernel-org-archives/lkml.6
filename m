Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeD3Jqy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:46:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57020 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeD3Jqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:46:53 -0400
Subject: Re: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
To: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mark.rutland@arm.com, marc.zyngier@arm.com, james.morse@arm.com,
        daniel.thompson@linaro.org, Joel Fernandes <joelaf@google.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <CAEi0qNk7pVtfcrFU4gM35sajPb09xjR8d6cJkgoSr-H0Tgo+QA@mail.gmail.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <cc4347d0-995d-6921-a796-374a214cdce9@arm.com>
Date: Mon, 30 Apr 2018 10:46:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEi0qNk7pVtfcrFU4gM35sajPb09xjR8d6cJkgoSr-H0Tgo+QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

Thanks for the interest.

On 29/04/18 07:35, Joel Fernandes wrote:
> Hi Julien,
> 
> I am interested in evaluating if using this is feasible for our
> Android devices. There is quite a usecase for lockup detection that it
> seems worthwhile if it works well. Atleast I feel this can be used a
> debug option considering the performance downgrade.
> 
> Do you have more details of if any GICv3 based system will work, or is
> there a way an SoC can be misconfigured so that this series will not
> work? I think Marc told me that's possible, but I wasn't sure. I will
> be quite happy if it works on SoC as long as they have the requisite
> GIC version.
> 
> Some more questions below:
> 
> On Wed, Jan 17, 2018 at 3:54 AM, Julien Thierry <julien.thierry@arm.com> wrote:
>> Hi,
>>
>> This series is a continuation of the work started by Daniel [1]. The goal
>> is to use GICv3 interrupt priorities to simulate an NMI.
>>
>> To achieve this, set two priorities, one for standard interrupts and
>> another, higher priority, for NMIs. Whenever we want to disable interrupts,
>> we mask the standard priority instead so NMIs can still be raised. Some
>> corner cases though still require to actually mask all interrupts
>> effectively disabling the NMI.
>>
>> Of course, using priority masking instead of PSR.I comes at some cost. On
>> hackbench, the drop of performance seems to be >1% on average for this
>> version. I can only attribute that to recent changes in the kernel as
> 
> Do you have more specific performance data on the performance overhead
> with this series?
> 

Not at the moment. I was planning on doing a v3 anyway considering this 
series is getting a bit old and the GICv3 driver has had some modifications.

Once I get to it I can try to have more detailed performance data on a 
recent kernel. I've really only measured the performance on hackbench 
and on kernel build from defconfig (and for the kernel build the 
performance difference was completely hidden by the noise).

>> hackbench seems slightly slower compared to my other benchmarks while the
>> runs with the use of GICv3 priorities have stayed in the same time frames.
>> KVM Guests do not seem to be affected preformance-wise by the host using
>> PMR to mask interrupts or not.
>>
>> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
>> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
>> for now. I don't think there is any reason LPIs should be allowed to be set
>> as NMI as they do not have an active state.
>> When an NMI is active on a CPU, no other NMI can be triggered on the CPU.
>>
>>
>> Requirements to use this:
>> - Have GICv3
>> - SCR_EL3.FIQ is set to 1 when linux runs
> 
> Ah I see it mentioned here. Again, can you clarify if this is
> something that can be misconfigured? Is it something that the
> bootloader sets?
> 

Yes, this is something that the bootloader sets and we have seen a few 
cases where it is set to 0, so it can be "misconfigured".

It is not impossible to handle this case, but this bit affects the view 
the GICv3 CPU interface has on interrupt priority values. However it 
requires to add some conditions in both the interrupt handling and 
masking/unmasking code, so ideally we would avoid adding things to this.

But the idea is that Linux only deals with group 1 interrupts, and group 
1 interrupts are only signaled as FIQs when the execution state is 
secure or at EL3, which should never happen in Linux's case. So ideally 
we'd like firmwares to set up this bit properly rather than to have to 
deal with both cases when only one of them makes sense for Linux.

> Sorry if these questions sound premature, I haven't yet taken a closer
> look at the series.
> 
Cheers,

-- 
Julien Thierry
