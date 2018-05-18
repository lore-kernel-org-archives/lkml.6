Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeERQCZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:02:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55366 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752503AbeERQCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:02:20 -0400
Subject: Re: [PATCH v9 05/11] arm64: kexec_file: load initrd and device-tree
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-6-takahiro.akashi@linaro.org>
 <c10624c0-9962-af38-1dd5-656902180ace@arm.com>
 <20180518071133.GL2737@linaro.org> <20180518074203.GM2737@linaro.org>
From: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <59963e4b-968f-7251-4000-5a545dd44628@arm.com>
Date: Fri, 18 May 2018 16:59:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180518074203.GM2737@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 18/05/18 08:42, AKASHI Takahiro wrote:
> On Fri, May 18, 2018 at 04:11:35PM +0900, AKASHI Takahiro wrote:
>> On Tue, May 15, 2018 at 05:20:00PM +0100, James Morse wrote:
>>> On 25/04/18 07:26, AKASHI Takahiro wrote:
>>>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>>>> index f9ebf54ca247..b3b9b1725d8a 100644
>>>> --- a/arch/arm64/kernel/machine_kexec_file.c
>>>> +++ b/arch/arm64/kernel/machine_kexec_file.c

>>>> @@ -55,3 +74,144 @@ int arch_kexec_walk_mem(struct kexec_buf *kbuf,

>>>> +	buf = vmalloc(buf_size);
>>>> +	if (!buf) {
>>>> +		ret = -ENOMEM;
>>>> +		goto out_err;
>>>> +	}
>>>> +
>>>> +	ret = fdt_open_into(initial_boot_params, buf, buf_size);
>>>> +	if (ret)
>>>> +		goto out_err;
>>>> +
>>>> +	nodeoffset = fdt_path_offset(buf, "/chosen");
>>>> +	if (nodeoffset < 0)
>>>> +		goto out_err;
>>>> +
>>>> +	/* add bootargs */
>>>> +	if (cmdline) {
>>>> +		ret = fdt_setprop(buf, nodeoffset, "bootargs",
>>>> +						cmdline, cmdline_len + 1);
>>>
>>> fdt_setprop_string()?
>>
>> OK
> 
> cmdline_len is passed by system call, kexec_file_load(), and this means
> that we can't believe that cmdline is always terminated with '\0'.

Yuck, we expect user-space to tell us how long the string is. It may be worth a
comment that it isn't necessarily null-terminated, as that is surprising!

(I assume the DT's property length is enough to make that safe for the new
kernel to read).


>>>> +		/* within 1GB-aligned window of up to 32GB in size */
>>>> +		kbuf.buf_max = round_down(kern_seg->mem, SZ_1G)
>>>> +						+ (unsigned long)SZ_1G * 32;
>>>> +		kbuf.top_down = false;
>>>> +
>>>> +		ret = kexec_add_buffer(&kbuf);
>>>> +		if (ret)
>>>> +			goto out_err;
>>>> +		initrd_load_addr = kbuf.mem;
>>>> +
>>>> +		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>>>> +				initrd_load_addr, initrd_len, initrd_len);
>>>> +	}
>>>> +
>>>> +	/* load dtb blob */
>>>> +	ret = setup_dtb(image, initrd_load_addr, initrd_len,
>>>> +				cmdline, cmdline_len, &dtb, &dtb_len);
>>>> +	if (ret) {
>>>> +		pr_err("Preparing for new dtb failed\n");
>>>> +		goto out_err;
>>>> +	}
>>>> +
>>>> +	kbuf.buffer = dtb;
>>>> +	kbuf.bufsz = dtb_len;
>>>> +	kbuf.memsz = dtb_len;
>>>> +	/* not across 2MB boundary */
>>>> +	kbuf.buf_align = SZ_2M;
>>>> +	kbuf.buf_max = ULONG_MAX;
>>>> +	kbuf.top_down = true;
>>>> +
>>>> +	ret = kexec_add_buffer(&kbuf);
>>>> +	if (ret)
>>>> +		goto out_err;
>>>> +	image->arch.dtb_mem = kbuf.mem;
>>>> +	image->arch.dtb_buf = dtb;
>>>> +
>>>> +	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>>>> +			kbuf.mem, dtb_len, dtb_len);
>>>> +
>>>> +	return 0;
>>>> +
>>>> +out_err:
>>>> +	vfree(dtb);
>>>> +	image->arch.dtb_buf = NULL;
>>>
>>> Won't kimage_file_post_load_cleanup() always be called if we return an error
>>> here? Why not leave the free()ing until then?
>>
>> Right.
>> The reason why I left the code here was that we'd better locally clean up
>> all the stuff that were locally allocated if we trivially need to (and can)
>> do so.
>>
>> As it's redundant, I will remove it.
> 
> will remove only "image->arch.dtb_buf = NULL."

Ah, because you haven't set the arch.dtb_buf pointer yet.

What about in patch 7 where you expect kimage_file_prepare_segments() to call
arch_kimage_file_post_load_cleanup() to free the arch.elf_headers? I'd expect
the free()ing to always happen in one place.


Thanks,

James
