Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbeEKRGy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:06:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44902 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbeEKRGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:06:52 -0400
Subject: Re: [PATCH v9 03/11] arm64: kexec_file: invoke the kernel without
 purgatory
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-4-takahiro.akashi@linaro.org>
 <9c830fe8-56d8-b43a-6265-43d31dffe61a@arm.com>
 <20180507052208.GD11326@linaro.org>
From: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <ece8d3cc-127f-6855-52fb-24e4a1d4e823@arm.com>
Date: Fri, 11 May 2018 18:03:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180507052208.GD11326@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 07/05/18 06:22, AKASHI Takahiro wrote:
> On Tue, May 01, 2018 at 06:46:06PM +0100, James Morse wrote:
>> On 25/04/18 07:26, AKASHI Takahiro wrote:
>>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>>> index f76ea92dff91..f7dbba00be10 100644
>>> --- a/arch/arm64/kernel/machine_kexec.c
>>> +++ b/arch/arm64/kernel/machine_kexec.c
>>> @@ -205,10 +205,17 @@ void machine_kexec(struct kimage *kimage)

>>>  	cpu_soft_restart(kimage != kexec_crash_image,
>>> -		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
>>> +		reboot_code_buffer_phys, kimage->head, kimage->start,
>>> +#ifdef CONFIG_KEXEC_FILE
>>> +				kimage->purgatory_info.purgatory_buf ?
>>> +						0 : kimage->arch.dtb_mem);
>>> +#else
>>> +				0);
>>> +#endif


>> purgatory_buf seems to only be set in kexec_purgatory_setup_kbuf(), called from
>> kexec_load_purgatory(), which we don't use. How does this get a value?
>>
>> Would it be better to always use kimage->arch.dtb_mem, and ensure that is 0 for
>> regular kexec (as we can't know where the dtb is)? (image_arg may then be a
>> better name).
> 
> The problem is arch.dtb_mem is currently defined only if CONFIG_KEXEC_FILE.

I thought it was ARCH_HAS_KIMAGE_ARCH, which we can define all the time if
that's what we want.


> So I would like to
> - merge this patch with patch#8
> - change the condition
>         #ifdef CONFIG_KEXEC_FILE
>        				kimage->file_mode ? kimage->arch.dtb_mem : 0);
>         #else
>         			0);
>         #endif

If we can avoid even this #ifdef by always having kimage->arch, I'd prefer that.
If we do that 'dtb_mem' would need some thing that indicates its for kexec_file,
as kexec has a DTB too, we just don't know where it is...


Thanks,

James
