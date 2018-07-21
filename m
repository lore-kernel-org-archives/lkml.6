Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DDCECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FCB20863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="OlmHjdIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FCB20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=runbox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeGVAcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 20:32:02 -0400
Received: from aibo.runbox.com ([91.220.196.211]:36910 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbeGVAcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 20:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
        bh=qhHCj96h8JZgQKcMUVDvns6GKQ0zr5/DZlkLIbqzt4s=; b=OlmHjdIqsT6WS/+MdeBjaDKDXR
        UloUdO0L/7b47z8k1VoFwdUemEtq2IEiICME5PLPjLAG3DC8WO5MXJ1LDi7BBKns65B+L5qAIuKHq
        8G10BWA7QbM5LWvpq5uAYzGzgxkA9okTmaKGjPX87cXadE4+CObM9s8MItiSLfC5FpvMk8pOUARmM
        NHbYx+NSTGGBbMiSm3h5ncVWC2Db4ROL4oQ62jA++PtjHMA0/mTgbygPD5SQ544ct41SDp8ldVJi/
        IBEfRpb49itT2VxbgaZBKn1f48x3K79lLzBXdjDRLE5H/TO2387X55BZqN/UTIf640L84PA9L6J/B
        4ooWEckA==;
Received: from [10.9.9.211] (helo=mailfront11.runbox.com)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1fh1R9-0007tc-9s; Sun, 22 Jul 2018 01:37:19 +0200
Received: by mailfront11.runbox.com with esmtpsa  (uid:769847 )  (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        id 1fh1R1-0004SU-1q; Sun, 22 Jul 2018 01:37:11 +0200
Subject: Re: [PATCH 1/2] x86/entry/64: Do not clear %rbx under Xen
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20180721194909.23903-1-m.v.b@runbox.com>
 <CALCETrX435cC7Hi2aTLVrBecZEEeJ3_TgQnTwbObNrt9MKvFzg@mail.gmail.com>
 <b9ad156c-45e9-da80-9cf0-eabbe5a1bbf2@runbox.com>
 <CALCETrXsNxYP7-w-OoiNdJWspTKCsr0i01e6NiwFk1O5jL6grA@mail.gmail.com>
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
Message-ID: <ce0cf39e-102e-8a33-6d46-492cd34e9506@runbox.com>
Date:   Sat, 21 Jul 2018 19:37:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALCETrXsNxYP7-w-OoiNdJWspTKCsr0i01e6NiwFk1O5jL6grA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/2018 07:30 PM, Andy Lutomirski wrote:
> On Sat, Jul 21, 2018 at 4:19 PM, M. Vefa Bicakci <m.v.b@runbox.com> wrote:
>> On 07/21/2018 05:45 PM, Andy Lutomirski wrote:
>>>
>>> On Sat, Jul 21, 2018 at 12:49 PM, M. Vefa Bicakci <m.v.b@runbox.com>
>>> wrote:
>>>>
>>>> Commit 3ac6d8c787b8 ("x86/entry/64: Clear registers for
>>>> exceptions/interrupts, to reduce speculation attack surface")
>>>> unintendedly
>>>> broke Xen PV virtual machines by clearing the %rbx register at the end of
>>>> xen_failsafe_callback before the latter jumps to error_exit.
>>>> error_exit expects the %rbx register to be a flag indicating whether
>>>> there should be a return to kernel mode.
>>>>
>>>> This commit makes sure that the %rbx register is not cleared by
>>>> the PUSH_AND_CLEAR_REGS macro, when the macro in question is instantiated
>>>> by xen_failsafe_callback, to avoid the issue.
>>>
>>>
>>> Seems like a genuine problem, but:
>>>
>>>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>>>> index c7449f377a77..96e8ff34129e 100644
>>>> --- a/arch/x86/entry/entry_64.S
>>>> +++ b/arch/x86/entry/entry_64.S
>>>> @@ -1129,7 +1129,7 @@ ENTRY(xen_failsafe_callback)
>>>>           addq    $0x30, %rsp
>>>>           UNWIND_HINT_IRET_REGS
>>>>           pushq   $-1 /* orig_ax = -1 => not a system call */
>>>> -       PUSH_AND_CLEAR_REGS
>>>> +       PUSH_AND_CLEAR_REGS clear_rbx=0
>>>>           ENCODE_FRAME_POINTER
>>>>           jmp     error_exit
>>>
>>>
>>> The old code first set RBX to zero then, if frame pointers are on,
>>> sets it to some special non-zero value, then crosses its fingers and
>>> hopes for the best.  Your patched code just skips the zeroing part, so
>>> RBX either contains the ENCODE_FRAME_POINTER result or is
>>> uninitialized.
>>>
>>> How about actually initializing rbx to something sensible like, say, 1?
>>
>> Hello Andy,
>>
>> Thank you for the review! Apparently, I have not done my homework fully.
>> I will test your suggestion and report back, most likely in a few hours.
>>
>> I have been testing with the next/linux-next tree's master branch
>> (dated 20180720), and I noticed that ENCODE_FRAME_POINTER changes the
>> frame pointer (i.e., RBP) register, as opposed to the RBX register,
>> which the patch aims to avoid changing before jumping to error_exit.
>> It is possible that I am missing something though -- I am not sure about
>> the connection between the RBP and RBX registers.
> 
> Sorry, brain fart on my part.

No problem! :-)

>> The change introduced by commit 3ac6d8c787b8 is in the excerpt below. Would
>> it
>> be valid to state that the original code had the same issue that you
>> referred
>> to (i.e., leaving the RBX register uninitialized)?
> 
> Presumably.
> 
> I would propose a rather different fix:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/pti&id=bb3d76b50c3bc78b67d79cf90d328f38a435c793
> 
> Any chance you could test that and see if it fixes your problem?

Of course; I will report back with the result in a few hours.
