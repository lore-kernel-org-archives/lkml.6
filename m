Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025BEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFE121533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K/yM7yoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFE121533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeI0ITV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:19:21 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33008 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbeI0ITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 04:19:21 -0400
Received: by mail-yb1-f196.google.com with SMTP id z18-v6so472228ybr.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=85No1yqVeE5nzAv2xgGRCSOQfuJrRBFQT4kRr8jN/2A=;
        b=K/yM7yoaIsnmUXFGNPXbKrlzPKrTIAPkmqsNcMLeeu+5q4MkHrAcXLqMNSKviB7Td6
         D+Eu6XYDnFZkgtE3bELrQWQfat+REqfyd3rMm6+Pi1YgqwZ4T9scvQTH+GFEkewR4AzA
         Jo+RWMwnbZQd3zGkdOpA9r/JCr2ICVZrOeL30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=85No1yqVeE5nzAv2xgGRCSOQfuJrRBFQT4kRr8jN/2A=;
        b=nwi2rXcCiyKx3kl37T7T+lxkTdfyKo4r80nAVkIHbsRf3dXhLJUDe4lWYk+nzn3D2v
         EUQxOyD5tmzWx/0QyKxr+63+9JH8XZdNR+1mraT8TPHos/vZQfPJPVcfnPfG+JaP/k7x
         zwd7Uv411mgzz562GaB8JURJdD8BdL1nhfkGQkHiM7x20mbkB1Xn1Wr5t2GGwUz5Rv3B
         LW+TmuwS+I2Cd4d1jVFZWBoEiFGAWD9MsLQXX8LAdsER6HEbSsAaD/dZkwHJ4Oi8gKj0
         n421Qp3PafFcl36LaarPdVfcP3U8VJQMr9LjgFWGZBaApRWoP6vAKQlQRQksG66NX759
         rXKQ==
X-Gm-Message-State: ABuFfogY+OPBFsYu6HfxIVPKNBzzArFvRU0xhztV+UBZTXfWc7+xgv7j
        mFquOPvN6s9zy7JcHfrrNFpUYH88U8o=
X-Google-Smtp-Source: ACcGV61LFytPQzFsSsLRlmZCaO606u2Skvow7bGEMyS7A1WMQ+gfdJhXgSFbPRwrTliXjRjYZvKI5Q==
X-Received: by 2002:a25:6254:: with SMTP id w81-v6mr4611387ybb.97.1538013808431;
        Wed, 26 Sep 2018 19:03:28 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id l145-v6sm259005ywe.105.2018.09.26.19.03.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 19:03:26 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 184-v6so467965ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 19:03:25 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr4520380ybg.171.1538013805367;
 Wed, 26 Sep 2018 19:03:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 19:03:24
 -0700 (PDT)
In-Reply-To: <CAG48ez0M90ajea8Cee32VjRV4A5CjM8FA1kpdmL6yThBrGf9Lg@mail.gmail.com>
References: <20180911183909.233413-1-jannh@google.com> <CAG48ez03ivLr6w+V911V7pqb1o=kcJw4CLEktcSVVE+=hXXP=w@mail.gmail.com>
 <CAGXu5jKBPh+TSCuaitpPdk89hW=ch+QeRsUfE68pLpzLS=z4Jg@mail.gmail.com>
 <CAG48ez22djpKdtYDTMn0MS=2m_QAq983O0-oXyVGiu3ju2HwXg@mail.gmail.com>
 <CAGXu5jLLC6dp7T5AmKur0dioc767vvJFms8wj9syLBvQzcYQpg@mail.gmail.com> <CAG48ez0M90ajea8Cee32VjRV4A5CjM8FA1kpdmL6yThBrGf9Lg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 26 Sep 2018 19:03:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKcxDThFHsueZGFcNSvqi3JSgWA3hWrxEYPm-3YRUkbFw@mail.gmail.com>
