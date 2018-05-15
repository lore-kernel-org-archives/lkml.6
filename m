Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754350AbeEORRn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:17:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36078 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753681AbeEORRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:17:42 -0400
Subject: Re: [PATCH v9 06/11] arm64: kexec_file: allow for loading
 Image-format kernel
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-7-takahiro.akashi@linaro.org>
 <c604b578-6667-3532-eac9-55c428001025@arm.com>
 <20180507072139.GF11326@linaro.org>
 <6f0df3a8-a691-80f1-85de-3e0ead852f12@arm.com>
 <20180515051308.GD2737@linaro.org>
From: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <4a8409dc-27b3-1ddc-0427-0ca55edcb893@arm.com>
Date: Tue, 15 May 2018 18:14:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180515051308.GD2737@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 15/05/18 06:13, AKASHI Takahiro wrote:
> On Fri, May 11, 2018 at 06:07:06PM +0100, James Morse wrote:
>> On 07/05/18 08:21, AKASHI Takahiro wrote:
>>> On Tue, May 01, 2018 at 06:46:11PM +0100, James Morse wrote:
>>>> On 25/04/18 07:26, AKASHI Takahiro wrote:
>>>>> This patch provides kexec_file_ops for "Image"-format kernel. In this
>>>>> implementation, a binary is always loaded with a fixed offset identified
>>>>> in text_offset field of its header.
>>
>>>>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>>>>> index e4de1223715f..3cba4161818a 100644
>>>>> --- a/arch/arm64/include/asm/kexec.h
>>>>> +++ b/arch/arm64/include/asm/kexec.h

>>>> Could we check branch_code is non-zero, and text-offset points within image-size?
>>>
>>> We could do it, but I don't think this check is very useful.
>>>
>>>>
>>>> We could check that this platform supports the page-size/endian config that this
>>>> Image was built with... We get a message from the EFI stub if the page-size
>>>> can't be supported, it would be nice to do the same here (as we can).
>>>
>>> There is no restriction on page-size or endianness for kexec.
>>
>> No, but it won't boot if the hardware doesn't support it. The kernel will spin
>> at a magic address that is, difficult, to debug without JTAG. The bug report
>> will be "it didn't boot".
> 
> OK.
> Added sanity checks for cpu features, endianness as well as page size.
> 
>>
>>> What will be the purpose of this check?
>>
>> These values are in the header so that the bootloader can check them, then print
>> a meaningful error. Here, kexec_file_load() is playing the part of the bootloader.

>> I'm assuming kexec_file_load() can only be used to kexec linux... unlike regular
>> kexec. Is this where I'm going wrong?

Trying to work this out for myself: we can't support any UEFI application as we
can't give it the boot-services environment, so I'm pretty sure
kexec_file_load() must be linux-specific.

Can we state somewhere that we only expect arm64 linux to be booted with
kexec_file_load()? Its not clear from the kconfig text, which refers to kexec,
which explicitly states it can boot other OS. But for kexec_file_load() we're
following the kernel's booting.txt.


>>>>> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
>>>>> new file mode 100644
>>>>> index 000000000000..4dd524ad6611
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/kernel/kexec_image.c
>>>>> @@ -0,0 +1,79 @@
>>>>
>>>>> +static void *image_load(struct kimage *image,
>>>>> +				char *kernel, unsigned long kernel_len,
>>>>> +				char *initrd, unsigned long initrd_len,
>>>>> +				char *cmdline, unsigned long cmdline_len)
>>>>> +{
>>>>> +	struct kexec_buf kbuf;
>>>>> +	struct arm64_image_header *h = (struct arm64_image_header *)kernel;
>>>>> +	unsigned long text_offset;
>>>>> +	int ret;
>>>>> +
>>>>> +	/* Load the kernel */
>>>>> +	kbuf.image = image;
>>>>> +	kbuf.buf_min = 0;
>>>>> +	kbuf.buf_max = ULONG_MAX;
>>>>> +	kbuf.top_down = false;
>>>>> +
>>>>> +	kbuf.buffer = kernel;
>>>>> +	kbuf.bufsz = kernel_len;
>>>>> +	kbuf.memsz = le64_to_cpu(h->image_size);
>>>>> +	text_offset = le64_to_cpu(h->text_offset);
>>>>> +	kbuf.buf_align = SZ_2M;
>>>>
>>>>> +	/* Adjust kernel segment with TEXT_OFFSET */
>>>>> +	kbuf.memsz += text_offset;
>>>>> +
>>>>> +	ret = kexec_add_buffer(&kbuf);
>>>>> +	if (ret)
>>>>> +		goto out;
>>>>> +
>>>>> +	image->arch.kern_segment = image->nr_segments - 1;
>>>>
>>>> You only seem to use kern_segment here, and in load_other_segments() called
>>>> below. Could it not be a local variable passed in? Instead of arch-specific data
>>>> we keep forever?
>>>
>>> No, kern_segment is also used in load_other_segments() in machine_kexec_file.c.
>>> To optimize memory hole allocation logic in locate_mem_hole_callback(),
>>> we need to know the exact range of kernel image (start and end).
>>
>> That's the second user. My badly-made point is one calls the other, but passes
>> the data via some until-kexec lifetime struct. (its not important, just an
>> indicator this worked differently in the past and hasn't been cleaned up).
>> I meant something like [0].
> 
> OK, but instead of adding kern_seg, I want to change the interface to:
> 
> | extern int load_other_segments(struct kimage *image,
> |		unsigned long kernel_load_addr, unsigned long kernel_size,
> |		char *initrd, unsigned long initrd_len,
> |		char *cmdline, unsigned long cmdline_len);
> 
> This way, we will in future be able to address an issue I mentioned in
> my previous e-mail. (If we support vmlinux, the kernel occupies two segments
> for text and data, respectively.)

Aha, its not from old-stuff, its for future-stuff!


James
