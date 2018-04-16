Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeDPV7f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:59:35 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34009 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbeDPV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:59:32 -0400
X-Google-Smtp-Source: AIpwx48/ZRNghs1MsuaBB3yY7uWU/Qm+cP2ZkPXtuTBrsSJNNw2hNMhy6m3XV/OPb5aqxYY6KUAneg==
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
 <2120d34a-41d2-9fff-2710-d11e9a19e12a@gmail.com>
 <855860ef-f84e-00af-ed44-55d6a5a41a94@arm.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <70c0a230-945a-3a1a-7c49-4b0784a3cfa6@gmail.com>
Date: Mon, 16 Apr 2018 16:59:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <855860ef-f84e-00af-ed44-55d6a5a41a94@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/2018 11:38 AM, James Morse wrote:
> Hi Alex,
> 
> On 09/04/18 19:11, Alex G. wrote:
>> On 04/06/2018 01:24 PM, James Morse wrote:
>> Do you have any ETA on when your SEA patches are going to make it
>> upstream? There's not much point in updating my patchset if it's going
>> to conflict with your work.
> 
> The SEA stuff went in with 7edda0886bc3 ("acpi: apei: handle SEA notification
> type for ARMv8"). My series is moving it to use the estatus-queue in the same
> way as x86's NOTIFY_NMI does. This lets us safely add the other two NMI-like
> notifications. I have no idea on the ETA, it depends on review feedback!

Okay. I'll get a v2 out soonish then.

(snip)
> This assumes a cache-invalidate will clear the error, which I don't think we're
> guaranteed on arm.
> It also destroys any adjacent data, "everyone's happy" includes the thread that
> got a chunk of someone-else's stack frame, I don't think it will be happy for
> very long!

Hmm, no cache-line (or page) invalidation on arm64? How does
dma_map/unmap_*() work then? You may not guarantee to fix the error, but
I don't buy into the "let's crash without trying" argument.

> (this is a side issue for AER though)

Somebody muddled up AER with these tables, so we now have to worry about
it. :)

(snip)
>> How does FFS handle race conditions that can occur when accessing HW
>> concurrently with the OS? I'm told it's the main reasons why BIOS
>> doesn't release unused cores from SMM early.
> 
> This is firmware's problem, it depends on whether there is any hardware that is
> shared with the OS. Some hardware can be marked 'secure' in which case only
> firmware can access it, alternatively firmware can trap or just disable the OS's
> access to the shared hardware.

It's everyone's problem. It's the firmware's responsibility.

> For example, with the v8.2 RAS Extensions, there are some per-cpu error
> registers. Firmware can disable these for the OS, so that it always reads 0 from
> them. Instead firmware takes the error via FF, reads the registers from
> firmware, and dumps CPER records into the OS's memory.
> 
> If there is a shared hardware resource that both the OS and firmware may be
> accessing, yes firmware needs to pull the other CPUs in, but this depends on the
> SoC design, it doesn't necessarily happen.

The problem with shared resources is just a problem. I've seen systems
where all 100 cores are held up for 300+ ms. In latency-critical
applications reliability drops exponentially. Am I correct in assuming
your answer would be to "hide" more stuff from the OS?


(snip)
> Sure, we're quirking our behaviour based on a high level of mistrust for the
> firmware. My point here was we shouldn't duplicate the implementation because we
> want x86:{AER,CPU,MEM} to behave differently to arm64:{AER,CPU,MEM}. I'd rather
> the quirked-behaviour was along the *:{AER} versus *:{CPU,MEM} line. If we have
> extra code to spot deferrable errors, we should use it on both architectures.

It's a well earned and well deserved mistrust. Firmware is evil (*).

(*) sarcastic overstatement of facts


(snip)
> For AER we agree, these never mean 'the CPU is on fire'.

Sounds like a good marketing slogan:
"ACME's new turbo-encabulated CPU -- it's on fire!"


(snip)
>>> even if broken firmware thinks they are fatal.
> 
>> I think the idea of firmware-first is broken. But it's there, it's
>> shipping in FW, so we have to accommodate it in SW.
> 
> Part of our different-views here is firmware-first is taking something away from
> you, whereas for me its giving me information that would otherwise be in
> secret-soc-specific registers.

Under this interpretation, FFS is a band-aid to the problem of "secret"
registers. "Secret" hardware doesn't really fit well into the idea of an
OS [1]. The irony of the solution is that the response is centered on
firmware extensions which were designed to stile interoperability [2].

You are right, FFS is a poopstorm and headache for me. It takes my
sanity away. I once wrote FW for a laptop where the only use of SMM was
to run the "Enable ACPI" call -- which only disabled further SMM. We
didn't need an iota of FFS because at that time AMD wasn't secretive,
and there was no need to have "secret" registers in the first place.

