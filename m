Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeDFS1T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:27:19 -0400
Received: from foss.arm.com ([217.140.101.70]:40994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbeDFS1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:27:17 -0400
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
 <e65986c8-55a1-14c4-5c06-f34fa25916d8@arm.com>
 <9e29e5c6-b942-617e-f92e-728627799506@gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <cdea7af5-6c9b-10c5-a9a9-1481446c65a8@arm.com>
Date: Fri, 6 Apr 2018 19:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9e29e5c6-b942-617e-f92e-728627799506@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 04/04/18 20:49, Alex G. wrote:
> On 04/04/2018 11:53 AM, James Morse wrote:
>>>> How do we know we will survive this trip?
>>>
>>> We don't.
>>
>> Isn't that even worse than panic()ing? (No output, followed by a watchdog reboot
>> if we're lucky)

> On the contrary. No output, followed by a watchdog reboot is usually
> what happens when the panic() is in NMI. One of the very few ways that
> can be debugged is over a NULL modem cable.

(IPMI-SOL?)

Really? printk has NMI support, and panic()s call to bust_spinlocks() should
unblank the screen before printk_safe_flush_on_panic() dumps the messages. (I'm
assuming some BMC-VGA exists to capture the 'screen').


>>>> On arm64 systems it may not be possible to return to the context we took the NMI
>>>> notification from: we may bounce back into firmware with the same "world is on
>>>> fire" error. Firmware can rightly assume the OS has made no attempt to handle
>>>> the error. 
>>>
>>> I'm not aware of the NMI path being used on arm64:
>>> $ git grep 'select HAVE_ACPI_APEI_NMI'
>>> arch/x86/Kconfig:       select HAVE_ACPI_APEI_NMI               if ACPI
>>> $
>>
>> (I agree its not obvious!), arm64 has NOTIFY_SEA, NOTIFY_SEI and NOTIFY_SDEI
>> that all behave like NOTIFY_NMI (in that they can interrupt IRQ-masked code).
>>
>> CONFIG_HAVE_ACPI_APEI_NMI has come to mean NOTIFY_NMI, which requires the arch
>> code to implement register_nmi_handler() and (from memory) behave as a notifier
>> chain, which doesn't fit with how these things behave.
>>
>> NOTIFY_SEA lives behind CONFIG_ACPI_APEI_SEA in driver/acpi/apei/Kconfig.
>> The series to add SDEI support is on the list here:
>> https://www.spinics.net/lists/arm-kernel/msg642946.html
>> (NOTIFY_SEI is very tricky for firmware to get right, I don't think we're there
>> yet.)

> From my understanding, your patch series tries to use ghes_notify_nmi()
> as a common entry point. 

It abstracts the NMI-like notifications to use a common helper into the
estatus-queue. ghes_notify_nmi() is the arch-code entry point for x86's
NOTIFY_NMI. We  have ghes_notify_sea() and ghes_sdei_callback() on arm64. They
are different as their registration requirements are different. They each call
_in_nmi_notify_one() to do the in_nmi() ghes work.


> But if on arm64, you can return to firmware,
> then we have wildly different constraints.

We can't return to firmware, but we can take the error again, causing another
trap to firmware.

e.g.: If a program accesses a value in the cache and the cache location is
discovered to be corrupt/marked-as-poisoned. This causes an 'external abort'
exception, which firmware has configured to trap to firmware. Once there, it
generates CPER records and sets-up an external-abort-exception for Linux.
If linux returns from this external-abort, we return to whatever program
accessed the bad-cache-value in the first case, re-run the instruction that
generates the external abort, and the same thing happens again, but to firmware
it looks like a second fault at the same address.

The same thing can happen for a processor error.


> On x86, you can't return to SMM. You can have a new SMI triggered while
> servicing the NMI, but you can't re-enter an SMI that you've returned
> from. SMM holds all the cores, and they all leave SMM at roughly the
> same time, so you don't deal with coexistence issues. This probably also
> avoids the multiple notifications that you are trying to implement on arm.

its the new SMI case.

(We don't necessarily have all cores pulled into firmware, (although firmware
could do that in software), so different CPUs taking NMI-like notifications is
one of the things we have to handle.)


> On quick thought, I think the best way to go for both series is to leave
> the entry points arch-specific, and prevent hax86 and harm64 from
> stepping on each other's toes. Thoughts?

The behaviour should be driven from the standard. I agree there is some leeway,
which linux should handle on all architectures that support GHES.

The entry points from the arch code are already separate, as these have
different notification types in the HEST->GHES entries and different
registration requirements.
Once in ghes.c all the NMI-like notifications get merged together as the only
relevant thing about them is we have to use the estatus-queue, and can't call
any of the sleepy recovery helpers.



