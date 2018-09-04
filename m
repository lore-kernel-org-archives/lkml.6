Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C424C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ABE2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoCbySeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ABE2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeIEByb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIEByb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:31 -0400
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D500C20836
        for <linux-kernel@vger.kernel.org>; Tue,  4 Sep 2018 21:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536096453;
        bh=f7LGP/x4uAdxq6LpfzWTq2jucyGoY3eenUq/z4sJbeQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=CoCbySeMP11Wh8sOTjG+jOt12goZzqRaK/p7hfHS2G7tzvTQMSAdwIsiTeOrCwlRT
         EP0hSI3hdVWVyAoPV8hYJjd4Y1YB+3JV5PaXe2qbC344HxDyOHU6BTe+JUUC294Cfp
         nJUqYplD4Nv/EN2w86T+POjh/AvlkSkPISIzzvG0=
Received: by mail-wm0-f43.google.com with SMTP id y139-v6so5828569wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 14:27:32 -0700 (PDT)
X-Gm-Message-State: APzg51B+d4La7w9g9YgS359LYE46mATTRB1HxYhv7OPJkROqbi+iyelS
        7Hu1wVBJ3IpvrCk90aQRHoiIiQBqElgM5kMx58DVwg==
X-Google-Smtp-Source: ANB0VdYzx8kjEyujCqnOtPpre32Rk+mUIvSLKajcG4SpSFBHSZh3LnzRRItjcH0KhXQ90+QcYz5okBe4FK0KqXelC84=
X-Received: by 2002:a7b:c151:: with SMTP id z17-v6mr3525255wmi.162.1536096451347;
 Tue, 04 Sep 2018 14:27:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:5942:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 14:27:10 -0700 (PDT)
In-Reply-To: <8a62de3e-defa-6681-c853-cd5140c5f0b5@intel.com>
References: <20180807172920.8766-1-sean.j.christopherson@intel.com>
 <20180904195030.GA6269@linux.intel.com> <CALCETrU-HXfr_eAfeS1t7JH+-gOh0ZfAoGxjcOckxEX1fN_YDA@mail.gmail.com>
 <8a62de3e-defa-6681-c853-cd5140c5f0b5@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Sep 2018 14:27:10 -0700
X-Gmail-Original-Message-ID: <CALCETrUKJ2qYVZRhDQEbVRPkgtj9VEdxc83ON9nAK-S52s7qmg@mail.gmail.com>
Message-ID: <CALCETrUKJ2qYVZRhDQEbVRPkgtj9VEdxc83ON9nAK-S52s7qmg@mail.gmail.com>
Subject: Re: [PATCH] x86/pkeys: Explicitly treat PK #PF on kernel address as a
 bad area
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 2:21 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 09/04/2018 12:56 PM, Andy Lutomirski wrote:
>> I have no objection to this patch.
>>
>> Dave, why did you think that we could get a PK fault on the vsyscall
>> page, even on kernels that still marked it executable?  Sure, you
>> could get an instruction in the vsyscall page to get a PK fault, but
>> CR2 wouldn't point to the vsyscall page, right?
>
> I'm inferring the CR2 value from the page fault trace point.  I see
> entries like this:
>
>  protection_keys-4313  [002] d... 420257.094541: page_fault_user:
> address=_end ip=_end error_code=0x15
>
> But, that's not a PK fault, and it triggers the "misaligned vsyscall
> (exploit attempt or buggy program)" stuff in dmesg.  It's just the
> symptom of trying to execute the non-executable vsyscall page.
>
> I'm not a super big fan of this particular patch, though.  The
> fault_in_kernel_space() check is really presuming two things:
> 1. pkey faults (PF_PK=1) only occur on user pages (_PAGE_USER=1)
> 2. fault_in_kernel_space()==1 addresses are never user pages
>
> #1 is a hardware expectation.  We *can* look for that directly by just
> making sure that X86_PF_PK is only set when it also comes with
> X86_PF_USER in the hardware page fault error code.
>
> (...
>         Aside: We should probably explicitly separate out the hardware
>         error code from the software-munged version, like we do here:
>         >         if (user_mode(regs)) {
>         >                 local_irq_enable();
>         >                 error_code |= X86_PF_USER)
>
> But, #2 is a bit of a more loose check.  It wasn't true for the recent
> vsyscall, and I've also seen goofy drivers map memory out to userspace
> quite a few times in the kernel address space.
>
> So, I'd much rather see a X86_PF_USER check than a X86_PF_USER check.
>
> But, as for pkeys...
>
> The original intent here was to relay: "protection key faults can never
> be spurious".  The reason in my silly comment was that we don't do lazy
> flushing, but that's imprecise: the real reasoning is that we don't ever
> have kernel pages on which we can take protection key faults.
>
> IOW, I think the check here should be for "protection key faults only
> occur on user pages", and all the *spurious* checking should be looking
> at *just* user vs. kernel pages, like:
>
> static int spurious_fault_check(unsigned long error_code, pte_t *pte)
> {
>         /* Only expect spurious faults on kernel pages: */
>         WARN_ON_ONCE(pte_flags(*pte) & _PAGE_USER);
>         /* Only expect spurious faults originating from kernel code: */
>         WARN_ON_ONCE(error_code & X86_PF_USER);
>         ...
>

Want to just send an alternative patch?

Also, I doubt it matters right here, but !X86_PF_USER isn't quite the
same thing as "originating from kernel code" -- it can also be user
code that does a CPL0 access due to exception delivery or access to a
descriptor table.  Which you saw plenty of times while debugging
PTI... :)  I doubt any of those should be spurious, though.

--Andy
