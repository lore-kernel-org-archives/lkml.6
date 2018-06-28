Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AC5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5E825115
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z8KblJ9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5E825115
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936011AbeF1Udt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932078AbeF1Udr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:33:47 -0400
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 947F3242DA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530218027;
        bh=AfnuWQQP97MYR1Usb9kpz7R64eXQPZM5FxMtTp2v04c=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=z8KblJ9Y5WV1EUVnctfnyVfZwdTc1Hrq6TVBncxgV6m4eIEnfv9PCojSPxAIrfPUP
         +fRP/cX4BL6uVfI3+UGpFGasJXb6bc2+DqC7M7lZeGT6U4MHQj2ckIIrph/4qdlwKw
         83Ef9hwSl761rBw6XUoYBEEw/9F9iPlBRs9xibSY=
Received: by mail-wm0-f54.google.com with SMTP id 69-v6so10288826wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 13:33:46 -0700 (PDT)
X-Gm-Message-State: APt69E0zy9+fot4rtfLJULges9+vUDUsymlhw6AYPuM/kiMQ4k61ci8c
        Ipxytw4s08lVfb7VspRz7wzT/rlafNBH8jENxeqUiw==
X-Google-Smtp-Source: AAOMgpd747CP1gua05mqAMbWeu5JyKf4K0wWUT/6bpazntLY3PER7wnvRQg6jPCf6Va50SnSdbdmFl+oxtSX/oWahV8=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr8706936wmi.46.1530218025012;
 Thu, 28 Jun 2018 13:33:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7e92:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 13:33:24
 -0700 (PDT)
In-Reply-To: <27F6CB18-8E20-487B-B55B-1DAEF9DF9E2C@zytor.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
 <20180621211754.12757-2-h.peter.anvin@intel.com> <CALCETrWerhEUMw+JS4p5MVEopiMnUjbUtX58Ci7UYfYT=Y5Cvw@mail.gmail.com>
 <408ed97a-c64d-c523-c403-4e066d1f34c3@intel.com> <FB113DE3-5841-49B2-A11E-CE785EF0C763@amacapital.net>
 <CALCETrX30hRA_8OJ4uv4GQDf_Tu+DNRhgbo5XF60kTyH9+4G=Q@mail.gmail.com> <27F6CB18-8E20-487B-B55B-1DAEF9DF9E2C@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Jun 2018 13:33:24 -0700
X-Gmail-Original-Message-ID: <CALCETrWkHsptX=z8bPGwYEVwqG8Hz2=ybkym=-EBq1qeC2ycZw@mail.gmail.com>
Message-ID: <CALCETrWkHsptX=z8bPGwYEVwqG8Hz2=ybkym=-EBq1qeC2ycZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] x86/ldt: refresh %fs and %gs in refresh_ldt_segments()
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <h.peter.anvin@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:22 AM,  <hpa@zytor.com> wrote:
> On June 27, 2018 11:19:12 AM PDT, Andy Lutomirski <luto@kernel.org> wrote=
:
>>On Fri, Jun 22, 2018 at 11:47 AM, Andy Lutomirski <luto@amacapital.net>
>>wrote:
>>>
>>>
>>>
>>>> On Jun 22, 2018, at 11:29 AM, H. Peter Anvin
>><h.peter.anvin@intel.com> wrote:
>>>>
>>>>> On 06/22/18 07:24, Andy Lutomirski wrote:
>>>>>
>>>>> That RPL3 part is false.  The following program does:
>>>>>
>>>>> #include <stdio.h>
>>>>>
>>>>> int main()
>>>>> {
>>>>>    unsigned short sel;
>>>>>    asm volatile ("mov %%ss, %0" : "=3Drm" (sel));
>>>>>    sel &=3D ~3;
>>>>>    printf("Will write 0x%hx to GS\n", sel);
>>>>>    asm volatile ("mov %0, %%gs" :: "rm" (sel & ~3));
>>>>>    asm volatile ("mov %%gs, %0" : "=3Drm" (sel));
>>>>>    printf("GS =3D 0x%hx\n", sel);
>>>>>    return 0;
>>>>> }
>>>>>
>>>>> prints:
>>>>>
>>>>> Will write 0x28 to GS
>>>>> GS =3D 0x28
>>>>>
>>>>> The x86 architecture is *insane*.
>>>>>
>>>>> Other than that, this patch seems generally sensible.  But my
>>>>> objection that it's incorrect with FSGSBASE enabled for %fs and %gs
>>>>> still applies.
>>>>>
>>>>
>>>> Ugh, you're right... I misremembered.  The CPL simply overrides the
>>RPL
>>>> rather than trapping.
>>>>
>>>> We still need to give legacy applications which have zero idea about
>>the
>>>> separate bases that apply only to 64-bit mode a way to DTRT.
>>Requiring
>>>> these old crufty applications to do something new is not an option.
>>>
>>>>
>>>> As ugly as it is, I'm thinking the Right Thing is to simply make it
>>a
>>>> part of the Linux ABI that if the FS or GS selector registers point
>>into
>>>> the LDT then we will requalify them; if a 64-bit app does that then
>>they
>>>> get that behavior.  This isn't something that will happen
>>>> asynchronously, and if a 64-bit process loads an LDT value into FS
>>or
>>>> GS, they are considered to have opted in to that behavior.
>>>
>>> But the old and crusty apps don=E2=80=99t depend on requalification bec=
ause
>>we never used to do it.
>>>
>>> I=E2=80=99m not convinced we ever need to refresh the base. In fact, we=
 could
