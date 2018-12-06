Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2171DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45E420878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EjgA4tia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45E420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeLFW4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:56:03 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38958 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeLFW4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:56:03 -0500
Received: by mail-yw1-f66.google.com with SMTP id j6so288503ywj.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 14:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JW5CivxuM5IQiF1ypLDdmu+2GGtRJqXw6EH7cbr+0Do=;
        b=EjgA4tiapHVa1rfADWDddNLowb/tmklLw78VSGIAC/j+WKcCwqTJaV5/VaLUy+xWYS
         cB/5CNJrDGX0sObMm7AVX8bSnfpZeClHo5lNdXLsx39jHqOemSg4EjiPi1zIWA85f8ZI
         H993ZexSjGYyw2YAaO7XINnaPsAwTgFFuPPe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JW5CivxuM5IQiF1ypLDdmu+2GGtRJqXw6EH7cbr+0Do=;
        b=EXSw+QHXixjVEdeli/qaJ3lhqphGA7t76TAy5xeieoW4a/hAls7vysQLgD3kUArnDL
         JkU/+KJuB6t4srnw+wZkAeIJ0uftIVO2NXiv9jxzA8BUcvmJXmbGY+LcJbKZ8jabF2W/
         vS6JaArH4HnJnMiuYwdCT9T11AXZ49+C6Yz3FQ9ZAcJvqq7NacsjBwjmGKlG5nPwoSbV
         QVxxLrT2CAeXlyPACuKxYK6r078RUCkzkvgGA8RpPpId7d7Q3pNYo6yyyCiuYkIbetNw
         2dTcvLH120a2YRJe/d/Hq9rCigXC+956wmlc9DM1bL6QfEmU/gys6yjEQM6vyfwllzQs
         P5wQ==
X-Gm-Message-State: AA+aEWYssHtm6CzDqHXFbYyA7Gto11KBg1POwpbGoaV2vNPoeeirXhVB
        D5OPNhhQEHw1dzsZ+V384s6C1SvC2Xg=
X-Google-Smtp-Source: AFSGD/XX6k7PSBRUceWpp/i4iJmQSnKW1SLqTA/BIV6xxreKx9QfIs1ckI2ZKEkCs4zwHHqB8p4KeQ==
X-Received: by 2002:a0d:f603:: with SMTP id g3mr30177748ywf.75.1544136961084;
        Thu, 06 Dec 2018 14:56:01 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id w2sm1392455ywl.10.2018.12.06.14.55.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 14:55:59 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id c15so1555395ybf.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 14:55:58 -0800 (PST)
X-Received: by 2002:a25:2347:: with SMTP id j68mr21247092ybj.137.1544136958487;
 Thu, 06 Dec 2018 14:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20181112192443.GL3645@cisco> <20181127232126.GA23658@cisco>
 <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
 <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
 <87zhtthkuy.fsf@xmission.com> <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
 <87k1ktqoe5.fsf@xmission.com> <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
 <87r2euiuql.fsf@xmission.com> <CAHk-=wjTzjOqEhWJskx7ToHL2d1KUxsNOZ2V0=v_R6VJYtOm7Q@mail.gmail.com>
 <20181206192059.GD10086@cisco> <87lg528io7.fsf@xmission.com>
 <CAGXu5jLUXCP1UWpiFRJ=jM8jwrnS1v2By8c4ywRPhAdOPAUMtA@mail.gmail.com> <87tvjq2s55.fsf@xmission.com>
In-Reply-To: <87tvjq2s55.fsf@xmission.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Dec 2018 14:55:45 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+a3kuS38gfB5tswYiLvnpLT3ZYzDdxMX5+F9Y-XG6r0g@mail.gmail.com>
Message-ID: <CAGXu5j+a3kuS38gfB5tswYiLvnpLT3ZYzDdxMX5+F9Y-XG6r0g@mail.gmail.com>
Subject: Re: siginfo pid not populated from ptrace?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 2:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Kees Cook <keescook@chromium.org> writes:
> > What should we do for v4.20? I need to have the selftests actually
> > passing. :)
>
> For v4.20 we need to do one of two things.
> 1) Present a plausible case that someone will could care about,
>    we document it in the commit we can perform my earlier partial revert.

If SIGSTOP si_pid can't be used to determine who sent the signal
reliably even before, then I'm guessing we'll never see a real-world
case where this matters.

> 2) Remove the sanity check seccomp_bpf.c
>
> I really just want to ensure we have clear reasoning here.

I'll remove it for now and add a link to this conversation, in case
anyone else goes looking.

-Kees

-- 
Kees Cook
