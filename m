Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E95C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3122089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3122089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbeGJPZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:25:12 -0400
Received: from foss.arm.com ([217.140.101.70]:48830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754085AbeGJPZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:25:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2828680D;
        Tue, 10 Jul 2018 08:25:10 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 701FE3F589;
        Tue, 10 Jul 2018 08:25:07 -0700 (PDT)
Subject: Re: [PATCH v10 08/14] arm64: kexec_file: load initrd and device-tree
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-9-takahiro.akashi@linaro.org>
 <1e401f4e-6176-990d-476c-31ae3f28f26c@arm.com>
 <20180710073719.GW28220@linaro.org>
From:   James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <27eda5b7-f9ad-2918-c302-3669d4b72fd0@arm.com>
Date:   Tue, 10 Jul 2018 16:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710073719.GW28220@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 10/07/18 08:37, AKASHI Takahiro wrote:
> On Tue, Jul 03, 2018 at 05:32:09PM +0100, James Morse wrote:
>> On 23/06/18 03:20, AKASHI Takahiro wrote:
>>> load_other_segments() is expected to allocate and place all the necessary
>>> memory segments other than kernel, including initrd and device-tree
>>> blob (and elf core header for crash).
>>> While most of the code was borrowed from kexec-tools' counterpart,
>>> users may not be allowed to specify dtb explicitly, instead, the dtb
>>> presented by the original boot loader is reused.
>>>
>>> arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
>>> specific data allocated in load_other_segments().

>>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>>> index c38a8048ed00..7115c4f915dc 100644
>>> --- a/arch/arm64/kernel/machine_kexec_file.c
>>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>>
>>> +static int setup_dtb(struct kimage *image,
>>> +		unsigned long initrd_load_addr, unsigned long initrd_len,
>>> +		char *cmdline, unsigned long cmdline_len,
>>> +		char **dtb_buf, size_t *dtb_buf_len)
>>> +{

[..]

>>> +	/* add bootargs */
>>> +	if (cmdline) {
>>> +		ret = fdt_setprop(buf, nodeoffset, "bootargs",
>>> +						cmdline, cmdline_len + 1);
>>> +		if (ret)
>>> +			goto out_err;
>>> +	}
>>
>> So (cmdline_len == 0) from user-space means keep the old cmdline. Sounds
>> sensible. Is this documented anywhere?

> To be a bit surprise, --append (and --cmdline) option belongs to arch-
> specific options in terms of implementation. Apparently, a standard man page
> of kexec(8) say little about it, in particular, for device-tree-based system.
> 
> As far as arm64 is concerned, the fact is a bit complicated.
> User space kexec accepts --append as well as --reuse-cmdline, and
> along with yet another --dtb option, a resulting command line for new
> kernel (or bootargs in new dtb) would look to be:
> 
> 	--append=A | --reuse-cmdline |     --dtb
> 		   |                 |   n    |    y(bootargs=B)
> 
> 	    n            n               S(*1)      B(*2)
> 	    n            y               S          S(*3)
> 	    y            n               A          A
> 	    y            y              S+A        S+A(*4)
> 
>       where S: the cmdline parameters of the running system
> 		 (equal to bootargs in system's dtb)

(I'm afraid I don't understand this table, but the text below helps...)


> You are talking about case(1) above.
> 
> Given that we can have an explicit option, --reuse-cmdline, the cmdline
> in (1) should be NULL. Meanwhile, we specify --dtb here, which means
> that we want to re-use system's dtb, implying that we also want to
> reuse a cmdline parameter. (This can be arguable, though)

Sounds like this is all user-space's problem!


> So I would say that we have both reasons to go for and go against.
> 
> # Likewise,
> # I wonder why the cmdnline would not be B or A+B, respectively,
> in case of (3) and (4). But it's a different issue.
> 
>> powerpc does the opposite, it deletes the bootargs in this case. Are we happy
>> making his a per-arch thing?
> 
> My compromise solution is:
> a.to maintain compatibility with powerpc at system call level, 

This sounds like the right thing to do.


>   that is,
>   replacing bootargs in new dtb if user explicitly specifies cmdline
>   argument, otherwise nullifying bootargs,
> b.yet maintain compatibility with arm64's kexec behavior at command line
>   interface level. If neither --append nor --dtb is not specified,
>   user space kexec will reuse the system's command line whether or not
>   --reuse-cmdline is used.

(a and b aren't options this time: you're proposing to do a-and-b)


> (Do you follow me?)

I think so:
The syscall will behave the same as powerpc meaning the kernel will never re-use
the existing cmdline in the dtb, even if that means (trying to) boot without one.

If user-space wants to re-use the command line, it should read /proc/cmdline and
feed the string back into the kernel.


> So kexec and kexec_file on arm64 will still behave in exactly the same way,
> but differently from ppc at command level for now.

> The point is that, if we might want or need to change this behavior
> (at any time in the future), we would only have to modify user space kexec.
> Kernel semantics will never break.
> 
> (b) requires additional small modification on kexec-tools, but kexec_file
> support is yet to be upstreamed anyway.

Makes sense!


Thanks,

James