I don't think this is the issue though: An NMI notification could by any of the
eleven CPER notification record types.
Your argument is Linux probably can handle PCIe-AER errors, even if broken
firmware thinks they are fatal.
This is only one of the eleven notification record types. Returning to handle
the error definitely doesn't work for some classes of fatal error, especially
when interrupts are masked.

I think its straightforward to test whether the CPER records contain only errors
where we can do better: (not tested/built, I haven't checked whether this is nmi
safe):
---------------------%<---------------------
/*
 * Return true if only PCIe-AER CPER sections are present. We ignore the fatal
 * severity in this case as linux knows better. Called in_nmi().
 */
static bool ghes_is_deferrable(struct ghes *ghes,
       const struct acpi_hest_generic_status *estatus)
{
       guid_t *sec_type;
       struct acpi_hest_generic_data *gdata;

       apei_estatus_for_each_section(estatus, gdata) {
               sec_type = (guid_t *)gdata->section_type;
               if (!guid_equal(sec_type, &CPER_SEC_PCIE))
                       return false;
       }

       return true;
}
---------------------%<---------------------


>> Wouldn't reasonably-intelligent firmware be able to spot the same fault
>> repeatedly in a loop? (last-fault-address == this-fault-address,
>> last-fault-time==now)
> 
> I'm told that the BIOS on Dell machines will detect interrupt storms,
> and disable the specific error source in such cases. On an x86 server.
> 50us of SMM eats up several milliseconds-core of CPU time, so they try
> to be a little careful.
> 
>>>> Your 'not re-arming the error' example makes this worrying.
>>>
>>> Those are one class of bugs you get when you let firmware run the show.
>>> It's been an issue since day one of EFI. The best you can do in such
>>> cases is accept you may later lose the link to a device.
>>> Side-note: We have a BIOS defect filed with against this particular
>>> issue, and it only seems to affect PCIe SMIs.
>>
>> This sounds like policy applied too early
> 
> That's firmware-first in one sentence.
> 
>> fixing the firmware to at least make this configurable would be preferable.
> 
> I can ask for "fixing the firmware" and we might even get the fix, but
> the fact remains that there are machines in the field with the buggy
> BIOSes, and there will continue to be such machines even after a fix is
> released.
> 
> 
>> My point was there is a class of reported-as-fatal error that really is fatal,
>> and for these trying to defer the work to irq_work is worse than panic()ing as
>> we get less information about what happened.
> 
> How do we get less information? We save the GHES structure on the
> estatus_queue, and use it as the error source in either case. Is there a
> class of errors where we can reasonable expect things to be okay in NMI,
> but go horribly wrong on return from NMI?

Yes, (described above). This could happen if we see Arm64's 'SEA' CPER  records
or x86's 'MCE' CPER records. I'm pretty sure it will happen on both
architectures if you return to a context with interrupts masked.

Things will go horribly wrong if you return from an imprecise exception notified
via firmware first.


> (snip)
>> Are all AER errors recoverable?  (is an OS:'fatal' AER error ever valid?)
> 
> PCIe "fatal" means that your link is gone and you might not get it back.
> You lose all the downstream devices. You may be able to reset the link
> and get it back. This sort of "fatal" has no impact on a machine's
> ability to continue operation.
> 
> From ACPI, FFS should only send a "fatal" error if a machine needs reset
> [1], so it's clearly a firmware bug to mark any PCIe error "fatal". This
> won't stop BIOS vendors from taking shortcuts and deciding to crash an
> OS by sending the error as "fatal".
> 
> [1]ACPI 6.2: 18.1Hardware Errors and Error Sources

Great! Its never valid. So we can check the CPER records in the NMI handler, and
for AER errors, clear the fatal bit printing a nasty message about the firmware.


>>> The alternative is to keep ghes_do_proc() and ghes_notify_nmi() in sync,
>>> duplicate code between the two. But we can also get ghes_proc_irq_work()
>>> as an entry point, and this easily turns in a maintenance nightmare.
>>
>> We can't call all the recovery-helpers from ghes_notify_nmi() as they sleep and
>> allocate memory. I think the trick would be to make the CPER parsing routines
>> NMI-safe so that we can check these 'fatal' records for cases where we're pretty
>> sure linux can do a better job.
> 
> can_i_handle_this_nonblocking(struct four_letter_acronum_err *err) ?

Nothing so complicated. Just clearing the bit for AER-only CPER blocks should do.

(we can probably assume that AER & Vendor-Specific are describing the same thing)


