Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98808C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8CF20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8CF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeJOU6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:58:21 -0400
Received: from thoth.sbs.de ([192.35.17.2]:54502 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeJOU6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:58:21 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w9FD8u2W002851
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 15:08:56 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w9FD8sQU007922;
        Mon, 15 Oct 2018 15:08:54 +0200
Subject: Re: [PATCH] x86/entry/32: Fix setup of CS high bits
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
 <1531906876-13451-11-git-send-email-joro@8bytes.org>
 <97421241-2bc4-c3f1-4128-95b3e8a230d1@siemens.com>
 <35a24feb-5970-aa03-acbf-53428a159ace@web.de>
 <CALCETrWveao7jthnfKr5F=UyEpyowP0VA20eZi5OxizgT05EDA@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <406a08c7-6199-a32d-d385-c032fb4c34d6@siemens.com>
Date:   Mon, 15 Oct 2018 15:08:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CALCETrWveao7jthnfKr5F=UyEpyowP0VA20eZi5OxizgT05EDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.18 17:12, Andy Lutomirski wrote:
> On Sat, Oct 13, 2018 at 3:02 AM Jan Kiszka <jan.kiszka@web.de> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Even if we are not on an entry stack, we have to initialize the CS high
>> bits because we are unconditionally evaluating them
>> PARANOID_EXIT_TO_KERNEL_MODE. Failing to do so broke the boot on Galileo
>> Gen2 and IOT2000 boards.
>>
>> Fixes: b92a165df17e ("x86/entry/32: Handle Entry from Kernel-Mode on Entry-Stack")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   arch/x86/entry/entry_32.S | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
>> index 2767c625a52c..95c94d48ecd2 100644
>> --- a/arch/x86/entry/entry_32.S
>> +++ b/arch/x86/entry/entry_32.S
>> @@ -389,6 +389,12 @@
>>           * that register for the time this macro runs
>>           */
>>
>> +       /*
>> +        * Clear unused upper bits of the dword containing the word-sized CS
>> +        * slot in pt_regs in case hardware didn't clear it for us.
>> +        */
>> +       andl    $(0x0000ffff), PT_CS(%esp)
>> +
> 
> Please improve the comment. Since commit:
> 
> commit 385eca8f277c4c34f361a4c3a088fd876d29ae21
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Fri Jul 28 06:00:30 2017 -0700
> 
>      x86/asm/32: Make pt_regs's segment registers be 16 bits
> 
> Those fields are genuinely 16 bit.  So the comment should say
> something like "Those high bits are used for CS_FROM_ENTRY_STACK and
> CS_FROM_USER_CR3".

/*
  * The high bits of the CS dword (__csh) are used for
  * CS_FROM_ENTRY_STACK and CS_FROM_USER_CR3. Clear them in case
  * hardware didn't do this for us.
  */

OK? I will send out v2 with this wording soon.

> 
> Also, can you fold something like this in:
> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 2767c625a52c..358eed8cf62a 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -171,7 +171,7 @@
>          ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
>          .if \no_user_check == 0
>          /* coming from usermode? */
> -       testl   $SEGMENT_RPL_MASK, PT_CS(%esp)
> +       testb   $SEGMENT_RPL_MASK, PT_CS(%esp)
>          jz      .Lend_\@
>          .endif
>          /* On user-cr3? */
> 

Makes sense, but this looks like a separate patch to me.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
