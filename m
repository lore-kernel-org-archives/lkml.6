Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698CAC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E55E20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="AaQk3y+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E55E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeLAU34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 15:29:56 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54281 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeLAU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 15:29:56 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so2260354ita.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 01:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=mrSp3pTBiD1qDYQHP+IvL1wIPPJwoVZAeIrhY8kUNWc=;
        b=AaQk3y+GiiOhLYx6lcXw9cFeX793DITmD+IZBkiPwaPN1i1hOzRlPHtOBThFU/EyZZ
         eKAuhMWS0on0/60npzQIx9z5AgWmLa8rF3jrioFbdKrlm2SfHxKMdngT0kyox0hcT4qK
         zGAVzNCpH4v7F/QFs/rlbhdblIsTyNzyhNm50Wf3fzF91IZcGkOR4oAOKwPnuug/lhvQ
         ecvAklgbeKdhL1P+U+WdUjkl84DmLRzcRiTDAoQP+AqH3xXSvKza3RDF+t4JoS7CJkgI
         BqhTV849EGIZX6xtsmSp/Pr71bTa0Ssi/iLuqHXt22ut57cV5csNL3Cg6wloyi7TpY5Z
         70cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=mrSp3pTBiD1qDYQHP+IvL1wIPPJwoVZAeIrhY8kUNWc=;
        b=mQ3na7S2loqR5dF7jfrw34juNk/H60OILn3h3rxntoMJOa8rt+skUvwEfci8x3oNtD
         g3HaRqYs5HW6hidiolJa1VwMny4WDGJJoXoVC5X/+lMd3n6Q5qhMcnnELdgJyH34BdiJ
         tyeM3GIaR9nAfFtBOsjHI+16DciOgtS4SO70ykx1MVwhWoElqJWdc3/BlvUvIHl2wusa
         Ez6DaTLAfrOESxxlf7iMwhh2umAguAacdNPTuSH7+Dnh/C/VVlTCvVXRaYIzo7wMb7+a
         a0v8EcnSFuVzVbIQGRoNdQhLh/u+F6Zyl6FmNnXdzaoCjhmVDQf0QzbE/mAuI4OdU/tc
         Mn+Q==
X-Gm-Message-State: AA+aEWZEu/xVZnOQAOQIsetEpyIMBHaJ11UO5FZ6ZytDN2kfECpTCHEy
        RqruBsAwKXHdixzhvZsQoz/+Mw==
X-Google-Smtp-Source: AFSGD/UK9A+UlifJf42SrkkWK471JrRIGTzSmd3V84HnZDuzQAQDAvSXWtMS9N6yTyBlp+Olgu13WA==
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr8106942jah.130.1543655871345;
        Sat, 01 Dec 2018 01:17:51 -0800 (PST)
Received: from [26.67.160.54] ([172.56.13.56])
        by smtp.gmail.com with ESMTPSA id 14sm1776731itm.3.2018.12.01.01.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 01:17:50 -0800 (PST)
Date:   Sat, 01 Dec 2018 22:17:40 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAK8P3a1OX1Hb17=NbTYqZxgEM-sk5-dh_VeKa0bXJpq=k=KxHA@mail.gmail.com>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com> <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io> <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com> <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net> <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com> <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io> <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com> <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com> <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com> <CALCETrWcJCjNGEqgq57Bm8O3qWkfEwau2SiXAv+SNYvNmXnBCA@mail.gmail.com> <CAK8P3a1OX1Hb17=NbTYqZxgEM-sk5-dh_VeKa0bXJpq=k=KxHA@mail.gmail.com>
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
Message-ID: <9D19D003-EA65-4D05-A3A6-10EA8F506DFF@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 1, 2018 9:51:18 PM GMT+13:00, Arnd Bergmann <arnd@arndb=2Ede> w=
rote:
>On Sat, Dec 1, 2018 at 12:54 AM Andy Lutomirski <luto@kernel=2Eorg>
>wrote:
>> On Fri, Nov 30, 2018 at 2:10 PM Arnd Bergmann <arnd@arndb=2Ede> wrote:
>> > On Fri, Nov 30, 2018 at 5:36 PM Andy Lutomirski <luto@kernel=2Eorg>
>wrote:
>> > > On Fri, Nov 30, 2018 at 3:41 AM Arnd Bergmann <arnd@arndb=2Ede>
>wrote:
>> > > > siginfo_t as it is now still has a number of other downsides,
>and Andy in
>> > > > particular didn't like the idea of having three new variants on
>x86
>> > > > (depending on how you count)=2E His alternative suggestion of
>having
>> > > > a single syscall entry point that takes a 'signfo_t __user *'
>but interprets
>> > > > it as compat_siginfo depending on
>in_compat_syscall()/in_x32_syscall()
>> > > > should work correctly, but feels wrong to me, or at least
>inconsistent
>> > > > with how we do this elsewhere=2E
>
>> > The '548 | 0x40000000' part seems to be the only sensible
>> > way to handle x32 here=2E What exactly would you propose to
>> > avoid defining the other entry points?
>>
>> I would propose that it should be 335 | 0x40000000=2E  I can't see any
>> reasonable way to teach the kernel to reject 335 | 0x40000000 that
>> wouldn't work just as well to accept it and make it do the right
>> thing=2E  Currently we accept it and do the *wrong* thing, which is no
>> good=2E
>>
>> > and we have to
>> > add more complexity to the copy_siginfo_from_user()
>> > implementation to duplicate the hack that exists in
>> > copy_siginfo_from_user32()=2E
>>
>> What hack are you referring to here?
>
>I mean this part:
>
>#ifdef CONFIG_COMPAT
>int copy_siginfo_to_user32(struct compat_siginfo __user *to,
>                           const struct kernel_siginfo *from)
>#if defined(CONFIG_X86_X32_ABI) || defined(CONFIG_IA32_EMULATION)
>{
>        return __copy_siginfo_to_user32(to, from, in_x32_syscall());
>}
>int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
>                       const struct kernel_siginfo *from, bool x32_ABI)
>#endif
>{
>=2E=2E=2E
>        case SIL_CHLD:
>                new=2Esi_pid    =3D from->si_pid;
>                new=2Esi_uid    =3D from->si_uid;
>                new=2Esi_status =3D from->si_status;
>#ifdef CONFIG_X86_X32_ABI
>                if (x32_ABI) {
>                    new=2E_sifields=2E_sigchld_x32=2E_utime =3D from->si_=
utime;
>                    new=2E_sifields=2E_sigchld_x32=2E_stime =3D from->si_=
stime;
>                } else
>#endif
>                {
>                        new=2Esi_utime =3D from->si_utime;
>                        new=2Esi_stime =3D from->si_stime;
>                }
>                break;
>=2E=2E=2E
>}
>#endif
>
>If we have a '548 | 0x40000000' entry pointing to
>__x32_compat_sys_procfd_kill, then that will do the right
>thing=2E If you instead try to have x32 call into the native
>sys_procfd_kill, then copy_siginfo_to_user() will also have
>to know about x32, effectively duplicating that mess above,
>unless you want to also change all users of
>copy_siginfo_to_user32() to use copy_siginfo_to_user()
>and handle all cases in one function=2E

I've been looking into having siginfo64_t
with the new copy_siginfo_to_user64()
function=2E It looks like a pretty intricate=20
task=2E Are we sure that we want to go
down this road? I'm not sure that it'll be
worth it=2E Especially since we force yet
another signal struct on user space=2E

