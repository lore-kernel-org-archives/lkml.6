Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbeEOQTB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:19:01 -0400
Received: from foss.arm.com ([217.140.101.70]:35086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeEOQTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:19:00 -0400
Subject: Re: [PATCH v9 03/11] arm64: kexec_file: invoke the kernel without
 purgatory
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-4-takahiro.akashi@linaro.org>
 <9c830fe8-56d8-b43a-6265-43d31dffe61a@arm.com>
 <20180507052208.GD11326@linaro.org>
 <ece8d3cc-127f-6855-52fb-24e4a1d4e823@arm.com>
 <20180515044542.GC2737@linaro.org>
From: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <fbd2c6c6-be20-a9fa-0303-e4448225df18@arm.com>
Date: Tue, 15 May 2018 17:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180515044542.GC2737@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 15/05/18 05:45, AKASHI Takahiro wrote:
> On Fri, May 11, 2018 at 06:03:49PM +0100, James Morse wrote:
>> On 07/05/18 06:22, AKASHI Takahiro wrote:
>>> On Tue, May 01, 2018 at 06:46:06PM +0100, James Morse wrote:
>>>> On 25/04/18 07:26, AKASHI Takahiro wrote:
>>>>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>>>>> index f76ea92dff91..f7dbba00be10 100644
>>>>> --- a/arch/arm64/kernel/machine_kexec.c
>>>>> +++ b/arch/arm64/kernel/machine_kexec.c
>>>>> @@ -205,10 +205,17 @@ void machine_kexec(struct kimage *kimage)
>>
>>>>>  	cpu_soft_restart(kimage != kexec_crash_image,
>>>>> -		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
>>>>> +		reboot_code_buffer_phys, kimage->head, kimage->start,
>>>>> +#ifdef CONFIG_KEXEC_FILE
>>>>> +				kimage->purgatory_info.purgatory_buf ?
>>>>> +						0 : kimage->arch.dtb_mem);
>>>>> +#else
>>>>> +				0);
>>>>> +#endif
>>
>>
>>>> purgatory_buf seems to only be set in kexec_purgatory_setup_kbuf(), called from
>>>> kexec_load_purgatory(), which we don't use. How does this get a value?
>>>>
>>>> Would it be better to always use kimage->arch.dtb_mem, and ensure that is 0 for
>>>> regular kexec (as we can't know where the dtb is)? (image_arg may then be a
>>>> better name).
>>>
>>> The problem is arch.dtb_mem is currently defined only if CONFIG_KEXEC_FILE.
>>
>> I thought it was ARCH_HAS_KIMAGE_ARCH, which we can define all the time if
>> that's what we want.
>>
>>
>>> So I would like to
>>> - merge this patch with patch#8
>>> - change the condition
>>>         #ifdef CONFIG_KEXEC_FILE
>>>        				kimage->file_mode ? kimage->arch.dtb_mem : 0);
>>>         #else
>>>         			0);
>>>         #endif
>>
>> If we can avoid even this #ifdef by always having kimage->arch, I'd prefer that.
>> If we do that 'dtb_mem' would need some thing that indicates its for kexec_file,
>> as kexec has a DTB too, we just don't know where it is...
> 
> OK, but I want to have a minimum of kexec.arch always exist.

I'm curious, why? Its 32bytes that is allocated a maximum of twice.

(my questions on what needs to go in there were because it looked like a third
user was missing...)


> How about this?
>
> | struct kimage_arch {
> | 	phys_addr_t dtb_mem;
> | #ifdef CONFIG_KEXEC_FILE

#ifdef in structs just breeds more #ifdefs, as the code that accesses those
members has to be behind the same set of conditions.

Given this, I prefer the #ifdefs around cpu_soft_restart() as it doesn't force
us to add more #ifdefs later.

For either option without purgatory_info:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
