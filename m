Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7665C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DF6206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TRzkUs09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DF6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIMTtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:49:35 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34219 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeIMTtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:49:35 -0400
Received: by mail-yw1-f68.google.com with SMTP id y134-v6so1244216ywg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lqkrvO4ljv0hR1+QCQLMipnxMahrrKYDsk1knwbuUdQ=;
        b=TRzkUs09krr/JPT/9OhtSG+n5kuEmWfeoJZRHkkBEkG5JbOtHfFWxhB6sNtHG+xCYp
         SGI/gjM1cw09quY+PHZhzXu2W+OOu8Y/mxM4IocTctT77zy0Z9BKIsXf2HNs2CjvnS3S
         Ormf9lL+FBVU/wYs7woxfogAtWxQXzbfBygGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lqkrvO4ljv0hR1+QCQLMipnxMahrrKYDsk1knwbuUdQ=;
        b=Itb4Y0Zi9Wcrw7XpunGFwiCFX/ENajCS9qHEUZoz9PkoDOS3RolbCisbYfnN+Lbk+K
         b9YvSfER5ce2OWCen4P/v3fJyUhsw96xJ8sUpYBeApveyPsmQdrFSaNl1JFYE4AE/lrf
         8TjhZqXrtO50GLyTKgR9ImKsSGyHGco2n0Md2hWG0fwz0DGoQJLG4JXR/Gz5Ojisxh7F
         XAjEufEte29x1Rlncs8JMqByCFxoToiYVf8BW0ex6b4xBAxhD3RMSoa6nW19NoB5ys8s
         C8dtTHZz4/jUK1Vve5PeId71Mvb6V62p80dE0cpbUUTfFNcGHSwqAUTOe2OItt3IjQdq
         cDiA==
X-Gm-Message-State: APzg51Cy21Vu5JmoIk4b/z+uHMSKPugaLFPRkPZgSabuobh2t+ZvxQH9
        7Act0/MBXvj9oSR5hlrFrfIFQGJJ3AU=
X-Google-Smtp-Source: ANB0VdYLckxJnqmLTCig+VDJ8IF5UipZ/2zZwmRfHfDgZE1D84clcjvRHvU2+brfTOryB/8+1nf19w==
X-Received: by 2002:a0d:e3c3:: with SMTP id m186-v6mr3583923ywe.317.1536849585630;
        Thu, 13 Sep 2018 07:39:45 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id t124-v6sm1792798ywt.105.2018.09.13.07.39.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 07:39:44 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id g79-v6so720549ybf.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:39:44 -0700 (PDT)
X-Received: by 2002:a25:f606:: with SMTP id t6-v6mr3678650ybd.141.1536849583806;
 Thu, 13 Sep 2018 07:39:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 07:39:43
 -0700 (PDT)
In-Reply-To: <CAG48ez22djpKdtYDTMn0MS=2m_QAq983O0-oXyVGiu3ju2HwXg@mail.gmail.com>
References: <20180911183909.233413-1-jannh@google.com> <CAG48ez03ivLr6w+V911V7pqb1o=kcJw4CLEktcSVVE+=hXXP=w@mail.gmail.com>
 <CAGXu5jKBPh+TSCuaitpPdk89hW=ch+QeRsUfE68pLpzLS=z4Jg@mail.gmail.com> <CAG48ez22djpKdtYDTMn0MS=2m_QAq983O0-oXyVGiu3ju2HwXg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 07:39:43 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLLC6dp7T5AmKur0dioc767vvJFms8wj9syLBvQzcYQpg@mail.gmail.com>
Message-ID: <CAGXu5jLLC6dp7T5AmKur0dioc767vvJFms8wj9syLBvQzcYQpg@mail.gmail.com>
Subject: Re: [PATCH] proc: restrict kernel stack dumps to root
To:     Jann Horn <jannh@google.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
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

On Thu, Sep 13, 2018 at 4:55 AM, Jann Horn <jannh@google.com> wrote:
> On Thu, Sep 13, 2018 at 12:28 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Wed, Sep 12, 2018 at 8:29 AM, Jann Horn <jannh@google.com> wrote:
>> > +linux-api, I guess
>> >
>> > On Tue, Sep 11, 2018 at 8:39 PM Jann Horn <jannh@google.com> wrote:
>> >>
>> >> Restrict the ability to inspect kernel stacks of arbitrary tasks to root
>> >> in order to prevent a local attacker from exploiting racy stack unwinding
>> >> to leak kernel task stack contents.
>> >> See the added comment for a longer rationale.
>> >>
>> >> There don't seem to be any users of this userspace API that can't
>> >> gracefully bail out if reading from the file fails. Therefore, I believe
>> >> that this change is unlikely to break things.
>> >> In the case that this patch does end up needing a revert, the next-best
>> >> solution might be to fake a single-entry stack based on wchan.
>> >>
>> >> Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
>> >> Cc: stable@vger.kernel.org
>> >> Signed-off-by: Jann Horn <jannh@google.com>
>> >> ---
>> >>  fs/proc/base.c | 14 ++++++++++++++
>> >>  1 file changed, 14 insertions(+)
>> >>
>> >> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> >> index ccf86f16d9f0..7e9f07bf260d 100644
>> >> --- a/fs/proc/base.c
>> >> +++ b/fs/proc/base.c
>> >> @@ -407,6 +407,20 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
>> >>         unsigned long *entries;
>> >>         int err;
>> >>
>> >> +       /*
>> >> +        * The ability to racily run the kernel stack unwinder on a running task
>> >> +        * and then observe the unwinder output is scary; while it is useful for
>> >> +        * debugging kernel issues, it can also allow an attacker to leak kernel
>> >> +        * stack contents.
>> >> +        * Doing this in a manner that is at least safe from races would require
>> >> +        * some work to ensure that the remote task can not be scheduled; and
>> >> +        * even then, this would still expose the unwinder as local attack
>> >> +        * surface.
>> >> +        * Therefore, this interface is restricted to root.
>> >> +        */
>> >> +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
>> >> +               return -EACCES;
>>
>> In the past, we've avoided hard errors like this in favor of just
>> censoring the output. Do we want to be more cautious here? (i.e.
>> return 0 or a fuller seq_printf(m, "[<0>] privileged\n"); return 0;)
>
> In my mind, this is different because it's a place where we don't have
> to selectively censor output while preserving parts of it, and it's a
> place where, as Laura said, it's useful to make lack of privileges
> clearly visible because that informs users that they may have to retry
> with more privileges.
>
> Of course, if you have an example of software that actually breaks due
> to this, I'll change it. But I looked at the three things in Debian
> codesearch that seem to use it, and from what I can tell, they all
> bail out cleanly when the read fails.

I prefer -EACCESS too, but I thought I'd mention the alternative. So, I guess:

Reviewed-by: Kees Cook <keescook@chromium.org>

:)

-Kees

-- 
Kees Cook
Pixel Security
