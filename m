Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4FECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FDD20868
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO7ph1xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FDD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeGVAY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 20:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbeGVAY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 20:24:56 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB7320864
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 23:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532215826;
        bh=UDIoa9BbRnm2jxNS5PdV2KqOPMM1XVQ8Z1dAbLN7G+w=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=oO7ph1xdeimLdNBKmSJ6atWDg4qfd3Rts7UCRtHYXrBgZ9/mn8FRV+JxsL0tezIFp
         aGLQzd9owKxrLMa8/dVNKau6T60dx9Sm6d6ZSd+XAenMbKQMtkl1X8N/fIoukld34+
         /jJbTuZ/PoIpGtS/IYHi7oSATP6g3Vm9GODDxLHY=
Received: by mail-wr1-f47.google.com with SMTP id e7-v6so14412755wrs.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 16:30:26 -0700 (PDT)
X-Gm-Message-State: AOUpUlERKKUEUIaCtS0TGJFXJJ/1N9fD2RMQbdqvxk/i0ELLb+NePGeN
        x9YLPHnzhcX2ghKTiJ2cUnC05DxU+NjdsA9mD2ORRA==
X-Google-Smtp-Source: AAOMgpf1rOygB7BPzoYkNKSSCEem8m4XBi7QQG5fPBo44PmfW79Eo4gaW+VI1tKz4HPWznsRoSldseyTwf8L+sm1fEc=
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr4888278wra.120.1532215824794;
 Sat, 21 Jul 2018 16:30:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 16:30:04
 -0700 (PDT)
In-Reply-To: <b9ad156c-45e9-da80-9cf0-eabbe5a1bbf2@runbox.com>
References: <20180721194909.23903-1-m.v.b@runbox.com> <CALCETrX435cC7Hi2aTLVrBecZEEeJ3_TgQnTwbObNrt9MKvFzg@mail.gmail.com>
 <b9ad156c-45e9-da80-9cf0-eabbe5a1bbf2@runbox.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 21 Jul 2018 16:30:04 -0700
X-Gmail-Original-Message-ID: <CALCETrXsNxYP7-w-OoiNdJWspTKCsr0i01e6NiwFk1O5jL6grA@mail.gmail.com>
Message-ID: <CALCETrXsNxYP7-w-OoiNdJWspTKCsr0i01e6NiwFk1O5jL6grA@mail.gmail.com>
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

On Sat, Jul 21, 2018 at 4:19 PM, M. Vefa Bicakci <m.v.b@runbox.com> wrote:
> On 07/21/2018 05:45 PM, Andy Lutomirski wrote:
>>
>> On Sat, Jul 21, 2018 at 12:49 PM, M. Vefa Bicakci <m.v.b@runbox.com>
>> wrote:
>>>
>>> Commit 3ac6d8c787b8 ("x86/entry/64: Clear registers for
>>> exceptions/interrupts, to reduce speculation attack surface")
>>> unintendedly
>>> broke Xen PV virtual machines by clearing the %rbx register at the end of
>>> xen_failsafe_callback before the latter jumps to error_exit.
>>> error_exit expects the %rbx register to be a flag indicating whether
>>> there should be a return to kernel mode.
>>>
>>> This commit makes sure that the %rbx register is not cleared by
>>> the PUSH_AND_CLEAR_REGS macro, when the macro in question is instantiated
>>> by xen_failsafe_callback, to avoid the issue.
>>
>>
>> Seems like a genuine problem, but:
>>
>>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>>> index c7449f377a77..96e8ff34129e 100644
>>> --- a/arch/x86/entry/entry_64.S
>>> +++ b/arch/x86/entry/entry_64.S
>>> @@ -1129,7 +1129,7 @@ ENTRY(xen_failsafe_callback)
>>>          addq    $0x30, %rsp
>>>          UNWIND_HINT_IRET_REGS
>>>          pushq   $-1 /* orig_ax = -1 => not a system call */
>>> -       PUSH_AND_CLEAR_REGS
>>> +       PUSH_AND_CLEAR_REGS clear_rbx=0
>>>          ENCODE_FRAME_POINTER
>>>          jmp     error_exit
>>
>>
>> The old code first set RBX to zero then, if frame pointers are on,
>> sets it to some special non-zero value, then crosses its fingers and
>> hopes for the best.  Your patched code just skips the zeroing part, so
>> RBX either contains the ENCODE_FRAME_POINTER result or is
>> uninitialized.
>>
>> How about actually initializing rbx to something sensible like, say, 1?
>
>
> Hello Andy,
>
> Thank you for the review! Apparently, I have not done my homework fully.
> I will test your suggestion and report back, most likely in a few hours.
>
> I have been testing with the next/linux-next tree's master branch
> (dated 20180720), and I noticed that ENCODE_FRAME_POINTER changes the
> frame pointer (i.e., RBP) register, as opposed to the RBX register,
> which the patch aims to avoid changing before jumping to error_exit.
> It is possible that I am missing something though -- I am not sure about
> the connection between the RBP and RBX registers.

Sorry, brain fart on my part.

>
> The change introduced by commit 3ac6d8c787b8 is in the excerpt below. Would
> it
> be valid to state that the original code had the same issue that you
> referred
> to (i.e., leaving the RBX register uninitialized)?

Presumably.

I would propose a rather different fix:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/pti&id=bb3d76b50c3bc78b67d79cf90d328f38a435c793

Any chance you could test that and see if it fixes your problem?
