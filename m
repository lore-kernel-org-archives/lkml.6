Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECD2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A6920868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A6920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeK3IJR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:09:17 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42464 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeK3IJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:09:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so3618347qtq.9;
        Thu, 29 Nov 2018 13:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GBd+z/mwxXYuThLSf+B4xpvms0GbzaZ6e4I+CTFDcDg=;
        b=n3LWW8rLLlj81QOIHIC63u922xtEsPljOKTGVNtyCO6qhO8Sz47jHmfmedzUGB3LX3
         ayZHV0efkZe94ImTgX4b6Z6EzmyAeizbdhzcApJSprb+mW5T4bP0k8YdkFKeNCLGL8BP
         OzRJswZkd1J2SMf/p91KJpaYMh8BCLaPOfLdQ3coZ8dFjYBoV+btPmiVJYMcYugj+XtB
         fanL+ndcdOuWKfZbVjpXgBXm6EKthJKM8mocmX+/rH0ODSbG+byjhv5GLA8AraXi3lqZ
         E//i80s2BvtlSS48OxtLshFzK/UvWm/mczfJHz4GdIzpO4zsgMOYcy+i0QsFqtJWbFVQ
         3M5w==
X-Gm-Message-State: AA+aEWa3/zYeS4viF0oSt/I/uHPM3vRv4BYo0rwDC0NIv70rOy5jePrt
        zxFC8z2Y8UQheNKv3+Snq1Wto2fauI6Lm3Ho6eM=
X-Google-Smtp-Source: AFSGD/VEcAsb8VMvtTvzAud5UEWOuPcmYbwPQE+ZhJvyvmEf4JE07FbJ8h3oVrkcyhWytKqV1+baplZQlR6kc2AQSUY=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr3021100qte.212.1543525352322;
 Thu, 29 Nov 2018 13:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
In-Reply-To: <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Nov 2018 22:02:13 +0100
Message-ID: <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     christian@brauner.io, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:14 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > On Nov 29, 2018, at 11:55 AM, Christian Brauner <christian@brauner.io> wrote:
> >> On Thu, Nov 29, 2018 at 11:22:58AM -0800, Andy Lutomirski wrote:
> >>> On Thu, Nov 29, 2018 at 11:17 AM Christian Brauner <christian@brauner.io> wrote:
> >>>> On November 30, 2018 5:54:18 AM GMT+13:00, Andy Lutomirski <luto@amacapital.net> wrote:
> >>
> >> The #1 fix would add a copy_siginfo_from_user64() or similar.
> >
> > Thanks very much! That all helped a bunch already! I'll try to go the
> > copy_siginfo_from_user64() way first and see if I can make this work. If
> > we do this I would however only want to use it for the new syscall first
> > and not change all other signal syscalls over to it too. I'd rather keep
> > this patchset focussed and small and do such conversions caused by the
> > new approach later. Does that sound reasonable?
>
> Absolutely. I don’t think we can change old syscalls — the ABI is set in stone.
> But for new syscalls, I think the always-64-bit behavior makes sense.

It looks like we already have a 'struct signalfd_siginfo' that is defined in a
sane architecture-independent way, so I'd suggest we use that.

We may then also want to make sure that any system call that takes a
siginfo has a replacement that takes a signalfd_siginfo, and that this
replacement can be used to implement the old version purely in
user space.

Is the current procfd_signal() proposal (under whichever name) sufficient
to correctly implement both sys_rt_sigqueueinfo() and sys_rt_tgsigqueueinfo()?
Can we implement sys_rt_sigtimedwait() based on signalfd()?
If yes, that would leave waitid(), which already needs a replacement
for y2038, and that should then also return a signalfd_siginfo.
My current preference for waitid() would be to do a version that
closely resembles the current interface, but takes a signalfd_siginfo
and a __kernel_timespec based rusage replacement (possibly
two of them to let us map wait6), but does not operate on procfd or
take a signal mask. That would require yet another syscall, but I
don't think I can do that before we want to have the set of y2038
safe syscalls.

       Arnd
