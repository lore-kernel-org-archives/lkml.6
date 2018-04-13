Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeDMQlq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:41:46 -0400
Received: from foss.arm.com ([217.140.101.70]:44124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751421AbeDMQlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:41:42 -0400
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
 <cdea7af5-6c9b-10c5-a9a9-1481446c65a8@arm.com>
 <2120d34a-41d2-9fff-2710-d11e9a19e12a@gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <855860ef-f84e-00af-ed44-55d6a5a41a94@arm.com>
Date: Fri, 13 Apr 2018 17:38:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2120d34a-41d2-9fff-2710-d11e9a19e12a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 09/04/18 19:11, Alex G. wrote:
> On 04/06/2018 01:24 PM, James Morse wrote:
> Do you have any ETA on when your SEA patches are going to make it
> upstream? There's not much point in updating my patchset if it's going
> to conflict with your work.

The SEA stuff went in with 7edda0886bc3 ("acpi: apei: handle SEA notification
type for ARMv8"). My series is moving it to use the estatus-queue in the same
way as x86's NOTIFY_NMI does. This lets us safely add the other two NMI-like
notifications. I have no idea on the ETA, it depends on review feedback!


>>> But if on arm64, you can return to firmware,
>>> then we have wildly different constraints.
>>
>> We can't return to firmware, but we can take the error again, causing another
>> trap to firmware.
>>
>> e.g.: If a program accesses a value in the cache and the cache location is
>> discovered to be corrupt/marked-as-poisoned. This causes an 'external abort'
>> exception, which firmware has configured to trap to firmware. Once there, it
>> generates CPER records and sets-up an external-abort-exception for Linux.
>> If linux returns from this external-abort, we return to whatever program
>> accessed the bad-cache-value in the first case, re-run the instruction that
>> generates the external abort, and the same thing happens again, but to firmware
>> it looks like a second fault at the same address.

> This is a very good example of why we should _not_ panic in NMI.
> Invalidate the cache-line, next load causes a memory round-trip, and
> everyone's happy. Of course, FFS can't do that because it doesn't know
> if it's valid to invalidate (pun intended). But the OS does. So you
> _want_ to reach the error handler downstream of NMI context, and you do
> _not_ want to crash.

This assumes a cache-invalidate will clear the error, which I don't think we're
guaranteed on arm.
It also destroys any adjacent data, "everyone's happy" includes the thread that
got a chunk of someone-else's stack frame, I don't think it will be happy for
very long!

(this is a side issue for AER though)


>>> On x86, you can't return to SMM. You can have a new SMI triggered while
>>> servicing the NMI, but you can't re-enter an SMI that you've returned
>>> from. SMM holds all the cores, and they all leave SMM at roughly the
>>> same time, so you don't deal with coexistence issues. This probably also
>>> avoids the multiple notifications that you are trying to implement on arm.
>>
>> its the new SMI case.
>>
>> (We don't necessarily have all cores pulled into firmware, (although firmware
>> could do that in software), so different CPUs taking NMI-like notifications is
>> one of the things we have to handle.)

> How does FFS handle race conditions that can occur when accessing HW
> concurrently with the OS? I'm told it's the main reasons why BIOS
> doesn't release unused cores from SMM early.

This is firmware's problem, it depends on whether there is any hardware that is
shared with the OS. Some hardware can be marked 'secure' in which case only
firmware can access it, alternatively firmware can trap or just disable the OS's
access to the shared hardware.

For example, with the v8.2 RAS Extensions, there are some per-cpu error
registers. Firmware can disable these for the OS, so that it always reads 0 from
them. Instead firmware takes the error via FF, reads the registers from
firmware, and dumps CPER records into the OS's memory.

If there is a shared hardware resource that both the OS and firmware may be
accessing, yes firmware needs to pull the other CPUs in, but this depends on the
SoC design, it doesn't necessarily happen.


>>> On quick thought, I think the best way to go for both series is to leave
>>> the entry points arch-specific, and prevent hax86 and harm64 from
>>> stepping on each other's toes. Thoughts?
>>
>> The behaviour should be driven from the standard. I agree there is some leeway,
>> which linux should handle on all architectures that support GHES.
> 
> "The standard" deals mostly with firmware behavior. While I'm all for
> following specifications in order to ensure smooth interaction and
> integration, Linux is an OS and it deals with a plethora of "standards".
> Its job is to serve user requests. When a "standard" deviates from this,
> such as mandating a crash when one is not required, it's the OS's job to
> _not_ follow this requirement.

Sure, we're quirking our behaviour based on a high level of mistrust for the
firmware. My point here was we shouldn't duplicate the implementation because we
want x86:{AER,CPU,MEM} to behave differently to arm64:{AER,CPU,MEM}. I'd rather
the quirked-behaviour was along the *:{AER} versus *:{CPU,MEM} line. If we have
extra code to spot deferrable errors, we should use it on both architectures.


>> Once in ghes.c all the NMI-like notifications get merged together as the only
>> relevant thing about them is we have to use the estatus-queue, and can't call
>> any of the sleepy recovery helpers.
>>
>> I don't think this is the issue though: An NMI notification could by any of the
>> eleven CPER notification record types.
>> Your argument is Linux probably can handle PCIe-AER errors,
> 
> My argument is that Linux should do a best effort to recover from
> hardware (or FFS) errors. In support of that argument, I presented
> evidence that Linux already can handle a variety of errors. How those
> errors are reported determines whether the OS crashes or not, and that's
> not right.

For AER we agree, these never mean 'the CPU is on fire'.


> When errors are reported natively, we make it to the error
> handlers before crashing. And the essence of my argument is that there
> is no reason to have a different behavior with FFS.

For the native CPU-error case, the CPU generates some kind of interrupt out of
firey-death, into the error handler and we put out the fire or panic.

For the firmware-first case this patch returned us to the firey-death, in the
hope of taking an IRQ that would bring us into the error handler.
This won't work if the CPU came out of a mode where interrupts are masked.
Even if they aren't, its not guaranteed on arm64 that we take the interrupt 'in
time'. Doesn't x86 guarantee to execute at least one instruction after an iret?
(I recall something about interrupt storms and forward-progress guarantees).


Some triage of the error in the NMI handler is the right thing to do here. I
agree with your point that AER errors are always deferrable, lets tackle those
first.

(I think user-space memory errors can be deferred if we took the error out of
user-space and can prevent our return with TIF_NEED_RESCHED or equivalent. The
same might work for CPU errors affecting user-space context)


>> even if broken firmware thinks they are fatal.

> I think the idea of firmware-first is broken. But it's there, it's
> shipping in FW, so we have to accommodate it in SW.

Part of our different-views here is firmware-first is taking something away from
you, whereas for me its giving me information that would otherwise be in
secret-soc-specific registers.


>> This is only one of the eleven notification record types. Returning to handle
>> the error definitely doesn't work for some classes of fatal error, especially
>> when interrupts are masked.
> 
>> I think its straightforward to test whether the CPER records contain only errors
>> where we can do better: (not tested/built, I haven't checked whether this is nmi
>> safe):

> That looks very similar to what I had originally implemented.

>> ---------------------%<---------------------
>> /*
>>  * Return true if only PCIe-AER CPER sections are present. We ignore the fatal
>>  * severity in this case as linux knows better. Called in_nmi().
>>  */
>> static bool ghes_is_deferrable(struct ghes *ghes,
>>        const struct acpi_hest_generic_status *estatus)
>> {
>>        guid_t *sec_type;
>>        struct acpi_hest_generic_data *gdata;
>>
>>        apei_estatus_for_each_section(estatus, gdata) {
>>                sec_type = (guid_t *)gdata->section_type;
>>                if (!guid_equal(sec_type, &CPER_SEC_PCIE))
> 
> Also need to check if the CPER record contains enough information to
> identify the cause of the error. There's no guarantee the record even
> has a valid PCI BDF, let alone error information. Possible? yes. Easy?
> yes. Advisable? maybe.

If AER errors never prevent the CPU getting to the deferred error handler, we
can do that sort of thing there.


>>>> My point was there is a class of reported-as-fatal error that really is fatal,
>>>> and for these trying to defer the work to irq_work is worse than panic()ing as
>>>> we get less information about what happened.
>>>
>>> How do we get less information? We save the GHES structure on the
>>> estatus_queue, and use it as the error source in either case. Is there a
>>> class of errors where we can reasonable expect things to be okay in NMI,
>>> but go horribly wrong on return from NMI?
>>
>> Yes, (described above). This could happen if we see Arm64's 'SEA' CPER  records
>> or x86's 'MCE' CPER records. I'm pretty sure it will happen on both
>> architectures if you return to a context with interrupts masked.

> And linux can handle a wide subset of MCEs just fine, so the
> ghes_is_deferrable() logic would, under my argument, agree to pass
> execution to the actual handlers.

For some classes of error we can't safely get there.


> I do agree that this is one case where
> splitting the handler in a top half and bottom half would make sense.

Yes, splitting this stuff up to have all the NMI-safe stuff up-front, then drop
to IRQ-context for the next round would make this a lot easier.


> Though in that case, the problem is generalized to "how to best handle
> error Y", rather than "how to handle error Y in FFS".

(that's a good thing yes?) I assume x86 can take MCE errors out of IRQ-masked
code. Sharing the handle_foo_error_nmi() code between the two paths would be a
good thing.


>>>> Are all AER errors recoverable?  (is an OS:'fatal' AER error ever valid?)
>>>
>>> PCIe "fatal" means that your link is gone and you might not get it back.
>>> You lose all the downstream devices. You may be able to reset the link
>>> and get it back. This sort of "fatal" has no impact on a machine's
>>> ability to continue operation.
>>>
>>> From ACPI, FFS should only send a "fatal" error if a machine needs reset
>>> [1], so it's clearly a firmware bug to mark any PCIe error "fatal". This
>>> won't stop BIOS vendors from taking shortcuts and deciding to crash an
>>> OS by sending the error as "fatal".
>>>
>>> [1]ACPI 6.2: 18.1Hardware Errors and Error Sources
>>
>> Great! Its never valid. So we can check the CPER records in the NMI handler, and
>> for AER errors, clear the fatal bit printing a nasty message about the firmware.

> There's the counter-argument that the machine is a "XYZ" appliance, and
> losing the PCIe link to the "XYZ" device is essentially "fatal" to the
> (purpose of the) machine. As you noted, there is some leeway ;)

For any appliance I'd expect some health-monitor-thing to spot all the disks in
the disk-enclosure have disappeared and reboot.
(Losing the root-filsystem is probably the general case).


> Sarcasm aside, I do like the idea of a message complaining about the
> firmware.

It wouldn't be appropriate in all cases, but for AER it looks like 'fatal' is
always an over-reaction.
For example, given a memory error firmware can't know whether we can re-read
some page of kernel memory from disk and then reschedule the thread.


>>> That's the approach I originally tried, but I didn't like it. The
>>> parsing gets deeper and deeper, and, by the time you realize if the
>>> error can be handled or not, you're already halfway through recovery.
>>>
>>> This is a perfectly viable approach. However, is there a palpable
>>> (non-theoretical) concern that warrants complicating things this way?
>>
>> For AER your text above says no, we can always handle an error, they are never
>> fatal.
>>
>> For memory-errors, yes. An ECC error for a location on the kernel stack while
>> the affected thread was preempt_disable()d. We can't kick the thread off the
>> CPU, and we can't return from the handler as we can't stop accesses to the stack
>> when we return.
>>
>> We can avoid it being complicated by just separating AER errors out when they
>> come in. You've said they never mean the OS has to reboot.
> 
> If we're going to split recovery paths, then it makes better sense to
> have a system where handleable errors are passed down to a lesser
> context. Or even run non-blocking handlers in whatever context they are
> received. Much more than having a special case for a specific error.

Yes. I think running the NMI-safe parts of the handler first, then the IRQ-parts
when we drop to IRQ context is the way to do this.


>>> I abstract things at irq_work_queue(): "queue this work and let me
>>> return from this interrupt"
>>
>> ('from this NMI', to come back later as an IRQ, from where we can call
>> schedule_work_on(). This chaining is because the scheduler takes irqsave
>> spin-locks to schedule the work.)
> 
> Hopefully, the handling is set up in such a way that I don't have to
> worry about these details on a per-error basis. If I do have to worry,
> them I must be doing something wrong.

I agree, but something has to know. Lets tackle AER first, where we have none of
theses concerns, then tackle those that are more closely tied to the CPU state.


>>> In the event that FFS fails to prevent and SMI storm, and keeps spamming
>>> the CPU with NMIs, that is a clear firmware bug. It's also the sort of
>>> bug I haven't observed in the wild.
>>
>> Do these SMI ever occur synchronously with the CPUs execution? i.e. if I execute
>> this instruction, I will get an SMI. (or are these your handled-elsewhere-NMI case?)
> 
> I'm not aware of synchronous exceptions that end up as SMIs, though I
> imagine it is possible on x86. An IO write to an SMI trap is equivalent
> to that.

Okay, that's good to know.


>> On arm64 poisoned-cache locations triggering an external abort (leading to a
>> NOTIFY_SEA NMI-like notification to APEI) in response to a load is synchronous,
>> hence the live-lock problem.
> 
> How is this currently handled in the kernel-first case?

We don't have any kernel-first support today it would need the Arm version of
MCA (v8.2 RAS Extensions) which are relatively new. Everything we've seen so far
is using firmware-first as it has to know a little about the SoC topology.

How would it be handled? For the kernel-first version of NOTIFY_SEA the code
would get the interrupted pt_regs and can probe the RAS Error registers to get
the physical address and properties of the fault. It can then determine whether
this can be handled, and kick off the appropriate recovery helper.
If it interrupted the kernel, the helper has to schedule the recovery work, if
it interrupted interrupts-masked code, it would have to self-IPI to then be able
to schedule the work. The same return-to-a-broken-context problem exists for
kernel-first, we can't do it there either.


>>> I am not concert about livelocking the system.
>>
>> This is what keeps me awake at night.
> 
> Nothing keeps me awake at night. I keep others awake at night.

(Ha! I owe you a beer!)


>> I think your platform has NMI handled as MCE/kernel-first for synchronous CPU
>> errors. SMI triggered by PCI-AER are notified by NMI too, but handled by
>> firmware-first.
> 
> MCEs come in via FFS.

Oh? I thought those were to separate worlds. I assumed MCE-NMIs didn't go via SMM.


> There's a school of thought that sees a certain
> value in logging ECC errors to the BMC. It's arguable whether the ECC
> errors are synchronous in 100% of cases.


>> This hybrid kernel/firmware first depending on the error-source isn't the only
>> way of building things. Appendix-N of the UEFI spec lists CPER records for
>> firmware-first handling of types of error that your platform must 'handle
>> elsewhere'.
>>
>> We have arm systems where kernel-first isn't viable as the equivalent of the MCA
>> registers is platform/integration/silicon-revision specific. These systems
>> handle all their errors using firmware-first. These systems will generate CPER
>> records where fatal means fatal, and returning from the NMI-like notification
>> will either send us into the weeds, or trap us back into firmware.
> 
> Without getting into details, the non-viablity of kernel-first is
> subjective.

Sure, there are some similar problems for both.


I think the way forward here is to spot defer-able errors, even if they are
marked fatal. Initially this will just be AER, but if we can split up the
handlers to have NMI/IRQ/Process context counterparts, we may be able to do
enough work early-on to defer other types of error.


Thanks,

James
