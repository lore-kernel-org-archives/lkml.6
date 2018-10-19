Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C23ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F3C21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjPbEARM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F3C21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJSMeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbeJSMeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 08:34:11 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E73821470
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 04:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539923392;
        bh=TUZvn65JKwqb6+T3EiH6Xe3tGdkOvIYBv3I4QnDINBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sjPbEARMIH022gSOFG5VOJl//YBan62B8fFFpOpAyT3RdcEaIh+Og2ne5yboNXaYg
         SIAPS/zBf7dwA8wY+Pvd7O3zz0eoHi11Vug0vIBggGtS5N35UNuwXzfsvxKFqsp0fy
         zSZQ5SbuiA6TEde8cKzhktK4Sg8GjTWkiPqD/yL8=
Received: by mail-wm1-f50.google.com with SMTP id 206-v6so2253523wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 21:29:52 -0700 (PDT)
X-Gm-Message-State: ABuFfohnIR5hm8wuNRBUJMn/rif0osck2ie57UyiQk9Xyj9S3uNHSq1O
        bIdgqxXwu/mILT+nzthSR1HUZblhAdsB2JVotgSYhA==
X-Google-Smtp-Source: ACcGV63kaAfwAp8q2uV+Ldvg7xTRB11j7sTPWVfCD+Ce/3NFLfc0Jl9J71KhjYdeBIHdoDaVJDfAT+et75vtrFYs6w8=
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr3025461wmf.19.1539923391063;
 Thu, 18 Oct 2018 21:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181018005420.82993-1-namit@vmware.com> <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net> <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com> <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
In-Reply-To: <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 18 Oct 2018 21:29:39 -0700
X-Gmail-Original-Message-ID: <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
Message-ID: <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
To:     Nadav Amit <namit@vmware.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Oct 18, 2018, at 6:08 PM, Nadav Amit <namit@vmware.com> wrote:
>
> at 10:00 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>
>>
>>
>>> On Oct 18, 2018, at 9:47 AM, Nadav Amit <namit@vmware.com> wrote:
>>>
>>> at 8:51 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>
>>>>> On Wed, Oct 17, 2018 at 8:12 PM Nadav Amit <namit@vmware.com> wrote:
>>>>> at 6:22 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>>>
>>>>>>> On Oct 17, 2018, at 5:54 PM, Nadav Amit <namit@vmware.com> wrote:
>>>>>>>
>>>>>>> It is sometimes beneficial to prevent preemption for very few
>>>>>>> instructions, or prevent preemption for some instructions that prec=
ede
>>>>>>> a branch (this latter case will be introduced in the next patches).
>>>>>>>
>>>>>>> To provide such functionality on x86-64, we use an empty REX-prefix
>>>>>>> (opcode 0x40) as an indication that preemption is disabled for the
>>>>>>> following instruction.
>>>>>>
>>>>>> Nifty!
>>>>>>
>>>>>> That being said, I think you have a few bugs. First, you can=E2=80=
=99t just ignore
>>>>>> a rescheduling interrupt, as you introduce unbounded latency when th=
is
>>>>>> happens =E2=80=94 you=E2=80=99re effectively emulating preempt_enabl=
e_no_resched(), which
>>>>>> is not a drop-in replacement for preempt_enable(). To fix this, you =
may
>>>>>> need to jump to a slow-path trampoline that calls schedule() at the =
end or
>>>>>> consider rewinding one instruction instead. Or use TF, which is only=
 a
>>>>>> little bit terrifying=E2=80=A6
>>>>>
>>>>> Yes, I didn=E2=80=99t pay enough attention here. For my use-case, I t=
hink that the
>>>>> easiest solution would be to make synchronize_sched() ignore preempti=
ons
>>>>> that happen while the prefix is detected. It would slightly change th=
e
>>>>> meaning of the prefix.
>>>
>>> So thinking about it further, rewinding the instruction seems the easie=
st
>>> and most robust solution. I=E2=80=99ll do it.
>>>
>>>>>> You also aren=E2=80=99t accounting for the case where you get an exc=
eption that
>>>>>> is, in turn, preempted.
>>>>>
>>>>> Hmm.. Can you give me an example for such an exception in my use-case=
? I
>>>>> cannot think of an exception that might be preempted (assuming #BP, #=
MC
>>>>> cannot be preempted).
>>>>
>>>> Look for cond_local_irq_enable().
>>>
>>> I looked at it. Yet, I still don=E2=80=99t see how exceptions might hap=
pen in my
>>> use-case, but having said that - this can be fixed too.
>>
>> I=E2=80=99m not totally certain there=E2=80=99s a case that matters.  Bu=
t it=E2=80=99s worth checking
>
> I am still checking. But, I wanted to ask you whether the existing code i=
s
> correct, since it seems to me that others do the same mistake I did, unle=
ss
> I don=E2=80=99t understand the code.
>
> Consider for example do_int3(), and see my inlined comments:
>
> dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
> {
>    ...
>    ist_enter(regs);        // =3D> preempt_disable()
>    cond_local_irq_enable(regs);    // =3D> assume it enables IRQs
>
>    ...
>    // resched irq can be delivered here. It will not caused rescheduling
>    // since preemption is disabled
>
>    cond_local_irq_disable(regs);    // =3D> assume it disables IRQs
>    ist_exit(regs);            // =3D> preempt_enable_no_resched()
> }
>
> At this point resched will not happen for unbounded length of time (unles=
s
> there is another point when exiting the trap handler that checks if
> preemption should take place).

I think it's only a bug in the cases where someone uses extable to fix
up an int3 (which would be nuts) or that we oops.  But I should still
fix it.  In the normal case where int3 was in user code, we'll miss
the reschedule in do_trap(), but we'll reschedule in
prepare_exit_to_usermode() -> exit_to_usermode_loop().

>
> Another example is __BPF_PROG_RUN_ARRAY(), which also uses
> preempt_enable_no_resched().

Alexei, I think this code is just wrong. Do you know why it uses
preempt_enable_no_resched()?

Oleg, the code in kernel/signal.c:

                preempt_disable();
                read_unlock(&tasklist_lock);
                preempt_enable_no_resched();
                freezable_schedule();

looks bogus.  I don't get what it's trying to achieve with
preempt_disable(), and I also don't see why no_resched does anything.
Sure, it prevents a reschedule triggered during read_unlock() from
causing a reschedule, but it doesn't prevent an interrupt immediately
after the preempt_enable_no_resched() call from scheduling.

--Andy

>
> Am I missing something?
>
> Thanks,
> Nadav
