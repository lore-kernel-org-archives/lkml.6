Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936285AbeCBL4a (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:56:30 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40670 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934881AbeCBL4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:56:25 -0500
X-Google-Smtp-Source: AG47ELvHyzKfU48YYWAUUbua3FpfqMAXyqP/y3Rtf6mu0D3TSD/wlTCe8wR5zYffFHE95oVjvWTSX6o6tB7DFSIlsTc=
MIME-Version: 1.0
In-Reply-To: <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com> <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
From: Grzegorz Jaszczyk <jaz@semihalf.com>
Date: Fri, 2 Mar 2018 12:56:24 +0100
Message-ID: <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during machine_crash_shutdown
To: Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Hoeun Ryu <hoeun.ryu@gmail.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your feedback. I probably over-interpreted some of the
documentation paragraph to justify (probably) buggy behavior that I am
seeing. Regardless of correctness of this patch I will appreciate if
you could help understanding this issue.

First the whole story: I was debugging why the crashdump kernel hangs
in v. early stage, when the kdump was triggered from the
ARM_SBSA_WATCHDOG interrupt handler, while everything worked fine when
it was triggered from the process context. Finally It occurred that it
is because the crashdump kernel doesn't get any timer interrupt. I
also notice that this problem doesn't occur when the gic is configured
to work in EOImode == 1. In such circumstances, the write to
GIC_CPU_EOI in gic_handle_irq is causing priority drop to idle, and
therefore when the crashdump kernel starts, the timer interrupt is
able to preempt still active watchdog interrupt (I know that this
interrupt shouldn't be active after irq_set_irqchip_state but for some
reason it seems to not do the job correctly).

In my commit log I wrongly describe the bahaviour of
irq_set_irqchip_state and irq_get_irqchip_state. In
machine_kexec_mask_interrupts (when watchdog interrupt is active)
after adding some debugs I see that (focusing only on watchdog
interrupt):
1) before calling irq_set_irqchip_state when I check the status with
irq_get_irqchip_state I see that watchdog interrupt is active
2) decative interrupt via irq_set_irqchip_state
3) check the status via irq_get_irqchip_state which indicates that the
status has changed to inactive, so everything seems to be fine, but
still in crashdump kernel I don't get any interrupts (when the EOImode
== 0).

When I modify the machine_kexec_mask_interrupts, to call the eoi for
watchdog (only temporary to observe the effect):
if (i == watchdog_irq)
     chip->irq_eoi(&desc->irq_data);

everything is working. So it seems that deactivating the interrupt via
write to GIC_CPU_EOI (EOImode == 0) or GIC_CPU_EOI +
GIC_CPU_DEACTIVATE (EOImode == 1) does the job, while deactivating it
with use of GIC_DIST_ACTIVE_CLEAR doesn't.

I am using the unmodified GICv2m ("arm,gic-400") and the watchdog
interrupt is connected as one of the SPI. Do you have any idea what
can be wrong? Maybe I am missing something? gic configuration? I also
don't exclude that nobody who work with kdump doesn't use (EOImode ==
0) and therefore didn't see this behavior.

Thank you in advance,
Grzegorz