>>start preserving the base of LDT-referencing FS/GS across context
>>switches even without FSGSBASE at some minor performance cost, but I
>>don=E2=80=99t really see the point. I still think my proposed semantics a=
re
>>easy to implement and preserve the ABI even if they have the sad
>>property that the FSGSBASE behavior and the non-FSGSBASE behavior end
>>up different.
>>>
>>
>>There's another reasonable solution: do exactly what your patch does,
>>minus the bugs.  We would need to get the RPL !=3D 3 case right (easy)
>>and the case where there's a non-running thread using the selector in
>>question.  The latter is probably best handled by adding a flag to
>>thread_struct that says "fsbase needs reloading from the descriptor
>>table" and only applies if the selector is in the LDT or TLS area.  Or
>>we could hijack a high bit in the selector.  Then we'd need to update
>>everything that uses the fields.
>
> Obviously fix the bugs.
>
> How would you control this bit?

Sorry, I was wrong in my previous email.  Let me try this again:

Notwithstanding the RPL thing, the reason I don't like your patch as
is, and the reason I didn't write a similar patch myself, is that it
will behave nondeterministically on an FSGSBASE kernel.  Suppose there
are two threads, A and B, that share an mm.  A has %fs =3D=3D 0x7 and
FSBASE =3D 0.  The LDT has the base for entry 0 set to 0.

Now thread B calls modify_ldt to change the base for entry 0 to 1.

The Obviously Sane (tm) behavior is for task A's FSBASE to
asynchronously change to 1.  This is the only deterministic behavior
that is even possible on a 32-bit kernel, and it's the only
not-totally-nutty behavior that is possible on a 64-bit non-FSGSBASE
kernel, and it's still perfectly reasonable for FSGSBASE.  The problem
is that it's not so easly to implement.

With your patch, on an FSGSBASE kernel, we get the desired behavior if
thread A is running while thread B calls modify_ldt().  But we get
different behavior if thread A is stopped -- thread A's FSBASE will
remain set to 0.

With that in mind, my email was otherwise garbage, and the magic "bit"
idea was total crap.

I can see three vaguely credible ways to implement this.

1. thread B walks all threads on the system, notices that thread A has
the same mm, and asynchronously fixes it up.  The locking is a bit
tricky, and the performance isn't exactly great.  Maybe that's okay.

2. We finally add an efficient way to find all threads that share an
mm and do (1) but faster.

3. We add enough bookkeeping to thread_struct so that, the next time
thread A runs or has ptrace try to read its FSBASE, we notice that
FSBASE is stale and fix it up.

(3) will perform the best, but the implementation is probably nasty.
If we want modify_ldt() to only reset the base for the modified
records, we probably need a version number for each of the 8192
possible LDT entries stored in ldt_struct (which will double its size,
but so what?).  Then we need thread_struct to store the version number
of the LDT entries that fsindex and gsindex refer to.  Now we make
sure that every code path that reads fsbase or gsbase first calls some
revalidate_fs_and_gs() function that will reset the bases and maybe
even the selectors if needed.  Getting the locking right on that last
bit is possibly a bit tricky, since we may need the LDT lock to be
held across the revalidation *and* whatever subsequent code actually
reads the values.

I think that (3) is the nicest solution, but it would need to be implemeted=
.

What do you think?