Message-ID: <CAGXu5jKcxDThFHsueZGFcNSvqi3JSgWA3hWrxEYPm-3YRUkbFw@mail.gmail.com>
Subject: Re: [PATCH] proc: restrict kernel stack dumps to root
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ken Chen <kenchen@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Security Officers <security@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 6:19 PM, Jann Horn <jannh@google.com> wrote:
> On Thu, Sep 13, 2018 at 4:39 PM Kees Cook <keescook@chromium.org> wrote:
>> On Thu, Sep 13, 2018 at 4:55 AM, Jann Horn <jannh@google.com> wrote:
>> > On Thu, Sep 13, 2018 at 12:28 AM Kees Cook <keescook@chromium.org> wrote:
>> >>
>> >> On Wed, Sep 12, 2018 at 8:29 AM, Jann Horn <jannh@google.com> wrote:
>> >> > +linux-api, I guess
>> >> >
>> >> > On Tue, Sep 11, 2018 at 8:39 PM Jann Horn <jannh@google.com> wrote:
>> >> >>
>> >> >> Restrict the ability to inspect kernel stacks of arbitrary tasks to root
>> >> >> in order to prevent a local attacker from exploiting racy stack unwinding
>> >> >> to leak kernel task stack contents.
>> >> >> See the added comment for a longer rationale.
>> >> >>
>> >> >> There don't seem to be any users of this userspace API that can't
>> >> >> gracefully bail out if reading from the file fails. Therefore, I believe
>> >> >> that this change is unlikely to break things.
>> >> >> In the case that this patch does end up needing a revert, the next-best
>> >> >> solution might be to fake a single-entry stack based on wchan.
>> >> >>
>> >> >> Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
>> >> >> Cc: stable@vger.kernel.org
>> >> >> Signed-off-by: Jann Horn <jannh@google.com>
>> >> >> ---
>> >> >>  fs/proc/base.c | 14 ++++++++++++++
>> >> >>  1 file changed, 14 insertions(+)
>> >> >>
>> >> >> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> >> >> index ccf86f16d9f0..7e9f07bf260d 100644
>> >> >> --- a/fs/proc/base.c
>> >> >> +++ b/fs/proc/base.c
>> >> >> @@ -407,6 +407,20 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
>> >> >>         unsigned long *entries;
>> >> >>         int err;
>> >> >>
>> >> >> +       /*
>> >> >> +        * The ability to racily run the kernel stack unwinder on a running task
>> >> >> +        * and then observe the unwinder output is scary; while it is useful for
>> >> >> +        * debugging kernel issues, it can also allow an attacker to leak kernel
>> >> >> +        * stack contents.
>> >> >> +        * Doing this in a manner that is at least safe from races would require
>> >> >> +        * some work to ensure that the remote task can not be scheduled; and
>> >> >> +        * even then, this would still expose the unwinder as local attack
>> >> >> +        * surface.
>> >> >> +        * Therefore, this interface is restricted to root.
>> >> >> +        */
>> >> >> +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
>> >> >> +               return -EACCES;
>> >>
>> >> In the past, we've avoided hard errors like this in favor of just
>> >> censoring the output. Do we want to be more cautious here? (i.e.
>> >> return 0 or a fuller seq_printf(m, "[<0>] privileged\n"); return 0;)
>> >
>> > In my mind, this is different because it's a place where we don't have
>> > to selectively censor output while preserving parts of it, and it's a
>> > place where, as Laura said, it's useful to make lack of privileges
>> > clearly visible because that informs users that they may have to retry
>> > with more privileges.
>> >
>> > Of course, if you have an example of software that actually breaks due
>> > to this, I'll change it. But I looked at the three things in Debian
>> > codesearch that seem to use it, and from what I can tell, they all
>> > bail out cleanly when the read fails.
>>
>> I prefer -EACCESS too, but I thought I'd mention the alternative. So, I guess:
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> What do I need to do to get this merged? Oh, I think I misread
> MAINTAINERS - Alexey Dobriyan is not a maintainer, just a reviewer. So
> I guess this has to go via Andrew Morton? Should I resend the patch
> with Andrew in the recipient list?

Yeah, traditionally Andrew has taken /proc patches.

-Kees

-- 
Kees Cook
Pixel Security
