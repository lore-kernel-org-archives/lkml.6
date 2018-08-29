Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F422C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7D220657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhHpJTn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7D220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeH2UaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727293AbeH2UaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:30:20 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFFDF20666
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 16:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535560357;
        bh=A5bT3HQyf3AMTeKPVvzRUmUPxNczw9j8KNgcNEVFFNQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=fhHpJTn2EcreKNt1YIG+nx6lnz0dZ0QAQdiuDLSQM8aI10X4klk7PqPV8pN0/9B+C
         2C96PyYlufQtk5o4WkJiCAiMrEXqxRP6v+bmxVG643Qz+7W9OtSom8kozy4Ob0x8OV
         8FivjT3mReypyW3FA+DQ7SEeUN0KDkRPM1sweosE=
Received: by mail-wr1-f41.google.com with SMTP id n2-v6so5420962wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 09:32:36 -0700 (PDT)
X-Gm-Message-State: APzg51BhptF4s9k0ep/ibPXVyuslQPGXU+afUs7TZND5WprKVDbekhaS
        RkixubzHcGZZOAAXo49bMFsc8/cS/Jy/uBlo0oL6aw==
X-Google-Smtp-Source: ANB0VdY+0Nn9oAlbu5CRLx8d0WuoS3cdMJ/2FOigWXFXGNOZEQ/8RjQqNvR9JegmR96ykhNROyy9q1XogF4NZ5wuWb0=
X-Received: by 2002:adf:f112:: with SMTP id r18-v6mr4798839wro.29.1535560355431;
 Wed, 29 Aug 2018 09:32:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 09:32:14 -0700 (PDT)
In-Reply-To: <20180829161400.GV24124@hirez.programming.kicks-ass.net>
References: <20180829081147.184610-1-namit@vmware.com> <20180829081147.184610-6-namit@vmware.com>
 <20180829092839.GP24124@hirez.programming.kicks-ass.net> <CALCETrXe9CUMo3c44UtmkxD4w68PvmoypdCyvCFvWiZVuxy=sQ@mail.gmail.com>
 <20180829161400.GV24124@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 29 Aug 2018 09:32:14 -0700
X-Gmail-Original-Message-ID: <CALCETrVixiv+9Eb7yO334gF_C4CLgr0cTDzS==FZ3TXSgMNt9Q@mail.gmail.com>
Message-ID: <CALCETrVixiv+9Eb7yO334gF_C4CLgr0cTDzS==FZ3TXSgMNt9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] x86/alternatives: use temporary mm for text poking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 9:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Aug 29, 2018 at 08:46:04AM -0700, Andy Lutomirski wrote:
>> On Wed, Aug 29, 2018 at 2:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Wed, Aug 29, 2018 at 01:11:46AM -0700, Nadav Amit wrote:
>>
>> >> +     pte_clear(poking_mm, poking_addr, ptep);
>> >> +
>> >> +     /*
>> >> +      * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
>> >> +      * as it also flushes the corresponding "user" address spaces, which
>> >> +      * does not exist.
>> >> +      *
>> >> +      * Poking, however, is already very inefficient since it does not try to
>> >> +      * batch updates, so we ignore this problem for the time being.
>> >> +      *
>> >> +      * Since the PTEs do not exist in other kernel address-spaces, we do
>> >> +      * not use __flush_tlb_one_kernel(), which when PTI is on would cause
>> >> +      * more unwarranted TLB flushes.
>> >> +      */
>> >
>> > yuck :-), but yeah.
>>
>> I'm sure we covered this ad nauseum when PTI was being developed, but
>> we were kind of in a rush, so:
>>
>> Why do we do INVPCID at all?  The fallback path for non-INVPCID
>> systems uses invalidate_user_asid(), which should be faster than the
>> invpcid path.  And doesn't do a redundant flush in this case.
>
> I don't remember; and you forgot to (re)add dhansen.
>
> Logically INVPCID_SINGLE should be faster since it pokes out a single
> translation in another PCID instead of killing all user translations.
>
> Is it just a matter of (current) chips implementing INVLPCID_SINGLE
> inefficient, or something else?

It's two things.  Current chips (or at least Skylake, but I'm pretty
sure that older chips are the same) have INVPCID being slower than
writing CR3.  (Yes, that's right, it is considerably faster to flush
the a whole PCID by writing to CR3 than it is to ask INVPCID to do
anything at all.)  But INVPCID is also serializing, whereas just
marking an ASID for future flushing is essentially free.

It's plausible that there are workloads where the current code is
faster, such as where we're munmapping a single page via syscall and
we'd prefer to only flush that one TLB entry even if the flush
operation is slower as a result.

--Andy
