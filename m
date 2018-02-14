Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966740AbeBNDWW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:22:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15396 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966723AbeBNDWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:22:20 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37041819"
Subject: Re: [PATCH v3 2/5] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, <tglx@linutronix.de>, <x86@kernel.org>,
        <joro@8bytes.org>, <uobergfe@redhat.com>, <prarit@redhat.com>
References: <20180209121008.28980-1-bhe@redhat.com>
 <20180209121008.28980-3-bhe@redhat.com> <87r2pq9a60.fsf@xmission.com>
 <bb1a2eb2-335a-b789-4274-6b62dd5ef2ef@cn.fujitsu.com>
 <87vaf03i06.fsf@xmission.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <62686ee8-4d67-753d-3442-5456a2ba7076@cn.fujitsu.com>
Date: Wed, 14 Feb 2018 11:22:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87vaf03i06.fsf@xmission.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 5AA2E48AE762.ACCEE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

At 02/14/2018 01:40 AM, Eric W. Biederman wrote:
> Dou Liyang <douly.fnst@cn.fujitsu.com> writes:
> 
>> Hi Baoquan,
>>
>> At 02/12/2018 11:08 AM, Eric W. Biederman wrote:
>>> Baoquan He <bhe@redhat.com> writes:
>>>
>>>> This is a regression fix.
>>>>
>>>> Before, to fix erratum AVR31, commit 522e66464467 ("x86/apic: Disable
>>>> I/O APIC before shutdown of the local APIC") moved lapic_shutdown()
>>>> calling after disable_IO_APIC(). This introdued a regression. The
>>>> root cause is that disable_IO_APIC() not only clears IO_APIC, also
>>>> restore boot irq mode by setting LAPIC/APIC/IMCR, lapic_shutdown()
>>>> after disable_IO_APIC() will disable LAPIC and ruin the possible
>>>> virtual wire mode setting which the code has been trying to do all
>>>> along.
>>>>
>>>> The consequence is, in KVM guest kernel always prints warning as below
>>>> during kexec/kdump kernel boots up. That happened in setup_local_APIC()
>>>> since 'do { xxx } while (queued && max_loops > 0)' loop does not function
>>
>> I am not sure another thing here
>>
>> AFAIK, according to the order of SMP machine shutdown, other CPUs will
>> be stopped firstly, then the last CPU disable its local apic.
>>
>>   --machine_shutdown
>>     |----......
>>     |----stop_other_cpus()
>>     |----local_shutdown()
>>
>> So, the pending interrupts exist only in BSP and only be ACKed by
>> BSP. is it right?(I validated this by print the value of APIC_IRR/ISR of
>> all CPUs, found only BSP had the non-zero value).
> 
> We don't know.  In the kexec on panic case we try and shutdown the other
> cpus but we have a timeout because we might fail.
> 
> Further you have to be careful with the concept of boot cpu.  In the
> normal kexec case shutdown on the boot cpu and leave it running.  In the
> kexec on panic case we shutdown on an arbitrary cpu.
> 
>> If it is right, We will do not need check the pending interrupt for each
>> cpus.
> 
> It is also cheap if there are no pending interrupts as there is nothing
> to do.
> 

Yes, It's cheap.

But, the local APICs in APs were disabled at that time, not sure if
writing to the end-of-interrupt (EOI) register could cause the local
APIC to clear the ISR successfully.

If the ISR was not cleared, doing that check is useless.

I can't produce any cases that the lapics in APs have pending
interrupts. do you have some suggestions?

>> BTW, the pending interrupt check code is mixed with the local
>> APIC setup code, that looks messy. How about extracting the code which
>> related to the crash interrupt check, put it into a new function and
>> only invoked it when the CPU is BSP?
> 
> Moving it into it's own function makes sense.  Let's not taint the
> concept with ``crash''.  We don't know that the only way this will
> ever happen is from kexec on panic.   We only know it was easy to
> trigger the condition from kexec on panic.
> 

Yes, I see.

> There are a lot of cases I can think of that interrupts might fire while
> interrupts are disabled because the kernel is booting.  A normal kexec
> is also possible.
> 
> Throw in MSI interrupts and transitioning from one state to another in
> non-legacy apic mode and we might be more likely to get some irqs in
> a pending state.
> 
> Your patch makes me nervous as it is not just code motion but a much
> more substantial change.
> 
> 
> As much as I agree that we need to fix the regression in the apic
> shutdown code that is causing problems.  What we really need to do
> is to completely remove the apic shutdown code from the kexec on panic
> code path.  Over the long term that will provide us with a much more

Wow, indeed, and it is related to many hypervisors on x86, For me, still
need more investigations and tests.

Thanks,
	dou
