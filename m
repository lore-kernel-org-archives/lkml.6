Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5559AECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DC92086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhL616ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DC92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbeGVSyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730122AbeGVSyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:54:22 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0428320893
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532282214;
        bh=JqqWVY2NOKDjeW+YktpM51WOLWKanwYfG4+S4fxooI8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=HhL616magqNDJSCTMW3O1WP/1JfOMnjQ4Xa5Z6wiAHLDqPY5kqWYQWhjVJyYR7xQ2
         hRusdQC4Yw7h2BTNO/lu/tyvu/DMOBGE4F98MrjMeqJHpHo6SolnVIpuSXAmp3aOiH
         5zP9T1bUElFl+oZzGmH8A92cg6LLGn3i6XbyCM1Q=
Received: by mail-wr1-f53.google.com with SMTP id j5-v6so15684137wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 10:56:53 -0700 (PDT)
X-Gm-Message-State: AOUpUlFVZFN+hUtijAJB/fS/nHCM82qZ4oY22rCPNvLsQNKW83l0WwXH
        grTDvvQeVaUSu549uSyvytAxIU+oIgwc3Io6gO5+yg==
X-Google-Smtp-Source: AAOMgpdAzKn2Bxz6vUqmNyqdxAsr4vB6HIL7gTkXfLUD1FFcBvYH0PzIOJPwhTpNOPp4hBMpkB+6o7I8bS8xx+SJVrE=
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr6248648wrs.171.1532282212367;
 Sun, 22 Jul 2018 10:56:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 10:56:31
 -0700 (PDT)
In-Reply-To: <74f29b48-7522-c4f4-c2e7-d8e41fd88873@runbox.com>
References: <20180721194909.23903-1-m.v.b@runbox.com> <CALCETrX435cC7Hi2aTLVrBecZEEeJ3_TgQnTwbObNrt9MKvFzg@mail.gmail.com>
 <b9ad156c-45e9-da80-9cf0-eabbe5a1bbf2@runbox.com> <CALCETrXsNxYP7-w-OoiNdJWspTKCsr0i01e6NiwFk1O5jL6grA@mail.gmail.com>
 <ce0cf39e-102e-8a33-6d46-492cd34e9506@runbox.com> <74f29b48-7522-c4f4-c2e7-d8e41fd88873@runbox.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 22 Jul 2018 10:56:31 -0700