> That's the approach I originally tried, but I didn't like it. The
> parsing gets deeper and deeper, and, by the time you realize if the
> error can be handled or not, you're already halfway through recovery.
> 
> This is a perfectly viable approach. However, is there a palpable
> (non-theoretical) concern that warrants complicating things this way?

For AER your text above says no, we can always handle an error, they are never
fatal.

For memory-errors, yes. An ECC error for a location on the kernel stack while
the affected thread was preempt_disable()d. We can't kick the thread off the
CPU, and we can't return from the handler as we can't stop accesses to the stack
when we return.

We can avoid it being complicated by just separating AER errors out when they
come in. You've said they never mean the OS has to reboot.


>>>> For the PCI*/AER errors we should be able to try and handle it ... if we can get
>>>> back to process/IRQ context:
>>>> What happens if a PCIe driver has interrupts masked and is doing something to
>>>> cause this error? We can take the NMI and setup the irq-work, but it may never
>>>> run as we return to interrupts-masked context.
>>>
>>> The way the recovery from NMI is set up is confusing. On NMIs,
>>> ghes_proc_in_irq() is queued up to do further work. Despite the name, in
>>> this case it runs as a task. That further queues up AER work,
>>> Either way, PCIe endpoint interrupts are irrelevant here. AER recovery
>>> runs independent of drivers or interrupts:
>>
>> Hmm, we may be looking at different things, (and I'm not familiar with x86):
>> ghes_notify_nmi() uses irq_work_queue() to add the work to a percpu llist and
>> call arch_irq_work_raise(). arch_irq_work_raise() sends a self IPI, which, once
>> taken causes the arch code to call irq_work_run() to consume the llist.
> 
> I abstract things at irq_work_queue(): "queue this work and let me
> return from this interrupt"

('from this NMI', to come back later as an IRQ, from where we can call
schedule_work_on(). This chaining is because the scheduler takes irqsave
spin-locks to schedule the work.)


>> My badly made point is we could take the NMI that triggers all this from a
>> context that has interrupts masked. We can't take the self-IPI until we return
>> from the NMI, and we return to a context that still has interrupts masked. The
>> original context may cause the NMI to trigger again before it unmasks
>> interrupts. In this case we've livelocked, the recovery work never runs.

> In order to get another NMI from firmware, you need SMM to be triggered
> again. Remember, SMM has to exit before the NMI can be serviced.
> 
> I doubt the livelock is a concern in this place, because we're dealing
> with NMIs invoked by firmware(SMM). NMIs for other reasons would be
> handled elsewhere.

(aha, this might be the difference in the way we see this)


> In the event that FFS fails to prevent and SMI storm, and keeps spamming
> the CPU with NMIs, that is a clear firmware bug. It's also the sort of
> bug I haven't observed in the wild.

Do these SMI ever occur synchronously with the CPUs execution? i.e. if I execute
this instruction, I will get an SMI. (or are these your handled-elsewhere-NMI case?)

On arm64 poisoned-cache locations triggering an external abort (leading to a
NOTIFY_SEA NMI-like notification to APEI) in response to a load is synchronous,
hence the live-lock problem.

I agree AER is very likely to be different.


>> I think something like polling a status register over a broken-link would do
>> this. (has my config write been acknowledge?)

> That would not be a valid reason to disable interrupts. Non-posted PCIe
> requests can take hundreds of milliseconds (memory-mapped or otherwise).
> I can't think of any sort of code that can cause errors to come in via
> NMI which would be a suitable atomic context for disabling interrupts.
> 
> Maybe on arm it's normal to stuff in anything error-related via NMI? On
> x86, most error sources have their own (maskable) interrupt vector.

Maybe. On arm systems error sources might have their own interrupts that are
taken to firmware, and firmware may be able to mask them. This is all hidden in
firmware, which can use something like SDEI to push these onto linux as NMI-like
notifications.


> I am not concert about livelocking the system.

This is what keeps me awake at night.


I think your platform has NMI handled as MCE/kernel-first for synchronous CPU
errors. SMI triggered by PCI-AER are notified by NMI too, but handled by
firmware-first.
This hybrid kernel/firmware first depending on the error-source isn't the only
way of building things. Appendix-N of the UEFI spec lists CPER records for
firmware-first handling of types of error that your platform must 'handle
elsewhere'.

We have arm systems where kernel-first isn't viable as the equivalent of the MCA
registers is platform/integration/silicon-revision specific. These systems
handle all their errors using firmware-first. These systems will generate CPER
records where fatal means fatal, and returning from the NMI-like notification
will either send us into the weeds, or trap us back into firmware.


Thanks,

James
