Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524B0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1319020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1319020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388918AbeGWSGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:06:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388357AbeGWSGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:06:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90A0B18A;
        Mon, 23 Jul 2018 10:04:04 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30D263F5D0;
        Mon, 23 Jul 2018 10:04:02 -0700 (PDT)
Subject: Re: [PATCH v11 11/15] arm64: kexec_file: add crash dump support
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-12-takahiro.akashi@linaro.org>
 <9efd0567-35dc-7435-74d6-1b540f3e5b9f@arm.com>
 <20180723053923.GN11258@linaro.org>
From:   James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <8600c940-158a-f64f-8271-32f8fb40f198@arm.com>
Date:   Mon, 23 Jul 2018 18:04:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723053923.GN11258@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 23/07/18 06:39, AKASHI Takahiro wrote:
> On Wed, Jul 18, 2018 at 05:50:22PM +0100, James Morse wrote:
>> On 11/07/18 08:41, AKASHI Takahiro wrote:
>>> Enabling crash dump (kdump) includes
>>> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>>>   using crash_prepare_elf64_headers(), and
>>> * add two device tree properties, "linux,usable-memory-range" and
>>>   "linux,elfcorehdr", which represent respectively a memory range
>>>   to be used by crash dump kernel and the header's location
>>
>>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>>> index 69333694e3e2..eeb5766928b0 100644
>>> --- a/arch/arm64/include/asm/kexec.h
>>> +++ b/arch/arm64/include/asm/kexec.h
>>> @@ -99,6 +99,10 @@ static inline void crash_post_resume(void) {}
>>>  struct kimage_arch {
>>>  	phys_addr_t dtb_mem;
>>>  	void *dtb_buf;
>>> +	/* Core ELF header buffer */
>>
>>> +	void *elf_headers;
>>
>> Shouldn't this be a phys_addr_t if it comes from kbuf.mem?
> 
> Do you mean elf_load_addr? You're right.
> But kexec_buf defined mem as unsigned long and so I'd rather change
> dtb_mem to unsigned long instead of elf_load_addr, which will also be
> renamed to elf_headers_mem for clarification.

>> (dtb_mem is, and they type tells us which way round the runtime/kexec-time
>> pointers are)

My preference would be for physical addresses to always be phys_addr_t, but as
long as we can easily spot the difference kexec-time versus runtime addresses,
it will save bugs where we use the wrong one.


>>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>>> index a0b44fe18b95..261564df7210 100644
>>> --- a/arch/arm64/kernel/machine_kexec_file.c
>>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>>> @@ -132,6 +173,45 @@ static int setup_dtb(struct kimage *image,

>>> +		kbuf.buf_min = crashk_res.start;
>>> +		kbuf.buf_max = crashk_res.end + 1;
>>> +		kbuf.top_down = true;
>>> +
>>> +		ret = kexec_add_buffer(&kbuf);
>>> +		if (ret) {
>>> +			vfree(hdrs_addr);
>>> +			goto out_err;
>>> +		}
>>> +		image->arch.elf_headers = hdrs_addr;
>>> +		image->arch.elf_headers_sz = hdrs_sz;
>>> +		image->arch.elf_load_addr = kbuf.mem;
>>> +
>>> +		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>>> +				 image->arch.elf_load_addr, hdrs_sz, hdrs_sz);
>>> +	}
>>> +
>>>  	kbuf.image = image;
>>>  	/* not allocate anything below the kernel */
>>>  	kbuf.buf_min = kernel_load_addr + kernel_size;

>> I think the initramfs can escape the crash kernel range because you add to the
>> buf_max region:
>> |	/* within 1GB-aligned window of up to 32GB in size */
>> |	kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
>> |				 + (unsigned long)SZ_1G * 32;
> 
> No worries.
> kexec_add_buffer() will limit the search only within crashk_res anyway.

via arch_kexec_walk_mem()? Got it.

But strangely the buf_min and buf_max still matter because
locate_mem_hole_callback() uses them.


> Are you reviewing other patches in my v11?
> If not, I will post v12 tomorrow.

No, (I try to batch replies to avoid that happening).
I'm reading up on Secure-boot and trying to test the pe_verification stuff...


Thanks,

James
