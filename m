Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C46EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4CE20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Jtv2avI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4CE20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeLAJhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:37:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38142 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbeLAJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:37:45 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so5822547ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=OfZv7fTNKoh4kn2f19oRkFkSqlp3rDFeXtQG1XLB1JM=;
        b=Jtv2avI3o8vggbJKg/Ab4bl/szqkxKIHlozO+c1xUhhtpKbUFjFwXiV/rYJtJoz8vh
         9981DIWaRHvX2sHe3Lp0/p7TlVC33tBMdyhUWfbGQ4hTcD7QL74PxghEpVme99wPFCU/
         +S1pGodZ7Aa6+7kUEYuYVdf5/ZcAgfF4Y5Cxl9rMhwMzwwxj4HIHORvb1UnrGOUGBrHV
         YYg2rqUUsKSJ4LIoMSXKnCofyCmqTM0OwusJhUvbMWunivuZHB1tdsM+y3AmvlVrXhGP
         StqTC+1HwCgVFJo5tsiuBQyD90ZiVWx4sZMvUiCf+0QnZGFgrZYmJTUEIB6TMvSp0qHt
         SwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=OfZv7fTNKoh4kn2f19oRkFkSqlp3rDFeXtQG1XLB1JM=;
        b=EWJZtU39CB5YMIRfVfJyWTxNBEeaWr0YSR4DXPXuT+ddX6g8UQExV9tWOse0rAAG/1
         avS2DMQ91dJmBzbBgHRJ4R7Et0NtLbi7bZe6tB0UdxiNJb/ghlBs1fgQ3VnEatdvsGvg
         JsoTSTev5Bw/vIfPRUbR1v46nafS8t/6PGcJPURm1k5rAsbcjSk2ApzuenxGkxokaJnA
         HPSa0HPqLnMbxUITASdT6lJ4KL9iC0rbBqe+i60rgP9Ars7eROU7OO7XYsIHaS1zP8cM
         eb/39RO8FfvpO1gohb1WEZg4dxha+AGDTibvPeXX+htFoUytfLnkinBaU6dV3qAdSxaL
         jtLg==
X-Gm-Message-State: AA+aEWaUhL70Dg4epZpWkMSl1E+u2d50yKzR+VwZF95YI4Ca854E/YXb
        HdF7LbNTOkqBp57T6KPMkTFwsQ==
X-Google-Smtp-Source: AFSGD/VqfC3Hu3Vm3a/FvzXQcvUN0O0tXIURzKY5poVqUGV+q9+WHVt6Rj8INE7M/lk0oNG6pbTuoQ==
X-Received: by 2002:a6b:930b:: with SMTP id v11mr6133166iod.148.1543616816994;
        Fri, 30 Nov 2018 14:26:56 -0800 (PST)
Received: from [26.67.58.27] ([172.56.12.18])
        by smtp.gmail.com with ESMTPSA id 134sm252990itl.25.2018.11.30.14.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 14:26:56 -0800 (PST)
Date:   Sat, 01 Dec 2018 11:26:41 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com> <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io> <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com> <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net> <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com> <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io> <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com> <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com> <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>
CC:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
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
From:   Christian Brauner <christian@brauner.io>
Message-ID: <EC87B1BE-BDD0-414F-85F8-806C3CC4DD07@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 1, 2018 11:09:58 AM GMT+13:00, Arnd Bergmann <arnd@arndb=2Ede> =
wrote:
>On Fri, Nov 30, 2018 at 5:36 PM Andy Lutomirski <luto@kernel=2Eorg>
>wrote:
>>
>> On Fri, Nov 30, 2018 at 3:41 AM Arnd Bergmann <arnd@arndb=2Ede> wrote:
>> > siginfo_t as it is now still has a number of other downsides, and
>Andy in
>> > particular didn't like the idea of having three new variants on x86
>> > (depending on how you count)=2E His alternative suggestion of having
>> > a single syscall entry point that takes a 'signfo_t __user *' but
>interprets
>> > it as compat_siginfo depending on
>in_compat_syscall()/in_x32_syscall()
>> > should work correctly, but feels wrong to me, or at least
>inconsistent
>> > with how we do this elsewhere=2E
>>
>> If everyone else is okay with it, I can get on board with three
>> variants on x86=2E  What I can't get on board with is *five* variants
>on
>> x86, which would be:
>>
>> procfd_signal via int80 / the 32-bit vDSO: the ia32 structure
>>
>> syscall64 with nr =3D=3D 335 (presumably): 64-bit
>
>These seem unavoidable
>
>> syscall64 with nr =3D=3D 548 | 0x40000000: x32
>>
>> syscall64 with nr =3D=3D 548: 64-bit entry but in_compat_syscall() =3D=
=3D
>> true, behavior is arbitrary
>>
>> syscall64 with nr =3D=3D 335 | 0x40000000: x32 entry, but
>> in_compat_syscall() =3D=3D false, behavior is arbitrary
>
>Am I misreading the code? The way I understand it, setting the
>0x40000000 bit means that both in_compat_syscall() and
>in_x32_syscall become() true, based on
>
>static inline bool in_x32_syscall(void)
>{
>#ifdef CONFIG_X86_X32_ABI
>        if (task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT)
>                return true;
>#endif
>        return false;
>}
>
>The '548 | 0x40000000' part seems to be the only sensible
>way to handle x32 here=2E What exactly would you propose to
>avoid defining the other entry points?
>
>> This mess isn't really Christian's fault -- it's been there for a
>> while, but it's awful and I don't think we want to perpetuate it=2E
>
>I'm not convinced that not assigning an x32 syscall number
>improves the situation, it just means that we now have one
>syscall that behaves completely differently from all others,
>in that the x32 version requires being called through a
>SYSCALL_DEFINE() entry point rather than a
>COMPAT_SYSCALL_DEFINE() one, and we have to
>add more complexity to the copy_siginfo_from_user()
>implementation to duplicate the hack that exists in
>copy_siginfo_from_user32()=2E
>
>Of course, the nicest option would be to completely remove
>x32 so we can stop worrying about it=2E

One humble point I would like to make is that what I care about most is a =
sensible way forward without having to redo essential parts of how syscalls=
 work=2E
I don't want to introduce a sane, small syscall that ends up breaking all =
over the place because we decided to fix past mistakes that technically hav=
e nothing to do with the patch itself=2E
However, I do sympathize and understand these concerns=2E