2018-02-28 18:45 GMT+01:00 Marc Zyngier <marc.zyngier@arm.com>:
> On 28/02/18 17:16, Mark Rutland wrote:
>> [Adding MarcZ]
>>
>> On Wed, Feb 28, 2018 at 06:01:00PM +0100, Grzegorz Jaszczyk wrote:
>>> Hitherto during machine_kexec_mask_interrupts there was an attempt to
>>> remove active state using irq_set_irqchip_state() routine and only if it
>>> failed, the attempt to EOI the interrupt was made. Nevertheless relaying
>>> on return value from irq_set_irqchip_state inside
>>> machine_kexec_mask_interrupts is incorrect - it only returns the status
>>> of the routine but doesn't provide information if the interrupt was
>>> deactivated correctly or not.
>>
>> This doesn't sound right. The return value of irq_set_irqchip_state() is
>> certainly supposed to indicate that it did what it was asked to (i.e.
>> correctly (de)activated the interrupt).
>>
>> IIUC, you're saying that there's a problem whereby:
>>
>> (a) irq_set_irqchip_state() returns succesfully, but:
>>
>> (b) irq_set_irqchip_state() does not alter the interrupt state to that
>>     requested.
>>
>> ... which sounds like a bug.
>>
>> When does this happen, exactly?
>>
>> Thanks,
>> Mark.
>>
>>> Therefore the irq_eoi wasn't call even if the interrupt remained
>>> active.
>>>
>>> To determine the sate correctly the irq_get_irqchip_state() could be
>>> used but according to the ARM Generic Interrupt Controller Architecture
>>> Spec, non-secure reading from GICD_ISACTIVERn/GICD_ICACTIVERn can be not
>>> permitted (depending on NS_access setting of Non-secure Access Control
>>> Registers, a.k.a. GICD_NSACRn). What is more interesting GICD_NSACRn
>>> is optional Secure register.
>
> All the Linux interrupts are either non-secure, or accessible using
> non-secure accessors. I'm afraid you're misunderstanding a thing or two
> about the architecture.
>
>>>
>>> Moreover de-activating the interrupt via GICD_ISACTIVERn register
>>> (regardless of the possibility of checking status or not) seems to not
>>> do the job, when the GIC Distributor is configured to forward the
>>> interrupts to the CPU interfaces.
>
> Then you seem to have really buggy HW.
>
>>>
>>> Because of all above the attempt to deactivate interrupts via
>>> irq_set_irqchip_state() is removed in this patch. Instead the irq_eoi is
>>> called whenever the interrupt is in progress(irqd_irq_inprogress).
>>>
>>> Before this patch the kdump triggered from interrupt context worked
>>> correctly by accident when the GIC was configured with
>>> GIC_CPU_CTRL_EOImodeNS == 1 (supports_deactivate == true). In mentioned
>>> mode GIC_CPU_EOI has priority drop functionality only and
>>> GIC_CPU_DEACTIVATE is used for interrupt deactivation. Also the
>>> gic_handle_irq behaviour is a bit different in mentioned mode and
>>> performs write to the GIC_CPU_EOI which causes the priority drop to the
>>> idle priority. So even if the irq_eoi wasn't called during
>>> machine_kexec_mask_interrupts, the interrupts of the crashdump kernel
>>> was handled due to interrupt preemption (since the priority of still
>>> active interrupt was dropped to idle priority).
>>>
>>> Nevertheless when the kdump was triggered from interrupt context while
>>> the GIC was configured to work in GIC_CPU_CTRL_EOImodeNS == 0, the
>>> crashdump kernel hang in early stage due to lack of timer interrupt
>>> arrival.
>>>
>>> After this fix the kdump behaves correctly when triggered from interrupt
>>> context independently of GIC_CPU_CTRL_EOImodeNS configuration.
>>>
>>> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
>>> ---
>>>  arch/arm64/kernel/machine_kexec.c | 10 +---------
>>>  1 file changed, 1 insertion(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>>> index f76ea92..30ad183 100644
>>> --- a/arch/arm64/kernel/machine_kexec.c
>>> +++ b/arch/arm64/kernel/machine_kexec.c
>>> @@ -220,20 +220,12 @@ static void machine_kexec_mask_interrupts(void)
>>>
>>>      for_each_irq_desc(i, desc) {
>>>              struct irq_chip *chip;
>>> -            int ret;
>>>
>>>              chip = irq_desc_get_chip(desc);
>>>              if (!chip)
>>>                      continue;
>>>
>>> -            /*
>>> -             * First try to remove the active state. If this
>>> -             * fails, try to EOI the interrupt.
>>> -             */
>>> -            ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
>>> -
>>> -            if (ret && irqd_irq_inprogress(&desc->irq_data) &&
>>> -                chip->irq_eoi)
>>> +            if (irqd_irq_inprogress(&desc->irq_data) && chip->irq_eoi)
>
> This really doesn't make any sense. Either you've successfully
> deactivated the interrupt, or you haven't. Doing both is a terrible
> violation of the GIC architecture, don't do that. There is also 0
> guarantee that the interrupt was active on the CPU you're currently
> running. If you activated it on another CPU, good luck.
>
> To echo to Mark's concerns, you don't explain the root cause: Why is
> irq_set_irqchip_state silently failing? With what IRQ type? On what GIC
> implementation?
>
>>>                      chip->irq_eoi(&desc->irq_data);
>>>
>>>              if (chip->irq_mask)
>
> As it stands, this patch breaks more things than it should. I'd suggest
> you start from the beginning and explain the issue you're facing.
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
