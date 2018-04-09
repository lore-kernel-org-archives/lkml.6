Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbeDISLR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:11:17 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46161 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752846AbeDISLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:11:13 -0400
X-Google-Smtp-Source: AIpwx48Qyf8c+iEkUnSGbDA0Jg9MeJrk2cUxYUIZvtL/wogMRm7n5YuMTNHK2bKjTvCtnH/pqJgVqw==
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
 <9e29e5c6-b942-617e-f92e-728627799506@gmail.com>
 <cdea7af5-6c9b-10c5-a9a9-1481446c65a8@arm.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <2120d34a-41d2-9fff-2710-d11e9a19e12a@gmail.com>
Date: Mon, 9 Apr 2018 13:11:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cdea7af5-6c9b-10c5-a9a9-1481446c65a8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 04/06/2018 01:24 PM, James Morse wrote:

Do you have any ETA on when your SEA patches are going to make it
upstream? There's not much point in updating my patchset if it's going
to conflict with your work.

(snip)
>> On the contrary. No output, followed by a watchdog reboot is usually
>> what happens when the panic() is in NMI. One of the very few ways that
>> can be debugged is over a NULL modem cable.
> 
> (IPMI-SOL?)
> 
> Really? printk has NMI support, and panic()s call to bust_spinlocks() should
> unblank the screen before printk_safe_flush_on_panic() dumps the messages. (I'm
> assuming some BMC-VGA exists to capture the 'screen').

Plausible. There are other mechanisms though that may reset the system
before it is practical to capture the screen.

(snip)
>> But if on arm64, you can return to firmware,
>> then we have wildly different constraints.
> 
> We can't return to firmware, but we can take the error again, causing another
> trap to firmware.
> 
> e.g.: If a program accesses a value in the cache and the cache location is
> discovered to be corrupt/marked-as-poisoned. This causes an 'external abort'
> exception, which firmware has configured to trap to firmware. Once there, it
> generates CPER records and sets-up an external-abort-exception for Linux.
> If linux returns from this external-abort, we return to whatever program
> accessed the bad-cache-value in the first case, re-run the instruction that
> generates the external abort, and the same thing happens again, but to firmware
> it looks like a second fault at the same address.

This is a very good example of why we should _not_ panic in NMI.
Invalidate the cache-line, next load causes a memory round-trip, and
everyone's happy. Of course, FFS can't do that because it doesn't know
if it's valid to invalidate (pun intended). But the OS does. So you
_want_ to reach the error handler downstream of NMI context, and you do
_not_ want to crash.


(snip)
>> On x86, you can't return to SMM. You can have a new SMI triggered while
>> servicing the NMI, but you can't re-enter an SMI that you've returned
>> from. SMM holds all the cores, and they all leave SMM at roughly the
>> same time, so you don't deal with coexistence issues. This probably also
>> avoids the multiple notifications that you are trying to implement on arm.
> 
> its the new SMI case.
> 
> (We don't necessarily have all cores pulled into firmware, (although firmware
> could do that in software), so different CPUs taking NMI-like notifications is
> one of the things we have to handle.)

How does FFS handle race conditions that can occur when accessing HW
concurrently with the OS? I'm told it's the main reasons why BIOS
doesn't release unused cores from SMM early.


>> On quick thought, I think the best way to go for both series is to leave
>> the entry points arch-specific, and prevent hax86 and harm64 from
>> stepping on each other's toes. Thoughts?
> 
> The behaviour should be driven from the standard. I agree there is some leeway,
> which linux should handle on all architectures that support GHES.

"The standard" deals mostly with firmware behavior. While I'm all for
following specifications in order to ensure smooth interaction and
integration, Linux is an OS and it deals with a plethora of "standards".
Its job is to serve user requests. When a "standard" deviates from this,
such as mandating a crash when one is not required, it's the OS's job to
_not_ follow this requirement.


> The entry points from the arch code are already separate, as these have
> different notification types in the HEST->GHES entries and different
> registration requirements.
> Once in ghes.c all the NMI-like notifications get merged together as the only
> relevant thing about them is we have to use the estatus-queue, and can't call
> any of the sleepy recovery helpers.
> 
> I don't think this is the issue though: An NMI notification could by any of the
> eleven CPER notification record types.
> Your argument is Linux probably can handle PCIe-AER errors,

My argument is that Linux should do a best effort to recover from
hardware (or FFS) errors. In support of that argument, I presented
evidence that Linux already can handle a variety of errors. How those
errors are reported determines whether the OS crashes or not, and that's
not right. When errors are reported natively, we make it to the error
handlers before crashing. And the essence of my argument is that there
is no reason to have a different behavior with FFS.

> even if broken firmware thinks they are fatal.

I think the idea of firmware-first is broken. But it's there, it's
shipping in FW, so we have to accommodate it in SW.


> This is only one of the eleven notification record types. Returning to handle
> the error definitely doesn't work for some classes of fatal error, especially
> when interrupts are masked.

