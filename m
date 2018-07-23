Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CF8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D5A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D5A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbeGWSH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:07:59 -0400
Received: from foss.arm.com ([217.140.101.70]:36982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388200AbeGWSH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:07:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5147218A;
        Mon, 23 Jul 2018 10:05:50 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BFE43F5D0;
        Mon, 23 Jul 2018 10:05:48 -0700 (PDT)
Subject: Re: [PATCH] arm64, kaslr: export offset in VMCOREINFO ELF notes
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-mips@linux-mips.org
References: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
 <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com>
 <CACi5LpOa-BMRSTShS019DDv7MoxNfpnnsqjwR3z13GZC49NrSA@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <9c4d7c8d-3f0b-ff2f-68e8-03638a5fe2a4@arm.com>
Date:   Mon, 23 Jul 2018 18:05:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACi5LpOa-BMRSTShS019DDv7MoxNfpnnsqjwR3z13GZC49NrSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

(CC: +mips list, looks like mips is missing vmcore's KERNELOFFSET too.
Start of this thread: https://lkml.org/lkml/2018/7/18/951 )

On 19/07/18 15:55, Bhupesh Sharma wrote:
> On Thu, Jul 19, 2018 at 5:01 PM, James Morse <james.morse@arm.com> wrote:
>> On 18/07/18 22:37, Bhupesh Sharma wrote:
>>> Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.
>>>
>>> makedumpfile user-space utility will need fixup to use this KASLR offset
>>> to work with cases where we need to find a way to translate symbol
>>> address from vmlinux to kernel run time address in case of KASLR boot on
>>> arm64.
>>
>> You need the kernel VA for a symbol. Isn't this what kallsyms is for?
>> | root@frikadeller:~# cat /proc/kallsyms | grep swapper_pg_dir
>> | ffff5404610d0000 B swapper_pg_dir

> Its already used by other archs like x86_64.
> Its just that we are enabling this feature for arm64 now that the
> KASLR boot cases are more widely seen on arm64 boards (as newer EFI
> firmware implementations are available which support EFI_RNG_PROTOCOL
> and hence KASLR boot).
> 
> And we want existing user-space application(s) to work similarly on
> arm64 distributions as they work historically on other archs like
> x86_64 (in most cases the user-space user is not even aware, if he is
> developing for or using an underlying hardware which is arm64 or
> x86_64)

Aha, so its ABI. This is the information that should be in the commit message as
it describes why this patch should be merged.

... Ideally core code would do this, that way this information won't be missed
when an architecture adds KASLR support.

But mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
and x86 always provides this value, not just if CONFIG_RANDOMIZE_BASE is
selected. I can't see a way to do this without touching all three architectures.
(we can try and tidy it up once its clear whether mips needs this too)


I think the patch is fine, but could you re-post it with a commit message that
describes that vmcore parsing in user-space already expects this value in the
notes. We're providing it for portability of those existing tools with x86.


>> I picked swapper_pg_dir, but you could use any of the vmcore:SYMBOL() addresses
>> to work out this offset. (you should expect the kernel to rename these symbols
>> at a whim).
>>
> 
> Perhaps you missed what the above makedumpfile command was doing, so
> let me summarize again:

Yes, I glossed over it, all that seemed relevant is you are trying to find the
kernel-va of a symbol from the value in the vmlinux.


> as it breaks the
> existing user-space use-cases and the .conf file can be user-defined
> (and hence he can pick any symbol/functions

My suggestion was you can calculate the offset between the link-time and
run-time address from information you already have. You just need one of each.
This would be better as its independent of how the kernel does the relocation.

But, this is irrelevant as 'KERNELOFFSET=' is already an ABI string.


> which might not even be present in 'kallsyms').

Eh? How can that happen? I thought even modules had their symbols added to kallsyms.



Thanks,

James
