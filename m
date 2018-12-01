Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07217C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31EF20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XT81wwMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31EF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeLAMcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:32:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37079 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeLAMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:32:02 -0500
Received: by mail-io1-f65.google.com with SMTP id f14so581227iol.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 17:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=scHL1AO23eV3cOMIfNsYXeoYriec7TVDVgXopqvkICk=;
        b=XT81wwMmm841FMp5UDixE4o3A/6pxCFEPPBs0fec52yBBQugYvNpUPBkyyc1p2fhnf
         Q1KjAzKaNm/ziMsRNwQ64q3tz+0O7hO6uef475DBGuf3vQ4h7epp9qQVQWeX0Eepdh7x
         5TTs9RZ2Su5tDsScwwPIaX0pZlBCASGVcxzjXSin6MqzaU+AOEfchSir3snBPqIhcKO/
         NXvyXO77BSUuUKytTnnb1KjdaHSY4JVAfibTOrMK+y53ISvbu/C9vUPvceojYO4wIQMr
         DF8lXaUWA56LDgRE8Uc2h1b+8mT/nrkVaAQCDLjucKwDabynip/69EGkxU9mTEG5obmb
         F7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=scHL1AO23eV3cOMIfNsYXeoYriec7TVDVgXopqvkICk=;
        b=RVBRzcdzedmMT5EgjdXgdtfDmcYIIiPb2XWg9a2ywpuxEdHcuPQzL/5TKBJhQXLKwe
         he0k433TAVIk1ZRKzQd14CilQakDR0A83FPEjqu9dKSFFNEdBwwAFsCys5k/kf5aKnfs
         RaI5gciIhXKkn5ott6YzcaqJRnWOQi81pKcS7s88BPNzRbujgs7nvNDwFIBLATiRINI/
         d0wpvrDrrQAU4U01UbQUq7YmAip3PyhBv3e/LVNX5MikStkaCMaW51VZGMoFbyAbvrb3
         vfm7EgbFFp/9qUJ7+9DJN5aKzGB6oLG3znUUXiU9QgBem30Oukv6RIFfZMaut0tIDJQ+
         bNpg==
X-Gm-Message-State: AA+aEWax5ns4OazYcSH/013p9X1//3Q5mXouBhUBbcz3obi3n0u8cueR
        tXmiJegjw7fXLApcKdcOrW5OKA==
X-Google-Smtp-Source: AFSGD/VvEyIYrAcw8ubhY3KRvSkESmAC9W0j3I/wDc48sHbTIs7UJamcjWUdWSYsrouMpuO38e+3CA==
X-Received: by 2002:a5d:9855:: with SMTP id p21mr6723429ios.64.1543627246988;
        Fri, 30 Nov 2018 17:20:46 -0800 (PST)
Received: from [26.67.58.27] ([172.56.12.18])
        by smtp.gmail.com with ESMTPSA id a10sm427617itc.3.2018.11.30.17.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 17:20:45 -0800 (PST)
Date:   Sat, 01 Dec 2018 14:20:37 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrWcUQC_aeHRwVF0yr8GATndRU9277rQQ+caOcR1uJ1W9g@mail.gmail.com>
References: <20181120105124.14733-1-christian@brauner.io> <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io> <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com> <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net> <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com> <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io> <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com> <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com> <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com> <EC87B1BE-BDD0-414F-85F8-806C3CC4DD07@brauner.io> <CAKOZuesEPFnkd7YGbu82TRQwhR=KPwNW8GpYTw=719_xmJx9FA@mail.gmail.com> <CAK8P3a2x3nQKKvLBSH8G9R6w+sv=09y3h7gWdFYUMNAsB8aj6g@mail.gmail.com> <7C5B4CBD-6364-4DCE-9EFD-3657C67DACEB@brauner.io> <CALCETrWcUQC_aeHRwVF0yr8GATndRU9277rQQ+caOcR1uJ1W9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Andy Lutomirski <luto@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Colascione <dancol@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <F9EBD99D-0339-4AD6-B89B-84F164454336@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 1, 2018 12:46:22 PM GMT+13:00, Andy Lutomirski <luto@kernel=2Eo=
rg> wrote:
>On Fri, Nov 30, 2018 at 3:40 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>>
>> On December 1, 2018 12:12:53 PM GMT+13:00, Arnd Bergmann
><arnd@arndb=2Ede> wrote:
>> >On Sat, Dec 1, 2018 at 12:05 AM Daniel Colascione
><dancol@google=2Ecom>
>> >wrote:
>> >> On Fri, Nov 30, 2018 at 2:26 PM Christian Brauner
>> ><christian@brauner=2Eio> wrote:
>> >> > On December 1, 2018 11:09:58 AM GMT+13:00, Arnd Bergmann
>> ><arnd@arndb=2Ede> wrote:
>> >> >
>> >> > One humble point I would like to make is that what I care about
>> >most is a sensible way forward without having to redo essential
>parts
>> >of how syscalls work=2E
>> >> > I don't want to introduce a sane, small syscall that ends up
>> >breaking all over the place because we decided to fix past mistakes
>> >that technically have nothing to do with the patch itself=2E
>> >> > However, I do sympathize and understand these concerns=2E
>> >>
>> >> IMHO, it's fine to just replicate all the splits we have for the
>> >> existing signal system calls=2E It's ugly, but once it's done, it'll
>be
>> >> done for a long time=2E I can't see a need to add even more signal
>> >> system calls after this one=2E
>> >
>> >We definitely need waitid_time64() and rt_sigtimedwait_time64()
>> >in the very near future=2E
>>
>> Right, I remember you pointing this out in a prior mail=2E
>> Thanks for working on this for such a long time now, Arnd!
>> Can we agree to move on with the procfd syscall given the current
>constraints?
>> I just don't want to see the syscall being
>> blocked by a generic problem whose
>> ultimate solution is to get rid of weird
>> architectural constraints=2E
>
>Creating and using a copy_siginfo_from_user64() function would work
>for everyone, no?

Meaning, no compat syscalls, introduce=20
new struct siginfo64_t and the copy=20
function you named above?