[1] https://www.youtube.com/watch?v=_36yNWw_07g
[2]
http://antitrust.slated.org/www.iowaconsumercase.org/011607/3000/PX03020.pdf

(snip)
>> And linux can handle a wide subset of MCEs just fine, so the
>> ghes_is_deferrable() logic would, under my argument, agree to pass
>> execution to the actual handlers.
> 
> For some classes of error we can't safely get there.

Optimize for the common case.

(snip)
>> Though in that case, the problem is generalized to "how to best handle
>> error Y", rather than "how to handle error Y in FFS".
> 
> (that's a good thing yes?) I assume x86 can take MCE errors out of IRQ-masked
> code. Sharing the handle_foo_error_nmi() code between the two paths would be a
> good thing.

That's a good thing, yes. But, by ignorance, FFS doesn't always let you
do this. Getting to your kernel data structures is not IRQ-safe in the
general case. In the AER case, you need pci_get_domain_bus_and_slot(),
which is not IRQ-safe. So, while in the native case, you can stage
context pointers, and separate things based on interrupt vector, you
don't get this sort of flexibility with FFS.

There is the extra step of recovering your context, which is not the
sort of situation you often get with kernel-first. Most of the
discussion has been around whether to crash before we even get this
context. Stay tuned for v2 though.

(snip)
>> Sarcasm aside, I do like the idea of a message complaining about the
>> firmware.
> 
> It wouldn't be appropriate in all cases, but for AER it looks like 'fatal' is
> always an over-reaction.
> For example, given a memory error firmware can't know whether we can re-read
> some page of kernel memory from disk and then reschedule the thread.

If firmware can't know the error is recoverable, it also can't know it's
fatal. When firmware does try to make a determination from insufficient
information, it opens itself up to sarky remarks. That's fair game.

(snip)
>> If we're going to split recovery paths, then it makes better sense to
>> have a system where handleable errors are passed down to a lesser
>> context. Or even run non-blocking handlers in whatever context they are
>> received. Much more than having a special case for a specific error.
> 
> Yes. I think running the NMI-safe parts of the handler first, then the IRQ-parts
> when we drop to IRQ context is the way to do this.

Coming soon to a ML near you.

>>>> I abstract things at irq_work_queue(): "queue this work and let me
>>>> return from this interrupt"
>>>
>>> ('from this NMI', to come back later as an IRQ, from where we can call
>>> schedule_work_on(). This chaining is because the scheduler takes irqsave
>>> spin-locks to schedule the work.)
>>
>> Hopefully, the handling is set up in such a way that I don't have to
>> worry about these details on a per-error basis. If I do have to worry,
>> them I must be doing something wrong.
> 
> I agree, but something has to know. Lets tackle AER first,

The actual handler knows. For AER, that's do_recovery().

> where we have none of theses concerns

Untamed PCIe errors can end up as MCEs and triple-fault the CPU :)
You didn't think we get a free ride with AER, did you?

(snip)
>>> On arm64 poisoned-cache locations triggering an external abort (leading to a
>>> NOTIFY_SEA NMI-like notification to APEI) in response to a load is synchronous,
>>> hence the live-lock problem.
>>
>> How is this currently handled in the kernel-first case?
> 
> We don't have any kernel-first support today

:(

> it would need the Arm version of
> MCA (v8.2 RAS Extensions) which are relatively new. Everything we've seen so far
> is using firmware-first as it has to know a little about the SoC topology.
> 
> How would it be handled? For the kernel-first version of NOTIFY_SEA the code
> would get the interrupted pt_regs and can probe the RAS Error registers (snip)

Sounds like a regular, standard, raceless error handler :)


>>>> I am not concert about livelocking the system.
>>>
>>> This is what keeps me awake at night.
>>
>> Nothing keeps me awake at night. I keep others awake at night.
> 
> (Ha! I owe you a beer!)

(I will not forget)

>>> I think your platform has NMI handled as MCE/kernel-first for synchronous CPU
>>> errors. SMI triggered by PCI-AER are notified by NMI too, but handled by
>>> firmware-first.
>>
>> MCEs come in via FFS.
> 
> Oh? I thought those were to separate worlds. I assumed MCE-NMIs didn't go via SMM.

FFS is done in SMM. I'm certain there's a very simple and easy way in
which MCEs can be reported kernel-first, but I've only seen it done FFS
recently.

(snip)
> I think the way forward here is to spot defer-able errors, even if they are
> marked fatal. Initially this will just be AER, but if we can split up the
> handlers to have NMI/IRQ/Process context counterparts, we may be able to do
> enough work early-on to defer other types of error.

You're gonna love my v2.

Alex
