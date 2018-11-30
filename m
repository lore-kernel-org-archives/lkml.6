Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B29C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3448820660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="cQMhrMck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3448820660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeLAJIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:08:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43410 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeLAJIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:08:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so3419142plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 13:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=x4RrUArMCEl7I5ibRBgEnMh9EHvRGirKVKGxsqMZpbM=;
        b=cQMhrMckjwfU3f4S/XXLmmZAZBasHrSceerLLrOWgXrWuD3CyL8rGYlY07mSnJaoRv
         UX9PN4pYZWd6dqIqIYJnb1/N3r/lDWQ3uRqfLeR4649sL1Vh0D1n/Xt2t7Q6d6oG/dJU
         q19PllM0qEnHvOGvhstQyMiDPZP0wnQg7wezDhBjCQv6Ri3GOt7/d/TqWmkvAZ/e/CgX
         q4k65o9zPSfJDqA7u+zv8R4XSEUdudnixO1jyv8o6wLRvicFfstWJbGGXPaplusHRbKQ
         NQfqGur7wUsJlCL2v1CWnyIdqwd2SaXDXb9DgMxV3pm1zZ9ca1XS6LfAxQY+5RKCGNe6
         0viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=x4RrUArMCEl7I5ibRBgEnMh9EHvRGirKVKGxsqMZpbM=;
        b=i3m2LYnSQwNPz72BVO+QurESgwz2DbkGUrMnZrEFuOPRy/jcx4mbPW6+3hM1cWS9VI
         93+l7qKj0OtB5MqptplDWzGTMz5Bc2juMcDhv6nraVdjMvAmYuSXEHeuEelKra/bMLi4
         1AT6apuDfeMn5leZi12wHtOdzOekuMmpbteL7nVSp4Y7N23/in2pZheYM8cUQMsvHKRZ
         U4qO2ZvzsoiqYBSiv4CKdyW7wJlg3pDIYckWRpVaCL8EUQMSe/2RpgfjasIDq6gtrs5m
         Ry8MkBNXtw7x/3Yob1uYZ4OM1GQiiYAs2ovfpQvjd6npSNCiBD8SDjpuV9d2FjWt0yPV
         vYQQ==
X-Gm-Message-State: AA+aEWbD6QqrnZpfXMLc7wLszkQrSIelHwFSCymXw3wSl85l8uD9zz1D
        QV9ULRpyBr5pKTYejqloeF/Xpg==
X-Google-Smtp-Source: AFSGD/UKKvkPgROgkFvG8pkQdez6NuNUEu84jyK7prx2u/E1oxt/SU65aSAEeQVMazKOOOnMBick9w==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr7318575pls.90.1543615044383;
        Fri, 30 Nov 2018 13:57:24 -0800 (PST)
Received: from [192.168.1.3] ([210.246.63.204])
        by smtp.gmail.com with ESMTPSA id r130sm10571382pfr.48.2018.11.30.13.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 13:57:23 -0800 (PST)
Date:   Sat, 01 Dec 2018 10:57:11 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com> <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io> <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com> <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net> <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com> <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io> <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com> <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <DCA81C46-30A4-4B6A-AA1F-9DCC102968C9@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 1, 2018 5:35:45 AM GMT+13:00, Andy Lutomirski <luto@kernel=2Eor=
g> wrote:
>On Fri, Nov 30, 2018 at 3:41 AM Arnd Bergmann <arnd@arndb=2Ede> wrote:
>> siginfo_t as it is now still has a number of other downsides, and
>Andy in
>> particular didn't like the idea of having three new variants on x86
>> (depending on how you count)=2E His alternative suggestion of having
>> a single syscall entry point that takes a 'signfo_t __user *' but
>interprets
>> it as compat_siginfo depending on
>in_compat_syscall()/in_x32_syscall()
>> should work correctly, but feels wrong to me, or at least
>inconsistent
>> with how we do this elsewhere=2E
>
>If everyone else is okay with it, I can get on board with three
>variants on x86=2E  What I can't get on board with is *five* variants on

Thanks Andy, that helps a lot=2E
I'm okay with it=2E Does this require any additional changes to how the sy=
scall
is currently hooked up?

>x86, which would be:
>
>procfd_signal via int80 / the 32-bit vDSO: the ia32 structure
>
>syscall64 with nr =3D=3D 335 (presumably): 64-bit
>
>syscall64 with nr =3D=3D 548 | 0x40000000: x32
>
>syscall64 with nr =3D=3D 548: 64-bit entry but in_compat_syscall() =3D=3D
>true, behavior is arbitrary
>
>syscall64 with nr =3D=3D 335 | 0x40000000: x32 entry, but
>in_compat_syscall() =3D=3D false, behavior is arbitrary
>
>This mess isn't really Christian's fault -- it's been there for a
>while, but it's awful and I don't think we want to perpetuate it=2E
>
>Obviously, I'd prefer a variant where the structure that's passed in
>is always the same=2E
>
>BTW, do we consider siginfo_t to be extensible?  If so, and if we pass

I would prefer if we could consider it extensible=2E
If so I would prefer if we could pass in a size argument=2E

>in a pointer, presumably we should pass a length as well=2E