> I think its straightforward to test whether the CPER records contain only errors
> where we can do better: (not tested/built, I haven't checked whether this is nmi
> safe):
That looks very similar to what I had originally implemented.
> ---------------------%<---------------------
> /*
>  * Return true if only PCIe-AER CPER sections are present. We ignore the fatal
>  * severity in this case as linux knows better. Called in_nmi().
>  */
> static bool ghes_is_deferrable(struct ghes *ghes,
>        const struct acpi_hest_generic_status *estatus)
> {
>        guid_t *sec_type;
>        struct acpi_hest_generic_data *gdata;
> 
>        apei_estatus_for_each_section(estatus, gdata) {
>                sec_type = (guid_t *)gdata->section_type;
>                if (!guid_equal(sec_type, &CPER_SEC_PCIE))

Also need to check if the CPER record contains enough information to
identify the cause of the error. There's no guarantee the record even
has a valid PCI BDF, let alone error information. Possible? yes. Easy?
yes. Advisable? maybe.


(snip)
>>> My point was there is a class of reported-as-fatal error that really is fatal,
>>> and for these trying to defer the work to irq_work is worse than panic()ing as
>>> we get less information about what happened.
>>
>> How do we get less information? We save the GHES structure on the
>> estatus_queue, and use it as the error source in either case. Is there a
>> class of errors where we can reasonable expect things to be okay in NMI,
>> but go horribly wrong on return from NMI?
> 
> Yes, (described above). This could happen if we see Arm64's 'SEA' CPER  records
> or x86's 'MCE' CPER records. I'm pretty sure it will happen on both
> architectures if you return to a context with interrupts masked.

And linux can handle a wide subset of MCEs just fine, so the
ghes_is_deferrable() logic would, under my argument, agree to pass
execution to the actual handlers. I do agree that this is one case where
splitting the handler in a top half and bottom half would make sense.
Though in that case, the problem is generalized to "how to best handle
error Y", rather than "how to handle error Y in FFS".


>> (snip)
>>> Are all AER errors recoverable?  (is an OS:'fatal' AER error ever valid?)
>>
>> PCIe "fatal" means that your link is gone and you might not get it back.
>> You lose all the downstream devices. You may be able to reset the link
>> and get it back. This sort of "fatal" has no impact on a machine's
>> ability to continue operation.
>>
>> From ACPI, FFS should only send a "fatal" error if a machine needs reset
>> [1], so it's clearly a firmware bug to mark any PCIe error "fatal". This
>> won't stop BIOS vendors from taking shortcuts and deciding to crash an
>> OS by sending the error as "fatal".
>>
>> [1]ACPI 6.2: 18.1Hardware Errors and Error Sources
> 
> Great! Its never valid. So we can check the CPER records in the NMI handler, and
> for AER errors, clear the fatal bit printing a nasty message about the firmware.

There's the counter-argument that the machine is a "XYZ" appliance, and
losing the PCIe link to the "XYZ" device is essentially "fatal" to the
(purpose of the) machine. As you noted, there is some leeway ;)
Sarcasm aside, I do like the idea of a message complaining about the
firmware.

(snip)
>> That's the approach I originally tried, but I didn't like it. The
>> parsing gets deeper and deeper, and, by the time you realize if the
>> error can be handled or not, you're already halfway through recovery.
>>
>> This is a perfectly viable approach. However, is there a palpable
>> (non-theoretical) concern that warrants complicating things this way?
> 
> For AER your text above says no, we can always handle an error, they are never
> fatal.
> 
> For memory-errors, yes. An ECC error for a location on the kernel stack while
> the affected thread was preempt_disable()d. We can't kick the thread off the
> CPU, and we can't return from the handler as we can't stop accesses to the stack
> when we return.
> 
> We can avoid it being complicated by just separating AER errors out when they
> come in. You've said they never mean the OS has to reboot.

If we're going to split recovery paths, then it makes better sense to
have a system where handleable errors are passed down to a lesser
context. Or even run non-blocking handlers in whatever context they are
received. Much more than having a special case for a specific error.


(snip)
>> I abstract things at irq_work_queue(): "queue this work and let me
>> return from this interrupt"
> 
> ('from this NMI', to come back later as an IRQ, from where we can call
> schedule_work_on(). This chaining is because the scheduler takes irqsave
> spin-locks to schedule the work.)

Hopefully, the handling is set up in such a way that I don't have to
worry about these details on a per-error basis. If I do have to worry,
them I must be doing something wrong.


(snip)
>> In the event that FFS fails to prevent and SMI storm, and keeps spamming
>> the CPU with NMIs, that is a clear firmware bug. It's also the sort of
>> bug I haven't observed in the wild.
> 
> Do these SMI ever occur synchronously with the CPUs execution? i.e. if I execute
> this instruction, I will get an SMI. (or are these your handled-elsewhere-NMI case?)

I'm not aware of synchronous exceptions that end up as SMIs, though I
imagine it is possible on x86. An IO write to an SMI trap is equivalent
to that.

> On arm64 poisoned-cache locations triggering an external abort (leading to a
> NOTIFY_SEA NMI-like notification to APEI) in response to a load is synchronous,
> hence the live-lock problem.

How is this currently handled in the kernel-first case?


(snip)
> Maybe. On arm systems error sources might have their own interrupts that are
> taken to firmware,

That sounds like an even bigger headache than x86.


>> I am not concert about livelocking the system.
> 
> This is what keeps me awake at night.

Nothing keeps me awake at night. I keep others awake at night.

> I think your platform has NMI handled as MCE/kernel-first for synchronous CPU
> errors. SMI triggered by PCI-AER are notified by NMI too, but handled by
> firmware-first.

MCEs come in via FFS. There's a school of thought that sees a certain
value in logging ECC errors to the BMC. It's arguable whether the ECC
errors are synchronous in 100% of cases.

> This hybrid kernel/firmware first depending on the error-source isn't the only
> way of building things. Appendix-N of the UEFI spec lists CPER records for
> firmware-first handling of types of error that your platform must 'handle
> elsewhere'.
> 
> We have arm systems where kernel-first isn't viable as the equivalent of the MCA
> registers is platform/integration/silicon-revision specific. These systems
> handle all their errors using firmware-first. These systems will generate CPER
> records where fatal means fatal, and returning from the NMI-like notification
> will either send us into the weeds, or trap us back into firmware.

Without getting into details, the non-viablity of kernel-first is
subjective.

Alex
