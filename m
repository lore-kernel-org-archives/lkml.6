Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeCUArq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 20:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbeCUArm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 20:47:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F85F2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELumRgyRryk3vSmMdM3wxK8ObKn4iMDDYFsU95cYk1RpFu5QW6JQPmVBiHr+rTnj85tJxxz/heN4NyVvULMzs/Q=
MIME-Version: 1.0
In-Reply-To: <C78DE381-C618-4370-9B06-F6E25C850661@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com> <C78DE381-C618-4370-9B06-F6E25C850661@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 21 Mar 2018 00:47:21 +0000
X-Gmail-Original-Message-ID: <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
Message-ID: <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
Subject: Re: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when FS/GS
 updated by ptracer
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 4:33 PM, Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
> On 3/20/18, 08:05, "Andy Lutomirski" <luto@kernel.org> wrote:
>> I've also suggested something like this myself, but this approach is
>> far more complicated than the older approach.  Was there something
>> that the old approach would break?  If so, what?
> Sorry, I don't know your suggestion. Can you elaborate your suggestion?

What the old code did.

If I've understood all your emails right, when you looked at existing
ptrace users, you found that all of them that write to gs and/or
gs_base do it as part of a putregs call that writes them at the same
time.  If so, then your patch does exactly the same thing that my old
patches did, but your patch is much more complicated.  So why did you
add all that complexity?

>
>>> +               /*
>>> +                * %fs setting goes to reload its base, when tracee
>>> +                * resumes without FSGSBASE (legacy). Here with FSGSBASE
>>> +                * FS base is (manually) fetched from GDT/LDT when needed.
>>> +                */
>>> +               else if (static_cpu_has(X86_FEATURE_FSGSBASE) &&
>>> +                        (value != 0) && (task->thread.fsindex != value))
>>> +                       task->thread.fsbase = task_seg_base(task, value);
>
>> The comment above should explain why you're checking this particular
>> condition.  I find the fsindex != value check to be *very* surprising.
>>  On a real CPU, writing some nonzero value to %fs does the same thing
>>  regardless of what the old value of %fs was.
>
> With FSGSBASE, when both index and base are not changed, base will
> be (always) fetched from GDT/LDT. This is not thought as legacy behavior
> we need to support, AFAIK.
>
>> This is_fully_covered thing is IMO overcomplicated.  Why not just make
>> a separate helper set_fsgs_index_and_base() and have putregs() call it
>> when both are set at once?
>
> Using helper function here is exactly what I did at first. I thought this
> tag is simple enough and straightforward at the end. But I'm open to
> factor it out.
>
>

I retract this particular comment.  But I still think that all this
complexity needs to be more clearly justified.  My objection to the
old approach wasn't that I thought it was obviously wrong -- I thought
that someone needed to survey existing ptrace() users and see if
anyone needed the fancier code that you're adding.  Did you find
something that needs this fancy code?
