Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeCCLqf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 06:46:35 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:40686 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeCCLqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 06:46:34 -0500
X-Google-Smtp-Source: AG47ELt4BFtx8fyw5RPDvq4X/QA2s282eCwkYnrDqgTk2KJ4ADwNBPsArSuIqg0iID7Mqx2JJwu+tg==
Subject: Re: "x86/boot/compressed/64: Prepare trampoline memory" breaks boot
 on Zotac CI-321
To: Ingo Molnar <mingo@kernel.org>
Cc: Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>
References: <12357ee3-0276-906a-0e7c-2c3055675af3@gmail.com>
 <CAA42JLZRxCGSsW5FKpH3AjZGbaUyrcRPdVBtMQcc4ZcxKNuDQw@mail.gmail.com>
 <8c6c0f9d-0f47-2fc9-5cb5-6335ef1152cd@gmail.com>
 <20180303100257.hzrqtshcnhzy5spl@gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <f399b62f-984e-c693-81f0-9abe3c49d8f1@gmail.com>
Date: Sat, 3 Mar 2018 12:46:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180303100257.hzrqtshcnhzy5spl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.03.2018 um 11:02 schrieb Ingo Molnar:
> 
> * Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> Am 03.03.2018 um 00:50 schrieb Dexuan-Linux Cui:
>>> On Fri, Mar 2, 2018 at 12:57 PM, Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>> wrote:
>>>
>>>     Recently my Mini PC Zotac CI-321 started to reboot immediately before
>>>     anything was written to the console.
>>>
>>>     Bisecting lead to b91993a87aff "x86/boot/compressed/64: Prepare
>>>     trampoline memory" being the change breaking boot.
>>>
>>>     If you need any more information, please let me know.
>>>
>>>     Rgds, Heiner
>>>
>>>
>>> This may fix the issue: https://lkml.org/lkml/2018/2/13/668
>>>
>>> Kirill posted a v2 patchset 3 days ago and I suppose the patchset should include the fix.
>>>
>> Thanks for the link. I bisected based on the latest next kernel including
>> v2 of the patchset (IOW - the potential fix is included already).
> 
> Are you sure? b91993a87aff is the old patch-set - which I just removed from -next 
> and which should thus be gone in the Monday iteration of -next.
> 
> I have not merged v2 in -tip yet, did it get applied via some other tree?
> 
> Thanks,
> 
> 	Ingo
> 
I wanted to apply the fix mentioned in the link but found that the statement was movq already.
Therefore my (most likely false) understanding that it's v2.
I'll re-test once v2 is out and let you know.

Rgds, Heiner


 diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
 index 70b30f2bc9e0..99a0e7993252 100644
 --- a/arch/x86/boot/compressed/head_64.S
 +++ b/arch/x86/boot/compressed/head_64.S
 @@ -332,7 +332,7 @@ ENTRY(startup_64)
 
  	/* Make sure we have GDT with 32-bit code segment */
  	leaq	gdt(%rip), %rax
 -	movl	%eax, gdt64+2(%rip)
 +	movq	%rax, gdt64+2(%rip)
  	lgdt	gdt64(%rip)
 
  	/*
 -- 
  Kirill A. Shutemov
