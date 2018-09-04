Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D7C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0AF2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNLEKOCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0AF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeIEAXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbeIEAXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:23:13 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EE8620869
        for <linux-kernel@vger.kernel.org>; Tue,  4 Sep 2018 19:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536090995;
        bh=A4epN5Ye3M/shXurfeqmxOfZ7lb3DSWp9WpeSyZBBsU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=pNLEKOCKThxHecZu69Ty34gZVzQJQpHcc8hRumpl8NkeQcxORuDU2Ewy1fRG+1AAy
         4LLvBx+lX2AvOK3s8kwCqdSBceoKd+9dxeYqGxM3nksB1w52udSgMQexg4jlmHV2v0
         6YS/iW8JagdUFuhgkjggVjw9zaWRYOVrsfBp2AbI=
Received: by mail-wm0-f45.google.com with SMTP id r1-v6so10003433wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 12:56:35 -0700 (PDT)
X-Gm-Message-State: APzg51DTxnDwVe2nVx5jGuxwdHqHSkmLJs+Ljo/1nUuIOdJJg/aOaUbM
        ZlQFRlJ0m/uJPeyM86cdElArEm71ifQY8RMl76krbQ==
X-Google-Smtp-Source: ANB0VdZZobdpHPveuXGfEtlYjzUTrrNahXbnredefMxThem3RtO+O75blyXKwmWA2e+VaYFA2OyhLu91NFkziuxlMwU=
X-Received: by 2002:a1c:d1c3:: with SMTP id i186-v6mr9369265wmg.5.1536090993667;
 Tue, 04 Sep 2018 12:56:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b156:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 12:56:13 -0700 (PDT)
In-Reply-To: <20180904195030.GA6269@linux.intel.com>
References: <20180807172920.8766-1-sean.j.christopherson@intel.com> <20180904195030.GA6269@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Sep 2018 12:56:13 -0700
X-Gmail-Original-Message-ID: <CALCETrU-HXfr_eAfeS1t7JH+-gOh0ZfAoGxjcOckxEX1fN_YDA@mail.gmail.com>
Message-ID: <CALCETrU-HXfr_eAfeS1t7JH+-gOh0ZfAoGxjcOckxEX1fN_YDA@mail.gmail.com>
Subject: Re: [PATCH] x86/pkeys: Explicitly treat PK #PF on kernel address as a
 bad area
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 12:50 PM, Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
> Cc-ing Jann and Andy.
>
> On Tue, Aug 07, 2018 at 10:29:20AM -0700, Sean Christopherson wrote:
>> Kernel addresses are always mapped with _PAGE_USER=0, i.e. PKRU
>> isn't enforced, and so we should never see X86_PF_PK set on a
>> kernel address fault.  WARN once to capture the issue in case we
>> somehow don't die, e.g. the access originated in userspace.
>>
>> Remove a similar check and its comment from spurious_fault_check().
>> The intent of the comment (and later code[1]) was simply to document
>> that spurious faults due to protection keys should be impossible, but
>> that's irrelevant and a bit of a red herring since we should never
>> get a protection keys fault on a kernel address regardless of the
>> kernel's TLB flushing behavior.
>>
>> [1] http://lists-archives.com/linux-kernel/28407455-x86-pkeys-new-page-fault-error-code-bit-pf_pk.html
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> ---
>> There's no indication that this condition has ever been encountered.
>> I came across the code in spurious_fault_check() and was confused as
>> to why we would unconditionally treat a protection keys fault as
>> spurious when the comment explicitly stated that such a case should
>> be impossible.
>>
>> Dave Hansen suggested adding a WARN_ON_ONCE in spurious_fault_check(),
>> but it seemed more appropriate to freak out on any protection keys
>> fault on a kernel address since that would imply a hardware issue or
>> kernel bug.  I omitted a Suggested-by since this isn't necessarily
>> what Dave had in mind.
>>
>>  arch/x86/mm/fault.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 2aafa6ab6103..f19a55972136 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1040,12 +1040,6 @@ static int spurious_fault_check(unsigned long error_code, pte_t *pte)
>>
>>       if ((error_code & X86_PF_INSTR) && !pte_exec(*pte))
>>               return 0;
>> -     /*
>> -      * Note: We do not do lazy flushing on protection key
>> -      * changes, so no spurious fault will ever set X86_PF_PK.
>> -      */
>> -     if ((error_code & X86_PF_PK))
>> -             return 1;
>>
>>       return 1;
>>  }
>> @@ -1241,6 +1235,14 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>>        * protection error (error_code & 9) == 0.
>>        */
>>       if (unlikely(fault_in_kernel_space(address))) {
>> +             /*
>> +              * We should never encounter a protection keys fault on a
>> +              * kernel address as kernel address are always mapped with
>> +              * _PAGE_USER=0, i.e. PKRU isn't enforced.
>> +              */
>> +             if (WARN_ON_ONCE(error_code & X86_PF_PK))
>> +                     goto bad_kernel_address;
>> +
>>               if (!(error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
>>                       if (vmalloc_fault(address) >= 0)
>>                               return;
>> @@ -1253,6 +1255,8 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>>               /* kprobes don't want to hook the spurious faults: */
>>               if (kprobes_fault(regs))
>>                       return;
>> +
>> +bad_kernel_address:
>>               /*
>>                * Don't take the mm semaphore here. If we fixup a prefetch
>>                * fault we could otherwise deadlock:

I have no objection to this patch.

Dave, why did you think that we could get a PK fault on the vsyscall
page, even on kernels that still marked it executable?  Sure, you
could get an instruction in the vsyscall page to get a PK fault, but
CR2 wouldn't point to the vsyscall page, right?

>> --
>> 2.18.0
>>
