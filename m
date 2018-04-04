Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeDDTty (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:49:54 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34909 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeDDTtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:49:50 -0400
X-Google-Smtp-Source: AIpwx4+cSSPZkz9XkHJiN5zkDHVFP3CuWCfZqRyzZTmyI4jQJY9075NSpNE2LC//G72//jvoRJ/FiA==
Subject: Re: [RFC PATCH 3/4] acpi: apei: Do not panic() in NMI because of GHES
 messages
To: James Morse <james.morse@arm.com>
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
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <9e29e5c6-b942-617e-f92e-728627799506@gmail.com>
Date: Wed, 4 Apr 2018 14:49:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e65986c8-55a1-14c4-5c06-f34fa25916d8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2018 11:53 AM, James Morse wrote:
> Hi Alex,
(snip)
>>> How do we know we will survive this trip?
>>
>> We don't.
> 
> Isn't that even worse than panic()ing? (No output, followed by a watchdog reboot
> if we're lucky)

On the contrary. No output, followed by a watchdog reboot is usually
what happens when the panic() is in NMI. One of the very few ways that
can be debugged is over a NULL modem cable.

>>> On arm64 systems it may not be possible to return to the context we took the NMI
>>> notification from: we may bounce back into firmware with the same "world is on
>>> fire" error. Firmware can rightly assume the OS has made no attempt to handle
>>> the error. 
>>
>> I'm not aware of the NMI path being used on arm64:
>> $ git grep 'select HAVE_ACPI_APEI_NMI'
>> arch/x86/Kconfig:       select HAVE_ACPI_APEI_NMI               if ACPI
>> $
> 
> (I agree its not obvious!), arm64 has NOTIFY_SEA, NOTIFY_SEI and NOTIFY_SDEI
> that all behave like NOTIFY_NMI (in that they can interrupt IRQ-masked code).
> 
> CONFIG_HAVE_ACPI_APEI_NMI has come to mean NOTIFY_NMI, which requires the arch
> code to implement register_nmi_handler() and (from memory) behave as a notifier
> chain, which doesn't fit with how these things behave.
>
> NOTIFY_SEA lives behind CONFIG_ACPI_APEI_SEA in driver/acpi/apei/Kconfig.
> The series to add SDEI support is on the list here:
> https://www.spinics.net/lists/arm-kernel/msg642946.html
> (NOTIFY_SEI is very tricky for firmware to get right, I don't think we're there
> yet.)

>From my understanding, your patch series tries to use ghes_notify_nmi()
as a common entry point. But if on arm64, you can return to firmware,
then we have wildly different constraints.

On x86, you can't return to SMM. You can have a new SMI triggered while
servicing the NMI, but you can't re-enter an SMI that you've returned
from. SMM holds all the cores, and they all leave SMM at roughly the
same time, so you don't deal with coexistence issues. This probably also
avoids the multiple notifications that you are trying to implement on arm.

On quick thought, I think the best way to go for both series is to leave
the entry points arch-specific, and prevent hax86 and harm64 from
stepping on each other's toes. Thoughts?


(snip)
> Wouldn't reasonably-intelligent firmware be able to spot the same fault
> repeatedly in a loop? (last-fault-address == this-fault-address,
> last-fault-time==now)

I'm told that the BIOS on Dell machines will detect interrupt storms,
and disable the specific error source in such cases. On an x86 server.
50us of SMM eats up several milliseconds-core of CPU time, so they try
to be a little careful.

>>> Your 'not re-arming the error' example makes this worrying.
>>
>> Those are one class of bugs you get when you let firmware run the show.
>> It's been an issue since day one of EFI. The best you can do in such
>> cases is accept you may later lose the link to a device.
>> Side-note: We have a BIOS defect filed with against this particular
>> issue, and it only seems to affect PCIe SMIs.
> 
> This sounds like policy applied too early

That's firmware-first in one sentence.

> fixing the firmware to at least make this configurable would be preferable.

I can ask for "fixing the firmware" and we might even get the fix, but
the fact remains that there are machines in the field with the buggy
BIOSes, and there will continue to be such machines even after a fix is
released.


> My point was there is a class of reported-as-fatal error that really is fatal,
> and for these trying to defer the work to irq_work is worse than panic()ing as
> we get less information about what happened.

How do we get less information? We save the GHES structure on the
estatus_queue, and use it as the error source in either case. Is there a
class of errors where we can reasonable expect things to be okay in NMI,
but go horribly wrong on return from NMI?

(snip)
> Are all AER errors recoverable?  (is an OS:'fatal' AER error ever valid?)

PCIe "fatal" means that your link is gone and you might not get it back.
You lose all the downstream devices. You may be able to reset the link
and get it back. This sort of "fatal" has no impact on a machine's
ability to continue operation.

>From ACPI, FFS should only send a "fatal" error if a machine needs reset
[1], so it's clearly a firmware bug to mark any PCIe error "fatal". This
won't stop BIOS vendors from taking shortcuts and deciding to crash an
OS by sending the error as "fatal".

[1]ACPI 6.2: 18.1Hardware Errors and Error Sources


>> The alternative is to keep ghes_do_proc() and ghes_notify_nmi() in sync,
>> duplicate code between the two. But we can also get ghes_proc_irq_work()
>> as an entry point, and this easily turns in a maintenance nightmare.
> 
> We can't call all the recovery-helpers from ghes_notify_nmi() as they sleep and
> allocate memory. I think the trick would be to make the CPER parsing routines
> NMI-safe so that we can check these 'fatal' records for cases where we're pretty
> sure linux can do a better job.

can_i_handle_this_nonblocking(struct four_letter_acronum_err *err) ?

That's the approach I originally tried, but I didn't like it. The
parsing gets deeper and deeper, and, by the time you realize if the
error can be handled or not, you're already halfway through recovery.

This is a perfectly viable approach. However, is there a palpable
(non-theoretical) concern that warrants complicating things this way?

>>> For the PCI*/AER errors we should be able to try and handle it ... if we can get
>>> back to process/IRQ context:
>>> What happens if a PCIe driver has interrupts masked and is doing something to
>>> cause this error? We can take the NMI and setup the irq-work, but it may never
>>> run as we return to interrupts-masked context.
>>
>> The way the recovery from NMI is set up is confusing. On NMIs,
>> ghes_proc_in_irq() is queued up to do further work. Despite the name, in
>> this case it runs as a task. That further queues up AER work,
>> Either way, PCIe endpoint interrupts are irrelevant here. AER recovery
>> runs independent of drivers or interrupts:
> 
> Hmm, we may be looking at different things, (and I'm not familiar with x86):
> ghes_notify_nmi() uses irq_work_queue() to add the work to a percpu llist and
> call arch_irq_work_raise(). arch_irq_work_raise() sends a self IPI, which, once
> taken causes the arch code to call irq_work_run() to consume the llist.

I abstract things at irq_work_queue(): "queue this work and let me
return from this interrupt"

> My badly made point is we could take the NMI that triggers all this from a
> context that has interrupts masked. We can't take the self-IPI until we return
> from the NMI, and we return to a context that still has interrupts masked. The
> original context may cause the NMI to trigger again before it unmasks
> interrupts. In this case we've livelocked, the recovery work never runs.

In order to get another NMI from firmware, you need SMM to be triggered
again. Remember, SMM has to exit before the NMI can be serviced.

I doubt the livelock is a concern in this place, because we're dealing
with NMIs invoked by firmware(SMM). NMIs for other reasons would be
handled elsewhere.
In the event that FFS fails to prevent and SMI storm, and keeps spamming
the CPU with NMIs, that is a clear firmware bug. It's also the sort of
bug I haven't observed in the wild.


> I think something like polling a status register over a broken-link would do
> this. (has my config write been acknowledge?)

That would not be a valid reason to disable interrupts. Non-posted PCIe
requests can take hundreds of milliseconds (memory-mapped or otherwise).
I can't think of any sort of code that can cause errors to come in via
NMI which would be a suitable atomic context for disabling interrupts.

Maybe on arm it's normal to stuff in anything error-related via NMI? On
x86, most error sources have their own (maskable) interrupt vector. I am
not concert about livelocking the system.

(snip)
>> I can see an issue if we somehow lose the ability to run queued
>> tasks, but in that case, we've already lost control of the machine.
> 
> about to loose control of the machine: firmware has saved the day giving us a
> clean slate and some standardised messages that describe the fault.

In theory, yes. In practice, by the time OS gets control things are
usually worse than they would have been without FFS.
"standardized" is really a pipe dream, especially on x86, where each
vendor interprets things differently, so the OS still has to figure it
all out on its own.

> I agree we can do better for AER errors, but I don't think we should make the
> handling of other classes of error worse. These classes match nicely to the CPER
> record types, which we already have mapped in ghes_notify_nmi().

My approach is to _not_ trust the firmware. I hope arm does it better,
but on x86, each hardware vendor does what it thinks is best in
firmware. The result is wildly different FFS behavior between vendors.
This is something that an OS then, cannot rely upon.

Alex