X-Gmail-Original-Message-ID: <CALCETrWbbLRM_0YTFaUx5V1FobwB6izD5ed9Xmf=wpdA0Lx2Tw@mail.gmail.com>
Message-ID: <CALCETrWbbLRM_0YTFaUx5V1FobwB6izD5ed9Xmf=wpdA0Lx2Tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/entry/64: Do not clear %rbx under Xen
To:     "M. Vefa Bicakci" <m.v.b@runbox.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 6:20 PM, M. Vefa Bicakci <m.v.b@runbox.com> wrote:
> On 07/21/2018 07:37 PM, M. Vefa Bicakci wrote:
>>
>> On 07/21/2018 07:30 PM, Andy Lutomirski wrote:
>>>
>>> On Sat, Jul 21, 2018 at 4:19 PM, M. Vefa Bicakci <m.v.b@runbox.com>
>>> wrote:
>>>>
>>>> On 07/21/2018 05:45 PM, Andy Lutomirski wrote:
>>>>>
>>>>>
>>>>> On Sat, Jul 21, 2018 at 12:49 PM, M. Vefa Bicakci <m.v.b@runbox.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> Commit 3ac6d8c787b8 ("x86/entry/64: Clear registers for
>>>>>> exceptions/interrupts, to reduce speculation attack surface")
>>>>>> unintendedly
>>>>>> broke Xen PV virtual machines by clearing the %rbx register at the end
>>>>>> of
>>>>>> xen_failsafe_callback before the latter jumps to error_exit.
>>>>>> error_exit expects the %rbx register to be a flag indicating whether
>>>>>> there should be a return to kernel mode.
>>>>>>
>>>>>> This commit makes sure that the %rbx register is not cleared by
>>>>>> the PUSH_AND_CLEAR_REGS macro, when the macro in question is
>>>>>> instantiated
>>>>>> by xen_failsafe_callback, to avoid the issue.
>>>>>
>>>>>
>>>>>
>>>>> Seems like a genuine problem, but:
>>>>>
>>>>>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>>>>>> index c7449f377a77..96e8ff34129e 100644
>>>>>> --- a/arch/x86/entry/entry_64.S
>>>>>> +++ b/arch/x86/entry/entry_64.S
>>>>>> @@ -1129,7 +1129,7 @@ ENTRY(xen_failsafe_callback)
>>>>>>           addq    $0x30, %rsp
>>>>>>           UNWIND_HINT_IRET_REGS
>>>>>>           pushq   $-1 /* orig_ax = -1 => not a system call */
>>>>>> -       PUSH_AND_CLEAR_REGS
>>>>>> +       PUSH_AND_CLEAR_REGS clear_rbx=0
>>>>>>           ENCODE_FRAME_POINTER
>>>>>>           jmp     error_exit
>>>>>
>>>>>
>>>>>
>>>>> The old code first set RBX to zero then, if frame pointers are on,
>>>>> sets it to some special non-zero value, then crosses its fingers and
>>>>> hopes for the best.  Your patched code just skips the zeroing part, so
>>>>> RBX either contains the ENCODE_FRAME_POINTER result or is
>>>>> uninitialized.
>>>>>
>>>>> How about actually initializing rbx to something sensible like, say, 1?
>>>>
>>>>
>>>> Hello Andy,
>>>>
>>>> Thank you for the review! Apparently, I have not done my homework fully.
>>>> I will test your suggestion and report back, most likely in a few hours.
>>>>
>>>> I have been testing with the next/linux-next tree's master branch
>>>> (dated 20180720), and I noticed that ENCODE_FRAME_POINTER changes the
>>>> frame pointer (i.e., RBP) register, as opposed to the RBX register,
>>>> which the patch aims to avoid changing before jumping to error_exit.
>>>> It is possible that I am missing something though -- I am not sure about
>>>> the connection between the RBP and RBX registers.
>>>
>>>
>>> Sorry, brain fart on my part.
>>
>>
>> No problem! :-)
>>
>>>> The change introduced by commit 3ac6d8c787b8 is in the excerpt below.
>>>> Would
>>>> it
>>>> be valid to state that the original code had the same issue that you
>>>> referred
>>>> to (i.e., leaving the RBX register uninitialized)?
>>>
>>>
>>> Presumably.
>>>
>>> I would propose a rather different fix:
>>>
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/pti&id=bb3d76b50c3bc78b67d79cf90d328f38a435c793
>>>
>>> Any chance you could test that and see if it fixes your problem?
>>
>>
>> Of course; I will report back with the result in a few hours.
>
>
> Hello Andy,
>
> I confirm that the commit at [1] resolves the issue in question as well.
>
> To test, I first reverted my commit, applied your commit and verified that
> the bug cannot be reproduced. Afterwards, I reverted your commit and
> verified that the bug is reproducible.
>
> I am not sure about the best way to document the bug I encountered in your
> commit message, but in case you plan to have your commit merged, please
> feel free to add a "Reported-and-tested-by: M. Vefa Bicakci
> <m.v.b@runbox.com>"
> tag to the commit message, possibly with a link to this e-mail thread.
>
> Finally, as I had mentioned in my commit message, this bug exists in all
> kernel versions 4.14 and greater, so it would be nice if you could
> carbon-copy
> "stable@vger.kernel.org" in the commit message as well.
>
> Thank you,

I'm curious why the sigreturn_64 selftest didn't catch this bug.  Do
you happen to know why?  The xen_failsafe_callback mechanism is a bit
mysterious to me.

>
> Vefa
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/pti&id=bb3d76b50c3bc78b67d79cf90d328f38a435c793
>
