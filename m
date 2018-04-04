Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeDDQ4U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:56:20 -0400
Received: from foss.arm.com ([217.140.101.70]:46686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbeDDQ4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:56:19 -0400
Subject: Re: [RFC PATCH 3/4] acpi: apei: Do not panic() in NMI because of GHES
 messages
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, tbaicar@codeaurora.org,
        will.deacon@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org,
        gengdongjiu@huawei.com, linux-kernel@vger.kernel.org,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com
References: <20180403170830.29282-1-mr.nuke.me@gmail.com>
 <20180403170830.29282-4-mr.nuke.me@gmail.com>
 <338e9bb4-a837-69f9-36e5-5ee2ddcaaa38@arm.com>
 <d6492b41-612a-b256-44c9-4ff3b3d5ae4b@gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <e65986c8-55a1-14c4-5c06-f34fa25916d8@arm.com>
Date: Wed, 4 Apr 2018 17:53:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d6492b41-612a-b256-44c9-4ff3b3d5ae4b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 04/04/18 16:33, Alex G. wrote:
> On 04/04/2018 02:18 AM, James Morse wrote:
>> On 03/04/18 18:08, Alexandru Gagniuc wrote:
>>> BIOSes like to send NMIs for a number of silly reasons often deemed
>>> to be "fatal". For example pin bounce during a PCIE hotplug/unplug
>>> might cause the link to go down and retrain, with fatal PCI errors
>>> being generated while the link is retraining.

>>> Instead of panic()ing in NMI context, pass fatal errors down to IRQ
>>> context to see if they can be resolved.
>>
>> How do we know we will survive this trip?
> 
> We don't.

Isn't that even worse than panic()ing? (No output, followed by a watchdog reboot
if we're lucky)


>> On arm64 systems it may not be possible to return to the context we took the NMI
>> notification from: we may bounce back into firmware with the same "world is on
>> fire" error. Firmware can rightly assume the OS has made no attempt to handle
>> the error. 
> 
> I'm not aware of the NMI path being used on arm64:
> $ git grep 'select HAVE_ACPI_APEI_NMI'
> arch/x86/Kconfig:       select HAVE_ACPI_APEI_NMI               if ACPI
> $

(I agree its not obvious!), arm64 has NOTIFY_SEA, NOTIFY_SEI and NOTIFY_SDEI
that all behave like NOTIFY_NMI (in that they can interrupt IRQ-masked code).

CONFIG_HAVE_ACPI_APEI_NMI has come to mean NOTIFY_NMI, which requires the arch
code to implement register_nmi_handler() and (from memory) behave as a notifier
chain, which doesn't fit with how these things behave.

NOTIFY_SEA lives behind CONFIG_ACPI_APEI_SEA in driver/acpi/apei/Kconfig.
The series to add SDEI support is on the list here:
https://www.spinics.net/lists/arm-kernel/msg642946.html
(NOTIFY_SEI is very tricky for firmware to get right, I don't think we're there
yet.)


> A far as jumping back into firmware, the OS should clear the GHES block
> status before exiting the NMI. THis tells the firmware that the OS got
> the message [1]
> I'm not seeing any mechanism to say "handled/not handled", so I'm not
> sure how firmware can make such assumptions.

(I'm probably assuming GHESv2's ACK stuff).

Wouldn't reasonably-intelligent firmware be able to spot the same fault
repeatedly in a loop? (last-fault-address == this-fault-address,
last-fault-time==now)


>> Your 'not re-arming the error' example makes this worrying.
> 
> Those are one class of bugs you get when you let firmware run the show.
> It's been an issue since day one of EFI. The best you can do in such
> cases is accept you may later lose the link to a device.
> Side-note: We have a BIOS defect filed with against this particular
> issue, and it only seems to affect PCIe SMIs.

This sounds like policy applied too early, fixing the firmware to at least make
this configurable would be preferable.


My point was there is a class of reported-as-fatal error that really is fatal,
and for these trying to defer the work to irq_work is worse than panic()ing as
we get less information about what happened.


>>> With these change, PCIe error are handled by AER. Other far less
>>> common errors, such as machine check exceptions, still cause a panic()
>>> in their respective handlers.
>>
>> I agree AER is always going to be different. Could we take a look at the CPER
>> records while still in_nmi() to decide whether linux knows better than firmware?
>>
>> For non-standard or processor-errors I think we should always panic() if they're
>> marked as fatal.
>> For memory-errors we could split memory_failure() up to have
>> {NMI,IRQ,process}-context helpers, all we need to know at NMI-time is whether
>> the affected memory is kernel memory.
> 
> I'm trying to avoid splitting up the recovery logic based on _how_ we
> were notified of the error. 

I agree, last time I checked there were 11 of them. 'in_nmi()' or not is a
distinction the ghes code already has for ghes_copy_tofrom_phys(). We already
have to consider NMI-like notifications separately as we can't call the
recovery-helpers.


> The only sure way to know if you've handled
> an error is to try to handle it. Not handling _any_ fatal error still
> results in a panic(), and I was very careful to ensure that.

Are all AER errors recoverable?  (is an OS:'fatal' AER error ever valid?)


> The alternative is to keep ghes_do_proc() and ghes_notify_nmi() in sync,
> duplicate code between the two. But we can also get ghes_proc_irq_work()
> as an entry point, and this easily turns in a maintenance nightmare.

We can't call all the recovery-helpers from ghes_notify_nmi() as they sleep and
allocate memory. I think the trick would be to make the CPER parsing routines
NMI-safe so that we can check these 'fatal' records for cases where we're pretty
sure linux can do a better job.


>> For the PCI*/AER errors we should be able to try and handle it ... if we can get
>> back to process/IRQ context:
>> What happens if a PCIe driver has interrupts masked and is doing something to
>> cause this error? We can take the NMI and setup the irq-work, but it may never
>> run as we return to interrupts-masked context.
> 
> The way the recovery from NMI is set up is confusing. On NMIs,
> ghes_proc_in_irq() is queued up to do further work. Despite the name, in
> this case it runs as a task. That further queues up AER work,
> Either way, PCIe endpoint interrupts are irrelevant here. AER recovery
> runs independent of drivers or interrupts:

Hmm, we may be looking at different things, (and I'm not familiar with x86):
ghes_notify_nmi() uses irq_work_queue() to add the work to a percpu llist and
call arch_irq_work_raise(). arch_irq_work_raise() sends a self IPI, which, once
taken causes the arch code to call irq_work_run() to consume the llist.

My badly made point is we could take the NMI that triggers all this from a
context that has interrupts masked. We can't take the self-IPI until we return
from the NMI, and we return to a context that still has interrupts masked. The
original context may cause the NMI to trigger again before it unmasks
interrupts. In this case we've livelocked, the recovery work never runs.

I think something like polling a status register over a broken-link would do
this. (has my config write been acknowledge?)


>  - Drivers that implement AER recovery services are expected to do the
> right thing and shut down IO. To not do so, is a bug in the driver.
>  - Drivers that do not implement AER have their devices taken offline.

> It is not uncommon for PCIe errors to amplify. Imagine losing the link
> right after you've fired off several DMA queues. You'd get a stream of
> Unsupported Request errors. AER handles this fairly well.


>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>> index 2c998125b1d5..7243a99ea57e 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>> @@ -955,7 +962,7 @@ static void __process_error(struct ghes *ghes)
>>>  static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>>  {
>>>  	struct ghes *ghes;
>>> -	int sev, ret = NMI_DONE;
>>> +	int ret = NMI_DONE;
>>>  
>>>  	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
>>>  		return ret;
>>> @@ -968,13 +975,6 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>>>  			ret = NMI_HANDLED;
>>>  		}
>>>  
>>> -		sev = ghes_severity(ghes->estatus->error_severity);
>>> -		if (sev >= GHES_SEV_PANIC) {
>>> -			oops_begin();
>>> -			ghes_print_queued_estatus();
>>> -			__ghes_panic(ghes);
>>> -		}
>>> -
>>>  		if (!(ghes->flags & GHES_TO_CLEAR))
>>>  			continue;
>>
>> For Processor-errors I think this is the wrong thing to do, but we should be
>> able to poke around in the CPER records and find out what we are dealing with.
> 
> I don't think being trigger-happy with the panic button is ever a good
> thing. The logic to stop the system exists downstream, and is being
> called.

> I can see an issue if we somehow lose the ability to run queued
> tasks, but in that case, we've already lost control of the machine.

about to loose control of the machine: firmware has saved the day giving us a
clean slate and some standardised messages that describe the fault.

I agree we can do better for AER errors, but I don't think we should make the
handling of other classes of error worse. These classes match nicely to the CPER
record types, which we already have mapped in ghes_notify_nmi().


Thanks,

James
